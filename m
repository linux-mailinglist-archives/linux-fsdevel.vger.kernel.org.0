Return-Path: <linux-fsdevel+bounces-43865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0647A5ECD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0F417976F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 07:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10821FBEAF;
	Thu, 13 Mar 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqJo5nOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A531FC7E3
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850450; cv=none; b=Dc4rH5zTwAUK2jjY1SDLra1ll0pclUNwbt3VBy5h/jGevTHVBAqjQtZfkk6bRv4fR/m3+qywuLjssLdfmGK/bLak1uR6t8e/AerN9dXiz1EbwY2M0UX+dyOzlrFgDFdEyq41Bv9AIkjK+ltsqmQNFxgrhPhyHuou2mecm4H8OaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850450; c=relaxed/simple;
	bh=KtmKrH0Gsv0sBFL6B7nZq6RHI/4HDfiECApPAP1vOr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5u0mf9+UjW/PraN2+rj+K9Lr6qRs3OTiZIUbVxBcbukCtq9zejBUh9IDIPROuBSSw58EWDTbZeoflSjGdOIzkWAlfCTZZscJAjjw685JGzhAV4slS8k7CGiZt1W/rLy6L46u2geoW3wgw7O9P+ZYNyQJMX+xVGMTTP0Jk36Djg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqJo5nOP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741850447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o4bfYEIbp/kS2X2cwGn1CJqsR/J4F2IpC4H45RKU2a4=;
	b=FqJo5nOPWDZvXMnUaMq8yz7DAur3XgvRRlldH1KzVjncJ0fRNlVzjqNZFuXxvAjubh5CLt
	5jKxjXawWTfdH8AWnvBzqXRPxrEq0ySpYNjo+t4cSIWfVKj7VHmk6qIelpyJAHuOg2rHkT
	6r9zYLj7QvIxHGSArTietsOR7zVC46A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-s5uo4S9HOmC7guWHeZJFDA-1; Thu, 13 Mar 2025 03:20:45 -0400
X-MC-Unique: s5uo4S9HOmC7guWHeZJFDA-1
X-Mimecast-MFC-AGG-ID: s5uo4S9HOmC7guWHeZJFDA_1741850444
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39131851046so234472f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 00:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850444; x=1742455244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4bfYEIbp/kS2X2cwGn1CJqsR/J4F2IpC4H45RKU2a4=;
        b=O+cZLljuJXAkvkFJxaNPsYSrbjTBjd9+kNxEIACuLH1pDptutJOgfjwks9xtBNZ/K8
         GJdBCOceFnAharJPd2XjxQIagjAztPVeBQR8OU4SZMcdOT0SM5Vit92tqctt8vfQaHbN
         c3P/wRXaxi5FiJlHmlvxkasBitH6TmHW8zgxsUdX87nzg1GmPWeyEnSvhl0ae6qeXrBp
         xdugA8gw+FUUwBXuOhU7nDIucfSx8FIsR9Qf4gTpF/IfksYgpGSmFlFndSA7eBBfL7Lo
         q6t0CPKvNgmA7aa4jX0VXtO/r0iNlF2Zu1sYFPDR7BuS6voadI4f03QTrOhZR4GDzkTd
         lPxw==
X-Forwarded-Encrypted: i=1; AJvYcCVdZBEHDbws+K8oWUmzL70jK7vxU5oVo4R3+LE3+SLCIWYc7tCXTrOyvHrzBOgJRWWTblahGk1ILAVLk+E5@vger.kernel.org
X-Gm-Message-State: AOJu0YxcIB1N/vQLxqCn3Q4+E/MYMi75rplfpgc6TtFCOstDynjFoLDa
	KWvZt5sYO3uMC3PDOB8wgYH+MBIIE9s3GK+jDOyuVM5bLBusxmavAQLkp3gc6bujfwepxFHgTFT
	noU/jJwZOAaJDOfrVsSAkbyQ6ow2pFkrtXaSBb4LtwEMwpdUHFm9fiRwq1Agkld8=
X-Gm-Gg: ASbGncuIm4mfT1r/XSiZ5wxShx7XP9N8gqACpZYK++NjlDWC7Q0gpacvgYQX/3+I8Cn
	nwJRf2PDxn+nolJiof1JdcCPyErGq1G9Eiyu08MLu9g9oM1z7zTB1pxwjBNrg2ujW3YnFXUP7q0
	P6htaGOBrXrIW35K+R2cA8RLo+oQjUbFr+TFD6G9EESHKKJQ06DRqrtgxwcqt6QV8ABHxb3SKs2
	al5wnXEIHB8eO2M0bv4qAXeUK90LI9pgU0xNufmB5BW6QEZT0da6Gj4Y05aWH8jfRZrWZpDqKIs
	Xb6EtSIC1w==
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id ffacd0b85a97d-39132dab192mr19228458f8f.54.1741850444464;
        Thu, 13 Mar 2025 00:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdSno6hSKVsk5d06B4EsgagrhEFS5vVdfXL2wu7cQUeZCwJ3oOQpqMw11c+iVNeKk+NLYSpA==
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id ffacd0b85a97d-39132dab192mr19228411f8f.54.1741850444109;
        Thu, 13 Mar 2025 00:20:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d18a2af42sm10316185e9.32.2025.03.13.00.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:20:43 -0700 (PDT)
Date: Thu, 13 Mar 2025 03:20:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
Message-ID: <20250313032001-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>

On Wed, Mar 12, 2025 at 11:19:06PM +0100, David Hildenbrand wrote:
> On 12.03.25 01:06, Nico Pache wrote:
> > Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
> > expose it through /proc/meminfo and other memory reporting interfaces.
> 
> In balloon_page_enqueue_one(), we perform a
> 
> __count_vm_event(BALLOON_INFLATE)
> 
> and in balloon_page_list_dequeue
> 
> __count_vm_event(BALLOON_DEFLATE);
> 
> 
> Should we maybe simply do the per-node accounting similarly there?


BTW should virtio mem be tied into this too, in some way? or is it too
different?

> -- 
> Cheers,
> 
> David / dhildenb


