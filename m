Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346AB74ECB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 13:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjGKL2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 07:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjGKL2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:28:07 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7B910C7
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 04:28:01 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-P9VisGTbPgGWqvxb_D7cHg-1; Tue, 11 Jul 2023 07:26:13 -0400
X-MC-Unique: P9VisGTbPgGWqvxb_D7cHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A4AF10504C9;
        Tue, 11 Jul 2023 11:26:13 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.45.225.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B08863F3C;
        Tue, 11 Jul 2023 11:25:59 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     James.Bottomley@HansenPartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        dhowells@redhat.com, fenghua.yu@intel.com, firoz.khan@linaro.org,
        fweimer@redhat.com, geert@linux-m68k.org, glebfm@altlinux.org,
        gor@linux.ibm.com, hare@suse.com, heiko.carstens@de.ibm.com,
        hpa@zytor.com, ink@jurassic.park.msu.ru, jhogan@kernel.org,
        kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, luto@kernel.org, mattst88@gmail.com,
        mingo@redhat.com, monstr@monstr.eu, mpe@ellerman.id.au,
        namhyung@kernel.org, palmer@sifive.com, paul.burton@mips.com,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        rth@twiddle.net, schwidefsky@de.ibm.com,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp
Subject: [PATCH v3 0/5] Add a new fchmodat4() syscall
Date:   Tue, 11 Jul 2023 13:25:41 +0200
Message-Id: <cover.1689074739.git.legion@kernel.org>
In-Reply-To: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes since v2 [20190717012719.5524-1-palmer@sifive.com]:

* Rebased to master.
* The lookup_flags passed to sys_fchmodat4 as suggested by Al Viro.
* Selftest added.

Changes since v1 [20190531191204.4044-1-palmer@sifive.com]:

* All architectures are now supported, which support squashed into a
  single patch.
* The do_fchmodat() helper function has been removed, in favor of directly
  calling do_fchmodat4().
* The patches are based on 5.2 instead of 5.1.

---

Alexey Gladkov (1):
  selftests: add fchmodat4(2) selftest

Palmer Dabbelt (4):
  Non-functional cleanup of a "__user * filename"
  fs: Add fchmodat4()
  arch: Register fchmodat4, usually as syscall 451
  tools headers UAPI: Sync files changed by new fchmodat4 syscall

 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/arm64/include/asm/unistd32.h             |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl         |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 fs/open.c                                     |  18 ++-
 include/linux/syscalls.h                      |   4 +-
 include/uapi/asm-generic/unistd.h             |   5 +-
 tools/include/uapi/asm-generic/unistd.h       |   5 +-
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |   1 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |   1 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |   1 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/fchmodat4/.gitignore  |   2 +
 tools/testing/selftests/fchmodat4/Makefile    |   6 +
 .../selftests/fchmodat4/fchmodat4_test.c      | 151 ++++++++++++++++++
 29 files changed, 207 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/fchmodat4/.gitignore
 create mode 100644 tools/testing/selftests/fchmodat4/Makefile
 create mode 100644 tools/testing/selftests/fchmodat4/fchmodat4_test.c

-- 
2.33.8

