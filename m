Return-Path: <linux-fsdevel+bounces-79431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBSQGqtnqGl3uQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 18:11:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B25204EC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 18:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E69C930CAD48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ED8378823;
	Wed,  4 Mar 2026 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgR9KCvA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32683376BDC
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643857; cv=none; b=qR7FBfILI3jd/430ChwMOGAPXPGSfbxqRVf2adJK0jfNOmhYT//1X6iQfF9I3cMeRGK4Z3SM395b7VwadLzk4WdNIfgz+4sleCBFSQ715mVmkeBNZRK18kUxDiK+zET2nIhScN7ewbP2MyOLcNRej/FGuRSC0P3wAbMri1PxL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643857; c=relaxed/simple;
	bh=N9bqg+zuj5jfjRoQwkYbE3By4c80B02cGJcwY8Qt3tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quFy2s+9OmZK5OfypqiekhUGmpw8onW8DGkOWGOod8gEz8CIdfyUNMSLqXcemkcu40S4qI6/X/2riVIDnyJPGeYQEepnRHP0UjIuQn21CLpiPXtlWjwoZDNvrpkFY51D+9t5KVoRix3wEEWCn3IsDYUs2BSmXyrokxTG+e1HTtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgR9KCvA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772643855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8GfexEkfqFL5XRJKzVVmmvcp8C4kKdZL+qnu7d+OPnk=;
	b=bgR9KCvA5KnX/bPshCfS8bptQV9kMX69ZvnAX5JYNMEM7mj8oqpmU1wk0ZAB0Nn0GHLzpr
	4L3kBunlAy023WGlwasBV11Q3TdKNeajfo/YKi3fn9yzjY2xVt1bmVdwdQxEZOPCSU1c7v
	xYMasLn0yj/1z52cXOtOl5AJvRWoUHk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-XzRWCnM-Og6G3lLVo0u-fg-1; Wed,
 04 Mar 2026 12:04:11 -0500
X-MC-Unique: XzRWCnM-Og6G3lLVo0u-fg-1
X-Mimecast-MFC-AGG-ID: XzRWCnM-Og6G3lLVo0u-fg_1772643848
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4AF21956067;
	Wed,  4 Mar 2026 17:04:07 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 130DC1958DC7;
	Wed,  4 Mar 2026 17:04:06 +0000 (UTC)
Date: Wed, 4 Mar 2026 12:04:04 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aahmBCz1xJBCPcZ-@bfoster>
References: <20260129155028.141110-2-bfoster@redhat.com>
 <aY6_eqkIrMkOr039@infradead.org>
 <aY9hY7TwgMXJNzkI@bfoster>
 <aaXesgEmu46X7OwD@bfoster>
 <aabyFY0l7GTEHnoQ@infradead.org>
 <aacv39AZ5P9ubOZ5@bfoster>
 <aagv8y96vGHvbOdX@infradead.org>
 <aag-_c8G_L5MQ42m@bfoster>
 <aahEk4yNqd15BIt7@infradead.org>
 <aahJcVkrkLRtsJO9@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aahJcVkrkLRtsJO9@bfoster>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 15B25204EC6
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
	TAGGED_FROM(0.00)[bounces-79431-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 10:02:09AM -0500, Brian Foster wrote:
> On Wed, Mar 04, 2026 at 06:41:23AM -0800, Christoph Hellwig wrote:
> > On Wed, Mar 04, 2026 at 09:17:33AM -0500, Brian Foster wrote:
> > > I tested the change below but it ended up failing xfs/131. Some fast and
> > > loose (i.e. LLM assisted) trace analysis suggests the issue is that this
> > > particular situation is racy. I.e., we write to a sparse file range and
> > > add COW fork dellaloc, writeback kicks in and drops the delalloc
> > > mapping, then zeroing occurs over said range and finds holes in both
> > > forks, then zone I/O completion occurs and maps blocks into the data
> > > fork.
> > 
> > Yes, that can happen.  But the folio will be locked or have the
> > writeback bit set over that whole period, so I can't see how writeback
> > can actually race with that?
> > 
> 
> I think that's why the flush (i.e. current behavior) works..
> 
> The change in my last mail attempts to replace the flush with improved
> reporting to only report a hole if one exists in both COW/data forks at
> the same time. So basically if the data fork is currently a hole and
> writeback kicks in, xfs_zoned_map_blocks() deletes the COW fork mapping
> and carries on with zoned writeback handling. At that point if zeroing
> occurs, it would see holes in both the COW (just removed) and data fork
> (not yet mapped in) and think there's nothing to do.
> 
> The idea is that if say we instead did something like transfer delalloc
> into the data fork at writeback time, if the data fork had a hole, then
> we could always tell from the iomap mapping whether we need to zero or
> not without flushing or consulting pagecache at all.
> 

This patch seems to work on a quick test. It's basically the two patches
squashed together (I'd post them as independent patches), so nothing too
different, but if we fix up the zero logic first that helps clean up the
indentation as a bonus.

Brian

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index be86d43044df..27470ec8372b 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1590,6 +1590,7 @@ xfs_zoned_buffered_write_iomap_begin(
 {
 	struct iomap_iter	*iter =
 		container_of(iomap, struct iomap_iter, iomap);
+	struct address_space	*mapping = inode->i_mapping;
 	struct xfs_zone_alloc_ctx *ac = iter->private;
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
@@ -1614,6 +1615,7 @@ xfs_zoned_buffered_write_iomap_begin(
 	if (error)
 		return error;
 
+restart:
 	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
 	if (error)
 		return error;
@@ -1651,14 +1653,6 @@ xfs_zoned_buffered_write_iomap_begin(
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
@@ -1690,6 +1684,31 @@ xfs_zoned_buffered_write_iomap_begin(
 	count_fsb = min3(end_fsb - offset_fsb, XFS_MAX_BMBT_EXTLEN,
 			 XFS_B_TO_FSB(mp, 1024 * PAGE_SIZE));
 
+	/*
+	 * We don't allocate blocks for zeroing a hole, but we only report a
+	 * hole in zoned mode if one exists in both the COW and data forks.
+	 *
+	 * There is currently a corner case where writeback removes the COW fork
+	 * mapping and unlocks the inode, leaving a transient state where a hole
+	 * exists in both forks until write completion maps blocks into the data
+	 * fork. Until we can avoid this transient hole state, detect and avoid
+	 * this with a flush of any such range that appears dirty in pagecache.
+	 */
+	if ((flags & IOMAP_ZERO) && srcmap->type == IOMAP_HOLE) {
+		if (filemap_range_needs_writeback(mapping, offset,
+						  offset + count - 1)) {
+			xfs_iunlock(ip, lockmode);
+			error = filemap_write_and_wait_range(mapping, offset,
+							    offset + count - 1);
+			if (error)
+				return error;
+			goto restart;
+		}
+
+		xfs_hole_to_iomap(ip, iomap, offset_fsb, end_fsb);
+		goto out_unlock;
+	}
+
 	/*
 	 * The block reservation is supposed to cover all blocks that the
 	 * operation could possible write, but there is a nasty corner case


