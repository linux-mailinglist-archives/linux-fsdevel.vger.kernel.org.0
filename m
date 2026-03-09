Return-Path: <linux-fsdevel+bounces-79841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMYwAnIer2neOAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:24:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B7123FC37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C8053009381
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 19:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47258363C4A;
	Mon,  9 Mar 2026 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1qQBqsF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE2344D95;
	Mon,  9 Mar 2026 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084259; cv=none; b=O/ijrRKwfjUAREqq9nXbtPl5e6e4nLuaw6eHPiUiPwj4/wd6aYNxva1jRW8skjwA57EwkOZHwSQUqZKXRufK5AM8cmyBzfKu5Wpbhb8++kyRJWJpceE2VDRTnNoI/75peusBEoM5LHvoJqjCoJrG8J3+qTy3G2TSc6Zi2xIpRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084259; c=relaxed/simple;
	bh=IJcAWqvdv23TT6+zVeEt1eaU/4jMTaDgQsGemo50jSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCMAKCJfr3PhNHk5dH8Cwnnlh4MAcZ4WmkpEoSdgV5x6V75QPCK5GdB3SIEJC1rE5en/ZJGHC0Oe4Gcu1jaHB/V9mMLEhWmdwqGBfqgVaIRO9rTNWr/oyP2N0Uju5YhvOSsdrVkSuttNrsFYNZs1OX6U2U9LaUnIYOWl58tLvpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1qQBqsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C028C4CEF7;
	Mon,  9 Mar 2026 19:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773084259;
	bh=IJcAWqvdv23TT6+zVeEt1eaU/4jMTaDgQsGemo50jSg=;
	h=From:To:Cc:Subject:Date:From;
	b=d1qQBqsF4/iw4Tc3hphf5EzwE8e9lxn7/y1F0SXGorIhcJCuz/vu3F8fco+JuWC8d
	 3eqQ6E8i/+a3x6cnDzBPnGvdDhlFCjsSDxr/Rvhk8AUiyZvdFWOFsL41HtghmCOb3L
	 xod/yj7pTVHsTczJUF9SirwfEjop3B8bai8srWHLID+i+Aor+K9huBr1AmE4hF4oYo
	 +Tu/6oKZxVxkjnuor8CFrw4F7xtYstHg/3aqb5mJVd2frVrJcHac/KcM6t7FkDr2GO
	 sfXN2VCzUDnVQj5d5bRI/f7hKTnKuaOOaaPYGRuJwnEbbLjPram+82QIqrQktOV9HX
	 hhXvwILcV5hxQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	djwong@kernel.org,
	david@fromorbit.com
Subject: [PATCH v4 00/25] fs-verity support for XFS with post EOF merkle tree
Date: Mon,  9 Mar 2026 20:23:15 +0100
Message-ID: <20260309192355.176980-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08B7123FC37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79841-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fromorbit.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

Hi all,

This patch series adds fs-verity support for XFS. This version stores
merkle tree beyond end of the file, the same way as ext4 does it. The
difference is that verity descriptor is stored at the next aligned 64k
block after the merkle tree last block. This is done due to sparse
merkle tree which doesn't store hashes of zero data blocks.

The patchset starts with a few fs-verity preparation patches. Then, a
few patches to allow iomap to work in post EOF region. The XFS fs-verity
implementation follows.

The tree is read by iomap into page cache at offset of next largest
folio past end of file. The same offset is used for on-disk.

This patchsets also synthesizes merkle tree block full of hashes of
zeroed data blocks. This merkle blocks are not stored on disk, they are
holes in the tree.

Testing. The -g verity is passing for 1k, 8k and 4k with/without quota,
the tests include different merkle tree block size.

This series based on latest fsverity branch with patchset fs generated
integrity information [1] on top of fsverity/for-current.

kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/aalbersh/xfs-linux.git/log/?h=b4/fsverity

xfsprogs:
https://github.com/alberand/xfsprogs/tree/b4/fsverity

xfstests:
https://github.com/alberand/xfstests/tree/b4/fsverity

Cc: fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org

Cc: david@fromorbit.com
Cc: djwong@kernel.org
Cc: ebiggers@kernel.org
Cc: hch@lst.de

[1]: https://lore.kernel.org/linux-xfs/20260223132021.292832-1-hch@lst.de/

---
Changes in v4:
- Use fserror interface in fsverity instead of fs callback
- Hoist pagecache_read from f2fs/ext4 to fsverity
- Refactor iomap code
- Fetch fsverity_info only for file data and merkle tree holes
- Do not disable preallocation, remove unwritten extents instead
- Offload fsverity hash I/O to fsverity workqueue in read path
- Store merkle tree at round_up(i_size, 64k)
- Add a spacing between merkle tree and fsverity descriptor as next 64k
  aligned block
