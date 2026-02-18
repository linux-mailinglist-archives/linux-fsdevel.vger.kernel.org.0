Return-Path: <linux-fsdevel+bounces-77554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOk/FRaOlWl7SQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:01:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E822E15511B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08CD6303B4C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D85533D6CB;
	Wed, 18 Feb 2026 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ4x99Hf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+EV+HOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78433D502
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408662; cv=none; b=BdL3RYhxAVf1pJ3moiGeTNS4yHAAvjUsRKDTysUo2BXqIZn+WqfcrVCs38URRebgxfACuxigAKI5/b8i5HcQNtwqAO/IlwtEIiYPqNBPhjTbMIZbWNV1wOcE3+7WEQv6OrEsCi2S9uYHJMdS7xhbVdEfPqnMl0OvGJlFnrGONKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408662; c=relaxed/simple;
	bh=6aOIQiPaQR+XKiGerpItA4/7Z/95kKFkL1ZGyjcNy1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF2G0R0YJ8AvVOcIiBbFJiRcBiycXEj8CEtOw63iP/NSQYQO0NlZjQPoSPKvZDyJxnYsXa9uE28Jwo2jg1esaXsmvDjy2FyH7iFFEjf1J0D005jHLR5xI82s4q2q9YoV9e9MXw7RPF09uG5Fca9v3w6j5wxd50xllaeQy+pWPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQ4x99Hf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+EV+HOw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771408660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=//uspxAcdKQl0NBbsDDK4OeRCiJdPlDUYGGqBQXBcNc=;
	b=IQ4x99HfOQv8vGeMWFnh3IuKTRgNze/OOizEDk9cXDC2QI7GCoTrwYtaABcCoUZXLPcZgc
	mb9kCPOBXy9GsaTJSQ6+YDPrw6uw6m1H6z1p83toMh9XhXu2E8zXAAisDgyNp0wL9995Pt
	O75kmysVHjC2F/blJszlvuVTyfkY8Os=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-nvBJfpkhNc-swpheOebK4g-1; Wed, 18 Feb 2026 04:57:38 -0500
X-MC-Unique: nvBJfpkhNc-swpheOebK4g-1
X-Mimecast-MFC-AGG-ID: nvBJfpkhNc-swpheOebK4g_1771408658
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso28315405e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 01:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771408657; x=1772013457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=//uspxAcdKQl0NBbsDDK4OeRCiJdPlDUYGGqBQXBcNc=;
        b=S+EV+HOwXcML8p0VxD2MKBcuonNoxmyFYzZHvzcDPnrk2wkiO2Dh84O71rM8nBgVuP
         nqjmoacRGlILt3TFq9qwjKnR0p16mpS6cso9veyXQKINFiF8+A09XqCltd6jMHfgNYk4
         pzArnu8ElnRxm/x/YdKS3nqwbWstVEKm0IAl/RLWV/iuXftzT7NjESrronXb83dY9V+A
         IMgnmWrlO34HuuqSSBvmX7hF6XbrUyN6rzyTcukBX+CR6R9AkvGHT3bX8k88qdI+3ABp
         qcuFTKBqftLo0LD31WNfnnAVJgRYa+matC2eLHJkVrynGxNoLBulLuy/cTuRznExPEY/
         xYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771408657; x=1772013457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//uspxAcdKQl0NBbsDDK4OeRCiJdPlDUYGGqBQXBcNc=;
        b=wMmiuIFrQJ+tAmcvSsnP+XLiMNSFwqDCq9CbDdNjAjaa0CYHIUhxbMstMLH/AElCsr
         +qZvJBur7g+Zn/jNtOzLB4fSxNldgC0upooyiYnu9d0lR85sx0srrpF+ebmj/45IT8fd
         mQc/s2UAzbAmrUYqYQxrF35q73U71FN2oVK6GHsjJLSuEkk820NEPmBjdcWozdlosxbz
         GDQZjSKUZPwv/q/D9h/eChCLyOZ3iw5+bkDPjjB0p/Ewvl3rNcGsTMST2320uP1gIUjX
         PblsV+6MS8mKja9h84E/J7T8TG26vc4YIZjFp116aGFK+hoMOzifAnf/GgE3JGPl980o
         oj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSaZ0j4BD/uPAqSqohrS9vmQFcvDlADb9nyQXICtKHGCYp0vD89hUVc7sCwEPf3lw1MSdoih9i1GG31eAW@vger.kernel.org
X-Gm-Message-State: AOJu0YzsfRT1Zqb5XI1NWkQ/6VnwyEJ9Wm4mmFYJfNRy6dt/yvSCmf+O
	ESs3ZPec6pDl5qOmPI7jEcGisM7cBSRshx6+j+YpSxCc2wrWv6sdCDh/a96KeQgcUwSb2/sN2XY
	7EH/vOmcvYalCWejZD84b4A5YZxcuBGf+MpHvC+hxIUYkyZKT1QllfrCnmWLpRb27/A==
