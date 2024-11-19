Return-Path: <linux-fsdevel+bounces-35206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A23E39D25CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 13:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0271DB28FB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 12:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141AA1CBEA7;
	Tue, 19 Nov 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+8BNuKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4147157472;
	Tue, 19 Nov 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019369; cv=none; b=qEi6BjvKLVD8oMCkvBUfI+jxSYgFOqxJH/i0+MKf3Uh59PxW88mCOxJWV01IFSSy0ZzMaFu2V+uuaJ2RFDgR9+gHUz1fp1mCwIyibLy4XmP3LK2m0VG5X+cwjOvGn+yToFrqvtnxlYt8G3uaBwhnnuOtX/Fr2zpxyzeqgDXBtkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019369; c=relaxed/simple;
	bh=p8Yl/1BFqqV0Cn6OSfhR36jUOfMKyX2cywI1X5xIm/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6ZAjFWWimKjEIZ9HlMPEyfDndj1pv7dqiX2/JAfnWct6mmKihuuHt71ucx6WNTjT4Dgw2b8JonXWU7TKdYhy1XXG0P+FrKY5MtF4kgAEHNQHtDe6I4BZUZ+BqzDsK2O5Co96evJASfPjmkpYTVutZP9wCQPULfXEwVABQjxBMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+8BNuKe; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2ea78d164b3so688122a91.2;
        Tue, 19 Nov 2024 04:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732019366; x=1732624166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8Cy4XcMd92kGMZiPRTiEZ4gdTHlal5Fe394Gz1xPoA=;
        b=X+8BNuKemJo6mfQqFhPyGbcmySXxNTFT+59ZROfaWEs96hvHrVGGUVdZPQTfaZt+1c
         uBnNLJ/sZkjulz0HwoXWKDn9wzLl8mdUfB+hiey7k7yZErL0EwRmnSi2Q/0gH3XF4LF6
         ocF0caKhLLhYxcnPmlxv7++Uo4aAbn8LhOkS6Ibk3miH6hGJvntHP/IeJraXpxS4Qj3E
         s9ofmMzOnZMhRuBg+5NPD+P8GrteCzNnYXKcrVXcDl6V1JU2NcNhKqhZWPYchatvyopt
         h7oIOaPPN4hKXgozwJ53EHyVF4Kg1TCxQprvt3Yk1gDxuhdz/ju1jncHzIzv6f+NuC9l
         zvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732019366; x=1732624166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8Cy4XcMd92kGMZiPRTiEZ4gdTHlal5Fe394Gz1xPoA=;
        b=ST4w7rk9xuBEjP9JjR1q5EMC219hA9u9fwGzED49HTJxFJd+VY3Jp9wyYAthIbc+3w
         P+NHHs2PVfEexG9YLr2OTvJjoqAHphLfP3LNPA7Q2KClFnbhjJD1wR0MvVABBJOFDiz1
         gpifxOvAyF4gxyjTYQH8zCxF/BSNojx4LRjZO8EDvuE98LAtp6UBDhyFQVrCy1G/E7QL
         mdgeJE+fZx4dhDL+MIc1DJ22nlDO4Z7ZiWrqFVcsFSh/83vVJIP1z1RnL+Yo0ows67gk
         Bqse2qXVTwP6RGAU3NbUMPFqkUxyM0Zql91TfktO5YaceLklLP1vg40EC9OkDnndAt+h
         5H1A==
X-Forwarded-Encrypted: i=1; AJvYcCUjsbXpyxVdJ6Yvwj4+si5l2qIzE+cb/a2p/Pidnu4Q95uAeYJjkvjriKF4rto+Unc3PNw9Yyqm3zJLrreG@vger.kernel.org, AJvYcCXQjHe27OlUhKv02WYEWnCJkQvjd80c9NYDESXzh/kO4R4Hrw+nJYNFlyewPGWgjlyuJA+tFOuhyaeL/dNn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8e26q4V2eMABUPbNvt6RVf4JZYBlUH9wcGhn8BedmX4jVcoUc
	V8iFgFsDyZ46u4aitMzlvOIHKZZbY0AqyjW2t26Of6N/phY6tdm+G2zh18a35UQ=
X-Google-Smtp-Source: AGHT+IHbmrydBTMkJRe5R2ZwCxpRenmU8Eus8/aMcSDJwulMF+J5G1E0KpHb/AVHDPSNAuhUL6uDhw==
X-Received: by 2002:a17:90b:5281:b0:2ea:97b6:c466 with SMTP id 98e67ed59e1d1-2ea97b6c53emr7066154a91.12.1732019365919;
        Tue, 19 Nov 2024 04:29:25 -0800 (PST)
