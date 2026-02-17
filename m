Return-Path: <linux-fsdevel+bounces-77437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Is7I8r3lGktJgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:20:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4511C151C52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BD403036EA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ABC2D781E;
	Tue, 17 Feb 2026 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttSt8DbB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34916221FCF;
	Tue, 17 Feb 2026 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771370434; cv=none; b=AZ/Etm86wAgW3GvZBUMkCeXetIVgV8+UTf7CrzeZH2yWbeGa0qYwxh1BFc1NXFyfxutM9yzrl5jCAhzHJ7cdB333R5rJFdI8EXn3toefol2NiVUSRagvroLVTuBP67SKzQRIYxITU48BRl85csSh4V0/BmNgMdnEQElUMgFPr10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771370434; c=relaxed/simple;
	bh=1aNcJF5LRg5ndX0CMDpJI5zR2Sp/MUO6ZObA61itwEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fVSnzL9o5zkh4vOJmFmgxkS657kXGm7joH1UEHha3UdO2h0xyYEgyg6sBGBaTDU46imgIP2GNmiNABYWrqEbLTF7iKYM7Uwx7Ifb0d1xpGZLrbRvVghc2WB+rwBIMpBmFf4HOTuCjRgrYJQfH9N3Rwhf+Sx/9mbVSoM4/Hb9D8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttSt8DbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2714EC4CEF7;
	Tue, 17 Feb 2026 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771370433;
	bh=1aNcJF5LRg5ndX0CMDpJI5zR2Sp/MUO6ZObA61itwEU=;
	h=From:To:Cc:Subject:Date:From;
	b=ttSt8DbBc2wpv5nnatC7l95YZM19Cb+hnmmkszNkZ+Z4FWmB6qlKoMVhMapKJg71X
	 4UIRJWCVGctNXzmLqfH0Xyqi5KZWH847VzYfqCZC6tQgwOS32frlv8QpkvyI/By/ci
	 irKJJRtauHAz8ukTHn4IQb5Ij+vIFTsch7wd1Osf7EbA0jazRW4of+IynA+CxoKIDm
	 NjGz1Jt1BnYF7Po48cZ8OY6vtyks7kFIdNngU7+pDEu7sdgqdhwB5ei69nhuZkCdQx
	 A+cQddHkFbL3f7oqexuNTt0+6TNs3zXkBgzsCxdZuK61cqI3YNpXHMLOsH4bJcN2iW
	 /xeEnFD8ehphg==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	hch@lst.de,
	djwong@kernel.org
Subject: [PATCH v3 00/35] fs-verity support for XFS with post EOF merkle tree
Date: Wed, 18 Feb 2026 00:19:00 +0100
Message-ID: <20260217231937.1183679-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77437-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[lst.de:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 4511C151C52
X-Rspamd-Action: no action

Hi all,

This patch series adds fs-verity support for XFS. This version stores
merkle tree beyond end of the file, the same way as ext4 does it. The
verity descriptor is stored at the tail of the merkle tree.

The patchset starts with a few fs-verity preparation patches. Then, a few
patches to allow iomap to work in post EOF region. The XFS fs-verity
implementation follows.

Preallocations. The preallocations are disabled for fs-verity files. If
inode is fs-verity one the allocation size is set to zero. This is fine
as the only writing happening is merkle tree data and descriptor.

The tree is read by iomap into page cache at offset of next largest
folio past end of file. This offset is different from one stored
on-disk, file offset is 1ULL << 53. This is far enough to handle any
supported file size.

This patchsets also synthesizes merkle tree block full of hashes of
zeroed data blocks. This merkle blocks are not stored on disk, they are
holes in the tree.

Testing. The -g verity is passing for 1k, 8k and 4k with/without quota,
the tests include different merkle tree block size.

From time to time I see a generic/579 (stress test enable/read) failing
on xfs_8k. Somehow, merkle block is zeroed page. I haven't found the
reason why yet.

Feedback is welcomed :)

This series based on latest fsverity branch with patchset fs generated
integrity information [1] and the one preceding it [2] and traces
patchset [3].

xfsprogs:
https://github.com/alberand/xfsprogs/tree/b4/fsverity

xfstests:
https://github.com/alberand/xfstests/tree/b4/fsverity

Cc: fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org

Cc: djwong@kernel.org
Cc: ebiggers@kernel.org
Cc: hch@lst.de

[1]: https://lore.kernel.org/linux-xfs/20260128161517.666412-1-hch@lst.de/T/#t
[2]: https://lore.kernel.org/linux-xfs/aXnb17nHHog9z6tC@nidhogg.toxiclabs.cc/T/#t
[3]: https://lore.kernel.org/fsverity/20260203-wasser-universal-5cc36f5a273e@brauner/T/#t

