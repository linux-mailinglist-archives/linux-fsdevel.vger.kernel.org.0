Return-Path: <linux-fsdevel+bounces-16696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A348A17EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3164F1C22355
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C7C17597;
	Thu, 11 Apr 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Gx/pmH40"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6900156CF;
	Thu, 11 Apr 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847239; cv=none; b=dwvfMiXijMIK3LLS1q8BFwJvukpEBN3Nr+m52oG8FOJOsjOZ10wr4M6oxF55/sZZDpgiAwE0BZkvCciG0ai//MHB2wWFc30sWyK7ts5O1JZi15no/yLd+pPJ3EdBE5IDcNEsk/sY0zG0CG39Efq+iWC5oNfqnWlQsRG42uzzY2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847239; c=relaxed/simple;
	bh=0sJklcroXx0twEuteSQyv6xJPzfQFPsElw9aR0ItkAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vp9h/pEEPoGdpgApNrbRUkjSUgBiJS493CQmKuQycASutdgjB+E/nfHkeooQKN3VxtyYjuJerlmb4VAwvy6fHBQLqpoFRNOkSu1WKJZ2eGuyFXZh7hVpJZFxLD5lChLbEUYHpcNfktcmO1pUMQ+JTZWV1TDzMASc+l3ivbvpPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Gx/pmH40; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=powD30dhU5To9qd0/tLSN14LVM1RvO26QHoNbh0+HyA=; b=Gx/pmH40FLMhnlL6MY4+hiCPaX
	r7KeziN8t37F6MlkbDhr8m0/70DHQQz+V3hRnQ/5A4S3Qi+GBaeXlwUD9r9+tJtLX2fPJPyEm1mFB
	oxO8JzLAhOkvDa2mv4+P9Xj0m46LxsZ0qgnEwsD0AK4Na19VeQQ1PS862UJ3n4FrTkgipq1bfoLh6
	WvsOBx9k8snK6qwhLu772w6feSSxVtWrhbCtIzyjk2zdLKNT9aYUoyAYTCxrxh9gZU/83VBwhSnh1
	U3ydVCSEhnrJ31yFdCrJe8DN+9UzQDimnrpQMQEE0FI77ddUZD4Ka35Xvt0Xo4v/vBhA/yPnFpew9
	1dEUTSXw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruvoB-00AYkb-00;
	Thu, 11 Apr 2024 14:53:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	hch@lst.de,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: [PATCH 04/11] gfs2: more obvious initializations of mapping->host
Date: Thu, 11 Apr 2024 15:53:39 +0100
Message-Id: <20240411145346.2516848-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
References: <20240411144930.GI2118490@ZenIV>
 <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

what's going on is copying the ->host of bdev's address_space

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/gfs2/glock.c      | 2 +-
 fs/gfs2/ops_fstype.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 34540f9d011c..1ebcf6c90f2b 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1227,7 +1227,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
 	mapping = gfs2_glock2aspace(gl);
 	if (mapping) {
                 mapping->a_ops = &gfs2_meta_aops;
-		mapping->host = s->s_bdev->bd_inode;
+		mapping->host = s->s_bdev->bd_mapping->host;
 		mapping->flags = 0;
 		mapping_set_gfp_mask(mapping, GFP_NOFS);
 		mapping->i_private_data = NULL;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 572d58e86296..fcf7dfd14f52 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -114,7 +114,7 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 
 	address_space_init_once(mapping);
 	mapping->a_ops = &gfs2_rgrp_aops;
-	mapping->host = sb->s_bdev->bd_inode;
+	mapping->host = sb->s_bdev->bd_mapping->host;
 	mapping->flags = 0;
 	mapping_set_gfp_mask(mapping, GFP_NOFS);
 	mapping->i_private_data = NULL;
-- 
2.39.2


