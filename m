Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE56B35D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 03:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfGQB3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 21:29:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42359 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfGQB3P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 21:29:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so11036556plb.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2019 18:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Km6i2EwlnHTMsEa+Chc8B8lkJXrzGe+ncWgEI0oBDH8=;
        b=DLAJM7oG3ybeUmclWPVZfMhBUnRrw9wGMdXduIn2giXhaGrJ7S5W8yVcEE2KwLFQAh
         D1fm8Qfvlg4+vU/wK9eEo2SBWGFnrW2QH4msqzaJa2F5Mqtk545ueU4VzXlO2Pka91aE
         0ZIjIFL3MsFSMfhP6hasIsWi+LC5nQsPKwISrpKwFjetWndP1gu0y7RwT7xlLsYYY3bX
         aA9+vRQ2Jy/EGfc2fUemHwW+nDNJKVxhk9EQMc/dKQv4LICHm3AoRl9JnxONdNyJNxBk
         BKPc4PBCTZeLcTJbqW33HPUobtx12bsfbsrHt2Ek4XDY+qdDSWFBlI6LBq/1RrDbWAwT
         fAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=Km6i2EwlnHTMsEa+Chc8B8lkJXrzGe+ncWgEI0oBDH8=;
        b=T0UT+IDqAxUBPOT68rx7UCzWD4pPaHEiinO55VDTBbVVYmHKQIBluS3UkhWY2JWVA7
         /OpY2cgrv/adnJCznKinV856qi17Wr4pygf6JTM4qOJKsdIuAIA5eqSN68O6eKUUTjJx
         OTdevxd9e+m9wOjXHKx/8SqKtv6kTByi8Dr/APsuUAuoZZ1MhmLM67HRXk2lQK904rOl
         ao0ZOMy5IJH1EL97n+paeK2aUxh52uiAQ82ca/QGTNVBOKgOyKqmoPvH2Uqi2TeB4eEC
         2q5rwaT6wvIgvgPTWRvezf0nfkC888caJx4evR+S1BtcekdSXO3bJpzwCaRCr3CfPOtw
         T0Gw==
X-Gm-Message-State: APjAAAUBUxwsEMnwK3psxeaxB9e46qzf6FBskxf1Dtv65oFbFYH19XGT
        1wt+nTprrDPg7JC/4XBiGKjGDg==
X-Google-Smtp-Source: APXvYqy1hMVJ/bl9aSMVuTE5nvwz4oMGbsdCr+A6D4NXU76rmJy3i+4M2pUivduNcdb15I23YjfxXQ==
X-Received: by 2002:a17:902:ba96:: with SMTP id k22mr40372539pls.44.1563326954956;
        Tue, 16 Jul 2019 18:29:14 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s11sm20793710pgv.13.2019.07.16.18.29.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 18:29:14 -0700 (PDT)
Subject: [PATCH v2 2/4] Add fchmodat4(), a new syscall
Date:   Tue, 16 Jul 2019 18:27:17 -0700
Message-Id: <20190717012719.5524-3-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717012719.5524-1-palmer@sifive.com>
References: <20190717012719.5524-1-palmer@sifive.com>
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

man 3p says that fchmodat() takes a flags argument, but the Linux
syscall does not.  There doesn't appear to be a good userspace
workaround for this issue but the implementation in the kernel is pretty
straight-forward.  The specific use case where the missing flags came up
was WRT a fuse filesystem implemenation, but the functionality is pretty
generic so I'm assuming there would be other use cases.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 fs/open.c                | 20 ++++++++++++++++----
 include/linux/syscalls.h |  7 +++++--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index b5b80469b93d..2f72b4d6a2c1 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -569,11 +569,17 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
 	return ksys_fchmod(fd, mode);
 }
 
-int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
+int do_fchmodat4(int dfd, const char __user *filename, umode_t mode, int flags)
 {
 	struct path path;
 	int error;
-	unsigned int lookup_flags = LOOKUP_FOLLOW;
+	unsigned int lookup_flags;
+
+	if (unlikely(flags & ~AT_SYMLINK_NOFOLLOW))
+		return -EINVAL;
+
+	lookup_flags = flags & AT_SYMLINK_NOFOLLOW ? 0 : LOOKUP_FOLLOW;
+
 retry:
 	error = user_path_at(dfd, filename, lookup_flags, &path);
 	if (!error) {
@@ -587,15 +593,21 @@ int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
 	return error;
 }
 
+SYSCALL_DEFINE4(fchmodat4, int, dfd, const char __user *, filename,
+		umode_t, mode, int, flags)
+{
+	return do_fchmodat4(dfd, filename, mode, flags);
+}
+
 SYSCALL_DEFINE3(fchmodat, int, dfd, const char __user *, filename,
 		umode_t, mode)
 {
-	return do_fchmodat(dfd, filename, mode);
+	return do_fchmodat4(dfd, filename, mode, 0);
 }
 
 SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
 {
-	return do_fchmodat(AT_FDCWD, filename, mode);
+	return do_fchmodat4(AT_FDCWD, filename, mode, 0);
 }
 
 static int chown_common(const struct path *path, uid_t user, gid_t group)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e1c20f1d0525..a4bde25ad264 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -433,6 +433,8 @@ asmlinkage long sys_chroot(const char __user *filename);
 asmlinkage long sys_fchmod(unsigned int fd, umode_t mode);
 asmlinkage long sys_fchmodat(int dfd, const char __user *filename,
 			     umode_t mode);
+asmlinkage long sys_fchmodat4(int dfd, const char __user *filename,
+			     umode_t mode, int flags);
 asmlinkage long sys_fchownat(int dfd, const char __user *filename, uid_t user,
 			     gid_t group, int flag);
 asmlinkage long sys_fchown(unsigned int fd, uid_t user, gid_t group);
@@ -1320,11 +1322,12 @@ static inline long ksys_link(const char __user *oldname,
 	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
 
-extern int do_fchmodat(int dfd, const char __user *filename, umode_t mode);
+extern int do_fchmodat4(int dfd, const char __user *filename, umode_t mode,
+			int flags);
 
 static inline int ksys_chmod(const char __user *filename, umode_t mode)
 {
-	return do_fchmodat(AT_FDCWD, filename, mode);
+	return do_fchmodat4(AT_FDCWD, filename, mode, 0);
 }
 
 extern long do_faccessat(int dfd, const char __user *filename, int mode);
-- 
2.21.0

