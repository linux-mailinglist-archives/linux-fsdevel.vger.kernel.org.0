Return-Path: <linux-fsdevel+bounces-16626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E998A044B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 01:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9888B288F6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 23:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321393FBAC;
	Wed, 10 Apr 2024 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ul8dGcy7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EC43FB0F
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712793510; cv=none; b=S6gXZjt2iprT0xeKaTHyOpclbC0/MgHM7t0STcnmCvTQzFp/B/4ojpyvIvOraPWtMEB2wVBLmIEQ3rcRBGOLWwloQha+GWnjzzFDR/8K6zD2PznJXiVcK7cwxCpxdtX/7u8CQYMKxFKcsaPPTZz6ifmcPxVJ04PQlN7MWyd/o24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712793510; c=relaxed/simple;
	bh=bXItv4HYzVSIBt+RUD5HDA9HqlJYzm+XsjCsyrirxEM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FubVfCGPB/Xcuu3EXrvWs0OdRYcNuWzx1pj5UBK+lERms1feolcqO7pYKDAuh+GLbfI6sw7AYqbUTAWGC11OKp6/PUkpmHQNVXjZmwYLxB+min0u4Mmt2d7Rbo/Dok5eEzagVgJr1DcsHKhsdfhoDk1LWrACyKPQQxUHAuiMo6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ul8dGcy7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e062f3a47bso36895ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 16:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712793508; x=1713398308; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZXB+0PtaF+vG2Eqe2ku2kHYSPF78NFZHwzDIf6uFVo=;
        b=ul8dGcy7CrJ4QlBF847S23xeeYmdr1uFniE4EssnJuF9uVlt7XlFWP/5saKY3aGGW6
         R/q84JQjdLY84gy2Yu+ZQ6zCcbXvw21T5S/DGqsB8NpeuJXPW59MsqZjy/XzAygRg3FO
         DBBcBNWAd4ELo87Pj02kig4gcrMCTCo+FYBKF7n6m8I1/hq8MFyInnBIGKI437o+MHRF
         Gnd16K0fGkceV/fcAMhxNA84MifHHBUF3AQe6/KoL1V4r0IS8vl8ts7kJVWiL8sCrkSy
         LRhk5QIGmrXzoSMDm5WRzQs+21LKt/dozqUiJjUDTaEeKPpjutitrYmpRn0UFk88ARtF
         jVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712793508; x=1713398308;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZXB+0PtaF+vG2Eqe2ku2kHYSPF78NFZHwzDIf6uFVo=;
        b=QN62ZPBk39qU2k1aq0Xl9s2+LyUoJGcG9+zG2W+Dc5NEo/kaRFMkZ9IpDHtTJW8EiD
         9w4VK/otJ7ZcxLABTh79lAEY6hbgEOUlmxtaIFZO9Mm9ALk7GdVof8O5y0uAMc2NXiFY
         +jSszp4NKApRO6y398hQG3/UtR/gyB/JglOzDzgG4BVSutiLUcfoiD4/8gFb6Jkj14Ap
         19h3/jTMBAoXEEs64RNvJA+GRd8HaK7UiVd/gFy+eT8IoOfErft4oxGqs+9AUHVFEEp/
         gWPtBlZx1EmyIYH1TnbUbel2H40x23xRTC+f5tYZttsdiSAo+SNzxqCWOH9WCLYFIVVk
         MFjA==
X-Forwarded-Encrypted: i=1; AJvYcCVIO7rfODHYl+zkF2BYZdIUe/GdRR5XuoOwlM6n/IDMymwkxuh96JYsmoGRWDzDudcT41zqU+1chUeSTTWvAbntcrCkFx3rdFWktloRgg==
X-Gm-Message-State: AOJu0YzLMZKNCShpJTxVbDwMdRBsgPw6FxjJE6EM6RUYFHN4IEsxMjH6
	kO+QJ7T4u2qdGFC8qxst7UEiuK3nuXSDDNGT5FP31g1itgD1eQKGB8gjrBIZXw==
X-Google-Smtp-Source: AGHT+IGd+QI2KOJ5c/8/pTyKY+Y+N0EZgS87fvMttED3Ds2Pyg5DEehZ91bfZhC4ZUFBKIIxCloFUA==
X-Received: by 2002:a17:902:e743:b0:1e3:c01d:fb17 with SMTP id p3-20020a170902e74300b001e3c01dfb17mr55118plf.11.1712793508162;
        Wed, 10 Apr 2024 16:58:28 -0700 (PDT)
