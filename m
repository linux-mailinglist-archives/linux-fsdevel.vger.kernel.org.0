Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD34331545
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 21:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfEaTXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 15:23:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39266 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfEaTXu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 15:23:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so4384195plm.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2019 12:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=VG+Xtpxl4luXcLoXYHzOczLmqwJ/KICZpqExcJIYQWo=;
        b=WOunJzt5hFKtSZmzNmN+XxBLXHmG6bWhcZI/2W3gnVGdkxINagqfAnuoGlDqP22v0i
         pDhSGoo6KmpWRQGx/1F4ThCFImqU0K7oiwxkVMQv6cu/RFaPyC7eMsBLYwLlToJDCyXn
         q1o+JKclwBUBKAoSfzH+c2+Nw7eAjIQTSPgfoSb/v0lJAkukgVtQxmd2E+S6h7/5X1oL
         9b+P+2NxS33LUpMDSxmVto+fGTb52Z63VM67lRbHp06livpAqovjMMrhysQOnIy1iyoJ
         BDV0gJQpuLZERsrqx2orA4csh90yDiKZ5J7cKS7+uKffY1oCqgtBaGUS4tmUNEtvmm3w
         Q8TQ==
X-Gm-Message-State: APjAAAUhH3au3lT7NXbx1TO0Cv+U2AnOrGda8HegV1UASHHGLW/7tVCR
        17CQwPgbOpnwhzRXSqK65piyyA==
X-Google-Smtp-Source: APXvYqwodoAgavzj2P4i1gNyR2leUPdA0IKjvBtDOQwiUdYmgggspbkKhk4fbaMsdd3hKYvFlqbwlg==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr11774895pla.172.1559330629047;
        Fri, 31 May 2019 12:23:49 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r4sm11493078pfq.134.2019.05.31.12.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 12:23:48 -0700 (PDT)
Subject: Add a new fchmodat4() syscall
Date:   Fri, 31 May 2019 12:11:59 -0700
Message-Id: <20190531191204.4044-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Arnd Bergmann <arnd@arndb.de>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I spent half of dinner last night being complained to by one of our
hardware engineers about Linux's lack of support for the flags argument
to fchmodat().  This all came about because of a FUSE filesystem
implementation, and while there are some application-specific
workarounds for the issue it seemed to me like the cleanest bet was to
just go add another fchmodat() that supports flags to the kernel.

The actual implementation is super simple: essentially it's just
the same as fchmodat(), but LOOKUP_FOLLOW is conditionally set based on
the flags.  I've attempted to make this match "man 2 fchmodat" as
closely as possible, which says EINVAL is returned for invalid flags (as
opposed to ENOTSUPP, which is currently returned by glibc for
AT_SYMLINK_NOFOLLOW).  I have a sketch of a glibc patch that I haven't
even compiled yet, but seems fairly straight-forward:

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
proper procedure to follow is.  I'm assuming any new syscall will
involve fairly significant discussion, so I've just done the minimum of
an implementation for this patch set.  Specifically, I've:

* Defined a new syscall that looks like fchmodat but includes a flag
  argument, which I'm calling fchmodat4 because it has 4 arguments.  I
  don't know if that's the correct naming convention, and don't really
  have any skin in that game.
* Implemented that syscall by extending the fchmod code to handle flags,
  which is pretty straight-forward.  I think it's sane, but given that
  it's so simple I'm not sure if I'm missing something -- specifically,
  I didn't go check to make sure the semantics of AT_SYMLINK_NOFOLLOW
  match !LOOKUP_FOLLOW.  I'm assuming the do, but sometimes when I look
  at something and say "that's so simple, how is it broken" I'm actually
  just missing something entirely.
* Added an asm-generic syscall number for this, which I assume I'm
  supposed to do this first as it looks like we're trying to keep the
  numbers in sync everywhere.
* Added x86 syscalls for this so I could test it.

I also cleaned up a checkpatch issue in fchmodat().  I only found this
because I copied the fchmodat() interface for fchmodat4() and it threw
the warning, I don't personally care either way as to whether or not the
space is in there.

