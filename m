Return-Path: <linux-fsdevel+bounces-77557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFvvDMiTlWk1SgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:26:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B6715561E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF213057E8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355CF2FDC20;
	Wed, 18 Feb 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3DFO7fu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oUr6bhcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEB2FD699
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409895; cv=none; b=oEvy9OX8qhKmZq8J8URWFOIctztw+NNLzpSzyHvXDWVsXVmsNzRRGymBxGiQIDTieXF3y/Md9/2IB+CwK6/fff7/vKo+VZxJP1Jb8Hznw5Uxxrptt6/RgxUl7hl7IeYoVV5ltCn7ggfyAgvn4FMwsXm/RJGbpa4Uk1cAeL1TbT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409895; c=relaxed/simple;
	bh=hEkOYoZ+YvzCIzyqbCCHiW1cU9u4+rx18WM/qq/4Keo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sho6lUtHFUFi/TURVSqrjMGSYjvqnuhe5RQcphZK6KpFfK5ccntk2+bQyKsNT6sJNo5iY1+GNl4vNMOkDYmhWhnlDCV6MXCBmYT6RkOzJ5IupMSOIqs0ilX+E4R/jFs/VYyC9TFzHGh6aX8+Kjh0cfBPBqt79EDozY0DQxfmgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I3DFO7fu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oUr6bhcG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771409893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CdumppwhlBUdillyHNoUIaTpT4tIY7ONjvEdXG67S8c=;
	b=I3DFO7fuOB/p7zSzjdb1yQVJKbUC7KK+UrxhPIa2ZWOo9OI7v5IuoqyDl0fsCLtVi5dgCQ
	b98U18b7L7ngguPqo8gXt6sjOTUAfQWe75CfHgsJ9zPcDCA3ErGjbA6e4tWTHjp4PCqjpj
	JARFquPNPwpEGxmAAXiwlqk4jxbpYBo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-FLZ3aj3_O0erl2lfXvBH2w-1; Wed, 18 Feb 2026 05:18:10 -0500
X-MC-Unique: FLZ3aj3_O0erl2lfXvBH2w-1
X-Mimecast-MFC-AGG-ID: FLZ3aj3_O0erl2lfXvBH2w_1771409889
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435db8ebc98so4872988f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 02:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771409889; x=1772014689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdumppwhlBUdillyHNoUIaTpT4tIY7ONjvEdXG67S8c=;
        b=oUr6bhcG2x4YhoM/N/QevpH+wQFl9gQQM9KVdzimEPUNex9wrf6w9Oc33XuXrOVLgE
         RJ792Rw8QwEhuC++XXoDDDYjVo2+sEEu1HnuFBjoH9nvg8+1WE4zM8tTm2NX4FEr4EQB
         66bqrMdNnlS9Y/l1rK6TkuW82MUgxeLjtBbgiSBi1COh6BVJP7U7GFi1yhfU3kCUSbsh
         AXyPhtHw8WZ1xVzegH4gX2RJ3rMUsFKp8lmKLLdnTVBYvrY2FloOCImx0GyfSpDkM8De
         cT008TvD6checaEAQ6FfI6gH24EaIw+SIxdaVoK2MpcM0Zr7WTOAV07gkwTd7KTT3GmS
         cmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771409889; x=1772014689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdumppwhlBUdillyHNoUIaTpT4tIY7ONjvEdXG67S8c=;
        b=Bo/WUsIZlgntROvKkZPtbSXwyEzoqHdIPkFGFMjfkViVrf5eZ7/4ZiEhUziODnp8eC
         yeyAKeXrxkFjtsymbuhscWJWseTV3djADjD9GlLj1DrQ90LC9bVlE45ueehUN0FRNv2a
         VvfunvBRAX7EPq4XHCCi7leABsw1cuxIeWoTkSmPT0LBW9Sp8K13oBpaYJAKe+vdLXQN
         NPb7jkAPbopOsMHTO06Qa/b8nPgravQGrp1g6gptvOm43n8UwcVQ+CwfDm+qRYxJS1mt
         YqeTCucm9bxbyNyiI7DQS86eEV8m8Nys+mKFr9yPMbQ9aWMVYmyCn12aPm/FIWtMndxs
         noOA==
