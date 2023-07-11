Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B321F74ECCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 13:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjGKL3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 07:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjGKL2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:28:38 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C6B1BCB
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 04:28:27 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-1yjghznhNHO9f6zghBUlhw-1; Tue, 11 Jul 2023 07:26:39 -0400
X-MC-Unique: 1yjghznhNHO9f6zghBUlhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F71B3C13928;
        Tue, 11 Jul 2023 11:26:38 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.45.225.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5A9463F3C;
        Tue, 11 Jul 2023 11:26:25 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        James.Bottomley@HansenPartnership.com, acme@kernel.org,
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
        namhyung@kernel.org, paul.burton@mips.com, paulus@samba.org,
        peterz@infradead.org, ralf@linux-mips.org, rth@twiddle.net,
        schwidefsky@de.ibm.com, sparclinux@vger.kernel.org,
        stefan@agner.ch, tglx@linutronix.de, tony.luck@intel.com,
        tycho@tycho.ws, will@kernel.org, x86@kernel.org,
        ysato@users.sourceforge.jp
Subject: [PATCH v3 2/5] fs: Add fchmodat4()
Date:   Tue, 11 Jul 2023 13:25:43 +0200
Message-Id: <d11b93ad8e3b669afaff942e25c3fca65c6a983c.1689074739.git.legion@kernel.org>
In-Reply-To: <cover.1689074739.git.legion@kernel.org>
References: <87o8pscpny.fsf@oldenburg2.str.redhat.com> <cover.1689074739.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

On the userspace side fchmodat(3) is implemented as a wrapper
function which implements the POSIX-specified interface. This
interface differs from the underlying kernel system call, which does not
have a flags argument. Most implementations require procfs [1][2].

There doesn't appear to be a good userspace workaround for this issue
but the implementation in the kernel is pretty straight-forward.

The new fchmodat4() syscall allows to pass the AT_SYMLINK_NOFOLLOW flag,
unlike existing fchmodat.

[1] https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/fchmodat.c;h=17eca54051ee28ba1ec3f9aed170a62630959143;hb=a492b1e5ef7ab50c6fdd4e4e9879ea5569ab0a6c#l35
[2] https://git.musl-libc.org/cgit/musl/tree/src/stat/fchmodat.c?id=718f363bc2067b6487900eddc9180c84e7739f80#n28

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/open.c                | 18 ++++++++++++++----
 include/linux/syscalls.h |  2 ++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 4478adcc4f3a..58bb88c6afb6 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -671,11 +671,11 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
 	return err;
 }
 
-static int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
+static int do_fchmodat4(int dfd, const char __user *filename, umode_t mode, int lookup_flags)
 {
 	struct path path;
 	int error;
-	unsigned int lookup_flags = LOOKUP_FOLLOW;
+
 retry:
 	error = user_path_at(dfd, filename, lookup_flags, &path);
 	if (!error) {
@@ -689,15 +689,25 @@ static int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
 	return error;
 }
 
+SYSCALL_DEFINE4(fchmodat4, int, dfd, const char __user *, filename,
+		umode_t, mode, int, flags)
+{
+	if (unlikely(flags & ~AT_SYMLINK_NOFOLLOW))
+		return -EINVAL;
+
+	return do_fchmodat4(dfd, filename, mode,
+			flags & AT_SYMLINK_NOFOLLOW ? 0 : LOOKUP_FOLLOW);
+}
+
 SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename,
 		umode_t, mode)
 {
-	return do_fchmodat(dfd, filename, mode);
+	return do_fchmodat4(dfd, filename, mode, LOOKUP_FOLLOW);
 }
 
 SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
 {
-	return do_fchmodat(AT_FDCWD, filename, mode);
+	return do_fchmodat4(AT_FDCWD, filename, mode, LOOKUP_FOLLOW);
 }
 
 /**
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 497bdd968c32..b17d37d2bad6 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -466,6 +466,8 @@ asmlinkage long sys_chroot(const char __user *filename);
 asmlinkage long sys_fchmod(unsigned int fd, umode_t mode);
 asmlinkage long sys_fchmodat(int dfd, const char __user *filename,
 			     umode_t mode);
+asmlinkage long sys_fchmodat4(int dfd, const char __user *filename,
+			     umode_t mode, int flags);
 asmlinkage long sys_fchownat(int dfd, const char __user *filename, uid_t user,
 			     gid_t group, int flag);
 asmlinkage long sys_fchown(unsigned int fd, uid_t user, gid_t group);
-- 
2.33.8

