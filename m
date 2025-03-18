Return-Path: <linux-fsdevel+bounces-44321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4680FA6754A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 14:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A7E1895DFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D902720CCED;
	Tue, 18 Mar 2025 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e6hmVdV6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD31EF377
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304966; cv=none; b=OBiSKEYf1VYuZzreE84/+0DKcd0pXwS5xql4iAVe2wB4jxtIIIniFDW4kISCi/+V7tq5lyNU5oIDFxUgVpX15UvjODLeb65aB4g/5jYZqp8zdhPnerhRuWJ6DoL2CqHlz7zVTtgAI9Z5O154pqJJBmlqfsnITrh5jacHwW+/ZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304966; c=relaxed/simple;
	bh=Qu51nKO9TZWFvcRJhvFmFzvEVPotNYtPAHYFaj0V95s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=gXYtY1DFFSyNS116/MwNPGX9jlsqGAbdOTopol3w3KOs1fM/88bMklsCgVZtTBZmMBz/OIlLBz7YZHq2Ji6In17B1syNvyDHlEnRkj/tEHMQzT2ub+erqHdqzohSCBB+5kCWLl6rk1ZOA3LAHNjcKA3gBDCcFniyEf4Eg0K7Pn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=e6hmVdV6; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250318133556epoutp03e93e0315d3579b31df9a97a6e85ec365~t6SCSwCh03169331693epoutp03F
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 13:35:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250318133556epoutp03e93e0315d3579b31df9a97a6e85ec365~t6SCSwCh03169331693epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742304957;
	bh=N29Sqzj6IBCm/SVPH5Mztc3DedVCXsDfngpapt3RCM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e6hmVdV6ogi8z5E8dW58Eo++HMkHBpBv5PM2dHL4gLO+ScqvwxVGRZFz61mgqpvQ9
	 8cvkCIzwOCteTUuO4sJpC+m+C8m12ItQmvmTNx0crXtCG6Plt+zm5OQv9PKgOPOAdM
	 Bh3kLfSBt8cS7efumdR8KJlbGUHuUt+3x2CibApI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250318133556epcas5p487251cfed881aa5c07558ce25ab8e76a~t6SBokcyB2323123231epcas5p4w;
	Tue, 18 Mar 2025 13:35:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4ZHCXV476Pz4x9Pq; Tue, 18 Mar
	2025 13:35:54 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	74.56.19956.AB679D76; Tue, 18 Mar 2025 22:35:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250318114532epcas5p42af2e2ae5f41e1ac44b49b6166622ae4~t4xpOGh_10388403884epcas5p4k;
	Tue, 18 Mar 2025 11:45:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250318114532epsmtrp2e52f0106c6dbbd03a0ffb6ce53d7d84e~t4xpNVhbW3123431234epsmtrp2t;
	Tue, 18 Mar 2025 11:45:32 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-71-67d976ba48bb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	93.27.18729.CDC59D76; Tue, 18 Mar 2025 20:45:32 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250318114530epsmtip123a66ab71895d16055106228039f0a94~t4xnWvK6g1228612286epsmtip1Q;
	Tue, 18 Mar 2025 11:45:30 +0000 (GMT)
Date: Tue, 18 Mar 2025 17:07:12 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Jan Kara <jack@suse.cz>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, Dave Chinner
	<david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, joshi.k@samsung.com, axboe@kernel.dk, clm@meta.com,
	willy@infradead.org, gost.dev@samsung.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Parallelizing filesystem writeback
Message-ID: <20250318113712.GA14945@green245>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <qdgoyhi5qjnlfk6zmlizp2lcrmg43rwmy3tl4yz6zkgavgfav5@nsfculj7aoxe>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc18fj8LW5QmaXSsy8uZcZCu0o9TXBQSdkSfgRiJmi1sCL/TR
	YtvX0h/OuS1pAmyTTYuZjtChIcwpP9dYy2/qsPIjhcJ0uIxuc0H5oRZlS1Fihsy1fWXxv8+5
	55x7vuece/m8OC8m5JexJsbA0hoCi0U7r25LFvUe9inFltNCsvWmFSOdP2eRzuE/Aekb6EHI
	5tYhhPy2tgIhh54+wMiOh4+iyH6XByUvL7h45FTNHCBXHtdj2c9To42QutSUTE2OmylHyzGM
	+nrqAqD6fBaMmrh+hDrhbAGUt2EwmlpyJBbEHlRnqBhawRiSGLZEpyhjlZlE3v6it4rSZWKJ
	SCIntxNJLK1lMond+QWiPWWaoGYi6TCtMQePCmijkUjdkWHQmU1MkkpnNGUSjF6h0Uv1KUZa
	azSzyhSWMb0pEYvfSA8GFqtVI788RfXtXciRafceC+i0INUghg9xKaxzjkVVg1h+HN4H4I2B
	XsAZAQC9V+qiOWMZwK72c9FrKf5bDoRzuAAc8v4eMeYBrGwPoKEoFH8FXvP7sRBj+Ktw8E4V
	CPF6fBO0DTejoQQe3orAEY+LF3LE43nQsnApKsQCXARti0uA43XQUzcbvjQGfxveq5gO8wb8
	ZTjQORKuDPEBPmyfuIty+nbDybP9kfbioX/EGdEthEuLLoxjJXw8OReJ0cOK4cuA4yxYNWoN
	C+LhKni7ihMH8c3w9OgPCHf+Ajy+MhvJFcDus2tMwM+b6yMMoWtibcQUvNY0yuNGZEVh060a
	Xg14yfZMc7Zn6nH8OmzoC2A2wA/yJnjhXz6H26C9N7UBRLWAjYzeqFUyxnR9Gst8+P/SS3Ra
	Bwg/6+S8bnB7+u8UN0D4wA0gn0esF+TM/qqMEyjoj44yBl2RwaxhjG6QHtzWSZ5wQ4ku+C9Y
	U5FEKhdLZTKZVJ4mkxAvCip6KpVxuJI2MWqG0TOGtTyEHyO0IKKODP1zsnLzCTGp2HHfu1pY
	d+6zR/n7+8vvfJGt7fljht2raTh4aMuulJqPs9XVpQs7ExqtCb657vOFEyLfzN75seFAbtls
	ZfzWNt+hqzvv2bbnMKdWM1Q3OqLO173bJpAkIglFzHdyx/XVvCdfzijO2AsLQObKA/sU2vWN
	553ln25mS9Ub13Xk/CZdybWTMwaBJ3BlIR4l/B+oJW3pB1A57Z3ItZhqi//KcjRu/scazYrq
	v1cndhZrn8hHSiWY+6vxh+60Y4vHP7l7P/P9+Z7kVJPDnpd4NAns+vGAFe8vdc9tuXjqtbQz
	Opg/6Bc0lo/19k3ZP704rt1X61l+b55AjSpakswzGOn/AL7eiFRfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTvdOzM10gy2PDC1W3+1ns9hyyd5i
	y7F7jBY3D+xksli5+iiTxezpzUwWR/+/ZbPY+uUrq8WevSdZLPa93stscWPCU0aL3z/msDnw
	eJxaJOGxeYWWx+WzpR6bVnWyeUy+sZzRY/fNBjaPcxcrPPq2rGL0OLPgCLvH501yAVxRXDYp
	qTmZZalF+nYJXBnT3ixnLni7haliwZPbzA2M/f8Yuxg5OSQETCRePdzE1MXIxSEksJtRYufb
	q8wQCQmJUy+XQRUJS6z895wdougJo8TXyyvBilgEVCUuvHrFBmKzCahLHHneCtYgIiAtMevY
	ShYQm1lgNZPEzofVILawgLdEw+vNrCA2r4CuxKx3n8HqhQQmskjMvuEIEReUODnzCVSvlsSN
	fy+BruMAsqUllv/jAAlzCvhJvGx+AFYiKqAscWDbcaYJjIKzkHTPQtI9C6F7ASPzKkbJ1ILi
	3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4AjT0tzBuH3VB71DjEwcjIcYJTiYlUR43Z9cTxfi
	TUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2xJDU7NbUgtQgmy8TBKdXAxB7MMLPXK1ir
	902ewJmFwXOzWRl6gudzzHa0inzu9eafT/TVSUnXhL68YwtK+HvMnS/7SnHaVckcHe2rCybO
	22+hXPTUU+f/Q6fFk6SlDlW+dfrLPDdTaaVmr0DSUR7LLfZvNWovBjhavJUNitvm3TmJ42Hm
	LatnXhwbCvvWpXeGXHhQo9qnsu9r46PLPwvYyy+ltQYI3n0V7LCsIej/xprZGltWmP3Lm1nb
	dHEPo0bg8p2h0hZbszYw8pmt55/M1yZibz/pf2h/y5W6iMcJZ+yFGPYvUjZnDHF5xHJL9M6/
	70Wqv69+Wz/tgt3pvBm7FrXLT7/9mPNj36Ojpu8rgk/+ntw2+0umo/2qX7lHlFiKMxINtZiL
	ihMB1HVcsx8DAAA=
