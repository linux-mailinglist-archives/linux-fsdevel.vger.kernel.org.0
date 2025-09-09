Return-Path: <linux-fsdevel+bounces-60664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E378EB4FAD9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9C174E068E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23615326D4F;
	Tue,  9 Sep 2025 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h59UmyRB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D118DB16
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421021; cv=none; b=AbFQO3LU8dUd2/zlW9HDbeq156a8mSZsiCwYiTcucueuI1Lo9XsucuV59zPHaStx7eYOuUzuKeeHtgscqkWVSuZ6upn6ubk+8rtF+BLKK51DN4s/CxoqCg5vXkS+Es+5exjb9ch2fNfWtzphnd//of494ubG0/1CWkKqY61RV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421021; c=relaxed/simple;
	bh=s92S74rkTQygVdBylBjRnsGIqHJ3GyRJ+UufBEDW444=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/jtdAE6tzo+fMWkkCBuWIREWHfcxApwbKESGjqnxXA3XXGxk8Ox/cK+OheaKeesxFeKw8A1RpBfD6SGZret8w8rjzR7lTFtFRFY28AfiKYqNCv1A6WP/9GE2JezEJo7UM+FKL3QghqsZE72OoTcLRb2R0ztUOxp9UiT2LaxORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h59UmyRB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757421018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=00MIITktQKpeu4Npo919IC2v222FV9c+T1/KFxmzFFk=;
	b=h59UmyRB75xi7w3nVLnf7EIAh4x0kQpEQhVrHGMXh+Q++u7fHM6y/cefhQ9qUUOlajinzD
	EsBwxnSKA/EaJIm1+MKWgtg65rk/xySfRLN+AHqzGBTEBs1SYo/qfvLbcw8bFt7/UJSYuC
	iHax0b9VOwczJdbAXO+D7odYd3J0Ijw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-bkT4n2FBOsCCgD6LTw34aA-1; Tue, 09 Sep 2025 08:30:17 -0400
X-MC-Unique: bkT4n2FBOsCCgD6LTw34aA-1
X-Mimecast-MFC-AGG-ID: bkT4n2FBOsCCgD6LTw34aA_1757421016
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45cb5dbda9cso34377455e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 05:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421016; x=1758025816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00MIITktQKpeu4Npo919IC2v222FV9c+T1/KFxmzFFk=;
        b=PpOXYU4Gs+0G1jgheNXh6+ahS+yXwC3w3xL6ER2gEWXSmPfK6fOrct+h+m+4lDL37I
         2h0pph4yp3nbj77yrOppcixoBF52s6kuA3xxfrKTa9HUyaSkIwcFR4JFdZPYoB/cix4X
         RIS0J2GICj8nd8QlDG1i3Ts9bHKUGwT5KzJbXUD8AxP65DPJvSLHyYwfnboZCCPO3SKK
         DLxuYmHQskR6sLxa3bOQ2iB3Dr3iiSFtCeOlv1VP11AsdO66kgOkAIVqrf6t0Ygg4EFf
         fSLp1da7a6iN8bvZxKzNJOsm6fYuoodnE0p9BNjfF+WQzHX2JikI8gI+aFmNwHdHTwRL
         XJtg==
X-Forwarded-Encrypted: i=1; AJvYcCVXr0PWsOexCtENfXXdJmRlVYT7+sjm/J2jT/umaHBP1hzTY+qATxnyke2YbHYN5yp4jAY27921UPR1LmnS@vger.kernel.org
X-Gm-Message-State: AOJu0YxOtX84yisr7hWCpsu9H/NarhXlH0vz0gaGXDFURugCVTTRZ2zu
	LS/Yu3TNhr/7cAb69/XjYFs+ksYDNf/+m4KbVAc8SWDOKK7gvrdT7RDcP7yC2XAalD8TWJNHpxF
	EUwCRXdR4NKOKjgwaEqAoVPsSV0g0nH5bmFS5ItcW50eJjhZxAZA6ZcrN3uGktiGj2Q==
X-Gm-Gg: ASbGncvv+cXkx/l2GQufnx88h5yGJ2TjShLDhcgtwLRl2FrTGPphHzsfgD4Yi2l7vgH
	YletAdHWJZTzFj6u1/91ibQV4XG8ZSFzwUWc8pYQ2KGUpOvhYiR1dZS3St7LuGV4hE1KGRHUQ77
	yw8EV+ChLuEsXAbEhZGZKlvnTir1aHA3cnA3Mkl3RwA+c0xaQSJ7Fm0xrpC5Nv3paRHkv0nLLMj
	+paLT9JF/fyI8oZPSeslC41jRMuRk0GFC5EU0TN3EdmhgxzG7ZOFa0AeSq/fePWbgVC2emfkaMv
	6QouT2qoAJ6KtUZtleFqB5KgFoc+aNn7
X-Received: by 2002:a05:600c:1c1b:b0:45b:7185:9e5 with SMTP id 5b1f17b1804b1-45df6334418mr607495e9.5.1757421016403;
        Tue, 09 Sep 2025 05:30:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF90lk9hKimn7/9fXuczdVmK4Oq8YW/IoH85cs4kzzTgo9MhmHaqu+WdCnHoNhq9HRvmfB8fQ==
X-Received: by 2002:a05:600c:1c1b:b0:45b:7185:9e5 with SMTP id 5b1f17b1804b1-45df6334418mr607245e9.5.1757421015994;
        Tue, 09 Sep 2025 05:30:15 -0700 (PDT)
Received: from thinky ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bfd8csm2646333f8f.11.2025.09.09.05.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:30:15 -0700 (PDT)
Date: Tue, 9 Sep 2025 14:30:14 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, david@fromorbit.com, 
	ebiggers@kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 02/29] iomap: introduce iomap_read/write_region
 interface
Message-ID: <pz7g2o6lo6ef5onkgrn7zsdyo2o3ir5lpvo6d6p2ao5egq33tw@dg7vjdsyu5mh>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-2-9e5443af0e34@kernel.org>
 <20250729222252.GJ2672049@frogsfrogsfrogs>
 <20250811114337.GA8850@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811114337.GA8850@lst.de>

On 2025-08-11 13:43:37, Christoph Hellwig wrote:
> On Tue, Jul 29, 2025 at 03:22:52PM -0700, Darrick J. Wong wrote:
> > ...and these sound a lot like filemap_read and iomap_write_iter.
> > Why not use those?  You'd get readahead for free.  Though I guess
> > filemap_read cuts off at i_size so maybe that's why this is necessary?
> > 
> > (and by extension, is this why the existing fsverity implementations
> > seem to do their own readahead and reading?)
> > 
> > ((and now I guess I see why this isn't done through the regular kiocb
> > interface, because then we'd be exposing post-EOF data hiding to
> > everyone in the system))
> 
> Same thoughts here.  It seems like we should just have a beyond-EOF or
> fsverity flag for ->read_iter / ->write_iter and consolidate all this
> code.  That'll also go along nicely with the flag in the writepage_ctx
> suggested by Joanne.
> 

In addition to being bound by the isize the fiemap_read() copies
data to the iov_iter, which is not really needed for fsverity. Also,
even on fsverity systems this function will not be called on the
fsverity metadata, not sure how much overhead these checks would add
but this is probably not desired anyway.

Is adding something like fiemap_fetch or fiemap_read_unbound to just
call filemap_get_pages() would be better? A filemap_read() without
isize check and copying basically

The write path seems to be fine, adding kiocb->ki_flags and
iomap_iter->flags flag to work beyond EOF to skip inode size updates
in iomap_write_iter() seems to be enough.

-- 
- Andrey


