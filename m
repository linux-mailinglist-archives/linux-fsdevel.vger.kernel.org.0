Return-Path: <linux-fsdevel+bounces-50501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8F7ACC988
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 16:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF7216290C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFF123A990;
	Tue,  3 Jun 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UId1WCJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113015624B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962094; cv=none; b=c3in1elr0hwxnSgQgtPjPVVCuhAhlpDLvANegZcQuCAERJ3ht5/m2wGeuwJYv2YRo4o4aBNY84Y6mSLiyBEWz6hs/64G+foMpduTX60fVtg0GvNAscdjJy74rlwbta9iRsf19C+fhuxflFZe3CF3UjtcU1DMTwTXpj278A5vlbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962094; c=relaxed/simple;
	bh=ZSJYdEef4HMhqcvEtqqcCwQsna/0EAzpKj6JAiVrgBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6E6Lv0LA/pRBdMUbCOo2onUkNdopl+SnQRLgTNlpmzHC/Ag5i3ZKstk4HtQ3KpR2AfyR2tXh0k3J7nnEndno2fBhq7m4US92205vkBWddkeMzaIABKjx/PXs5Gif4ct03bzR+t8EDPMQAA+Bf0WpcMqEb1Zl+GVDICovb0o/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UId1WCJf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad88d77314bso1024693966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748962089; x=1749566889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=emupu0FVoX0tEpk+sXqho1utvGRUyKk3cbcNI7c+Gpk=;
        b=UId1WCJfwO7jQFb2LvfpNSNKTAS3QNnlCl8VRdwuWMhOlKn8go1K/mI0ZBUpNauY0l
         1h31p27szQDY6Z7a3O9pKYa+5GBGqCVTXm5pn99aefsrxWHHwFu0uc+esX8Q6oF3C36O
         hIgsrXe7RoHFCDf0Pnnwmv3Q/24xQsCWKKNnQEvc9JRHfGJvbhWPgspkLA8mdS/sLqkn
         dICF/WDiPrReVI2BhmkzrRwIF4BPnKYE2nqh7qiPtQ4ezPiwqXk7v/41DzFpI/6xgnLG
         ehP8sNGcXZhty4NWB9nPW0ZkjZwO4hDM5UDC8jGWT0fXoK1TaA4cz10JRQ0vEsApfnal
         Ijig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748962089; x=1749566889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emupu0FVoX0tEpk+sXqho1utvGRUyKk3cbcNI7c+Gpk=;
        b=XQtYWvvMZBHliVztQiYCDoDks7k6WWv7NPdViZXOwSG+tYCcvQbCiaK9qwOIk8hOOG
         yyuPJZmmqx/lMQvJBSRqeyWlQdgQ6SsBmsDCRzmOR4pEJHJH+M7wuMjJqd2sbf47oT3/
         LgPWatSeGhEWSkB4tiZn4dsXEiVtK+JX3UO7CbqRt9ab+/NTQqw0FquXwkehcMQ4eIUG
         C4dBTiNHN/3X15uOASlLDcxU5/POxo9Ad3KA5AIupwozeJ+EKr8ntwYOQBtHgVGGOA+0
         XGQIY6jftQhoilIRuEUkV+9iUULDVmwG0seGmsWYJI8SQK5mDrtXK9q6OcGKWwkqyvJZ
         bLFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFw0qHGtODpgfjGZudcY9wsFZ0DGM6Jrv1iJORKc7X0VUPQvElWTC4DPLOwRnvDgheayiVRxAKm5FcGw8V@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJPIuewtKed3mxKypAop2YaNAFNMHlvf0/8NlX9idymHvdexj
	W7aIELVEZgtX57fcqto4+LON5dmeD3p1vMNLFktHa/R1KNtnVWySZghjcyy5EaEpoZQ=
