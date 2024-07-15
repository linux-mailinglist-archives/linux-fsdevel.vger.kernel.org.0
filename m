Return-Path: <linux-fsdevel+bounces-23663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AF89310A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 10:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D891C21BA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E443185086;
	Mon, 15 Jul 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lqCheDuH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0931836CE
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033551; cv=none; b=PG9NxxYLWZXPQUUvlZndExxZHQLj3tMNyijXqxcmNr26J2yJSCSx8HD/O4twj9vskFn1qB+Xvjqia7KHPhmYiMIYsSayEakW83Eyg0SZcxtJ31qtVvE8a7ojL4qFS2R+ZQIi91/YBa1WMeyYOplusx2nC+66oqtAYUGiXpb2B6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033551; c=relaxed/simple;
	bh=MIFpZl5p/ktVxSENpSPhRpEignOYsjsDZTzD8m5IENU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e83R2laZcoocHVml9pZbx/0Xh0lrvppD01gjwrWnClqgrNmSiKy+dA7V+NfOf+WhWUNDMGoNzzZqIem+TDw/UGF+NTIcbLnM6ZXApu3jNlZgCeeqkHnjEaUeU5hymh2ehn4GTPFqOW8WMmKimL3rxRLTRcUVb7KqCJfDCQPAAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=lqCheDuH; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ee98a224b8so5069271fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721033548; x=1721638348; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFtI2KoVZL8zpxDmxsiji21hGTTPGlau5bq5V67S++I=;
        b=lqCheDuHpdxnC5dncSmTKUJt+W6J1BgtQ6+6pA9haUmlXGbXsjuvDjcqQf2nTivSAQ
         nGdiZYKHgT0uIUfrznQOhWrRDkpc8/NsxXqvyf6XMb6b67u4iWRkMc6l44WzxsT2I7BL
         T1byK3oIuVTmIhJjkE6Yw5kw8QDYZTOaaS0tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721033548; x=1721638348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFtI2KoVZL8zpxDmxsiji21hGTTPGlau5bq5V67S++I=;
        b=HlgO4HNDSThqlZmK2C1KweZpZvTVbWogNiBrjGGVGEqYAP9KilafsKxlHb9nj0Nitg
         9sdXhdJRUCLuInip3qVtLkGQASfWoQA0eIVm3/Kq0efKjk15APUHvhWdZw1r/aVxUtch
         rSbsr/72IPrhQc8zKoHtDHECE4aD9RJDT6oHvCrIEA+VIm7ctDfNOlrDd9ggAzjlu4Ih
         NQ4o5w7XQsK7jRQPeugt7bYOrOirsRbXufd3VvkJCN5Mbh4n0Sik46klZsAxx0vcmYgR
         1dDd2Qk1Tu+gJzuYzrUqc0vq8YQhH2xJmK/ft0/zl7iUNO9c2jP050hV8zRPVI4D4hAq
         Kk/w==
X-Forwarded-Encrypted: i=1; AJvYcCX+Mz0138W1dWqJ3/8CuR8t+ZiHArrE37UgRbvmiKnoF/g0/OVb6mnjRHruqxufkUrWjfeQMnKDSazRlb4QaGeooQRfdnfkGCzDOAI22g==
X-Gm-Message-State: AOJu0Yzmgs0zTonu8pSNa8goEDfezWIyIXZ3VMgjIahQG/pdfVoAQYNl
	eNcQd8KrCC6UtPKKK8adOuiWjdQe3bJcOKm2VCpz3kmnr7lOK+qgODev1qWXgPY=
X-Google-Smtp-Source: AGHT+IHmjsFZ+qyY6qOuWBh0tmFYh3x5Sbnw2EXZYOBODf4NfNY2g4S0U+DdM2RcQHVCl5EcvZtu3w==
X-Received: by 2002:a05:651c:198b:b0:2ee:91b7:860 with SMTP id 38308e7fff4ca-2eec98be531mr64924681fa.4.1721033546536;
        Mon, 15 Jul 2024 01:52:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc306sm113442395e9.30.2024.07.15.01.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 01:52:26 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:52:23 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Lei Liu <liulei.rjpt@vivo.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrei Vagin <avagin@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Daniel Vetter <daniel@ffwll.ch>,
	"Vetter, Daniel" <daniel.vetter@intel.com>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH 0/2] Support direct I/O read and write for memory
 allocated by dmabuf
Message-ID: <ZpTjR-7dabdyREXS@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Lei Liu <liulei.rjpt@vivo.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrei Vagin <avagin@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	"Vetter, Daniel" <daniel.vetter@intel.com>,
	opensource.kernel@vivo.com
References: <20240710135757.25786-1-liulei.rjpt@vivo.com>
 <5e5ee5d3-8a57-478a-9ce7-b40cab60b67d@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e5ee5d3-8a57-478a-9ce7-b40cab60b67d@amd.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Wed, Jul 10, 2024 at 04:14:18PM +0200, Christian König wrote:
> Am 10.07.24 um 15:57 schrieb Lei Liu:
> > Use vm_insert_page to establish a mapping for the memory allocated
> > by dmabuf, thus supporting direct I/O read and write; and fix the
> > issue of incorrect memory statistics after mapping dmabuf memory.
> 
> Well big NAK to that! Direct I/O is intentionally disabled on DMA-bufs.
> 
> We already discussed enforcing that in the DMA-buf framework and this patch
> probably means that we should really do that.

Last time I looked dma_mmap doesn't guarantee that the vma end sup with
VM_SPECIAL, and that's pretty much the only reason why we can't enforce
this. But we might be able to enforce this at least on some architectures,
I didn't check for that ... if at least x86-64 and arm64 could have the
check, that would be great. So might be worth it to re-audit this all.

I think all other dma-buf exporters/allocators do only create VM_SPECIAL
vmas.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

