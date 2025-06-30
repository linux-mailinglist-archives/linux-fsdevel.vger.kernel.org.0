Return-Path: <linux-fsdevel+bounces-53383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB3BAEE43D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440981630A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A1292B3E;
	Mon, 30 Jun 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxywBWBi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C2290BA5
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300439; cv=none; b=C8tc2Of+2UiSJSTaRmVTS/cKPU72W8+n2THQ6UIfWLzicmeWSPAPOyPts7qrsd6cG0cTZNlLmpsAFklw8eJ67OUs2JVPuGgx+YFDzXNJsXyHOE3SGCCsRyy7STPyDSByXoIrxiToY9mRaXgHuMjHqBVPf3VaVpJe4VVHI+5DBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300439; c=relaxed/simple;
	bh=bO/jpswV1LWNhjalyWMDjdR/z42wKAwo8hIHFNHoxHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWApRDQMl1o5fTesqczbgPloyPLGZWOfFdTOdltqqH24NFD2Qv0hVV2CxRvqZv0joyGt20M2tcwENxEHST3MGNDm1DaOrJHM1Pe24Bgd3XA82RAmd4YPp0X6D0eYE2x5IAWWElW39z9s0VvZojXi6D0vjj290Q3tF238De8Xu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxywBWBi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751300436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/ldgdzsRv8e0UT+Jrv0yb/WEFGbntMvFcer/+29UGk=;
	b=PxywBWBiHerhAyKg+rmzOXJ699aWGxVmwSikMpQ3UdK1caX2gG4QmxMqwdQqHMtQ6u3q28
	BC1ssB1+f7tvFCvMedqG3fOCFB0glG3Q/1EDsdJcvburVKz/X/nwG/DqktLzKenAlY6TtN
	wEe35sUlXxi1FHZxUnwXdJb/jC90z/g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-3pFxaKHWO-mjgqn9q9yUQA-1; Mon, 30 Jun 2025 12:20:34 -0400
X-MC-Unique: 3pFxaKHWO-mjgqn9q9yUQA-1
X-Mimecast-MFC-AGG-ID: 3pFxaKHWO-mjgqn9q9yUQA_1751300433
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so22328565e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300433; x=1751905233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/ldgdzsRv8e0UT+Jrv0yb/WEFGbntMvFcer/+29UGk=;
        b=cys6RmWjvjIPc1tE6yY0z47ATfSIXRnR4+MQHT6iP6u8eY4Kzkcmq4lHKTMAszg965
         rr/JNaAnGTFxtok9RCNQQ0+PNiECLdc+9CZx9hEH8WbTOC7ws7qTk2sLXUxhW3eF3Vir
         3Y0UEge4lZhmhRjWu+TRQZeraqiCylJwvSwmMpJEv4z9Jt06gtSfMo+T91Ir7mcSkmt8
         17fm4g53yVi9zfw1oIhJInm3pHmI7I3Vf6AwqWboyoLyCjqENNdoUBuj3AWSHGQeGsmW
         PxXlc3zEI4mVKgWSKb3V2E5TS7lgIAK8L6uTtmErxct07d9mCMZ53ejG6xZJdkX7cdjN
         WWwg==
X-Forwarded-Encrypted: i=1; AJvYcCVPhJuFCiFc3BnLUTe+V8zeHxxTo9ZsHVUudMdi8OKYuFgCij3RDg4Fnbqmvsr003lwo3lMEoAx6VOkZ1E9@vger.kernel.org
X-Gm-Message-State: AOJu0YwoGFYRBl1VAJFDib1SRAUSL/3lm3zYPrVQZSZfImeOY/P/VcN+
	cuHc0F1gzvJELAWT+Uo6swzWvtVYzIge8S6t8L5YrfBzcIdUBj3ftTyPMa+u/Yr9jVZ1IL7ca+v
	YGaq3MKYdcxCLLlmQSfs+Kh4e5d49QStWAw9q5oNfYLABVL1sGtb1eKP1q4qt2qM4dg==
X-Gm-Gg: ASbGncuM6MCdKiLTJPLCdHVUfSZtbGF2uwHU2OcucJCpTaC4F8NFd0AQZ1j6g4mCDs1
	6RNi7vmWaQFY17QyS37CVvkqlfozalcgi57J+VpWok2Yqhey/Vfu3gTowgPFVAzv9klvPq6sbvl
	ZYLIp4V/J6aNzK45VO/W93CbO2XZ0c6QFSoDACe/p/xFztkCZ6B7WWGIfeSrq0zNCOiWSm+GROJ
	c8GOKQuo6tXsuYr3IBwsVX7ZLE0yxpCODkzMfl8PAd/Ez/rE7RvkSmIOyw6YfKprtK/2dIiNhGH
	Fpq58DuolEl9jAfhZSCNEB8/D8Ym
X-Received: by 2002:a05:600c:458b:b0:450:b9c0:c7d2 with SMTP id 5b1f17b1804b1-45391b6b96dmr112684345e9.11.1751300433124;
        Mon, 30 Jun 2025 09:20:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFduavveB4cdYSeQ2qocLMKSrImBMaC6aj6NuX+uihLHHyN/rjbOwaD5qNXSxUq7WLZl2/mug==
