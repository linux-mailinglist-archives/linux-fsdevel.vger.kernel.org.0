Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911D774EEE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGKMbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 08:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGKMbi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF52173A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 05:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689078501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xjRw+jQ/3UZ/6JfODln6k9FlUepnlRP0EJXqY57Twrc=;
        b=WTwaDA8gYtkPU6QJqflZAOgvEFgqBgab++gDifsIwk4ANgqodewlmX2z2OtUdkD9npCJps
        Tgn1ghP30rvDFcoTqUmmjQ1eWyX5OnrXn1DnamEJ2IAf3+WLiROAkDL7eGrhmgF8P4/Lbt
        NEK+7jr5Z6E4EN17gxlxMJNjLcsdxKE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-7TmWQ9O4NwC7vHZLlcVKgA-1; Tue, 11 Jul 2023 08:25:06 -0400
X-MC-Unique: 7TmWQ9O4NwC7vHZLlcVKgA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E5E628EC108;
        Tue, 11 Jul 2023 12:25:04 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96DBB200AD6E;
        Tue, 11 Jul 2023 12:24:53 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, James.Bottomley@HansenPartnership.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        axboe@kernel.dk, benh@kernel.crashing.org, borntraeger@de.ibm.com,
        bp@alien8.de, catalin.marinas@arm.com, christian@brauner.io,
        dalias@libc.org, davem@davemloft.net, deepa.kernel@gmail.com,
        deller@gmx.de, dhowells@redhat.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, glebfm@altlinux.org, gor@linux.ibm.com,
        hare@suse.com, hpa@zytor.com, ink@jurassic.park.msu.ru,
        jhogan@kernel.org, kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, luto@kernel.org, mattst88@gmail.com,
        mingo@redhat.com, monstr@monstr.eu, mpe@ellerman.id.au,
        namhyung@kernel.org, paul.burton@mips.com, paulus@samba.org,
        peterz@infradead.org, ralf@linux-mips.org, rth@twiddle.net,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp
Subject: Re: [PATCH v3 0/5] Add a new fchmodat4() syscall
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
        <cover.1689074739.git.legion@kernel.org>
Date:   Tue, 11 Jul 2023 14:24:51 +0200
In-Reply-To: <cover.1689074739.git.legion@kernel.org> (Alexey Gladkov's
        message of "Tue, 11 Jul 2023 13:25:41 +0200")
Message-ID: <87lefmbppo.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Alexey Gladkov:

> This patch set adds fchmodat4(), a new syscall. The actual
> implementation is super simple: essentially it's just the same as
> fchmodat(), but LOOKUP_FOLLOW is conditionally set based on the flags.
> I've attempted to make this match "man 2 fchmodat" as closely as
> possible, which says EINVAL is returned for invalid flags (as opposed to
> ENOTSUPP, which is currently returned by glibc for AT_SYMLINK_NOFOLLOW).
> I have a sketch of a glibc patch that I haven't even compiled yet, but
> seems fairly straight-forward:
>
>     diff --git a/sysdeps/unix/sysv/linux/fchmodat.c b/sysdeps/unix/sysv/linux/fchmodat.c
>     index 6d9cbc1ce9e0..b1beab76d56c 100644
>     --- a/sysdeps/unix/sysv/linux/fchmodat.c
>     +++ b/sysdeps/unix/sysv/linux/fchmodat.c
>     @@ -29,12 +29,36 @@
>      int
>      fchmodat (int fd, const char *file, mode_t mode, int flag)
>      {
>     -  if (flag & ~AT_SYMLINK_NOFOLLOW)
>     -    return INLINE_SYSCALL_ERROR_RETURN_VALUE (EINVAL);
>     -#ifndef __NR_lchmod		/* Linux so far has no lchmod syscall.  */
>     +  /* There are four paths through this code:
>     +      - The flags are zero.  In this case it's fine to call fchmodat.
>     +      - The flags are non-zero and glibc doesn't have access to
>     +	__NR_fchmodat4.  In this case all we can do is emulate the error codes
>     +	defined by the glibc interface from userspace.
>     +      - The flags are non-zero, glibc has __NR_fchmodat4, and the kernel has
>     +	fchmodat4.  This is the simplest case, as the fchmodat4 syscall exactly
>     +	matches glibc's library interface so it can be called directly.
>     +      - The flags are non-zero, glibc has __NR_fchmodat4, but the kernel does

If you define __NR_fchmodat4 on all architectures, we can use these
constants directly in glibc.  We no longer depend on the UAPI
definitions of those constants, to cut down the number of code variants,
and to make glibc's system call profile independent of the kernel header
version at build time.

Your version is based on 2.31, more recent versions have some reasonable
emulation for fchmodat based on /proc/self/fd.  I even wrote a comment
describing the same buggy behavior that you witnessed:

+      /* Some Linux versions with some file systems can actually
+        change symbolic link permissions via /proc, but this is not
+        intentional, and it gives inconsistent results (e.g., error
+        return despite mode change).  The expected behavior is that
+        symbolic link modes cannot be changed at all, and this check
+        enforces that.  */
+      if (S_ISLNK (st.st_mode))
+       {
+         __close_nocancel (pathfd);
+         __set_errno (EOPNOTSUPP);
+         return -1;
+       }

I think there was some kernel discussion about that behavior before, but
apparently, it hasn't led to fixes.

I wonder if it makes sense to add a similar error return to the system
call implementation?

>     +	not.  In this case we must respect the error codes defined by the glibc
>     +	interface instead of returning ENOSYS.
>     +    The intent here is to ensure that the kernel is called at most once per
>     +    library call, and that the error types defined by glibc are always
>     +    respected.  */
>     +
>     +#ifdef __NR_fchmodat4
>     +  long result;
>     +#endif
>     +
>     +  if (flag == 0)
>     +    return INLINE_SYSCALL (fchmodat, 3, fd, file, mode);
>     +
>     +#ifdef __NR_fchmodat4
>     +  result = INLINE_SYSCALL (fchmodat4, 4, fd, file, mode, flag);
>     +  if (result == 0 || errno != ENOSYS)
>     +    return result;
>     +#endif

The last if condition is the recommended approach, but in the past, it
broke container host compatibility pretty badly due to seccomp filters
that return EPERM instead of ENOSYS.  I guess we'll learn soon enough if
that's been fixed by now. 8-P

Thanks,
Florian

