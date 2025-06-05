Return-Path: <linux-fsdevel+bounces-50718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0518ACED5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5C7189683B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0A62066CE;
	Thu,  5 Jun 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4/M2ByE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E68F6E
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749118538; cv=none; b=VuOurEMEOAhCDXj+3XN/hxBNH6rHvjJZpSBidhmTkiT3mR2AJpXOL8xoAQynFgPv0lJN5pmly32OhOG6F2t2Sx9TlfWfB3xM40s9YoSuKq3rok+ZKoh06HtCcqBNZgUhbvXaR5UcW/Xgf0yacrzL9Nfdr2ba16etyytXELC109M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749118538; c=relaxed/simple;
	bh=bQeCVOkF32YQYoflaUXUSKWOSUx/i2p1LYZNWtX4PAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IWd1PyLb7OotbanXWgzpwXedlRjsTfFIRMiW/xgmM3hyPE4M1E/p6ekRZzzyW0DQEsqHD4ZbA9sUnUP55yPSfhBYNESDh71vJhQiKLlsHpYOqqczh85iD+MV7evz3xYd0Uh4uZ+MVhbte68pLeYog9SyHK4833ZYdz/nFgFskvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4/M2ByE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adb5fd85996so157596966b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749118535; x=1749723335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n98VpYFqy0lVVkwliMwDoaIMs+SO1kDqH/egJWgGh1E=;
        b=M4/M2ByEwR/WsUHVj12mwnGVx0bnfY6+8rQWE/YZWMG3WzuCy2p5KM5+/m4s2ynWel
         ofrI89wXp/Y16B4TUxGBJABfdV7BKaBXs5fPkb0zmyQ41m7FjEykJ1xv+EvcAM/PBPs/
         4L+BdvTmc/zitcAnM2tOEvpm95e4aZj2bEErOd81s6HO+7bmVyZJRZ0YrHddBs5Eyb5D
         1jGLpPfqlH2Uw3Ltyr1kVIsM6zzatSkTfUPL53ccTYRzJc9RVKG/jOihRpgmHCX3IO4p
         HFwmCONY8O0OpAXZSRDJ9HvjzdCjWenByKuBqtJ2TnvU6Bv+BVNab1KMTRyZ2YR4a0pe
         LDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749118535; x=1749723335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n98VpYFqy0lVVkwliMwDoaIMs+SO1kDqH/egJWgGh1E=;
        b=UtgOKb3o9U/vE8gc3c10xZ1yvGAqHHCIdTpBdrYbZ777B+1ILT2/6bEriasq8XYJd7
         VwsOpP22Xs/ybK+B1WfAvh/a2IGzY6TVASj7fE97vWaY0zs3WuwqgMOB8fDSWAYWOqk+
         SJnhNq5uRxi2YZWt7p0bIZFyjn+QhQzb/NwGBJbq0n6VlvAMXFVzOCKX371lzh6hIWpi
         bkP4jkk93eAIVLdEfexxnpo7KZ/hch9o6i/neyZqZ1cQaZOkcLf294bMRzi0Wb68oGCN
         7MBPQLfiRMvnNcdUdrjYJb3TYsenbuFDtl1tgfMVqy8GYAlo5sv2j/Gvn3tD5MB9paPH
         LW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWC33G7pPnhhc84apHkv66FXnEsesG+84BCw0yoV4u8fe0gUzRMBrWT+9uG/LzgN5/mwDZDKPyuy9bu8uxi@vger.kernel.org
X-Gm-Message-State: AOJu0YyrqF7bkoBon0mgN77DQDeJiKvhfIgYQd9PhbcS4CYDsriWHipv
	4qpJ3JQMwot8lFuH4HHse3Emg8PTD8TzzYfmONUqh9/w4ADnOqE8MQhV
