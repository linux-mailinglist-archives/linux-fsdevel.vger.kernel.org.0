Return-Path: <linux-fsdevel+bounces-12696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F819862907
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 04:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1AF281FFA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 03:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B656AA0;
	Sun, 25 Feb 2024 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qyzi2t2l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A328F1;
	Sun, 25 Feb 2024 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708833201; cv=none; b=QAsApYLTfc5BPEsPQwMIgFgO4FDvbPhNV7c88sGSsNeRoVisaX1/qIgjRM5FWtMNX7VcfQY3BTU53BEPqDg1oNqhqGYp+Ay698mskLrJ16PYUsO0JBB0Dg9uujMnDmqEDUK6IZjI4corZSQO+R+9dkbUpjbfGICFbjscYrBiNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708833201; c=relaxed/simple;
	bh=F6vftM2HPJ8p+RYO+nyfuI65MLY2TTCXZc5JFILU3xA=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYR8guvWQ8dGhRDQ3BvRaP3DoIu8rnUSnGuW7cFyE9CxOzgk1oDrhOLhuRZtrhAM5n/X1ot8FdifoV1islxVxr+QLq/nZE/Lf8Q8KGzdn2YbKMy/XcW3ncHZ8a/wFGXuVuzcjdwz36crFfijUOSaSbZ1gNLll8EB6zTfTRKxgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qyzi2t2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4247EC433A6;
	Sun, 25 Feb 2024 03:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708833201;
	bh=F6vftM2HPJ8p+RYO+nyfuI65MLY2TTCXZc5JFILU3xA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=Qyzi2t2lulHWB6gJY3MezHuJm/VDo8E4YOQqMEh+hjeEyzA5CsO2zHO/wgHB9LF5s
	 bME1HQVl56eCmNuHsL4V9I4SJTCe61/3iowpb5LSx3RVcnZeNrmpLVdVrOO325WXDm
	 fZyZoVELt6Vs9GvyUYhBUnEHNsATLJBkBQ533WI63IDh09s+xdQHcc814Q7MDvziKo
	 Rm5lhwdYlGCsnPcj33ENnqfzx/KAXI+57uzyjsB9kCUVAsqL2O7JFVhfC1AQ9/Y0PK
	 pV+Y/2tvR3cIt5ORPbmygQ8t9P8mGHvu26Q0NiyVgZmHbSMYmw6Toqfwf69+u/4I71
	 VBB3TzMUv2+6g==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e49332d014so316109a34.3;
        Sat, 24 Feb 2024 19:53:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFX48qac5d8CY/Ue+wElKMyF8KgGoK94ulddqTCQ5GqYT6YNOf/vUrGB3mnjvdb2asYDPUdhy6snaTlpMTrpu59pmb8GMV78ewkaCP4THvqRHVWyfavwxLJo72rECKtWOn81BgZtvjkaK/Nw==
X-Gm-Message-State: AOJu0YxJ6UL03QZ4MW3xvo/cJ/NoG7XeDKlnxu7nu6gNB2s08ONfTYdS
	1O6iNR16Y2fJRGalQeHtCOVBrwuidnLRs18FDrxikgM3cgaPygIojaGvAvHqnDS3M9D+tfcOiG3
	cY55wO/F21Nck17aaihnzWzuPwmQ=
X-Google-Smtp-Source: AGHT+IEY8bmu/ADERIYfcAcW72NKdjxEWQ1Xl7Q6LIrlQ9QtIuS0T/ius1jFVisYmAhFYie1O04ctUoGI1mPj66IHMw=
X-Received: by 2002:a9d:6955:0:b0:6e4:92a8:1fae with SMTP id
 p21-20020a9d6955000000b006e492a81faemr2392454oto.0.1708833200511; Sat, 24 Feb
 2024 19:53:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:c10:0:b0:51d:7041:beda with HTTP; Sat, 24 Feb 2024
 19:53:19 -0800 (PST)
In-Reply-To: <20240224134803.829394-1-chengming.zhou@linux.dev>
References: <20240224134803.829394-1-chengming.zhou@linux.dev>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 25 Feb 2024 12:53:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_HUcSrFv1q6HvPkOBdENkK+Hjih-KiwZMc97mPaiGPHA@mail.gmail.com>
Message-ID: <CAKYAXd_HUcSrFv1q6HvPkOBdENkK+Hjih-KiwZMc97mPaiGPHA@mail.gmail.com>
Subject: Re: [PATCH] exfat: remove SLAB_MEM_SPREAD flag usage
To: chengming.zhou@linux.dev
Cc: sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, Xiongwei.Song@windriver.com, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

2024-02-24 22:48 GMT+09:00, chengming.zhou@linux.dev <chengming.zhou@linux.dev>:
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Applied it to #dev.
Thanks for your patch!

