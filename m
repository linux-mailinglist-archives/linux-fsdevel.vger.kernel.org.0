Return-Path: <linux-fsdevel+bounces-57801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1138BB256C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887443B3927
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 22:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193DF2F28EE;
	Wed, 13 Aug 2025 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Xxxa+0cG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD606302744;
	Wed, 13 Aug 2025 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124648; cv=none; b=j7m1m1IMsi8aMosCtoy4eYWKgBz5rpdGIGFb3H3DTGCS1XL7iG8NdMhRzU95KaFU/gekxwPNmpkJAWQesIcbNF7DNrcS3kP1EVQt6dYeNn8pKDxLBrKw18a0oX+MMl6jvWPZ8yxc6FVu8ccwK6q6r+cFZwWgZvT3GvrXcSwtS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124648; c=relaxed/simple;
	bh=qB84Oe9/0kM8Wpl78BU3Rii6T4df6I3ewolZDZdUFVU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hq3quQvCnclxxe0R7zcxZXrX9uh1MMgUAd7ccQ9VduTqHFb58uRdODzk3yR4gnqns3/uJI6zAXxtlXC1WkeRW/b26ujJZFOJPW8y7kaDi/LpaO6ihlgz9cq/orcWAVkiW/4FX4W2aRF19lxuB+PDwgxVQzKE+xXcg7vjYl2cD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Xxxa+0cG; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lZkvLWWCVq0OqDqLW+/6y5gYne0ck0FIKVPelCjVDRU=; b=Xxxa+0cGNlkaXkZ6ER2DiVFwCA
	vGSXmjir3wkGhOgdhzWF1EEpk0MXDdVK6M7Kqu1gT9YDnVPvRH/5dCFUecnHPwXXmQD2D0U3C3dam
	jF8TdhYQHFBAfoO2FbPd12B8BvhP0ncd5diaMEGmsQTk6eHKWV1jX0vkx368fFXAzWkL06ZR6llyB
	i6Fla21hlhh17wo1es67IPag11K9zaVsZtD2GHerf2Vg0QFXD9UoRFQS70e7bl0cj858BtJ5gri7Q
	4Tq8mHcyYVsdtsj5JMamCcPOv9S6bGedfuIJj9+YOKKaC9fQmZjd0Pj32KzMAoSwpGenNLFOnlwLf
	qhREJLKg==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1umK5u-00Ds0c-Pl; Thu, 14 Aug 2025 00:37:18 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 0/9] ovl: Enable support for casefold filesystems
Date: Wed, 13 Aug 2025 19:36:36 -0300
Message-Id: <20250813-tonyk-overlayfs-v4-0-357ccf2e12ad@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHQTnWgC/3XOSw6CMBCA4auQrq3pE1tX3sO4KDCFRqSmJY2Ec
 HcLGzXE5T/JfDMzihAcRHQuZhQguej8kEMcClR3ZmgBuyY3YoRJIojGox+mO/YJQm8mG7HU1Eo
 QjSAng/LWM4B1r0283nJ3Lo4+TNuBRNfpfytRTDDXmpa0tKANv7jW9M4ca/9AK5bYB1BE7gGWA
 QJSMEUbw6naAfwbUHuArx8QqysQrKzML7AsyxuSE6QiMQEAAA==
X-Change-ID: 20250409-tonyk-overlayfs-591f5e4d407a
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Hi all,

We would like to support the usage of casefold filesystems with
overlayfs to be used with container tools. This use case requires a
simple setup, where every layer will have the same encoding setting
(i.e. Unicode version and flags), using one upper and one lower layer.

* Implementation

When merge layers, ovl uses a red-black tree to check if a given dentry
name from a lower layers already exists in the upper layer. For merging
case-insensitive names, we need to store then in tree casefolded.
However, when displaying to the user the dentry name, we need to respect
the name chosen when the file was created (e.g. Picture.PNG, instead of
picture.png). To achieve this, I create a new field for cache entries
that stores the casefolded names and a function ovl_strcmp() that uses
this name for searching the rb_tree. For composing the layer, ovl uses
the original name, keeping it consistency with whatever name the user
created.

The rest of the patches are mostly for checking if casefold is being
consistently used across the layers and dropping the mount restrictions
that prevented case-insensitive filesystems to be mounted.

Thanks for the feedback!

---
Changes in v4:
- Split patch "ovl: Support case-insensitive lookup" and move patch that
  creates ofs->casefold to the begging of the series
- Merge patch "Store casefold name..." and "Create ovl_casefold()..."
- Make encoding restrictions apply just when casefold is enabled
- Rework set_d_op() with new helper
- Set encoding and encoding flags inside of ovl_get_layers()
- Rework how inode flags are set and checked
v3: https://lore.kernel.org/r/20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com

Changes in v3:
- Rebased on top of vfs-6.18.misc branch
- Added more guards for casefolding things inside of IS_ENABLED(UNICODE)
- Refactor the strncmp() patch to do a single kmalloc() per rb_tree operation
- Instead of casefolding the cache entry name everytime per strncmp(),
  casefold it once and reuse it for every strncmp().
- Created ovl_dentry_ci_operations to not override dentry ops set by
  ovl_dentry_operations
- Instead of setting encoding just when there's a upper layer, set it
  for any first layer (ofs->fs[0].sb), regardless of it being upper or
  not.
- Rewrote the patch that set inode flags
- Check if every dentry is consistent with the root dentry regarding
  casefold
v2: https://lore.kernel.org/r/20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com

Changes in v2:
- Almost a full rewritten from the v1.
v1: https://lore.kernel.org/lkml/20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com/

---
André Almeida (9):
      ovl: Support mounting case-insensitive enabled filesystems
      fs: Create new helper sb_encoding()
      ovl: Create ovl_casefold() to support casefolded strncmp()
      fs: Create sb_same_encoding() helper
      ovl: Ensure that all layers have the same encoding
      ovl: Set case-insensitive dentry operations for ovl sb
      ovl: Add S_CASEFOLD as part of the inode flag to be copied
      ovl: Check for casefold consistency when creating new dentries
      ovl: Allow case-insensitive lookup

 fs/overlayfs/copy_up.c   |  2 +-
 fs/overlayfs/dir.c       |  5 +++
 fs/overlayfs/inode.c     |  1 +
 fs/overlayfs/namei.c     | 17 +++++----
 fs/overlayfs/overlayfs.h |  8 ++--
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/params.c    | 15 ++++++--
 fs/overlayfs/params.h    |  1 +
 fs/overlayfs/readdir.c   | 99 ++++++++++++++++++++++++++++++++++++++++++------
 fs/overlayfs/super.c     | 51 +++++++++++++++++++++++++
 fs/overlayfs/util.c      |  8 ++--
 include/linux/fs.h       | 27 ++++++++++++-
 12 files changed, 202 insertions(+), 33 deletions(-)
---
base-commit: 7aef10fd5ca1726315dc387448924b9e3e417e8e
change-id: 20250409-tonyk-overlayfs-591f5e4d407a

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


