Return-Path: <linux-fsdevel+bounces-77698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKUwFwPwlmngrAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 12:12:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F9215E313
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 12:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 841A33007C97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52F274B37;
	Thu, 19 Feb 2026 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoJxr3nA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXh90YZ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62E33D6FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771499485; cv=none; b=L0vdVR2G/rc66CU7V9tnC2PuhKSG0Zl/+hl83Bo6Hb61HGswUn6o64AkBzaTK8JapDj9QnWRxw1uea8ZnYMAuLzn8MQaSskIUUWPfBdWsewR8r9HqtAasrp6TnMpS8zvQbgSRDsqCAmoCZVwYbFFGrNBc6sgBEP2QOQ29EyCdNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771499485; c=relaxed/simple;
	bh=nB0bTsF21LZ1FMr3dpBbHwJVzpYmVbgqeukyG/vW3pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGoWEmIsb063zAT91q70RDFHLII1v2tUY6UANwZjzT0zqbKJoZv3bQHIdhBlKnaD1oPtqC8NBDrs2W2iHKLQxcI73JaWtGXXTs89kQfEbmmOrUNCZuuAsvFnuA3NbFxKcW/NlV788doGlE3C7T1tbwbMW8qzoVEX8ZqOhvJS2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OoJxr3nA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXh90YZ0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771499483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5XAF0Aaeg8lBO1DxOELBnxRYVsQIoZJWshuHqIQFsA=;
	b=OoJxr3nAk8mt79VOnD/zFDxB/Uxw2wm7yOY+AonZeeEeueK6q5O2Vd3R/J04ScrJaewSIZ
	tK6vagIHhgzkkZEPiYzfmcK2rbbbnxK1KAlrpt03TPN9rk1GfTthP7AftqFQdkNN0BwwxG
	D0h+ni027/KWB/lYxaXNKTBCNl84TE8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-erJegUROMj-sA_jMTZiOVA-1; Thu, 19 Feb 2026 06:11:22 -0500
X-MC-Unique: erJegUROMj-sA_jMTZiOVA-1
X-Mimecast-MFC-AGG-ID: erJegUROMj-sA_jMTZiOVA_1771499481
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so4105335e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 03:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771499481; x=1772104281; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A5XAF0Aaeg8lBO1DxOELBnxRYVsQIoZJWshuHqIQFsA=;
        b=BXh90YZ0i5Z7RatEh/UhrBwyMu97e75d+bBk+UJnsl/FIe2oJlSX438qyia3FREfdk
         XKclxgxpo34jPWOLzlElj6oT5KR6n7NAAI/b6QSGV0DanzwwNXo5wac6eOFpCIsKXqOm
         rZT8fBnEHRlozTZY5BzK+wycj7h7C6val+nrfRWMBNkxGMp2hI7QrIQQEzovS/6/5Gee
         /Zb7Bs2knICU4wR7/yardK+/PXBCP09VbHUDhjux1itB+eTiNhXnb2I+tEwUeJRJnA9d
         83hmdMAl0gao3+TR2Coe1z11WEL29R2lWv7tAvjMpTuz2GGKCyOrjM0f7M0bF8EK8Z2Q
         8mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771499481; x=1772104281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5XAF0Aaeg8lBO1DxOELBnxRYVsQIoZJWshuHqIQFsA=;
        b=HwXnYBI2NY5jEJvDnfGepP8eKFUlK3dOw6Dkd8A0Vua72ewu2FNUxn9E9cHTAaxTPb
         YqiHoeqSE1bNnlkWCkFGY0MGL+H2fGRGBJaLmnbDdFSNX6RpN/rLJrIkoCmwecMsiujU
         /Slrc6+lJNBwvrnjmQoxHAWng8a01BBIcQ7SO1uWToFI7p8+tSsJN3QasT0Z7NbAQL+W
         GeIqtrvp0MZFVx0rU5RGn1OSH8Nykn4/SnKtHyqxdIvYfRZebO2+Q7Qm7scv/TsoBU1z
         2rX4CHDZOQAegrB1jGdpSgHlfrwpE6XSUKJtGnjlioYECYMNt98PFgV306QYXvTCs2Cl
         F56Q==
X-Forwarded-Encrypted: i=1; AJvYcCURc6m+bwQbmnO+lLQ9Br/Kv4z/zc/g5NE3VvrXXDJQnxv9G4L5dOLTtUmOWj931DQVdBvZWhaqm2nrZi1S@vger.kernel.org
X-Gm-Message-State: AOJu0YyzOZa+K44QSiUXaLs7hy2hKM3tmXELMZG9LOLw/2vlqyjYkJ4J
	GfU3hNlH44fyWClu6QVa3JjrG+TsO5pjPOEYG/nmDE5E5HCnpNSIkHlOXljzjijNk7taKPr+qt1
	XuS/JRtsMifshX1M5xMlik5Lv3jn7XX4MEu0ejfWPcXqAy8lc9fbYfknQjUmzWDbBsg==
X-Gm-Gg: AZuq6aJa3vEHv3pgl2zE443Vku8I4J0pXI6SHC6BY8nrLbtg1fsn7J7XjJT7Hnf1dz5
	VPEUZ5wfQJ8qNMDOSHusJOprmMPE4LTuEGfyaF08hkTNAoglS1S/Wy/mgMiRxP8DSmYrvNGGTqu
	ehuhNE8UbWPCpnXn6CErohvQB4GDd7hiyVTq9BZHPGiUsbSJ9DDnlTceGl6m973MYpsht8h7Jij
	hnW8XOZd97KVc9mYm+JaR6qxJt/GVV7VhrFfaaeu6n+xrLkJ07b5g0oEk7HwA9an0GuopukL/Iy
	HBB64H93rUktTXrqRxgq4dDmucDdj5fEfWPAGfdFo+UM4JZjPqGMBu12/YnbEhUm1Ou+AwZzAzH
	UBs7j3Ko4Ctc=
