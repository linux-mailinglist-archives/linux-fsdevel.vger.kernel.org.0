Return-Path: <linux-fsdevel+bounces-59086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01995B34486
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1851654C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF672FC01E;
	Mon, 25 Aug 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+5rGEX6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E22FB96A
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133219; cv=none; b=F6EQ1gs5fDNzeij5JoJaNj2uwpb++EO6OdqIqdtfiYqB9eJNp/SN58AIyRmIUGr8bBT79OI0AUpZ7VgQmD2/e27Tn6fLNhmNmkqLt2jA2QBUjChTfuUvWY6JyZ9NoEVTcWetsGOMr7zuoDkxRmeU7puvExbT1StOIc5+mo339qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133219; c=relaxed/simple;
	bh=jyM9sjgBOfjONVoB7+Ua/Oi2BsARIgUQ/8NXPMg2Sik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Se3k+K6gwJY1s+bMX92Q2uzQiL8suoCrBSMLM30iCSdjsyykt5dJKZWqBTURpGTrVUZ7SVrAyjkg0ZkKADhJASR2FSYJRWmytF8sGtUhCbJ0sGx+frfxX5HEweq2S9ireSyXAZqTQev/Kr4P2TPMFOZCVXrgeYG3EjBWuowmg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+5rGEX6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756133217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KY2wm3NrmZibOSyrPDfEQp80W2axFO0h9jlPQgJYcCQ=;
	b=U+5rGEX6enbcbFmFKjh4xSyx/wCQVLl/5ZToB9BB1YRROPrEhj69Zab9H8U2TuxDMXTDif
	CmPsKnDnw17t9okaHU2roU5wDn5y++uV+1YdqmRGy97bIvaSLuxMVDY8j+nQ8hqDw6oqNO
	LYffUCM78OxuUggzNmLghUnqpK4WmP8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-uwB4iORxPAGQxcwzyE3_Lg-1; Mon, 25 Aug 2025 10:46:49 -0400
X-MC-Unique: uwB4iORxPAGQxcwzyE3_Lg-1
X-Mimecast-MFC-AGG-ID: uwB4iORxPAGQxcwzyE3_Lg_1756133209
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3c68ac7e19dso863222f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 07:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133208; x=1756738008;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KY2wm3NrmZibOSyrPDfEQp80W2axFO0h9jlPQgJYcCQ=;
        b=frQJE04xI0ps9wsHswiM+3pI2PzeVBiAJBGZJRZX5XDXEtQN6TNQ9XQ+o79Q8jgCnw
         4vlbCFgaUJNeFS6vuIpPd5eCdEjXs0OO/7Flm9ocsBL3SjHkZWRGjE7lJNonwqwLzW7N
         ebGLdZTBXFN5uDTGyfEpyEQSlzwEb7m81sr4tuO8hfPMV+c5CWFfS2guKiMbYqbH9r5V
         MYGCttOjEe607+CfLcFkzZipzoDnxZMVVTtg3qbZhEPUDvRtlOM/TfJIgMJHPxVgzv8Y
         pGURXtteL8ApiyzessyfAEf0kOQ8gkTLxXU28C9PLfHM5cv/5tgBzyB60zvwazwarPVX
         DkBg==
X-Forwarded-Encrypted: i=1; AJvYcCXke1teua4upO8BETKI9JcGP/wAugF2Q1pa07Q9OfXVQ/eLePUV7phcA83L4m/lhzd4qgwNkIEH1hdbms+9@vger.kernel.org
X-Gm-Message-State: AOJu0YzB8ReqosyDEhzYQ/u7J41DfyBxokIHu3GBt/enjOktrpUrDbru
	kV2pJsUnPDO+iJsVnNQQXhtKW6k+4+nS4eVILOJqKUSEj/PRiQ4OoC8+866Vc91HsQCICFkaV5/
	oJvpu/fMYEAGGnbmsDf9GKaxEIj6kznf7QGj4b6i3ybS8wyOMlvcVk4X1TsDcnie9wb8=
