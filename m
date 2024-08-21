Return-Path: <linux-fsdevel+bounces-26463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07199959976
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 13:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E721F2497D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7936420694F;
	Wed, 21 Aug 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="zDSvhaKH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A521B3B12
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234214; cv=none; b=ezSYSwvEidFdKGkvTmXCZZetn3bro8rr37ZhBEB+KKBEClCjg8nffaSX1vcaKoufchyfCkvG/gt4ylK9UizGQiPtjEU0cimq8X7GQBVFwT4euVIABRAJb+TpWjWrbVB1s/3FgATinJyWOSO/2PNdNHJVjza7U2BtMmkShc1uEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234214; c=relaxed/simple;
	bh=HWH25yedLYdz8ph8RY73eXm+N0rL0t6KkJUIcf82vuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yb70NThXcH8h1OukuKb0auOWbWZWvsbsO7tynLS4Hjy+VVbEWMLoMXMIrfJ5k0S6ZK9Tt1tnECWoiNet8t8ZLrQ5PURivuGjE15ZD+fviCs6ywywqsSNba1qKNVGEfzJ+KyhVGNy0Q+TMAKUwtWNRnar01sHrdKwkhHnGxASo5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=zDSvhaKH; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WphYl4rvFz19Jt;
	Wed, 21 Aug 2024 11:56:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724234187;
	bh=yUyLTvLEaoLUHEgIZFvmpeRx32nYNt81EVAXTRpMemc=;
	h=From:To:Cc:Subject:Date:From;
	b=zDSvhaKHu+Wm4cRqIZyQdDaiV70hi7RZnioobuXfjPbQWQyiitSvNxM2OBuyrm8Uq
	 jzw0avdMOz3+AQuLuQZEKyaFyUo0xT7FlRt1qTZOf2TldRDmzF9ik+HRLKHekELdOB
	 CmfjJB4Q4y6FRPwOTmk7c541fWPTfFWuIaqWxgEM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WphYk49KczLLf;
	Wed, 21 Aug 2024 11:56:26 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Casey Schaufler <casey@schaufler-ca.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 1/2] fs: Fix file_set_fowner LSM hook inconsistencies
Date: Wed, 21 Aug 2024 11:56:05 +0200
Message-ID: <20240821095609.365176-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The fcntl's F_SETOWN command sets the process that handle SIGIO/SIGURG
for the related file descriptor.  Before this change, the
file_set_fowner LSM hook was always called, ignoring the VFS logic which
may not actually change the process that handles SIGIO (e.g. TUN, TTY,
dnotify), nor update the related UID/EUID.

Moreover, because security_file_set_fowner() was called without lock
(e.g. f_owner.lock), concurrent F_SETOWN commands could result to a race
condition and inconsistent LSM states (e.g. SELinux's fown_sid) compared
to struct fown_struct's UID/EUID.

This change makes sure the LSM states are always in sync with the VFS
state by moving the security_file_set_fowner() call close to the
UID/EUID updates and using the same f_owner.lock .

Rename f_modown() to __f_setown() to simplify code.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://lore.kernel.org/r/20240812174421.1636724-1-mic@digikod.net
- Only keep the LSM hook move.

Changes since v1:
https://lore.kernel.org/r/20240812144936.1616628-1-mic@digikod.net
- Add back the file_set_fowner hook (but without user) as
  requested by Paul, but move it for consistency.
---
 fs/fcntl.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 300e5d9ad913..c28dc6c005f1 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -87,8 +87,8 @@ static int setfl(int fd, struct file * filp, unsigned int arg)
 	return error;
 }
 
-static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
-                     int force)
+void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
+		int force)
 {
 	write_lock_irq(&filp->f_owner.lock);
 	if (force || !filp->f_owner.pid) {
@@ -98,19 +98,13 @@ static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
 
 		if (pid) {
 			const struct cred *cred = current_cred();
+			security_file_set_fowner(filp);
 			filp->f_owner.uid = cred->uid;
 			filp->f_owner.euid = cred->euid;
 		}
 	}
 	write_unlock_irq(&filp->f_owner.lock);
 }
-
-void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
-		int force)
-{
-	security_file_set_fowner(filp);
-	f_modown(filp, pid, type, force);
-}
 EXPORT_SYMBOL(__f_setown);
 
 int f_setown(struct file *filp, int who, int force)
@@ -146,7 +140,7 @@ EXPORT_SYMBOL(f_setown);
 
 void f_delown(struct file *filp)
 {
-	f_modown(filp, NULL, PIDTYPE_TGID, 1);
+	__f_setown(filp, NULL, PIDTYPE_TGID, 1);
 }
 
 pid_t f_getown(struct file *filp)
-- 
2.46.0