X-CMS-MailID: 20250318114532epcas5p42af2e2ae5f41e1ac44b49b6166622ae4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----smkAoC60a7u2mLi3Ss29b8NT2iAal2vPoRoPruPDCgH-0Z0S=_1316a_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749
References: <CGME20250129103448epcas5p1f7d71506e4443429a0b0002eb842e749@epcas5p1.samsung.com>
	<20250129102627.161448-1-kundan.kumar@samsung.com>
	<Z5qw_1BOqiFum5Dn@dread.disaster.area>
	<20250131093209.6luwm4ny5kj34jqc@green245>
	<Z6GAYFN3foyBlUxK@dread.disaster.area> <20250204050642.GF28103@lst.de>
	<s43qlmnbtjbpc5vn75gokti3au7qhvgx6qj7qrecmkd2dgrdfv@no2i7qifnvvk>
	<Z6qkLjSj1K047yPt@dread.disaster.area>
	<20250220141824.ju5va75s3xp472cd@green245>
	<qdgoyhi5qjnlfk6zmlizp2lcrmg43rwmy3tl4yz6zkgavgfav5@nsfculj7aoxe>

------smkAoC60a7u2mLi3Ss29b8NT2iAal2vPoRoPruPDCgH-0Z0S=_1316a_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

> I was thinking about how to best parallelize the writeback and I think
> there are two quite different demands for which we probably want two
> different levels of parallelism.
> 
> One case is the situation when the filesystem for example has multiple
> underlying devices (like btrfs or bcachefs) or for other reasons writeback
> to different parts is fairly independent (like for different XFS AGs). Here
> we want parallelism at rather high level I think including separate
> dirty throttling, tracking of writeback bandwidth etc.. It is *almost* like
> separate bdis (struct backing_dev_info) but I think it would be technically
> and also conceptually somewhat easier to do the multiplexing by factoring
> out:
> 
>         struct bdi_writeback wb;  /* the root writeback info for this bdi */
>         struct list_head wb_list; /* list of all wbs */
> #ifdef CONFIG_CGROUP_WRITEBACK
>         struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
>         struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
> #endif
>         wait_queue_head_t wb_waitq;
> 
> into a new structure (looking for a good name - bdi_writeback_context???)
> that can get multiplied (filesystem can create its own bdi on mount and
> configure there number of bdi_writeback_contexts it wants). We also need to
> add a hook sb->s_ops->get_inode_wb_context() called from __inode_attach_wb()
> which will return appropriate bdi_writeback_context (or perhaps just it's
> index?) for an inode. This will be used by the filesystem to direct
> writeback code where the inode should go. This is kind of what Kundan did
> in the last revision of his patches but I hope this approach should
> somewhat limit the changes necessary to writeback infrastructure - the
> patch 2 in his series is really unreviewably large...

Thanks Jan.

I tried to modify the existing infra based on your suggestion [1]. This
only takes care of the first case that you mentioned. I am yet to start
to evaluate and implement the second case (when amount of cpu work is
high). The patch is large, because it requires changing all the places
that uses bdi's fields that have now been moved to a new structure. I
will try to streamline it further.

I have omitted the xfs side plumbing for now.
Can you please see if this aligns with the scheme that you had in mind?
If the infra looks fine, I can plumb XFS changes on top of it.

Note: This patch is only compile tested, haven't run any tests on it.

It is on top of v6.13
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/?h=v6.13

[1]

Subject: [PATCH] writeback: add infra for parallel writeback

Introduce a new bdi_writeback_ctx structure that enables us to have
multiple writeback contexts for parallel writeback.

Existing single threaded writeback will use default_ctx.

Filesystem now have the option to create there own bdi aind populate
multiple bdi_writeback_ctx in bdi's bdi_wb_ctx_arr (xarray for now, but
plan to move to use a better structure like list_lru).

Introduce a new hook get_inode_wb_ctx() in super_operations which takes
inode as a parameter and returns the bdi_wb_ctx corresponding to the
inode.

Modify all the functions/places that operate on bdi's wb, wb_list,
cgwb_tree, wb_switch_rwsem, wb_waitq as these fields have now been moved
to bdi_writeback_ctx

Store a reference to bdi_wb_ctx in bdi_writeback.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
---
 fs/fs-writeback.c                | 170 +++++++++++++++++-------
 include/linux/backing-dev-defs.h |  34 +++--
 include/linux/backing-dev.h      |  48 +++++--
 include/linux/fs.h               |   1 +
 mm/backing-dev.c                 | 218 +++++++++++++++++++++++--------
 mm/page-writeback.c              |   5 +-
 6 files changed, 345 insertions(+), 131 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3cd99e2dc6ac..4c47c298f174 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -265,23 +265,27 @@ void __inode_attach_wb(struct inode *inode, struct folio *folio)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	struct bdi_writeback *wb = NULL;
+	struct bdi_writeback_ctx *bdi_writeback_ctx =
+						fetch_bdi_writeback_ctx(inode);
 
 	if (inode_cgwb_enabled(inode)) {
 		struct cgroup_subsys_state *memcg_css;
 
 		if (folio) {
 			memcg_css = mem_cgroup_css_from_folio(folio);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+			wb = wb_get_create(bdi, bdi_writeback_ctx, memcg_css,
+					   GFP_ATOMIC);
 		} else {
 			/* must pin memcg_css, see wb_get_create() */
 			memcg_css = task_get_css(current, memory_cgrp_id);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+			wb = wb_get_create(bdi, bdi_writeback_ctx, memcg_css,
+					   GFP_ATOMIC);
 			css_put(memcg_css);
 		}
 	}
 
 	if (!wb)
