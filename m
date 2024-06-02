Return-Path: <linux-fsdevel+bounces-20731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D28D74E8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA62B2141F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 11:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28CB38389;
	Sun,  2 Jun 2024 11:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNciHn5B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1993A1BB
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jun 2024 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717327002; cv=none; b=eEwwgs2ZoRhVMJ0NL/GBHwgmjan90RsDHB3K6uJSGQZcTzuXydzeDTbjK6/b74CJg/Z34ojaJRKWdEYyc2MtJaT3gCKtPSFhszgM2AgK+cJOWavklPnfAcXCAZdbcsGOeJop7zNQPmr0rjgy5Jst7pAxq1jfSmVdcMsnJ73bXgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717327002; c=relaxed/simple;
	bh=YCmxdfhYQeXhWlaQwq3LcnFSAcFQkqT2we7Sk85tI9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilWCqYCIBPg8Mis98Xx9dOwqzJR/PUfK3P5fSJdBqkocP5gJH6eMAcP7sKozX2qiTpG4n9/I4q6oKE/qbg6fvJpiVEOw62a5UOZAKHG1WgckCyK2ln17V5HoT2KcmvQWXzAA1Hr/G5AjWibc9IGN9nFOHlO1bBkrpi8Hx43HdIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNciHn5B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717326999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xB7XoRdgVTbFO1Td9v+EnfBLv3e5u1le/I3V6za6ljg=;
	b=FNciHn5BU0YqiqV60bopOSdJY/FV8XMCst6CxMeWwmmwXe6gvb5YvyZ1XtpNYofTc95/u0
	YqwqMRyT5MTYxIbZc4lo3BU5Stdj0vgo/cAXl0D9bGyvhlWy8/HCdAOlgiV/qf2fbZKubg
	FHEuB/alniCna3ixNmo2S7ZnrJMQM6A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-3bU5Tr9hMr2vyiekgUpSTw-1; Sun, 02 Jun 2024 07:16:36 -0400
X-MC-Unique: 3bU5Tr9hMr2vyiekgUpSTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD83881227E;
	Sun,  2 Jun 2024 11:16:35 +0000 (UTC)
Received: from bfoster (unknown [10.22.8.96])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 21FFB36EC;
	Sun,  2 Jun 2024 11:16:35 +0000 (UTC)
Date: Sun, 2 Jun 2024 07:16:53 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandanbabu@kernel.org, jack@suse.cz, willy@infradead.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 3/8] iomap: pass blocksize to iomap_truncate_page()
Message-ID: <ZlxUpYvb9dlOHFR3@bfoster>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-4-yi.zhang@huaweicloud.com>
 <ZlnE7vrk_dmrqUxC@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlnE7vrk_dmrqUxC@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Fri, May 31, 2024 at 05:39:10AM -0700, Christoph Hellwig wrote:
> > -		const struct iomap_ops *ops)
> > +iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
> > +		bool *did_zero, const struct iomap_ops *ops)
> >  {
> > -	unsigned int blocksize = i_blocksize(inode);
> > -	unsigned int off = pos & (blocksize - 1);
> > +	unsigned int off = rem_u64(pos, blocksize);
> >  
> >  	/* Block boundary? Nothing to do */
> >  	if (!off)
> 
> Instad of passing yet another argument here, can we just kill
> iomap_truncate_page?
> 
> I.e. just open code the rem_u64 and 0 offset check in the only caller
> and call iomap_zero_range.  Same for the DAX variant and it's two
> callers.
> 
> 

Hey Christoph,

I've wondered the same about killing off iomap_truncate_page(), but JFYI
one of the several prototypes I have around of other potential ways to
address this problem slightly splits off truncate page from being a
straight zero range wrapper. A quick diff [2] of that is inlined below
for reference (only lightly tested, may be busted, etc.).

The idea is that IIRC truncate_page() was really the only zero range
user that might actually encounter dirty cache over unwritten mappings,
so given that and the typically constrained range size of truncate page,
just let it be more aggressive about bypassing the unwritten mapping
optimization in iomap_zero_iter(). Just something else to consider, and
this is definitely not something you'd want to do for zero range proper.

Brian

P.S., I think the last patches I actually posted around this were here
[1], but I also have multiple versions of that selective flush approach
ported to iomap instead of being XFS specific as well.

[1] https://lore.kernel.org/linux-xfs/20221104182358.2007475-1-bfoster@redhat.com/
    https://lore.kernel.org/linux-xfs/20221128173945.3953659-1-bfoster@redhat.com/
[2] truncate page POC:

--- 8< ---

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c5802a459334..a261e732ea05 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1380,7 +1380,8 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 }
 EXPORT_SYMBOL_GPL(iomap_file_unshare);
 
-static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
+static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
+			      bool dirty_cache)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
@@ -1388,7 +1389,8 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 	loff_t written = 0;
 
 	/* already zeroed?  we're done. */
-	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
+	if (srcmap->type == IOMAP_HOLE ||
+	    (!dirty_cache && srcmap->type == IOMAP_UNWRITTEN))
 		return length;
 
 	do {
@@ -1439,7 +1441,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 	int ret;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_zero_iter(&iter, did_zero);
+		iter.processed = iomap_zero_iter(&iter, did_zero, false);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_zero_range);
@@ -1450,11 +1452,29 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 {
 	unsigned int blocksize = i_blocksize(inode);
 	unsigned int off = pos & (blocksize - 1);
+	struct iomap_iter iter = {
+		.inode		= inode,
+		.pos		= pos,
+		.len		= blocksize - off,
+		.flags		= IOMAP_ZERO,
+	};
+	loff_t end;
+	int ret;
+	bool dirty_cache = false;
 
 	/* Block boundary? Nothing to do */
 	if (!off)
 		return 0;
-	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
+
+	/* overwrite unwritten ranges if any part of the range is dirty for
+	 * truncate page */
+	end = iter.pos + iter.len - 1;
+	if (filemap_range_needs_writeback(inode->i_mapping, iter.pos, end))
+		dirty_cache = true;
+
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.processed = iomap_zero_iter(&iter, did_zero, dirty_cache);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 


