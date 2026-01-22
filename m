Return-Path: <linux-fsdevel+bounces-74983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sClMDD3fcWk+MgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:26:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E5963083
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 795D77679E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449EA376BC7;
	Thu, 22 Jan 2026 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rGgRTf0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2576B34CFBB;
	Thu, 22 Jan 2026 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070148; cv=none; b=AauxjqTIl26MIOcMj+COFQSQBrTBhkL/7RC7SRP+2xXM0VScqZGUWS0qDvSfkbmB+BSmhmlqME0EF5+lBrdpg6bDV2d1yzQkTi3yuSBfeX3LUsgmrfmH1a/3fNOculV3p45hBZHfPgPL4GKoHwgM2E+lRt05UWz2Nq41p3moJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070148; c=relaxed/simple;
	bh=Hrwr/fMYLxj9ok/slq8sbviTQLTF9yXoiyXOpcXNa4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpFPtsfVkaZSEZBuQbnLXIuqhP0MaMLzCWD9XWwsBX10xcRRrP+NMVJqzfk0PLC+EUpF2GIKP62CROpJP4xmNzGq1ry7cQz2At+w6R9fGjP+H+5bmnqlO0g5513tnfc2GpmQ2F/gW38NXhaEODDv0QIFCt0gaEbbnTFjPwmOYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rGgRTf0O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=iXKlgI5mS16I9g4e1Orrg3wlBXZeyCMyoyxfvSYepqc=; b=rGgRTf0OcAev4pI/Wfx3GGpLO9
	r5yxrrJ7Q7V58xtL6nEMg44KfYMJwSlGgtChkUNYr3Z8Egr6SffraBe04smzAX2NY/UZIbq8lc7sI
	pwvVZ6eRzqYzPc/ZOxci/bVLX9tEJUdMuObov495cANoQlyUX5S6LWHF6DNvViI6lCqlDDcqcawRH
	R80PmyQBsqIb0VKnLAtB3m43hjIJjd2Ydl1FiKXu0W5jzBBCMPh5rQQA7uqEqTH6GGp53lC/WQjrX
	mKBDcXQB7eVHFNPJvuc+npqA2y+UOxWQ3zjtF0DIJ5oV7+/Enw9DF6skUT74FM7IHCAwOWYOS60Tz
	0Gd15HEA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vipxM-00000006dsU-3Z7U;
	Thu, 22 Jan 2026 08:22:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: fsverity cleanups, speedup and memory usage optimization v2
Date: Thu, 22 Jan 2026 09:21:56 +0100
Message-ID: <20260122082214.452153-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-74983-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	R_SPF_SOFTFAIL(0.00)[~all];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: D0E5963083
X-Rspamd-Action: no action

Hi all,

this series has a hodge podge of fsverity enhances that I looked into as
part of the review of the xfs fsverity support series.

The first part calls fsverity code from VFS code instead of requiring
boilerplate in the file systems.  The first patch fixes a bug in btrfs
as part of that, as btrfs was missing a check.  An xfstests
test case for this was submitted already.

The middle part optimizes the fsverity read path by kicking off readahead
for the fsverity hashes from the data read submission context, which in my
simply testing showed huge benefits for sequential reads using dd.
I haven't been able to get fio to run on a preallocated fio file, but
I expect random read benefits would be significantly better than that
still.

The last part avoids the need for a pointer in every inode for fsverity
and instead uses a rhashtable lookup, which is once per read_folio or
->readahead invocation and for for btrfs another time for each bio
completion.  Right now this does not increse the number of inodes in
each slab, but for ext4 we are getting very close to that (within
16 bytes by my count).

Changes since v1:
 - reorder to keep the most controversial part last
 - drop moving the open handling to common code (for now)
 - factor the page cache read code into common code
 - reduce the number of hash lookups
 - add a barrier in the fsverity_active that pairs with the cmpxchg
   that sets the inode flag.

Diffstat:
 fs/attr.c                    |   12 ++
 fs/btrfs/btrfs_inode.h       |    4 
 fs/btrfs/extent_io.c         |   37 +++++---
 fs/btrfs/inode.c             |   13 ---
 fs/btrfs/verity.c            |   11 --
 fs/buffer.c                  |   25 ++---
 fs/ext4/ext4.h               |    4 
 fs/ext4/inode.c              |    4 
 fs/ext4/readpage.c           |   31 ++++---
 fs/ext4/super.c              |    4 
 fs/ext4/verity.c             |   34 ++------
 fs/f2fs/compress.c           |    7 -
 fs/f2fs/data.c               |   73 +++++++++++------
 fs/f2fs/f2fs.h               |   12 --
 fs/f2fs/file.c               |    4 
 fs/f2fs/inode.c              |    1 
 fs/f2fs/super.c              |    3 
 fs/f2fs/verity.c             |   34 ++------
 fs/inode.c                   |    9 ++
 fs/verity/Makefile           |    3 
 fs/verity/enable.c           |   39 +++++----
 fs/verity/fsverity_private.h |   19 ++--
 fs/verity/open.c             |   80 ++++++++++---------
 fs/verity/pagecache.c        |   53 ++++++++++++
 fs/verity/read_metadata.c    |   10 +-
 fs/verity/verify.c           |   94 +++++++++++++++-------
 include/linux/fsverity.h     |  180 +++++++++++++++----------------------------
 27 files changed, 422 insertions(+), 378 deletions(-)

