Return-Path: <linux-fsdevel+bounces-25868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9C09512B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2541C228CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0A32C6BD;
	Wed, 14 Aug 2024 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YFWlQEIl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD3374FA
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723603628; cv=none; b=MiYWWI7nZa/BW9q3NrvyccQvFwcBwDbHvsSgvXul99/27ahNLQsfMeJ4PBPEjM5kh8pSCgf/Sl04nl8CAGMaAx6ztuA6TzUKIk7UC6dfRhB1aqQpT3c+6WxWAMfuGIxaVm9atWEkuUp9BHH/y+DWKA7sbyan8n6ramadYTsFnLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723603628; c=relaxed/simple;
	bh=+XSQP6JjRisu6j+WPBg6o/c6mx52smfB/O54cIEbdwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQT/xwD61xKc91Nv1agM0b2+2W+O0GnlJH3hKKMwvt7ujWVXViaWWR+Z+GB/MlJisoWzeb/EJ+lm0XdCOqRuHB+9+6xl5tJKtlNcZaJ0VL5+wNBfRPbK3fmtDOrHq+Dpl1R4hBycGzQbIVUyxs0PuPSotThSOLIvJnBwUc2RfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YFWlQEIl; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c68b71ada4so1634937a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 19:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723603626; x=1724208426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HndCF9glIkOMUvWq/mEOxgU2lZeOnPtNB9Xnwe55q3I=;
        b=YFWlQEIlPEvEWs0LdGfHHM4fN5ynFFJBk8v1jaZnuX5K5gT2mZtwj+CV34rQ8lFYT8
         pJ4JDvB2JuYI0ogyER/u/NmiAtvWNiV+K0q490ReT5TPyxyCBkPVTDvGUKMNwW+003fe
         Nxyfr5Q6PqhRG3aAFoad11jOWKeG1fIEhYP8R8zKo6fKVPSb1Ftx8ifk1yifQkhRFnuV
         oMIqlKymMo2xs6W1LeLV0pjKMsWZSc7fxCETKBsTFO/gnxyV7MtZsW52zIL2NeMnxv7G
         0/A84dxRf50jgYW1VF6ZdGKNQhXqJNFNxl2g92SLH8kcnmeMDZUxNa0OqJT61M0R9Se2
         H94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723603626; x=1724208426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HndCF9glIkOMUvWq/mEOxgU2lZeOnPtNB9Xnwe55q3I=;
        b=rFPBB4hVX91YeVC2Ly/53aFuX5zwOSaxP0iyLsTXhp00j/GlKwYd58edPZfgWwrAo6
         w99OawgE4E761ZeVDfWSfsHmIxxv39DdNb6ZiQFv3yDYc5WCjl5efEIJ4Elu6H8/Sv/H
         uYxSIQRBLLVoc8ilK/g74ScmiJIGxKoj0fKETV5SW2SAYAzc+TPmNraBTBL7ewfVTRxh
         oxxkTEwG6A92PKFIfR2j4ZuYIFR7bPtHDLCrN1TDuNAaqrvBCsIgh+xz3EaUudnbTkE+
         cn7bgeoJKoBqOXk5yT4nH/asf5wYeecIdpsIfntXJ0TCffeWbfjMm+CBseeMzLIKEeAc
         08pQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7zzXiREFSroZlISDlyXPEfsYJR2Kma+cobDaoYKafcbhOfL3xLlDz5qFcFH0HrXAYAPaCvEguDOEsckR+bOsjCOS+QdjgY6mqKTjZ4g==
X-Gm-Message-State: AOJu0Yz22jsqy/K2dq+COCCCNtJaB4kQotuYR4CmqmAy/BirdZjOLjob
	Xji+l8cSdQKtHYotpzGxEut90h9a9pCRf1PQ05qcbrzfDtzpTTM++soxOhHKB5U=
X-Google-Smtp-Source: AGHT+IHp+5SEOXnqyHBJUu8nZh2c1nW001BOSSG1PaVG7oaO5Q+f5qABUl3n1SRexvQ5+uArfDwtLA==
X-Received: by 2002:a05:6a21:3a81:b0:1c6:f043:693f with SMTP id adf61e73a8af0-1c8eae6f47dmr1952825637.17.1723603625970;
        Tue, 13 Aug 2024 19:47:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14de23sm20058735ad.104.2024.08.13.19.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 19:47:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1se42R-00GJdn-1E;
	Wed, 14 Aug 2024 12:47:03 +1000
Date: Wed, 14 Aug 2024 12:47:03 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, jack@suse.cz, willy@infradead.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 0/6] iomap: some minor non-critical fixes and
 improvements when block size < folio size
Message-ID: <Zrwap10baOW8XeIv@dread.disaster.area>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <ZrwNG9ftNaV4AJDd@dread.disaster.area>
 <feead66e-5b83-7e54-1164-c7c61e78e7be@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feead66e-5b83-7e54-1164-c7c61e78e7be@huaweicloud.com>

On Wed, Aug 14, 2024 at 10:14:01AM +0800, Zhang Yi wrote:
> On 2024/8/14 9:49, Dave Chinner wrote:
> > important to know if the changes made actually provided the benefit
> > we expected them to make....
> > 
> > i.e. this is the sort of table of results I'd like to see provided:
> > 
> > platform	base		v1		v2
> > x86		524708.0	569218.0	????
> > arm64		801965.0	871605.0	????
> > 
> 
>  platform	base		v1		v2
>  x86		524708.0	571315.0 	569218.0
>  arm64	801965.0	876077.0	871605.0

So avoiding the lock cycle in iomap_write_begin() (in patch 5) in
this partial block write workload made no difference to performance
at all, and removing a lock cycle in iomap_write_end provided all
that gain?

Is this an overwrite workload or a file extending workload? The
result implies that iomap_block_needs_zeroing() is returning false,
hence it's an overwrite workload and it's reading partial blocks
from disk. i.e. it is doing synchronous RMW cycles from the ramdisk
and so still calling the uptodate bitmap update function rather than
hitting the zeroing case and skipping it.

Hence I'm just trying to understand what the test is doing because
that tells me what the result should be...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

