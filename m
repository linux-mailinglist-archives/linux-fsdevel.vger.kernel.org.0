Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F16AD6B33A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 03:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfGQB3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 21:29:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44344 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfGQB3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 21:29:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so9958396pfe.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 18:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=lCAdtmytrwTdW3zlJMsL7BH9HcOHIdUFUev907eAt/A=;
        b=EWeObjoFmWq4Omx3n/Vk5ieecW6ME7Q+UElx0hnCrcAOTTwfJ8WA/Sx8n3WY/vKhA0
         w6DxbQo2seu7BVmNL69pGIK8MrLb9SGxQw0ZhHDA/oLivg3XTYry1Jl/HOn/8ds0c/xl
         O9ThCZWa11yjixEiKl5hzy4Eccujt0+y1RLNUSrPKnvavkdRx+ydohJ0NNiQpiV3Ozvx
         aK7noJb1AfREOkm/Jo45bQYJsqD5CIa30MNowi++lgOE2CEfnJvHQKtzGzh+WEvqD0ri
         qekgiFl3gec+0sTohyesxiSbunkhOiFPrtSd5l3tnJD2fwW7uxBVPSQs3Dbrtim5XVys
         eqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=lCAdtmytrwTdW3zlJMsL7BH9HcOHIdUFUev907eAt/A=;
        b=fUshXfBph+phqmacp0TFTCLQ6byNnE6z+vvknId6ZX2/4Rem4c+h8QxyvJPA7cxAVz
         ytRxQIXxNoeiB+GcSUu9HQhg9IM5uyZTQ/d/Kir7K0qaT1jXXXQvY9JGO14Qo7NS6QVm
         oZ9zaxq9fm1++1qZ3cfohQk/u8St4mMp+w43rgXr4McmgKxgrBgAOIECqazIFF3tlPk2
         cJHjaSxhc3tb2LKfw4ASRWQ7gSt/6XzyCCkZt5ZsSgRJpZJMXMSfxXTV97Kq8smcyTsV
         VGnlNxUhR9OX1bXvtV3gktA5RBu/QuBXsJ4RANP75Zn/KivvGbgcxrjzkwnu6jYbqPqP
         K2hg==
X-Gm-Message-State: APjAAAXB4wlv8A/156kNZkvEAoNpWQaLEROIdxHsKpvMNqnl0s4584iH
        43ZB/h+ztBNhGA45/tl3gl51oQ==
X-Google-Smtp-Source: APXvYqxD+A8D1A0efvs/gHSpa51lIoBZYiXr5jNYG6C1/J/dqptdfkqKaxchYfNokKm4TbgakH+Oxw==
X-Received: by 2002:a17:90a:fa18:: with SMTP id cm24mr39334563pjb.120.1563326951272;
        Tue, 16 Jul 2019 18:29:11 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r61sm32564152pjb.7.2019.07.16.18.29.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 18:29:10 -0700 (PDT)
Subject: Add a new fchmodat4() syscall, v2
Date:   Tue, 16 Jul 2019 18:27:15 -0700
Message-Id: <20190717012719.5524-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        monstr@monstr.eu, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        dhowells@redhat.com, firoz.khan@linaro.org, stefan@agner.ch,
        schwidefsky@de.ibm.com, axboe@kernel.dk, christian@brauner.io,
        hare@suse.com, deepa.kernel@gmail.com, tycho@tycho.ws,
        kim.phillips@arm.com, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch set adds fchmodat4(), a new syscall. The actual
