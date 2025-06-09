Return-Path: <linux-fsdevel+bounces-51038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CC2AD21F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 17:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E0C3B3470
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 15:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FCB20A5EC;
	Mon,  9 Jun 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cISdoLgm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0A1624CE
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481387; cv=none; b=c2l3oUjahV5lhE8PBRVyCIPyX7W37zpa0yXUOsrbEh3/YOIkVZxB0CotySsziYAbXkio+yyW7HqNu21PTyAFLYjAa9uDXitddLss7dBJPipt2W8nFazj9jcBRa5iiB/3GvrMiBMZq/KnrFLouiD3tDf5R4Q268Cc3ll7+iQpnJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481387; c=relaxed/simple;
	bh=RXAVys5zSBY8z2t6y8XO5fPsTD7X2RM71zurpDCnhqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg3E6aMz6tEq0lTySLHHcap5xgNSjV+r2WesojzF5ZrqcuYvVQtUMNLBe5dFHK1FXRsqEQys5BeFRF2k8j77VH720r1AtvhedFft8tGP08tOvJ08ZgSyn6/BLbtTPMlUlx0GI+oSuCzZmmTpfew2S1iG8uS56iyKFIdgBgRxqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cISdoLgm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749481384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNcpH+bcZai1yfLZlLefAAm7I6glTiPKEZc98aEB9ag=;
	b=cISdoLgm0LnyIYyvNABpesbp2rMXdNdGKjZC3yA2VIce1fpqOfTpZuvdgvY7e/2YDO1Is0
	+pfu7nIcSTSzI6XlFXwJfqP25DyEGhbKz+hu4d+zaznOnFjNSpPtaJhb4Tyl95XU0Gu4HU
	KrJb6dLnKWt1ixyKKqGQgDzzsrNIDR4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-I27tHou1PYSuJx5rwaiFjQ-1; Mon, 09 Jun 2025 11:03:02 -0400
X-MC-Unique: I27tHou1PYSuJx5rwaiFjQ-1
X-Mimecast-MFC-AGG-ID: I27tHou1PYSuJx5rwaiFjQ_1749481382
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fad8b4c92cso118588166d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jun 2025 08:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749481382; x=1750086182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNcpH+bcZai1yfLZlLefAAm7I6glTiPKEZc98aEB9ag=;
        b=WIwONXDVJkWA7dCLe921XA3PO1H2JgS0hXokf5HqT2XchyW6WJFw7MGGCb1pMzqZFK
         kS1Ffu3lEEXmXeu09xbh9E9OQHsi3LGACmu5LYKDvzMP9b/5p2UqbPYD/GPSxPYNYVvu
         mO5nMc3HcSsB5J15zoES7CkSQ4vL0w+To8jibz6U/RVgma+2iy82MQbBl+ObvjM0DQPn
         /v7ZBs9lDJowHfHZYFwmDtfz2u8q4sDjF6CeBTxbEtlHwGIGknd5J22QApYD+ysir1Q4
         GVu5H6Pq6hCAuQU8X/28JGFQmHaMYpJHN0MUNtjnQzqoXhj0MN12wr4nClc6OZXmfO6l
         zvRA==
X-Forwarded-Encrypted: i=1; AJvYcCX8RWQDDruJb8nqT/a+5vuL2bSzpHVTybz42ma5PRlENv9wPZ9e4Vk9Ytzl38zOnrZhNqyC+PctqMXWQdB4@vger.kernel.org
X-Gm-Message-State: AOJu0YyroY7SgDChnhyuQ/yfzyjzfXhRS74rZ9WVOeXkHaGHNIWv9xNm
	K8jGKQwYD+IyS8gE1t4000evuTHLC1O28yKitYJZ/yRKSLLtHFC/x5SRtBCR6YVemdfIimXckkF
	oFpzRgVvZvoTN9tkeU7lSwLFCxZBF4ZbXOTmHzEs10nh5IBcPg6YUoJiyVtAN5XbRSYg=
X-Gm-Gg: ASbGncvR2aypmuaVOxocAtBZFvGuAET+95BTUVh+1LS2ruwV+eNbn+XlC6had5yQMKs
	jMj6fNo339dq8VuAtdsS2/ltxBj9/o1A7WClivPS5EIg0WaF8D5FxvtOs0reEUL8UjssGNs8fTq
	3cceQTABFxH0tn7rOMLPs0DqcDG2dAdV61AkcZLiMT0cjs464IpBrsmv7lfwlFX9bZxR3Reop4/
	hPRmiGTq6El7K+TW2n8GaKCpVHLrYrh2Mgzj3TUtVi9knfNbqEMLmv9J8seSxaicvhjfUzLMffQ
	iJg=
X-Received: by 2002:a05:6214:c68:b0:6fa:ca81:4121 with SMTP id 6a1803df08f44-6fb0905b95fmr182520686d6.44.1749481382005;
        Mon, 09 Jun 2025 08:03:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG31IbS/tH29+tac1BfQOs8d7QAQpKa2+wtvwN79ZFd1EW+t9uEZUIMv1somHhXHI9x3fa1xA==
X-Received: by 2002:a05:6214:c68:b0:6fa:ca81:4121 with SMTP id 6a1803df08f44-6fb0905b95fmr182520316d6.44.1749481381607;
        Mon, 09 Jun 2025 08:03:01 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b29fbdsm52483506d6.89.2025.06.09.08.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 08:03:01 -0700 (PDT)
Date: Mon, 9 Jun 2025 11:02:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tal Zussman <tz2294@columbia.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] userfaultfd: correctly prevent registering
 VM_DROPPABLE regions
Message-ID: <aEb3od8YQTvDQu4q@x1.local>
References: <20250607-uffd-fixes-v2-0-339dafe9a2fe@columbia.edu>
 <20250607-uffd-fixes-v2-1-339dafe9a2fe@columbia.edu>
 <20250607150438.4439e19f74693445212d93df@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250607150438.4439e19f74693445212d93df@linux-foundation.org>

On Sat, Jun 07, 2025 at 03:04:38PM -0700, Andrew Morton wrote:
> On Sat, 07 Jun 2025 02:40:00 -0400 Tal Zussman <tz2294@columbia.edu> wrote:
> 
> > vma_can_userfault() masks off non-userfaultfd VM flags from vm_flags.
> > The vm_flags & VM_DROPPABLE test will then always be false, incorrectly
> > allowing VM_DROPPABLE regions to be registered with userfaultfd.
> > 
> > Additionally, vm_flags is not guaranteed to correspond to the actual
> > VMA's flags. Fix this test by checking the VMA's flags directly.
> 
> Wondering if we should backport this.  afaict we don't know the
> userspace impact of this because nobody has tried it!

Yes that's fair question.  Per my limited understanding of MAP_DROPPABLE
(even if as a generic flag), I'd be surprised if someone tries to enable
userfaultfd on it, being succeeded or not.. or requiring that to properly
fail on any stable branches.  AFAIU that's the only possible effect we can
expect from a backport.

IMHO for this case we can avoid backporting until anyone requested with an
explicit use case.

Thanks,

-- 
Peter Xu


