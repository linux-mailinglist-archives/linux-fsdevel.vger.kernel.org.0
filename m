Return-Path: <linux-fsdevel+bounces-38638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794D0A055DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 09:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B16162DBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE721EF097;
	Wed,  8 Jan 2025 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d8GcKJtc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02AA1E3DF2;
	Wed,  8 Jan 2025 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326562; cv=none; b=QiASOBhOSI+/TReXp/qdQ239Jl8Gwl9wNFtDvC4aWVRf4nNMl3oIsLF2kUiarIX67PnLbimrv9qMgRuBr4c2UCkjVFXzcJ30Eaq+V/NH0oIPtLgXIwKfxjZGt5HNkM3wQylgqg00WVMmw+3mXgt+Zh1f6XyoHaRxZNRfu71rVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326562; c=relaxed/simple;
	bh=vwZZ3Bc9XTp9tFTvSHgy4LZpXS8HsiJXBfWGvM1wELw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5PhLwN3MnzcXd0E3AS1G62w48V1KDxj/CviDYqcvj9JaQ8uDKeZD9QrFBIMYrrq09GF6rd/Keuk3tlCyz5KDq5DKgpeN3EPyaAB2ZAmJz0lAKWC3dKbgDv8/fQ8tX95rP9gBY0f6R2DjAApDuxuo0nBkacmyF+xUmoyrGz+SiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d8GcKJtc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wY/30fLw6EBpvH4a0jLLZOLV98/vgA8jQUv/UD7U+TM=; b=d8GcKJtcPJmpxoEIGdcdfNV7Ko
	987vuULZ/+N8MOtfHQkJQxCbsGAwq4l50JZCxVKZeWZl86+7o+tRntEMMMJbgzkYpz4Ps9WBUSvKA
	dLDjimG4SnXz7fkD8FkFps3f6RBHIXE4Ke32d04F1rE+jLj86vrq5EpbRvL8XFDe4pQ5Ah2qaf8tj
	WRSvNf1dYRnco3tMm8WbDsVPeN0UVaRNeRJpJArpwQEPGfs2DCcxf38fzeI+IrgI8jz8fsPtznsk6
	cT3h34+RfnZuK/rvVbs0M8LVxRy2EUa5lSFyKGzlVRNsrCPx2dkVQFNufBwkBQf+fyWTE1VZvJamZ
	sVqCIZcg==;
Received: from 2a02-8389-2341-5b80-e44b-b36a-6403-8f06.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e44b:b36a:6403:8f06] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVRqz-00000007do2-0AoK;
	Wed, 08 Jan 2025 08:55:54 +0000
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
Subject: add STATX_DIO_READ_ALIGN v2
Date: Wed,  8 Jan 2025 09:55:28 +0100
Message-ID: <20250108085549.1296733-1-hch@lst.de>
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

file systems that write out of place usually require different alignment
for direct I/O writes than what they can do for reads.  This series tries
to address this by adding yet another statx field.

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

