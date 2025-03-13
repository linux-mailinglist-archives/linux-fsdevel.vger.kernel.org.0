Return-Path: <linux-fsdevel+bounces-43902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C61A5F81A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1516E161604
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7A5267F55;
	Thu, 13 Mar 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZr0fHek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E342267393;
	Thu, 13 Mar 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876079; cv=none; b=Tedp4PiGSKRJQUwWBOPbKzvIKpmbNM8U0u0WKge1ITEqu29NC9N7Z7ewGv99BZE4xNkom7kjKzM90wW7IFpo187q7v5uqecwW11l1g7PLAtiDjJYWLhoKNLWWKS4T/lWhu81s0LfwS3K6j/zc6H3Nkx3I3tiAuH5lm2+TpADHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876079; c=relaxed/simple;
	bh=gxg+0lDzP4WW6H+ac5tKgySrv/5xRkMqt16F5FhafeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssj/HYqDW4kvh8+IXlMghJ/Fn2tuMAWmXganwbTf9i5xBaPOcErCs5S+tUvOcdJUNtfqGwPnwAjlTmu2y5PEprO8PJn/wteXSu9KveU8+fShUd3RZefjHORCM8al3FJBAgi4CH6UDqJwXYp+zAjEtfhK6gpmxV5WH8KoOSebnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZr0fHek; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso218849466b.0;
        Thu, 13 Mar 2025 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876076; x=1742480876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNUKO0Et5yT84TqbQgeEjeVZKHHspqia0B9fx6XJNnc=;
        b=eZr0fHekS6ldgQw+cL8QKHjo/Ymdi7o/ER6+LOU9NwPliiskKSRzF3xi98FzaNVzKe
         bAx0WWOZz/JzPuB1Qb39rlRO11fcHVxvlkyKBBcocxZ5GChafqs/DZMAKMevyHl2CEtF
         tgElWXF0h4DcJrcVAWyesTqTkrqyFiJBXj218+n8UiRf0BVSdvPp/By/Qs5i/ZchxUZ6
         yAQpyjYDDr6TFdYnBbAvdCV+//BGq6ed+LAFxYiqkUyUqn8pR32WSMt5jGdDPOFm9l3k
         Qs2eyOZR6R4cm56jmox4Ax7B9z7xbCOTaJemOvcQU+LEE/lmDiB7XFTBxUcDaAMPnNEE
         LKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876076; x=1742480876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNUKO0Et5yT84TqbQgeEjeVZKHHspqia0B9fx6XJNnc=;
        b=TAUR3y+U0c/oToHWyKt6ReE72luVpxqlsVPt93bKuySNoZ+fIuWFVKS+KOOABe4dkL
         UFXlGBGkEFDjyVhvu7w6BLpPERl5usPcN4B9WXvJmBL4xjhxgpSU2dnfGa4l4/ll+Ese
         BrC7z2o6J9sqm6YSYLak8uG4CJ4wEDM7NnijQOs6noYmriFmAqBCyhwHkMZBxqbT53v7
         VvwbWuo+ZqtK4GWEcXzOdIQmQogGfXILlLr8fZUSQy3k4P6VAUFn1RMbjAVI8C1ZwPvF
         lcnhn+TF+depoFLpJbLcwlQTpUuk3Eb719N6De1mjqlEDdThFOhKgrikOFALfs390HjZ
         +Gdw==
X-Forwarded-Encrypted: i=1; AJvYcCUnpfKhxlzWA4WhGVSBjIdk+hTEHtKNoiqsMKbsF5GcGRG52J47tN7Vdyq7Qce1mwH1XGjTkNvO2bEDCu21@vger.kernel.org, AJvYcCVn+/4CGGltreEHPCpgGStdvXV1Hh9lm/+SML2MXJY5tX9mVZk6aL6XeoyTTIexDLITSU+xl4X2LKRpmCjz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7T102YWXQPDzsULWZ2wogC3azTSuXr5/BQ9poVj92HBzzkvlZ
	6b77h6ks8RVlEF9iwHocPdUNlBaYeMfntW5ZDl8YcPzHBe1dzp7J
X-Gm-Gg: ASbGncuIfEGa36eBRbwB0fuAH7Qi4RnwyjLErCvtBAWDqzLykNyxB7gA70Zyj/0Ncqq
	QhOIzUqUiCiR9e7UXVOQ49sk3SfZKO4KhJAWx89ELkqPuVOoVmGJ+JUG6mB1uFkF8xwZQmIT28g
	dBqq/xBcFJC2Wb6uZ0uez8TxfYXUKKa7vAJddN+FhpySQU1pw7D/1dr/SjQ3kmBFfjjzBygjF1f
	ct70YXfTnHghRk7cwB5aOl0OCGtBH0sUHmKlXca0RRiCSHdKJCyW7Pn5EML8nzT65SFGvYd2zEG
	csJExC/ukKDZP95QT7o6aA7I3KYq0Vzad/2NwDu4ZC3yWtSVx8H57c6DrFv2XXc=
