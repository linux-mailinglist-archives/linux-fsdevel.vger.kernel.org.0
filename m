Return-Path: <linux-fsdevel+bounces-6554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6529819809
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 06:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D481F2497D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 05:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E688156C8;
	Wed, 20 Dec 2023 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BVU4CFKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42814F65;
	Wed, 20 Dec 2023 05:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NagWBOwhQpzgItNonYmSZAcEuPBWdXAlV9sGuh4zWX8=; b=BVU4CFKu2Uxp5110zGqtI4v1PL
	Pdtdum77NyVbqRZNl6rMQUxQ2Zgy5Rmqz2u/wNVsAq7VLd7rVrQQObJAQy6stnS27SoLXBtxZnC5v
	/PhQYMU/qVyLz6xfjkR/Bvcqp71XIW7SZSdrFJptHRW8WxuCauTwnrJZHlTFWK0bDxOpC6qpl0E//
	7SC1Y4oENollcpi123KyC73Zdku8PwP+yeBtVSHnNpOd5n1+QVlhtrybNWiduhNCu6SE0T+iEneV+
	FhZqtCAUxKB/X6XKiyQ5ZQ7KYfnNZvO2skK6btFvdR2eo6lecA01FGbxcd1mKHI8CD4fKDFAJ1RaT
	aGCJnluA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFp0o-00HInT-0T;
	Wed, 20 Dec 2023 05:20:54 +0000
Date: Wed, 20 Dec 2023 05:20:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org
Subject: [PATCH 07/22] ceph: d_obtain_{alias,root}(ERR_PTR(...)) will do the
 right thing
Message-ID: <20231220052054.GF1674809@ZenIV>
References: <20231220051348.GY1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220051348.GY1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/export.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 726af69d4d62..a79f163ae4ed 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -286,8 +286,6 @@ static struct dentry *__snapfh_to_dentry(struct super_block *sb,
 		doutc(cl, "%llx.%llx parent %llx hash %x err=%d", vino.ino,
 		      vino.snap, sfh->parent_ino, sfh->hash, err);
 	}
-	if (IS_ERR(inode))
-		return ERR_CAST(inode);
 	/* see comments in ceph_get_parent() */
 	return unlinked ? d_obtain_root(inode) : d_obtain_alias(inode);
 }
-- 
2.39.2


