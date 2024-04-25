Return-Path: <linux-fsdevel+bounces-17826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1728B2954
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E75D1C2166A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 20:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5588C152166;
	Thu, 25 Apr 2024 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hZaRIiTZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E801509B1;
	Thu, 25 Apr 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075227; cv=none; b=fVbQUyr8RfFUK77Nv527O7yOrDuphnIttwtNYi+RfApSLtlkA5f8eq4EKLQd9hzv8Knzsbue7eWO/gEEbmaHDprf+xgpiZhofgz99RUJheye1gLTABrHVbiLCHWk+3RIc9C5jSZ5pzY33YKgGyOJ1H3hO5ZcWfWjbCNl5lQONgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075227; c=relaxed/simple;
	bh=et2Hcs8znt83TMzNzjOyrgb4KgwNt3rMEIRDvV87364=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDpFY42C+g6XuXrMaosa6OMYV7toOSTnSrj/jFB6H9LyzctL5921DdmwgPCs3OWw6Yl/g3uukO6IPoBjrR7fzwvuGQ6/3wIj1pmZOdGm4jMHiBBRzTDK4MAtcHcOTueg7gVUSANxL32ODIxIR2GTa+d7Mur7EucNl8OXwwbWd38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hZaRIiTZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CWkahd/7c0dNWOJ3gjnw/oed1ipfsFzi1RZ1N5IsR1s=; b=hZaRIiTZQlU34DfDwFH9xmwXQk
	vnq0sGJ3LivS7M0HpO2smopg0FRYefI+ayheYNtEwvJU2lF4r2vUqraYq67t/7UaZ7VHJNwocpU3d
	mqd/RaFvP4ncR0DYB8w4y34aK/aSnWW2meXQO0e4zzEVhXlZGK3Q37xuLJwjs+rQguI3qQlM/hu5y
	8jR657qs4vAMd1rmVUoi8o6xjkUEYWNiZ6FTifA6Zffw7Jc8R6p3clMo6HjkdSdxvCF6D3r8YJPfe
	eRer5DIVxqdRc2glwW5BKgCR04HmgWu1tn7v6ubr57AVuO9M5Sv7oKn59t4AfGcnmRtGzjz4C34L2
	kGAl+tXw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s05GT-004KYp-24;
	Thu, 25 Apr 2024 20:00:17 +0000
Date: Thu, 25 Apr 2024 21:00:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: [PATCH 6/6] z_erofs_pcluster_begin(): don't bother with rounding
 position down
Message-ID: <20240425200017.GF1031757@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
 <20240425195641.GJ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425195641.GJ2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

... and be more idiomatic when calculating ->pageofs_in.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/erofs/zdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d417e189f1a0..a4ff20b54cc1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -868,7 +868,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 	} else {
 		void *mptr;
 
-		mptr = erofs_read_metabuf(&map->buf, sb, erofs_pos(sb, blknr), EROFS_NO_KMAP);
+		mptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);
 		if (IS_ERR(mptr)) {
 			ret = PTR_ERR(mptr);
 			erofs_err(sb, "failed to get inline data %d", ret);
@@ -876,7 +876,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
 		}
 		get_page(map->buf.page);
 		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
-		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
+		fe->pcl->pageofs_in = offset_in_page(mptr);
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	}
 	/* file-backed inplace I/O pages are traversed in reverse order */
-- 
2.39.2


