Return-Path: <linux-fsdevel+bounces-25889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00F09515B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 09:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3B31C21272
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293D67F486;
	Wed, 14 Aug 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c0JgkVsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2529CFB
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621328; cv=none; b=Dz03Uvj14Y9Crauc/u0ZelwN67bFK63KK68sCYsINi3vKT5fHr608nkDSUyJCVzww0fNmcQ1NB54fYsWOFRZs6269+LECJYVGgYnOGKqOTdB/zV4U2wSziqJHZJd1dqfBsKV2cj9y9OrJXn2Zx3hP7In4QpNAHmCPOkOp1MRRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621328; c=relaxed/simple;
	bh=lLPJEBPlhrgaJ78QMbH5E9PyKRWjdvgh1G4JWYJ27do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUsTuni5sgm9zQfsV5NI6OJGrwucRb29z9L7fW9kUQ227IArZJcHtUCwRoan4tj83L7taHOUOlhMqziLf4d82cDs78RNpCduAbOkv827Kp+PIKierRE8M28rTaIH9N41x9CUWEEecDaandBGyBvhVYfDjak0GLuxVqawXCQ0Das=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c0JgkVsM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f04150796so8267827e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723621324; x=1724226124; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eV6KIkP1HPbjcvGK3wIkhkXD//T52t9H2OkdZ8k6KTE=;
        b=c0JgkVsM/6d0Fmos9Rcf1aX0QxvX4VealsmBM0FSQrMAUGtRXRSJ9nBCuBmx9ka4TA
         2Z8h01usakLy3IuPw0WUVKlSAk7mnwC8knxfdoEKpX3RKkn4fAaHk4XflF/g6C6UO/W7
         sSkxbsiXfEJBhP2jEBKKzzVVbhTQra9lhIUo/P8D7V5JQMR61RKfmfqZBhsPcxzR0QMX
         dHj01H/ZyFkwtepIx6utyeW/Ovu8BbcNFZBQgYo5IKpjqj8NJ84l/pGJIXjISmZTxq5I
         XEEo+RE78OpN47+Ski6qru59I1CcTguy/CKJ9HHHXtvxHmyC46jwri/JQGrbKoyuyOqL
         axWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723621324; x=1724226124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eV6KIkP1HPbjcvGK3wIkhkXD//T52t9H2OkdZ8k6KTE=;
        b=G9MVCsOOJetDDgwSnp1T6G6SFtbyXOh6JiBJqkHiTwjwrOqLm53AM/nYSo0+iLPw9h
         ACXwQRbw31RcUOHXDIkrQti7W5N37s8T/joJ5b3h3k/AXvABumU1pR5SbzHpMQ4VfM5u
         D+AdcX03Wnm+sfwWXo7eHk9Kv3z1+X1fOdC4leySm9tSsX5poSRaeSbz6dtvRZlz2sAz
         ffZc/q3TjedzGdhhQyocvVEQQUnyCNUAiXborXKAylPyZLWpDvZ4D1NTVYXu4S+Wx0pn
         5fMZw588GqawA5iXzzgBzPqAw7tWO69qlE4pQTFhOLFJc1/5gaA9FsBmbDXl9sM7y0Cb
         CKWg==
X-Forwarded-Encrypted: i=1; AJvYcCWuE1/IZ5X+8KRxEbCDI9qpLZXq23lNc3sSk0cmM0gKwVv8dNkdWVzes0tO17Po+WsVz6xreYDXP2yooCM+Yefos435XFtXmRl9v7N9lg==
X-Gm-Message-State: AOJu0Yz+J08GA87llGBkP7UWx8p4aAh/RKYy8IToi1JdBWvCCZ4ig1oJ
	vSAooHvYlbUwv/gBDr/skv9UmJT4pgIiZkT6OL+mRMxwTad0dRKCXvIvH1SD1sOS9dP+lpbD4sx
	h
X-Google-Smtp-Source: AGHT+IEPEkmqbfOKrDzwCqyeDWSVGBTGsyPlmNBuCoSJ3GpFrD/Zo2c+Nd9Cmu681kwGjzZIAcdP6A==
X-Received: by 2002:a05:6512:2529:b0:532:f173:a63b with SMTP id 2adb3069b0e04-532f173a8ffmr668799e87.46.1723621324386;
        Wed, 14 Aug 2024 00:42:04 -0700 (PDT)
Received: from localhost (109-81-83-166.rct.o2.cz. [109.81.83.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded5c166sm11604145e9.46.2024.08.14.00.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:42:04 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:42:03 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	david@fromorbit.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
Message-ID: <Zrxfy-F1ZkvQdhNR@tiehlicka>
References: <20240812090525.80299-1-laoar.shao@gmail.com>
 <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org>
 <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>

On Mon 12-08-24 20:59:53, Yafang Shao wrote:
> On Mon, Aug 12, 2024 at 7:37 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> > > The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af905bfc
> > > ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To complement
> > > this, let's add two helper functions, memalloc_nowait_{save,restore}, which
> > > will be useful in scenarios where we want to avoid waiting for memory
> > > reclamation.
> >
> > No, forcing nowait on callee contets is just asking for trouble.
> > Unlike NOIO or NOFS this is incompatible with NOFAIL allocations
> 
> I don’t see any incompatibility in __alloc_pages_slowpath(). The
> ~__GFP_DIRECT_RECLAIM flag only ensures that direct reclaim is not
> performed, but it doesn’t prevent the allocation of pages from
> ALLOC_MIN_RESERVE, correct?

Right but this means that you just made any potential nested allocation
within the scope that is GFP_NOFAIL a busy loop essentially. Not to
mention it BUG_ON as non-sleeping GFP_NOFAIL allocations are
unsupported. I believe this is what Christoph had in mind. I am really
surprised that we even have PF_MEMALLOC_NORECLAIM in the first place!
Unsurprisingly this was merged without any review by the MM community :/
-- 
Michal Hocko
SUSE Labs

