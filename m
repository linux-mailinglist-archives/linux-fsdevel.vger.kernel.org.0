Return-Path: <linux-fsdevel+bounces-69361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75414C77ADD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 08:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 97EDC2C953
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A342BE7DF;
	Fri, 21 Nov 2025 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgUBHAWc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE003358BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709767; cv=none; b=PVoO1XMaN0RZGtBEROEC1e6w6bvSwmAXdMPLU7PtZHp7/V5O5zyPdqK3EOvMbHqzzLLleiBA9fZAPSG3krvGYJWVUDRasizlC//6mJu5F8TqX/9tQeXbEO0ZNWG/RgiMcroAMsfwOnE9uMUHkZhM5NoplgXfYFeZl4svUw0hFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709767; c=relaxed/simple;
	bh=QU7UgbrRQWIE5jt+i0Rs5HLMeVgJ47HBJ/y0Eje87Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BvSiPK6z3DLO7tKcJ5FXxp0ujSINp+u3G7/waipPKgxXuuDXYAoiPyI0PLw3r0AuIOkWqcLOHEaZLVZ3rFeNhKdE572xYYsLNEqdVaJalAhRQ4bl245bKFBz1oCQbnA7IVdLokW2D4nUQrspNBf5ndG2JusdwqcwHatW4IS/9/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgUBHAWc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42bb288c219so1554524f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 23:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763709763; x=1764314563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qBonvU1U3ZemupKyXYNMEJLvdVev/yCBsIjnIBAPUGc=;
        b=MgUBHAWcmcbNGdST01Mn+EjPHK85Ej8jrbibhgw/MDJMxtq2TJ1jI0qNosa3JsdoUo
         J2shLOSZCgwFl1GfuiNIpE0rpCxsQZdSeXB1XwKLytQd4o/fMdji/O4O+Wys6yT4QSn1
         ow3xAuhqmUBkaZLy07eBiFEAMYefRM5EVfg/V8aVsUWyoZFZjimzqGpTzF05yiP1Mp5u
         WjK6wDopONFwhdPgdwnjsOXtDu06d6s0oSlWlddJOb1j+RwPkm21qPaUPLfiXShoSdk8
         e453Jr/qMBsbuWpga8iDraoP8ozc5P2cSjGhHiEeAgVtFDx1OHuSZxl2IMqF46ins4Xz
         T5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763709763; x=1764314563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBonvU1U3ZemupKyXYNMEJLvdVev/yCBsIjnIBAPUGc=;
        b=ntIkz47gvPkAu6xzXxnvhSIcBUDJzom8xgIVEKQ3HvGrRv0mUOuy8mOENFBWx4XulO
         kJQNPqvj6SYL8i50MK9xSUaNaIg+/Sh7HpN+iHeWvldKOpIim9EN8TVhBCS4pfjAZAsw
         dPsswyp/rbtueSq4PzARF/dQeUgCJfb9GMnAg4BcEp6frewTeAdPGg55ZVkVLU7XoJnd
         nLiytatgyBxKENues9JCZFyRKxunf+1gW6+iTu9ErRnsciOrG5elX2oychkdLNF70UMo
         bO3kT+4qoohY9+KbZSI4RBKNV7WEyXoiFiqzr0qgrpuiyYj3CptwKWnbQ6e8VHCIVGT1
         8FTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbfqk2/k6DgRMWEbVTQkazjDopGUVHGwg1Fabux+TWLbPc/fu3VvDaC+0BL29uFeAO5M8rLz83pNYgNBoc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ka8ZC3SyQJyFBYebywRKW59q4iBAiUb54SzrF/TfL5I+5bgh
	uqDi1YyZBeJivJ9jOmKOMhWFo45EsR8eiVuRWT9yDB60TjhYYEK75WSo
X-Gm-Gg: ASbGncvuU/pJGr+P0h12ZFX+qcnfnwr0pQgm6yJTpaB9x+ztDPJjig7daOqjkQeAFJC
	vI1xF0ZRFKplqbaP7+a+3jPfR6Yxs/qzw7RDd0Cx5SdckYCMXKRQ7KpUJKbtOFQPLu3jn/h5wxs
	SR+cGu+UdC0n+xpOA+ztCFVyzDaJTNCE9nPvz+9IU2bLiz330fgTbiNUSwJ4dY3WV9bdS6iHG5f
	b4TkE+hCQ9ziziN0iOFUbli8fz1xxt1BmAsKLIvPt2+lDImh4YMogjlGqr/cAWnDtv8jftYa9+t
	a73ZNXxf59iFSG4qMji+hLeRcsjiWAC+6mZ/9dFJ/5NnoHV+Ogwd6Y20N377xOInfjmi7Rxfuaz
	pf4s6qkEclVIn4zgK6bwF+re7xibbagGdADEmrBIU1ksNcqXGWOI6W6J243rIrT48re47WhU8WO
	20x4dWrUu9NYfq8nkApsu7keoWMFl5lcFsBtOCSPBL03HbzkNispUvzKTs7bc=
