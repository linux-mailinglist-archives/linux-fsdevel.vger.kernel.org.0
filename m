Return-Path: <linux-fsdevel+bounces-51753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711BDADB0D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 15:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507851728C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0512DBF6B;
	Mon, 16 Jun 2025 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZwATEYTA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23FA29B78F;
	Mon, 16 Jun 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078806; cv=none; b=gL2lIhK/bUVIJ5FEvMdc04giHDNUN0203PmDjcZcRpNqs5sRdWg7yFcy3WnL5OITrE0dnXMMGhMOfgbE9viK81rNRXl7q9MQmhMkq3f/YzhIX4QH4NfuHdxvbB0UPy0opDg2ZxOyI7mnmq81vki7sFPAiD6EnaYBvdw3kY9vRXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078806; c=relaxed/simple;
	bh=e1uSwlLdErjqDZyWzU/hj0Na9sgtKk4iemqYCXEZKoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mce1mi7sVGwHzzBtj2G73al6epFrlBwJDD5O6UjbPkwL/36nrGN3jASxlPEhzrMo0u7/CAc8m+m7XGe2aapT6bcU57Jk5hJ7UR0M7j5AVjHn2wLfqMFKiGlaiBgsQb7K/Ch2KWcFsG83wzNdqQSgjD8LWSd3wj8vQ/As19jI4kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZwATEYTA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8tVwLUserej16NPd2Va9129cuYtZXyZKK5GU8UvfgUs=; b=ZwATEYTAkiIHRmeyPXkG3m7K3e
	JcRVg7Hee5fczHT/wV51TOtCvQWBj2I2z5DQzIFi9rFl2buCMhMgtzU8pgEQk4/9J3hpjzh7ihDSo
	PY4i+Jgc89RrwzyQWIZhfmmKUxDMuRQOJX2Fuvv2Id24SwFWIA04C7JHI/zTFPXd61AxVmEHMyxUw
	GCJcepmM/DZ1yveEgqqbzfPV8xZmVIYOlh4LntwMRD3yeMn9fqjw2XOJK3m2yUFN7auGXMwCCOf8g
	i4Vwl8gYnLyIx9kNH0msLgWjLEkvvevAsS8Q11l5P47C69kKZE17rUDDcsBbwC33m1CrrKJ/HxZl9
	5XjaM8xA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9RT-00000004Sae-1Hm9;
	Mon, 16 Jun 2025 13:00:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: refactor the iomap writeback code
Date: Mon, 16 Jun 2025 14:59:01 +0200
Message-ID: <20250616125957.3139793-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this is an alternative approach to the writeback part of the
"fuse: use iomap for buffered writes + writeback" series from Joanne.
It only handles the writeback side, not the write into page cache or
read sides, and also doesn't allow building the writeback code without
CONFIG_BLOCK yet, despite making some progress to that.

The big difference compared to Joanne's version is that I hope the
split between the generic and ioend/bio based writeback code is a bit
cleaner here.  We have two methods that define the split between the
generic writeback code, and the implemementation of it, and all knowledge
of ioends and bios now sits below that layer.

Diffstat:
 Documentation/filesystems/iomap/operations.rst |   37 --
 block/fops.c                                   |   25 +
 fs/gfs2/aops.c                                 |    8 
 fs/gfs2/bmap.c                                 |   15 -
 fs/iomap/buffered-io.c                         |  323 +++----------------------
 fs/iomap/internal.h                            |    1 
 fs/iomap/ioend.c                               |  220 ++++++++++++++++-
 fs/iomap/trace.h                               |    2 
 fs/xfs/xfs_aops.c                              |  238 ++++++++++--------
 fs/zonefs/file.c                               |   29 +-
 include/linux/iomap.h                          |   48 +--
 11 files changed, 487 insertions(+), 459 deletions(-)