X-Gm-Gg: ASbGncsaRvp0HfKVuopybhXCKm7dmaInpaSrjcIMW6q8EYVFbCs1gJU485oLDy9Qewv
	Hkcs6pKqN+Sr0JOLKNSPfDMVKyo948nUY31ch7AWviOXFu1Gd4pk0khSLj6IQkMuoNjSdVpukSf
	kH3L9Oq/mTVOU3+bAZ0oGlFKYDObcVDZBWl9aEWBbSx/qcBu230nwXLs7aJwz2YLk71kWTa7I2b
	20v7Ga5I2HjK+olRE11re7gHxKiG4CjLbL/gnvCKLyIfwiWp1GVy1vhhiQGHV9D657P58lBrgkA
	uNBiGFNXtCeoDBksRZaHHXlM2aXo6fuVDES2tQrv5THGhGF4YJG7/YJRuZXmtWCasJKGkPmm7M3
	IxUPzvWwPFXu48kX5Tax3QGU6YAjgPpfDBwFFo5HyIyrs78ZdDA6Nu4bykcI=
X-Google-Smtp-Source: AGHT+IE89kjPsCBmJCUtde4SjZ7RTg/l2m9iX6NkHDI5xnRcf24xlpHI2GW+0dThSnOVweQKqCzBVg==
X-Received: by 2002:a17:907:a089:b0:ad8:e477:970c with SMTP id a640c23a62f3a-addf8d1dbe4mr586002466b.23.1749118534314;
        Thu, 05 Jun 2025 03:15:34 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6aaf5sm1230837166b.183.2025.06.05.03.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:15:33 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	NeilBrown <neilb@suse.de>
Subject: [PATCH] ovl: fix regression caused for lookup helpers API changes
Date: Thu,  5 Jun 2025 12:15:30 +0200
Message-Id: <20250605101530.2336320-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lookup helpers API was changed by merge of vfs-6.16-rc1.async.dir to
pass a non-const qstr pointer argument to lookup_one*() helpers.

All of the callers of this API were changed to pass a pointer to temp
copy of qstr, except overlays that was passing a const pointer to
dentry->d_name that was changed to pass a non-const copy instead
when doing a lookup in lower layer which is not the fs of said dentry.

This wrong use of the API caused a regression in fstest overlay/012.

Fix the regression by making a non-const copy of dentry->d_name prior
to calling the lookup API, but the API should be fixed to not allow this
class of bugs.

Cc: NeilBrown <neilb@suse.de>
Fixes: 5741909697a3 ("VFS: improve interface for lookup_one functions")
Fixes: 390e34bc1490 ("VFS: change lookup_one_common and lookup_noperm_common to take a qstr")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/namei.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

Christian,

Please fast track this fix to Linus before 6.16-rc1 and
consider how you would like to fix the lookup_one*() API.

This change is independent of the ovl changes staged on overlayfs-next,
which I am assuming Miklos is going to send to Linus.

Thanks,
Amir.

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index bf722daf19a9..00979555223d 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1371,7 +1371,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 bool ovl_lower_positive(struct dentry *dentry)
 {
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
-	struct qstr *name = &dentry->d_name;
+	const struct qstr *name = &dentry->d_name;
 	const struct cred *old_cred;
 	unsigned int i;
 	bool positive = false;
@@ -1394,9 +1394,16 @@ bool ovl_lower_positive(struct dentry *dentry)
 		struct dentry *this;
 		struct ovl_path *parentpath = &ovl_lowerstack(poe)[i];
 
+		/*
+		 * We need to make a non-const copy of dentry->d_name,
+		 * becuase lookup_one_positive_unlocked() will hash name
+		 * with parentpath base, which is on another (lwoer fs).
+		 * TODO: the lookup_* API should be changed not to allow this.
+		 */
 		this = lookup_one_positive_unlocked(
 				mnt_idmap(parentpath->layer->mnt),
-				name, parentpath->dentry);
+				&QSTR_LEN(name->name, name->len),
+				parentpath->dentry);
 		if (IS_ERR(this)) {
 			switch (PTR_ERR(this)) {
 			case -ENOENT:
-- 
2.34.1