- Squash helpers into first user commits
- Squash on-disk format changes into single commit
- Drop different offset for pagecache/on-disk
- Don't zero out pages in higher order folios in write path
- Link to v3: https://lore.kernel.org/fsverity/20260217231937.1183679-1-aalbersh@kernel.org/T/#t
Changes in v3:
- Different on-disk and pagecache offset
- Use read path ioends
- Switch to hashtable fsverity info
- Synthesize merkle tree blocks full of zeroes
- Other minor refactors
- Link to v2: https://lore.kernel.org/fsverity/20260114164210.GO15583@frogsfrogsfrogs/T/#t
Changes in v2:
- Move to VFS interface for merkle tree block reading
- Drop patchset for per filesystem workqueues
- Change how offsets of the descriptor and tree metadata is calculated
- Store fs-verity descriptor in data fork side by side with merkle tree
- Simplify iomap changes, remove interface for post eof read/write
- Get rid of extended attribute implementation
- Link to v1: https://lore.kernel.org/r/20250728-fsverity-v1-0-9e5443af0e34@kernel.org

Andrey Albershteyn (23):
  fsverity: report validation errors through fserror to fsnotify
  fsverity: expose ensure_fsverity_info()
  fsverity: generate and store zero-block hash
  fsverity: introduce fsverity_folio_zero_hash()
  fsverity: pass digest size and hash of the empty block to ->write
  fsverity: hoist pagecache_read from f2fs/ext4 to fsverity
  iomap: introduce IOMAP_F_FSVERITY and teach writeback to handle
    fsverity
  iomap: obtain fsverity info for read path
  iomap: issue readahead for fsverity merkle tree
  iomap: teach iomap to handle fsverity holes and verify data holes
  iomap: introduce iomap_fsverity_write() for writing fsverity metadata
  xfs: introduce fsverity on-disk changes
  xfs: initialize fs-verity on file open
  xfs: don't allow to enable DAX on fs-verity sealed inode
  xfs: disable direct read path for fs-verity files
  xfs: handle fsverity I/O in write/read path
  xfs: use read ioend for fsverity data verification
  xfs: add fs-verity support
  xfs: remove unwritten extents after preallocations in fsverity
    metadata
  xfs: add fs-verity ioctls
  xfs: introduce health state for corrupted fsverity metadata
  xfs: add fsverity traces
  xfs: enable ro-compat fs-verity flag

Darrick J. Wong (2):
  xfs: advertise fs-verity being available on filesystem
  xfs: check and repair the verity inode flag state

 fs/btrfs/verity.c              |   6 +-
 fs/ext4/verity.c               |  36 +--
 fs/f2fs/verity.c               |  34 +--
 fs/iomap/buffered-io.c         |  97 ++++++-
 fs/iomap/trace.h               |   3 +-
 fs/verity/enable.c             |   4 +-
 fs/verity/fsverity_private.h   |   3 +
 fs/verity/open.c               |   8 +-
 fs/verity/pagecache.c          |  55 ++++
 fs/verity/verify.c             |   2 +
 fs/xfs/Makefile                |   1 +
 fs/xfs/libxfs/xfs_bmap.c       |   7 +
 fs/xfs/libxfs/xfs_format.h     |  13 +-
 fs/xfs/libxfs/xfs_fs.h         |   2 +
 fs/xfs/libxfs/xfs_health.h     |   4 +-
 fs/xfs/libxfs/xfs_inode_buf.c  |   8 +
 fs/xfs/libxfs/xfs_inode_util.c |   2 +
 fs/xfs/libxfs/xfs_sb.c         |   4 +
 fs/xfs/scrub/attr.c            |   7 +
 fs/xfs/scrub/common.c          |  53 ++++
 fs/xfs/scrub/common.h          |   2 +
 fs/xfs/scrub/inode.c           |   7 +
 fs/xfs/scrub/inode_repair.c    |  36 +++
 fs/xfs/xfs_aops.c              |  48 +++-
 fs/xfs/xfs_bmap_util.c         |   8 +
 fs/xfs/xfs_file.c              |  19 +-
 fs/xfs/xfs_fsverity.c          | 460 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_fsverity.h          |  28 ++
 fs/xfs/xfs_health.c            |   1 +
 fs/xfs/xfs_inode.h             |   6 +
 fs/xfs/xfs_ioctl.c             |  14 +
 fs/xfs/xfs_iomap.c             |  15 +-
 fs/xfs/xfs_iops.c              |   4 +
 fs/xfs/xfs_message.c           |   4 +
 fs/xfs/xfs_message.h           |   1 +
 fs/xfs/xfs_mount.h             |   4 +
 fs/xfs/xfs_super.c             |   7 +
 fs/xfs/xfs_trace.h             |  45 ++++
 include/linux/fsverity.h       |  17 +-
 include/linux/iomap.h          |  10 +
 40 files changed, 992 insertions(+), 93 deletions(-)
 create mode 100644 fs/xfs/xfs_fsverity.c
 create mode 100644 fs/xfs/xfs_fsverity.h

-- 
2.51.2


