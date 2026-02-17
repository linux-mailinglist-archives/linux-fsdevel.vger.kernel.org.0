Return-Path: <linux-fsdevel+bounces-77404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJODFwnilGlqIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:47:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA8C150E24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31FDD3008606
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4406A2FBDF0;
	Tue, 17 Feb 2026 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIzruJhN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C064D2F5308;
	Tue, 17 Feb 2026 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771364866; cv=none; b=KEOIfs3XEQwhgFxBxK7hlcC28NM2laTekmVhpn81pcETKU4gaUDd9mt7jWYd7QN9yU6MDUTKUkyRG9N3OhLccKBDh8HSmHTFp98ce3Mg5wN3H6v8byV3uQHFi3NH7dBDO1tRsTqk8l8L1VvlSk2rNiCCHBRXrZX4qFLInTVpsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771364866; c=relaxed/simple;
	bh=uFarXmlAvCx7b/yKLd2k3+58CR08lbeRk5TkvQs+/0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HlMSptfcODhj+J7P26x2IMFqCLI2YGqYl/KGlTVs6oil95mw/ZkLGVSxxS7fHRu9ZHL6rjYa5NUK0RZ0hK2gITZN75GWtqsEHP89av3b011xxlA+f60cz+KSziDcP3h7fgl3avqQXMW9Z4G7I8w5SH9gMefEV3XrQK2VIx6R40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIzruJhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20653C4CEF7;
	Tue, 17 Feb 2026 21:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771364866;
	bh=uFarXmlAvCx7b/yKLd2k3+58CR08lbeRk5TkvQs+/0A=;
	h=From:To:Cc:Subject:Date:From;
	b=kIzruJhNO4cS4+JtGZE7/hXD1JcWKjVgWD2RAuLpE9FMTZYBbThGG6LTSUbnPCeP/
	 yW28Wceq4gziBpRxYmKoWIBIPu+gq627IXmtV9vubGkoPR9gfQ9AXVFcNEySjRhVsV
	 Sctbj1BoiWbThrTw5ErOYyg6d+sKi15pyJg5ptfIBQecMeTsE8SZaYG6B0FXR3j1Tz
	 EKFaxCFfwq1+khuL39yNVwTTREW2nTOGwrPdJ5AOOCGZAkxWocBF0+WOA/y3sYUgZH
	 reyhUsSf3ntIMtApoeWWghJHKzmgKwadrTfjZFq6PBLYMVvQNAwbToQZWJvpCbH0oY
	 m01n2mn6owqrQ==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-api@vger.kernel.org,
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
Subject: [PATCH v8 00/17] Subject: Exposing case folding behavior
Date: Tue, 17 Feb 2026 16:47:24 -0500
Message-ID: <20260217214741.1928576-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77404-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CA8C150E24
X-Rspamd-Action: no action

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

Series based on 9702969978695d9a699a1f34771580cdbb153b33

[1] https://github.com/kofemann/ms-nfs41-client

[2] https://patchwork.kernel.org/project/linux-nfs/cover/20211217203658.439352-1-trondmy@kernel.org/

---

Changes since v7:
- Split file_attr initialization changes into a separate patch

Changes since v6:
- Remove the memset from vfs_fileattr_get

Changes since v5:
- Finish the conversion to FS_XFLAGs
- NFSv4 GETATTR now clears the attr mask bit if nfsd_get_case_info()
  fails

Changes since v4:
- Observe the MSDOS "nocase" mount option
- Define new FS_XFLAGs for the user API

Changes since v3:
- Change fa->case_preserving to fa_case_nonpreserving
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


Chuck Lever (17):
  fs: Move file_kattr initialization to callers
  fs: Add case sensitivity flags to file_kattr
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
 fs/ext4/ioctl.c          |  7 +++++++
 fs/f2fs/file.c           |  7 +++++++
 fs/fat/fat.h             |  3 +++
 fs/fat/file.c            | 22 ++++++++++++++++++++++
 fs/fat/namei_msdos.c     |  1 +
 fs/fat/namei_vfat.c      |  1 +
 fs/file_attr.c           | 18 +++++++++---------
 fs/hfs/dir.c             |  1 +
 fs/hfs/hfs_fs.h          |  2 ++
 fs/hfs/inode.c           | 13 +++++++++++++
 fs/hfsplus/inode.c       |  8 ++++++++
 fs/isofs/dir.c           | 15 +++++++++++++++
 fs/nfs/client.c          |  9 +++++++--
 fs/nfs/inode.c           | 20 ++++++++++++++++++++
 fs/nfs/internal.h        |  3 +++
 fs/nfs/nfs3proc.c        |  2 ++
 fs/nfs/nfs3xdr.c         |  7 +++++--
 fs/nfs/nfs4proc.c        |  2 ++
 fs/nfs/proc.c            |  3 +++
 fs/nfs/symlink.c         |  3 +++
 fs/nfsd/nfs3proc.c       | 18 ++++++++++--------
 fs/nfsd/nfs4xdr.c        | 31 +++++++++++++++++++++++++++----
 fs/nfsd/vfs.c            | 25 +++++++++++++++++++++++++
 fs/nfsd/vfs.h            |  2 ++
 fs/ntfs3/file.c          | 23 +++++++++++++++++++++++
 fs/ntfs3/inode.c         |  1 +
 fs/ntfs3/namei.c         |  2 ++
 fs/ntfs3/ntfs_fs.h       |  1 +
 fs/smb/client/cifsfs.c   | 20 ++++++++++++++++++++
 fs/smb/server/smb2pdu.c  | 25 +++++++++++++++++++------
 fs/vboxsf/dir.c          |  1 +
 fs/vboxsf/file.c         |  6 ++++--
 fs/vboxsf/super.c        |  4 ++++
 fs/vboxsf/utils.c        | 31 +++++++++++++++++++++++++++++++
 fs/vboxsf/vfsmod.h       |  6 ++++++
 fs/xfs/xfs_ioctl.c       |  9 ++++++++-
 include/linux/fileattr.h |  3 ++-
 include/linux/nfs_xdr.h  |  2 ++
 include/uapi/linux/fs.h  |  7 +++++++
 42 files changed, 346 insertions(+), 37 deletions(-)

-- 
2.53.0


