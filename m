Return-Path: <linux-fsdevel+bounces-75914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBgaN3Lge2lyJAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 23:34:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 17384B562C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 23:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFCB83004413
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D6B368282;
	Thu, 29 Jan 2026 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3aIfBKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F23432939C;
	Thu, 29 Jan 2026 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726062; cv=none; b=b2urDuqc3m0IHXPl22CSPvANu9FooJbjOcKhgUxUUlrTyw3oTmNzfr+bxNE63YqSpkTSFW32RMX5LjDVjhYPKQqqj8BMegbPHc6xorwLN9Tsl3YfYQm0qCLXYik2ks+KsWepfSKdMhgJZjaaLmXPqzbzmCzDfjM/EZl7f8GARZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726062; c=relaxed/simple;
	bh=aAsAQr3olCVAPwtnbMv+uKrBk9dB7Xxlgu3OYuVbFgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny2Teailr7NcZMGRr+77WyGyVgzYpy6psF2uluwrEMQ4/+w1wZfUTh84wahjaIdCmFmK4R5s4enRJFHgimEBTn0EaxZw0rbVGbxzHn5Ev/2DpmyRCXwItOWJxJJ1a0Y3FntoxeEzmCWxSO2OvLSs9KJCPnYt4KZgL7v9/K9rb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3aIfBKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D07C4CEF7;
	Thu, 29 Jan 2026 22:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769726061;
	bh=aAsAQr3olCVAPwtnbMv+uKrBk9dB7Xxlgu3OYuVbFgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k3aIfBKUpMQTLAl18ZSlFFxyK4de6DV6bM0MJut9fsQbs+B9SUiM6sLpiQU5BnYg+
	 z5ZvLpTOEPD/o3Fi+TxkwSedlZosqXCT/XVjDugwguNV4l1BnIlmnp391M4iznR328
	 KMnY1pNfZgbSDdJRIbiRhXmXnU8xKLhYj5xXdtKRS7rS4aPcRgt891nTs3fglhJgIb
	 i0NEPceT8Sls/IB5ieb9pRBK/Hanu40d1jM2QvvjGK6dODI9fuaH6v8IahNbWKxJEX
	 sAEtBzUPuoBDLG+OIrSEg7744r0fgIA+M/8QS1tg8SXJqpSe1qeoqLtNX0wL3C0keg
	 IVk930WXDnc2A==
Date: Thu, 29 Jan 2026 14:34:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com,
	david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk,
	hch@lst.de, ritesh.list@gmail.com, dave@stgolabs.net,
	cem@kernel.org, wangyufei@vivo.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v3 6/6] xfs: offload writeback by AG using per-inode
 dirty bitmap and per-AG workers
Message-ID: <20260129223421.GE7712@frogsfrogsfrogs>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
 <CGME20260116101305epcas5p497cd6d9027301853669f1c1aaffbf128@epcas5p4.samsung.com>
 <20260116100818.7576-7-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116100818.7576-7-kundan.kumar@samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75914-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 17384B562C
X-Rspamd-Action: no action

