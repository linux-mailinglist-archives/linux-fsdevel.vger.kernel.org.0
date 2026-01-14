Return-Path: <linux-fsdevel+bounces-73639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CBED1D16D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 09:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E879304FD9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF80737F740;
	Wed, 14 Jan 2026 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFMuzEED";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tSsrfM6u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7C37F0F7
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378848; cv=none; b=MBBtN48qVP22LnqiLxJh4fHOJkDdK55Wc1jKZhEOwmQ/y/abrL/5M0g/ZdldPTAXVvxKP+NviVRxsQkvleNzJ7tZ7HJvIl4UvRb2IqNIufAFM1Cw37f4txxzPxXrYiVRpFlOOASKxtLzfJVPZKyVuXrpDkL/SITNNX9F2GIYPug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378848; c=relaxed/simple;
	bh=RTcjpEqOm45gmsFr+TBc5Irtq01dJ5bQ4/uCScFzUhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSR86gXZv3DErDugBJNP6P0w5Xk8cqb6mjPV3ULKvFU1FfJMK34S5wm9o9oKmjyeO0wOs7cGOJJzub+nKM7oqn7IO/BTzveh34OhCpkt+gWndYI3y63v4TqfPG4vn+Fmgk+AM5MS2s+3hKyeiV8vl0nBmAXUhMLlcXVRYEbaklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFMuzEED; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tSsrfM6u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768378839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VYnnUZghf6HwJqXJDWVaeOjjdjMBw+O6FSttE0RsUb8=;
	b=HFMuzEEDs8AaIF8lrTS9aYfsxZ+Z8ZFvPJ5Wv1/BJkK392gIsykS9We5hScBqZ3QPoqlcA
	4dLJllRf9KM8mTHKbouBMTEWBhK7naIvlaMEJrItlJhmy0ub9VDkNNoc4yG4q5sDjmTRm0
	IECu3JZSzvaebi5kMs875iBl9qQwrEw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-2f2uVY89NcScGBrDfXWuzg-1; Wed, 14 Jan 2026 03:20:38 -0500
X-MC-Unique: 2f2uVY89NcScGBrDfXWuzg-1
X-Mimecast-MFC-AGG-ID: 2f2uVY89NcScGBrDfXWuzg_1768378837
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d28e7960fso83981555e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 00:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768378836; x=1768983636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYnnUZghf6HwJqXJDWVaeOjjdjMBw+O6FSttE0RsUb8=;
        b=tSsrfM6uYu7AIxRByUcEBVOeLfPOcP9BGmVZ50zkVCNLGzmuCqQ6bbiNrVKaS/2DXD
         EO3SHNACogAtJ+CnJFe+Xy/ghgDve5f3S1DSjd5D6zuQMC3dfDlRIuosXhtWMSm1ANEi
         hpDj24+49I3SIegIs8RaCi2tj4MjBxs/ce+paWtUqYarsTFDPCtcxsTEh4Fl/aqj/d//
         +CE+Clfe1n9q2b+61R4zx3EmZX8f3k3LVa8O8HAwWBt/20Xv8Sr0nXHS8w/5HsPQ9TAZ
         wqgvOh+oEOyyIExQdjmLCUWVKKWJtDu/1e974tV4dWt0LE0wyeOBDp1jtI9dLrZ3Bj+w
         FwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768378836; x=1768983636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYnnUZghf6HwJqXJDWVaeOjjdjMBw+O6FSttE0RsUb8=;
        b=PqY8eqFEOWUK1E7GJOZFh8QZH4w763HWd78cki5oFlvQ0XIlToxv6FNiNgS4UAIStb
         LapD4SyGGLeP7KJB57YsaCAxiAeYLM2TJPB2mr40SOeF6Ye5zAJFng1OLfre+T+EP/sd
         Jqn2qWTIiUvFCpTIEFF0fQ3ywPv2HMn/ApFhoEItdf8Fsw67H7ZzR5Je5A9ZW7MbaBc7
         HoHRIbq3WqVDNATcpzgRkgPY0X8qfKHkqB2NO/BnrVVKMu584XJJ6LjSJ2RlPBRMVDtL
         q/UgI+5Il0EBdDp1cI7I3pmw7Wtsohis/u6OM8o+PAhN0bwKaAGSLYSTvv73VThDZGYr
         uJQw==
X-Forwarded-Encrypted: i=1; AJvYcCVc+1X9n2iDNXdbF0Zy+6h5S0d+GFeYfTZcXOccOJUeqEZIyqx2zSB5N6dMuZMYsN0CnKc5AyB9r4ZsvmNR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsrl3RxFyhMrxV8EQs/qj1HcpD44WYpkYGQNiaM3TRPqYztNlx
	V2hlZqr2W3/REP0iW+RYl9YdNrr8l9gWQny32U9VNNIU32KjST/qzTol8eFlx2ODhXE/V6XwVjD
	AkrG7DXR+wY6j+2MmYnpUKS2ZQd8NocPRoNFXMOf7tq0V6Ho4sZnqE7oXbwEpHLYWyAHy6c4A8w
	==
