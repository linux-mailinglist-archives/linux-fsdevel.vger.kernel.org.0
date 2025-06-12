Return-Path: <linux-fsdevel+bounces-51501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71241AD742A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4462C0BAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D5C2550CF;
	Thu, 12 Jun 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d+6oAeBO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF2254869
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739148; cv=none; b=dev8V7o7FbAkXxrsshV7jY/ItHSsdYjuIzviXUT1oGFmZUfOKZZjdpqHU3PyrqC6UVpfWSCYEaaG4JBG10pu4wlTZDEy875HcUADrVvaFI6dLD6dL+7WwCRtz/whfTK0/PhM+2OeUaPcx9Ssw+nJ5w6UyEUn2ReCjOQjO4dwemc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739148; c=relaxed/simple;
	bh=ccUudFjoKbL5pxh5Ts0dAIPV2u4bU/LqR8Qzyhmjp+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMcSCI1sNBuBBMoloVOhPqrpeWOKt0Bkh/u15ybsGVjKGvWKg/YLUmrggxkxZWfKqA9COQEPjJp3MxvbtSUa4gaCb3tdPxru8sM3qg+BeV/CC1vjmhtYr1m2oXQGOB5Ne2cWnjlwbXafz1TloyCdC6Rd5X3IvxK3hDzhiqiTCgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d+6oAeBO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ZbHcNGwVyW0bZsGH/Oe1DQB0C0q3nsMsmiG6jQc28lA=; b=d+6oAeBO6MWnzrsd60Aaus/b58
	Beg1UvzE7Som5k8uWggMDuWAI8QaInhywFBCG9x3qqsGCwWRVw0PEmlzZvwRHOdEvkUxp1d1TbtUe
	Bx+TcoJ+JDp+Z6VaDkK2tBnxZ2TD9a+TQaiCu15cOylmZg3yXwX1FzZMgPm9VD1p+LFfdNU3UCC+K
	ufeT/0Ap9oSmHs+SoWIscevT5Bz7ETUS6Nk/H26Eyod9Zz+fmlgDlZqPljq9g5hfMx+zmxi18W8Gl
	UASRLQZvAb8jTAZP7tB4Qkz7CgjVhoVTtGiYSLQo3XNudlULhG/RMN22vntMI77XTVb5ausd0cyik
	aGgIHdYw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPj57-0000000BxEW-0NvR;
	Thu, 12 Jun 2025 14:39:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Phillip Lougher <phillip@squashfs.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] squashfs: Remove page->mapping references
Date: Thu, 12 Jun 2025 15:38:59 +0100
Message-ID: <20250612143903.2849289-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're close to being able to kill page->mapping.  These two patches get
us a little bit closer.

Matthew Wilcox (Oracle) (2):
  squashfs: Pass the inode to squashfs_readahead_fragment()
  squashfs: Use folios in squashfs_bio_read_cached()

 fs/squashfs/block.c | 45 ++++++++++++++++++++++-----------------------
 fs/squashfs/file.c  |  7 +++----
 2 files changed, 25 insertions(+), 27 deletions(-)

-- 
2.47.2