X-Received: by 2002:a05:600c:3b22:b0:477:9a61:fd06 with SMTP id 5b1f17b1804b1-4839fe97501mr21343415e9.8.1771499480420;
        Thu, 19 Feb 2026 03:11:20 -0800 (PST)
X-Received: by 2002:a05:600c:3b22:b0:477:9a61:fd06 with SMTP id 5b1f17b1804b1-4839fe97501mr21342205e9.8.1771499479443;
        Thu, 19 Feb 2026 03:11:19 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f90c27fsm32768655e9.2.2026.02.19.03.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 03:11:19 -0800 (PST)
Date: Thu, 19 Feb 2026 12:11:18 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH v3 11/35] iomap: allow filesystem to read fsverity
 metadata beyound EOF
Message-ID: <qheg77kxcl4ecqdrsnmz4acfvszjlamlb7ilgxxyf3pmt4r7ah@5fzzmcpurdfp>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-12-aalbersh@kernel.org>
 <20260218063606.GD8600@lst.de>
 <hfteu6bonpv7djecbf3d6ekh56ktgcl4c2lvtjtrjfetzaq5dw@scsrvxx5rgig>
 <20260219060420.GC3739@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219060420.GC3739@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77698-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4F9215E313
X-Rspamd-Action: no action

On 2026-02-19 07:04:20, Christoph Hellwig wrote:
> On Wed, Feb 18, 2026 at 10:41:14AM +0100, Andrey Albershteyn wrote:
> > > +		 * Handling of fsverity "holes". We hits this for two case:
> > > +		 *   1. No need to go further, the hole after fsverity
> > > +		 *	descriptor is the end of the fsverity metadata.
> > > +		 *
> > > +		 *	No ctx->vi means we are reading a folio with descriptor.
> > > +		 *	XXX: what does descriptor mean here?  Also how do we
> > > +		 *	even end up with this case?  I can't see how this can
> > > +		 *	happe based on the caller?
> > 
> > fsverity descriptor. This is basically the case as for EOF folio.
> > Descriptor is the end of the fsverity metadata region. If we have 1k
> > fs blocks (= merkle blocks) we can have [descriptor | hole ] folio.
> > As we are not limited by i_size here, iomap_block_needs_zeroing()
> > won't fire to zero this hole. So, this case is to mark this tail as
> > uptodate.
> 
> How do we end up in that without ctx->vi set?

We're reading it

> 
> > I think this could be split into two cases by checking if (poff +
> > plen) cover everything to the folio end. This means that we didn't
> > get the case with tree holes and descriptor in one folio.
> 
> That might be more clear.
> 
> > > +		    	if (!ctx->vi) {
> > > +				iomap_set_range_uptodate(folio, poff, plen);
> > > +				/*
> > > +				 * XXX: why return to the caller early here?
> > > +				 */
> > 
> > To not hit hole in the tree (which means synthesize the block). The
> > fsverity_folio_zero_hash() case.
> 
> Well, I mean return early from the function and not just move on
> to the next loop iteration (which based on everything else you
> wrote would then terminate anyway), і.e., why is this not:
> 
> 		if (!ctx->vi)
> 			fsverity_folio_zero_hash(folio, poff, plen, ctx->vi)
> 		iomap_set_range_uptodate(folio, poff, plen);
> 	} else if ...

yes this would work

I've attached the current patch, with all the changes.

+               } else if (iomap_block_needs_zeroing(iter, pos) &&
+                          !(iomap->flags & IOMAP_F_FSVERITY)) {

This check is still needed as we should not hit it when we're
reading normal merkle tree block. iomap_block_needs_zeroing is
checking if offset is beyond i_size and will fire here for merkle
blocks.

Let me know if you prefer to split the first case further, or the
current patch is good enough.

-- 
- Andrey

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 47356c763744..af7b79073879 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -533,10 +533,31 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
                if (plen == 0)
                        return 0;
 
-               /* zero post-eof blocks as the page may be mapped */
-               if (iomap_block_needs_zeroing(iter, pos) &&
-                   !(iomap->flags & IOMAP_F_FSVERITY)) {
+               /*
+                * Handling of fsverity "holes". We hits this for two case:
+                *   1. No need to go further, the hole after fsverity
+                *      descriptor is the end of the fsverity metadata.
+                *
+                *   2. This folio contains merkle tree blocks which need to be
+                *      synthesized and fsverity descriptor.
+                */
+               if ((iomap->flags & IOMAP_F_FSVERITY) &&
+                   iomap->type == IOMAP_HOLE) {
+                       /*
+                        * Synthesize the hash value for a zeroed folio if we
+                        * are reading merkle tree blocks.
+                        */
+                       if (ctx->vi)
+                               fsverity_folio_zero_hash(folio, poff, plen,
+                                                        ctx->vi);
+                       iomap_set_range_uptodate(folio, poff, plen);
+               } else if (iomap_block_needs_zeroing(iter, pos) &&
+                          !(iomap->flags & IOMAP_F_FSVERITY)) {
+                       /* zero post-eof blocks as the page may be mapped */
                        folio_zero_range(folio, poff, plen);
+                       if (fsverity_active(iter->inode) &&
+                           !fsverity_verify_blocks(ctx->vi, folio, plen, poff))
+                               return -EIO;
                        iomap_set_range_uptodate(folio, poff, plen);
                } else {
                        if (!*bytes_submitted)


