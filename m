Return-Path: <linux-fsdevel+bounces-41033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A5A2A11A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40ACC167897
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9C2224B02;
	Thu,  6 Feb 2025 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xz6Lgs9u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841242253E1;
	Thu,  6 Feb 2025 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824057; cv=none; b=YokaDCjk3gzN8Of1OkEXDMsgUMBNQYw4XGVB9pkk3NKNqJJKJXw0ajxA954q7lPfwSM3OqKStCEUJJjZGqWyRHtVJxljQ1pTH71PlYAIO0OdEVzZkaoB8t7e8IyOzw2vbUmY3PW++PqF6+GAP/5i/DBC5fCIxPv/7H1l69CQrRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824057; c=relaxed/simple;
	bh=mT51tQfoopx9xtqQyBUbFzMcpdKBNgUpar9ueNdIeS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibsCRC3rE+dugmeolI5wHURs3Yr6ZnwhBHx2Cp6EbJNzcr17dlPnEP5b1F8J2CG+FM1VFOG/2Hu7onmijljt5AYjintODsERyhHxWGDALTwuBeacH5raKzNNU/CoDWmXizJdZt3m/bx1t0ZZZxF9eI/LjSR1jsYbuUrXEVKsfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xz6Lgs9u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Vq+1dXNbIakkcSTYO+Spc+n1+X+QlIFvv/1cYLB7P+M=; b=xz6Lgs9uRRhRMQFCl09n/9rEPP
	UJTKhBOhHUy4CFPnqiPj5ayzRxm4ybTVBGSEsfA1P1idIC37xZUwcxmRCwFM5u3ofnr8sbKiuuyjs
	ihH+B9onhM5l9ozLAbmoHvBn5yNnX0fT5GNtymgwgThNo8cGwmFItaIhT16EMOiQ1nGsk5ZjO2AJS
	8Q0GHavxqBcmxxSH2FsG8GiUwAThmE0sIQR1IKPrZhwKza9JpE0bnZF6sPOY8thqzMpagFVdSF4OP
	mfLx6S9Xu1admyD+buKrbizDacI4LN4O/bEiNaeJ2/sdgmgme3Ore30ukaOS4olP7XYVYYaF2vqa8
	0BmT2G9w==;
Received: from 2a02-8389-2341-5b80-9d5d-e9d2-4927-2bd6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9d5d:e9d2:4927:2bd6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfvZH-00000005PWP-3Uhh;
	Thu, 06 Feb 2025 06:40:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/11] iomap: add a io_private field to struct iomap_ioend
Date: Thu,  6 Feb 2025 07:40:06 +0100
Message-ID: <20250206064035.2323428-9-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206064035.2323428-1-hch@lst.de>
References: <20250206064035.2323428-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a private data field to struct iomap_ioend so that the file system
can attach information to it.  Zoned XFS will use this for a pointer to
the open zone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/ioend.c      | 1 +
 include/linux/iomap.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 44f254ecab55..18894ebba6db 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -23,6 +23,7 @@ struct iomap_ioend *iomap_init_ioend(struct inode *inode,
 	ioend->io_offset = file_offset;
 	ioend->io_size = bio->bi_iter.bi_size;
 	ioend->io_sector = bio->bi_iter.bi_sector;
+	ioend->io_private = NULL;
 	return ioend;
 }
 EXPORT_SYMBOL_GPL(iomap_init_ioend);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5768b9f2a1cc..b4be07e8ec94 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -370,6 +370,7 @@ struct iomap_ioend {
 	struct iomap_ioend	*io_parent;	/* parent for completions */
 	loff_t			io_offset;	/* offset in the file */
 	sector_t		io_sector;	/* start sector of ioend */
+	void			*io_private;	/* file system private data */
 	struct bio		io_bio;		/* MUST BE LAST! */
 };
 
-- 
2.45.2


