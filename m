Return-Path: <linux-fsdevel+bounces-43489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002E4A5750F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 23:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEFA3AC017
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 22:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D00258CFE;
	Fri,  7 Mar 2025 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cw+7BQBe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B26258CDA
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387327; cv=none; b=APm93YTkZ0vIOi8iWwsaRGVH1xJ5X+jTex0fnPPfUQWn14+sICIh1DEHlq5bLksC15PZ2TA2YI1mHPm/reKtyNAsnnNNDKwUOQ2sSmhcuebYcqDCv4WPQRANGmFdgQCgKY1IhlWbEQTaYoegx/69Z6QSvRUJ1GuNT2ReT6YeRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387327; c=relaxed/simple;
	bh=QbJVwK7yIplBFiKYa4/igotSC0EWBBnFNF1lNEacZeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhXoKo2VWa/qreJ4iJdhv1YTudvNmWA98ezcadRIC51leUKOIhYexXbGda5dF0rK7ScpNhyzwlhcC04BHIyaeV8easiC3+Wt4jVAF7vngL6RqXfPepSY2p+coECj0Rh+v3UYdrU+sRJHob+w/8kVgUOM8WjsTS1tuN4Agz+HfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cw+7BQBe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741387324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDGwdwGPb9qTBerw8cjE5pk2Lbp1bTzvxl+acBBp6AM=;
	b=Cw+7BQBeIRV6hSU9SJNp3frQqIp9mToKd4KCasYHetCaBzKvLDigFzTTHXKCB1NSBWmQXR
	qZuNJON8Ly4vHfEJfWFWkWOj2wyJXRsz1TDDUtp3tUrO7zUDyeZaxCJbiNl1WVavEMIrEe
	K0jVHnd+3JA1DD0oBbdFr0aZA0SLDQk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-nS5xtTsJNWyOTB_ukoCBSg-1; Fri, 07 Mar 2025 17:42:03 -0500
X-MC-Unique: nS5xtTsJNWyOTB_ukoCBSg-1
X-Mimecast-MFC-AGG-ID: nS5xtTsJNWyOTB_ukoCBSg_1741387323
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-474f1ef0b7fso47386571cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Mar 2025 14:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741387323; x=1741992123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDGwdwGPb9qTBerw8cjE5pk2Lbp1bTzvxl+acBBp6AM=;
        b=qBb821KFCGnfZCAtWfJxNCMjk639evDug6sK0fmR2HOTnEUhZ/w0jOSY5qvSAxsG5k
         5OnfS9Tgb8Vxryzzs0DZM4xXMixXgo/7EN9P5rsVeddlzti6aNt6SafLhCtNAWhM+qwN
         Tc3z2tbt+22IMMVVnBim4+15kPLc1zTjpxo/fIaKoyzBNmp/GMsUxEM8Gq9RvXvKpJLj
         RcSY3Yab3fzgJs4ktXUkkytkRJyEJKszBQA6FQh2ycyB8VlfF5jFTOLLUZz/Q0IAAkV4
         HoVR7Hy+MIq70mUQJKmRMewuAo5QC/GxfyKpqQ1gh/ijMZS+B1PESQvagjdXMGQmhjQm
         j+eA==
X-Forwarded-Encrypted: i=1; AJvYcCVVkL/mO7pQp9NcQBlWzlO+B/PvIrcMihSkxOyC/thrt9U1UxSTstgNf1J6cevpJhDfILw9BrIW4KJlkns2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz030f8lkED3ehQy+EwxRtT/38q0G7Q7oxXbxHSt8bqQI3xxC+i
	0VQ7OWltY9JjFBj+bSPQsax8GnGvtBufHACWeY5xB2YKHF+8JjOmMli11gLyjhFFzvuIaLBDKW9
	7SWgmMr46QyL/TPbyob2ygGzclVuZVsq9ienRB2j0fO7yXrBNyZdI+iRaNtDk73uRZ+MYgWo=
X-Gm-Gg: ASbGncsvomKsXxfJBJIORxa5nQIjsybfroePsMffswG3oxU7IozrvPWOxLdbLoQn2LC
	pLYBG/rUK1vnIH6OPx+tBiSrKBaXJL47Rl5AeHYDVL5oBjIDZ7ae3dtvu9Vuno3hMtoQcY3yBQO
	bt867fsS9PW/FtOO67wpNCTiEKrs7dfWC3FskDwV3p8pegwRyBSWvoYT/WFMYIlbQyCSZgW6H7s
	Ul5nNxTMuYdQqK222t/dtocrVHiwvSzJvCDssENLKF8S8TexXETj1eMI7rQYbziCtlJXjLva/cg
	5Cva6pc=
X-Received: by 2002:a05:622a:5e8b:b0:476:6215:eafc with SMTP id d75a77b69052e-476621612ecmr15952171cf.22.1741387322986;
        Fri, 07 Mar 2025 14:42:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR8lVl/s+4EWWT/wvvD3qNU2PvGL5/xU3ZWoqR1iKynkdv5g8/8qA4/93Pss+bseIKro2zWw==
X-Received: by 2002:a05:622a:5e8b:b0:476:6215:eafc with SMTP id d75a77b69052e-476621612ecmr15952001cf.22.1741387322707;
        Fri, 07 Mar 2025 14:42:02 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d96f525sm25205451cf.21.2025.03.07.14.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 14:42:01 -0800 (PST)
Date: Fri, 7 Mar 2025 17:41:58 -0500
From: Peter Xu <peterx@redhat.com>
To: jimsiak <jimsiak@cslab.ece.ntua.gr>
Cc: Jinjiang Tu <tujinjiang@huawei.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	linux-mm@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: Using userfaultfd with KVM's async page fault handling causes
 processes to hung waiting for mmap_lock to be released
Message-ID: <Z8t2Np8fOM9jWmuu@x1.local>
References: <79375b71-db2e-3e66-346b-254c90d915e2@cslab.ece.ntua.gr>
 <20250307072133.3522652-1-tujinjiang@huawei.com>
 <46ac83f7-d3e0-b667-7352-d853938c9fc9@huawei.com>
 <dee238e365f3727ab16d6685e186c53c@cslab.ece.ntua.gr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dee238e365f3727ab16d6685e186c53c@cslab.ece.ntua.gr>

On Fri, Mar 07, 2025 at 03:11:09PM +0200, jimsiak wrote:
> Hi,
> 
> From my side, I managed to avoid the freezing of processes with the
> following change in function userfaultfd_release() in file fs/userfaultfd.c
> (https://elixir.bootlin.com/linux/v5.13/source/fs/userfaultfd.c#L842):
> 
> I moved the following command from line 851:
> WRITE_ONCE(ctx->released, true);
> (https://elixir.bootlin.com/linux/v5.13/source/fs/userfaultfd.c#L851)
> 
> to line 905, that is exactly before the functions returns 0.
> 
> That simple workaround worked for my use case but I am far from sure that is
> a correct/sufficient fix for the problem at hand.

Updating the field after userfaultfd_ctx_put() might mean UAF, afaict.

Maybe it's possible to remove ctx->released but only rely on the mmap write
lock.  However that'll need some closer look and more thoughts.

To me, the more straightforward way to fix it is to use the patch I
mentioned in the other email:

https://lore.kernel.org/all/ZLmT3BfcmltfFvbq@x1n/

Or does it mean it didn't work at all?

Thanks,

-- 
Peter Xu


