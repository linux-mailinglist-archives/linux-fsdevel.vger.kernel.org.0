Return-Path: <linux-fsdevel+bounces-37687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFB89F5C8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 03:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E07577A4119
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 02:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5E12CDAE;
	Wed, 18 Dec 2024 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GTMS2yoi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2A35970;
	Wed, 18 Dec 2024 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734487343; cv=none; b=BfWrD23ehCWk3bwMl8qhQrKXPVZtVAQZURkxCCW577TDLYUwJ7ofrTvyS/tVpACNa7vXy3n+ysQ58HNkU/3IjG2duPCEixs0LSEO6cgiDFuSaxUe2GEC5DCHIRCACV/+0v918tmgnUWT2Emo9kT42J+DQaiXfPnWGd8Ly+9ZzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734487343; c=relaxed/simple;
	bh=Hk64SXnfRGJRi+/vHn7G8cK7dKWDRtkSs8XS8WFgCAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HqUf6Qt0tdSxKKoC6+TJ+xhbTzHAQnJDi8g5YJrnRxcox2+CGe+spY5IudRSNzc0p5PxG9RMLBKp3v+Sw1M3KzODsPPuubOy/JTNuf4Hxq+E2VQsthL0S/kghCdlhsigaUQzLSCJaYRmpM9IyqCjJdAUnjuJbzE9wwIur+VDfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GTMS2yoi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3kstiw8DGy+LZqa+lbGlsyzzHfy0quVH0jm/EBxZMLU=; b=GTMS2yoiwWY0Ifhn4wiYQbNRua
	4KJQeIDN7HDu+Dw/9OXzs10OmrFL0N5PUjsfWlXeTnUq2J5xm5niDWNDsrjodyh9mHNfXl8r7kYZZ
	/+e6bS0hW9cRe6WljMPqgw3OZqwU5O/XhqyqnFElL+2nJ51U4kh3BeqB+r/d69iOW44m0vFDcUVPF
	Tpxm/D6Th3cazeRtI3tewMwLx4VvY/Pjr/w02PtU8Oos0L0Eyur/SXyOkAYc1ejrt7MAhhJ1Yt6aP
	lyC005RYEEWmOmZovoiuoL5izpFxhl34H/EOzDeVM2iaHPwdrjierO+PWKxFT7fohKUz4ogKTKEqt
	YU9w6pCg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjO9-0000000FLOF-1AAW;
	Wed, 18 Dec 2024 02:02:13 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk,
	hch@lst.de,
	hare@suse.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH 0/2] block size limit cleanups
Date: Tue, 17 Dec 2024 18:02:10 -0800
Message-ID: <20241218020212.3657139-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

This spins off two change which introduces no functional changes from the
bs > ps block device patch series [0]. These are just cleanups.

[0] https://lkml.kernel.org/r/20241214031050.1337920-1-mcgrof@kernel.org

Luis Chamberlain (2):
  block/bdev: use helper for max block size check
  nvme: use blk_validate_block_size() for max LBA check

 block/bdev.c             | 3 +--
 drivers/nvme/host/core.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.43.0


