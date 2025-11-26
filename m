Return-Path: <linux-fsdevel+bounces-69889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01010C89FCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 14:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11CF3A6246
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76283328B42;
	Wed, 26 Nov 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK2k/IgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A032862E
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764163261; cv=none; b=DDJwK/AEsHTr7YCzRjD94M9gfvtWa23nn2OL3MhLBhpnGSTQ9jS64qy9h+eB6C5cgDi+4G/SUOmNAwGAoVQcgQevAsbUyhEAQNRFw33d9xNq6WS4e+jSzXaazmNrrFYXPOiifaO1TEoYWD6/uKroYqyaq+05Br9QeK8ovGu+9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764163261; c=relaxed/simple;
	bh=4jlAAB5XdbUpOwW0EcuDgRZEC07kaVgp/5OwwYZgG0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WriyJF+naFmHastlGu5y44iSKKrteQgBQDK6WqUKlB7pBjqljBgb50pQEh5hT69jnWXoSces0HRNQ9gW33U4jcV45hQblC7ik2OhXab4ki4+lX9aV5fJ3LoMjE9WGCl0ooquxM5f8K2YzUc84Ibxz9Iab9XF6NiDfwCILyf+Ayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK2k/IgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46990C116C6;
	Wed, 26 Nov 2025 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764163261;
	bh=4jlAAB5XdbUpOwW0EcuDgRZEC07kaVgp/5OwwYZgG0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rK2k/IgR+bqF29CkA5jdeypdGWtZj0L7pMyuuoSacWdI4Z7cbsJE6ISh5S64JcnBh
	 FsSRkWNXjYeC5hfPDkMsVHBIzwStrLUUn99cC2UZJDPZZ/lCLLvY4dMSKYln7ug+IH
	 Rr5HeFY6YssEaoaQDqQQhV2LCLbiVSdBAe9/5NosFVjOFZ5FLoQupqgbR84yPsBSUp
	 aQFEq6BsktJ/a1ICRVsSG/1ZJOIXKaZFdbRk6qsc0Tc9Ndtb4HTtuW8feEMRZ9+hh0
	 98Nc1m6SxwOscMWkrDuq+mNNmpmoJz2+MUys0EkJpyrlW27TBr2Wr+UqKheaYaNbTT
	 V99zguMm7r0Qw==
Date: Wed, 26 Nov 2025 14:20:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 22/47] ipc: convert do_mq_open() to FD_PREPARE()
Message-ID: <20251126-reagenzglas-gecko-4bb05b983db2@brauner>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-22-b6efa1706cfd@kernel.org>
 <c41de645-8234-465f-a3be-f0385e3a163c@sirena.org.uk>
 <CAHk-=wg+So1GE7=t94ejj4kBrportn2FGzOrqETO5PHVLAzh0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+So1GE7=t94ejj4kBrportn2FGzOrqETO5PHVLAzh0A@mail.gmail.com>

On Tue, Nov 25, 2025 at 04:05:20PM -0800, Linus Torvalds wrote:
> On Tue, 25 Nov 2025 at 14:30, Mark Brown <broonie@kernel.org> wrote:
> >
> >
> > It's not clear to me if this is an overly
> > sensitive test or an actual issue.
> 
> I think these two cases are both "error handling done in a different
> order", where the test expected to get EMFILE (or something like
> that), but now the file open is done before, so it actually gets
> EACCES.
> 
> I'm not sure it really matters, but the old code did seem to do the
> file prepare first, and the
> 
>         path.dentry = lookup_noperm(&QSTR(name->name), root);
> 
> afterwards.
> 
> And while I don't think the order *really* matters, I do think the old
> order was better.
> 
> And I think it can be done that way.
> 
> So Christian, I think the proper solution is to not do that
> "dentry_open()" in the FD_ADD() after doing all the other prep-work:
> 
>         ret = FD_ADD(O_CLOEXEC, dentry_open(&path, oflag, current_cred()));
> 
> but instead make a new proper "handle_mq_open()" helper that does the whole
> 
>         path.dentry = lookup_noperm(&QSTR(name->name), root);
> ...
>         ret = prepare_open(path.dentry, oflag, ro, mode, name, attr);
> ...
>         return dentry_open(&path, oflag, current_cred());
> 
> dance, and then do
> 
>         ret = FD_ADD(O_CLOEXEC, handle_mq_open());
> 
> so that this all is done in the same order as it used to be done.
> 
> Hmm?

Yeah, we sure can do that. Ok, reproduced and then added a fix.

> I think the same thing is true for the other failed test-case.
> 
>              Linus

Added the following which imho looks nicer as well:

commit b52154435037d501e73bf09a644dffede831ed05
Author:     Christian Brauner <brauner@kernel.org>

    ipc: preserve original file opening pattern

    LTP seems to have assertions about what errnos are surfaced in what
    order. I think that's often misguided but we can accomodate this here
    and preserve the original order.

    Fixes: https://lore.kernel.org/c41de645-8234-465f-a3be-f0385e3a163c@sirena.org.uk
    Reported-by: Mark Brown <broonie@kernel.org>
    Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 8b9b53db67a2..d3a588d0dcf6 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -892,14 +892,35 @@ static int prepare_open(struct dentry *dentry, int oflag, int ro,
        return inode_permission(&nop_mnt_idmap, d_inode(dentry), acc);
 }

+static struct file *mqueue_file_open(struct filename *name,
+                                    struct vfsmount *mnt, int oflag, bool ro,
+                                    umode_t mode, struct mq_attr *attr)
+{
+       struct path path __free(path_put) = {};
+       struct dentry *dentry;
+       int ret;
+
+       dentry = lookup_noperm(&QSTR(name->name), mnt->mnt_root);
+       if (IS_ERR(dentry))
+               return ERR_CAST(dentry);
+
+       path.dentry = dentry;
+       path.mnt = mntget(mnt);
+
+       ret = prepare_open(path.dentry, oflag, ro, mode, name, attr);
+       if (ret)
+               return ERR_PTR(ret);
+
+       return dentry_open(&path, oflag, current_cred());
+}
+
 static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
                      struct mq_attr *attr)
 {
+       struct filename *name __free(putname) = NULL;;
        struct vfsmount *mnt = current->nsproxy->ipc_ns->mq_mnt;
        struct dentry *root = mnt->mnt_root;
-       struct filename *name;
-       struct path path;
-       int ret;
+       int fd;
        int ro;

        audit_mq_open(oflag, mode, attr);
@@ -910,23 +931,11 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,

        ro = mnt_want_write(mnt);       /* we'll drop it in any case */
        inode_lock(d_inode(root));
-       path.dentry = lookup_noperm(&QSTR(name->name), root);
-       if (IS_ERR(path.dentry)) {
-               ret = PTR_ERR(path.dentry);
-               goto out_unlock;
-       }
-       path.mnt = mntget(mnt);
-       ret = prepare_open(path.dentry, oflag, ro, mode, name, attr);
-       if (!ret)
-               ret = FD_ADD(O_CLOEXEC, dentry_open(&path, oflag, current_cred()));
-       path_put(&path);
-
-out_unlock:
+       fd = FD_ADD(O_CLOEXEC, mqueue_file_open(name, mnt, oflag, ro, mode, attr));
        inode_unlock(d_inode(root));
        if (!ro)
                mnt_drop_write(mnt);
-       putname(name);
-       return ret;
+       return fd;
 }

 SYSCALL_DEFINE4(mq_open, const char __user *, u_name, int, oflag, umode_t, mode,


