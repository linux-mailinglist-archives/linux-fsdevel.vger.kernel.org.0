Return-Path: <linux-fsdevel+bounces-17825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486D38B2950
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69BD1F220DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 20:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743EB15253A;
	Thu, 25 Apr 2024 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d3rirtyB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51761152166;
	Thu, 25 Apr 2024 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075195; cv=none; b=KBLOlpDvUdxzbXdCR8FjbZ3OHoURr9fD54KSOG09Gx2fexRlUVxgTFXlnDIb2mKdeN0BT11CJmIOjlQ1I3+ea6wSnwto56S36E56zqdh4wrxX0t9CEThoV+DjH7dUN8DUJvJbIExf5IOVRee62F1L8n7x9bIiPECCk8RHaM4gFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075195; c=relaxed/simple;
	bh=36smUnp+akhP8BPhodQ9jKtqIhW4f0YGIVbUQ3ifVnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsiW+rzJGcqdpEkTlHmyy6hnsXHkmpZW21c8CwfCN4XW5KPvNK1WjZWxTeo5F1zQwkmLfFGYYWOrqiUutXIB/om540DLZLUcgv8umReZlStzJBAprBhoFBSAmzZdMeHaCMPJpejaP3BaxWaZVAAQ7keu9VmPY5c2gyt5DGufpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d3rirtyB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1/A6EPRYlgPkVcT/gEicL5tptJT8BYi4kFZJ/grRn58=; b=d3rirtyBX/nRQkrUpHBK42qJm8
	vzFTGUylLUcMmgI7I6KYX3CBRnTrv5+P5nALihbIQ808vnjP8uvAPMjBt4md3UST9xOmhYlYEwCes
	nYsog6AtNKYJnFjsfrR2g2oi+W6VTD3V70HSU/9rtSKMn0anMYN4CM070/er4WUQFEHypGCiTy0Lh
	8pSFMp+jdTVy4XweRm+QyMUKmQprb+ejpdETo8w88Hasf/mvQCiNjr5pWWVzqIezQWJ/jRe0jrPyh
	wS8PXB3p4MZZSdjoOdI3F1b+XSLFsvm2pEfgb5VGSmGokHjEYZQctvxbqleYO53XfsIyvvzlUUV/u
	vJO0prEw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s05Fw-004KX6-2B;
	Thu, 25 Apr 2024 19:59:44 +0000
Date: Thu, 25 Apr 2024 20:59:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: [PATCH 5/6] erofs: don't round offset down for erofs_read_metabuf()
Message-ID: <20240425195944.GE1031757@ZenIV>
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

There's only one place where struct z_erofs_maprecorder ->kaddr is
used not in the same function that has assigned it -
the value read in unpack_compacted_index() gets calculated in
z_erofs_load_compact_lcluster().  With minor massage we can switch
to storing it with offset in block already added.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/erofs/zmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 7c7151c22067..5f9ece0c2a03 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -34,13 +34,13 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	unsigned int advise, type;
 
 	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      erofs_pos(inode->i_sb, erofs_blknr(inode->i_sb, pos)), EROFS_KMAP);
+				      pos, EROFS_KMAP);
 	if (IS_ERR(m->kaddr))
 		return PTR_ERR(m->kaddr);
 
 	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
 	m->lcn = lcn;
-	di = m->kaddr + erofs_blkoff(inode->i_sb, pos);
+	di = m->kaddr;
 
 	advise = le16_to_cpu(di->di_advise);
 	type = (advise >> Z_EROFS_LI_LCLUSTER_TYPE_BIT) &
@@ -120,7 +120,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 {
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	unsigned int vcnt, base, lo, lobits, encodebits, nblk, eofs;
+	unsigned int vcnt, lo, lobits, encodebits, nblk, bytes;
 	int i;
 	u8 *in, type;
 	bool big_pcluster;
@@ -138,11 +138,11 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
 	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
-	eofs = erofs_blkoff(m->inode->i_sb, pos);
-	base = round_down(eofs, vcnt << amortizedshift);
-	in = m->kaddr + base;
+	bytes = pos & ((vcnt << amortizedshift) - 1);
 
-	i = (eofs - base) >> amortizedshift;
+	in = m->kaddr - bytes;
+
+	i = bytes >> amortizedshift;
 
 	lo = decode_compactedbits(lobits, in, encodebits * i, &type);
 	m->type = type;
@@ -267,7 +267,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 out:
 	pos += lcn * (1 << amortizedshift);
 	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      erofs_pos(inode->i_sb, erofs_blknr(inode->i_sb, pos)), EROFS_KMAP);
+				      pos, EROFS_KMAP);
 	if (IS_ERR(m->kaddr))
 		return PTR_ERR(m->kaddr);
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
-- 
2.39.2


