Return-Path: <linux-fsdevel+bounces-64416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55579BE6E3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 09:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFE9422A80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 07:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A20311943;
	Fri, 17 Oct 2025 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fsT2Isd9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518C310625;
	Fri, 17 Oct 2025 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684884; cv=none; b=LzcNxTLZlsp/Y7tGOx1tWwVK/nPuqprpqZ4b3odt9NWiiwNEw5Pui6gDSPBRtF4AcmFg+w+4cIgtcq1LItEf5FAg0ItDIITyaVgcRgnuVEtSIF2D2dHBcZOmP3NvyJpwN/mnnZLmGfX5c+WVFomnjLZ7aWCBCmRWoFfZNakaeF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684884; c=relaxed/simple;
	bh=c+p2EOnfSjgU7eznQF3IOv148U2gld7mSGFhtiFvcO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oalc8oupdeAANqsvsEYxYgooAF0PEpQDumSQs9f9wZFLqDi/dgOWLkEgMpbimnhqOi3N+B9mPd0WjxSTuttJKlSQK9R+6f/eQ5UbmK8v/zl3s71gzwuRQmuyQfo2WBycGMVzfgLUw9GJK7VK1m9nU8Eh1vO1G3k7PIEbTcottKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fsT2Isd9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VBx1ZOxv1Kov0BXvIk+Fax9Fpj20VkMMtF1vJ/HqGVs=; b=fsT2Isd9m3wxuuHcjEOaHlpCLR
	3nZcQ9yx4fWNDf4V318PFvEw9yR9/s8ssEtlT18DBAPu6VFqRdpD5zIpisuULnOl2R/oapPRxlaP1
	Y4zJ/bMj3jB2ORKzSquK55H3CIPcSuChH2vi2+QOVDuCdjSp5BAuIEgfMWka5T5O9DygaZ+Qpqc1p
	gtief+HSzxrhespy+kYiiKAGy6BVBvWEuoIeg/qwETxpc5HvkTeURzclm8ghTfHNFcbIzgAV7cviZ
	1JTaFmccMWti86MgerG4v15I8AByfqwtVgoeezIOxio8idr+AjNL/GWWAH/LWrBsUWlvBvbpmeXX1
	iPfnstng==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9eZG-00000006vtE-3Ati;
	Fri, 17 Oct 2025 07:08:02 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] sysctl: fix kernel-doc format warning
Date: Fri, 17 Oct 2025 00:08:02 -0700
Message-ID: <20251017070802.1639215-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the "type" struct member using '@type' to avoid a kernel-doc
warning:

Warning: include/linux/sysctl.h:178 Incorrect use of kernel-doc format:
 * enum type - Enumeration to differentiate between ctl target types

Fixes: 2f2665c13af4 ("sysctl: replace child with an enumeration")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
---
 include/linux/sysctl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20251016.orig/include/linux/sysctl.h
+++ linux-next-20251016/include/linux/sysctl.h
@@ -176,7 +176,7 @@ struct ctl_table_header {
 	struct ctl_node *node;
 	struct hlist_head inodes; /* head for proc_inode->sysctl_inodes */
 	/**
-	 * enum type - Enumeration to differentiate between ctl target types
+	 * @type: Enumeration to differentiate between ctl target types
 	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
 	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
 	 *                                       empty directory target to serve

