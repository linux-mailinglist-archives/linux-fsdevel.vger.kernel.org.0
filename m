Return-Path: <linux-fsdevel+bounces-34412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD79C5115
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996041F21F6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 08:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BF020B7FC;
	Tue, 12 Nov 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjspjfIe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AF1AA788;
	Tue, 12 Nov 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401146; cv=none; b=KpB58swrNmyL8866Cx6Cr2hlg5sGUanzj4fvhuN3n3AnrQ2V1j4P7ExVN1kq6b53aKjRDsHlpt3XcSU034GMSU6n53Akvx+M5ziriIPeVhACliGcv0JTXNFgQLb6rwSoqJNfjpkeZYbtENrYE3hVbmja2ZuIOJh09NDaqAI0Gyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401146; c=relaxed/simple;
	bh=Pj0QzxQ7ODfh7/HrYJ9yLIVM92RhdQGUOPxeusozQTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9D6IlPgxOhnywlbY7kfIiA5sBsD6H9pY+EadiYvSE66ilimy8/BL7xw//Ot6vpHcCikRRqWFBJpvlJGbhXsla9t/Z6aDT87yKsEeek5vinv7RSPPIzLlBHCadpo2hlPYG58N4idWT+5CRCiTmH3nVkp6OC0WJOzxyPK0qZBtd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjspjfIe; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2118dfe6042so21440185ad.2;
        Tue, 12 Nov 2024 00:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731401144; x=1732005944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrT6bEUv9tRHMW8wYiNkeYHJqAClE8kFBlBgkdpORpM=;
        b=cjspjfIe1mFvSxDgR+axhfE1v7YsNgg/zDMDnYc9frNgEK2xyWtsQf/nfxflLCb0yt
         HTxzIObteSTm5xIOUENSIvyU755x/sTgcQ5Pb9sNYnyUPNvi+tH4QjEDoRM7Tg/tfWdC
         J5gwHiwPEzWFjN6gPLMxnpdbV1r6rSwyw36vNqTJlbkXse5pcUE7tMdDpUjWuWL2+4Wt
         WKc30P8aN5bDw1r6zCHrzvcJSLPxqvXHGhjsfVDDQeboD8CaAbdcywpbmrmSTeWlmpmd
         RczpLo+e1Q6NXS3b+x1xDstikcnZiIxo9v3KmTDATg9WlzZcUXh2J/5PAVyc4TqbAy+Y
         fg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731401144; x=1732005944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrT6bEUv9tRHMW8wYiNkeYHJqAClE8kFBlBgkdpORpM=;
        b=bqYS56WQ83WoZofHjNNAUehgaPj8TkSQ2zEcUHIxf0xGGZJ315ZxJpKid3shIZBQLR
         puevzM0im/kF8Ul1ZKfdJKJTPCReVBImgjtnnUQ1DyEQoKfomFLjzs+F69MbgKUd3BTj
         BwBTsCFriZjSTtaHTy0fYKX/d7n5bcJrVLMSHw67kWYCCVBylciHXsSCGwAf2aAUCIp0
         MHzmTga3BOJHFTzmcpX+qIVojAX/4gtx8grwzOr/PkdFU//Gcbzz33hzD6MrzqqqqGN/
         13UaEKTUHXDPO8lpTfZCxMW1NdC4rLsebwyQMzucMUgSSs4AqJr7/b+di4shr0x0A/Wc
         iPTA==
X-Forwarded-Encrypted: i=1; AJvYcCUFxVX+GdwLnqnLQo7hIUW4yYkqSOH5VmVtvy0yzzAdrRj/cI+9aFFDIb5Ujh5V+8vGpinI8b1E7/eA06Qq@vger.kernel.org, AJvYcCUtkoIYR9F3cM7ahf7zyh/j2yjvqG/J3BOQE0X9TbHrfFg8+1dR8S7MKFyGoZTcgQWYsQqP3+IdAgMVElpX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3GbnVvNlo0/CyM2vQpmuGcMGrKXCYuTqCgiZCU5hEfKf6w291
	y7dc4QzFnt6x3KLHunHdWgjd1l5hH+hviIYAfem+lfZpWRle2gTe