X-Gm-Gg: ASbGncveBxAFVUMVeSRUQQQO4a0wZSTDpLqRt7YDqDIv4IrqkyLutn+8p3Td4+i9hDx
	eNK7KUnTHk806pHNEq8f5FBpwgn0uv9SFu9GcOc+7hXzBozywSktaJtDaMa72drI50Eb+6i0QTK
	0e4G2Io78d3RR1IcD3svTmaY7jD8+6bWsMxp9wWtAgo/FqX7P2LMmd9/gFL+mgVJWrzhUp5USLb
	YtIyuNFNKjkta9V86lOUmqCGDmfPpvFUfSw18gW7Vo2dUMVTuk0OxywdKsU7vVAbkzf6+afRpsG
	RnQn2Gp3qE1NdRcTLdyrs9kQfZYZWlEIZJr1Z7Jj5r4pBEmokBDF82ewAxS/lkPJ
X-Google-Smtp-Source: AGHT+IHMPk/E1wB5w3uEJOJyss7DVzc2lc08kcqumZBJp3zEJ80iGBcdVvuMoYieWZBFkdImcajKWg==
X-Received: by 2002:a17:907:3d8c:b0:ad8:8478:6eb8 with SMTP id a640c23a62f3a-adb32248ce5mr1458814066b.9.1748962089043;
        Tue, 03 Jun 2025 07:48:09 -0700 (PDT)
Received: from localhost (109-81-89-112.rct.o2.cz. [109.81.89.112])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ada6ad3dd27sm952233566b.160.2025.06.03.07.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 07:48:08 -0700 (PDT)
Date: Tue, 3 Jun 2025 16:48:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, donettom@linux.ibm.com, aboorvad@linux.ibm.com,
	sj@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix the inaccurate memory statistics issue for users
Message-ID: <aD8LKHfCca1wQ5pS@tiehlicka>
References: <4f0fd51eb4f48c1a34226456b7a8b4ebff11bf72.1748051851.git.baolin.wang@linux.alibaba.com>
 <20250529205313.a1285b431bbec2c54d80266d@linux-foundation.org>
 <aDm1GCV8yToFG1cq@tiehlicka>
 <72f0dc8c-def3-447c-b54e-c390705f8c26@linux.alibaba.com>
 <aD6vHzRhwyTxBqcl@tiehlicka>
 <ef2c9e13-cb38-4447-b595-f461f3f25432@linux.alibaba.com>
 <aD7OM5Mrg5jnEnBc@tiehlicka>
 <7307bb7a-7c45-43f7-b073-acd9e1389000@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7307bb7a-7c45-43f7-b073-acd9e1389000@linux.alibaba.com>

On Tue 03-06-25 22:22:46, Baolin Wang wrote:
> Let me try to clarify further.
> 
> The 'mm->rss_stat' is updated by using add_mm_counter(),
> dec/inc_mm_counter(), which are all wrappers around
> percpu_counter_add_batch(). In percpu_counter_add_batch(), there is percpu
> batch caching to avoid 'fbc->lock' contention. 

OK, this is exactly the line of argument I was looking for. If _all_
updates done in the kernel are using batching and therefore the lock is
only held every N (percpu_counter_batch) updates then a risk of locking
contention would be decreased. This is worth having a note in the
changelog.

> This patch changes task_mem()
> and task_statm() to get the accurate mm counters under the 'fbc->lock', but
> this will not exacerbate kernel 'mm->rss_stat' lock contention due to the
> the percpu batch caching of the mm counters.
> 
> You might argue that my test cases cannot demonstrate an actual lock
> contention, but they have already shown that there is no significant
> 'fbc->lock' contention when the kernel updates 'mm->rss_stat'.

I was arguing that `top -d 1' doesn't really represent a potential
adverse usage. These proc files are generally readable so I would be
expecting something like busy loop read while process tries to update
counters to see the worst case scenario. If that is barely visible then
we can conclude a normal use wouldn't even notice.

See my point?

-- 
Michal Hocko
SUSE Labs

