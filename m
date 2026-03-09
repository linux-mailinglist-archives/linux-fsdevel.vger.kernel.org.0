Return-Path: <linux-fsdevel+bounces-79834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHmnJ7APr2kYNQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:21:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9D823E8B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 19:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E01C308104B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 18:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F76186E2E;
	Mon,  9 Mar 2026 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0qKMM3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8E2D592F
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080345; cv=none; b=J3gXSIiAH+pCPFR5VEJCZ56x8GtKXwZLovmZ8kCp7cg+lHX2i6tXd1VXOLBUCr6h79/ynF3peEV9y9e41QcBpOOqFmsovRsjwfOPROQlDyJjPYlyxA2dnutBOgR5sYIANQiFiAz/pe86FAxrddVsLNiuloARa6Qns7dBH7qaelg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080345; c=relaxed/simple;
	bh=wknnr9MoC+bkdr5zC/PBjCqgsLeUAGOlPG/OIO29ecI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSddB173eBnFr9Jo5+VBMy2vZiSjRDCVaA24tJxy1ltyNQVhLacaNd0sQzHu2BghHSs3hrgbZVg4jMMXKEkjMZu5xsdWhsAFue2lDbrduxXfnonrv18o13CBocVtbTLtrFGP3kq/RzNHbnAgmzswXgZ8uE6+m4TPO2FLYYmoZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0qKMM3u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773080343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cLA0FswOMLrW4AW155XudpOPWcl/Opi/LJ23QbeWMlQ=;
	b=G0qKMM3uKG9RAPtIVlkl1PvQ2GWrP2jFlJS0ICqHN0SOzKDbZrpcED0EOyLFzKZswYW4ew
	yjVbo/iCM9yRhcH11nuhdy6nTd6sn+02L+FaqEpboBqdn2S5G0La5n5S8KO/urpSLz62bz
	LWUiGrDK6c1E3U0hiyKq85/CEGolrsM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-1PWVPQrJMTqveX9EeT7IHw-1; Mon,
 09 Mar 2026 14:18:59 -0400
X-MC-Unique: 1PWVPQrJMTqveX9EeT7IHw-1
X-Mimecast-MFC-AGG-ID: 1PWVPQrJMTqveX9EeT7IHw_1773080339
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D750C19560A3;
	Mon,  9 Mar 2026 18:18:58 +0000 (UTC)
Received: from bfoster (unknown [10.22.89.107])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 393DA19560A6;
	Mon,  9 Mar 2026 18:18:58 +0000 (UTC)
Date: Mon, 9 Mar 2026 14:18:56 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 1/8] xfs: fix iomap hole map reporting for zoned zero
 range
Message-ID: <aa8PEP9EvKuXYhgO@bfoster>
References: <20260309134506.167663-1-bfoster@redhat.com>
 <20260309134506.167663-2-bfoster@redhat.com>
 <20260309171100.GL6033@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309171100.GL6033@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 1D9D823E8B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79834-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.990];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 10:11:00AM -0700, Darrick J. Wong wrote:
> On Mon, Mar 09, 2026 at 09:44:59AM -0400, Brian Foster wrote:
> > The hole mapping logic for zero range in zoned mode is not quite
> > correct. It currently reports a hole whenever one exists in the data
> > fork. If the first write to a sparse range has completed and not yet
> > written back, the blocks exist in the COW fork as delalloc until
> > writeback completes, at which point they are allocated and mapped
> > into the data fork. If a zero range occurs on a range that has not
> > yet populated the data fork, we will incorrectly report it as a
> > hole.
> > 
> > Note that this currently functions correctly because we are bailed
> > out by the pagecache flush in iomap_zero_range(). If a hole or
> > unwritten mapping is reported with dirty pagecache, it assumes there
> > is pending data, flushes to induce any pending block
> > allocations/remaps, and retries the lookup. We want to remove this
> > hack from iomap, however, so update iomap_begin() to only report a
> > hole for zeroing when one exists in both forks.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/xfs/xfs_iomap.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index be86d43044df..8c3469d2c73e 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -1651,14 +1651,6 @@ xfs_zoned_buffered_write_iomap_begin(
> >  				&smap))
> >  			smap.br_startoff = end_fsb; /* fake hole until EOF */
> >  		if (smap.br_startoff > offset_fsb) {
> > -			/*
> > -			 * We never need to allocate blocks for zeroing a hole.
> > -			 */
> > -			if (flags & IOMAP_ZERO) {
> > -				xfs_hole_to_iomap(ip, iomap, offset_fsb,
> > -						smap.br_startoff);
> > -				goto out_unlock;
> > -			}
> >  			end_fsb = min(end_fsb, smap.br_startoff);
> >  		} else {
> >  			end_fsb = min(end_fsb,
> > @@ -1690,6 +1682,16 @@ xfs_zoned_buffered_write_iomap_begin(
> >  	count_fsb = min3(end_fsb - offset_fsb, XFS_MAX_BMBT_EXTLEN,
> >  			 XFS_B_TO_FSB(mp, 1024 * PAGE_SIZE));
> >  
> > +	/*
> > +	 * When zeroing, don't allocate blocks for holes as they are already
> > +	 * zeroes, but we need to ensure that no extents exist in both the data
> > +	 * and COW fork to ensure this really is a hole.
> 
> But where is the cow fork check?  iomap_iter initializes srcmap to
> IOMAP_HOLE, so if we end up here on an IOMAP_ZERO then we've scanned the
> data fork and found no mapping.  But then we jump to out_unlock, which
> means we don't actually look at ip->cowfp.
> 

The COW fork is checked a few lines up from where this is added. If it
finds blocks it exits out, if not it falls into this codepath for
allocation into the fork (implying a hole).

Brian

> <confused>
> 
> --D
> 
> > +	 */
> > +	if ((flags & IOMAP_ZERO) && srcmap->type == IOMAP_HOLE) {
> > +		xfs_hole_to_iomap(ip, iomap, offset_fsb, end_fsb);
> > +		goto out_unlock;
> > +	}
> > +
> >  	/*
> >  	 * The block reservation is supposed to cover all blocks that the
> >  	 * operation could possible write, but there is a nasty corner case
> > -- 
> > 2.52.0
> > 
> > 
> 


