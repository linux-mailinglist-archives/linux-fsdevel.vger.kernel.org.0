Return-Path: <linux-fsdevel+bounces-46949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41799A96DC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9CF7A99AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722B628150B;
	Tue, 22 Apr 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ5nuynm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF927C158
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330565; cv=none; b=Xm7GjfpJ+EsL7PjKuYvkCR7rkrNBShvaUk50+ehHiIdj6VRpBaB/0bJlg8v//va/k2LuhIL7WQIvWnBT/77BUB6YM64kSBtW49cQKoha17DS3NYsBq1LKWJ0gpKCRnKbOQsUhsIUJFwOobRKgoHK138cbRf7LBqr3RVFvbRqwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330565; c=relaxed/simple;
	bh=7RfI2IHE7zQtNw/N6NsLRkG2eg30BYeS0Pla5ZjDVvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=puOFrV2GHlY1oDrRNpT+mGlEbOjSXWZsW+4Gouc+JsXci+H4FL93Na6Y34tUHKFavwsc0/08T2bnzXRt7MYZ7HzLzbC4Su+lNjXSqXBoLwjMOKeAIaHIJItDvmIREdW34OldE17Q0v3mIRIY7AUALiUQqqtRZ4UosaAy5i2zMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ5nuynm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749D6C4CEEA;
	Tue, 22 Apr 2025 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745330565;
	bh=7RfI2IHE7zQtNw/N6NsLRkG2eg30BYeS0Pla5ZjDVvo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jQ5nuynmML+AkMgcvvaSJZE97PsLprl36a4q72ONX3/6/jUP0kUpJsJI+iXkI3DLU
	 im1+Sm27oVnfLX/C4xlBTzqQ2VeWoFOL/a1IrUeU0/Nd70GwsgaBhORTg2b/2m8p7h
	 BO6vgpvstwRoP/uuJWX8qoD96zlECx7OPOvofTuZM34fvmMDvaI+a/dkwiFdBhqNFA
	 6qWXLukMlg0FheCqkRr1RNC5b0VyJxO65w3W3tkm3C7FQIENxLAWNKfxp3Cp2eoh60
	 rppVXx5YEQ9BHJsQGEvvGkhKxk36E0L+0vRIFi5js3zjx34M4M47PH32/I7QzdrBTl
	 Y/7hgARRYeo8A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 22 Apr 2025 16:02:32 +0200
Subject: [PATCH v2 1/2] mnt_idmapping: don't bother with
 initial_idmapping() in {from,make}_vfs{g,u}id()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-work-mnt_idmap-s_user_ns-v2-1-34ce4a82f931@kernel.org>
References: <20250422-work-mnt_idmap-s_user_ns-v2-0-34ce4a82f931@kernel.org>
In-Reply-To: <20250422-work-mnt_idmap-s_user_ns-v2-0-34ce4a82f931@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4096; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7RfI2IHE7zQtNw/N6NsLRkG2eg30BYeS0Pla5ZjDVvo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSwL2xIUdSVvtJ2keGY0mFhrhuPFDXFFppqdiYdORSuZ
 tq8o4K3o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIr4xkZNmYf4H4/7Z8hH2fi
 P42WOx6N/55F8LxVmNIj2bZLTLh/JiPDY0PJ+cslD3Kulf//JdTuwdWYwEVrHGV2Fk9YeDJY8/s
 6VgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The shortcut isn't really worth it and just causes more complexity than
necessary most likely. It elides an smp_rmb() in some cases but let's
see if that actually matters.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mnt_idmapping.c | 46 ++--------------------------------------------
 1 file changed, 2 insertions(+), 44 deletions(-)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index a37991fdb194..373a3eba2ff8 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -42,20 +42,6 @@ struct mnt_idmap invalid_mnt_idmap = {
 };
 EXPORT_SYMBOL_GPL(invalid_mnt_idmap);
 
