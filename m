Return-Path: <linux-fsdevel+bounces-71126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C34CB655E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 16:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCFD2302434A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3DE304980;
	Thu, 11 Dec 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbyir3h+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CB25B30D;
	Thu, 11 Dec 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466512; cv=none; b=CSWJodGl5UOOY6X/j45g2PA7tVO4aAKNW8MItC0K1rlD5XLBbHCSRJGCSapZ25Cbu45xtDXT/D7oUwliwhvXqeWcZ8M1uYdB4KLpzFXRcIuVr/Xsj1FwCfDPe1CG7uR62X3lrVw/423sr+dbNw2IActR5OJWxTzpNUrKFEMmKl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466512; c=relaxed/simple;
	bh=bZb7lrcO1JmFx9aVwulev2AKAjh46dUipO7T38l+F4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/h5fUJ4HdWAaFB/6fuC1u8MEspMrSRGBHmpwJ1HYlnAO6gChh9mk3rrWKD0e/l/GJ5NojeNh11wF+4K/UT5Yfxzdzpk4Z0QzXLL06bWgYJFUJKyojsrpswYE7oampVVKghvDtZ+V4hCYDyKRwZC+ptohCdaX3JYTxe4T3FC3Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jbyir3h+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F19C4CEF7;
	Thu, 11 Dec 2025 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765466512;
	bh=bZb7lrcO1JmFx9aVwulev2AKAjh46dUipO7T38l+F4U=;
	h=From:To:Cc:Subject:Date:From;
	b=Jbyir3h+9J1BU88MXbDNIhodAyLmvFQ09/gfZ8gNddCAkVtdJbcShGTZ/s5mOWXr5
	 msJimRR7vS917XjDFPgcbhUynR6FXVLgmNrK0cJWhWuwHQLNQK5NSO4cJaCqTybF4d
	 XFQJ+HdyRqv72LLxpfQAauUtdoXucfmstOAewY+p9oTWaWK1GR/Szpj5OfmoRYURJ0
	 H36U6VA9nCz1DighrCRE1X2bisxElpG+41FlP7QZMwxrjJgJ6ASsGGv4sedhRMlUJm
	 L1+SZiKk9Wyx2tf/dQvNY+9UsWoALzO3rRtVGJD+b4ibVKP+vg2MirlL78/qCrVa2Q
	 cHWHxOnEH7YEA==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	hirofumi@mail.parknet.co.jp,
	almaz.alexandrovich@paragon-software.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	Volker.Lendecke@sernet.de,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/6] Exposing case folding behavior
Date: Thu, 11 Dec 2025 10:21:10 -0500
Message-ID: <20251211152116.480799-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Following on from

https://lore.kernel.org/linux-nfs/20251021-zypressen-bazillus-545a44af57fd@brauner/T/#m0ba197d75b7921d994cf284f3cef3a62abb11aaa

I'm attempting to implement enough support in the Linux VFS to
enable file services like NFSD and ksmbd (and user space
equivalents) to provide the actual status of case folding support
in local file systems. The default behavior for local file systems
not explicitly supported in this series is to reflect the usual
POSIX behaviors:

  case-insensitive = false
  case-preserving = true

Changes since RFC:
- Use file_getattr instead of statx
- Postpone exposing Unicode version until later
- Support NTFS and ext4 in addition to FAT
- Support NFSv4 fattr4 in addition to NFSv3 PATHCONF

Chuck Lever (6):
  fs: Add case sensitivity info to file_kattr
  fat: Implement fileattr_get for case sensitivity
  ntfs3: Implement fileattr_get for case sensitivity
  ext4: Report case sensitivity in fileattr_get
  nfsd: Report export case-folding via NFSv3 PATHCONF
  nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and
    FATTR4_CASE_PRESERVING

 fs/ext4/ioctl.c          | 12 ++++++++++++
 fs/fat/fat.h             |  3 +++
 fs/fat/file.c            | 18 ++++++++++++++++++
 fs/fat/namei_msdos.c     |  1 +
 fs/fat/namei_vfat.c      |  1 +
 fs/file_attr.c           | 31 +++++++++++++++++++++++++++++++
 fs/nfsd/nfs3proc.c       | 18 ++++++++++--------
 fs/nfsd/nfs4xdr.c        | 30 ++++++++++++++++++++++++++----
 fs/nfsd/vfs.c            | 25 +++++++++++++++++++++++++
 fs/nfsd/vfs.h            |  2 ++
 fs/ntfs3/file.c          | 27 +++++++++++++++++++++++++++
 fs/ntfs3/inode.c         |  1 +
 fs/ntfs3/namei.c         |  2 ++
 fs/ntfs3/ntfs_fs.h       |  1 +
 include/linux/fileattr.h | 23 +++++++++++++++++++++++
 15 files changed, 183 insertions(+), 12 deletions(-)

-- 
2.52.0


