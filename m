Return-Path: <linux-fsdevel+bounces-974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259E57D47A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4068D1C20B5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 06:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CAC11721;
	Tue, 24 Oct 2023 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z/koJWZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65048101E3
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 06:44:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7F1111;
	Mon, 23 Oct 2023 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=mWJbrqGyOWZeG8arA3kiVOL37IHuK2xpDuB998/3rz0=; b=z/koJWZinP93IY3dpVf4azl6nx
	9ZjZXmOm83+5dIu6+Hdiqeiv2fLG6s+3JktdHxcWCNgsG/9EO9bUQuV5dKZKOXCBWhCe3i0zSeCMH
	lDoagtXHwO7U9dEf2seHBV5hBW0BuYDeDDmNenjcbDxBX/ONdDW5egCa8h2+iXRKr55TW13TC7+Iz
	UmL4FW4g8FLWJQ3kWws+XwRuLd7FYluXIuvR5dijb6jEijG5RocFccb0TOgik5oH5LlBnhV4uwZKE
	/aTGfJ7EeD8pauHT2HSIi/g3MAA2SaAKK7J4BRJg+jDxyDESVUYZnUHNsQ47Za5cWo43AX4884xQ2
	FlGywEMQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qvB9I-0090RP-18;
	Tue, 24 Oct 2023 06:44:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: add and use a per-mapping stable writes flag
Date: Tue, 24 Oct 2023 08:44:13 +0200
Message-Id: <20231024064416.897956-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all

A while ago Ilya pointer out that since commit 1cb039f3dc16 ("bdi:
replace BDI_CAP_STABLE_WRITES with a queue and a sb flag"), the stable
write flag on the queue wasn't used for writes to the block devices
nodes any more, and willy suggested fixing this by adding a stable write
flags on each address_space.  This series implements this fix, and also
fixes the stable write flag when the XFS RT device requires it, but the
main device doesn't (which is probably more a theoretical than a
practical problem).

Diffstat:
 block/bdev.c            |    2 ++
 fs/inode.c              |    2 ++
 fs/xfs/xfs_inode.h      |    8 ++++++++
 fs/xfs/xfs_ioctl.c      |    9 +++++++++
 fs/xfs/xfs_iops.c       |    7 +++++++
 include/linux/pagemap.h |   17 +++++++++++++++++
 mm/page-writeback.c     |    2 +-
 7 files changed, 46 insertions(+), 1 deletion(-)

