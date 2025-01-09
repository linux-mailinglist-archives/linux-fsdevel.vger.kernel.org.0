Return-Path: <linux-fsdevel+bounces-38717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B354A07007
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 09:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ECA07A1B6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31552215051;
	Thu,  9 Jan 2025 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mG341vL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E118D;
	Thu,  9 Jan 2025 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411478; cv=none; b=tMaUg/vnIaAk4sydihAhK2/y9Lpbpg7J1BWqtFgqCBkZksK9MyDozQczQyP4SXm+/QbhxTFzcA/9gevYrsa5f82i1UlCcIoJLCamvMiUN+OrjzJZhjMVoU3Xtp1a6KaZe91YLYRQtbvaDty3Z0iJsr3UZMkUW1xFpXbcltgCCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411478; c=relaxed/simple;
	bh=D4JItpqOcfiHXjA91/HhOMGPTQT1BlmSnInscT7GaPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvCZwqD0VIo8WMQvlaZyfoekd6pe/vy9YNiIJv50mBkxQKUNx4K875z1sMULaKJLpE0sKz8XPHUgKKXlVz4fQRp8JObLzLIWd9lSWf9sdkqkILj3Rrc47UPAecdJd+4Hm+XiIC7/fpXlZMRCePFJdHYOXoMXiTR4KpUJnwGEu4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mG341vL/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Sjjg0YlW4UhhXVfjL2QA+O88ApogCYw8NkeSR7u3ihY=; b=mG341vL/JWzlOLfTXwET3TbTQA
	vylMrCjpXr0hF8SPt8/Pl/HuYSgXjS5Zv0dhJiLvRcngSE0tPD1Eeoc0kDYp3t9Ui4eovXwapj2Eb
	SlH3mgM4wx4H7JSPZ9uUqT8gaDrohAdtn92Ct/jDxngHfKYcascuN8TSH20FS3ePvC2p0gt1RHRQW
	8loYlfjoz3Bm3u580qIGaXoLduy0L10zP09yCjKuw3GHZ1IX/7X+fKKNqg7REeRTN95BgU7InvIfE
	js7O9Khmdbg6uWScFcd9SMgpRI7m5o+xZ6ZVT4/ZnvPkRZePYkw7Zmlmwcr6eI++6f8SNhHf2Pkws
	fgKdxTeA==;
Received: from 2a02-8389-2341-5b80-ddeb-cdec-70b9-e2f0.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ddeb:cdec:70b9:e2f0] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnwe-0000000BBcT-26zt;
	Thu, 09 Jan 2025 08:31:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: add STATX_DIO_READ_ALIGN v3
Date: Thu,  9 Jan 2025 09:31:00 +0100
Message-ID: <20250109083109.1441561-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

[I hope that no one gets too annoyed by the rapid resends, but s we're
 down to comment an man page tweaks I thought I'd stick to the fast pace]

file systems that write out of place usually require different alignment
for direct I/O writes than what they can do for reads.  This series tries
to address this by adding yet another statx field.

Changes from v2:
 - more comment and man page tweaks

Changes from v1:
 - improve the comment in xfs_report_dioalign based on a contribution
   from Darrick
 - improve man page wording and formatting
 - also report the larger alignment in XFS_IOC_DIOINFO

Changes from RFC:
 - add a cleanup patch for xfs_vn_getattr
 - use xfs_inode_alloc_unitsize in xfs_vn_getattr
 - improve a comment in XFS

Diffstat:
 fs/stat.c                 |    1 
 fs/xfs/xfs_ioctl.c        |   11 ++++-
 fs/xfs/xfs_iops.c         |   62 +++++++++++++++++-----------
 include/linux/stat.h      |    1 
 include/uapi/linux/stat.h |   99 ++++++++++++++++++++++++++++++++++------------
 5 files changed, 125 insertions(+), 49 deletions(-)