X-Gm-Gg: AZuq6aL9lL+ebMl6C3VcXTvlCp9moLiM7GPCwDNDIFL+sR1uk+fdP9nNakdBZjAvWVQ
	GaLT/Ibbxt/s2SNXG7M95Wf7B/EubmAkR67BlPgy7qaq88xZmRCaXSLJCSowj18SkF/19UTD4sM
	4iSgjvgyrwraWxXVqNimI6tjg1450y1NbY8bvB0fL3hy13hiy+rrrLTrW3kL89HFOoRxPkvuMQS
	cjDtsdgDtp7lPQoKVTZI4XnykpKJ35+SHi25pmbZ4a8X7NcYPgV58Lnq5KmfOd6UxCAK0LCthEc
	xyyFPtow73xPdO8xr9gh5pHtXGJ2Et0d1JuI/yn8Q/sxMAUxSBMD1xoUtnOlTUByocXS4frnu/u
	mmmjz0TCenX0=
X-Received: by 2002:a05:600c:820f:b0:483:71f7:2797 with SMTP id 5b1f17b1804b1-48379b9f3a3mr224711125e9.14.1771408657370;
        Wed, 18 Feb 2026 01:57:37 -0800 (PST)
X-Received: by 2002:a05:600c:820f:b0:483:71f7:2797 with SMTP id 5b1f17b1804b1-48379b9f3a3mr224710785e9.14.1771408656858;
        Wed, 18 Feb 2026 01:57:36 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837b68e5adsm382224275e9.9.2026.02.18.01.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:57:36 -0800 (PST)
Date: Wed, 18 Feb 2026 10:57:35 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH v3 28/35] xfs: add fs-verity support
Message-ID: <mtnj4ahovgefkl4pexgwkxrreq6fm7hwpk5lgeaihxg7z5zdlz@tpzevymml5qx>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-29-aalbersh@kernel.org>
 <20260218064429.GC8768@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218064429.GC8768@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77554-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E822E15511B
X-Rspamd-Action: no action

On 2026-02-18 07:44:29, Christoph Hellwig wrote:
> > +static int
> > +xfs_fsverity_read(
> > +	struct inode	*inode,
> > +	void		*buf,
> > +	size_t		count,
> > +	loff_t		pos)
> > +{
> > +	struct folio	*folio;
> > +	size_t		n;
> > +
> > +	while (count) {
> 
> It might be nice to lift this from ext4/f2fs into common code rather
> than adding yet another duplicate.

sure

> 
> > +static int
> > +xfs_fsverity_write(
> > +	struct file		*file,
> > +	loff_t			pos,
> > +	size_t			length,
> > +	const void		*buf)
> > +{
> > +	int			ret;
> > +	struct iov_iter		iiter;
> > +	struct kvec		kvec = {
> > +		.iov_base	= (void *)buf,
> > +		.iov_len	= length,
> > +	};
> > +	struct kiocb		iocb = {
> > +		.ki_filp	= file,
> > +		.ki_ioprio	= get_current_ioprio(),
> > +		.ki_pos		= pos,
> > +	};
> > +
> > +	iov_iter_kvec(&iiter, WRITE, &kvec, 1, length);
> > +
> > +	ret = iomap_file_buffered_write(&iocb, &iiter,
> > +				   &xfs_buffered_write_iomap_ops,
> > +				   &xfs_iomap_write_ops, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +	return 0;
> 
> I'd move this to fs/iomap/ as and pass in the ops.

sure

> 
> > +static int
> > +xfs_fsverity_drop_descriptor_page(
> > +	struct inode	*inode,
> > +	u64		offset)
> > +{
> > +	pgoff_t index = offset >> PAGE_SHIFT;
> > +
> > +	return invalidate_inode_pages2_range(inode->i_mapping, index, index);
> > +}
> 
> What is the rationale for this?  Why do ext4 and f2fs get away without
> it?

They don't skip blocks full of zero hashes and then synthesize them.
XFS has holes in the tree and this is handling for the case
fs block size < PAGE_SIZE when these tree holes are in one folio
with descriptor. Iomap can not fill them without getting descriptor
first.

Should I add this to the comment above? Not sure how well it's
described

> 
> > +	pgoff_t			index)
> > +{
> > +	pgoff_t			metadata_idx =
> > +		(fsverity_metadata_offset(inode) >> PAGE_SHIFT);
> > +	pgoff_t			idx = index + metadata_idx;
> > +
> > +	return generic_read_merkle_tree_page(inode, idx);
> 
> I'd write this the same way ext4/f2fs do:
> 
> 	idx += (fsverity_metadata_offset(inode) >> PAGE_SHIFT);
> 	return generic_read_merkle_tree_page(inode, idx);
> 

sure

> 
> 
> > +{
> > +	pgoff_t			metadata_idx =
> > +		(fsverity_metadata_offset(inode) >> PAGE_SHIFT);
> > +	pgoff_t			idx = index + metadata_idx;
> > +
> > +	generic_readahead_merkle_tree(inode, idx, nr_pages);
> 
> Same here.
> 
> > +	if ((i == size) && (size == ip->i_mount->m_sb.sb_blocksize))
> 
> No need for the inner braces.
> 

-- 
- Andrey


