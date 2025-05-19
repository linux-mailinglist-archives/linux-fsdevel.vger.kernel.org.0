Return-Path: <linux-fsdevel+bounces-49422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B26ABC01F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 16:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF481739DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06262283142;
	Mon, 19 May 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P636DutZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A5280A22
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663380; cv=none; b=CZyZaxwHHFJkLYpTUbuHu31NpPiM5co6skv05A4M7T+WWcDyd2cTuBAWn/Z4ZZFuL4D0PUhvltA4NYMyjS9y/cXnCTh9xxwnh46qCtoF8amxCg3bx5i5tKG9BzFv4MNdbZ0PLoeKmY80ePuBmqEYuW0veO+5G2xP8h2kCh/S/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663380; c=relaxed/simple;
	bh=6JeicjUHmHodkNN/zM/djUCuOR2HOijRfC1PdA6i1Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEDlA2WDEywKhuvEEazxO+58vy92cVOnGxwSpRuNPre4MpAaYHKCk0bp8wDsBVZW1B0HYH/wbfOk3Uuyub09PuQBr++5tT6QngF7w4Qg725diGKisebXDyavwmS4vLgnSm361JBEugodkXvgKKk9a3q8da5/Z76L/XOZFW5YdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P636DutZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a363ccac20so2281475f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747663375; x=1748268175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWHK376VyM/OI/YTUsa3tJsiwaElzvKB3NW3NOhpiiM=;
        b=P636DutZeVZfwjnLwuxbXt9gvNyYJSKX2bNgrVDsov0uHT4nKxEBaOfkCx+Upz0I7T
         VLN42EeAIvGmwPhJkQsQ0l0iJN/KBsDN3/qk1xsPE3oTKcxYm7HshGQpOcR6xGnoJWYs
         qXsOvMNFlV6lXskj8xwEqoaEK56QpQOlXqIf0I13Nf/Vt2VQCPUnOWFXipvCATD7dt0O
         rRCMm6/sQopHxPZbDy2Nsf0cXgB05xh3dcs4n47rn2PuQkds16tjOCIFtlCofp4E1QJO
         pUdEivieJJ5zG9fNXD3OYNAiJUEN/aNfVfW4KfMJK45zsfCjGlrgo5lFMbrxD3TWyuG9
         R7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747663375; x=1748268175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWHK376VyM/OI/YTUsa3tJsiwaElzvKB3NW3NOhpiiM=;
        b=el0rl9bM459xF5uDQlUIyfn0lNu0XrIgSsFHL50N72ky6McH8b3X9y704f4q27/UyK
         U8pboGr52VOghX4b3W3ShbBpVSwKcN+6oEK6qKtfsM0nVKoN5Yqq7qrghfipNcf4+XwI
         GKMj2wRelHKr/ZhbIiwrtun2y/BfH5EMPhHEhKd7+iE7RjQhIjepdqs0ul86h8WEyZ9+
         VYe3PKPo+9R0FqG2QIQ0UMJbANfTrRiRw21EJkxlKdyXaWJMgGcfujdF8hpgGxVQsOQ4
         wQCMMvPv02OJN0A5eiqJ0zzCXtyjDKVJBmfSO+0zXM2HB3DHAHLDKWTdJZVmh2anHLMM
         mgDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgablmGPue0TpbHP2dT2CuAn7J0iZEv4UYtsN6gA9L9X/F7030kB16w/SKZAJvu1Ws/4k/JUaotjtSOdv/@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5MhJYzhYhUHi0aTGgUPRwV/CWP7IkZi6EhQIt/6fo5v0Drm5
	+IvykJZIV87/HW2zLYIdxouKzytkjxyHma8nSTtnPL5WGFmY/NBw1Rrj93cqWbTrXcw=
X-Gm-Gg: ASbGnctC3JxnxhWUCawg5aTy0pcQaYdM8EeaoRBaYaaF5kd9uCHgX+2YpZoE11Z3Dr6
	exT/Pt9rCwWLSaB9rHJaLfgDIxBugvhzGGPRK5je3aZRt7rq+IAesckWJY7VVqpNXyd/XEn0JBQ
	yFnbVxJsgWwH32JUUzVKSoX9BELL24X4IzVYvQyxN5Fvnt6D6dhcxiDKuKhaXE8EhECSH0/Qx4c
	7re63/7ktEyZVyV5TbsTYiAaEigCQhk5n1USXkHlgs9nK3IoAbFmUKMDW4cFS6drbokn5udSn+a
	mElaRhpHY0WySWc=
X-Google-Smtp-Source: AGHT+IHgFSt1Ji7/vd8gjbKHf9/ZDkJicJQQ8h96um9tpOt5m+Et9jN1XlhPEUTYTozb2xYGapLzmg==
X-Received: by 2002:a05:6000:2482:b0:3a3:652d:1631 with SMTP id ffacd0b85a97d-3a3652d1856mr7082207f8f.16.1747663375211;
        Mon, 19 May 2025 07:02:55 -0700 (PDT)
Received: from localhost ([213.208.157.38])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca4d230sm12787370f8f.4.2025.05.19.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:02:54 -0700 (PDT)
Date: Mon, 19 May 2025 16:02:51 +0200
From: Michal Hocko <mhocko@suse.com>
To: Bharat Agrawal <bharat.agrawal@ansys.com>
Cc: "hughd@google.com" <hughd@google.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rientjes@google.com" <rientjes@google.com>,
	"zhangyiru3@huawei.com" <zhangyiru3@huawei.com>,
	"mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
	"liuzixian4@huawei.com" <liuzixian4@huawei.com>,
	"wuxu.wu@huawei.com" <wuxu.wu@huawei.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: mlock ulimits for SHM_HUGETLB
Message-ID: <aCs6C2vKbecx-boy@tiehlicka>
References: <SJ2PR01MB8345DF192742AC4DB3D2CBB78E9CA@SJ2PR01MB8345.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR01MB8345DF192742AC4DB3D2CBB78E9CA@SJ2PR01MB8345.prod.exchangelabs.com>

Hi,
On Mon 19-05-25 10:21:17, Bharat Agrawal wrote:
> Hi all,
> 
> Could anyone please help comment on the risks associated with an
> application throwing the "Using mlock ulimits for SHM_HUGETLB is
> deprecated" message on RHEL 8.9 with 4.18.0-513.18.1.el8_9.x86_64
> Linux kernel?

This is not RHEL specific behavior. The current Linus tree has the same
warning which has been added by 
: commit 2584e517320bd48dc8d20e38a2621a2dbe58fade
: Author: Ravikiran G Thirumalai <kiran@scalex86.org>
: Date:   Tue Mar 31 15:21:26 2009 -0700
: 
:     mm: reintroduce and deprecate rlimit based access for SHM_HUGETLB
: 
:     Allow non root users with sufficient mlock rlimits to be able to allocate
:     hugetlb backed shm for now.  Deprecate this though.  This is being
:     deprecated because the mlock based rlimit checks for SHM_HUGETLB is not
:     consistent with mmap based huge page allocations.
: 
:     Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
:     Reviewed-by: Mel Gorman <mel@csn.ul.ie>
:     Cc: William Lee Irwin III <wli@holomorphy.com>
:     Cc: Adam Litke <agl@us.ibm.com>
:     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
:     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

HTH
-- 
Michal Hocko
SUSE Labs

