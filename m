Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C60481871
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 03:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhL3CTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Dec 2021 21:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhL3CTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Dec 2021 21:19:02 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABA7C061574;
        Wed, 29 Dec 2021 18:19:01 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n2l1w-00FsF9-Ge; Thu, 30 Dec 2021 02:19:00 +0000
Date:   Thu, 30 Dec 2021 02:19:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stefan Roesch <shr@fb.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com, torvalds@linux-foundation.org,
        christian.brauner@ubuntu.com
Subject: Re: [PATCH v10 4/5] io_uring: add fsetxattr and setxattr support
Message-ID: <Yc0XFGDl/Y1Z2Fzc@zeniv-ca.linux.org.uk>
References: <20211229203002.4110839-1-shr@fb.com>
 <20211229203002.4110839-5-shr@fb.com>
 <Yc0Ws8LevbWc+N1q@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yc0Ws8LevbWc+N1q@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 30, 2021 at 02:17:23AM +0000, Al Viro wrote:

> > +static int io_setxattr_prep(struct io_kiocb *req,
> > +			const struct io_uring_sqe *sqe)
> > +{
> > +	struct io_xattr *ix = &req->xattr;
> > +	const char __user *path;
> > +	int ret;
> > +
> > +	ret = __io_setxattr_prep(req, sqe);
> > +	if (ret)
> > +		return ret;
> > +
> > +	path = u64_to_user_ptr(READ_ONCE(sqe->addr3));
> > +
> > +	ix->filename = getname_flags(path, LOOKUP_FOLLOW, NULL);
> > +	if (IS_ERR(ix->filename)) {
> > +		ret = PTR_ERR(ix->filename);
> > +		ix->filename = NULL;
> > +	}
> > +
> > +	return ret;
> > +}
> 
> ... and here you use it and bring the pathname in.  Should the latter
> step fail, you restore ->filename to NULL and return an error.
> 
> Could you explain what kind of magic could allow the caller to tell
> whether ix->ctx.kname needs to be freed on error?  I don't see any way
> that could possibly work...

getxattr side has the same problem, AFAICS...
