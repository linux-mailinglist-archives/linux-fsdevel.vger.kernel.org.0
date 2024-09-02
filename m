Return-Path: <linux-fsdevel+bounces-28213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4AF96816B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 10:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B299282AEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778A8185957;
	Mon,  2 Sep 2024 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RqOVgxdh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C20181310
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264708; cv=none; b=ST8kTTyIJBI41C0RwiGDPjVpdBKdycyda7ojpZADt+nIxWHj2y409KeDF2PXoD6HVcLQO0U/sYQno8m6kp9cJEeRSn2luJpN1Gsj++IfnRNv55LBRgv2eA5VvfHUMraI8NRNJs/YTo8drHEV0momtF1vkxOaprxnf3MYkZOvXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264708; c=relaxed/simple;
	bh=9zZ42yNwHBqjx5DZimYOFUIHAV4oLkD/Ak5BIcgnj98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcVo4AjYFbUPFj/W+i0mV8lxl9tjr4zbLsuixSdvfaC6XVtgcVVEmUu6C+5NizQSecMzrSfwkYOw3cnUUdonXHUYhP4rLAOV9pUEGT/5Qw2Qsn//aaZcv9uX+rDuGcAus/5C1aVvQZlviC/pX7ELz6tkSnxWO441OuxdaBoSC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RqOVgxdh; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso40704591fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Sep 2024 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725264705; x=1725869505; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NGvD+BjgTTmOW/uciXFa90rfCMl9ykoBAkblULS1a0A=;
        b=RqOVgxdh8IBnyu/kfCdbZyNIQyj/hg25r0dVolXB1ewKTwnf+yHgBmdoe4pCHGCZEh
         b1Uj91cYv0xc8n5+dlk/r9WMmdrcVbPsg4/E4DMtv3IQV4xs8AC3UgNPR7QHiSZwEFLf
         XcMGlXTCmUZO68OGMQ8g8v+2Ti0F5WcTQvLV8BegPU1Xnc3IpYioU0vQsE5XE9273k/4
         M6fFobxJyR+8G/0SNqOYY0z6BwG0+zDkTZpjjKJpHbOw88DCDFDGBhe92wkX1TQ/TCu+
         6bqKRrkYi4DUeOPmg6v/Ii+IBpGZpR1ncoKLi0pYa44E7Aehdf1K26HI23wurgcBOD49
         JwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725264705; x=1725869505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGvD+BjgTTmOW/uciXFa90rfCMl9ykoBAkblULS1a0A=;
        b=MKh+Hc/BRetUOsl814y2Z6rc3n7MQ+pUAFJC/43P/Un8uxRVU3Y64ZeoUQnbUTrBh3
         3Fe0s+9AVXw6UvXe2JqYdcd2hlKfrKPvr3DeQ/lEliUpUj1wJp4q8Nyqu8SMGhJ8tVPS
         fMPtUHAFXp0D/4ABplX+NcMkSU4u3kAeiH//BhPE4qhTJP9gix8a2jTGf4oJudryrdZV
         QK1rXJsxbRfvXVidFY4D/4cTivvhs99wr4PTROAzWgvncu58lq7ZLNZZn88gkiXLSm/q
         r2qQ4n6HElfQ159d2pZCygAFxGUiP4iuBhR00J8vEBfPxmKx/2ZdrLv9EkvojmEuDi4+
         SnoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4VgunfWrK7JoGwalc7Vcqm0dmKz5lZi5e5QosW4IiWSQw247vA5ryKhO4TWGvmsm2k2+0hO3W+tjlwUJa@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpDOvPqTtjYAcKcwI6tkfhE/OBPMQ7ioLUWjm0yKinlOg0Ii/
	5j17JiPx+rDLCVw5Jcx+SYU3KKfTYZcObC7ZJYIbEw9+l/fpAUdokAZcIBG+BXU=
X-Google-Smtp-Source: AGHT+IEYuCcPm4Oa5/lRr8JA2e8+k/oUcobDB31K+uGnsFShL4OmLoxo2s2kxDZjerkPq2Xa0E+SZQ==
X-Received: by 2002:a2e:f12:0:b0:2f3:f8d7:d556 with SMTP id 38308e7fff4ca-2f6105cd99emr71774921fa.18.1725264704821;
        Mon, 02 Sep 2024 01:11:44 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c250edd2e3sm1832543a12.27.2024.09.02.01.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:11:44 -0700 (PDT)
Date: Mon, 2 Sep 2024 10:11:43 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <ZtVzP2wfQoJrBXjF@tiehlicka>
References: <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka>
 <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area>
 <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
 <ZtPhAdqZgq6s4zmk@dread.disaster.area>
 <CALOAHbBEF=i7e+Zet-L3vEyQRcwmOn7b6vmut0-ae8_DQipOAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBEF=i7e+Zet-L3vEyQRcwmOn7b6vmut0-ae8_DQipOAw@mail.gmail.com>

On Mon 02-09-24 11:02:50, Yafang Shao wrote:
> On Sun, Sep 1, 2024 at 11:35 AM Dave Chinner <david@fromorbit.com> wrote:
[...]
> > AIUI, the memory allocation looping has back-offs already built in
> > to it when memory reserves are exhausted and/or reclaim is
> > congested.
> >
> > e.g:
> >
> > get_page_from_freelist()
> >   (zone below watermark)
> >   node_reclaim()
> >     __node_reclaim()
> >       shrink_node()
> >         reclaim_throttle()
> 
> It applies to all kinds of allocations.
> 
> >
> > And the call to recalim_throttle() will do the equivalent of
> > memalloc_retry_wait() (a 2ms sleep).
> 
> I'm wondering if we should take special action for __GFP_NOFAIL, as
> currently, it only results in an endless loop with no intervention.

If the memory allocator/reclaim is trashing on couple of remaining pages
that are easy to drop and reallocated again then the same endless loop
is de-facto the behavior for _all_ non-costly allocations. All of them
will loop. This is not really great but so far we haven't really
developed a reliable thrashing detection that would suit all potential
workloads. There are some that simply benefit from work not being lost
even if the cost is a severe performance penalty. A general conclusion
has been that workloads which would rather see OOM killer triggering
early should implement that policy in the userspace. We have PSI,
refault counters and other tools that could be used to detect
pathological patterns and trigger workload specific action.

I really do not see why GFP_NOFAIL should be any special in this
specific case. 
-- 
Michal Hocko
SUSE Labs