X-Google-Smtp-Source: AGHT+IGmlb5e7j0vU8rSA9tjuwhueLznhTs8RfmcM3t8vqUuD3i56XzMImlSugBikE9WV2jX0LlEEA==
X-Received: by 2002:a17:903:228b:b0:20c:5533:36da with SMTP id d9443c01a7336-211ab9ccf30mr23782535ad.42.1731401143640;
        Tue, 12 Nov 2024 00:45:43 -0800 (PST)
Received: from localhost.localdomain ([43.154.34.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a62bd39sm11906542a91.48.2024.11.12.00.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:45:43 -0800 (PST)
From: Jim Zhao <jimzhao.ai@gmail.com>
To: jack@suse.cz
Cc: akpm@linux-foundation.org,
	jimzhao.ai@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH] mm/page-writeback: Raise wb_thresh to prevent write blocking with strictlimit
Date: Tue, 12 Nov 2024 16:45:39 +0800
Message-Id: <20241112084539.702485-1-jimzhao.ai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108220215.s27rziym6mn5nzv4@quack3>
References: <20241108220215.s27rziym6mn5nzv4@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On Fri 08-11-24 11:19:49, Jim Zhao wrote:
> > > On Wed 23-10-24 18:00:32, Jim Zhao wrote:
> > > > With the strictlimit flag, wb_thresh acts as a hard limit in
> > > > balance_dirty_pages() and wb_position_ratio(). When device write
> > > > operations are inactive, wb_thresh can drop to 0, causing writes to
> > > > be blocked. The issue occasionally occurs in fuse fs, particularly
> > > > with network backends, the write thread is blocked frequently during
> > > > a period. To address it, this patch raises the minimum wb_thresh to a
> > > > controllable level, similar to the non-strictlimit case.
> > > >
> > > > Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
> > >
> > > ...
> > >
> > > > +       /*
> > > > +        * With strictlimit flag, the wb_thresh is treated as
> > > > +        * a hard limit in balance_dirty_pages() and wb_position_ratio().
> > > > +        * It's possible that wb_thresh is close to zero, not because
> > > > +        * the device is slow, but because it has been inactive.
> > > > +        * To prevent occasional writes from being blocked, we raise wb_thresh.
> > > > +        */
> > > > +       if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
> > > > +               unsigned long limit = hard_dirty_limit(dom, dtc->thresh);
> > > > +               u64 wb_scale_thresh = 0;
> > > > +
> > > > +               if (limit > dtc->dirty)
> > > > +                       wb_scale_thresh = (limit - dtc->dirty) / 100;
> > > > +               wb_thresh = max(wb_thresh, min(wb_scale_thresh, wb_max_thresh / 4));
> > > > +       }
> > >
> > > What you propose makes sense in principle although I'd say this is mostly a
> > > userspace setup issue - with strictlimit enabled, you're kind of expected
> > > to set min_ratio exactly if you want to avoid these startup issues. But I
> > > tend to agree that we can provide a bit of a slack for a bdi without
> > > min_ratio configured to ramp up.
> > >
> > > But I'd rather pick the logic like:
> > >
> > >   /*
> > >    * If bdi does not have min_ratio configured and it was inactive,
> > >    * bump its min_ratio to 0.1% to provide it some room to ramp up.
> > >    */
> > >   if (!wb_min_ratio && !numerator)
> > >           wb_min_ratio = min(BDI_RATIO_SCALE / 10, wb_max_ratio / 2);
> > >
> > > That would seem like a bit more systematic way than the formula you propose
> > > above...
> >
> > Thanks for the advice.
> > Here's the explanation of the formula:
> > 1. when writes are small and intermittent，wb_thresh can approach 0, not
> > just 0, making the numerator value difficult to verify.
>
> I see, ok.
>
> > 2. The ramp-up margin, whether 0.1% or another value, needs
> > consideration.
> > I based this on the logic of wb_position_ratio in the non-strictlimit
> > scenario: wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8); It seems
> > provides more room and ensures ramping up within a controllable range.
>
> I see, thanks for explanation. So I was thinking how to make the code more
> consistent instead of adding another special constant and workaround. What
> I'd suggest is:
>
> 1) There's already code that's supposed to handle ramping up with
> strictlimit in wb_update_dirty_ratelimit():
>
>         /*
>          * For strictlimit case, calculations above were based on wb counters
>          * and limits (starting from pos_ratio = wb_position_ratio() and up to
>          * balanced_dirty_ratelimit = task_ratelimit * write_bw / dirty_rate).
>          * Hence, to calculate "step" properly, we have to use wb_dirty as
>          * "dirty" and wb_setpoint as "setpoint".
>          *
>          * We rampup dirty_ratelimit forcibly if wb_dirty is low because
>          * it's possible that wb_thresh is close to zero due to inactivity
>          * of backing device.
>          */
>         if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
>                 dirty = dtc->wb_dirty;
>                 if (dtc->wb_dirty < 8)
>                         setpoint = dtc->wb_dirty + 1;
>                 else
>                         setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
>         }
>
> Now I agree that increasing wb_thresh directly is more understandable and
> transparent so I'd just drop this special case.

