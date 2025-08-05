Return-Path: <linux-fsdevel+bounces-56713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247C0B1ACE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A4917EF86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 03:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18C61EF363;
	Tue,  5 Aug 2025 03:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cg121kSb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328BE72615;
	Tue,  5 Aug 2025 03:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754365711; cv=none; b=CbjSVVHr4VRCp0pQrocGNTtQhvWG6+MYC3y48rVQd1UrlH3Ny85LW109b9AS5pHo2r+T5gsEGBXMmEuNqj4KlhTd4monCfApS/SwJztDnjck6H0RYRcJf2+Df32CY+LiT7cOlHvxgdlsmFSdMGexbM8ILkKtImU2HiaeJFptwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754365711; c=relaxed/simple;
	bh=2NYG8G2h5AQQlHz2qPx5CzpuSIMUYeDTyFMImmoO7UA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CkFCE8F/HbFdvVjiRdc7S6HkoCYalKo4NffW6B+KvH48vALEb/dt9lk5Apky3Q1hWe1y7MfkCxWcQj8EKWH877GrPUbKJGKuvHMUR3PC1uXksEU2uQIceTqaH3tGnKNrQC+L1foRfPgjeMSuVSOXVRoUcst6HLEFLCGhgNXUm+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cg121kSb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PUdM4E1mQH13KKw+cr4oA8dVQ/P7q9l6p3ARqB/UHdU=; b=cg121kSbJksjOxfX9P3HAtlqH0
	RYTeauJh7VjKt4cdzWXRygLqUEUYVHLxYzkBUiw2HnuFuAy84EbV9lZLFRbcQTaKPpG0A6hDmuTRN
	3g95hH2yEI/gxqvBAdHM30vbP2dXaVMCBI4Cmn1av/RH7Gx7xs3a9BjHnw02fVeYExEKFyE8cfaK8
	ZhrOXhKil1+76VRL9B/HN7PWaOd9dEIoM1kD9ntj72q7jgE7Ew+wCmOHVcRalguIU+n48lOFqrn98
	nzrQwl8hPV0r5DNbsN6EYyHqzXXJnu+3aIaPRwFi4BqnUun60qHAKwEMFlzxmn+fS4wiO/JH+WXpQ
	hbarEVzw==;
Received: from [191.204.199.202] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uj838-009TiJ-Dp; Tue, 05 Aug 2025 05:09:14 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH RFC v2 0/8] ovl: Enable support for casefold filesystems
Date: Tue, 05 Aug 2025 00:09:04 -0300
Message-Id: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANB1kWgC/3WNzQrCMBCEX6Xs2UjSP4knQfABvEoPS7tpF9tEk
 hIsJe9u6N3jN8N8s0MgzxTgWuzgKXJgZzOUpwL6Ce1IgofMUMqykbXUYnV2ewsXyc+4mSAarUx
 D9VDLC0JefTwZ/h7GFzwfd+hyOHFYnd+Ol6iO6q8wKiFFpbVqVWtIY3XjEWfGc+8W6FJKPypXW
 si0AAAA
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
Changes in v2:
- Almost a full rewritten from the v1.
v1: https://lore.kernel.org/lkml/20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com/

---
André Almeida (8):
      olv: Store casefold name for case-insentive dentries
      ovl: Create ovl_strcmp() with casefold support
      fs: Create sb_same_encoding() helper
      ovl: Ensure that all mount points have the same encoding
      ovl: Set case-insensitive dentry operations for ovl sb
      ovl: Set inode S_CASEFOLD for casefolded dentries
      ovl: Check casefold consistency in ovl stack
      ovl: Drop restrictions for casefolded dentries

 fs/overlayfs/inode.c   |  7 +++++
 fs/overlayfs/namei.c   | 25 ++++++---------
 fs/overlayfs/params.c  |  7 -----
 fs/overlayfs/readdir.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/overlayfs/super.c   | 21 +++++++++++++
 fs/overlayfs/util.c    |  8 ++---
 include/linux/fs.h     | 22 ++++++++++++++
 7 files changed, 143 insertions(+), 29 deletions(-)
---
base-commit: ba04dc6f8768e61d6de2d0c5c5079a8b54e62fbb
change-id: 20250409-tonyk-overlayfs-591f5e4d407a

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


