Return-Path: <linux-fsdevel+bounces-53293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6D1AED324
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 06:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD827A5F2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E4118B464;
	Mon, 30 Jun 2025 04:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="B0mAtT8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61428A59
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 04:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256160; cv=none; b=sE6d+OsxTGm7XD/+13m62R2ThEsWDNB5QXcSpaiq6syKmLB5Y+Brg0lapv+/EgFVwYSVYBvMFXOnJvPY1yYuQ63Huy4WYd1seZUzX6SsiYeDHxD/UQNbeFVF+x0iBEm+hZ9rc/XzlTlhVCOMLobiEft0w8hRV9ot5okSUSQEYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256160; c=relaxed/simple;
	bh=2PH4IfqxjRoYODDt4w8REX+19hyHE9DD889qk2Up7TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5FQ679vNuBinPSHV2ChD5+Juk0VHMM/SPxCR70SyTzCegMbKcjtNH5GZZ+IME8l8z4ecxGzq284dq+xg07Jv+yCBxnwK5fZg1LirSZPE8CHnm8RXc84ZHN05EGhBQmw6HprVz7sn11UBOuoPnagWmYb/3EFjcqrnP11LvEZB5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=B0mAtT8e; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58d95ea53so44243061cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jun 2025 21:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751256156; x=1751860956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ccyGNOG4mThDYRScrKYSg+jRSybzBPlkASokJM1l1qQ=;
        b=B0mAtT8e/qEsXlVI+9kUS2H6qv5tMD9dedvyJUepa+BBYgq4DaT0RRHiAE3peQoDGI
         x/aS24e4D7bnzprAdgbJnnBhfAT2dlpg4VpM8hRxIKyFYgTJUKfUAtD0uspaSxJ6hSMq
         L8+J607CZMxdbVe5CzBriXWExnueBi4DqIgkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751256156; x=1751860956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccyGNOG4mThDYRScrKYSg+jRSybzBPlkASokJM1l1qQ=;
        b=SFhT+kl9Bwza03EQ5zPZkmNnLPboAJn6abRzqc3Y7NbSo32fdnXTlw5ObRw00RSnG5
         hnGkfy7MUUzdbKw83X6bwbn0i6XQHvUz0W2MjCq+nbK5nScwe9xzCK8VQpciGlUyePyz
         p8ZdVySqrqecskp8snUAQopj/sSQg6jganNqQIIzTq4PiuxI1QvZ/Z5iF6aonJwqjQGk
         1+gWKu5Q1KHlI+cYjXh0fQ+NfZwSI1gYM7Kbc4nsF2CDQy2RmQstRErA9JzcIEPrmiKB
         iSC8XulA78lKVI6GtAOVMrT1j8Y0hTac4FxQRMXSVv78jv8oClpdZHE1HRisO2yq38v4
         rgaw==
X-Forwarded-Encrypted: i=1; AJvYcCUywglnddfTEPgLlrFe5tvn2ylXiBzWe4NMc85+yGNMHu5CJGO4GMa2y8rCEdoFFN6A4kTuMalmjPt1JN5b@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Sr63RuNYws42NCGfAlJU+O0qE3btvut48t0yrvw2+f/30L01
	bOlbv/7UkBHZwREXG7zLX/Bi8m7DpmqJD3HNxCVbivJVOCeZflqQZNZEIaZpS0Skl/5vx40/g3q
	Ti9qlAJ9zOeFM1S6Q6UHKmCHp6a2TWdaD41rGxvS/bA==
X-Gm-Gg: ASbGncsxKVDYlOPyVqHopBLePvx5OX7wwFWTz5H04Hlpvoin6F6Lh/29F6/qLQuCvoh
	PRMEZgXdlfX/KR+SiPC2FycLRgOkFMRVWh9FYFLc24Vh6+CaEjqL2BU4+bvYanrZLy41Pw0HS55
	CZ1HtGu74NylBFXpfp/m5vBvzFboF4s+vNe3vwYcv5HZKxPF2iB3u3XjPylL/OhOOAi6xyXahwd
	MQ1
X-Google-Smtp-Source: AGHT+IGEA1Bx9EXMdm+tpafIIY/Ry9x0MSRRz2Z+QvxjDqOWaMdXDs4EnsATAsakAQqy0QCkLK0OokY4z73m/rZNDBU=
X-Received: by 2002:ac8:5c93:0:b0:4a6:fa39:63a4 with SMTP id
 d75a77b69052e-4a7f2db5dc1mr273364231cf.2.1751256156071; Sun, 29 Jun 2025
 21:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625-nr_writeback_removal-v1-1-7f2a0df70faa@suse.cz>
 <CAJnrk1YcA9MBC+KQdLE7B-CspoO5=xjkAf78swP6Q6UPijJaug@mail.gmail.com> <rr2hxi5dxoh6n4pbx5pcyelquvotbksfy2d2m5ycydafog65j4@rcekxluoecrr>
In-Reply-To: <rr2hxi5dxoh6n4pbx5pcyelquvotbksfy2d2m5ycydafog65j4@rcekxluoecrr>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 30 Jun 2025 06:02:25 +0200
X-Gm-Features: Ac12FXyOwr0llO8hHixJAlK1VoG5y6j39_v-eU55NPgRFJeCqE-U8vJRqvHmIrA
Message-ID: <CAJfpegtk9AEtj3kxivM=tm-DgSTnGqkv46HdNFcG34omJ2qVLw@mail.gmail.com>
Subject: Re: [PATCH] mm, vmstat: remove the NR_WRITEBACK_TEMP node_stat_item counter
To: Jan Kara <jack@suse.cz>
Cc: Joanne Koong <joannelkoong@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Tejun Heo <tj@kernel.org>, Maxim Patlasov <mpatlasov@parallels.com>, 
	"Zach O'Keefe" <zokeefe@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Jeff Layton <jlayton@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Jun 2025 at 09:01, Jan Kara <jack@suse.cz> wrote:

> Regarding the comment, I'm frankly not certain how strictlimit solved
> NR_WRITEBACK_TEMP issue because NR_WRITEBACK_TEMP was never included in any
> computations there AFAICS. It just helped to limit amount of outstanding
> dirty pages for FUSE mappings and thus indirectly limited the scope of
> NR_WRITEBACK_TEMP issue. Anyway I think the sentence is obsolete now and
> deleting it is indeed the right solution because FUSE writeback is now
> properly accounted in the dirty limit.

The question is how much fuse can overrun the dirty limit without strictlimit.

AFAIU the strictlimit feature was added because temp pages were not
accounted as "dirty" as opposed to writeback pages which were.

Header of commit 5a53748568f7 ("mm/page-writeback.c: add strictlimit
feature") has more details.  But I don't fully understand all of that,
and strictlimit may still be useful.

Thanks,
Miklos