X-Gm-Gg: ASbGnctr2z3KS1a9/WS6JRJ1o80EjFMMBbLgdMEb4OD9t557AjZYKGsFheGF16xZlnf
	tGKnAbVQK+9irC2/kZbLnMmgbUHi7YmGGBacNUCcU1sLCXC3fBpH9tiNUB9cEJddNuN8TG9O2/j
	8oaob1cK1hG15fe/OEqGszAbYbwHCwxCLP+FXrSRbZQ1oqG2WOmxFIM5JCwkWKPjjxakBnMu5uJ
	6rwJeN1exI9a8yL+UYXCGU35hvbW3iSv8UDFgmAZgA/RyVjbWW0IhhZUX1USHW97KfClOhE5wfy
	UadM2t4tcfAQM+o7bgGnKbbll+lCEjlVVxsY4V7RLtP6ha4RMJjoNdkzK7heGocSV3HGmwI7HwP
	UR8Zlam4Oowj3EqU3obErW73m7heQ28gnVDEQVfJDhnlVXu3kESjWkxVlhrCqRGcinHE=
X-Received: by 2002:a5d:4283:0:b0:3c6:71c4:15b1 with SMTP id ffacd0b85a97d-3c671c41891mr6599867f8f.37.1756133208525;
        Mon, 25 Aug 2025 07:46:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtUFUJHVoJc+4Q00c4CeDXG5Gf93RhjBiSX4FnqG9Oi+HjScx8FQNE8maF1Zwc4YLjexR1iw==
X-Received: by 2002:a5d:4283:0:b0:3c6:71c4:15b1 with SMTP id ffacd0b85a97d-3c671c41891mr6599840f8f.37.1756133208084;
        Mon, 25 Aug 2025 07:46:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76? (p200300d82f4f130042f198e5ddf83a76.dip0.t-ipconnect.de. [2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57487910sm111202325e9.15.2025.08.25.07.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 07:46:47 -0700 (PDT)
Message-ID: <9cb4adf8-94c7-4fa0-8bed-2f9274969b48@redhat.com>
Date: Mon, 25 Aug 2025 16:46:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] writeback: add sysfs to config the number of writeback
 contexts
To: wangyufei <wangyufei@vivo.com>, Andrew Morton
 <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT - MISC" <linux-mm@kvack.org>,
 "open list:PAGE CACHE" <linux-fsdevel@vger.kernel.org>
Cc: kundan.kumar@samsung.com, anuj20.g@samsung.com, hch@lst.de,
 bernd@bsbernd.com, djwong@kernel.org, jack@suse.cz,
 opensource.kernel@vivo.com
References: <20250825122931.13037-1-wangyufei@vivo.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250825122931.13037-1-wangyufei@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.08.25 14:29, wangyufei wrote:
> Hi everyone,
> 
> We've been interested in this patch about parallelizing writeback [1]
> and have been following its discussion and development. Our testing in
> several application scenarios on mobile devices has shown significant
> performance improvements.
> 
> Currently, we're focusing on how the number of writeback contexts impacts
> the performance on different filesystems and storage workloads. We noticed
> the previous discussion about making the number of writeback contexts an
> opt-in configuration to adapt to different filesystems [2]. Currently, it
> can only be set via a sysfs interface at system initialization. We'd like
> to discuss the possibility of supporting dynamic runtime configuration of
> the number of writeback contexts.
> 
> We have developed a mechanism that allows the number of writeback contexts
> to be configured at runtime via a sysfs interface. To configure, use:
> echo <nr_wb_ctx> > /sys/class/bdi/<dev>/nwritebacks.

What's the target use case for updating it dynamically?

If it's mostly for debugging/testing (find out what works, what 
doesn't), it might better go into debugfs or just carried out of tree.

If it's about setting sane default based on specific filesystems, maybe 
it could be optimized from within the kernel, without the need to expose 
this to an admin?

-- 
Cheers

David / dhildenb


