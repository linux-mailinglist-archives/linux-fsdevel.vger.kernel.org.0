Return-Path: <linux-fsdevel+bounces-72704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01019D00AE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 03:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7A0530780A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 02:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C8C273803;
	Thu,  8 Jan 2026 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AW0HD0jU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF53274659
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 02:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839156; cv=none; b=B5RxEhfBVvqPBYEh1X+c73lxf7iruhIk7jDoMUJqkXi1wxZUX33tGL6rdUj1BTVhPMNCgBg3lwC4KvM0LUOBDexCmlc9lSDvCefbegv7678pcWvyGPTN1Y/57kMS8AMfza4r9kjs9FCtPuxyYdeI712kyrs7lpcie+gHpdSqq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839156; c=relaxed/simple;
	bh=rUp6e6rYrHNK40ANcDg6tKJw2n8/tO5VdP53Ed06EoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kom4OPKkaRjlisywmS5FG5zX2wZNpewanZo2y57jjdZ31aYqcR0xkYUjbtr1MgWhvrllWo3xMTYYEo+7sy097xJ9vZh2b5X+m/IC0LGKBsW2vjFlGukQvwRn0pj/cmt6t7wKThU8brXkg4cJc+WtgLffQ/sgvaovBBOBlGP34AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AW0HD0jU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f102b013fso28273225ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 18:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1767839153; x=1768443953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R/u2vwlHE/6bSYKHhtW4VtZLFO4wVV+TWLcbSaPNhQI=;
        b=AW0HD0jUgf5En4sdhUPZ6qopRgUhEHfiQP8EDtzTH0dxuhld2mnitw18gwoEiCtBz0
         lM0on6t3QfwWsCsBSP4QIVDZ0pivOc/B6XRliSENj0wveNjb8/Mc0Wy6y9G9aSCTFu7R
         70xMJ6/F1TOFRxV+rDFSVfVnX3l9FHx4QrtbgPBmL6S9mGK99GHn7FPbgxBZvkHL0ipI
         6/v8RxX32MAuji3fIVVRJR42MoMgUISlkl565j5uTYP3IYZYyBYY2hos8lnZ/+zW42HK
         obQgSAE5TpHkEBpQJ/1VKd5jYLg6Q+ANPqNfdgHlkoTW5/w4vffSUoYmfWacuLhd+Rle
         AeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839153; x=1768443953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/u2vwlHE/6bSYKHhtW4VtZLFO4wVV+TWLcbSaPNhQI=;
        b=p5e857F7AbaySPA5cedBSmk4ORSxuGYRkOTk/G/CjmRlqXZcZyRKJ2wGI1+lIO0Q8H
         aFiio6O58eb9Lg3tcCgRB0w8++swI2u6KrTHQ5tvcifzGuKqadYzZD8V3UXchr1FhQlY
         op4/EC3s0XxmLIR+2vTdGoyBjQlq+f4gXKV3SluMgnHz27n/FvJU0+ZpRcxWRZnjAjj5
         WBmF1mvW9gWN66W8PERIGGdc/Qw9zjDYBAnwwWyYdmOBxYmj8nyDqJAE5RRBxPkkI2NC
         MZ27+C/YhINKEkr7E3gX/+MW3TKDUNDa7Yw0EmNpipGFTqcXMeu5L7iuaY+kiaNkQUcJ
         H9mA==
X-Forwarded-Encrypted: i=1; AJvYcCWa99+nl2DQ0UmImWa0e+G4ya8bzRLKrO/jopBCXHhsAN5j5Datu5QlBR0l3ST9StkDXhR721F81mtYq20c@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/xgTkIafs08qfryuxGyAogAMaNgq8jEFn4BQZtPMALd+05elZ
	y4rtPjw/+O+BRSqoNBGXS2jtP+Fz4d2vrbaeg6MAjvHJW3r1VMWV4yaZTl/Q/0FbAC3A8yv/xf2
	lD6Vb11HVWSy5wg5kC/GasqGAsNf6K3b5rVjycuECqM1NlGyXX7uiNRwhc6Tp