yes, I agree.

> 2) I'd just handle all the bumping of wb_thresh in a single place instead
> of having is spread over multiple places. So __wb_calc_thresh() could have
> a code like:
>
>         wb_thresh = (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100 * BDI_RATIO_SCALE)
>         wb_thresh *= numerator;
>         wb_thresh = div64_ul(wb_thresh, denominator);
>
>         wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
>
>         wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
>       limit = hard_dirty_limit(dtc_dom(dtc), dtc->thresh);
>         /*
>          * It's very possible that wb_thresh is close to 0 not because the
>          * device is slow, but that it has remained inactive for long time.
>          * Honour such devices a reasonable good (hopefully IO efficient)
>          * threshold, so that the occasional writes won't be blocked and active
>          * writes can rampup the threshold quickly.
>          */
>       if (limit > dtc->dirty)
>               wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8);
>       if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
>               wb_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
>
> and we can drop the bumping from wb_position)_ratio(). This way have the
> wb_thresh bumping in a single logical place. Since we still limit wb_tresh
> with max_ratio, untrusted bdis for which max_ratio should be configured
> (otherwise they can grow amount of dirty pages upto global treshold anyway)
> are still under control.
>
> If we really wanted, we could introduce a different bumping in case of
> strictlimit, but at this point I don't think it is warranted so I'd leave
> that as an option if someone comes with a situation where this bumping
> proves to be too aggressive.

Thank you, this is very helpful. And I have 2 concerns:

1.
In the current non-strictlimit logic, wb_thresh is only bumped within wb_position_ratio() for calculating pos_ratio, and this bump isn’t restricted by max_ratio. 
I’m unsure if moving this adjustment to __wb_calc_thresh() would effect existing behavior. 
Would it be possible to keep the current logic for non-strictlimit case?

2. Regarding the formula:
wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8);

Consider a case: 
With 100 fuse devices(with high max_ratio) experiencing high writeback delays, the pages being written back are accounted in NR_WRITEBACK_TEMP, not dtc->dirty. 
As a result, the bumped wb_thresh may remain high. While individual devices are under control, the total could exceed expectations.

Although lowering the max_ratio can avoid this issue, how about reducing the bumped wb_thresh?

The formula in my patch:
wb_scale_thresh = (limit - dtc->dirty) / 100;
The intention is to use the default fuse max_ratio(1%) as the multiplier.


Thanks
Jim Zhao

