Return-Path: <linux-fsdevel+bounces-19700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1698C8DB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 23:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236161F23334
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 21:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213E71411FC;
	Fri, 17 May 2024 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9vMkJd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B035231;
	Fri, 17 May 2024 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981560; cv=none; b=RY1GXDGHCGjiXTtjii4dyjj0GFJJV+RV9ZCiYPuuoBr80mVHrKgLq4bdkQDvaGcn0zAFRGjxgndB5qSK8hM1+BFoQsMFaJXUxXr5C+lK9FttLX7mn2FimObg917lC6DSpCnmU4y1yQYGSmKx9COdZuapVD46jDzcMf86Z9eP+s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981560; c=relaxed/simple;
	bh=7TdUGU59lM5Y68qE55hDQHQuzdkvVUf7N0kWoeZdMSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7RkIH829JjTFwvor5iD1A88Wj2UPZgCc7nE8Cp4NBFXqaIxwmP/PvtPVw6df5m4hmTYuR5VDiBlTYww76mii1McIUW1DeWlnRtjHtFAqFdhwxMgN/ym9/NNVTighpSmBWdlUqE2GreFHJKuMgzLurKJ2GUAteCnX9WJSrDe9N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9vMkJd8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b33d011e5dso456857a91.0;
        Fri, 17 May 2024 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715981558; x=1716586358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyrneMtT2roM/mXv9xc7jF6yRyXUeDAQ1aSOo1P0c+s=;
        b=S9vMkJd89imnOHeCgIiY9IV0YKWSbrONZDKiIsQCKLezFEAxoYYVVgmI1B9OMWcEUF
         Y1Y/pWQfXbI+dwJM/o5cqNH8c2ScuDQcQzShPtNMNZWou0CKAQg/RZg7rbV0d8zV1UMp
         1cjqbNJn7DUYsEGH0AmemdEVEAzfbklh9piSs34XB3Cuw30YYWZP+IIUBRJXzuJQnGnc
         gmpqg7BxszmAQ5qFIt8K2Nk3MGAOwzxH37uHNGUgKii/1O37ll6dsNZjgUSS2aFsYlyX
         8Wnanh/p55uHLg/NzGpoSO/JLfFTDPA9aZNjvkW7xZzdSmZ9WEnxHLvKnLH3G3W8NGZC
         UhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981558; x=1716586358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyrneMtT2roM/mXv9xc7jF6yRyXUeDAQ1aSOo1P0c+s=;
        b=ZUPIH4RF0nCaOY6bOYd9oiBP8xJBaXnZ2h0AMbQU2fiWznTjVr4dOE3tT2hAlH5dgf
         nCk/91hlqUbkNt9irSu9V5xv60l2Ux102cjWHqJIkJ2LbRrHymR2suKki7Kv0btMHGJM
         c1CH93IgMfCCzeFcpVfa8er6dc5Q9pX8mTxXUvhQ+CyQrHJLNlQNT5eJUjRvYST6P6Eh
         bJZngicjbXb4z8auH7dQNgtSNOWb5UsfLm2fgx+cSsWYehz3kFGffqYhHjCPKa60XCk2
         Ecb+zXNUaeDW+pnjs4WrW14Eu2fmBGLDJMEEMDhSPm/gg1PFSNk+bbUIklyxufO18yxV
         wXsw==
X-Forwarded-Encrypted: i=1; AJvYcCVH1Jz+L+xyeLoxUcL4RlNw8XU7F/GmmVwKggGMqnT/TVVgl6+BFF8g0WlypnuhGBl1BgSUIZtEPjgFd1vrsOo16W2fiu7W7kaKisPWZn6VGGI90hgOkoszSG0I3JFOulTLV/E9mo/RMAl3d236SUxX9nud/cCUVcABHEHC30XX/RnGj/OZokhEVGt24na4CPwgm+rbXATzSYZBoNdQjK3oRw==
X-Gm-Message-State: AOJu0YyjahJvbGI3dpI7fuAHVPwFoszvy7EBIH4Yqu/eTSdMWtVo4/Ex
	4uDOhiXcRyKgyQRxU1jXqe28NLn8fhh/gdE4l6Zb28IYlj0v2fR5
X-Google-Smtp-Source: AGHT+IFXyePfAU6GysoFIX/3SNu/9wWzEv6Uf6hwUK7S74vkedQQo6HP3kvP2IJec5JbP/nPkQmlFg==
X-Received: by 2002:a17:90a:68c9:b0:2b3:6898:d025 with SMTP id 98e67ed59e1d1-2bd6038cdabmr402648a91.9.1715981558358;
        Fri, 17 May 2024 14:32:38 -0700 (PDT)
Received: from nvdcloudtop.c.googlers.com.com (32.39.145.34.bc.googleusercontent.com. [34.145.39.32])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2b5e02bcf6asm15563186a91.1.2024.05.17.14.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:32:37 -0700 (PDT)
From: Navid <navid.emamdoost@gmail.com>
To: willy@infradead.org
Cc: bpf@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org,
	navid.emamdoost@gmail.com,
	yuzhao@google.com
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Date: Fri, 17 May 2024 21:32:31 +0000
Message-ID: <20240517213231.2934591-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-01-29 at 04:32 +0000, Matthew Wilcox wrote:
> Our documentation of the current page flags is ... not great.  I think
> I can improve it for the page cache side of things; I understand the
> meanings of locked, writeback, uptodate, dirty, head, waiters, slab,
> mlocked, mappedtodisk, error, hwpoison, readahead, anon_exclusive,
> has_hwpoisoned, hugetlb and large_remappable.
> 
> Where I'm a lot more shaky is the meaning of the more "real MM" flags,
> like active, referenced, lru, workingset, reserved, reclaim, swapbacked,
> unevictable, young, idle, swapcache, isolated, and reported.
> 
> Perhaps we could have an MM session where we try to explain slowly and
> carefully to each other what all these flags actually mean, talk about
> what combinations of them make sense, how we might eliminate some of
> them to make more space in the flags word, and what all this looks like
> in a memdesc world.
> 
> And maybe we can get some documentation written about it!  Not trying
> to nerd snipe Jon into attending this session, but if he did ...
> 
> [thanks to Amir for reminding me that I meant to propose this topic]
> 

On the "Reclaiming" part of this thread, we might consider this:

Optimizing Page Flags: Reclaiming Bits in page->flags via folio->lru

Limited bit space in the Linux kernel's page->flags field, especially on 32-bit
architectures, is a source of challenge [1]. This proposal aims to free up bits
by relocating flags like PG_active and PG_unevictable to the lower bits of
folio->lru as they are always unset. It helps with encoding zone, numa node,
and sparsemem section [2].

Proposed Process:

Candidate Evaluation: Assess flags for relocation suitability based on usage,
dependencies, and functional impact.
Impact Assessment: Evaluate the impact on kernel code to ensure correct behavior
and compatibility.
Relocation Implementation: Modify code to read/write flags from folio->lru and
adjust related macros/functions.
Thoroughly test changes.

[1] https://lwn.net/Articles/335768/
[2] https://blogs.oracle.com/linux/post/struct-page-the-linux-physical-page-frame-data-structure



