Return-Path: <linux-fsdevel+bounces-69362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2545C77B22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 08:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F13C84E5406
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF853375A4;
	Fri, 21 Nov 2025 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLqmX3dw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995891D90DF
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710107; cv=none; b=PliT06Awzr1aB6BmQDYk+RBx1jmZ7cK1g94G4GaJCNTzQV1oyxJbtb53g4+JZrFRlij2RXOMKM4q7rqdmcMQkpD7vy2hCTia+pwZNQkhOdbsrGJFBOTTJ6EABkYbN7q3bXZOCZZRzJ0x9Z2c3VpaeQ1BBjSdt7bCtunhxmTq1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710107; c=relaxed/simple;
	bh=g2i7/R56UTTVw1U5aYaOMR7BZAoaPIzLKYPX09tjRvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZpRDJgfYmhD0x9D2P1wSjyE6oKA87yijk127jITUdwHMbXi+R53+pAv77SU9dIFtHntLPssSqbHiHEi5NVZG+u3fpURdwP6GMA64pRoIW2mElW83VZ0O3fV6haxbLz4P6pOOkJ9qbrIknZUyQasWydU7nbRLahPlQETjDf2p1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLqmX3dw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47755de027eso9519915e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 23:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763710104; x=1764314904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9BYbALvRt6Xy+A7LeU1HJSCKjZwuwVgs7ggynkH6+Y=;
        b=iLqmX3dw+4/CL/DJM3cnszcm4t3roFzakRQE6XQ5Athf5gLoh4EenosLNnSaTCGx8H
         VhJNudDQzeUSf15XaNu1dICbsFiBjGYVwoCEqVq3EqtpVhy0TqLKre+LihGO3nx3COLP
         CAZ/rL8Fh6ZJNRXpY84zqmUCrMQMyuVZE4A+vo/z9iVqPUDQv3c+rElLNFwnpXjD7ZAf
         MZMiRcJSXdcRoEWCKB2RKWuiC87jf/pQmhR95OvDNVS21KbHopaN+8pa+pgPd5HXH7WE
         dd7wscy24AlHz1G/GVKK1ey6YSKWK/ikbrNNMJtzzizINe0SH8+3c2jA1n3mM1KY0Tsz
         VbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763710104; x=1764314904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9BYbALvRt6Xy+A7LeU1HJSCKjZwuwVgs7ggynkH6+Y=;
        b=JQM/i0bYyoDfTad+VsChB8HNySBN0L588w12tqQC1Xck7VO6gwZpCTr/3s4xBl/MMV
         81Eo2lxSqO0QbWuRaWdDsekMA6BLIlaVlTiJmJdiiKqtd5Js994pIxw40+SdKN2Gw1cO
         6xVNknTUjMQqB52zfU0kgxFBnzkNWT+JRGtSVShWHasoQeH4V7aYRkmlUCABdPNAe+v1
         ybhFIGapwuUV50flRt1kSTR1ieG8ZIAn6m3fklwPIGOCwd3pG6m+cVvmwYkMi01w4V8V
         ZN79xkshTOP298JJ4FD7EvCeq4mo7JKHjUbNfAQ/1XpUTv+9vT8x7zZ2Hmc0RDIPwyz1
         wv9w==
X-Forwarded-Encrypted: i=1; AJvYcCXY60iYfiDsc2eggWy3S243kPHG4g+VXq5jZsByB51IqM/LLPInwFNcf4Wpl1X12lRXy36R0wRqi5b4IVn7@vger.kernel.org
X-Gm-Message-State: AOJu0YynCP1AbFzLU6dsnQGKO7OiOukp4IppvFA8FamUqxPIxXhpnX87
	4FHUngldGdPI69rWCaqrKkSigSrlUrhitFl4uGjbZ0ZZP6YA1itW+Cif
X-Gm-Gg: ASbGnctV+JyG15HGVgIWruIDymEUa7heft5Q+CO3GTzLqMavZctxYKEgXEj+Nt3s4FY
	XAsYAH2Y1wdTCYe94g8Y5PxnKCMGGCudzS6Xvbi1iq3cAALAaqmKGaExmjwDx5ReItMyNvvi8SX
	pAoE2DUg7zr5JeX9qzYdmK6eqHSEgGa0FQkt3CA98Ru5D8L5x82I2dFRhOAX2RmroBuSqnsY7bq
	iLYxjlg2SDKa5qJD8u2J3yVYzUAAdy//LaiTkgQ3IlWjwtCAiRiJ21VgzMUE/PlH8xpBVbODWFq
	O0OQzxEKORWWNS9Dpi+UYb5ELemKAPVusBwpJw2jnHhlF4aplO6hHjOcXigbiNqxyJIejoT/2KM
	MjWOaBwjKGMQKfBcYzOjE4BmnfKD4nWBVbmfAuUSARFLYR92+Bg3xmym3Dd0jC557hlwyRsclfP
	nTe501JoK+u1ALZ8MSvBFa3SuXKQ8Eve1sltVbJ74Xza38zvE+KQeunVb5XD0=
X-Google-Smtp-Source: AGHT+IEImYE9q0tBVy5yyzYaN4QGnkFSvX0iXlmg7xc7ci3f9g+U3un/GHZg4Q+0VmEhxh45VWZBVA==
X-Received: by 2002:a05:600c:4f48:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-477c01e02e5mr11388795e9.28.1763710103890;
        Thu, 20 Nov 2025 23:28:23 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3b4fafsm28868915e9.14.2025.11.20.23.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 23:28:23 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: scale opening of character devices
Date: Fri, 21 Nov 2025 08:28:18 +0100
Message-ID: <20251121072818.3230541-1-mjguzik@gmail.com>
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

v2:
- add back new = NULL lost in refactoring

I'll note for interested my experience with the workload at hand comes
from FreeBSD and was surprised to find /dev/null on the profile. Given
that Linux is globally serializing on it, it has to be a factor as well
in this case.

 fs/char_dev.c        | 20 +++++++++++---------
 fs/inode.c           |  2 +-
 include/linux/cdev.h |  2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index c2ddb998f3c9..9a6dfab084d1 100644
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
+		struct cdev *new = NULL;
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


