Return-Path: <linux-fsdevel+bounces-64203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35D4BDCB9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 08:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A753C8200
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 06:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CC83101D7;
	Wed, 15 Oct 2025 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qcD8JhUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646473101A0;
	Wed, 15 Oct 2025 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509657; cv=none; b=MzY8Ag4fXnleBdjamR5Z23QGFp94s5jsX32yeGf0Ywcx8/oUwe3GWZwItgeOUUZ2uAjglejyA1CbOJPFCoEiIFhzlDvHebyVSl9E6KVLh5UjmYbBatyUeBGlURPeJT4dplMEKbHvRmcHowKNBvlgO4guXHA9bgdhEPTaCapFpfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509657; c=relaxed/simple;
	bh=bozsaBDORkNOdTOsfLOh+stJqppxciPfgqt524YhrwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVS5L8c1vC3KagR7Mcs+beI5l++TJahQpvUin/wN15cEU/ncfsRTG1GWEPCN0HGFejrfHEqhNhXP71d64ookZUkUpp8HzwRWeEar0eBiR7bvxfxJeCI6bF0pCWp3jbOT/WgfHoI3HVrQITJLszoshXiR0TEpX4jdfrDnWJSkMFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qcD8JhUe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Bf9tiNbfU41flJV3errjkwpyui3XNhOh03t9EHC+1tw=; b=qcD8JhUebCykZtn7+GYefOSj1l
	Fk5fCmxpfp8tCPOpE2BefBuilykQh94zlJ1sy93Gb6kddayF9ygtJndyvHDWERMhBTsozes4sMdoE
	/aGoYwSg+o7RxDZSfgmT1qYH/Q/h90eOmiZMtgQ25K494BkEukE8JxeiGY2z+khvvGOSUXTHbgSve
	5fAYNj6FrAwTHfnb4ORv7OSp/B1kqOKs+FObozjVhpa3ZMFZUb7es4pfVK9fH+62CBAgIJY1ZOKPD
	N7wz5N/92jglQPEbN72PQ5Eb4E0q0dImWNw8+N4M/lxtsFdhyWzKOxL4ZAUDhWD+ni6jlwiFljFfW
	G7p2sp2g==;
Received: from [38.87.93.141] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8uyy-00000000bCg-26Jk;
	Wed, 15 Oct 2025 06:27:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	willy@infradead.org,
	dlemoal@kernel.org,
	hans.holmberg@wdc.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: allow file systems to increase the minimum writeback chunk size
Date: Wed, 15 Oct 2025 15:27:13 +0900
Message-ID: <20251015062728.60104-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

The relatively low minimal writeback size of 4MiB leads means that
written back inodes on rotational media are switched a lot.  Besides
introducing additional seeks, this also can lead to extreme file
fragmentation on zoned devices when a lot of files are cached relative
to the available writeback bandwidth.
							         
Add a superblock field that allows the file system to override the
default size, and set it to the zone size for zoned XFS.

Diffstat:
 b/fs/fs-writeback.c         |   14 +++++---------
 b/fs/super.c                |    1 +
 b/fs/xfs/xfs_zone_alloc.c   |    7 +++++--
 b/include/linux/fs.h        |    1 +
 b/include/linux/writeback.h |    5 +++++
 fs/fs-writeback.c           |   14 +++++---------
 6 files changed, 22 insertions(+), 20 deletions(-)

