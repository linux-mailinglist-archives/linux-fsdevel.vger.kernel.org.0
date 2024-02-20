Return-Path: <linux-fsdevel+bounces-12169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D291885C2C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 18:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806851F21B2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 17:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB4877622;
	Tue, 20 Feb 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK9kqvzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4B6BB3C;
	Tue, 20 Feb 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450489; cv=none; b=uAxXXC2xwMcI+/RlDZ4chBDb8Gr78U9eM2n7fnd2l2w2C/K9ydBxlJPpQT5OiWmrsSHkOlHJjV8+m5RD7nAQE2h87H6X1VlyasYvQmlv560gaByKd/yILligAf0NYN+j7IB50TboXvIV1mph5sZucsrkFr2PvJPowAoR6YNlaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450489; c=relaxed/simple;
	bh=jvxP9y+fUaenjIbkE3NPIqpxAJvHGIsnTHgQLaNrJGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1OOJPH2YZlhrLowSYeVdLbx8WvuJVGT1R939h+dkjk6jmhhNqv2/GtYtAVOMe9+TFCyRBzL1o7peWpILf/yFMhQW5a+tkdbzIv5cDyQeKQcDW1gjEl83Ed/fSZoJQyhadkrn9EeRuzDiUe9KHy+WD4ANLvAJPOZSgbQQqgt3Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK9kqvzO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso5614495ad.3;
        Tue, 20 Feb 2024 09:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708450487; x=1709055287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0gLcb+UZQZKvdtR+xNRyRYfChy0U5BQPT68m+rMTnQ=;
        b=BK9kqvzOV17jowApQUroz/NpSlnl5KNAJ82N64uJGtoGYCXYscqkkKnv6GlnXv9jtC
         OblHE944j6Nayc/XWkMnANWIUT1MolsgBAV51bCfA7ajS043k4UW3L+1WXow9hp9NTLM
         e3PrzUfRx6V260pQ03dcpRlMCsU5/WnWmahVr3M4P5FE81Pt8OUAeK3kWYMNqK+3ucvo
         Om+95vf8WNQ7iPw8jpkr21LX7lZRtyavR6wpgn69uBPqEEJFJBkzRIRLEC34TIQGqgSv
         YhcdoC3XkL8p8ut5aOZRv/73UXUgQFSyzcKYjMd7uXTKkmSk46HdnJwvAT07UywqX8kt
         Zqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450487; x=1709055287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0gLcb+UZQZKvdtR+xNRyRYfChy0U5BQPT68m+rMTnQ=;
        b=gZI8cbEHnIwvylgwFbWQbVV6JA/VMzG+NhAhcZSH6uhuG0JAsbqLZOZfJrFukXvt+6
         xWtcIXsT2uyzFxUkuhUQxB1oZUmhoo01kT1QbjON0SOHLQZuwp6S2H+ozgC6QF9MZrtc
         O1a3hJeWRYQd83piqV4c+wC6zEZz6MXIQUMd0rMadEjaTeVCXxj2lPhjqAGPDhePB4Vr
         IFgtCFE0qgF1q40InAgXhkEWc7+BFgzCTx7ksaJgANunwX38CUiCovHnfCNeDHFc8Yzw
         08WahFfbp74dpAr88SgWHIxP192pWFfviuGA7mxjU845dVTIJggW9msnejbGEJI7c8oZ
         Tg9w==
X-Forwarded-Encrypted: i=1; AJvYcCWbo08YXDL029pOqHUyHNAzhfyySWACkCZMPAgD+DsTJcq+29WNykfoj2ULX5MV11Ea+Axm3N/oGHYg1ihb9op+/xQcZIqbs5IsxUsrpbQuaVoKLLGfensyVdN2ce797AZ3u0vY9ANEBfD32g==
X-Gm-Message-State: AOJu0YzMkZpj7nvsChyrc3M9WP5o1wBLQqC68k88TnGb20/l4KeZ1p12
	fC8U2fn4hMRYgVT6QmVNyZr8kUYvsUx7MBBPJaTyGhobVdVfXDT/PWdjOVnKleY=
X-Google-Smtp-Source: AGHT+IFWZ6D5sKzLckyDo+c4DpeZng9yQSbbwRxo4VXbopwXEM5SxqojmMb0zvmEoniSNOz/L5MSUw==
X-Received: by 2002:a17:902:ab94:b0:1db:d843:7246 with SMTP id f20-20020a170902ab9400b001dbd8437246mr6872177plr.51.1708450487274;
        Tue, 20 Feb 2024 09:34:47 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id jb12-20020a170903258c00b001d9c1d8a401sm6468490plb.191.2024.02.20.09.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:34:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Feb 2024 07:34:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
	hcochran@kernelspring.com, mszeredi@redhat.com, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: correct calculation of cgroup wb's bg_thresh in
 wb_over_bg_thresh
Message-ID: <ZdTitdV_1awPhfkQ@slm.duckdns.org>
References: <20240123183332.876854-1-shikemeng@huaweicloud.com>
 <20240123183332.876854-3-shikemeng@huaweicloud.com>
 <ZbAk8HfnzHoSSFWC@slm.duckdns.org>
 <a747dc7d-f24a-08bd-d969-d3fb35e151b7@huaweicloud.com>
 <ZbgR5-yOn7f5MtcD@slm.duckdns.org>
 <ad794d74-5f58-2fed-5a04-2c50c8594723@huaweicloud.com>
 <ZcUsOb_fyvYr-zZ-@slm.duckdns.org>
 <6505a0c5-5e22-3b25-65f5-2b44e885785d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6505a0c5-5e22-3b25-65f5-2b44e885785d@huaweicloud.com>

Hello,

On Sun, Feb 18, 2024 at 10:35:41AM +0800, Kemeng Shi wrote:
> Hi Tejun, sorry for the late reply as I was on vacation these days.
> I agree that visibility is poor so I have to add some printks to debug.
> Actually, I have added per wb stats to improve the visibility as we
> only have per bdi stats (/sys/kernel/debug/bdi/xxx:x/stats) now. And I
> plan to submit it in a new series.
> I'd like to add a script to improve visibility more but I can't ensure
> the time to do it. I would submit the monitoring script with the per wb
> stats if the time problem does not bother you.

It has had poor visiblity for many many years, I don't think we're in any
hurry.

Thanks.

-- 
tejun

