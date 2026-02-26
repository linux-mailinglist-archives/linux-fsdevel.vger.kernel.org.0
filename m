Return-Path: <linux-fsdevel+bounces-78635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAwIKJqsoGlulgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:27:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A3C1AF1A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCB830A2BA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871D1466B61;
	Thu, 26 Feb 2026 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQrL6ITS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA553A4F48
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137368; cv=none; b=is0xgsUfKHm+0NOOtauzHCxdO2xBtD36tszhzJ7RGW1yXljBlByVl0G041kN3QyY7K9zMVfXNUqYLinSkzMyTX/QWGt8lCZwe8run0tDTGtjerCszpXp395ikg9oMm2jVXnfBU9NU1g8pr9ZRm9uPxURCrwEK50yIMfVKNUuyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137368; c=relaxed/simple;
	bh=goH8RCwy3vIyoMa9jRYpSrn5Zkp3LvqVeAVfYxxYTvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqV8fJxF4P3Egu4tQ0hr1FTTIAyncAkpYLJBiPONUkUW9MGIaCilVuUK6QPQ+hsgS+9SAryBp0YaDT3AOnY7H/GZZT74hA9EgFIhtYSz/sKrUVxTV7lN6STl3cj7VUmWYBwHt9sM6dOWonyGyFAvgEEh1tfIvByy21UPM1INRpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQrL6ITS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772137365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yWZNpYzf4Dqw3i94iV7fiiH7gq94n6HGTsUtIH3AsWA=;
	b=UQrL6ITSY0feq6fQVCgBdMT6y2tRwg88mtZCdMVQYJiu+sQreuW9bZmFgdFPyN7MQBgWYP
	XtV1JUYsZtP+Iw4pPWJ06lSdXNhIu8k7Lp3PXYOz6QbfT59mKTWKrSKEhCdifaFweWzRdm
	/Te0yaQF+uLEkN8reeX1ENV6qtLJqeU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-XAF75V7rOmW6OA1s9pG8XQ-1; Thu,
 26 Feb 2026 15:22:41 -0500
X-MC-Unique: XAF75V7rOmW6OA1s9pG8XQ-1
X-Mimecast-MFC-AGG-ID: XAF75V7rOmW6OA1s9pG8XQ_1772137360
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 339CB1956064;
	Thu, 26 Feb 2026 20:22:39 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.229])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E41019560B5;
	Thu, 26 Feb 2026 20:22:36 +0000 (UTC)
Date: Thu, 26 Feb 2026 15:22:32 -0500
From: Brian Foster <bfoster@redhat.com>
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org
Subject: Re: [PATCH] mm: fix pagecache_isize_extended() early-return bypass
 for large folio mappings