implementation is super simple: essentially it's just the same as
fchmodat(), but LOOKUP_FOLLOW is conditionally set based on the flags.
I've attempted to make this match "man 2 fchmodat" as closely as
possible, which says EINVAL is returned for invalid flags (as opposed to
ENOTSUPP, which is currently returned by glibc for AT_SYMLINK_NOFOLLOW).
I have a sketch of a glibc patch that I haven't even compiled yet, but
seems fairly straight-forward:

    diff --git a/sysdeps/unix/sysv/linux/fchmodat.c b/sysdeps/unix/sysv/linux/fchmodat.c
    index 6d9cbc1ce9e0..b1beab76d56c 100644
    --- a/sysdeps/unix/sysv/linux/fchmodat.c
    +++ b/sysdeps/unix/sysv/linux/fchmodat.c
    @@ -29,12 +29,36 @@
     int
     fchmodat (int fd, const char *file, mode_t mode, int flag)
     {
    -  if (flag & ~AT_SYMLINK_NOFOLLOW)
    -    return INLINE_SYSCALL_ERROR_RETURN_VALUE (EINVAL);
    -#ifndef __NR_lchmod		/* Linux so far has no lchmod syscall.  */
    +  /* There are four paths through this code:
    +      - The flags are zero.  In this case it's fine to call fchmodat.
    +      - The flags are non-zero and glibc doesn't have access to
    +	__NR_fchmodat4.  In this case all we can do is emulate the error codes
    +	defined by the glibc interface from userspace.
    +      - The flags are non-zero, glibc has __NR_fchmodat4, and the kernel has
    +	fchmodat4.  This is the simplest case, as the fchmodat4 syscall exactly
    +	matches glibc's library interface so it can be called directly.
    +      - The flags are non-zero, glibc has __NR_fchmodat4, but the kernel does
    +	not.  In this case we must respect the error codes defined by the glibc
    +	interface instead of returning ENOSYS.
    +    The intent here is to ensure that the kernel is called at most once per
    +    library call, and that the error types defined by glibc are always
    +    respected.  */
    +
    +#ifdef __NR_fchmodat4
    +  long result;
    +#endif
    +
    +  if (flag == 0)
    +    return INLINE_SYSCALL (fchmodat, 3, fd, file, mode);
    +
    +#ifdef __NR_fchmodat4
    +  result = INLINE_SYSCALL (fchmodat4, 4, fd, file, mode, flag);
    +  if (result == 0 || errno != ENOSYS)
    +    return result;
    +#endif
    +
       if (flag & AT_SYMLINK_NOFOLLOW)
         return INLINE_SYSCALL_ERROR_RETURN_VALUE (ENOTSUP);
    -#endif

    -  return INLINE_SYSCALL (fchmodat, 3, fd, file, mode);
    +  return INLINE_SYSCALL_ERROR_RETURN_VALUE (EINVAL);
     }

I've never added a new syscall before so I'm not really sure what the
proper procedure to follow is.  Based on the feedback from my v1 patch
set it seems this is somewhat uncontroversial.  At this point I don't
think there's anything I'm missing, though note that I haven't gotten
around to testing it this time because the diff from v1 is trivial for
any platform I could reasonably test on.  The v1 patches suggest a
simple test case, but I didn't re-run it because I don't want to reboot
my laptop.

    $ touch test-file
    $ ln -s test-file test-link
    $ cat > test.c
    #include <fcntl.h>
    #include <stdio.h>
    #include <unistd.h>

    int main(int argc, char **argv)
    {
            long out;

            out = syscall(434, AT_FDCWD, "test-file", 0x888, AT_SYMLINK_NOFOLLOW);
            printf("fchmodat4(AT_FDCWD, \"test-file\", 0x888, AT_SYMLINK_NOFOLLOW): %ld\n", out);

            out = syscall(434, AT_FDCWD, "test-file", 0x888, 0);
            printf("fchmodat4(AT_FDCWD, \"test-file\", 0x888, 0): %ld\n", out);

            out = syscall(268, AT_FDCWD, "test-file", 0x888);
            printf("fchmodat(AT_FDCWD, \"test-file\", 0x888): %ld\n", out);

            out = syscall(434, AT_FDCWD, "test-link", 0x888, AT_SYMLINK_NOFOLLOW);
            printf("fchmodat4(AT_FDCWD, \"test-link\", 0x888, AT_SYMLINK_NOFOLLOW): %ld\n", out);

            out = syscall(434, AT_FDCWD, "test-link", 0x888, 0);
            printf("fchmodat4(AT_FDCWD, \"test-link\", 0x888, 0): %ld\n", out);

            out = syscall(268, AT_FDCWD, "test-link", 0x888);
            printf("fchmodat(AT_FDCWD, \"test-link\", 0x888): %ld\n", out);

            return 0;
    }
    $ gcc test.c -o test
    $ ./test
    fchmodat4(AT_FDCWD, "test-file", 0x888, AT_SYMLINK_NOFOLLOW): 0
    fchmodat4(AT_FDCWD, "test-file", 0x888, 0): 0
    fchmodat(AT_FDCWD, "test-file", 0x888): 0
    fchmodat4(AT_FDCWD, "test-link", 0x888, AT_SYMLINK_NOFOLLOW): -1
    fchmodat4(AT_FDCWD, "test-link", 0x888, 0): 0
    fchmodat(AT_FDCWD, "test-link", 0x888): 0

I've only built this on 64-bit x86.

Changes since v1 [20190531191204.4044-1-palmer@sifive.com]:

* All architectures are now supported, which support squashed into a
  single patch.
* The do_fchmodat() helper function has been removed, in favor of directly
  calling do_fchmodat4().
* The patches are based on 5.2 instead of 5.1.

