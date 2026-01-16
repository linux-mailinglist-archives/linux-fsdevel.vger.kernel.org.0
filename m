Return-Path: <linux-fsdevel+bounces-74132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 455EDD32F48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58B5B30A4FB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907B523EA85;
	Fri, 16 Jan 2026 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovd30LnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46D2877E8;
	Fri, 16 Jan 2026 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574781; cv=none; b=JZwXksnCgaDiYBA1NaEO6hByfgO2qlElrSeFvrWJ6AInuYJSE3Ba+0R/jR9C+uyQ8InFCrbn394J588RfeYU1gTNEyCxiavMPtDOxKr8iwO8jJtDBp9+iCQL9Nilzb5aKwiYNxghXowdDCUUS8dBbGEo7zHu95cei4xz9+crUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574781; c=relaxed/simple;
	bh=o8n9v+A8uQ1g3lXW02yP/a69ri374d7UcRTZHdCsRfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZVbJ9Eu75PBDJdzHyo+vERmcBOjhA2Eun8btZV9Mh66r81RA7e+ZusCUkPDEquX42tGtyr9OKXhO7j6Wn/LcBZroEK/hmYM7ntKb8IPdgrx9SaU7a3Jou4xJ+Nr+i5YY3jK4/FSniKAJfBdN7yn83cunuv4uQ6JVBRaHGatDUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovd30LnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D52CC116C6;
	Fri, 16 Jan 2026 14:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574780;
	bh=o8n9v+A8uQ1g3lXW02yP/a69ri374d7UcRTZHdCsRfo=;
	h=From:To:Cc:Subject:Date:From;
	b=ovd30LnKAovneMXvvNa8BsiFcuewh18ZU+tmt32Z9MW1ETPkcpdSIknDhL2yh+AHC
	 XKfYtiapFj5qix0+mOay6JtRThxrd48PUYKP0xA3e2mge50zfzlCeTASmXatU+ok+T
	 5g0XsefbC7F0x9fkioI0nS41J0SD3NuC3bVZVmzC+xHKB5km2x7mgIOkii97NAKGYZ
	 KF1ayeTq2zztaOkVQh+2yLrjKSw01NeZ0MQkmupsphQYwYaRoPKFrzlMXMJr+WRK7W
	 wn1FS8XW3k6541PIyJl8GqGdacKfg3WKse8lPJWZtvgfO4zkq+0Acuz5uUKwKhTDXO
	 bznniMeWHselg==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	cem@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	hansg@kernel.org,
	senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 00/16] Exposing case folding behavior
Date: Fri, 16 Jan 2026 09:45:59 -0500
Message-ID: <20260116144616.2098618-1-cel@kernel.org>
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
  case-nonpreserving = true

The case-insensitivity and case-nonpreserving booleans can be
consumed immediately by NFSD. These two attributes have been part of
the NFSv3 and NFSv4 protocols for decades, in order to support NFS
client implementations on non-POSIX systems.

Support for user space file servers is why this series exposes case
folding information via a user-space API. I don't know of any other
category of user-space application that requires access to case
folding info.


The Linux NFS community has a growing interest in supporting NFS
clients on Windows and MacOS platforms, where file name behavior does
not align with traditional POSIX semantics.

One example of a Windows-based NFS client is [1]. This client
implementation explicitly requires servers to report
FATTR4_WORD0_CASE_INSENSITIVE = TRUE for proper operation, a hard
requirement for Windows client interoperability because Windows
applications expect case-insensitive behavior. When an NFS client
knows the server is case-insensitive, it can avoid issuing multiple
LOOKUP/READDIR requests to search for case variants, and applications
like Win32 programs work correctly without manual workarounds or
code changes.