-		wb = &bdi->wb;
+		wb = &bdi_writeback_ctx->wb;
 
 	/*
 	 * There may be multiple instances of this function racing to
@@ -302,12 +306,15 @@ void __inode_attach_wb(struct inode *inode, struct folio *folio)
 static void inode_cgwb_move_to_attached(struct inode *inode,
 					struct bdi_writeback *wb)
 {
+	struct bdi_writeback_ctx *bdi_wb_ctx;
+
 	assert_spin_locked(&wb->list_lock);
 	assert_spin_locked(&inode->i_lock);
 	WARN_ON_ONCE(inode->i_state & I_FREEING);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
-	if (wb != &wb->bdi->wb)
+	bdi_wb_ctx = fetch_bdi_writeback_ctx(inode);
+	if (wb != &bdi_wb_ctx->wb)
 		list_move(&inode->i_io_list, &wb->b_attached);
 	else
 		list_del_init(&inode->i_io_list);
@@ -382,14 +389,14 @@ struct inode_switch_wbs_context {
 	struct inode		*inodes[];
 };
 
-static void bdi_down_write_wb_switch_rwsem(struct backing_dev_info *bdi)
+static void bdi_wb_ctx_down_write_wb_switch_rwsem(struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	down_write(&bdi->wb_switch_rwsem);
+	down_write(&bdi_wb_ctx->wb_switch_rwsem);
 }
 
-static void bdi_up_write_wb_switch_rwsem(struct backing_dev_info *bdi)
+static void bdi_wb_ctx_up_write_wb_switch_rwsem(struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	up_write(&bdi->wb_switch_rwsem);
+	up_write(&bdi_wb_ctx->wb_switch_rwsem);
 }
 
 static bool inode_do_switch_wbs(struct inode *inode,
@@ -490,7 +497,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 {
 	struct inode_switch_wbs_context *isw =
 		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work);
-	struct backing_dev_info *bdi = inode_to_bdi(isw->inodes[0]);
+	struct bdi_writeback_ctx *bdi_wb_ctx = fetch_bdi_writeback_ctx(isw->inodes[0]);
 	struct bdi_writeback *old_wb = isw->inodes[0]->i_wb;
 	struct bdi_writeback *new_wb = isw->new_wb;
 	unsigned long nr_switched = 0;
@@ -500,7 +507,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	 * If @inode switches cgwb membership while sync_inodes_sb() is
 	 * being issued, sync_inodes_sb() might miss it.  Synchronize.
 	 */
-	down_read(&bdi->wb_switch_rwsem);
+	down_read(&bdi_wb_ctx->wb_switch_rwsem);
 
 	/*
 	 * By the time control reaches here, RCU grace period has passed
@@ -529,7 +536,7 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	spin_unlock(&new_wb->list_lock);
 	spin_unlock(&old_wb->list_lock);
 
-	up_read(&bdi->wb_switch_rwsem);
+	up_read(&bdi_wb_ctx->wb_switch_rwsem);
 
 	if (nr_switched) {
 		wb_wakeup(new_wb);
@@ -583,6 +590,7 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
 static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
+	struct bdi_writeback_ctx *bdi_wb_ctx = fetch_bdi_writeback_ctx(inode);
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
 
@@ -609,7 +617,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	if (!memcg_css)
 		goto out_free;
 
-	isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+	isw->new_wb = wb_get_create(bdi, bdi_wb_ctx, memcg_css, GFP_ATOMIC);
 	css_put(memcg_css);
 	if (!isw->new_wb)
 		goto out_free;
@@ -678,12 +686,12 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	for (memcg_css = wb->memcg_css->parent; memcg_css;
 	     memcg_css = memcg_css->parent) {
-		isw->new_wb = wb_get_create(wb->bdi, memcg_css, GFP_KERNEL);
+		isw->new_wb = wb_get_create(wb->bdi, wb->bdi_wb_ctx, memcg_css, GFP_KERNEL);
 		if (isw->new_wb)
 			break;
 	}
 	if (unlikely(!isw->new_wb))
-		isw->new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
+		isw->new_wb = &wb->bdi_wb_ctx->wb; /* wb_get() is noop for bdi's wb */
 
 	nr = 0;
 	spin_lock(&wb->list_lock);
@@ -995,17 +1003,18 @@ static long wb_split_bdi_pages(struct bdi_writeback *wb, long nr_pages)
  */
 static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 				  struct wb_writeback_work *base_work,
-				  bool skip_if_busy)
+				  bool skip_if_busy,
+				  struct bdi_writeback_ctx *bdi_wb_ctx)
 {
 	struct bdi_writeback *last_wb = NULL;
-	struct bdi_writeback *wb = list_entry(&bdi->wb_list,
+	struct bdi_writeback *wb = list_entry(&bdi_wb_ctx->wb_list,
 					      struct bdi_writeback, bdi_node);
 
 	might_sleep();
 restart:
 	rcu_read_lock();
-	list_for_each_entry_continue_rcu(wb, &bdi->wb_list, bdi_node) {
-		DEFINE_WB_COMPLETION(fallback_work_done, bdi);
+	list_for_each_entry_continue_rcu(wb, &bdi_wb_ctx->wb_list, bdi_node) {
+		DEFINE_WB_COMPLETION(fallback_work_done, bdi_wb_ctx);
 		struct wb_writeback_work fallback_work;
 		struct wb_writeback_work *work;
 		long nr_pages;
@@ -1103,7 +1112,17 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 	 * And find the associated wb.  If the wb isn't there already
 	 * there's nothing to flush, don't create one.
 	 */
-	wb = wb_get_lookup(bdi, memcg_css);
+	if (bdi->is_parallel) {
+		struct bdi_writeback_ctx *bdi_wb_ctx;
+
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+			wb = wb_get_lookup(bdi_wb_ctx, memcg_css);
+			if (wb)
+				break;
+		}
+	} else {
+		wb = wb_get_lookup(&bdi->default_ctx, memcg_css);
+	}
 	if (!wb) {
 		ret = -ENOENT;
 		goto out_css_put;
@@ -1189,8 +1208,8 @@ fs_initcall(cgroup_writeback_init);
 
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
-static void bdi_down_write_wb_switch_rwsem(struct backing_dev_info *bdi) { }
-static void bdi_up_write_wb_switch_rwsem(struct backing_dev_info *bdi) { }
+static void bdi_wb_ctx_down_write_wb_switch_rwsem(struct bdi_writeback_ctx *bdi_wb_ctx) { }
+static void bdi_wb_ctx_up_write_wb_switch_rwsem(struct bdi_writeback_ctx *bdi_wb_ctx) { }
 
 static void inode_cgwb_move_to_attached(struct inode *inode,
 					struct bdi_writeback *wb)
@@ -1232,13 +1251,14 @@ static long wb_split_bdi_pages(struct bdi_writeback *wb, long nr_pages)
 
 static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 				  struct wb_writeback_work *base_work,
-				  bool skip_if_busy)
+				  bool skip_if_busy,
+				  struct bdi_writeback_ctx *bdi_wb_ctx)
 {
 	might_sleep();
 
-	if (!skip_if_busy || !writeback_in_progress(&bdi->wb)) {
+	if (!skip_if_busy || !writeback_in_progress(&bdi_wb_ctx->wb)) {
 		base_work->auto_free = 0;
-		wb_queue_work(&bdi->wb, base_work);
+		wb_queue_work(&bdi_wb_ctx->wb, base_work);
 	}
 }
 
@@ -2371,8 +2391,18 @@ static void __wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 	if (!bdi_has_dirty_io(bdi))
 		return;
 
-	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node)
-		wb_start_writeback(wb, reason);
+	/* traverse all the bdi_wb_ctx of the bdi */
+	if (bdi->is_parallel) {
+		struct bdi_writeback_ctx *bdi_wb_ctx;
+
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+			list_for_each_entry_rcu(wb, &bdi_wb_ctx->wb_list, bdi_node)
+				wb_start_writeback(wb, reason);
+		}
+	} else {
+		list_for_each_entry_rcu(wb, &bdi->default_ctx.wb_list, bdi_node)
+			wb_start_writeback(wb, reason);
+	}
 }
 
 void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
