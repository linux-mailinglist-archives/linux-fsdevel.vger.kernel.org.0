Return-Path: <linux-fsdevel+bounces-57153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0628BB1EFFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 22:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5A31789C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 20:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B1D242D75;
	Fri,  8 Aug 2025 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Z4a7Skhb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E15121CFFD;
	Fri,  8 Aug 2025 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686762; cv=none; b=Lhy6UnK/tgp+mnXqVrQMUQn690ZLbC0TlzmmeNFyB0iROxh/ONETU2KEGtVCpm5HAGZIAKw4Hi51Mff3hS1Djl6NjNOzECiuE3MhVbGL46/Z5Wk0uWKFcc06OXI9j1CAt+yTjC+2M+/o//o0kVjxYlNjaoRfwQzN6Ar+cIEdT/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686762; c=relaxed/simple;
	bh=Y1akW/tUO8/eLc3WG3wFlUv009EciIOQQNjsOPYu7hE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J4nQ2PSeNEjPBiBq1440gI8y/lfbHo7TEaTroSb1fq6OikFk3v//PvOnZo+qxq4ZppmeJRM0RexVbF6LaJ2JVepv2pUgkU8/7kz91J++gYOygYoLjHvM2wr6kbYx4iZDE+23r2OP+mn6ws80roCsd1FEsW2cOoiCJtJdpNgKoGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Z4a7Skhb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=n1D/LrSY803XlLsMoG+Du6YGArf9vgrOCY1imzFNMh8=; b=Z4a7Skhbl8V+UHlHFJR8iRC52Y
	27HdoiG4eTDk2jZfWEBotuMrHJ4BSxMQMaAkWdtU/ZyHeRosClI5dcjoBLs2fPJCGeAgxbjy0zwmd
	thHnjEnjcW/5T0/lj6yWKDo1zC3RstTrtB+R2L5nvuQWD5jjTfVAueU/bGh7JVeyldwGaxa//NVZ0
	Wxi6pHuP7JlCGQdUz8Vludq8nJDYTZ7r3u2fDtNg7shvJWvLOiA7Ys9Ce0g7N7XzxNCO1M8fxBGRk
	DtCWzAz88BXYS2C9Z8bhvgwHTynKsmIfHtnMkkSfs9+vQkE9Q7TNU/WhD4uBZ0oo7X+tIT34gMrkK
	s4czI3lg==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ukUBD-00BiQh-Se; Fri, 08 Aug 2025 22:59:12 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH RFC v3 0/7] ovl: Enable support for casefold filesystems
Date: Fri, 08 Aug 2025 17:58:42 -0300
Message-Id: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAJllmgC/3XNTQrCMBAF4KvIrI3ktzauBMEDuBUXoZ20wdpIU
 oKl9O6GbETE5ZvHfG+BiMFhhMNmgYDJRefHHMR2A01vxg6Ja3MGTrmikmoy+XG+E58wDGa2kSj
 NrELZSro3kL+eAa17FfEKl/MJbvnYuzj5MJeVxEr1F0yMUCK0ZhWrLGojjq4zgzO7xj8KlvgHq
 Kn6BXgGKCrJa9YaweovYF3XNz/Annn1AAAA
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
André Almeida (7):
      ovl: Store casefold name for case-insentive dentries
      ovl: Create ovl_casefold() to support casefolded strncmp()
      fs: Create sb_same_encoding() helper
      ovl: Ensure that all mount points have the same encoding
      ovl: Set case-insensitive dentry operations for ovl sb
      ovl: Add S_CASEFOLD as part of the inode flag to be copied
      ovl: Support case-insensitive lookup

 fs/overlayfs/namei.c     |  17 +++---
 fs/overlayfs/overlayfs.h |   2 +-
 fs/overlayfs/ovl_entry.h |   1 +
 fs/overlayfs/params.c    |   7 +--
 fs/overlayfs/readdir.c   | 133 ++++++++++++++++++++++++++++++++++++++++++-----
 fs/overlayfs/super.c     |  39 ++++++++++++++
 fs/overlayfs/util.c      |   8 +--
 include/linux/fs.h       |  19 +++++++
 8 files changed, 195 insertions(+), 31 deletions(-)
---
base-commit: 0fdf709a849f773c9b23b0d9fff2a25de056ddd5
change-id: 20250409-tonyk-overlayfs-591f5e4d407a

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


