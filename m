Return-Path: <linux-fsdevel+bounces-24030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B7937BDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 19:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD5E1C21B0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2AB1474CE;
	Fri, 19 Jul 2024 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M60DHghG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D61474B6;
	Fri, 19 Jul 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411477; cv=none; b=deLRxIGKhdZpltezg5HjdeXlqtcpiaGPK6BGQMADY+5r64k50J8VnRyKiDf1tz0XaJnza6jFy7SNTwrVyafJv1urrMz4/iu2EY85nhDQV8Limb3b4Nn0jKzkg21ciDkrvTYsoJZ+faV6JiHJrhIKZ+CWPwA6yMoBZQKXLvH2yUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411477; c=relaxed/simple;
	bh=CRz8k3HTuooGAxsJPa1nycCff8Abgj7enByDexJkR18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ho2hqYly9Zf8V4yOZEFSmzWh+qx4Z4W9xoJ8MH8wOJQCp97bQYV2QErCTy6iSuQorkT4l3s6XyXr2R0y9MSu44SpOsDbVGHU/ittIp35SUcqhBBd3srXDuUtqivNhTl8Pk0xw/COkmx1l/pR2hqUe+Fa1N8exdFobGYeCAZW9kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M60DHghG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=2Xnp6qrgaJvcjlO5v2NL5ahM/o+86YGtr10T49BBtSg=; b=M60DHghGOq+8ehb/MPjEIwVNna
	OqFS6jJg7CuWohcbpv6GBVqRVOHkuFdvDbtBeFqYnaExC8Hs2p+fNlxAuqk/8v2HVs4W7aq5seYGw
	QRXrJWwhaJC6DSM3XR7BYNT/j5pnRPuaGrqeNCcbZ9aeJLe3u63tPQ8XbQiE4Ivh6IEMb5D0LlT7Q
	wfU4KyBAMnA/q7ACpdA07Z0YU9p6PJOLgCpTu0R2VN5h+ea/3gIKjdpZ5un8L8tKxgYezI9dsarJ4
	Gozeumc+mmFhVkVipfOAOskOPfpkPzx3xauyy91SAuW14jgfck+Dkyb5Q8jHnRVAs6wZbmG2NN7M+
	UUnPTkSg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUrl9-00000003J4Z-0bXm;
	Fri, 19 Jul 2024 17:51:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] Remove uses of aops->writepage from gfs2
Date: Fri, 19 Jul 2024 18:51:00 +0100
Message-ID: <20240719175105.788253-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andreas,

Here's my latest attempt to switch gfs2 from ->writepage to
->writepages.  I've been a bit more careful this time; I'm not sure
whether __gfs2_writepage() could call gfs2_aspace_writepage(), but
this order of patches shouldn't break any bisection.

Matthew Wilcox (Oracle) (4):
  gfs2: Add gfs2_aspace_writepages()
  gfs2: Remove __gfs2_writepage()
  gfs2: Remove gfs2_jdata_writepage()
  gfs2: Remove gfs2_aspace_writepage()

 fs/gfs2/aops.c    | 30 ------------------------------
 fs/gfs2/log.c     | 12 ++----------
 fs/gfs2/meta_io.c | 24 +++++++++++++++++-------
 3 files changed, 19 insertions(+), 47 deletions(-)

-- 
2.43.0