---
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

Andrey Albershteyn (31):
  fsverity: expose ensure_fsverity_info()
  fsverity: add consolidated pagecache offset for metadata
  fsverity: generate and store zero-block hash
  fsverity: introduce fsverity_folio_zero_hash()
  fsverity: pass digest size and hash of the empty block to ->write
  iomap: introduce IOMAP_F_FSVERITY
  iomap: don't limit fsverity metadata by EOF in writeback
  iomap: obtain fsverity info for read path
  iomap: issue readahead for fsverity merkle tree
  iomap: allow filesystem to read fsverity metadata beyound EOF
  iomap: let fsverity verify holes
  xfs: use folio host instead of file struct
  xfs: add fs-verity ro-compat flag
  xfs: add inode on-disk VERITY flag
  xfs: initialize fs-verity on file open
  xfs: don't allow to enable DAX on fs-verity sealed inode
  xfs: disable direct read path for fs-verity files
  xfs: introduce XFS_FSVERITY_CONSTRUCTION inode flag
  xfs: introduce XFS_FSVERITY_REGION_START constant
  xfs: disable preallocations for fsverity Merkle tree writes
  xfs: add iomap write/writeback and reading of Merkle tree pages
  xfs: add helper to check that inode data need fsverity verification
  xfs: use read ioend for fsverity data verification
  xfs: add helpers to convert between pagecache and on-disk offset
  xfs: add a helper to decide if bmbt record needs offset conversion
  xfs: use different on-disk and pagecache offset for fsverity
  xfs: add fs-verity support
  xfs: add fs-verity ioctls
  xfs: introduce health state for corrupted fsverity metadata
  xfs: add fsverity traces
  xfs: enable ro-compat fs-verity flag

Darrick J. Wong (4):
  fsverity: report validation errors back to the filesystem
  xfs: advertise fs-verity being available on filesystem
  xfs: check and repair the verity inode flag state
  xfs: report verity failures through the health system

 fs/btrfs/verity.c               |   6 +-
 fs/ext4/verity.c                |   4 +-
 fs/f2fs/verity.c                |   4 +-
 fs/iomap/buffered-io.c          |  64 +++-
 fs/iomap/trace.h                |   3 +-
 fs/verity/enable.c              |   4 +-
 fs/verity/fsverity_private.h    |   3 +
 fs/verity/open.c                |   8 +-
 fs/verity/pagecache.c           |  28 ++
 fs/verity/verify.c              |   4 +
 fs/xfs/Makefile                 |   1 +
 fs/xfs/libxfs/xfs_bmap.c        |  13 +-
 fs/xfs/libxfs/xfs_format.h      |  13 +-
 fs/xfs/libxfs/xfs_fs.h          |  27 ++
 fs/xfs/libxfs/xfs_health.h      |   6 +-
 fs/xfs/libxfs/xfs_inode_buf.c   |   8 +
 fs/xfs/libxfs/xfs_inode_util.c  |   2 +
 fs/xfs/libxfs/xfs_sb.c          |   4 +
 fs/xfs/scrub/attr.c             |   7 +
 fs/xfs/scrub/common.c           |  53 ++++
 fs/xfs/scrub/common.h           |   2 +
 fs/xfs/scrub/inode.c            |   7 +
 fs/xfs/scrub/inode_repair.c     |  36 +++
 fs/xfs/xfs_aops.c               |  55 +++-
 fs/xfs/xfs_bmap_util.c          |   8 +
 fs/xfs/xfs_file.c               |  19 +-
 fs/xfs/xfs_fsverity.c           | 511 ++++++++++++++++++++++++++++++++
 fs/xfs/xfs_fsverity.h           |  46 +++
 fs/xfs/xfs_health.c             |   2 +
 fs/xfs/xfs_inode.h              |   6 +
 fs/xfs/xfs_ioctl.c              |  16 +
 fs/xfs/xfs_iomap.c              |  45 ++-
 fs/xfs/xfs_iops.c               |   4 +
 fs/xfs/xfs_message.c            |   4 +
 fs/xfs/xfs_message.h            |   1 +
 fs/xfs/xfs_mount.h              |   4 +
 fs/xfs/xfs_super.c              |   7 +
 fs/xfs/xfs_trace.h              |  46 +++
 include/linux/fsverity.h        |  43 ++-
 include/linux/iomap.h           |   7 +
 include/trace/events/fsverity.h |  19 ++
 41 files changed, 1109 insertions(+), 41 deletions(-)
 create mode 100644 fs/xfs/xfs_fsverity.c
 create mode 100644 fs/xfs/xfs_fsverity.h

-- 
2.51.2