Message-ID: <aaCriOt-CDs4sciP@bfoster>
References: <20240919160741.208162-3-bfoster@redhat.com>
 <3F3A46783F8E9D52+20260226133149.79586-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3A46783F8E9D52+20260226133149.79586-1-zhangdandan@uniontech.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78635-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41A3C1AF1A7
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:31:49PM +0800, Morduan Zang wrote:
> pagecache_isize_extended() has two early-return guards that were designed
> for the traditional sub-page block-size case:
> 
>   Guard 1:  if (from >= to || bsize >= PAGE_SIZE)
>                 return;
> 
>   Guard 2:  rounded_from = round_up(from, bsize);
>             if (to <= rounded_from || !(rounded_from & (PAGE_SIZE - 1)))
>                 return;
> 
> Guard 1 was originally "bsize == PAGE_SIZE" and was widened to
> "bsize >= PAGE_SIZE" by commit 2ebe90dab980 ("mm: convert
> pagecache_isize_extended to use a folio").  The rationale is correct
> for the traditional buffer_head path: when the block size equals the page
> size, every folio covers exactly one block, so writeback's EOF handling
> (e.g. iomap_writepage_handle_eof()) zeros the post-EOF tail of the folio
> before writing it out, and no action is needed here.
> 
> Guard 2 covers the case where @from rounded up to the next block boundary
> is already PAGE_SIZE-aligned, meaning no hole block straddles a page
> boundary.
> 
> Both guards are correct for the traditional case.  However, commit
> 52aecaee1c26 ("mm: zero range of eof folio exposed by inode size extension")
> added post-EOF zeroing inside pagecache_isize_extended() to
> handle dirty folios that will not go through writeback before the new
> i_size becomes visible.  That zeroing code is placed after both guards,
> so it is unreachable whenever either guard fires.
> 
> The same stale-data window is also covered by xfstests generic/363
> which uses fsx with "-e 1" (EOF pollution mode) and exercises a broad
> range of size-changing operations.
> 

Hi Morduan,

So looking back at the original cover letter for this, this bit was for
the case where we had a dirty folio in pagecache that might be partially
hole backed due to eof, therefore fs zeroing might not occur.  Hence we
do the page zeroing here before exposing this range to the file (i.e.
that writeback would have done if the folio were clean).

I thought at the time this plus the ext4 patch covered the bases for
generic/363 on ext4. You refer to this test above but don't mention if
it fails. Do you reproduce a failure with that test, or is this
something discovered by inspection?

> Fixes: 52aecaee1c26 ("mm: zero range of eof folio exposed by inode size extension")
> Fixes: 2ebe90dab980 ("mm: convert pagecache_isize_extended to use a folio")
> Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
> ---
>  mm/truncate.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 12467c1bd711..d3e473a206b3 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -847,13 +847,32 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
>  
>  	WARN_ON(to > inode->i_size);
>  
> -	if (from >= to || bsize >= PAGE_SIZE)
> +	if (from >= to)
>  		return;
> +
> +	/*
> +	 * For filesystems with bsize >= PAGE_SIZE, the traditional buffer_head
> +	 * path handles post-EOF zeroing correctly at writeback time. However,
> +	 * with large folios enabled, a single folio can span multiple PAGE_SIZE
> +	 * blocks, so mmap writes beyond EOF within the same folio are not zeroed
> +	 * at writeback time before i_size is extended. We must handle this here.
> +	 */
> +	if (bsize >= PAGE_SIZE) {
> +		/*
> +		 * Only needed if the mapping supports large folios, since otherwise
> +		 * each folio is exactly one page and writeback handles EOF zeroing.
> +		 */
> +		if (!mapping_large_folio_support(inode->i_mapping))
> +			return;

Is there currently a case for bsize >= PAGE_SIZE &&
!mapping_large_folio_support()? I thought there was a WIP for
multi-block folios, but I wasn't sure if that actually worked anywhere.

> +		goto find_folio;
> +	}
> +
>  	/* Page straddling @from will not have any hole block created? */
>  	rounded_from = round_up(from, bsize);
>  	if (to <= rounded_from || !(rounded_from & (PAGE_SIZE - 1)))
>  		return;
>  

If I understood this code correctly (and I very well may not), the
purpose of this is to basically filter out cases where a dirty eof folio
doesn't require a refault after the size update for the fs to fully
populate it with blocks. If that is the case, this makes me wonder if
perhaps this check should remain, but instead use folio_size() of the
eof folio (if one exists)..?

My understanding at one point was that we wouldn't have large eof folios
that included a page aligned offset beyond eof, but I also feel like
I've run into that once or twice when dealing with some other oddball fs
related issues, so I'm not really clear on what the expected behavior is
supposed to be there. Maybe it's a corner case (i.e. related to split
failure or some such)..? That is probably a question for Willy..

Brian

> +find_folio:
>  	folio = filemap_lock_folio(inode->i_mapping, from / PAGE_SIZE);
>  	/* Folio not cached? Nothing to do */
>  	if (IS_ERR(folio))
> -- 
> 2.50.1
> 
> 


