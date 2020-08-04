Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA0E23C119
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 22:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgHDU6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 16:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbgHDU6s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:58:48 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCEFF2086A;
        Tue,  4 Aug 2020 20:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596574728;
        bh=dtol9Ums/BnhF/0mrqyXgMMO0Dg0T0IcgMhAWs7Cpc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HOjBDJkp94PpyHMCmrl7tSHNej/Cr+XBZUXcsfPLqD5Ny/cMs7p+4+dsx4mOwaX4x
         oMnMOtKJ/OExtbF+iF2OTWDctUS5Izc4qRGgB1tG/ZvARbF45Ed8eQwLNT1jwzmXR5
         6CLfVzF54c5nIqm3rrD/iqnAkV0Dlu6vQHahVM4U=
Date:   Tue, 4 Aug 2020 13:58:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Calin Juravle <calin@google.com>, kernel-team@android.com,
        yanfei.xu@windriver.com,
        syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Subject: Re: [PATCH] Userfaultfd: Avoid double free of userfault_ctx and
 remove O_CLOEXEC
Message-ID: <20200804205846.GB1992048@gmail.com>
References: <20200804203155.2181099-1-lokeshgidra@google.com>
 <20200804204543.GA1992048@gmail.com>
 <CA+EESO6XGpiTLnxPraZqBigY7mh6G2jkHa2PKXaHXpzdrZd4wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EESO6XGpiTLnxPraZqBigY7mh6G2jkHa2PKXaHXpzdrZd4wA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 04, 2020 at 01:49:30PM -0700, Lokesh Gidra wrote:
> On Tue, Aug 4, 2020 at 1:45 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Tue, Aug 04, 2020 at 01:31:55PM -0700, Lokesh Gidra wrote:
> > > when get_unused_fd_flags returns error, ctx will be freed by
> > > userfaultfd's release function, which is indirectly called by fput().
> > > Also, if anon_inode_getfile_secure() returns an error, then
> > > userfaultfd_ctx_put() is called, which calls mmdrop() and frees ctx.
> > >
> > > Also, the O_CLOEXEC was inadvertently added to the call to
> > > get_unused_fd_flags() [1].
> > >
> > > Adding Al Viro's suggested-by, based on [2].
> > >
> > > [1] https://lore.kernel.org/lkml/1f69c0ab-5791-974f-8bc0-3997ab1d61ea@dancol.org/
> > > [2] https://lore.kernel.org/lkml/20200719165746.GJ2786714@ZenIV.linux.org.uk/
> > >
> > > Fixes: d08ac70b1e0d (Wire UFFD up to SELinux)
> > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> >
> > What branch does this patch apply to?  Neither mainline nor linux-next works.
> >
> On James Morris' tree (secure_uffd_v5.9 branch).
> 

For those of us not "in the know", that apparently means branch secure_uffd_v5.9
of https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git

Perhaps it would make more sense to resend your original patch series with this
fix folded in?

> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index ae859161908f..e15eb8fdc083 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2042,24 +2042,18 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  		O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
>  		NULL);
>  	if (IS_ERR(file)) {
> -		fd = PTR_ERR(file);
> -		goto out;
> +		userfaultfd_ctx_put(ctx);
> +		return PTR_ERR(file);
>  	}
>  
> -	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
> +	fd = get_unused_fd_flags(O_RDONLY);
>  	if (fd < 0) {
>  		fput(file);
> -		goto out;
> +		return fd;
>  	}
>  
>  	ctx->owner = file_inode(file);
>  	fd_install(fd, file);
> -
> -out:
> -	if (fd < 0) {
> -		mmdrop(ctx->mm);
> -		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
> -	}
>  	return fd;

This introduces the opposite bug: now it's hardcoded to *not* use O_CLOEXEC,
instead of using the flag the user passed in the flags argument to the syscall.

- Eric