X-Forwarded-Encrypted: i=1; AJvYcCUk1m77XKC06zxIeAVt8kfgAemwXnNU5EB2hEmVmbhzuM2EE7iKQ/CSo51QzJ/XXKl68kd6zXnQ04RdM0aS@vger.kernel.org
X-Gm-Message-State: AOJu0YymKjqUzbaCjzbEs69fmkzqpmihq8HpZ/K9oeTYxlP0K4rDGOHF
	D1v6v9V9eQ67uVkNxcmIe1EC+0OVvlQPKp+1FlsjMwEV6rnjU3zEiSQkau7s+ZwHFTI/brxpKN2
	VP2wqb2D7q+kTrAoZrSoKiieCiim/M2Ay+FJadkkrMDkS5BnYUFPb7HStUhgjN5X+Fg==
X-Gm-Gg: AZuq6aIerQjmyezOFOYwH/j0yKLS8RXuuBFwwAcPynrvAu1OToHOUBVljWJdkBxX50e
	rw+Vpc5YLs9lKnMTjSJxxzhROardMPEUo+CQdGD8sAw1XbvRlw43+y9r9g9Il02zrOpxfffKX1J
	pSvZCtF8pHDiHirOcxtYzpy9eYvSEHbbzw4kBpQBgf5JSRODa63sQm1Mqpbr/BEFIyL66xZGSp1
	LtthVzDJWfeHsuLo1J3kX2a6pZYD8UakXCptPE8x+WJkml8onQbTbz8MnXRnXgOKIIOPYtAjXID
	kLFzYcWgmTkmRb13EU4qW5tXY1SYJ96iHieODp4byGUXsWXcFY9muTutv5d/ubLf8aHW1R9eMsn
	LiiAwE0I8MM0=
X-Received: by 2002:a05:600c:19c6:b0:480:3bba:1ca9 with SMTP id 5b1f17b1804b1-48398a65e5cmr24011415e9.4.1771409888932;
        Wed, 18 Feb 2026 02:18:08 -0800 (PST)
X-Received: by 2002:a05:600c:19c6:b0:480:3bba:1ca9 with SMTP id 5b1f17b1804b1-48398a65e5cmr24010895e9.4.1771409888328;
        Wed, 18 Feb 2026 02:18:08 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48398244e83sm29376605e9.2.2026.02.18.02.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 02:18:08 -0800 (PST)
Date: Wed, 18 Feb 2026 11:18:07 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH v3 22/35] xfs: add iomap write/writeback and reading of
 Merkle tree pages
Message-ID: <zpdrihys2jk2duk3o76ao4tykc4o7adree2lf3dqzuiqggcaka@xnmbkzswbmpz>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-23-aalbersh@kernel.org>
 <20260218063521.GC8600@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218063521.GC8600@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77557-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88B6715561E
X-Rspamd-Action: no action

On 2026-02-18 07:35:21, Christoph Hellwig wrote:
> > -	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
> > +	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, iomap_flags, XFS_WPC(wpc)->data_seq);
> 
> Overly long line.
> 
> > +		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION)) {
> > +			wbc->range_start = fsverity_metadata_offset(VFS_I(ip));
> > +			wbc->range_end = LLONG_MAX;
> > +			wbc->nr_to_write = LONG_MAX;
> 
> Shouldn't this be taken care of by the caller?

hmm right, I will update filemap_write_and_wait() call in
xfs_fsverity_end_enable(). That the only place writeback of verity
metadata is requested.

> 
> > +			/*
> > +			 * Set IOMAP_F_FSVERITY to skip initial EOF check
> > +			 * The following iomap->flags would be set in
> > +			 * xfs_map_blocks()
> > +			 */
> > +			wpc.ctx.iomap.flags |= IOMAP_F_FSVERITY;
> 
> I'm usually a fan of more comments rather than less, but I don't think
> this adds any value.

Sure, I will rewrite it

-- 
- Andrey