Even the Linux client can take advantage of this information. Trond
merged patches 4 years ago [2] that introduce support for case
insensitivity, in support of the Hammerspace NFS server. In
particular, when a client detects a case-insensitive NFS share,
negative dentry caching must be disabled (a lookup for "FILE.TXT"
failing shouldn't cache a negative entry when "file.txt" exists)
and directory change invalidation must clear all cached case-folded
file name variants.

Hammerspace servers and several other NFS server implementations
operate in multi-protocol environments, where a single file service
instance caters to both NFS and SMB clients. In those cases, things
work more smoothly for everyone when the NFS client can see and adapt
to the case folding behavior that SMB users rely on and expect. NFSD
needs to support the case-insensitivity and case-nonpreserving
booleans properly in order to participate as a first-class citizen
in such environments.

Series based on v6.19-rc5.

[1] https://github.com/kofemann/ms-nfs41-client

[2] https://patchwork.kernel.org/project/linux-nfs/cover/20211217203658.439352-1-trondmy@kernel.org/

---

Changes since v4:
- Observe the MSDOS "nocase" mount option
- Define new FS_XFLAGs for the user API

Changes since v3:
- Change fa->case_preserving to fa->case_nonpreserving
- VFAT is case preserving
- Make new fields available to user space

Changes since v2:
- Remove unicode labels
- Replace vfs_get_case_info
- Add support for several more local file system implementations
- Add support for in-kernel SMB server

Changes since RFC:
- Use file_getattr instead of statx
- Postpone exposing Unicode version until later
- Support NTFS and ext4 in addition to FAT
- Support NFSv4 fattr4 in addition to NFSv3 PATHCONF


Chuck Lever (16):
  fs: Add case sensitivity info to file_kattr
  fat: Implement fileattr_get for case sensitivity
  exfat: Implement fileattr_get for case sensitivity
  ntfs3: Implement fileattr_get for case sensitivity
  hfs: Implement fileattr_get for case sensitivity
  hfsplus: Report case sensitivity in fileattr_get
  ext4: Report case sensitivity in fileattr_get
  xfs: Report case sensitivity in fileattr_get
  cifs: Implement fileattr_get for case sensitivity
  nfs: Implement fileattr_get for case sensitivity
  f2fs: Add case sensitivity reporting to fileattr_get
  vboxsf: Implement fileattr_get for case sensitivity
  isofs: Implement fileattr_get for case sensitivity
  nfsd: Report export case-folding via NFSv3 PATHCONF
  nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and
    FATTR4_CASE_PRESERVING
  ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION

 fs/exfat/exfat_fs.h      |  2 ++
 fs/exfat/file.c          | 16 ++++++++++++++--
 fs/exfat/namei.c         |  1 +
 fs/ext4/ioctl.c          |  6 ++++++
 fs/f2fs/file.c           |  6 ++++++
 fs/fat/fat.h             |  3 +++
 fs/fat/file.c            | 20 ++++++++++++++++++++
 fs/fat/namei_msdos.c     |  1 +
 fs/fat/namei_vfat.c      |  1 +
 fs/file_attr.c           |  6 ++++++
 fs/hfs/dir.c             |  1 +
 fs/hfs/hfs_fs.h          |  2 ++
 fs/hfs/inode.c           | 12 ++++++++++++
 fs/hfsplus/inode.c       |  7 +++++++
 fs/isofs/dir.c           | 11 +++++++++++
 fs/nfs/client.c          |  9 +++++++--
 fs/nfs/inode.c           | 18 ++++++++++++++++++
 fs/nfs/internal.h        |  3 +++
 fs/nfs/nfs3proc.c        |  2 ++
 fs/nfs/nfs3xdr.c         |  7 +++++--
 fs/nfs/nfs4proc.c        |  2 ++
 fs/nfs/proc.c            |  3 +++
 fs/nfs/symlink.c         |  3 +++
 fs/nfsd/nfs3proc.c       | 18 ++++++++++--------
 fs/nfsd/nfs4xdr.c        | 30 ++++++++++++++++++++++++++----
 fs/nfsd/vfs.c            | 25 +++++++++++++++++++++++++
 fs/nfsd/vfs.h            |  2 ++
 fs/ntfs3/file.c          | 22 ++++++++++++++++++++++
 fs/ntfs3/inode.c         |  1 +
 fs/ntfs3/namei.c         |  2 ++
 fs/ntfs3/ntfs_fs.h       |  1 +
 fs/smb/client/cifsfs.c   | 18 ++++++++++++++++++
 fs/smb/server/smb2pdu.c  | 25 +++++++++++++++++++------
 fs/vboxsf/dir.c          |  1 +
 fs/vboxsf/file.c         |  6 ++++--
 fs/vboxsf/super.c        |  4 ++++
 fs/vboxsf/utils.c        | 30 ++++++++++++++++++++++++++++++
 fs/vboxsf/vfsmod.h       |  6 ++++++
 fs/xfs/xfs_ioctl.c       |  6 ++++++
 include/linux/fileattr.h |  6 +++++-
 include/linux/nfs_xdr.h  |  2 ++
 include/uapi/linux/fs.h  |  2 ++
 42 files changed, 322 insertions(+), 27 deletions(-)

-- 
2.52.0