@@ -2427,9 +2457,19 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
 	list_for_each_entry_rcu(bdi, &bdi_list, bdi_list) {
 		struct bdi_writeback *wb;
 
-		list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node)
-			if (!list_empty(&wb->b_dirty_time))
-				wb_wakeup(wb);
+		if (bdi->is_parallel) {
+			struct bdi_writeback_ctx *bdi_wb_ctx;
+
+			for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+				list_for_each_entry_rcu(wb, &bdi_wb_ctx->wb_list, bdi_node)
+					if (!list_empty(&wb->b_dirty_time))
+						wb_wakeup(wb);
+			}
+		} else {
+			list_for_each_entry_rcu(wb, &bdi->default_ctx.wb_list, bdi_node)
+				if (!list_empty(&wb->b_dirty_time))
+					wb_wakeup(wb);
+		}
 	}
 	rcu_read_unlock();
 	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
@@ -2713,11 +2753,12 @@ static void wait_sb_inodes(struct super_block *sb)
 	mutex_unlock(&sb->s_sync_lock);
 }
 
-static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
-				     enum wb_reason reason, bool skip_if_busy)
+static void __writeback_inodes_sb_nr_bdi_wb_ctx(struct super_block *sb,
+						unsigned long nr, enum wb_reason reason,
+						bool skip_if_busy,
+						struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	struct backing_dev_info *bdi = sb->s_bdi;
-	DEFINE_WB_COMPLETION(done, bdi);
+	DEFINE_WB_COMPLETION(done, bdi_wb_ctx);
 	struct wb_writeback_work work = {
 		.sb			= sb,
 		.sync_mode		= WB_SYNC_NONE,
@@ -2727,12 +2768,29 @@ static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
 		.reason			= reason,
 	};
 
+	bdi_split_work_to_wbs(sb->s_bdi, &work, skip_if_busy, bdi_wb_ctx);
+	wb_wait_for_completion(&done);
+}
+
+static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
+				     enum wb_reason reason, bool skip_if_busy)
+{
+	struct backing_dev_info *bdi = sb->s_bdi;
+
 	if (!bdi_has_dirty_io(bdi) || bdi == &noop_backing_dev_info)
 		return;
 	WARN_ON(!rwsem_is_locked(&sb->s_umount));
 
-	bdi_split_work_to_wbs(sb->s_bdi, &work, skip_if_busy);
-	wb_wait_for_completion(&done);
+	if (bdi->is_parallel) {
+		struct bdi_writeback_ctx *bdi_wb_ctx;
+
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx)
+			__writeback_inodes_sb_nr_bdi_wb_ctx(sb, nr, reason,
+							    skip_if_busy, bdi_wb_ctx);
+	} else {
+		__writeback_inodes_sb_nr_bdi_wb_ctx(sb, nr, reason,
+						    skip_if_busy, &bdi->default_ctx);
+	}
 }
 
 /**
@@ -2785,17 +2843,10 @@ void try_to_writeback_inodes_sb(struct super_block *sb, enum wb_reason reason)
 }
 EXPORT_SYMBOL(try_to_writeback_inodes_sb);
 
-/**
- * sync_inodes_sb	-	sync sb inode pages
- * @sb: the superblock
- *
- * This function writes and waits on any dirty inode belonging to this
- * super_block.
- */
-void sync_inodes_sb(struct super_block *sb)
+static void sync_inodes_bdi_wb_ctx(struct super_block *sb,
+		struct backing_dev_info *bdi, struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	struct backing_dev_info *bdi = sb->s_bdi;
-	DEFINE_WB_COMPLETION(done, bdi);
+	DEFINE_WB_COMPLETION(done, bdi_wb_ctx);
 	struct wb_writeback_work work = {
 		.sb		= sb,
 		.sync_mode	= WB_SYNC_ALL,
@@ -2805,6 +2856,22 @@ void sync_inodes_sb(struct super_block *sb)
 		.reason		= WB_REASON_SYNC,
 		.for_sync	= 1,
 	};
+	bdi_wb_ctx_down_write_wb_switch_rwsem(bdi_wb_ctx);
+	bdi_split_work_to_wbs(bdi, &work, false, bdi_wb_ctx);
+	wb_wait_for_completion(&done);
+	bdi_wb_ctx_up_write_wb_switch_rwsem(bdi_wb_ctx);
+}
+
+/**
+ * sync_inodes_sb	-	sync sb inode pages
+ * @sb: the superblock
+ *
+ * This function writes and waits on any dirty inode belonging to this
+ * super_block.
+ */
+void sync_inodes_sb(struct super_block *sb)
+{
+	struct backing_dev_info *bdi = sb->s_bdi;
 
 	/*
 	 * Can't skip on !bdi_has_dirty() because we should wait for !dirty
@@ -2815,12 +2882,15 @@ void sync_inodes_sb(struct super_block *sb)
 		return;
 	WARN_ON(!rwsem_is_locked(&sb->s_umount));
 
-	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
-	bdi_down_write_wb_switch_rwsem(bdi);
-	bdi_split_work_to_wbs(bdi, &work, false);
-	wb_wait_for_completion(&done);
-	bdi_up_write_wb_switch_rwsem(bdi);
+	if (bdi->is_parallel) {
+		struct bdi_writeback_ctx *bdi_wb_ctx;
 
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+			sync_inodes_bdi_wb_ctx(sb, bdi, bdi_wb_ctx);
+		}
+	} else {
+		sync_inodes_bdi_wb_ctx(sb, bdi, &bdi->default_ctx);
+	}
 	wait_sb_inodes(sb);
 }
 EXPORT_SYMBOL(sync_inodes_sb);
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba..d00ae5b55f33 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -75,10 +75,10 @@ struct wb_completion {
  * can wait for the completion of all using wb_wait_for_completion().  Work
  * items which are waited upon aren't freed automatically on completion.
  */
-#define WB_COMPLETION_INIT(bdi)		__WB_COMPLETION_INIT(&(bdi)->wb_waitq)
+#define WB_COMPLETION_INIT(bdi_wb_ctx)		__WB_COMPLETION_INIT(&(bdi_wb_ctx)->wb_waitq)
 
-#define DEFINE_WB_COMPLETION(cmpl, bdi)	\
-	struct wb_completion cmpl = WB_COMPLETION_INIT(bdi)
+#define DEFINE_WB_COMPLETION(cmpl, bdi_wb_ctx)	\
+	struct wb_completion cmpl = WB_COMPLETION_INIT(bdi_wb_ctx)
 
 /*
  * Each wb (bdi_writeback) can perform writeback operations, is measured
@@ -104,6 +104,7 @@ struct wb_completion {
  */
 struct bdi_writeback {
 	struct backing_dev_info *bdi;	/* our parent bdi */
+	struct bdi_writeback_ctx *bdi_wb_ctx;
 
 	unsigned long state;		/* Always use atomic bitops on this */
 	unsigned long last_old_flush;	/* last old data flush */
@@ -160,6 +161,16 @@ struct bdi_writeback {
 #endif
 };
 
+struct bdi_writeback_ctx {
+	struct bdi_writeback wb;  /* the root writeback info for this bdi */
+	struct list_head wb_list; /* list of all wbs */
+#ifdef CONFIG_CGROUP_WRITEBACK
+	struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
+	struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
+#endif
+	wait_queue_head_t wb_waitq;
+};
+
 struct backing_dev_info {
 	u64 id;
 	struct rb_node rb_node; /* keyed by ->id */
@@ -182,16 +193,13 @@ struct backing_dev_info {
 	 * blk-wbt.
 	 */
 	unsigned long last_bdp_sleep;
-
-	struct bdi_writeback wb;  /* the root writeback info for this bdi */
-	struct list_head wb_list; /* list of all wbs */
+	struct bdi_writeback_ctx default_ctx;
+	bool is_parallel;
+	int nr_wb_ctx;
+	struct xarray bdi_wb_ctx_arr;
 #ifdef CONFIG_CGROUP_WRITEBACK
-	struct radix_tree_root cgwb_tree; /* radix tree of active cgroup wbs */
 	struct mutex cgwb_release_mutex;  /* protect shutdown of wb structs */
-	struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
 #endif
-	wait_queue_head_t wb_waitq;
-
 	struct device *dev;
 	char dev_name[64];
 	struct device *owner;
@@ -216,7 +224,7 @@ struct wb_lock_cookie {
  */
 static inline bool wb_tryget(struct bdi_writeback *wb)
 {
-	if (wb != &wb->bdi->wb)
+	if (wb != &wb->bdi_wb_ctx->wb)
 		return percpu_ref_tryget(&wb->refcnt);
 	return true;
 }
@@ -227,7 +235,7 @@ static inline bool wb_tryget(struct bdi_writeback *wb)
  */
 static inline void wb_get(struct bdi_writeback *wb)
 {
-	if (wb != &wb->bdi->wb)
+	if (wb != &wb->bdi_wb_ctx->wb)
 		percpu_ref_get(&wb->refcnt);
 }
 
@@ -246,7 +254,7 @@ static inline void wb_put_many(struct bdi_writeback *wb, unsigned long nr)
 		return;
 	}
 
-	if (wb != &wb->bdi->wb)
+	if (wb != &wb->bdi_wb_ctx->wb)
 		percpu_ref_put_many(&wb->refcnt, nr);
 }
 
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 8e7af9a03b41..e24cd3fd42b4 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -148,11 +148,29 @@ static inline bool mapping_can_writeback(struct address_space *mapping)
 	return inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK;
 }
 
+#define for_each_bdi_wb_ctx(bdi, wb_ctx) \
+	for (int i = 0; (i) < (bdi)->nr_wb_ctx \
+		    && ((wb_ctx) = xa_load(&(bdi)->bdi_wb_ctx_arr, i), 1); (i)++)
+
+static inline struct bdi_writeback_ctx *fetch_bdi_writeback_ctx(struct inode *inode)
+{
+	struct backing_dev_info *bdi = inode_to_bdi(inode);
+	struct super_block *sb = inode->i_sb;
+	struct bdi_writeback_ctx *bdi_wb_ctx;
+
+	if (sb->s_op->get_inode_wb_ctx)
+		bdi_wb_ctx = sb->s_op->get_inode_wb_ctx(inode);
+	else
+		bdi_wb_ctx = &bdi->default_ctx;
+	return bdi_wb_ctx;
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
-struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
+struct bdi_writeback *wb_get_lookup(struct bdi_writeback_ctx *bdi_wb_ctx,
 				    struct cgroup_subsys_state *memcg_css);
 struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
+				    struct bdi_writeback_ctx *bdi_wb_ctx,
 				    struct cgroup_subsys_state *memcg_css,
 				    gfp_t gfp);
 void wb_memcg_offline(struct mem_cgroup *memcg);
@@ -187,16 +205,17 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
  * Must be called under rcu_read_lock() which protects the returend wb.
  * NULL if not found.
  */
-static inline struct bdi_writeback *wb_find_current(struct backing_dev_info *bdi)
+static inline struct bdi_writeback *wb_find_current(struct backing_dev_info *bdi,
+		struct bdi_writeback_ctx *bdi_wb_ctx)
 {
 	struct cgroup_subsys_state *memcg_css;
 	struct bdi_writeback *wb;
 
 	memcg_css = task_css(current, memory_cgrp_id);
 	if (!memcg_css->parent)
-		return &bdi->wb;
+		return &bdi_wb_ctx->wb;
 
-	wb = radix_tree_lookup(&bdi->cgwb_tree, memcg_css->id);
+	wb = radix_tree_lookup(&bdi_wb_ctx->cgwb_tree, memcg_css->id);
 
 	/*
 	 * %current's blkcg equals the effective blkcg of its memcg.  No
@@ -217,12 +236,13 @@ static inline struct bdi_writeback *wb_find_current(struct backing_dev_info *bdi
  * wb_find_current().
  */
 static inline struct bdi_writeback *
-wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
+wb_get_create_current(struct backing_dev_info *bdi,
+		      struct bdi_writeback_ctx *bdi_wb_ctx, gfp_t gfp)
 {
 	struct bdi_writeback *wb;
 
 	rcu_read_lock();
-	wb = wb_find_current(bdi);
+	wb = wb_find_current(bdi, bdi_wb_ctx);
 	if (wb && unlikely(!wb_tryget(wb)))
 		wb = NULL;
 	rcu_read_unlock();
@@ -231,7 +251,7 @@ wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
 		struct cgroup_subsys_state *memcg_css;
 
 		memcg_css = task_get_css(current, memory_cgrp_id);
-		wb = wb_get_create(bdi, memcg_css, gfp);
+		wb = wb_get_create(bdi, bdi_wb_ctx, memcg_css, gfp);
 		css_put(memcg_css);
 	}
 	return wb;
@@ -264,7 +284,7 @@ static inline struct bdi_writeback *inode_to_wb_wbc(
 	 * If wbc does not have inode attached, it means cgroup writeback was
 	 * disabled when wbc started. Just use the default wb in that case.
 	 */
-	return wbc->wb ? wbc->wb : &inode_to_bdi(inode)->wb;
+	return wbc->wb ? wbc->wb : &fetch_bdi_writeback_ctx(inode)->wb;
 }
 
 /**
@@ -324,20 +344,22 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
 	return false;
 }
 
-static inline struct bdi_writeback *wb_find_current(struct backing_dev_info *bdi)
+static inline struct bdi_writeback *wb_find_current(struct backing_dev_info *bdi,
+		struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	return &bdi->wb;
+	return &bdi_wb_ctx->wb;
 }
 
 static inline struct bdi_writeback *
-wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
+wb_get_create_current(struct backing_dev_info *bdi, struct bdi_writeback_ctx *bdi_wb_ctx,
+		gfp_t gfp)
 {
-	return &bdi->wb;
+	return &bdi_wb_ctx->wb;
 }
 
 static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
 {
-	return &inode_to_bdi(inode)->wb;
+	return &fetch_bdi_writeback_ctx(inode)->wb;
 }
 
 static inline struct bdi_writeback *inode_to_wb_wbc(
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7e29433c5ecc..667f97c68cd1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2228,6 +2228,7 @@ struct super_operations {
    	struct inode *(*alloc_inode)(struct super_block *sb);
 	void (*destroy_inode)(struct inode *);
 	void (*free_inode)(struct inode *);
+	struct bdi_writeback_ctx* (*get_inode_wb_ctx)(struct inode *);
 
    	void (*dirty_inode) (struct inode *, int flags);
 	int (*write_inode) (struct inode *, struct writeback_control *wbc);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e61bbb1bd622..f904994efba1 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -84,26 +84,48 @@ static void collect_wb_stats(struct wb_stats *stats,
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-static void bdi_collect_stats(struct backing_dev_info *bdi,
-			      struct wb_stats *stats)
+
+static void bdi_wb_ctx_collect_stats(struct bdi_writeback_ctx *bdi_wb_ctx,
+				     struct wb_stats *stats)
 {
 	struct bdi_writeback *wb;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
+	list_for_each_entry_rcu(wb, &bdi_wb_ctx->wb_list, bdi_node) {
 		if (!wb_tryget(wb))
 			continue;
 
 		collect_wb_stats(stats, wb);
 		wb_put(wb);
 	}
+}
+static void bdi_collect_stats(struct backing_dev_info *bdi,
+			      struct wb_stats *stats)
+{
+	rcu_read_lock();
+	if (bdi->is_parallel) {
+		struct bdi_writeback_ctx *bdi_wb_ctx;
+
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+			bdi_wb_ctx_collect_stats(bdi_wb_ctx, stats);
+		}
+	} else {
+		bdi_wb_ctx_collect_stats(&bdi->default_ctx, stats);
+	}
 	rcu_read_unlock();
 }
 #else
 static void bdi_collect_stats(struct backing_dev_info *bdi,
 			      struct wb_stats *stats)
 {
-	collect_wb_stats(stats, &bdi->wb);
+	if (bdi->is_parallel) {
+		struct bdi_writeback_ctx *bdi_wb_ctx;
+
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+			collect_wb_stats(stats, &bdi_wb_ctx->wb);
+		}
+	} else {
+		collect_wb_stats(stats, &bdi->default_ctx.wb);
+	}
 }
 #endif
 
@@ -135,8 +157,9 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 		   "b_io:               %10lu\n"
 		   "b_more_io:          %10lu\n"
 		   "b_dirty_time:       %10lu\n"
-		   "bdi_list:           %10u\n"
-		   "state:              %10lx\n",
+		   "bdi_list:           %10u\n",
+		   /* TBD: what to do for state */
+		   /* "state:              %10lx\n", */
 		   K(stats.nr_writeback),
 		   K(stats.nr_reclaimable),
 		   K(stats.wb_thresh),
@@ -149,7 +172,7 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
 		   stats.nr_io,
 		   stats.nr_more_io,
 		   stats.nr_dirty_time,
-		   !list_empty(&bdi->bdi_list), bdi->wb.state);
+		   !list_empty(&bdi->bdi_list));/* bdi->wb.state); */
 
 	return 0;
 }
