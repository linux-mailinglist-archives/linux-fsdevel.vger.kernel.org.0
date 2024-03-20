Return-Path: <linux-fsdevel+bounces-14902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0112881404
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 16:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEBE285642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422704E1D5;
	Wed, 20 Mar 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXbVLRDZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ADF4AEC4;
	Wed, 20 Mar 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946886; cv=none; b=q9VMNzBZIuOmTi/Dj9wv5KiylqAqAunWRWocJ0MltnG2/W8P3C0ztyX1B0NvUpY9eoiFTZFW/P4LhgP0akmZp+RR/Zu4EUmUPe+HgERTjp9CTwUIRzHGhP0Od4RzAFcfCUW7CE2imi5IGXMvo4WGLoLdQa9M9UX2Eq5JtkkSFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946886; c=relaxed/simple;
	bh=RS6nQPu6ivw0T2tEdz2+PiDwOI6gLgItPD74FlJCCqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D02aLyxPw0yb24zNEcjQgWM9MuuhbZFELLBgrx5Xvj5X1YGnnDvN0v+Z16MEc8+lpvIDx/muaJQ4yMGVDpOZ11kZCg3Vcutcn2L8k9x6gE4CwBPBVQqLcQp/xfs7zpKSJSs0oBn+OTaz8IBnQBX77bCvTkycE/nBaIc2oYrF4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXbVLRDZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60a434ea806so74578287b3.3;
        Wed, 20 Mar 2024 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710946883; x=1711551683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/Y9ZMfO3J09Mar43NYCGm0KZxucij/o5mhyh/HvBdM=;
        b=gXbVLRDZy35Kwr9UihSjbFsh6dOrbA8ATOhfJF7l0FwG15r70FWfAsErFVck0YBpQO
         5RjF3WXWLWacGwdPIqtg6Ryq88G5SP8KXJAQJT5fL6Dd8+5z3zD070viil2Y+2Djjyip
         /vGDKeLRfU0ihRjnDpqELo8NwZ166kNZmORu4YGFpvqZwN8A6+63uvHuNWRfqz/igZfj
         mtkpKw9PCW3Ulh34YxZYhOhZl8pVON+D/1JVGaNFFyjpix8y9kEnmWEJ9M0KvysW60oq
         eYiZr9f2uZapwSpMNrhLW6YLccJlP2Zp4qPTWpvEGy72uYDLYJntg9N3/WOhHCbpEoDR
         Jhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710946883; x=1711551683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/Y9ZMfO3J09Mar43NYCGm0KZxucij/o5mhyh/HvBdM=;
        b=QSVHhIxJKsZMZr2cqhu11FHxhPWLBoVYoFZYNdOJ6DppM5psa20BkdRHzxNAdJJwzL
         1a+CRh471Eul/HEoxW9wYRp1SC47bScyvDzb+kZjaHLEH+6E5xiLf7lDKayWGigAlhs6
         /ZUQKJg+UtPhd19gOJWdi6o3jO1ZCQFWemX7gPb4AewQzEtOr6u2CoSdGbm/4r7v9tm4
         xS3QIwTu/YdIzrdKifmCZkvlevqmQyvr7wXbZ6VB5cjSZujCIVHccvk0Qqj8JPtCguJE
         4SPg3awPbTWACM905m/4INKiAgTZ0mvJddtxg/jq3Gmp6y6ZNFzjr79K10OLFN+AAqL7
         6keA==
X-Forwarded-Encrypted: i=1; AJvYcCUcd9RZ6bl4TtaamXNcsuAwnW4zQFvHMmecxJgV9vHPoFhSu7oFJi9cRESpn+GFkaeH6bDMRG4+nRXrB8ruYU3jm+8R0++Uyi7zveVwXgn5MmOGH9zBiAoRdck5+Q3eZciTAU/yqCq6BJTg+w==
X-Gm-Message-State: AOJu0YwukRxnSe2WPLDiV+lyvW3iwqNQSLgwRCP0liJC1Fn1GNt2N+He
	SxQeXOLc+r+Vw+gfwAz6qCAymi4Hq3ZMm2+7E0MaFfAMdFa7PK/y
X-Google-Smtp-Source: AGHT+IHjPaOvJ970QixGpEF5AV6WMUBFUeINTSBQuqjCg3fk6IZAip/bPRH6Cjfjbe/vjM8AEiymzg==
X-Received: by 2002:a81:8446:0:b0:60a:3020:29f2 with SMTP id u67-20020a818446000000b0060a302029f2mr17584014ywf.11.1710946883200;
        Wed, 20 Mar 2024 08:01:23 -0700 (PDT)
Received: from localhost ([2600:1700:2ec0:58c0::44])
        by smtp.gmail.com with ESMTPSA id l23-20020a81ad17000000b00608aeba302dsm2841301ywh.14.2024.03.20.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 08:01:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 20 Mar 2024 08:01:21 -0700
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, bfoster@redhat.com, jack@suse.cz,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 2/6] writeback: support retrieving per group debug
 writeback stats of bdi
Message-ID: <Zfr6QV-2IWD6yCI1@mtj.duckdns.org>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320110222.6564-3-shikemeng@huaweicloud.com>

On Wed, Mar 20, 2024 at 07:02:18PM +0800, Kemeng Shi wrote:
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 9845cb62e40b..bb1ce1123b52 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -355,6 +355,7 @@ int dirtytime_interval_handler(struct ctl_table *table, int write,
>  
>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
>  unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
> +unsigned long wb_calc_cg_thresh(struct bdi_writeback *wb);

Would cgwb_calc_thresh() be an easier name?

Thanks.

-- 
tejun