X-Google-Smtp-Source: AGHT+IEVZmpHLZrjcMQPf6kMwb6oK78NasXzqSzxf7wU1VF0VoUZxabsmjus6/LDL9zjOhY19483+A==
X-Received: by 2002:a17:907:1b16:b0:ac1:fa6f:4941 with SMTP id a640c23a62f3a-ac252a9d6a0mr3352723966b.13.1741876075535;
        Thu, 13 Mar 2025 07:27:55 -0700 (PDT)
Received: from f.. (cst-prg-90-242.cust.vodafone.cz. [46.135.90.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aefadsm86411066b.8.2025.03.13.07.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:27:54 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: dedup handling of struct filename init and refcounts bumps
Date: Thu, 13 Mar 2025 15:27:44 +0100
Message-ID: <20250313142744.1323281-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This is extracted from the patch which tried to introduce optional
non-atomic operation.

I think this is an ok cleanup, but I'm not going to argue about it.

ultimately this is a big NOP

 fs/namei.c         | 17 +++++++++--------
 include/linux/fs.h |  6 ++++++
 kernel/auditsc.c   | 12 +++++-------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 06765d320e7e..699158c325bf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -125,6 +125,13 @@
 
 #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
 
+static inline void initname(struct filename *name)
+{
+	name->uptr = NULL;
+	name->aname = NULL;
+	atomic_set(&name->refcnt, 1);
+}
+
 struct filename *
 getname_flags(const char __user *filename, int flags)
 {
@@ -203,10 +210,7 @@ getname_flags(const char __user *filename, int flags)
 			return ERR_PTR(-ENAMETOOLONG);
 		}
 	}
-
-	atomic_set(&result->refcnt, 1);
-	result->uptr = filename;
-	result->aname = NULL;
+	initname(result);
 	audit_getname(result);
 	return result;
 }
@@ -264,11 +268,8 @@ struct filename *getname_kernel(const char * filename)
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 	memcpy((char *)result->name, filename, len);
-	result->uptr = NULL;
-	result->aname = NULL;
-	atomic_set(&result->refcnt, 1);
+	initname(result);
 	audit_getname(result);
-
 	return result;
 }
 EXPORT_SYMBOL(getname_kernel);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 62440a9383dc..016b0fe1536e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2865,6 +2865,12 @@ static inline struct filename *getname_maybe_null(const char __user *name, int f
 extern void putname(struct filename *name);
 DEFINE_FREE(putname, struct filename *, if (!IS_ERR_OR_NULL(_T)) putname(_T))
 
+static inline struct filename *refname(struct filename *name)
+{
+	atomic_inc(&name->refcnt);
+	return name;
+}
+
 extern int finish_open(struct file *file, struct dentry *dentry,
 			int (*open)(struct inode *, struct file *));
 extern int finish_no_open(struct file *file, struct dentry *dentry);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 9c853cde9abe..78fd876a5473 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2207,10 +2207,8 @@ __audit_reusename(const __user char *uptr)
 	list_for_each_entry(n, &context->names_list, list) {
 		if (!n->name)
 			continue;
-		if (n->name->uptr == uptr) {
-			atomic_inc(&n->name->refcnt);
-			return n->name;
-		}
+		if (n->name->uptr == uptr)
+			return refname(n->name);
 	}
 	return NULL;
 }
@@ -2237,7 +2235,7 @@ void __audit_getname(struct filename *name)
 	n->name = name;
 	n->name_len = AUDIT_NAME_FULL;
 	name->aname = n;
-	atomic_inc(&name->refcnt);
+	refname(name);
 }
 
 static inline int audit_copy_fcaps(struct audit_names *name,
@@ -2369,7 +2367,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 		return;
 	if (name) {
 		n->name = name;
-		atomic_inc(&name->refcnt);
+		refname(name);
 	}
 
 out:
@@ -2496,7 +2494,7 @@ void __audit_inode_child(struct inode *parent,
 		if (found_parent) {
 			found_child->name = found_parent->name;
 			found_child->name_len = AUDIT_NAME_FULL;
-			atomic_inc(&found_child->name->refcnt);
+			refname(found_child->name);
 		}
 	}
 
-- 
2.43.0