@@ -190,17 +213,17 @@ static void wb_stats_show(struct seq_file *m, struct bdi_writeback *wb,
 		   wb->state);
 }
 
-static int cgwb_debug_stats_show(struct seq_file *m, void *v)
+
+static int cgwb_debug_stats_bdi_wb_ctx(struct seq_file *m,
+		struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	struct backing_dev_info *bdi = m->private;
+	struct bdi_writeback *wb;
 	unsigned long background_thresh;
 	unsigned long dirty_thresh;
-	struct bdi_writeback *wb;
 
 	global_dirty_limits(&background_thresh, &dirty_thresh);
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
+	list_for_each_entry_rcu(wb, &bdi_wb_ctx->wb_list, bdi_node) {
 		struct wb_stats stats = { .dirty_thresh = dirty_thresh };
 
 		if (!wb_tryget(wb))
@@ -224,6 +247,23 @@ static int cgwb_debug_stats_show(struct seq_file *m, void *v)
 
 		wb_put(wb);
 	}
+	return 0;
+}
+
+static int cgwb_debug_stats_show(struct seq_file *m, void *v)
+{
+	struct backing_dev_info *bdi = m->private;
+
+	rcu_read_lock();
+	if (bdi->is_parallel) {
+		struct bdi_writeback_ctx *bdi_wb_ctx;
+
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+			cgwb_debug_stats_bdi_wb_ctx(m, bdi_wb_ctx);
+		}
+	} else {
+		cgwb_debug_stats_bdi_wb_ctx(m, &bdi->default_ctx);
+	}
 	rcu_read_unlock();
 
 	return 0;