-/**
- * initial_idmapping - check whether this is the initial mapping
- * @ns: idmapping to check
- *
- * Check whether this is the initial mapping, mapping 0 to 0, 1 to 1,
- * [...], 1000 to 1000 [...].
- *
- * Return: true if this is the initial mapping, false if not.
- */
-static inline bool initial_idmapping(const struct user_namespace *ns)
-{
-	return ns == &init_user_ns;
-}
-
 /**
  * make_vfsuid - map a filesystem kuid according to an idmapping
  * @idmap: the mount's idmapping
@@ -65,13 +51,6 @@ static inline bool initial_idmapping(const struct user_namespace *ns)
  * Take a @kuid and remap it from @fs_userns into @idmap. Use this
  * function when preparing a @kuid to be reported to userspace.
  *
- * If initial_idmapping() determines that this is not an idmapped mount
- * we can simply return @kuid unchanged.
- * If initial_idmapping() tells us that the filesystem is not mounted with an
- * idmapping we know the value of @kuid won't change when calling
- * from_kuid() so we can simply retrieve the value via __kuid_val()
- * directly.
- *
  * Return: @kuid mapped according to @idmap.
  * If @kuid has no mapping in either @idmap or @fs_userns INVALID_UID is
  * returned.
@@ -87,12 +66,7 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
 		return VFSUIDT_INIT(kuid);
 	if (idmap == &invalid_mnt_idmap)
 		return INVALID_VFSUID;
-	if (initial_idmapping(fs_userns))
-		uid = __kuid_val(kuid);
-	else
-		uid = from_kuid(fs_userns, kuid);
-	if (uid == (uid_t)-1)
-		return INVALID_VFSUID;
+	uid = from_kuid(fs_userns, kuid);
 	return VFSUIDT_INIT_RAW(map_id_down(&idmap->uid_map, uid));
 }
 EXPORT_SYMBOL_GPL(make_vfsuid);
@@ -106,13 +80,6 @@ EXPORT_SYMBOL_GPL(make_vfsuid);
  * Take a @kgid and remap it from @fs_userns into @idmap. Use this
  * function when preparing a @kgid to be reported to userspace.
  *
- * If initial_idmapping() determines that this is not an idmapped mount
- * we can simply return @kgid unchanged.
- * If initial_idmapping() tells us that the filesystem is not mounted with an
- * idmapping we know the value of @kgid won't change when calling
- * from_kgid() so we can simply retrieve the value via __kgid_val()
- * directly.
- *
  * Return: @kgid mapped according to @idmap.
  * If @kgid has no mapping in either @idmap or @fs_userns INVALID_GID is
  * returned.
@@ -126,12 +93,7 @@ vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
 		return VFSGIDT_INIT(kgid);
 	if (idmap == &invalid_mnt_idmap)
 		return INVALID_VFSGID;
-	if (initial_idmapping(fs_userns))
-		gid = __kgid_val(kgid);
-	else
-		gid = from_kgid(fs_userns, kgid);
-	if (gid == (gid_t)-1)
-		return INVALID_VFSGID;
+	gid = from_kgid(fs_userns, kgid);
 	return VFSGIDT_INIT_RAW(map_id_down(&idmap->gid_map, gid));
 }
 EXPORT_SYMBOL_GPL(make_vfsgid);
@@ -159,8 +121,6 @@ kuid_t from_vfsuid(struct mnt_idmap *idmap,
 	uid = map_id_up(&idmap->uid_map, __vfsuid_val(vfsuid));
 	if (uid == (uid_t)-1)
 		return INVALID_UID;
-	if (initial_idmapping(fs_userns))
-		return KUIDT_INIT(uid);
 	return make_kuid(fs_userns, uid);
 }
 EXPORT_SYMBOL_GPL(from_vfsuid);
@@ -188,8 +148,6 @@ kgid_t from_vfsgid(struct mnt_idmap *idmap,
 	gid = map_id_up(&idmap->gid_map, __vfsgid_val(vfsgid));
 	if (gid == (gid_t)-1)
 		return INVALID_GID;
-	if (initial_idmapping(fs_userns))
-		return KGIDT_INIT(gid);
 	return make_kgid(fs_userns, gid);
 }
 EXPORT_SYMBOL_GPL(from_vfsgid);

-- 
2.47.2


