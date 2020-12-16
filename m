Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B42DB93E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 03:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgLPChI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 21:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgLPChI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 21:37:08 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13C5C061793
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 18:36:27 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpMfs-001Z1n-9q; Wed, 16 Dec 2020 02:36:20 +0000
Date:   Wed, 16 Dec 2020 02:36:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
Message-ID: <20201216023620.GH3579531@ZenIV.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20201214191323.173773-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214191323.173773-3-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 14, 2020 at 12:13:22PM -0700, Jens Axboe wrote:
> io_uring always punts opens to async context, since there's no control
> over whether the lookup blocks or not. Add LOOKUP_NONBLOCK to support
> just doing the fast RCU based lookups, which we know will not block. If
> we can do a cached path resolution of the filename, then we don't have
> to always punt lookups for a worker.
> 
> We explicitly disallow O_CREAT | O_TRUNC opens, as those will require
> blocking, and O_TMPFILE as that requires filesystem interactions and
> there's currently no way to pass down an attempt to do nonblocking
> operations there. This basically boils down to whether or not we can
> do the fast path of open or not. If we can't, then return -EAGAIN and
> let the caller retry from an appropriate context that can handle
> blocking.
> 
> During path resolution, we always do LOOKUP_RCU first. If that fails and
> we terminate LOOKUP_RCU, then fail a LOOKUP_NONBLOCK attempt as well.

Ho-hum...  FWIW, I'm tempted to do the same change of calling conventions
for unlazy_child() (try_to_unlazy_child(), true on success).  OTOH, the
call site is right next to removal of unlikely(status == -ECHILD) suggested
a few days ago...

Mind if I take your first commit + that removal of unlikely + change of calling
conventions for unlazy_child() into #work.namei (based at 5.10), so that
the rest of your series got rebased on top of that?

> @@ -3299,7 +3315,16 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
>  {
>  	struct dentry *child;
>  	struct path path;
> -	int error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
> +	int error;
> +
> +	/*
> +	 * We can't guarantee that the fs doesn't block further down, so
> +	 * just disallow nonblock attempts at O_TMPFILE for now.
> +	 */
> +	if (flags & LOOKUP_NONBLOCK)
> +		return -EAGAIN;

Not sure I like it here, TBH...
