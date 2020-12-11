Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF95B2D6E29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 03:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391826AbgLKCgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 21:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391165AbgLKCgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 21:36:40 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACABC0613D3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 18:36:00 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knYHj-000SvK-DE; Fri, 11 Dec 2020 02:35:55 +0000
Date:   Fri, 11 Dec 2020 02:35:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] fs: add support for LOOKUP_NONBLOCK
Message-ID: <20201211023555.GV3579531@ZenIV.linux.org.uk>
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210200114.525026-2-axboe@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 01:01:13PM -0700, Jens Axboe wrote:
> io_uring always punts opens to async context, since there's no control
> over whether the lookup blocks or not. Add LOOKUP_NONBLOCK to support
> just doing the fast RCU based lookups, which we know will not block. If
> we can do a cached path resolution of the filename, then we don't have
> to always punt lookups for a worker.
> 
> During path resolution, we always do LOOKUP_RCU first. If that fails and
> we terminate LOOKUP_RCU, then fail a LOOKUP_NONBLOCK attempt as well.

In effect you are adding a mode where
	* unlazy would fail, except when done from complete_walk()
	* ->d_revalidate() wouldn't be attempted at all (not even with LOOKUP_RCU)
	* ... but ->get_link() in RCU mode would
	* ... and so would everything done after complete_walk() in
do_open(), very much including the joys like mnt_want_write() (i.e. waiting for
frozen fs to thaw), handling O_TRUNC, calling ->open() itself...

So this "not punting lookups for a worker" looks fishy as hell - if you care
about blocking operations, you haven't really won anything.

And why exactly is the RCU case of ->d_revalidate() worth buggering off (it
really can't block - it's called under rcu_read_lock() and it does *not*
drop it)?

_IF_ for some theoretical exercise you want to do "lookup without dropping
out of RCU", just add a flag that has unlazy_walk() fail.  With -ECHILD.
Strip it away in complete_walk() and have path_init() with that flag
and without LOOKUP_RCU fail with -EAGAIN.  All there is to it.

It still leaves you with fuckloads of blocking operations (and that's
"blocking" with "until admin thaws the damn filesystem several hours
down the road") after complete_walk(), though.
