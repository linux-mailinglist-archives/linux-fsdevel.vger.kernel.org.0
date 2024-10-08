Return-Path: <linux-fsdevel+bounces-31287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6103E994349
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933A01C2344B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FE118B482;
	Tue,  8 Oct 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M1k8q/3/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6D185B5D;
	Tue,  8 Oct 2024 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377985; cv=none; b=b9SZRoce9baMXntM6aS2OoKYlEfSLH4tV64wkTdm7qGbzVIG+81Sj1nqB4qJwDGTOVNRvf4kAxFAYD3qD2E7R2S9pG4IOF+znXjbBKVHdwYL2mNNLHWpj4P7NSHusuXyzDHPF3aTBgZns2u6Qp55sOMlv8ncXRsLdBYmxJEod9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377985; c=relaxed/simple;
	bh=bsS1IQvSaGT2mjiswqsF3Xo/IXFfnpEWIxq0iLXXV/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z92Iy26hTeQTHLdGfBmC/GIDkCkf+vmDwcXiv8cCJDvUrJN35yCMQU0srX2Wm3Kq6w9yBlX5/pYKWQTaTiNAPUsqTRzAP4cPlhApjfOOl1U02WKB8HsyiSZmCBRKrWoFDBiHgipaQfQ8Vo2N1IvwwkgCxAqpC8ogdTxAvhmBBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M1k8q/3/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=r7gxCZXsIV5o7YP9IOswwIMFowO8tmBGG3O5Lyi0Zb8=; b=M1k8q/3/SfSPuUZKxU7nfqdjkV
	fZMmPguuVfERY3T797ud7JyM7U0edqHg4VSXNE4fwa1Xq+XnFX66TpSs95lQK5QB2yMbE1ew4Q7tW
	dKGKXBX5WGAXiZ1L/ZOeaMV8x89wXv0ZzqyQeHHYdEh04fEGo/Qvmp7rxASq/hHuR5NPLAOZSCgrG
	Btgnk/fvIq0ouNK04FhqvKWaKpAHvdj0liYYlyxA//q7IeNPhfivcerUOqmF7PCOQvOoJdoRExk6V
	R9gVlHMxpODIt232dmTC/gArH9zthoSABWnI3mdqoSiErEAEX0Z5CMFcdT6EfuSjXEHnFtC28aE8s
	/O9O96kA==;
Received: from 2a02-8389-2341-5b80-a172-fba5-598b-c40c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:a172:fba5:598b:c40c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sy64D-00000005BZG-44XN;
	Tue, 08 Oct 2024 08:59:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: fix stale delalloc punching for COW I/O v5
Date: Tue,  8 Oct 2024 10:59:11 +0200
Message-ID: <20241008085939.266014-1-hch@lst.de>
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

this is another fallout from the zoned XFS work, which stresses the XFS
COW I/O path very heavily.  It affects normal I/O to reflinked files as
well, but is very hard to hit there.

The main problem here is that we only punch out delalloc reservations
from the data fork, but COW I/O places delalloc extents into the COW
fork, which means that it won't get punched out forshort writes.


Changes since v4:
 - unshare also already holds the invalidate_lock as found out by recent
   fsstress enhancements

Changes since v3:
 - improve two comments

Changes since v2:
 - drop the patches already merged and rebased to latest Linus' tree
 - moved taking invalidate_lock from iomap to the caller to avoid a
   too complicated locking protocol
 - better document the xfs_file_write_zero_eof return value
 - fix a commit log typo

Changes since v1:
 - move the already reviewed iomap prep changes to the beginning in case
   Christian wants to take them ASAP
 - take the invalidate_lock for post-EOF zeroing so that we have a
   consistent locking pattern for zeroing.

Diffstat:
 Documentation/filesystems/iomap/operations.rst |    2 
 fs/iomap/buffered-io.c                         |  111 ++++++-------------
 fs/xfs/xfs_aops.c                              |    4 
 fs/xfs/xfs_bmap_util.c                         |   10 +
 fs/xfs/xfs_bmap_util.h                         |    2 
 fs/xfs/xfs_file.c                              |  146 +++++++++++++++----------
 fs/xfs/xfs_iomap.c                             |   67 +++++++----
 include/linux/iomap.h                          |   20 ++-
 8 files changed, 198 insertions(+), 164 deletions(-)