X-Gm-Gg: AY/fxX5T5fJzpdJMffOu3HjT3CssKFXOZLD3eAB8dTf2vvtzitqFpntrkOBdzL5kxJh
	5tyHko2zMxFnQHb488ZgfwykHROxTSIsH2RviJIFO13RYXCsdiWR4Wiuk++kFPchWzDSZugmomp
	3x495Jp2dfnCKTxWCeMoTsnfeGBiY3fu+b9zTejIW2o6VgcEOKLzPLUmburBfAFgqQ7jBCb9Vic
	DQj4eBJ7mWt8W+EiwXlySzke66NN5CKOBSuSbkzE6JINzDu8/JAWGlOkVKqKRPKXZJkDqp/ZxsI
	Shdv3g5+
X-Google-Smtp-Source: AGHT+IHR+/8idih/aFILbA+uvU1KBl6abnnr3/pNugfDhJIgQu/a3r1dVvD/avGUUaX32lvzi44poq9VHk6+L2EAwIc=
X-Received: by 2002:a17:902:ebcd:b0:298:616a:ba93 with SMTP id
 d9443c01a7336-2a3ee424a99mr33648465ad.9.1767839153518; Wed, 07 Jan 2026
 18:25:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223062113.52477-1-zhangtianci.1997@bytedance.com>
 <CAJnrk1aR=fPSXPuTBytnOPtE-0zuxfjMmFyug7fjsDa5T1djRA@mail.gmail.com>
 <CAP4dvsf+XGJQFk_UrGFmgTPfkbchm_izjO31M9rQN+wYU=8zMA@mail.gmail.com>
 <CAJnrk1Y0+j2xyko83s=b5Jw=maDKp3=HMYbLrVT5S+fJ1e2BNg@mail.gmail.com>
 <CAP4dvseWhaeu08NR-q=F5pRyMN5BnmWXHZi4i1L+utdjJTECaQ@mail.gmail.com>
 <CAJnrk1a2-HS6cqthfcU5hxBi7Rinwh8MpYggNtOg6P256aW0zw@mail.gmail.com>
 <CAP4dvsdRtO6BX6A-LdJDyakVucLskTvOViZRGonoMsK0eNtM1g@mail.gmail.com> <CAJnrk1Zt=zS7UYbryE0S+-1qBqYaowgCGa5Eq=gK7ynnk+ybTA@mail.gmail.com>
In-Reply-To: <CAJnrk1Zt=zS7UYbryE0S+-1qBqYaowgCGa5Eq=gK7ynnk+ybTA@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Thu, 8 Jan 2026 10:25:42 +0800
X-Gm-Features: AQt7F2qZuOhruDjgEpKG6I0zJfNCfy1h-ame9lCuN3A27woISZSogK78b-l5CnY
Message-ID: <CAP4dvseEksJNZf-sUVZj_x97v8=tCDh2dECRMynuYtYfmsw=uw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: add hang check in request_wait_answer()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xieyongji@bytedance.com, 
	zhujia.zj@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Hi Joanne,

> I think if the fusedaemon is in a process exit state (by "process exit
> state", I think you're talking about the state where
> fuse_session_exit() has been called but the daemon is stuck/hanging
> before actual process exit?), this can still be detected in libfuse.
> For example one idea could be libfuse spinning up a watchdog monitor
> thread that has logic checking if the session's mt_exited has been set
> with no progress on /sys/fs/fuse/.../waiting requests being fulfilled.

The process exit state I referred to is a more severe scenario:
the FUSEDaemon may be killed abruptly due to bugs or OOM.
In such an unexpected exit, no userspace threads can run normally.
However, some threads may remain stuck in the kernel and fail to exit properly.

We have encountered at least two such cases:

1. The mount system call of the FUSEDaemon is blocked by other threads
    and cannot acquire the super_block_list lock.(Our FUSEDaemon supports
    multiple mount points, so this mount operation will affect the
other mount points
    within the FUSEDaemon process.)
2. The jbd2 subsystem of the ext4 filesystem, which the FUSEDaemon
     logging system depends on, triggers a logical deadlock caused by
     priority inversion.

In these instances, a userspace watchdog would be ineffective.

Thanks,
Tianci

