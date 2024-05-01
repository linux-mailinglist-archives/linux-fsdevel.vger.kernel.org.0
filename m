Return-Path: <linux-fsdevel+bounces-18400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440A08B85B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 08:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FF81C22063
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B224D13B;
	Wed,  1 May 2024 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="JWy6cbG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50243AAB
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 May 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546280; cv=none; b=Z1Rw5ywlbR7zoMS9VyZbSxmRaUrAH93qZqDxjULaahzuDFjhE2G8ULmU7b95hmMRSan5aPJeATAR9Pq/0mH9HuaMEQPJPcATF1MuluExgA7OhwRb4uoaIX6S+s4s3RgboXPVfmWEnwiFIiVwhKFFPJyEzp69ZAvu3HTZ9ZNWym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546280; c=relaxed/simple;
	bh=JHfTGE6XFrijEkQaAb+wvtESU483miAAM5IVbgbcahQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjWlc3/kSin0J0yri3kIQC6Y7hBCWtbd7q01G4FZP5Q2p3oSnR1cZWNXn37pzXdRrEUnS4ssSTff5iGWkojN5nqao9rHzz6NRnqdP1br6DkPMZcgNr9722eYbumlwUofqaj332yvKCm3HHti2laVePepC9cz00RG5Hz0c1tPOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=JWy6cbG+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso43148355ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 23:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714546279; x=1715151079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNZLyG6u4xUG/H7FZmJcRs0vrAIcDKlQHLf7CLLPwDA=;
        b=JWy6cbG+1d0schy6VblnRV1b8O4/WRVEMZHSY9TLj4GUzMQmgIV51zl+D+cwb/04Vt
         mWoruIvdADMNphspxbztAELyMdqn/4muC18D7P/YRyOJkj6DmEPgeeh8ROIuP7Sm1g3B
         aEh6VWgMYzV+6PFI7UBTVuJnUzr5KV0+FZ3MAcYiZMBfVM+fEPqcxo37vtRq2b6zEMx/
         IoxJqhGmORhFLrb3Stl22h5LimBfRQRbcCpR70eBJHh1YLlC8XYmIP/7BCTO+FEtFfFN
         zB9psiBUymZXoTGmtATB9191oPfWTlPT3hrjTKNUwMXZhKvKqPzmOS8yYwuK1xFRvuyp
         MzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714546279; x=1715151079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNZLyG6u4xUG/H7FZmJcRs0vrAIcDKlQHLf7CLLPwDA=;
        b=QoD2NLAtfgktThVNffjTi/1CcGnsDC5kgcdtfJmUEOwi85uNgCVGN1auc0D+Zl84JI
         rvK2RQOJSS6SvPYDmYEZvc0dSUWgpRQ92b6meTvIQ+ECfxxClpGv+dQyL4g6FS8pgByY
         0O7dDdZJX6IS5FOH3aGlpUZCY90lumgl6s1LuU+9nI5Pc9Wv5FApHY8R4ff0hr9RyaYO
         4tafrQc5czz+f6uKFqn1/h/OB6rFoyjTZxyTTVB5LglIOlwtEYK1Fzm+bxwvF0ZEbO5M
         Rc50N5asRMkeH3riTjpZCUChDpaLnqbaa9wSBv7sV8kKwKMCex7MmuxHXeRALPy9bTim
         oEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXog3qnDDfAfmMunpln5ogshA3jBHIxbwvY0xtBHOI/IaJ4F6uYc6OYuelfaTV07c4SS0i7xFRszg66SnNnQaaXciJM+K6dUm7EH5cdaw==
X-Gm-Message-State: AOJu0YwmYRFmkodghmhgu9nMvPWU5PnGkX/zwTVSv5a8djKyEMP1xqiT
	sPV+IcpKCYgSVRqNiKvYpbzPxJ9m3GRO7Oc2OWTdCbzdIjMNdtMH4TeIS0q/Ils=
X-Google-Smtp-Source: AGHT+IG2Z/wySqd1NJnCFct2EGwo2kzRUh5XmAZi5hWfxL0w1v8Ms72FMH2GUKU/yvqUwnEtxfxs8g==
X-Received: by 2002:a17:902:bb17:b0:1e2:bf94:487 with SMTP id im23-20020a170902bb1700b001e2bf940487mr1480759plb.57.1714546278723;
        Tue, 30 Apr 2024 23:51:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id mi7-20020a170902fcc700b001e2c1740264sm23528976plb.252.2024.04.30.23.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 23:51:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s23oB-00H5CZ-1A;
	Wed, 01 May 2024 16:51:15 +1000
Date: Wed, 1 May 2024 16:51:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, willy@infradead.org,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before
 inserting delalloc block
Message-ID: <ZjHmY6RoE3ILnsMv@dread.disaster.area>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410142948.2817554-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410142948.2817554-3-yi.zhang@huaweicloud.com>

On Wed, Apr 10, 2024 at 10:29:16PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now we lookup extent status entry without holding the i_data_sem before
> inserting delalloc block, it works fine in buffered write path and
> because it holds i_rwsem and folio lock, and the mmap path holds folio
> lock, so the found extent locklessly couldn't be modified concurrently.
> But it could be raced by fallocate since it allocate block whitout
> holding i_rwsem and folio lock.
> 
> ext4_page_mkwrite()             ext4_fallocate()
>  block_page_mkwrite()
>   ext4_da_map_blocks()
>    //find hole in extent status tree
>                                  ext4_alloc_file_blocks()
>                                   ext4_map_blocks()
>                                    //allocate block and unwritten extent
>    ext4_insert_delayed_block()
>     ext4_da_reserve_space()
>      //reserve one more block
>     ext4_es_insert_delayed_block()
>      //drop unwritten extent and add delayed extent by mistake

Shouldn't this be serialised by the file invalidation lock?  Hole
punching via fallocate must do this to avoid data use-after-free
bugs w.r.t racing page faults and all the other fallocate ops need
to serialise page faults to avoid page cache level data corruption.
Yet here we see a problem resulting from a fallocate operation
racing with a page fault....

Ah, I see that the invalidation lock is only picked up deep inside
ext4_punch_hole(), ext4_collapse_range(), ext4_insert_range() and
ext4_zero_range(). They all do the same flush, lock, and dio wait
preamble but each do it just a little bit differently. The allocation path does
it just a little bit differently again and does not take the
invalidate lock...

Perhaps the ext4 fallocate code should be factored so that all the
fallocate operations run the same flush, lock and wait code rather
than having 5 slightly different copies of the same code?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

