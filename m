Return-Path: <linux-fsdevel+bounces-79399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA3XFPNDqGlOrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:38:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 794DD201B0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCCFB3107154
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E3C3B892D;
	Wed,  4 Mar 2026 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENg61SKE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1737E30A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633862; cv=none; b=kyvmHZTbr9pPLpXJ08eHEyvChxCaKYgyCnYCny6A2z1ZCMtKctcBUm6JNV/16rdDoA5I+a/jFO18zG8JbopKfAZ9ztpYcv/j2YNoQn9+rVelwDwOXnX3KR40h6rvwkfFejNOLNgCgeG+Ycyq7D+2LypigkJxXz8hm6VXR+RGiXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633862; c=relaxed/simple;
	bh=6JtS69mYUoBbU7O0h20B2ARRKM1cOUFfRPOspk6wUGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYR8O9bD9x9xCJGPOWlP+MG9S2VrF8jSvoBoDtTDSwSaJAQwfG649/0TQYuLheckCSGLOVIi18sUYZGyGpeNZZwNxWaegkuUxSARJyv/q1BQMlm6ePc0MDvU7CgBQTGpPNzzyeHHMqbdyTn/SOqVUenmaxQFqqapKNDr7OiN9Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENg61SKE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+rfuylRovf4/Oqh1rAeQkQoGs+Chd5zhIaqFe+tJyI=;
	b=ENg61SKE67bHqwdfLMy5AILo05GI2BAAt0TKWtWhwgqFBGf9YoaTvGpzIKg+S8GShbQUMG
	RkhYqewuxfD0CzOMucODYtyhoOKIcimiLYeh5zNHSBK2OiB3waSdUjh4gC9pG0X/4Jcg/2
	CR9NhxvApYy6XeqJh9UBV2tdGFnZe4M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-UOXJ1lTDMLu7yu-6TgFfvw-1; Wed,
 04 Mar 2026 09:17:37 -0500
X-MC-Unique: UOXJ1lTDMLu7yu-6TgFfvw-1
X-Mimecast-MFC-AGG-ID: UOXJ1lTDMLu7yu-6TgFfvw_1772633856
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 070061800365;
	Wed,  4 Mar 2026 14:17:36 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CF0B1958DC2;
	Wed,  4 Mar 2026 14:17:35 +0000 (UTC)
Date: Wed, 4 Mar 2026 09:17:33 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aag-_c8G_L5MQ42m@bfoster>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-2-bfoster@redhat.com>
 <aY6_eqkIrMkOr039@infradead.org>
 <aY9hY7TwgMXJNzkI@bfoster>
 <aaXesgEmu46X7OwD@bfoster>
 <aabyFY0l7GTEHnoQ@infradead.org>
 <aacv39AZ5P9ubOZ5@bfoster>
 <aagv8y96vGHvbOdX@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aagv8y96vGHvbOdX@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 794DD201B0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79399-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:13:23AM -0800, Christoph Hellwig wrote:
> On Tue, Mar 03, 2026 at 02:00:47PM -0500, Brian Foster wrote:
> > Oh I see. If I follow the high level flow here, zoned mode always writes
> > through COW fork delalloc, and then writeback appears to remove the
> > delalloc mapping and then does whatever physical zone allocation magic
> > further down in the submission path. So there are no unwritten extents
> > nor COW fork preallocation as far as I can tell.
> 
> Yes.
> 
> > I think that actually means the IOMAP_ZERO logic for the zoned
> > iomap_begin handler is slightly wrong as it is. I was originally
> > thinking this was just another COW fork prealloc situation, but in
> > actuality it looks like zoned mode intentionally creates this COW fork
> > blocks over data fork hole scenario on first write to a previously
> > unallocated file range.
> 
> Yes.
> 
> > IOMAP_ZERO returns a hole whenever one exists in the data fork, so that
> > means we're not properly reporting a data mapping up until the range is
> > allocated in the data fork (i.e. writeback occurs at least once). The
> > reason this has worked is presumably because iomap does the flush when
> > the range of a reported hole is dirty, so it retries the mapping lookup
> 
> Yeah.
> 
> > So the fix I posted works just the same.. lifting the flush just
> > preserves how things work today. But I think what this means is that we
> > should also be able to rework zoned mode IOMAP_ZERO handling to require
> > neither the flush nor dirty folio lookup. It should be able to return a
> > mapping to zero if blocks exist in either fork (allocating to COW fork
> > if necessary), otherwise report a hole.
> 
> Yeah.  If there still is a delalloc mapping in the COW fork we could
> actually steal that for zeroing.
> 
> 

I tested the change below but it ended up failing xfs/131. Some fast and
loose (i.e. LLM assisted) trace analysis suggests the issue is that this
particular situation is racy. I.e., we write to a sparse file range and
add COW fork dellaloc, writeback kicks in and drops the delalloc
mapping, then zeroing occurs over said range and finds holes in both
forks, then zone I/O completion occurs and maps blocks into the data
fork.

So this still seems like generally the right idea to me, but we probably
need to find a way to avoid the transient hole situation on an unlocked
inode. For example, maybe the COW fork delalloc could stay around
longer, or transfer to the data fork at writeback time if the data fork
range happens to be a hole.

But that's just handwaving and beyond the scope of this series. For now
I'll probably go back to the flush fix and document some of this in the
patch for future reference..

Brian

--- 8< ---

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 255b650c3790..533d44633177 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1651,14 +1651,6 @@ xfs_zoned_buffered_write_iomap_begin(
 				&smap))
 			smap.br_startoff = end_fsb; /* fake hole until EOF */
 		if (smap.br_startoff > offset_fsb) {
-			/*
-			 * We never need to allocate blocks for zeroing a hole.
-			 */
-			if (flags & IOMAP_ZERO) {
-				xfs_hole_to_iomap(ip, iomap, offset_fsb,
-						smap.br_startoff);
-				goto out_unlock;
-			}
 			end_fsb = min(end_fsb, smap.br_startoff);
 		} else {
 			end_fsb = min(end_fsb,
@@ -1690,6 +1682,15 @@ xfs_zoned_buffered_write_iomap_begin(
 	count_fsb = min3(end_fsb - offset_fsb, XFS_MAX_BMBT_EXTLEN,
 			 XFS_B_TO_FSB(mp, 1024 * PAGE_SIZE));
 
+	/*
+	 * We don't allocate blocks for zeroing a hole, but we only report a
+	 * hole in zoned mode if one exists in both the COW and data forks.
+	 */
+	if ((flags & IOMAP_ZERO) && srcmap->type == IOMAP_HOLE) {
+		xfs_hole_to_iomap(ip, iomap, offset_fsb, end_fsb);
+		goto out_unlock;
+	}
+
 	/*
 	 * The block reservation is supposed to cover all blocks that the
 	 * operation could possible write, but there is a nasty corner case