X-Google-Smtp-Source: AGHT+IHCa/mDVJYgIa60qmXsx8NLFXfcSCtUIzYM70iUWvyZT9ae/OaYZVKQJFWWylGnkkowy1Q1pg==
X-Received: by 2002:a05:6000:228a:b0:42b:3e60:18ba with SMTP id ffacd0b85a97d-42cc1ac9ca3mr1072320f8f.8.1763709763103;
        Thu, 20 Nov 2025 23:22:43 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34ff3sm9986431f8f.16.2025.11.20.23.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 23:22:42 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: scale opening of character devices
Date: Fri, 21 Nov 2025 08:22:37 +0100
Message-ID: <20251121072237.3230021-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

chrdev_open() always takes cdev_lock, which is only needed to synchronize
against cd_forget(). But the latter is only ever called by inode evict(),
meaning these two can never legally race. Solidify this with asserts.

More cleanups are needed here but this is enough to get the thing out of
the way.

Rationale is funny-sounding at first: opening of /dev/zero happens to be
a contention point in large-scale package building (think 100+ packages
at the same with a thread count to support it). Such a workload is not
only very fork+exec heavy, but frequently involves scripts which use the
idiom of silencing output by redirecting it to /dev/null.

A non-large-scale microbenchmark of opening /dev/null in a loop in 16
processes:
before:	2865472
after:	4011960 (+40%)

Code goes from being bottlenecked on the spinlock to being bottlenecked
on lockref.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I'll note for interested my experience with the workload at hand comes
from FreeBSD and was surprised to find /dev/null on the profile. Given
that Linux is globally serializing on it, it has to be a factor as well
in this case.

 fs/char_dev.c        | 20 +++++++++++---------
 fs/inode.c           |  2 +-
 include/linux/cdev.h |  2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index c2ddb998f3c9..dfde57cb5eed 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -374,15 +374,15 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 {
 	const struct file_operations *fops;
 	struct cdev *p;
-	struct cdev *new = NULL;
 	int ret = 0;
 
-	spin_lock(&cdev_lock);
-	p = inode->i_cdev;
+	VFS_BUG_ON_INODE(icount_read(inode) < 1, inode);
+
+	p = READ_ONCE(inode->i_cdev);
 	if (!p) {
 		struct kobject *kobj;
+		struct cdev *new;
 		int idx;
-		spin_unlock(&cdev_lock);
 		kobj = kobj_lookup(cdev_map, inode->i_rdev, &idx);
 		if (!kobj)
 			return -ENXIO;
@@ -392,19 +392,19 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 		   we dropped the lock. */
 		p = inode->i_cdev;
 		if (!p) {
-			inode->i_cdev = p = new;
+			p = new;
+			WRITE_ONCE(inode->i_cdev, p);
 			list_add(&inode->i_devices, &p->list);
 			new = NULL;
 		} else if (!cdev_get(p))
 			ret = -ENXIO;
+		spin_unlock(&cdev_lock);
+		cdev_put(new);
 	} else if (!cdev_get(p))
 		ret = -ENXIO;
-	spin_unlock(&cdev_lock);
-	cdev_put(new);
 	if (ret)
 		return ret;
 
-	ret = -ENXIO;
 	fops = fops_get(p->ops);
 	if (!fops)
 		goto out_cdev_put;
@@ -423,8 +423,10 @@ static int chrdev_open(struct inode *inode, struct file *filp)
 	return ret;
 }
 
-void cd_forget(struct inode *inode)
+void inode_cdev_forget(struct inode *inode)
 {
+	VFS_BUG_ON_INODE(!(inode_state_read_once(inode) & I_FREEING), inode);
+
 	spin_lock(&cdev_lock);
 	list_del_init(&inode->i_devices);
 	inode->i_cdev = NULL;
diff --git a/fs/inode.c b/fs/inode.c
index a62032864ddf..88be1f20782d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -840,7 +840,7 @@ static void evict(struct inode *inode)
 		clear_inode(inode);
 	}
 	if (S_ISCHR(inode->i_mode) && inode->i_cdev)
-		cd_forget(inode);
+		inode_cdev_forget(inode);
 
 	remove_inode_hash(inode);
 
diff --git a/include/linux/cdev.h b/include/linux/cdev.h
index 0e8cd6293deb..bed99967ad90 100644
--- a/include/linux/cdev.h
+++ b/include/linux/cdev.h
@@ -34,6 +34,6 @@ void cdev_device_del(struct cdev *cdev, struct device *dev);
 
 void cdev_del(struct cdev *);
 
-void cd_forget(struct inode *);
+void inode_cdev_forget(struct inode *);
 
 #endif
-- 
2.48.1