X-Gm-Gg: AY/fxX7ItAmGIT2qIrH+v6O4aj3FzhFcHQTeynYQphzzOem/YixetCKVNbpsYm47zMm
	CV6RqnNvCY7EGCEZaN+g5FNwi/7aPK2WZ0eNg/W/PlaPnLLebl5wyXn9sB7lEhHYKU2WY2p4l9g
	D/XsQ7JW4T+FR9rf3800ujC+JZ2s4hB86QleNpcRUBRVkrXIiN/UhT2rsO3rIdDcBLoGdt/1WFK
	Dx6wEK9SisByCNRzBAqu9lcaLOsNU07Y1cIHdYen2/MH4BhQbRkjo5TLbzniMiXuFtcmBqWXp5f
	YrfDR5COpbYUi35x2yS37IWyn6EeKAv4H5RS0ALQd7Wfst7bx1w1Wrhq1LrasfW+ILWPjbYLiXg
	=
X-Received: by 2002:a05:600c:3555:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-47ee3363c12mr21824065e9.19.1768378836238;
        Wed, 14 Jan 2026 00:20:36 -0800 (PST)
X-Received: by 2002:a05:600c:3555:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-47ee3363c12mr21823815e9.19.1768378835799;
        Wed, 14 Jan 2026 00:20:35 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edb7esm48605635f8f.30.2026.01.14.00.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:20:35 -0800 (PST)
Date: Wed, 14 Jan 2026 09:20:34 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, fsverity@lists.linux.dev, 
	linux-xfs@vger.kernel.org, ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 0/23] fs-verity support for XFS with post EOF merkle
 tree
Message-ID: <5z5r6jizgxqz5axvzwbdmtkadehgdf7semqy2oxsfytmzzu6ik@zfvhexcp3fz2>
References: <cover.1768229271.patch-series@thinky>
 <aWZ0nJNVTnyuFTmM@casper.infradead.org>
 <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl>
 <aWci_1Uu5XndYNkG@casper.infradead.org>
 <20260114061536.GG15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114061536.GG15551@frogsfrogsfrogs>

On 2026-01-13 22:15:36, Darrick J. Wong wrote:
> On Wed, Jan 14, 2026 at 05:00:47AM +0000, Matthew Wilcox wrote:
> > On Tue, Jan 13, 2026 at 07:45:47PM +0100, Andrey Albershteyn wrote:
> > > On 2026-01-13 16:36:44, Matthew Wilcox wrote:
> > > > On Mon, Jan 12, 2026 at 03:49:44PM +0100, Andrey Albershteyn wrote:
> > > > > The tree is read by iomap into page cache at offset 1 << 53. This is far
> > > > > enough to handle any supported file size.
> > > > 
> > > > What happens on 32-bit systems?  (I presume you mean "offset" as
> > > > "index", so this is 1 << 65 bytes on machines with a 4KiB page size)
> > > > 
> > > it's in bytes, yeah I missed 32-bit systems, I think I will try to
> > > convert this offset to something lower on 32-bit in iomap, as
> > > Darrick suggested.
> > 
> > Hm, we use all 32 bits of folio->index on 32-bit plaftorms.  That's
> > MAX_LFS_FILESIZE.  Are you proposing reducing that?
> > 
> > There are some other (performance) penalties to using 1<<53 as the lowest
> > index for metadata on 64-bit.  The radix tree is going to go quite high;
> > we use 6 bits at each level, so if you have a folio at 0 and a folio at
> > 1<<53, you'll have a tree of height 9 and use 17 nodes.
> > 
> > That's going to be a lot of extra cache misses when walking the XArray
> > to find any given folio.  Allowing the filesystem to decide where the
> > metadata starts for any given file really is an important optimisation.
> > Even if it starts at index 1<<29, you'll almost halve the number of
> > nodes needed.

Thanks for this overview!

> 
> 1<<53 is only the location of the fsverity metadata in the ondisk
> mapping.  For the incore mapping, in theory we could load the fsverity
> anywhere in the post-EOF part of the pagecache to save some bits.
> 
> roundup(i_size_read(), 1<<folio_max_order)) would work, right?

Then, there's probably no benefits to have ondisk mapping differ,
no?

> 
> > Adding this ability to support RW merkel trees is certainly coming at
> > a cost.  Is it worth it?  I haven't seen a user need for that articulated,
> > but I haven't been paying close attention.
> 
> I think the pagecache writes of fsverity metadata are only performed
> once, while enabling fsverity for a file.

yes

-- 
- Andrey


