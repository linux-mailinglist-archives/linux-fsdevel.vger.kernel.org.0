Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640D17BF136
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 05:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379412AbjJJDGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 23:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379418AbjJJDGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:06:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA56A7;
        Mon,  9 Oct 2023 20:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hF6lxVQ6evFyYtVvJFpE2W9il5nQR1vSVTE2wQU1M+E=; b=sjm4RXMQC9BX+t3FrdU+ybykLB
        hB4kmCwo9bGy1ANj+ODkBbFPUfdViapCTdyJdTGgL298Y9pATXcuwbDEajLydZ8X4otoOSbcYTnyt
        4IVYnAmNmP1HL+fSbQqNlWmT8F3W5+1h2LuwUoARQl10vogTHNUsoF3Scq56Pm7bYCGj+GdYEsnl8
        tTUNP02hJGBoBMyqEslY2QoQ0soESE0PTTqlGs/IFLlY/yu14rU5uOQzQvaSViMAgmr9CCoza0SkP
        3g3tAJI/uyax2g6ICO6jRXRnnD+2dj0AqRek9ed/yXJdREl+8OvDJYSCSDtU8wOMqCkkaNUTdBoL/
        Qdi2MXtw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qq34Z-00HPj4-2Y;
        Tue, 10 Oct 2023 03:06:15 +0000
Date:   Tue, 10 Oct 2023 04:06:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: shave work on failed file open
Message-ID: <20231010030615.GO800259@ZenIV>
References: <20230928-themen-dilettanten-16bf329ab370@brauner>
 <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
 <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
 <20230929-kerzen-fachjargon-ca17177e9eeb@brauner>
 <CAG48ez2cExy+QFHpT01d9yh8jbOLR0V8VsR8_==O_AB2fQ+h4Q@mail.gmail.com>
 <20230929-test-lauf-693fda7ae36b@brauner>
 <CAGudoHHwvOMFqYoBQAoFwD9mMmtq12=EvEGQWeToYT0AMg9V0A@mail.gmail.com>
 <CAGudoHHuQ2PjmX5HG+E6WMeaaOhSNEhdinCssd75dM0P+3ZG8Q@mail.gmail.com>
 <CAHk-=wir8YObRivyUX6cuanNKCJNKvojK0p2Rg_fKyUiHDVs-A@mail.gmail.com>
 <20230930-glitzer-errungenschaft-b86880c177c4@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930-glitzer-errungenschaft-b86880c177c4@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 30, 2023 at 11:04:20AM +0200, Christian Brauner wrote:
> +On newer kernels rcu based file lookup has been switched to rely on
> +SLAB_TYPESAFE_BY_RCU instead of call_rcu(). It isn't sufficient anymore to just
> +acquire a reference to the file in question under rcu using
> +atomic_long_inc_not_zero() since the file might have already been recycled and
> +someone else might have bumped the reference. In other words, the caller might
> +see reference count bumps from newer users. For this is reason it is necessary
> +to verify that the pointer is the same before and after the reference count
> +increment. This pattern can be seen in get_file_rcu() and __files_get_rcu().
> +
> +In addition, it isn't possible to access or check fields in struct file without
> +first aqcuiring a reference on it. Not doing that was always very dodgy and it
> +was only usable for non-pointer data in struct file. With SLAB_TYPESAFE_BY_RCU
> +it is necessary that callers first acquire a reference under rcu or they must
> +hold the files_lock of the fdtable. Failing to do either one of this is a bug.

Trivial correction: the last paragraph applies only to rcu lookups - something
like
        spin_lock(&files->file_lock);
        fdt = files_fdtable(files);
        if (close->fd >= fdt->max_fds) {
                spin_unlock(&files->file_lock);
                goto err;  
        }
        file = rcu_dereference_protected(fdt->fd[close->fd],
                        lockdep_is_held(&files->file_lock));
        if (!file || io_is_uring_fops(file)) {
		     ^^^^^^^^^^^^^^^^^^^^^ fetches file->f_op
                spin_unlock(&files->file_lock);
                goto err;
        }
	...

should be still valid.  As written, the reference to "rcu based file lookup"
is buried in the previous paragraph and it's not obvious that it applies to
the last one as well.  Incidentally, I would probably turn that fragment
(in io_uring/openclose.c:io_close()) into
	spin_lock(&files->file_lock);
	file = files_lookup_fd_locked(files, close->fd);
	if (!file || io_is_uring_fops(file)) {
		spin_unlock(&files->file_lock);
		goto err;
	}
	...

> diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
> index 1a587618015c..5e157f48995e 100644
> --- a/arch/powerpc/platforms/cell/spufs/coredump.c
> +++ b/arch/powerpc/platforms/cell/spufs/coredump.c
> @@ -74,10 +74,13 @@ static struct spu_context *coredump_next_context(int *fd)
>  	*fd = n - 1;
>  
>  	rcu_read_lock();
> -	file = lookup_fd_rcu(*fd);
> -	ctx = SPUFS_I(file_inode(file))->i_ctx;
> -	get_spu_context(ctx);
> +	file = lookup_fdget_rcu(*fd);
>  	rcu_read_unlock();
> +	if (file) {
> +		ctx = SPUFS_I(file_inode(file))->i_ctx;
> +		get_spu_context(ctx);
> +		fput(file);
> +	}

Well...  Here we should have descriptor table unshared, and we really
do rely upon that - we expect the file we'd found to have been a spufs
one *and* to have stayed that way.  So if anyone could change the
descriptor table behind our back, we'd be FUBAR.
