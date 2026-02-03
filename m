Return-Path: <linux-fsdevel+bounces-76167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKaUBXqmgWktIQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 08:40:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85891D5CB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 08:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DAB2302D97B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79EA36C0B4;
	Tue,  3 Feb 2026 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AFf3iwO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682AD190462
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770104436; cv=none; b=QhE7Li5f92Xb9eqqmEu7xA0hgHaW9M4BfTzkCxvrjlpewAQBZ4bcPE3CyepFMwSDZEn9KJYN2rBAu47GRxZ3zPZjlPbwvhQS+jUrTXsN2C6SqLJyg3LSisyBCitrCPu5fW7zJ50c0kYqD92IZ9r8JfyaK3h5xuJcLYyYSepp5Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770104436; c=relaxed/simple;
	bh=C/Yt0Bq6G7s+7UZwuj3yvtST0+rBYQESUblhgDR7Qpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=jVn7XT7RxMQiSRM5xAn0tb/Sn4uNZOY3t2NiE7JzJcUlWc0ES682lUwAx25RUWUxkIn1JL+OlAdAkIcf1uuTZ15BtHeQBU2yLADG+EBNynM9c3osnFXUST7Ob+FAlxQNJp2TPbEcOnXRg0sGgJ54YQCPUL2OcRYQMEL20cHPGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AFf3iwO0; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260203074031epoutp0198e12ebeb50df2134590248a6e6a2d47~QrJopQit_2712027120epoutp01J
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 07:40:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260203074031epoutp0198e12ebeb50df2134590248a6e6a2d47~QrJopQit_2712027120epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770104431;
	bh=3i42AQPiswee7v6oGNd7Mvy98fe3Jj+1YRuDJvSk26M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=AFf3iwO0Kj+DXTMR/Wgb+/IvCdajP/R/nA9rkWojBJtQ17dF08adb0mmKPg2nGTpT
	 ZMAMuqckShdL7vqMWVdQowO+cNpqXani8sOs7VlWoPvIFqxtcYBqadprgJupf17rii
	 f/3H7ITTQQt9KCd3sE48y1Fotnv+Offc31e02TIM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260203074030epcas5p42de397f727c1b41ad428522b9dd8d241~QrJn8FKKv2876728767epcas5p4n;
	Tue,  3 Feb 2026 07:40:30 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4f4wPn5Z5lz6B9mL; Tue,  3 Feb
	2026 07:40:29 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260203074028epcas5p22debb465f62585a9da0582f1c0c8c227~QrJmEnXRz3059230592epcas5p2a;
	Tue,  3 Feb 2026 07:40:28 +0000 (GMT)
