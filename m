Return-Path: <linux-fsdevel+bounces-76457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFgjA+i+hGnG4wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 17:01:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABCBF4E83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 17:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 075CB304D269
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E8D42884B;
	Thu,  5 Feb 2026 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9MAi7sO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D595742B750
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307004; cv=none; b=RDGPbCVo56NGZvYdkcuSXlMUTvWt/cvu9DtymzcUt4mA1GLQG7Yk4tKOI5MHxVHvpzVK4zUDVr/kzFOKHYJSrB6JwcZo6u3S4eu2EKwpK/X5tqLgfyWDeculzCa+DcOB5zPESXKnlpNW/FkIrx4q1w1s/D7jdWlx5cAPldQPN6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307004; c=relaxed/simple;
	bh=kwPrLxzmNu6NXm5vCQB29eSnXsK0FAJJVr9hC/uwkt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvyLdfoN2Y5iXarX5qDJkjPMZ4cT4O6iXGtpvvIFnMeW0Xp3fjS2kX6uQ+pC5TlDOVqQ6xyoh7sMXIrKfn5yiclPsPyhjlb5waeQ0PXw+deHlebSCd02l4qtHskjE9lI/e0I1mvpvJqVcBI5kXy+PRsxujW4c6PqNDSq7wLZXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9MAi7sO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770307002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eUzdVsVgqGYxQMSlMfTZqWPBf2xiq3xt7FhI76ZwiI=;
	b=H9MAi7sOdquAAq/GOqglyfH3WhXaBeOfEO10mcdcWo4a81+HXjnjYyGRxb7buM7cEDYWEH
	efODtW8BT/yCsVl9FeW+G5gHb9Xp0zeRzpRft3w28Y8Z29OiMKQiea7TMdHcD4XIPg/dc4
	yqFbdrRiSfZS+Qk8FI2XysWflXoHMuY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-AUlrj7mrP0CGSw1HpnAcmw-1; Thu,
 05 Feb 2026 10:56:36 -0500
X-MC-Unique: AUlrj7mrP0CGSw1HpnAcmw-1
X-Mimecast-MFC-AGG-ID: AUlrj7mrP0CGSw1HpnAcmw_1770306993
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 589AB1955F28;
	Thu,  5 Feb 2026 15:56:32 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.110])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0266300DDA1;
	Thu,  5 Feb 2026 15:56:26 +0000 (UTC)
Date: Thu, 5 Feb 2026 10:56:24 -0500
From: Brian Foster <bfoster@redhat.com>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, willy@infradead.org,
	mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de,
	ritesh.list@gmail.com, dave@stgolabs.net, cem@kernel.org,
	wangyufei@vivo.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	anuj20.g@samsung.com, vishak.g@samsung.com, joshi.k@samsung.com
Subject: Re: [PATCH v3 4/6] xfs: tag folios with AG number during buffered
 write via iomap attach hook