On Fri, Jan 16, 2026 at 03:38:18PM +0530, Kundan Kumar wrote:
> Offload XFS writeback to per-AG workers based on the inode dirty-AG
> bitmap. Each worker scans and submits writeback only for folios
> belonging to its AG.
> 
> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  fs/xfs/xfs_aops.c | 178 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 9d5b65922cd2..55c3154fb2b5 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -678,6 +678,180 @@ xfs_zoned_writeback_submit(
>  	return 0;
>  }
>  
> +static bool xfs_agp_match(struct xfs_inode *ip, pgoff_t index,
> +			  xfs_agnumber_t agno)
> +{
> +	void *ent;
> +	u32 v;
> +	bool match = false;
> +
> +	ent = xa_load(&ip->i_ag_pmap, index);
> +	if (ent && xa_is_value(ent)) {
> +		v = xa_to_value(ent);
> +		if (xfs_agp_valid(v))
> +			match = (xfs_agp_agno(v) == (u32)agno);
> +	}
> +
> +	return match;
> +}
> +
> +static bool xfs_folio_matches_ag(struct folio *folio, xfs_agnumber_t agno)
> +{
> +	struct xfs_inode *ip = XFS_I(folio_mapping(folio)->host);
> +
> +	return xfs_agp_match(ip, folio->index, agno);
> +}
> +
> +static int xfs_writepages_ag(struct xfs_inode *ip,
> +			     struct writeback_control *wbc,
> +			     xfs_agnumber_t agno)
> +{
> +	struct inode *inode = VFS_I(ip);
> +	struct address_space *mapping = inode->i_mapping;
> +	struct folio_batch *fbatch = &wbc->fbatch;
> +	int ret = 0;
> +	pgoff_t index, end;
> +
> +	wbc->range_cyclic = 0;
> +
> +	folio_batch_init(fbatch);
> +	index = wbc->range_start >> PAGE_SHIFT;
> +	end = wbc->range_end >> PAGE_SHIFT;
> +
> +	struct xfs_writepage_ctx wpc = {
> +		.ctx = {
> +			.inode = inode,
> +			.wbc = wbc,
> +			.ops = &xfs_writeback_ops,
> +		},
> +	};
> +
> +	while (index <= end) {
> +		int i, nr;
> +
> +		/* get a batch of DIRTY folios starting at index */
> +		nr = filemap_get_folios_tag(mapping, &index, end,
> +					    PAGECACHE_TAG_DIRTY, fbatch);
> +		if (!nr)
> +			break;
> +
> +		for (i = 0; i < nr; i++) {
> +			struct folio *folio = fbatch->folios[i];
> +
> +			/* Filter BEFORE locking */
> +			if (!xfs_folio_matches_ag(folio, agno))

So we grab a batch of dirty folios, and only /then/ check to see if
they've been tagged with the target agno?  That doesn't seem very
efficient if there are a lot of dirty folio and they're not evenly
distributed among AGs.

> +				continue;
> +
> +			folio_lock(folio);
> +
> +			/*
> +			 * Now it's ours: clear dirty and submit.
> +			 * This prevents *this AG worker* from seeing it again
> +			 * next time.
> +			 */
> +			if (!folio_clear_dirty_for_io(folio)) {
> +				folio_unlock(folio);
> +				continue;
> +			}
> +			xa_erase(&ip->i_ag_pmap, folio->index);

Why erase the association?  Is this because once we've written the folio
back to storage, we want a subsequent write to a fsblock within that
folio to tag the folio with the agnumber of that fsblock?  Hrm, maybe
that's how you deal with multi-fsblock folios; the folio tag reflects
the first block to be dirtied within the folio?

> +
> +			ret = iomap_writeback_folio(&wpc.ctx, folio);
> +			folio_unlock(folio);
> +
> +			if (ret) {
> +				folio_batch_release(fbatch);
> +				goto out;
> +			}
> +		}
> +
> +		folio_batch_release(fbatch);
> +		cond_resched();
> +	}
> +
> +out:
> +	if (wpc.ctx.wb_ctx && wpc.ctx.ops && wpc.ctx.ops->writeback_submit)
> +		wpc.ctx.ops->writeback_submit(&wpc.ctx, ret);
> +
> +	return ret;
> +}
> +
> +static void xfs_ag_writeback_work(struct work_struct *work)
> +{
> +	struct xfs_ag_wb *awb = container_of(to_delayed_work(work),
> +					     struct xfs_ag_wb, ag_work);
> +	struct xfs_ag_wb_task *task;
> +	struct xfs_mount *mp;
> +	struct inode *inode;
> +	struct xfs_inode *ip;
> +	int ret;
> +
> +	for (;;) {
> +		spin_lock(&awb->lock);
> +		task = list_first_entry_or_null(&awb->task_list,
> +						struct xfs_ag_wb_task, list);
> +		if (task)
> +			list_del_init(&task->list);
> +		spin_unlock(&awb->lock);
> +
> +		if (!task)
> +			break;
> +
> +		ip = task->ip;
> +		mp = ip->i_mount;
> +		inode = VFS_I(ip);
> +
> +		ret = xfs_writepages_ag(ip, &task->wbc, task->agno);
> +
> +		/* If didn't submit everything for this AG, set its bit */
> +		if (ret)
> +			set_bit(task->agno, ip->i_ag_dirty_bitmap);
> +
> +		iput(inode); /* drop igrab */
> +		mempool_free(task, mp->m_ag_task_pool);
> +	}
> +}
> +
> +static int xfs_vm_writepages_offload(struct address_space *mapping,
> +				     struct writeback_control *wbc)
> +{
> +	struct inode *inode = mapping->host;
> +	struct xfs_inode *ip = XFS_I(inode);
> +	struct xfs_mount *mp = ip->i_mount;
> +	struct xfs_ag_wb *awb;
> +	struct xfs_ag_wb_task *task;
> +	xfs_agnumber_t agno;
> +
> +	if (!ip->i_ag_dirty_bits)
> +		return 0;
> +
> +	for_each_set_bit(agno, ip->i_ag_dirty_bitmap, ip->i_ag_dirty_bits) {
> +		if (!test_and_clear_bit(agno, ip->i_ag_dirty_bitmap))
> +			continue;
> +
> +		task =  mempool_alloc(mp->m_ag_task_pool, GFP_NOFS);

Allocating memory (even from a mempool) during writeback makes me
nervous...

> +		if (!task) {
> +			set_bit(agno, ip->i_ag_dirty_bitmap);
> +			continue;
> +		}

...because apparently the allocation can fail.  If so, then why don't we
just fall back to serial writeback instead of ... moving on to the next
AG and seeing if there's more memory?

> +
> +		INIT_LIST_HEAD(&task->list);
> +		task->ip = ip;
> +		task->agno = agno;
> +		task->wbc = *wbc;
> +		igrab(inode); /* worker owns inode ref */

Shouldn't we check for a null return value here?  That should never
happen, but we /do/ have the option of falling back to standard
iomap_writepages.

> +
> +		awb = &mp->m_ag_wb[agno];
> +
> +		spin_lock(&awb->lock);
> +		list_add_tail(&task->list, &awb->task_list);
> +		spin_unlock(&awb->lock);
> +
> +		mod_delayed_work(mp->m_ag_wq, &awb->ag_work, 0);
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
>  	.writeback_range	= xfs_zoned_writeback_range,
>  	.writeback_submit	= xfs_zoned_writeback_submit,
> @@ -706,6 +880,7 @@ xfs_init_ag_writeback(struct xfs_mount *mp)
>  	for (agno = 0; agno < mp->m_sb.sb_agcount; agno++) {
>  		struct xfs_ag_wb *awb = &mp->m_ag_wb[agno];
>  
> +		INIT_DELAYED_WORK(&awb->ag_work, xfs_ag_writeback_work);
>  		spin_lock_init(&awb->lock);
>  		INIT_LIST_HEAD(&awb->task_list);
>  		awb->agno = agno;
> @@ -769,6 +944,9 @@ xfs_vm_writepages(
>  			xfs_open_zone_put(xc.open_zone);
>  		return error;
>  	} else {
> +		if (wbc->sync_mode != WB_SYNC_ALL)
> +			return xfs_vm_writepages_offload(mapping, wbc);
> +
>  		struct xfs_writepage_ctx	wpc = {
>  			.ctx = {
>  				.inode	= mapping->host,
> -- 
> 2.25.1
> 
> 