Received: from [107.111.86.57] (unknown [107.111.86.57]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260203074025epsmtip2d3fda19efcf042063b8e8f9ff1cd1b27~QrJi_HYYn0567805678epsmtip2k;
	Tue,  3 Feb 2026 07:40:25 +0000 (GMT)
Message-ID: <1eb3e208-f207-4a04-adbd-9ca143c4f869@samsung.com>
Date: Tue, 3 Feb 2026 13:10:24 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] xfs: offload writeback by AG using per-inode
 dirty bitmap and per-AG workers
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	dave@stgolabs.net, cem@kernel.org, wangyufei@vivo.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
From: Kundan Kumar <kundan.kumar@samsung.com>
In-Reply-To: <20260129223421.GE7712@frogsfrogsfrogs>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260203074028epcas5p22debb465f62585a9da0582f1c0c8c227
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116101305epcas5p497cd6d9027301853669f1c1aaffbf128
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
	<CGME20260116101305epcas5p497cd6d9027301853669f1c1aaffbf128@epcas5p4.samsung.com>
	<20260116100818.7576-7-kundan.kumar@samsung.com>
	<20260129223421.GE7712@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	TAGGED_FROM(0.00)[bounces-76167-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,samsung.com:dkim,samsung.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kundan.kumar@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 85891D5CB6
X-Rspamd-Action: no action

On 1/30/2026 4:04 AM, Darrick J. Wong wrote:
> On Fri, Jan 16, 2026 at 03:38:18PM +0530, Kundan Kumar wrote:
>> Offload XFS writeback to per-AG workers based on the inode dirty-AG
>> bitmap. Each worker scans and submits writeback only for folios
>> belonging to its AG.
>>
>> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> ---
>>   fs/xfs/xfs_aops.c | 178 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 178 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
>> index 9d5b65922cd2..55c3154fb2b5 100644
>> --- a/fs/xfs/xfs_aops.c
>> +++ b/fs/xfs/xfs_aops.c
>> @@ -678,6 +678,180 @@ xfs_zoned_writeback_submit(
>>   	return 0;
>>   }
>>   
>> +static bool xfs_agp_match(struct xfs_inode *ip, pgoff_t index,
>> +			  xfs_agnumber_t agno)
>> +{
>> +	void *ent;
>> +	u32 v;
>> +	bool match = false;
>> +
>> +	ent = xa_load(&ip->i_ag_pmap, index);
>> +	if (ent && xa_is_value(ent)) {
>> +		v = xa_to_value(ent);
>> +		if (xfs_agp_valid(v))
>> +			match = (xfs_agp_agno(v) == (u32)agno);
>> +	}
>> +
>> +	return match;
>> +}
>> +
>> +static bool xfs_folio_matches_ag(struct folio *folio, xfs_agnumber_t agno)
>> +{
>> +	struct xfs_inode *ip = XFS_I(folio_mapping(folio)->host);
>> +
>> +	return xfs_agp_match(ip, folio->index, agno);
>> +}
>> +
>> +static int xfs_writepages_ag(struct xfs_inode *ip,
>> +			     struct writeback_control *wbc,
>> +			     xfs_agnumber_t agno)
>> +{
>> +	struct inode *inode = VFS_I(ip);
>> +	struct address_space *mapping = inode->i_mapping;
>> +	struct folio_batch *fbatch = &wbc->fbatch;
>> +	int ret = 0;
>> +	pgoff_t index, end;
>> +
>> +	wbc->range_cyclic = 0;
>> +
>> +	folio_batch_init(fbatch);
>> +	index = wbc->range_start >> PAGE_SHIFT;
>> +	end = wbc->range_end >> PAGE_SHIFT;
>> +
>> +	struct xfs_writepage_ctx wpc = {
>> +		.ctx = {
>> +			.inode = inode,
>> +			.wbc = wbc,
>> +			.ops = &xfs_writeback_ops,
>> +		},
>> +	};
>> +
>> +	while (index <= end) {
>> +		int i, nr;
>> +
>> +		/* get a batch of DIRTY folios starting at index */
>> +		nr = filemap_get_folios_tag(mapping, &index, end,
>> +					    PAGECACHE_TAG_DIRTY, fbatch);
>> +		if (!nr)
>> +			break;
>> +
>> +		for (i = 0; i < nr; i++) {
>> +			struct folio *folio = fbatch->folios[i];
>> +
>> +			/* Filter BEFORE locking */
>> +			if (!xfs_folio_matches_ag(folio, agno))
> 
> So we grab a batch of dirty folios, and only /then/ check to see if
> they've been tagged with the target agno?  That doesn't seem very
> efficient if there are a lot of dirty folio and they're not evenly
> distributed among AGs.
> 

i_ag_dirty_bitmap is a hint populated at write time to indicate that an
inode likely has dirty folios tagged for AG X, so we only kick workers 
for AGs that should have work. That said, folios may not be evenly 
distributed across AGs, so a worker can still end up scanning and 
finding few or no matches in some cases.

>> +				continue;
>> +
>> +			folio_lock(folio);
>> +
>> +			/*
>> +			 * Now it's ours: clear dirty and submit.
>> +			 * This prevents *this AG worker* from seeing it again
>> +			 * next time.
>> +			 */
>> +			if (!folio_clear_dirty_for_io(folio)) {
>> +				folio_unlock(folio);
>> +				continue;
>> +			}
>> +			xa_erase(&ip->i_ag_pmap, folio->index);
> 
> Why erase the association?  Is this because once we've written the folio
> back to storage, we want a subsequent write to a fsblock within that
> folio to tag the folio with the agnumber of that fsblock?  Hrm, maybe
> that's how you deal with multi-fsblock folios; the folio tag reflects
> the first block to be dirtied within the folio?
> 

The primary reason for erasing the entry is to keep the metadata 
bounded, once the folio is written back and clean, there is no need to 
retain any AG association, so we drop it to free the per-folio state. On 
the next write, the folio is re-tagged based on the iomap for that write.

This also helps with multi-fsblock folios: by re-tagging on each 
clean->dirty transition.

>> +
>> +			ret = iomap_writeback_folio(&wpc.ctx, folio);
>> +			folio_unlock(folio);
>> +
>> +			if (ret) {
>> +				folio_batch_release(fbatch);
>> +				goto out;
>> +			}
>> +		}
>> +
>> +		folio_batch_release(fbatch);
>> +		cond_resched();
>> +	}
>> +
>> +out:
>> +	if (wpc.ctx.wb_ctx && wpc.ctx.ops && wpc.ctx.ops->writeback_submit)
>> +		wpc.ctx.ops->writeback_submit(&wpc.ctx, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static void xfs_ag_writeback_work(struct work_struct *work)
>> +{
>> +	struct xfs_ag_wb *awb = container_of(to_delayed_work(work),
>> +					     struct xfs_ag_wb, ag_work);
>> +	struct xfs_ag_wb_task *task;
>> +	struct xfs_mount *mp;
>> +	struct inode *inode;
>> +	struct xfs_inode *ip;
>> +	int ret;
>> +
>> +	for (;;) {
>> +		spin_lock(&awb->lock);
>> +		task = list_first_entry_or_null(&awb->task_list,
>> +						struct xfs_ag_wb_task, list);
>> +		if (task)
>> +			list_del_init(&task->list);
>> +		spin_unlock(&awb->lock);
>> +
>> +		if (!task)
>> +			break;
>> +
>> +		ip = task->ip;
>> +		mp = ip->i_mount;
>> +		inode = VFS_I(ip);
>> +
>> +		ret = xfs_writepages_ag(ip, &task->wbc, task->agno);
>> +
>> +		/* If didn't submit everything for this AG, set its bit */
>> +		if (ret)
>> +			set_bit(task->agno, ip->i_ag_dirty_bitmap);
>> +
>> +		iput(inode); /* drop igrab */
>> +		mempool_free(task, mp->m_ag_task_pool);
>> +	}
>> +}
>> +
>> +static int xfs_vm_writepages_offload(struct address_space *mapping,
>> +				     struct writeback_control *wbc)
>> +{
>> +	struct inode *inode = mapping->host;
>> +	struct xfs_inode *ip = XFS_I(inode);
>> +	struct xfs_mount *mp = ip->i_mount;
>> +	struct xfs_ag_wb *awb;
>> +	struct xfs_ag_wb_task *task;
>> +	xfs_agnumber_t agno;
>> +
>> +	if (!ip->i_ag_dirty_bits)
>> +		return 0;
>> +
>> +	for_each_set_bit(agno, ip->i_ag_dirty_bitmap, ip->i_ag_dirty_bits) {
>> +		if (!test_and_clear_bit(agno, ip->i_ag_dirty_bitmap))
>> +			continue;
>> +
>> +		task =  mempool_alloc(mp->m_ag_task_pool, GFP_NOFS);
> 
> Allocating memory (even from a mempool) during writeback makes me
> nervous...
> 

Agreed. We'll remove this allocation entirely. Instead of allocating an
xfs_ag_wb_task in ->writepages, we'll maintain a mount-wide list of 
"active" inodes (those with a non-empty dirty-AG hint). The offload path 
will only enqueue the inode on that list and kick the relevant AG workers.

Each AG worker will then walk the active inode list and scan the 
pagecache, filtering folios tagged for its AG and submitting IO. This 
keeps thewriteback path allocation-free and avoids mempool use under 
reclaim.

>> +		if (!task) {
>> +			set_bit(agno, ip->i_ag_dirty_bitmap);
>> +			continue;
>> +		}
> 
> ...because apparently the allocation can fail.  If so, then why don't we
> just fall back to serial writeback instead of ... moving on to the next
> AG and seeing if there's more memory?
> 
>> +
>> +		INIT_LIST_HEAD(&task->list);
>> +		task->ip = ip;
>> +		task->agno = agno;
>> +		task->wbc = *wbc;
>> +		igrab(inode); /* worker owns inode ref */
> 
> Shouldn't we check for a null return value here?  That should never
> happen, but we /do/ have the option of falling back to standard
> iomap_writepages.
> 

Yes I will fix this in next version.

>> +
>> +		awb = &mp->m_ag_wb[agno];
>> +
>> +		spin_lock(&awb->lock);
>> +		list_add_tail(&task->list, &awb->task_list);
>> +		spin_unlock(&awb->lock);
>> +
>> +		mod_delayed_work(mp->m_ag_wq, &awb->ag_work, 0);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
>>   	.writeback_range	= xfs_zoned_writeback_range,
>>   	.writeback_submit	= xfs_zoned_writeback_submit,
>> @@ -706,6 +880,7 @@ xfs_init_ag_writeback(struct xfs_mount *mp)
>>   	for (agno = 0; agno < mp->m_sb.sb_agcount; agno++) {
>>   		struct xfs_ag_wb *awb = &mp->m_ag_wb[agno];
>>   
>> +		INIT_DELAYED_WORK(&awb->ag_work, xfs_ag_writeback_work);
>>   		spin_lock_init(&awb->lock);
>>   		INIT_LIST_HEAD(&awb->task_list);
>>   		awb->agno = agno;
>> @@ -769,6 +944,9 @@ xfs_vm_writepages(
>>   			xfs_open_zone_put(xc.open_zone);
>>   		return error;
>>   	} else {
>> +		if (wbc->sync_mode != WB_SYNC_ALL)
>> +			return xfs_vm_writepages_offload(mapping, wbc);
>> +
>>   		struct xfs_writepage_ctx	wpc = {
>>   			.ctx = {
>>   				.inode	= mapping->host,
>> -- 
>> 2.25.1
>>
>>
> 