Message-ID: <aYS9qOxsv-xoUwGZ@bfoster>
References: <20260116100818.7576-1-kundan.kumar@samsung.com>
 <CGME20260116101256epcas5p2d6125a6bcad78c33f737fdc3484aca79@epcas5p2.samsung.com>
 <20260116100818.7576-5-kundan.kumar@samsung.com>
 <20260129004745.GC7712@frogsfrogsfrogs>
 <7dc267e7-b6e0-4be2-a60e-9d90dcf472eb@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dc267e7-b6e0-4be2-a60e-9d90dcf472eb@samsung.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76457-lists,linux-fsdevel=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[samsung.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,infradead.org,meta.com,fromorbit.com,gmail.com,kernel.dk,lst.de,stgolabs.net,vivo.com,vger.kernel.org,kvack.org,samsung.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[anuj20.g.samsung.com:query timed out,kundan.kumar.samsung.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9ABCBF4E83
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:58:34PM +0530, Kundan Kumar wrote:
> On 1/29/2026 6:17 AM, Darrick J. Wong wrote:
> > On Fri, Jan 16, 2026 at 03:38:16PM +0530, Kundan Kumar wrote:
> >> Use the iomap attach hook to tag folios with their predicted
> >> allocation group at write time. Mapped extents derive AG directly;
> >> delalloc and hole cases use a lightweight predictor.
> >>
> >> Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
> >> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> >> ---
> >>   fs/xfs/xfs_iomap.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 114 insertions(+)
> >>
> >> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> >> index 490e12cb99be..3c927ce118fe 100644
> >> --- a/fs/xfs/xfs_iomap.c
> >> +++ b/fs/xfs/xfs_iomap.c
> >> @@ -12,6 +12,9 @@
> >>   #include "xfs_trans_resv.h"
> >>   #include "xfs_mount.h"
> >>   #include "xfs_inode.h"
> >> +#include "xfs_alloc.h"
> >> +#include "xfs_ag.h"
> >> +#include "xfs_ag_resv.h"
> >>   #include "xfs_btree.h"
> >>   #include "xfs_bmap_btree.h"
> >>   #include "xfs_bmap.h"
> >> @@ -92,8 +95,119 @@ xfs_iomap_valid(
> >>   	return true;
> >>   }
> >>   
> >> +static xfs_agnumber_t
> >> +xfs_predict_delalloc_agno(const struct xfs_inode *ip, loff_t pos, loff_t len)
> >> +{
> >> +	struct xfs_mount *mp = ip->i_mount;
> >> +	xfs_agnumber_t start_agno, agno, best_agno;
> >> +	struct xfs_perag *pag;
> >> +
> >> +	xfs_extlen_t free, resv, avail;
> >> +	xfs_extlen_t need_fsbs, min_free_fsbs;
> >> +	xfs_extlen_t best_free = 0;
> >> +	xfs_agnumber_t agcount = mp->m_sb.sb_agcount;
> >> +
> >> +	/* RT inodes allocate from the realtime volume */
> >> +	if (XFS_IS_REALTIME_INODE(ip))
> >> +		return XFS_INO_TO_AGNO(mp, ip->i_ino);
> >> +
> >> +	start_agno =  XFS_INO_TO_AGNO(mp, ip->i_ino);
> >> +
> >> +	/*
> >> +	 * size-based minimum free requirement.
> >> +	 * Convert bytes to fsbs and require some slack.
> >> +	 */
> >> +	need_fsbs = XFS_B_TO_FSB(mp, (xfs_fsize_t)len);
> >> +	min_free_fsbs = need_fsbs + max_t(xfs_extlen_t, need_fsbs >> 2, 128);
> >> +
> >> +	/*
> >> +	 * scan AGs starting at start_agno and wrapping.
> >> +	 * Pick the first AG that meets min_free_fsbs after reservations.
> >> +	 * Keep a "best" fallback = maximum (free - resv).
> >> +	 */
> >> +	best_agno = start_agno;
> >> +
> >> +	for (xfs_agnumber_t i = 0; i < agcount; i++) {
> >> +		agno = (start_agno + i) % agcount;
> >> +		pag = xfs_perag_get(mp, agno);
> >> +
> >> +		if (!xfs_perag_initialised_agf(pag))
> >> +			goto next;
> >> +
> >> +		free = READ_ONCE(pag->pagf_freeblks);
> >> +		resv = xfs_ag_resv_needed(pag, XFS_AG_RESV_NONE);
> >> +
> >> +		if (free <= resv)
> >> +			goto next;
> >> +
> >> +		avail = free - resv;
> >> +
> >> +		if (avail >= min_free_fsbs) {
> >> +			xfs_perag_put(pag);
> >> +			return agno;
> >> +		}
> >> +
> >> +		if (avail > best_free) {
> >> +			best_free = avail;
> >> +			best_agno = agno;
> >> +		}
> >> +next:
> >> +		xfs_perag_put(pag);
> >> +	}
> >> +
> >> +	return best_agno;
> >> +}
> >> +
> >> +static inline xfs_agnumber_t xfs_ag_from_iomap(const struct xfs_mount *mp,
> >> +		const struct iomap *iomap,
> >> +		const struct xfs_inode *ip, loff_t pos, size_t len)
> >> +{
> >> +	if (iomap->type == IOMAP_MAPPED || iomap->type == IOMAP_UNWRITTEN) {
> >> +		/* iomap->addr is byte address on device for buffered I/O */
> >> +		xfs_fsblock_t fsb = XFS_BB_TO_FSBT(mp, BTOBB(iomap->addr));
> >> +
> >> +		return XFS_FSB_TO_AGNO(mp, fsb);
> >> +	} else if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_DELALLOC) {
> >> +		return xfs_predict_delalloc_agno(ip, pos, len);
> > 
> > Is it worth doing an AG scan to guess where the allocation might come
> > from?  The predictions could turn out to be wrong by virtue of other
> > delalloc regions being written back between the time that xfs_agp_set is
> > called, and the actual bmapi_write call.
> > 
> 
> The delalloc prediction works well in the common cases: (1) when an AG 
> has sufficient free space and allocations stay within it, and (2) when 
> an AG becomes full and allocation naturally moves to the next suitable AG.
> 
> The only case where the prediction can be wrong is when an AG is in the
> process of being exhausted concurrently with writeback, so allocation
> shifts between the time we tag the folio and the actual bmapi_write.
> My understanding is that window is narrow, and only a small fraction of 
> IOs would be misrouted.
> 

I wonder how true that would be under more mixed workloads. For example,
if writeback is iterating AGs under a trylock, all it really takes to
redirect incorrectly is lock contention, which then seems like it could
be a compounding factor for other AG workers.

Another thing that comes to mind is the writeback delay. For example, if
we buffer up enough delalloc in pagecache to one or more inodes that
target the same AG, then it seems possible to hint folios to AGs that
are already full, they "just don't know it yet." Maybe that is more of
an odd/rare case though.

Perhaps the better question here is.. how would one test for this? It
might be interesting to have stats counters or something that could
indicate hits and misses wrt the hint such that this could be more
easily evaluated against different workloads (assuming that doesn't
already exist and I missed it).. hm?

Brian

> >> +	}
> >> +
> >> +	return XFS_INO_TO_AGNO(mp, ip->i_ino);
> >> +}
> >> +
> >> +static void xfs_agp_set(struct xfs_inode *ip, pgoff_t index,
> >> +			xfs_agnumber_t agno, u8 type)
> >> +{
> >> +	u32 packed = xfs_agp_pack((u32)agno, type, true);
> >> +
> >> +	/* store as immediate value */
> >> +	xa_store(&ip->i_ag_pmap, index, xa_mk_value(packed), GFP_NOFS);
> >> +
> >> +	/* Mark this AG as having potential dirty work */
> >> +	if (ip->i_ag_dirty_bitmap && (u32)agno < ip->i_ag_dirty_bits)
> >> +		set_bit((u32)agno, ip->i_ag_dirty_bitmap);
> >> +}
> >> +
> >> +static void
> >> +xfs_iomap_tag_folio(const struct iomap *iomap, struct folio *folio,
> >> +		loff_t pos, size_t len)
> >> +{
> >> +	struct inode *inode;
> >> +	struct xfs_inode *ip;
> >> +	struct xfs_mount *mp;
> >> +	xfs_agnumber_t agno;
> >> +
> >> +	inode = folio_mapping(folio)->host;
> >> +	ip = XFS_I(inode);
> >> +	mp = ip->i_mount;
> >> +
> >> +	agno = xfs_ag_from_iomap(mp, iomap, ip, pos, len);
> >> +
> >> +	xfs_agp_set(ip, folio->index, agno, (u8)iomap->type);
> > 
> > Hrm, so no, the ag_pmap only caches the ag number for the index of a
> > folio, even if it spans many many blocks.
> > 
> > --D
> > 
> 
> Thanks for pointing out, I will rework to handle this case.
> 
> >> +}
> >> +
> >>   const struct iomap_write_ops xfs_iomap_write_ops = {
> >>   	.iomap_valid		= xfs_iomap_valid,
> >> +	.tag_folio		= xfs_iomap_tag_folio,
> >>   };
> >>   
> >>   int
> >> -- 
> >> 2.25.1
> >>
> >>
> > 
> 
> 


