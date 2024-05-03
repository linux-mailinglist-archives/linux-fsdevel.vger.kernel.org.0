Return-Path: <linux-fsdevel+bounces-18565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0278BA5F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 06:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C2A283892
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 04:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6DA27447;
	Fri,  3 May 2024 04:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="egc8ceLi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCC4224D4
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709863; cv=none; b=tqmGteNZEGIrImwZCCMtlG2JcNuzsOTbHG3uDucZk/zKXi/EwDeY7gj5TwNw0PTTj23r8OZrkpoiDe34UWKGNpQHOPSLMY3TyE9sJKyuJqCG6FeTeuFsEvYUxh5wzynZNIYieoqbBZuXXV/pn46jQ9+vjr/BH+omfbUoGFYU+yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709863; c=relaxed/simple;
	bh=NocbQBxKcyJelIDA1CsgTAp6trZZyE/fEv+c5mWg8DY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B4cQFu56FXV/VRisRQx+IuhCLpF02pFSEcmv/tw1e5VAd7hdITJWxBSATNXEXwnhh6Xb6OHEo+xtG9qdNAJCtbl7UXrs4t4KsZ6oD2Pw1DJZhawZfuyKiiZ02IyEQtm3HL8m07St3vWRYoXHyWOlMr1KVfzXRcmv0TrH6BU0Ew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=egc8ceLi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=soKYu4AIzkQ6eIL3mrQB3BPphhAGIT6bosMOIB+slWg=; b=egc8ceLiSobnMkTf7B1Ue0NQQu
	b1IZqdCEloxCmFGfABoeOTiv5DH052IV5PcsyrGHIiFlZAmkV7VGrDTj7EAQfDZF6283poQpxFwLO
	8DNIkqbqo2j9r0P5I0mJ51Lgsk2zGgptR9hZDwIkKfe2RniKA8hGsEzNg2wl0D4PyG3VTuQ/25FPz
	QFNqQZtRrd90WH89pftXSRqfok7IE2RmKvwRlE/qj7LePA8XjuPYTiJUJ33VA/DoZmd5un7edEiEp
	EGSrxwf5EgVY3F4CSEDwIkDuJ64QQLE2gdtosEXe0rmKoOmy8IltQ8CTWeluBITo9dVzW2cR96EPE
	0Gql/yfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2kMe-00A5VB-0Z
	for linux-fsdevel@vger.kernel.org;
	Fri, 03 May 2024 04:17:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/9] bcache_register(): don't bother with set_blocksize()
Date: Fri,  3 May 2024 05:17:32 +0100
Message-Id: <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503031833.GU2118490@ZenIV>
References: <20240503031833.GU2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

We are not using __bread() anymore and read_cache_page_gfp() doesn't
care about block size.  Moreover, we should *not* change block
size on a device that is currently held exclusive - filesystems
that use buffer cache expect the block numbers to be interpreted
in units set by filesystem.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
ACKed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/md/bcache/super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 330bcd9ea4a9..0ee5e17ae2dd 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2554,10 +2554,6 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	if (IS_ERR(bdev_file))
 		goto out_free_sb;
 
-	err = "failed to set blocksize";
-	if (set_blocksize(file_bdev(bdev_file), 4096))
-		goto out_blkdev_put;
-
 	err = read_super(sb, file_bdev(bdev_file), &sb_disk);
 	if (err)
 		goto out_blkdev_put;
-- 
2.39.2


