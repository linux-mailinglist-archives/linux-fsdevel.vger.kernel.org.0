Return-Path: <linux-fsdevel+bounces-43762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBCAA5D6B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0F81782BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 06:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC17B1E8823;
	Wed, 12 Mar 2025 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dqx3NHs8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A991CA9C
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762631; cv=none; b=jKdHqnpy2/e+7/dLvo63DKO/bqy4V3XUkvxV52niq3+4KLbYqbTPJL0HekA4ysUapYIcqst8jeZVr/K9O8pcN5huCsUsUamwl4lKZRhpQVmZdMen9U2KHZFLr7Y/ZbFUMtq8ssEIQNTUVCzBNNXMHomrgIle/pUICBf9T44Lhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762631; c=relaxed/simple;
	bh=CGj6X8im0j6eyvz1ZiOGqKpsN+vOoTYaN9QnyzioSZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaaYdbPOEVGwpPPARcvA/TkTNyU6KmeXOGn3uChpeSMR6uLBRNVMDwuAUPypCB0EsTnQYYwMCRGp7+52fYeLjAma/LXPXT5FZLr0YjKeHa/UOUU9zgST5u+L0UtdXI+VJNku7Cbrc9Jy0Uiq0uA7I69sI/APgBxilHSAufuDfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dqx3NHs8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741762627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ngFN5P8pa+SiEt1Ew8FmKgFK9481luIZ3P3zqtJw6G4=;
	b=Dqx3NHs8K09aFEB/YsOteClM/4lhfRVRqRdYOnYVypGVoplm65WEpVy+exL22j9eV57eBb
	a5NeLuMoZuZxlAt7LKlccuRRR+vjPGVGg4tISY5gJWnQqxvShcSKPePHRI3lFxIEpWFJC4
	cjMebRo51dATySOEHS0oq9qg9/3cFpc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-wQl_Ez7OOt-SmLJTcl9iZg-1; Wed, 12 Mar 2025 02:57:06 -0400
X-MC-Unique: wQl_Ez7OOt-SmLJTcl9iZg-1
X-Mimecast-MFC-AGG-ID: wQl_Ez7OOt-SmLJTcl9iZg_1741762625
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso31975225e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 23:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762625; x=1742367425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngFN5P8pa+SiEt1Ew8FmKgFK9481luIZ3P3zqtJw6G4=;
        b=ABCduMC6k6/cyuDKRpT9AcXG0xlCdmnHmiO9CUu+EhmFQSSwacMEDqwAF6j6b1pzyk
         QUluB+5CgSke/uuaCoRQVPQyca93BzdqofgR+CvZkseAMDKQP131r3RgjFITX+EaLwyR
         jYqCq3DmbfMSACkDYjyrdqEAL5FhIOjn171HXL48AA/8FMwStlPwChYS6aOaSsanFPDe
         OmZv+BzoBKOcouZM2qRBk45TNbpOhBb2iiSrCXL8XoAqvwBuCTo4wi4btFzRhUBGO5se
         zRK/P7x944XGiaUs6v6kF8LCz9MyK9c2tP4uvcwTdiPDVPa+EIQWVDwOXUz8FApIK3Id
         BpBA==
X-Forwarded-Encrypted: i=1; AJvYcCUpJ2Qpu8bkxsigrq2VTHCfVyZHuLF3mbaFpYS5c6p+4ZR+CC2P9zfHgl6qixF/B5ce+2XqjL/K1EK0KOIE@vger.kernel.org
X-Gm-Message-State: AOJu0YyFtGiHAHJN9enclnJcMM9LfhRsuWfx/v4R/7jUjFiIO2fIgZWi
	5htNnLDVKhOK82mDCEvgLfaLyS6PrrZqH8J/F6BjfiL5rhgQVwGAVeoVaZ3U9FvVw9jeRdboy+O
	ovScpvF8bCtC48P57Yden2hJCBBEGwPWXg7wBYQY+2S16kYJtwZL0TYtISPpp8tk=
X-Gm-Gg: ASbGncunprBT6Ii4Q3YaGz5uuL0vBRF6d1g8W1mM5cuWwB4VghSYdd8/7mJhZjdO6FU
	yPoibzDW1JZ5RnfUzSygyFDNtS3z2iPD696KtaH5MCxnoWLPzhJsuZ45qTmVxHvazRCny4UA9vB
	El6O5aFnJn8rov3MvWh1Sv1NK9n6aT8KwJMAMBdf6LqfUE6ioY/BqGr4sTP4GSA4l5GcQ0WiCfc
	NLMqHGHeLkhn+ujRkQISpxI/kTAKJtBy0MkZZpXQnC8TZKpWVePSQALQQdkFW/1JX/Xwcjn2FYf
	nTEsDoe8PQ==
X-Received: by 2002:a05:600c:5618:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43cdfb7db88mr143183485e9.29.1741762625064;
        Tue, 11 Mar 2025 23:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXQUbnjKhdX7cSTwHc/sH5KUBC9yqYpY1/TKqBEmz2tDiKoCFs3roMwKysiE2/kbKi5UsENQ==
X-Received: by 2002:a05:600c:5618:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43cdfb7db88mr143183025e9.29.1741762624636;
        Tue, 11 Mar 2025 23:57:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a731031sm11806955e9.7.2025.03.11.23.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:57:03 -0700 (PDT)
Date: Wed, 12 Mar 2025 02:56:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, david@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
Message-ID: <20250312025607-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-5-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312000700.184573-5-npache@redhat.com>

On Tue, Mar 11, 2025 at 06:06:59PM -0600, Nico Pache wrote:
> Update the NR_BALLOON_PAGES counter when pages are added to or
> removed from the VMware balloon.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  drivers/misc/vmw_balloon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index c817d8c21641..2c70b08c6fb3 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
>  
>  			vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
>  						 ctl->page_size);
> +			mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +				vmballoon_page_in_frames(ctl->page_size));


same issue as virtio I think - this counts frames not pages.

>  		}
>  
>  		if (page) {
> @@ -915,6 +917,8 @@ static void vmballoon_release_page_list(struct list_head *page_list,
>  	list_for_each_entry_safe(page, tmp, page_list, lru) {
>  		list_del(&page->lru);
>  		__free_pages(page, vmballoon_page_order(page_size));
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +			-vmballoon_page_in_frames(page_size));
>  	}
>  
>  	if (n_pages)
> @@ -1129,7 +1133,6 @@ static void vmballoon_inflate(struct vmballoon *b)
>  
>  		/* Update the balloon size */
>  		atomic64_add(ctl.n_pages * page_in_frames, &b->size);
> -


unrelated change

>  		vmballoon_enqueue_page_list(b, &ctl.pages, &ctl.n_pages,
>  					    ctl.page_size);
>  
> -- 
> 2.48.1