Received: from localhost.localdomain ([43.154.34.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea737252bdsm3792883a91.12.2024.11.19.04.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 04:29:25 -0800 (PST)
From: Jim Zhao <jimzhao.ai@gmail.com>
To: jack@suse.cz,
	shikemeng@huaweicloud.com
Cc: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	jimzhao.ai@gmail.com
Subject: Re: [PATCH v2] mm/page-writeback: Raise wb_thresh to prevent write blocking with strictlimit
Date: Tue, 19 Nov 2024 20:29:22 +0800
Message-Id: <20241119122922.3939538-1-jimzhao.ai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241119114444.3925495-1-jimzhao.ai@gmail.com>
References: <20241119114444.3925495-1-jimzhao.ai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, Jan, I just sent patch v2, could you please review it ?

And I found the debug info in the bdi stats. 
The BdiDirtyThresh value may be greater than DirtyThresh, and after applying this patch, the value of BdiDirtyThresh could become even larger.

without patch:
---
root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
BdiWriteback:                0 kB
BdiReclaimable:             96 kB
BdiDirtyThresh:        1346824 kB
DirtyThresh:            673412 kB
BackgroundThresh:       336292 kB
BdiDirtied:              19872 kB
BdiWritten:              19776 kB
BdiWriteBandwidth:           0 kBps
b_dirty:                     0
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1

with patch:
---
root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
BdiWriteback:               96 kB
BdiReclaimable:            192 kB
BdiDirtyThresh:        3090736 kB
DirtyThresh:            650716 kB
BackgroundThresh:       324960 kB
BdiDirtied:             472512 kB
BdiWritten:             470592 kB
BdiWriteBandwidth:      106268 kBps
b_dirty:                     2
b_io:                        0
b_more_io:                   0
b_dirty_time:                0
bdi_list:                    1
state:                       1


@kemeng, is this a normal behavior or an issue ?

Thanks,
Jim Zhao


> With the strictlimit flag, wb_thresh acts as a hard limit in
> balance_dirty_pages() and wb_position_ratio().  When device write
> operations are inactive, wb_thresh can drop to 0, causing writes to be
> blocked.  The issue occasionally occurs in fuse fs, particularly with
> network backends, the write thread is blocked frequently during a period.
> To address it, this patch raises the minimum wb_thresh to a controllable
> level, similar to the non-strictlimit case.
>
> Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
> ---
> Changes in v2:
> 1. Consolidate all wb_thresh bumping logic in __wb_calc_thresh for consistency;
> 2. Replace the limit variable with thresh for calculating the bump value,
> as __wb_calc_thresh is also used to calculate the background threshold;
> 3. Add domain_dirty_avail in wb_calc_thresh to get dtc->dirty.
> ---
>  mm/page-writeback.c | 48 ++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 25 deletions(-)
>
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index e5a9eb795f99..8b13bcb42de3 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -917,7 +917,9 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
>                                     unsigned long thresh)
>  {
>       struct wb_domain *dom = dtc_dom(dtc);
> +     struct bdi_writeback *wb = dtc->wb;
>       u64 wb_thresh;
> +     u64 wb_max_thresh;
>       unsigned long numerator, denominator;
>       unsigned long wb_min_ratio, wb_max_ratio;
>
> @@ -931,11 +933,27 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
>       wb_thresh *= numerator;
>       wb_thresh = div64_ul(wb_thresh, denominator);
>
> -     wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
> +     wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
>
>       wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
> -     if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
> -             wb_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
> +
> +     /*
> +      * It's very possible that wb_thresh is close to 0 not because the
> +      * device is slow, but that it has remained inactive for long time.
> +      * Honour such devices a reasonable good (hopefully IO efficient)
> +      * threshold, so that the occasional writes won't be blocked and active
> +      * writes can rampup the threshold quickly.
> +      */
> +     if (thresh > dtc->dirty) {
> +             if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT))
> +                     wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 100);
> +             else
> +                     wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 8);
> +     }
> +
> +     wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
> +     if (wb_thresh > wb_max_thresh)
> +             wb_thresh = wb_max_thresh;
>
>       return wb_thresh;
>  }
> @@ -944,6 +962,7 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
>  {
>       struct dirty_throttle_control gdtc = { GDTC_INIT(wb) };
>
> +     domain_dirty_avail(&gdtc, true);
>       return __wb_calc_thresh(&gdtc, thresh);
>  }
>
> @@ -1120,12 +1139,6 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
>       if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
>               long long wb_pos_ratio;
>
> -             if (dtc->wb_dirty < 8) {
> -                     dtc->pos_ratio = min_t(long long, pos_ratio * 2,
> -                                        2 << RATELIMIT_CALC_SHIFT);
> -                     return;
> -             }
> -
>               if (dtc->wb_dirty >= wb_thresh)
>                       return;
>
> @@ -1196,14 +1209,6 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
>        */
>       if (unlikely(wb_thresh > dtc->thresh))
>               wb_thresh = dtc->thresh;
> -     /*
> -      * It's very possible that wb_thresh is close to 0 not because the
> -      * device is slow, but that it has remained inactive for long time.
> -      * Honour such devices a reasonable good (hopefully IO efficient)
> -      * threshold, so that the occasional writes won't be blocked and active
> -      * writes can rampup the threshold quickly.
> -      */
> -     wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8);
>       /*
>        * scale global setpoint to wb's:
>        *      wb_setpoint = setpoint * wb_thresh / thresh
> @@ -1459,17 +1464,10 @@ static void wb_update_dirty_ratelimit(struct dirty_throttle_control *dtc,
>        * balanced_dirty_ratelimit = task_ratelimit * write_bw / dirty_rate).
>        * Hence, to calculate "step" properly, we have to use wb_dirty as
>        * "dirty" and wb_setpoint as "setpoint".
> -      *
> -      * We rampup dirty_ratelimit forcibly if wb_dirty is low because
> -      * it's possible that wb_thresh is close to zero due to inactivity
> -      * of backing device.
>        */
>       if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
>               dirty = dtc->wb_dirty;
> -             if (dtc->wb_dirty < 8)
> -                     setpoint = dtc->wb_dirty + 1;
> -             else
> -                     setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
> +             setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
>       }
>
>       if (dirty < setpoint) {
> --
> 2.20.1

