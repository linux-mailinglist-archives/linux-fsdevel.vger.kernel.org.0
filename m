Return-Path: <linux-fsdevel+bounces-25218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2851949E9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 05:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44093B20A78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 03:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D364191F8F;
	Wed,  7 Aug 2024 03:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kBpsMhbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879001A269;
	Wed,  7 Aug 2024 03:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002383; cv=none; b=d+oXrm4eGJTsTMXQ2RqhY79GEMDWhXj5HG/Zo0RQdQ2sWKJvc4NSNgCIs3OldNS96zMDFFqhKe0Oi+bAZp2/1M2xUNh20RzbKTC1pblivQbimA/SrsNyqQqtS0zLsR60JLTd+zZkHahRymC2xlmGTuZXyGq+69NzkjlcQahH85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002383; c=relaxed/simple;
	bh=S7xTj1+BRrFzibxP14qb9afX2Rlcc7Yzirv1sNhukC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r35b0so3qFIjK2gQC4RJydfRZCD3att8F6kgWZ9yFNloc9sqTHdBSYbttKQ4PSFkeOf0+PJMuXYMuuhm5WiJlM/frXCteqFGAQ3eUZtE1U8p3Efn4QCnjhxQ27+USrURN5v3GOEN/o4/Cdm6xCoLOfCQc3/cvrDAB15fhumu5Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kBpsMhbZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jy5sBXXGr2voNP18guOdqKk17MKFMl8ptCuzk1nlp0Q=; b=kBpsMhbZ+1Pgy99WHBD3YzI4XG
	Hqy0KiWbREOfNTGd4D85Ztw2vyfymYiId0v/fTjNdlVAQK/i5x/NoKEy/QsyytCQ29qGuUAPcq9Qm
	vjWq9+4BtI6nienJ8u7m7JMTT8t8SpdKlmHFaOFuyV61i2voDWVr/HNRi6uBFNEFEKkv5wF5jsRT4
	QsFXi0/Oqo98Wx1ic4RCpOZYs5IrLeuD9EiwRoO7eiq16UpiiqcAEe8uXB9oQygLNDqEwGOxHUSal
	larh/IiUtXsxc/JN3FDf2sNmqYdwc6o9DNqJ+ZGljoforqQ0namjXayDrOo23zksSQNAh0C4Om5cd
	UgGbrBrg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbXct-00000006gRT-3Off;
	Wed, 07 Aug 2024 03:46:16 +0000
Date: Wed, 7 Aug 2024 04:46:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <oliver.sang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Brauner <brauner@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-bcachefs@vger.kernel.org,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
	reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [fs]  cdc4ad36a8:
 kernel_BUG_at_include/linux/page-flags.h
Message-ID: <ZrLuBz1eBdgFzIyC@casper.infradead.org>
References: <202408062249.2194d51b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408062249.2194d51b-lkp@intel.com>

On Tue, Aug 06, 2024 at 10:26:17PM +0800, kernel test robot wrote:
> kernel test robot noticed "kernel_BUG_at_include/linux/page-flags.h" on:
> 
> commit: cdc4ad36a871b7ac43fcc6b2891058d332ce60ce ("fs: Convert aops->write_begin to take a folio")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 1e391b34f6aa043c7afa40a2103163a0ef06d179]
> 
> in testcase: boot

This patch should fix it.

Christian, can you squash the fix in?


diff --git a/mm/shmem.c b/mm/shmem.c
index 7d28304aea0f..66ff87417090 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2904,7 +2904,8 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	if (ret)
 		return ret;
 
-	if (folio_test_has_hwpoisoned(folio)) {
+	if (folio_test_hwpoison(folio) ||
+	    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio))) {
 		folio_unlock(folio);
 		folio_put(folio);
 		return -EIO;

