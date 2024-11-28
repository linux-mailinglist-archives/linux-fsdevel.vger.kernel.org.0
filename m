Return-Path: <linux-fsdevel+bounces-36083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC95B9DB6F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2541BB2157F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60619AD87;
	Thu, 28 Nov 2024 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hn4PkGuT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E361199385
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794902; cv=none; b=CFYPZCub2WEEVQFsn8zuo0VeBb0YlUlmaCnP3wXtKVwua80x9e/xY+Oa7vJOzfZmX0O5w7GabqswwcHl4oA6o1DdW/2SACMFsJckMertwADLJ9EslAKe65XQhNDchNh4FHEN9iigwGKsGEdplgl7dvn0ehYjzMD5qAYucCUlQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794902; c=relaxed/simple;
	bh=7CP4tcqnpE0T5QBZT8Iv6cBPWKj44CCY/hOUNg073eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRJwmjjTOURIbmcw858m7fUh5n+MYcfpKqhHVBE+sEAvbagfRyE3H6SWHX6TkmHWyVzC2Je4GhlKer2BE4VqlaqdVlaxo68NziBGsIkFDH+uZ0gBqBSA7OEYCSVvUvJA2sd5MHO7d0ywicM9lyJAYr9A3je4eXL6UC/05PM+/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hn4PkGuT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ea379ef02fso583556a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 03:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732794901; x=1733399701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGnQ7TfkS/IPmZtgOcK7zVT95hAmGlcDxB/++6PebPk=;
        b=hn4PkGuTZht0p/GIlpU3XD4gJYCY8fk6IUN1FD1WK3h9uYgdPJqVRIlIsnCwlfCajj
         oXB5KKVn86fZcswKKPiPakAo1kcOzNMqs7WCMG6Gq9rqUI51Pf83/t4aoHpCskJRKd8I
         LDDpCHDvgrMysdu4ol38rQl/Ilaay5gQiWcVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732794901; x=1733399701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGnQ7TfkS/IPmZtgOcK7zVT95hAmGlcDxB/++6PebPk=;
        b=HJorA2NXzZPJbTCsX04xpbD1A7TqeeCDNGnGDkeXBii07yUUyg/gNs5FtBV6ViXaRb
         NbXYIn/czX+XlSC0y7C/jtlTbAk23WAZ9Qg3kOiCx/PykVKePbgsoy2E0HijwdIz7ouW
         ed0Pt3ySq/iI7rDpY/ji5DwBvBBo19ie7rGi394MXszasYxNxzByh/4cG25U3ADkm8g7
         zrbPWOMCtsDQyw5l6EX5sJ6Pe7jfw2cEYGhPy/UDCdUe1mdNfsGg4fZTOUq62OIZKGDv
         G/TPgGYaqj5HicHMoZHNPA6AY5pZQEqln20YP7yqnyTL+2LmO035hQBgNVinCuSjnm48
         3uGg==
X-Forwarded-Encrypted: i=1; AJvYcCX7xvm2lfVMJ3QREUOfC4uZayYLLvi/dBWEfe9PXc5sp2FJ+3ili8nUiZHopZuuWGVaXHlkEPBgk5wJ+GHO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xF4DI5Mn8QeSlY+BDNxBUaw7J/em/dsefb4UcUOQu3xvnNC5
	eoW280e4I612k5Iyip/vEmnw3qCZ6oOm1bJL12DXX2l1ffvmFvZ9ZApvjik71A==
X-Gm-Gg: ASbGncubLPe4xzzCoGYKdM5pcgkmKtAyVqVXgvRGF5vyAtQiKvF0LajPiC+AzQ26CwX
	XpeZX3UkHEw6C5YCMFog4D/V2N9BuJuUnavpIhdhLKCIJM+QXefYau02lTGVD9BcDq1BufvNWBc
	ygcSnljJsJ73s90EbKudHWz4dhEWnNgY5J1o9WEFvpY42cy2k1F1u5ONbET9m09IFhwnVO2YdM/
	tpz6ornUX/DuCtD0gKJl+6r1ocqDncu3pq4+B1fbxjf/bHTeYh55Q==
X-Google-Smtp-Source: AGHT+IEYfa7FpYs83fdk8wCP69hIOqqNhAVNRH0clVznVXlTTBmonG5Tuoob4Btwif4YEPc3kpKYCw==
X-Received: by 2002:a17:90b:1dc9:b0:2eb:12b0:e948 with SMTP id 98e67ed59e1d1-2ee08eb2b30mr9271611a91.16.1732794900677;
        Thu, 28 Nov 2024 03:55:00 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e87e:5233:193f:13e1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa47ff0sm3295560a91.15.2024.11.28.03.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 03:55:00 -0800 (PST)
Date: Thu, 28 Nov 2024 20:54:55 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Joanne Koong <joannelkoong@gmail.com>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"laoar.shao@gmail.com" <laoar.shao@gmail.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
Message-ID: <20241128115455.GG10431@google.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com>
 <20241128104437.GB10431@google.com>
 <25e0e716-a4e8-4f72-ad52-29c5d15e1d61@fastmail.fm>
 <20241128110942.GD10431@google.com>
 <8c5d292f-b343-435f-862e-a98910b6a150@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c5d292f-b343-435f-862e-a98910b6a150@ddn.com>

Cc-ing Tomasz

On (24/11/28 11:23), Bernd Schubert wrote:
> > Thanks for the pointers again, Bernd.
> > 
> >> Miklos had asked for to abort the connection in v4
> >> https://lore.kernel.org/all/CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACFdgJJ_b8FdHw@mail.gmail.com/raw
> > 
> > OK, sounds reasonable. I'll try to give the series some testing in the
> > coming days.
> > 
> > // I still would probably prefer "seconds" timeout granularity.
> > // Unless this also has been discussed already and Bernd has a link ;)
> 
> 
> The issue is that is currently iterating through 256 hash lists + 
> pending + bg.
> 
> https://lore.kernel.org/all/CAJnrk1b7bfAWWq_pFP=4XH3ddc_9GtAM2mE7EgWnx2Od+UUUjQ@mail.gmail.com/raw

Oh, I see.

> Personally I would prefer a second list to avoid the check spike and latency
> https://lore.kernel.org/linux-fsdevel/9ba4eaf4-b9f0-483f-90e5-9512aded419e@fastmail.fm/raw

That's good to know.  I like the idea of less CPU usage in general,
our devices a battery powered so everything counts, to some extent.

> What is your opinion about that? I guess android and chromium have an
> interest low latencies and avoiding cpu spikes?

Good question.

Can't speak for android, in chromeos we probably will keep it at 1 minute,
but this is because our DEFAULT_HUNG_TASK_TIMEOUT is larger than that (we
use default value of 120 sec). There are setups that might use lower
values, or even re-define default value, e.g.:

arch/arc/configs/axs101_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
arch/arc/configs/axs103_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
arch/arc/configs/axs103_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
arch/arc/configs/hsdk_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
arch/arc/configs/vdk_hs38_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
arch/arc/configs/vdk_hs38_smp_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
arch/powerpc/configs/mvme5100_defconfig:CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=20

In those cases 1 minute fuse timeout will overshot HUNG_TASK_TIMEOUT
and then the question is whether HUNG_TASK_PANIC is set.

On the other hand, setups that set much lower timeout than
DEFAULT_HUNG_TASK_TIMEOUT=120 will have extra CPU activities regardless,
just because watchdogs will run more often.

Tomasz, any opinions?

