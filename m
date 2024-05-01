Return-Path: <linux-fsdevel+bounces-18444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEFB8B8EEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 19:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36282B20F47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 17:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7447418C1A;
	Wed,  1 May 2024 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsAlGXHL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC018030;
	Wed,  1 May 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583940; cv=none; b=hQ7eXL6KbO/PCBUv8sDNoCJ5m+M9vwYtxgQg8kRdIt4nRQNf11EbvNAvPkHI+cRo0mtAnOaHr3fn7OqZd5b9OSfnNVv2aY2N5nVuZ2kG9osYXhj0wuhoBHUiqa86MuQ8pqUwAQdjiL6mX77SzHBWSq4UbopiybiilRDwU+ZTRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583940; c=relaxed/simple;
	bh=A4CNBvfCgBvtTve4c3x3JmtcP/T/LBzmR3wc5V/73Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0TZT5c++uWrF2uIm/44WOcfnFbE6IkiYApm+f8WRsUPX7iym+v7mEoY9cOr4OVuFib2kgq0DMzmYHCMzv8t2nzdtCSgWmiKPmzq6npgDMcbcUNH/k61nJejSaoDRkts8Ue4yD4VbUaNOMTcNG6BBrmOIgWatV1fLrVb+L+Y6d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsAlGXHL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ac9b225a91so5419694a91.2;
        Wed, 01 May 2024 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714583939; x=1715188739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m07c5Fi/jiQW9GTxIy2Gh/ikvj0HKOu2QlszwrphLI0=;
        b=XsAlGXHLlD0V/32kJDh2a7CBY8CnkinUAKJvM+jkq6QTy9mQk24Ia2XF3liyIAyPEt
         kQ36w3XHJCn7Urvib/ys3WO7jgpletvo3ezoy6Wnql+8YVxZZxYm5IXgpvDK/Eo2ZGhP
         a6wCU+vZNr3gqGcGZeBpDJgKiMOhqB6l3wdGwle1tADGdDNLlRQaCVBiTyrbMCih6048
         dag1k9SaJc/Mp1ETFUI0y9YNRlccl/2x+MnTgsL08mV6/XOfXxNEPTl+wpkZC+fTGdbV
         +Yw2MvabHEFAF8/Nybt06/0yV7I0Hzo3ZmqukWgE8nlhy0ArhmeSrPN75LBm2w1mpTU3
         Japg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714583939; x=1715188739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m07c5Fi/jiQW9GTxIy2Gh/ikvj0HKOu2QlszwrphLI0=;
        b=VRNIwpRNCFEyjEJvHS/7TQ0d5qlg8AAE9WgE55V1Q606pReLYcUs2ZpFm8ugxoa6yP
         FF1JILxSx+D2X/WfFtYhE2vy1YijpnjL+bVhf0FZL/5GV3Rjn4G4e7zLIJAgHx0oskyE
         3WIiZVmQrhU5d5cdjuzqGiS7hG0ZHwgUJANV2shhLBdOr2ilIqVBAjA733ktix2RrwhU
         Mh9NafgcuoZBUGsUafS+reSrhtF1tvzhtjPMEYho0oiyzXOxAZ78OsPFKdRgJtlThg6C
         E0JrVysFwVG2NhpGUF/6pvafB468InHcvwbH+gePDm7fre62+i9rEo8rkJs5xQkTXuSz
         +kOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp8i/QcIdxGHaNs0ZeYFk4pzFobfThGrB7FqjMh0YB31dpOgDz860gSkwYkuhTxcZnIJ71mVZRFTD0gzlQw/AJVUai7lH9wYLJ0mKOaV8U7oytkKhPWa4rv8PtFQTRneD+RrubCtac6vVPnw==
X-Gm-Message-State: AOJu0Ywn0pX9N4mMDz9ftrs19sGJjaJ7uDylq4r0N9hvlUgSCUur4qOZ
	akXVw1d1k87lzlxYta/or1x6aWbBSzetRrWv33qBqNBhbn2/yh/y
X-Google-Smtp-Source: AGHT+IEM3V8NcvdrAmWIJZjePi+DWealRmXF6lmrLSb3GFNx1agPl7w6QxPM1Kw8esx4uAxxYweJOw==
X-Received: by 2002:a17:90b:602:b0:2b1:535f:c3dc with SMTP id gb2-20020a17090b060200b002b1535fc3dcmr3293351pjb.26.1714583938764;
        Wed, 01 May 2024 10:18:58 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090aac0900b002ad059491f6sm1572839pjq.5.2024.05.01.10.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:18:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 1 May 2024 07:18:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] writeback: factor out wb_dirty_freerun to remove
 more repeated freerun code
Message-ID: <ZjJ5gfIXBmpKMj9c@slm.duckdns.org>
References: <20240429034738.138609-1-shikemeng@huaweicloud.com>
 <20240429034738.138609-8-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429034738.138609-8-shikemeng@huaweicloud.com>

On Mon, Apr 29, 2024 at 11:47:35AM +0800, Kemeng Shi wrote:
...
> +static void wb_dirty_freerun(struct dirty_throttle_control *dtc,
> +			     bool strictlimit)
> +{
...
> +	/*
> +	 * LOCAL_THROTTLE tasks must not be throttled when below the per-wb
> +	 * freerun ceiling.
> +	 */
> +	if (!(current->flags & PF_LOCAL_THROTTLE))
> +		return;

Shouldn't this set free_run to true?

Also, wouldn't it be better if these functions return bool instead of
recording the result in dtc->freerun?

Thanks.

-- 
tejun