@@ -520,6 +560,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	memset(wb, 0, sizeof(*wb));
 
 	wb->bdi = bdi;
+	wb->bdi_wb_ctx = &bdi->default_ctx;
 	wb->last_old_flush = jiffies;
 	INIT_LIST_HEAD(&wb->b_dirty);
 	INIT_LIST_HEAD(&wb->b_io);
@@ -643,11 +684,11 @@ static void cgwb_release(struct percpu_ref *refcnt)
 	queue_work(cgwb_release_wq, &wb->release_work);
 }
 
-static void cgwb_kill(struct bdi_writeback *wb)
+static void cgwb_kill(struct bdi_writeback *wb, struct bdi_writeback_ctx *bdi_wb_ctx)
 {
 	lockdep_assert_held(&cgwb_lock);
 
-	WARN_ON(!radix_tree_delete(&wb->bdi->cgwb_tree, wb->memcg_css->id));
+	WARN_ON(!radix_tree_delete(&bdi_wb_ctx->cgwb_tree, wb->memcg_css->id));
 	list_del(&wb->memcg_node);
 	list_del(&wb->blkcg_node);
 	list_add(&wb->offline_node, &offline_cgwbs);
@@ -662,6 +703,7 @@ static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb)
 }
 
 static int cgwb_create(struct backing_dev_info *bdi,
+		       struct bdi_writeback_ctx *bdi_wb_ctx,
 		       struct cgroup_subsys_state *memcg_css, gfp_t gfp)
 {
 	struct mem_cgroup *memcg;
@@ -678,9 +720,9 @@ static int cgwb_create(struct backing_dev_info *bdi,
 
 	/* look up again under lock and discard on blkcg mismatch */
 	spin_lock_irqsave(&cgwb_lock, flags);
-	wb = radix_tree_lookup(&bdi->cgwb_tree, memcg_css->id);
+	wb = radix_tree_lookup(&bdi_wb_ctx->cgwb_tree, memcg_css->id);
 	if (wb && wb->blkcg_css != blkcg_css) {
-		cgwb_kill(wb);
+		cgwb_kill(wb, bdi_wb_ctx);
 		wb = NULL;
 	}
 	spin_unlock_irqrestore(&cgwb_lock, flags);
@@ -721,12 +763,12 @@ static int cgwb_create(struct backing_dev_info *bdi,
 	 */
 	ret = -ENODEV;
 	spin_lock_irqsave(&cgwb_lock, flags);
-	if (test_bit(WB_registered, &bdi->wb.state) &&
+	if (test_bit(WB_registered, &bdi_wb_ctx->wb.state) &&
 	    blkcg_cgwb_list->next && memcg_cgwb_list->next) {
 		/* we might have raced another instance of this function */
-		ret = radix_tree_insert(&bdi->cgwb_tree, memcg_css->id, wb);
+		ret = radix_tree_insert(&bdi_wb_ctx->cgwb_tree, memcg_css->id, wb);
 		if (!ret) {
-			list_add_tail_rcu(&wb->bdi_node, &bdi->wb_list);
+			list_add_tail_rcu(&wb->bdi_node, &bdi_wb_ctx->wb_list);
 			list_add(&wb->memcg_node, memcg_cgwb_list);
 			list_add(&wb->blkcg_node, blkcg_cgwb_list);
 			blkcg_pin_online(blkcg_css);
@@ -779,16 +821,16 @@ static int cgwb_create(struct backing_dev_info *bdi,
  * each lookup.  On mismatch, the existing wb is discarded and a new one is
  * created.
  */
-struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
+struct bdi_writeback *wb_get_lookup(struct bdi_writeback_ctx *bdi_wb_ctx,
 				    struct cgroup_subsys_state *memcg_css)
 {
 	struct bdi_writeback *wb;
 
 	if (!memcg_css->parent)
-		return &bdi->wb;
+		return &bdi_wb_ctx->wb;
 
 	rcu_read_lock();
-	wb = radix_tree_lookup(&bdi->cgwb_tree, memcg_css->id);
+	wb = radix_tree_lookup(&bdi_wb_ctx->cgwb_tree, memcg_css->id);
 	if (wb) {
 		struct cgroup_subsys_state *blkcg_css;
 
@@ -813,6 +855,7 @@ struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
  * create one.  See wb_get_lookup() for more details.
  */
 struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
+				    struct bdi_writeback_ctx *bdi_wb_ctx,
 				    struct cgroup_subsys_state *memcg_css,
 				    gfp_t gfp)
 {
@@ -821,45 +864,67 @@ struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 	might_alloc(gfp);
 
 	do {
-		wb = wb_get_lookup(bdi, memcg_css);
-	} while (!wb && !cgwb_create(bdi, memcg_css, gfp));
+		wb = wb_get_lookup(bdi_wb_ctx, memcg_css);
+	} while (!wb && !cgwb_create(bdi, bdi_wb_ctx, memcg_css, gfp));
 
 	return wb;
 }
 
+static int cgwb_bdi_wb_ctx_init(struct backing_dev_info *bdi,
+		struct bdi_writeback_ctx *bdi_wb_ctx)
+{
+	int ret;
+
+	INIT_RADIX_TREE(&bdi_wb_ctx->cgwb_tree, GFP_ATOMIC);
+	init_rwsem(&bdi_wb_ctx->wb_switch_rwsem);
+	ret = wb_init(&bdi_wb_ctx->wb, bdi, GFP_KERNEL);
+	/* better error handling */
+	if (!ret) {
+		bdi_wb_ctx->wb.memcg_css = &root_mem_cgroup->css;
+		bdi_wb_ctx->wb.blkcg_css = blkcg_root_css;
+	}
+	return ret;
+}
+
 static int cgwb_bdi_init(struct backing_dev_info *bdi)
 {
 	int ret;
 
-	INIT_RADIX_TREE(&bdi->cgwb_tree, GFP_ATOMIC);
 	mutex_init(&bdi->cgwb_release_mutex);
-	init_rwsem(&bdi->wb_switch_rwsem);
+	if (bdi->is_parallel) {
+		struct bdi_writeback_ctx *bdi_wb_ctx;
 
-	ret = wb_init(&bdi->wb, bdi, GFP_KERNEL);
-	if (!ret) {
-		bdi->wb.memcg_css = &root_mem_cgroup->css;
-		bdi->wb.blkcg_css = blkcg_root_css;
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+			ret = cgwb_bdi_wb_ctx_init(bdi, bdi_wb_ctx);
+			if (ret)
+				return ret;
+		}
+	} else {
+		cgwb_bdi_wb_ctx_init(bdi, &bdi->default_ctx);
 	}
+
 	return ret;
 }
 
-static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
+/* callers should create a loop and pass bdi_wb_ctx */
+static void cgwb_bdi_unregister(struct backing_dev_info *bdi,
+	struct bdi_writeback_ctx *bdi_wb_ctx)
 {
 	struct radix_tree_iter iter;
 	void **slot;
 	struct bdi_writeback *wb;
 
-	WARN_ON(test_bit(WB_registered, &bdi->wb.state));
+	WARN_ON(test_bit(WB_registered, &bdi_wb_ctx->wb.state));
 
 	spin_lock_irq(&cgwb_lock);
-	radix_tree_for_each_slot(slot, &bdi->cgwb_tree, &iter, 0)
-		cgwb_kill(*slot);
+	radix_tree_for_each_slot(slot, &bdi_wb_ctx->cgwb_tree, &iter, 0)
+		cgwb_kill(*slot, bdi_wb_ctx);
 	spin_unlock_irq(&cgwb_lock);
 
 	mutex_lock(&bdi->cgwb_release_mutex);
 	spin_lock_irq(&cgwb_lock);
-	while (!list_empty(&bdi->wb_list)) {
-		wb = list_first_entry(&bdi->wb_list, struct bdi_writeback,
+	while (!list_empty(&bdi_wb_ctx->wb_list)) {
+		wb = list_first_entry(&bdi_wb_ctx->wb_list, struct bdi_writeback,
 				      bdi_node);
 		spin_unlock_irq(&cgwb_lock);
 		wb_shutdown(wb);
@@ -930,7 +995,7 @@ void wb_memcg_offline(struct mem_cgroup *memcg)
 
 	spin_lock_irq(&cgwb_lock);
 	list_for_each_entry_safe(wb, next, memcg_cgwb_list, memcg_node)
-		cgwb_kill(wb);
+		cgwb_kill(wb, wb->bdi_wb_ctx);
 	memcg_cgwb_list->next = NULL;	/* prevent new wb's */
 	spin_unlock_irq(&cgwb_lock);
 
@@ -950,15 +1015,16 @@ void wb_blkcg_offline(struct cgroup_subsys_state *css)
 
 	spin_lock_irq(&cgwb_lock);
 	list_for_each_entry_safe(wb, next, list, blkcg_node)
-		cgwb_kill(wb);
+		cgwb_kill(wb, wb->bdi_wb_ctx);
 	list->next = NULL;	/* prevent new wb's */
 	spin_unlock_irq(&cgwb_lock);
 }
 
-static void cgwb_bdi_register(struct backing_dev_info *bdi)
+static void cgwb_bdi_register(struct backing_dev_info *bdi,
+		struct bdi_writeback_ctx *bdi_wb_ctx)
 {
 	spin_lock_irq(&cgwb_lock);
-	list_add_tail_rcu(&bdi->wb.bdi_node, &bdi->wb_list);
+	list_add_tail_rcu(&bdi_wb_ctx->wb.bdi_node, &bdi_wb_ctx->wb_list);
 	spin_unlock_irq(&cgwb_lock);
 }
 
@@ -981,14 +1047,31 @@ subsys_initcall(cgwb_init);
 
 static int cgwb_bdi_init(struct backing_dev_info *bdi)
 {
-	return wb_init(&bdi->wb, bdi, GFP_KERNEL);
+	int ret;
+
+	if (bdi->is_parallel) {
+		struct bdi_writeback_ctx *bdi_wb_ctx;
+
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+			ret = wb_init(&bdi_wb_ctx->wb, bdi, GFP_KERNEL);
+			/* better error handling */
+			if (!ret)
+				return ret;
+		}
+	} else {
+		ret = wb_init(&bdi->default_ctx.wb, bdi, GFP_KERNEL);
+	}
+	return ret;
 }
 
-static void cgwb_bdi_unregister(struct backing_dev_info *bdi) { }
+static void cgwb_bdi_unregister(struct backing_dev_info *bdi,
+		struct bdi_writeback_ctx *bdi_wb_ctx) { }
 
-static void cgwb_bdi_register(struct backing_dev_info *bdi)
+/* callers should create a loop and pass bdi_wb_ctx */
+static void cgwb_bdi_register(struct backing_dev_info *bdi,
+		struct bdi_writeback_ctx *bdi_wb_ctx)
 {
-	list_add_tail_rcu(&bdi->wb.bdi_node, &bdi->wb_list);
+	list_add_tail_rcu(&bdi_wb_ctx->wb.bdi_node, &bdi_wb_ctx->wb_list);
 }
 
 static void cgwb_remove_from_bdi_list(struct bdi_writeback *wb)
@@ -1003,12 +1086,14 @@ int bdi_init(struct backing_dev_info *bdi)
 	bdi->dev = NULL;
 
 	kref_init(&bdi->refcnt);
+	bdi->nr_wb_ctx = 1;
+	bdi->is_parallel = false;
 	bdi->min_ratio = 0;
 	bdi->max_ratio = 100 * BDI_RATIO_SCALE;
 	bdi->max_prop_frac = FPROP_FRAC_BASE;
 	INIT_LIST_HEAD(&bdi->bdi_list);
-	INIT_LIST_HEAD(&bdi->wb_list);
-	init_waitqueue_head(&bdi->wb_waitq);
+	INIT_LIST_HEAD(&bdi->default_ctx.wb_list);
+	init_waitqueue_head(&bdi->default_ctx.wb_waitq);
 	bdi->last_bdp_sleep = jiffies;
 
 	return cgwb_bdi_init(bdi);
@@ -1095,11 +1180,20 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
-	cgwb_bdi_register(bdi);
+	if (bdi->is_parallel) {
+		struct bdi_writeback_ctx *bdi_wb_ctx;
+
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+			cgwb_bdi_register(bdi, bdi_wb_ctx);
+			set_bit(WB_registered, &bdi_wb_ctx->wb.state);
+		}
+	} else {
+		cgwb_bdi_register(bdi, &bdi->default_ctx);
+		set_bit(WB_registered, &bdi->default_ctx.wb.state);
+	}
 	bdi->dev = dev;
 
 	bdi_debug_register(bdi, dev_name(dev));
-	set_bit(WB_registered, &bdi->wb.state);
 
 	spin_lock_bh(&bdi_lock);
 
@@ -1155,8 +1249,17 @@ void bdi_unregister(struct backing_dev_info *bdi)
 
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
-	wb_shutdown(&bdi->wb);
-	cgwb_bdi_unregister(bdi);
+	if (bdi->is_parallel) {
+		struct bdi_writeback_ctx *bdi_wb_ctx;
+
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+			wb_shutdown(&bdi_wb_ctx->wb);
+			cgwb_bdi_unregister(bdi, bdi_wb_ctx);
+		}
+	} else {
+		wb_shutdown(&bdi->default_ctx.wb);
+		cgwb_bdi_unregister(bdi, &bdi->default_ctx);
+	}
 
 	/*
 	 * If this BDI's min ratio has been set, use bdi_set_min_ratio() to
@@ -1183,9 +1286,18 @@ static void release_bdi(struct kref *ref)
 	struct backing_dev_info *bdi =
 			container_of(ref, struct backing_dev_info, refcnt);
 
-	WARN_ON_ONCE(test_bit(WB_registered, &bdi->wb.state));
 	WARN_ON_ONCE(bdi->dev);
-	wb_exit(&bdi->wb);
+	if (bdi->is_parallel) {
+		struct bdi_writeback_ctx *bdi_wb_ctx;
+
+		for_each_bdi_wb_ctx(bdi, bdi_wb_ctx) {
+			WARN_ON_ONCE(test_bit(WB_registered, &bdi_wb_ctx->wb.state));
+			wb_exit(&bdi_wb_ctx->wb);
+		}
+	} else {
+		WARN_ON_ONCE(test_bit(WB_registered, &bdi->default_ctx.wb.state));
+		wb_exit(&bdi->default_ctx.wb);
+	}
 	kfree(bdi);
 }
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d9861e42b2bd..51420474b4cf 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2101,6 +2101,7 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
+	struct bdi_writeback_ctx *bdi_wb_ctx = fetch_bdi_writeback_ctx(inode);
 	struct bdi_writeback *wb = NULL;
 	int ratelimit;
 	int ret = 0;
@@ -2110,9 +2111,9 @@ int balance_dirty_pages_ratelimited_flags(struct address_space *mapping,
 		return ret;
 
 	if (inode_cgwb_enabled(inode))
-		wb = wb_get_create_current(bdi, GFP_KERNEL);
+		wb = wb_get_create_current(bdi, bdi_wb_ctx, GFP_KERNEL);
 	if (!wb)
-		wb = &bdi->wb;
+		wb = &bdi_wb_ctx->wb;
 
 	ratelimit = current->nr_dirtied_pause;
 	if (wb->dirty_exceeded)
-- 
2.25.1


------smkAoC60a7u2mLi3Ss29b8NT2iAal2vPoRoPruPDCgH-0Z0S=_1316a_
Content-Type: text/plain; charset="utf-8"


------smkAoC60a7u2mLi3Ss29b8NT2iAal2vPoRoPruPDCgH-0Z0S=_1316a_--