Received: from [2620:0:1008:15:2d0b:3c67:e0d1:ea8] ([2620:0:1008:15:2d0b:3c67:e0d1:ea8])
        by smtp.gmail.com with ESMTPSA id ga18-20020a056a00621200b006edcf5533cesm214863pfb.79.2024.04.10.16.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:58:27 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:58:26 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, 
    gregkh@linuxfoundation.org, rafael@kernel.org, mike.kravetz@oracle.com, 
    muchun.song@linux.dev, rppt@kernel.org, david@redhat.com, 
    rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
    tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
    pasha.tatashin@soleen.com, yosryahmed@google.com, hannes@cmpxchg.org, 
    shakeelb@google.com, kirill.shutemov@linux.intel.com, 
    wangkefeng.wang@huawei.com, adobriyan@gmail.com, 
    Vlastimil Babka <vbabka@suse.cz>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, surenb@google.com, 
    linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-mm@kvack.org, 
    Matthew Wilcox <willy@infradead.org>, weixugc@google.com
Subject: Re: [PATCH v9 1/1] mm: report per-page metadata information
In-Reply-To: <20240319143320.d1b1ef7f6fa77b748579ba59@linux-foundation.org>
Message-ID: <65b77d3e-d683-1e90-ebb0-5c7758143048@google.com>
References: <20240220214558.3377482-1-souravpanda@google.com> <20240220214558.3377482-2-souravpanda@google.com> <20240319143320.d1b1ef7f6fa77b748579ba59@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 19 Mar 2024, Andrew Morton wrote:

> On Tue, 20 Feb 2024 13:45:58 -0800 Sourav Panda <souravpanda@google.com> wrote:
> 
> > Adds two new per-node fields, namely nr_memmap and nr_memmap_boot,
> > to /sys/devices/system/node/nodeN/vmstat and a global Memmap field
> > to /proc/meminfo. This information can be used by users to see how
> > much memory is being used by per-page metadata, which can vary
> > depending on build configuration, machine architecture, and system
> > use.
> 
> I yield to no man in my admiration of changelogging but boy, that's a
> lot of changelogging.  Would it be possible to consolidate the [0/N]
> coverletter and the [1/N] changelog into a single thing please?
> 
> >  Documentation/filesystems/proc.rst |  3 +++
> >  fs/proc/meminfo.c                  |  4 ++++
> >  include/linux/mmzone.h             |  4 ++++
> >  include/linux/vmstat.h             |  4 ++++
> >  mm/hugetlb_vmemmap.c               | 17 ++++++++++++----
> >  mm/mm_init.c                       |  3 +++
> >  mm/page_alloc.c                    |  1 +
> >  mm/page_ext.c                      | 32 +++++++++++++++++++++---------
> >  mm/sparse-vmemmap.c                |  8 ++++++++
> >  mm/sparse.c                        |  7 ++++++-
> >  mm/vmstat.c                        | 26 +++++++++++++++++++++++-
> >  11 files changed, 94 insertions(+), 15 deletions(-)
> 
> And yet we offer the users basically no documentation.  The new sysfs
> file should be documented under Documentation/ABI somewhere and
> perhaps we could prepare some more expansive user-facing documentation
> elsewhere?
> 

Sourav, is it possible to refresh this series into a v10 on top of the 
latest upstream kernel with a single condensed changelog that details the 
current behavior, what extension this is adding, and how it is generally 
useful?

As noted here, the cover letter has great material that discusses the 
rationale for this change but would be lost if only this patch is merged.  
So typically the cover letter material gets concatenated into the 
changelog, but in this case there's a lot of overlap.

A single patch that includes a succinct changelog would be awesome.

And then the requested documentation in Documentation/ABI either included 
in the same patch or as a second patch in the series?

I don't think the resulting patch series will actually need a cover letter 
after that, it will be able to stand on its own.

> I'd like to hear others' views on the overall usefulness/utility of this
> change, please?
> 

Likely true for all hyperscalers, the immediate use case that this could 
be applied to is to track boot memory overhead and any regression over 
time (across kernel upgrades, firmware upgrades, etc) that may change the 
amount of total memory available.  We'd want to subtract out the boot 
overhead that we know about (like struct page here) and then alert on any 
regression where we're losing memory from reboot to reboot for any reason.

This increased visibility into boot memory overhead allows us to create a 
mechanism to track changes over time when otherwise that attribution of 
that memory is not available.