X-Received: by 2002:a05:600c:458b:b0:450:b9c0:c7d2 with SMTP id 5b1f17b1804b1-45391b6b96dmr112684075e9.11.1751300432717;
        Mon, 30 Jun 2025 09:20:32 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm168769245e9.3.2025.06.30.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:20:29 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 30 Jun 2025 18:20:12 +0200
Subject: [PATCH v6 2/6] lsm: introduce new hooks for setting/getting inode
 fsxattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-xattrat-syscall-v6-2-c4e3bc35227b@kernel.org>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
In-Reply-To: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Casey Schaufler <casey@schaufler-ca.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5238; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=bO/jpswV1LWNhjalyWMDjdR/z42wKAwo8hIHFNHoxHc=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpJ2ev2XWlBSZ1NT29LbkmzeYMpctqZpt8v5pdwnD
 coswzK/b+ooZWEQ42KQFVNkWSetNTWpSCr/iEGNPMwcViaQIQxcnAIwkX2zGP5wFThm6IgLsXdV
 /tpyS4eJUcfv1pbw5zrMD884LNDjf2LJyNAdtarms/SlmIr7p/6vnKwRF9nfmmrtkis1Y3v8UtZ
 duqwAYNREEw==
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Introduce new hooks for setting and getting filesystem extended
attributes on inode (FS_IOC_FSGETXATTR).

Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c                | 19 ++++++++++++++++---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 16 ++++++++++++++++
 security/security.c           | 30 ++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 2910b7047721..be62d97cc444 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -76,10 +76,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
 int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
+	int error;
 
 	if (!inode->i_op->fileattr_get)
 		return -ENOIOCTLCMD;
 
+	error = security_inode_file_getattr(dentry, fa);
+	if (error)
+		return error;
+
 	return inode->i_op->fileattr_get(dentry, fa);
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
@@ -242,12 +247,20 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		} else {
 			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
 		}
+
 		err = fileattr_set_prepare(inode, &old_ma, fa);
-		if (!err)
-			err = inode->i_op->fileattr_set(idmap, dentry, fa);
+		if (err)
+			goto out;
+		err = security_inode_file_setattr(dentry, fa);
+		if (err)
+			goto out;
+		err = inode->i_op->fileattr_set(idmap, dentry, fa);
+		if (err)
+			goto out;
 	}
+
+out:
 	inode_unlock(inode);
-
 	return err;
 }
 EXPORT_SYMBOL(vfs_fileattr_set);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..9600a4350e79 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -157,6 +157,8 @@ LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
 	 const char *name)
+LSM_HOOK(int, 0, inode_file_setattr, struct dentry *dentry, struct fileattr *fa)
+LSM_HOOK(int, 0, inode_file_getattr, struct dentry *dentry, struct fileattr *fa)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
diff --git a/include/linux/security.h b/include/linux/security.h
index dba349629229..9ed0d0e0c81f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -451,6 +451,10 @@ int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name);
 void security_inode_post_removexattr(struct dentry *dentry, const char *name);
+int security_inode_file_setattr(struct dentry *dentry,
+			      struct fileattr *fa);
+int security_inode_file_getattr(struct dentry *dentry,
+			      struct fileattr *fa);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
@@ -1052,6 +1056,18 @@ static inline void security_inode_post_removexattr(struct dentry *dentry,
 						   const char *name)
 { }
 
+static inline int security_inode_file_setattr(struct dentry *dentry,
+					      struct fileattr *fa)
+{
+	return 0;
+}
+
+static inline int security_inode_file_getattr(struct dentry *dentry,
+					      struct fileattr *fa)
+{
+	return 0;
+}
+
 static inline int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return cap_inode_need_killpriv(dentry);
diff --git a/security/security.c b/security/security.c
index 596d41818577..711b4de40b8d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2622,6 +2622,36 @@ void security_inode_post_removexattr(struct dentry *dentry, const char *name)
 	call_void_hook(inode_post_removexattr, dentry, name);
 }
 
+/**
+ * security_inode_file_setattr() - check if setting fsxattr is allowed
+ * @dentry: file to set filesystem extended attributes on
+ * @fa: extended attributes to set on the inode
+ *
+ * Called when file_setattr() syscall or FS_IOC_FSSETXATTR ioctl() is called on
+ * inode
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_file_setattr(struct dentry *dentry, struct fileattr *fa)
+{
+	return call_int_hook(inode_file_setattr, dentry, fa);
+}
+
+/**
+ * security_inode_file_getattr() - check if retrieving fsxattr is allowed
+ * @dentry: file to retrieve filesystem extended attributes from
+ * @fa: extended attributes to get
+ *
+ * Called when file_getattr() syscall or FS_IOC_FSGETXATTR ioctl() is called on
+ * inode
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_file_getattr(struct dentry *dentry, struct fileattr *fa)
+{
+	return call_int_hook(inode_file_getattr, dentry, fa);
+}
+
 /**
  * security_inode_need_killpriv() - Check if security_inode_killpriv() required
  * @dentry: associated dentry

-- 
2.47.2