I've given this fairly minimal testing.  Essentially all I've done is
booted up 5.1.6 with this patch set on my local development box and run

    $ touch test-file
    $ ln -s test-file test-link
    $ cat > test.c
    #include <fcntl.h>
    #include <stdio.h>
    #include <unistd.h>
    
    int main(int argc, char **argv)
    {
            long out;
    
            out = syscall(428, AT_FDCWD, "test-file", 0x888, AT_SYMLINK_NOFOLLOW);
            printf("fchmodat4(AT_FDCWD, \"test-file\", 0x888, AT_SYMLINK_NOFOLLOW): %ld\n", out);
    
            out = syscall(428, AT_FDCWD, "test-file", 0x888, 0);
            printf("fchmodat4(AT_FDCWD, \"test-file\", 0x888, 0): %ld\n", out);
    
            out = syscall(268, AT_FDCWD, "test-file", 0x888);
            printf("fchmodat(AT_FDCWD, \"test-file\", 0x888): %ld\n", out);
    
            out = syscall(428, AT_FDCWD, "test-link", 0x888, AT_SYMLINK_NOFOLLOW);
            printf("fchmodat4(AT_FDCWD, \"test-link\", 0x888, AT_SYMLINK_NOFOLLOW): %ld\n", out);
    
            out = syscall(428, AT_FDCWD, "test-link", 0x888, 0);
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

While I don't think there's any reason what's there is unacceptable, I
don't really consider this finished.  I couldn't find a cookbook for
"here's how you add a system call", but all I really did was "git grep
add | grep syscall" so if there's something out there then please let me
know and I'll follow it.  Specifically, I haven't:

* Added any sort of documentation.  I don't find anything with a "git
  grep fchmodat", so I'm assuming it's just the man pages that are
  relevant here.
* Fixed any of the other architectures.  I'm assuming this is just the
  mechanical process of fixing all these in the same way I did for x86.

      arch/alpha/kernel/syscalls/syscall.tbl:461      common  fchmodat                        sys_fchmodat
      arch/arm/tools/syscall.tbl:333  common  fchmodat                sys_fchmodat
      arch/arm64/include/asm/unistd32.h:#define __NR_fchmodat 333
      arch/arm64/include/asm/unistd32.h:__SYSCALL(__NR_fchmodat, sys_fchmodat)
      arch/ia64/kernel/fsys.S:        data8 0                         // fchmodat
      arch/ia64/kernel/syscalls/syscall.tbl:268       common  fchmodat                        sys_fchmodat
      arch/m68k/kernel/syscalls/syscall.tbl:299       common  fchmodat                        sys_fchmodat
      arch/microblaze/kernel/syscalls/syscall.tbl:306 common  fchmodat                        sys_fchmodat
      arch/mips/kernel/syscalls/syscall_n32.tbl:262   n32     fchmodat                        sys_fchmodat
      arch/mips/kernel/syscalls/syscall_n64.tbl:258   n64     fchmodat                        sys_fchmodat
      arch/mips/kernel/syscalls/syscall_o32.tbl:299   o32     fchmodat                        sys_fchmodat
      arch/parisc/kernel/syscalls/syscall.tbl:286     common  fchmodat                sys_fchmodat
      arch/powerpc/kernel/syscalls/syscall.tbl:297    common  fchmodat                        sys_fchmodat
      arch/s390/kernel/syscalls/syscall.tbl:299  common       fchmodat                sys_fchmodat                    sys_fchmodat
      arch/sh/include/uapi/asm/unistd_64.h:#define __NR_fchmodat              334
      arch/sh/kernel/syscalls/syscall.tbl:306 common  fchmodat                        sys_fchmodat
      arch/sh/kernel/syscalls_64.S:   .long sys_fchmodat
      arch/sparc/kernel/syscalls/syscall.tbl:295      common  fchmodat                sys_fchmodat
      arch/xtensa/kernel/syscalls/syscall.tbl:300     common  fchmodat                        sys_fchmodat
* Looked at anything in tools.  Again, I'm assuming it's just a
  mechanical process of looking at all of these and adding fchmodat4.

      tools/include/nolibc/nolibc.h:#ifdef __NR_fchmodat
      tools/include/nolibc/nolibc.h:  return my_syscall4(__NR_fchmodat, AT_FDCWD, path, mode, 0);
      tools/include/uapi/asm-generic/unistd.h:#define __NR_fchmodat 53
      tools/include/uapi/asm-generic/unistd.h:__SYSCALL(__NR_fchmodat, sys_fchmodat)
      tools/perf/arch/powerpc/entry/syscalls/syscall.tbl:297  common  fchmodat                        sys_fchmodat
      tools/perf/arch/s390/entry/syscalls/syscall.tbl:299  common     fchmodat                sys_fchmodat                    compat_sys_fchmodat
      tools/perf/arch/x86/entry/syscalls/syscall_64.tbl:268   common  fchmodat                __x64_sys_fchmodat
      tools/perf/builtin-trace.c:     { .name     = "fchmodat",

* Done anything with userspace, aside from thinking about the glibc code
  above.  I'd assume that I'm meant to bring in libc-alpha to the
  discussion, but I didn't want to do so this early in case this was
  just a non-starter.

I'm happy dealing with all of that, but given that I'm assuming there's
going to be some discussion I wanted to send out the proof-of-concept
first to see if this has any legs.  Aside from the glibc side the
remaining work smells pretty mechanical, so I figured I'd wait on that
until I knew it wasn't going to be a waste of time -- partially because
I'm lazy, but mostly because I just realized I blew my whole morning
working on this when all I really wanted to do was avoid discussing
fchmodat in the first place :)
    

