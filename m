Return-Path: <linux-fsdevel+bounces-17548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814408AF73A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 21:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1581F26061
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B582D1420C9;
	Tue, 23 Apr 2024 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cC+nvlSD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0C13E418;
	Tue, 23 Apr 2024 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900146; cv=none; b=Lz7bkWBay0DH6lVnjqPzaL+NB4tWOlVXCnYpWwb3uuJCQSBVPcy4Vhh/RGHNLRf4ap3L2iEWN3SzwKp59L0TpykSEnugE5VvpLUMPPRG9nSOvqvMz2hvYUOr/2r0WtjcNLbpbslvE6aQMlVHr0nBVFVPJZlB7fbvGIX6ElLpaEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900146; c=relaxed/simple;
	bh=EzZJdpIWTl/3iKD9na06geOh+GtZoEqR0B1J0ANSbjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PoYjRDfLjwNGIpHZ0DK0cFItugCXEHOUhVjP7rz0aZxyB8/Jce3zUodipRp0n7plewEtP0pFZ39H6D9fM2k4V05cuy1sjpW7bJP+BGztWRk7YqQvnpx/B01TyQ3Y4QyttlRKPF3xLqhBIc/9E6wZz4fPD/zIDhPqx8OafgPQkt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cC+nvlSD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vqg+UQbcLjVoton0Lyr5jOmE484v1UI4Nu+NsQykQGA=; b=cC+nvlSD6rnap4tYjYeYd+Z8Ra
	b/+aMyRJwkZtmMCvXI50gbKBl087u7PxkCWLxaARcr+JBB8KYqBxbqnQvyWH0l4FTWdpTi8yuahC5
	Oeuf8edLkZpYeQtK8HzQ3yKcGoGvX3lSombn2tKMO8y5jFrZgT7qb2LTH5WHC3cIb4koBevGeso3r
	SRrIu47jLKJUIvXQtdSHJWIN8jRMPEd7OX+Vcs2zWLFCoIDE8oNkJzhsCGD/m0473gPqsQsWDwlBQ
	bDKH6xmNe7yIwTme3vmcXxKAcYMIJtdNVXVmnGwDj+nl3T6muxxCdnOdDisIaxU4P1NrwlNaVFnog
	JArPsaLg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzLig-00000001GKY-25wk;
	Tue, 23 Apr 2024 19:22:22 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	Liam.Howlett@oracle.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	david@fromorbit.com,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH v2 0/2] test_xarray: couple of fixes for v6-9-rc6
Date: Tue, 23 Apr 2024 12:22:19 -0700
Message-ID: <20240423192221.301095-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Andrew,

Provided there are no issues by folks with these two patches, here are a couple
of fixes which should be merged into the queue for v6.9-rc6.  The first one was
reported by Liam, after fixing that I noticed an issue which a test, and a fix
for that is on the second patch.

I wasn't even aware that you can test xarray in userspace, cool beans.

V2: add Fixes tag.

Luis Chamberlain (2):
  tools: fix userspace compilation with new test_xarray changes
  lib/test_xarray.c: fix error assumptions on
    check_xa_multi_store_adv_add()

 lib/test_xarray.c                       | 13 +++++++++----
 tools/testing/radix-tree/linux/kernel.h |  2 ++
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.43.0


