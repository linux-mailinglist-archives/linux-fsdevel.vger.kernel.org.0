Return-Path: <linux-fsdevel+bounces-4716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4021802A51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 03:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9F21C203A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D14C259D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="I6I3HXCK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41D9D7
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 18:14:15 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d7632a2237so565397b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Dec 2023 18:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701656055; x=1702260855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=388DnSOOl0dwCbXab02Ex4X5WwZLrBD/+hKfrfZ6LKo=;
        b=I6I3HXCKIyKq8eZyLsdgMqlcab3at3QRIDnOisTcfBigDotD30CBJJent1GrVw1FzO
         96BTl0n79ToD2MASNnU9aJitDqB9LknN3YboGn9hYn+xEaTI0Ne0aH8MlY/u13r35kcW
         /dXinOp/K0CEMN2xOFYS5dRKo657MXl1wPMwHDIbcc9lxH8Pc9LolYjR5XG3FpZWGPIE
         jRA9P27orVYj0S6dmshwGcy30dRb85tUCDENQT/h7vpi4d/NcUD6QUR496LSqH/cKFlI
         83ZztWc1wyawn5pFe+Qh0UHc3mbkRo+EhYf3PxFU3LQIHOjdq5CfnddtHfFv15tfyo6W
         V6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701656055; x=1702260855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=388DnSOOl0dwCbXab02Ex4X5WwZLrBD/+hKfrfZ6LKo=;
        b=wTCuBIGCVdkbY8g0VuItKnDn27Jy6jzsupvUnQoL+Z2VOC0Oof7+5NObtgsEkiezgb
         7w2Yd7zezkrdhvCS36Ym+sZ+YC050GbyrVYPcLGo+nCT5lI6HnWMjWcMDW6+JWRidFTt
         TAlkeKJDQ4KsCQcCngLkphheI8EVHNjOnb4NY/lyBOfb/s+zkpttQVQvWVVSydkLP0cf
         bn1ipkHWpmXtAbEkVSKt44B02R1iTRCjS9KPzbl4dP0qO9jta9SUMmaKRNSBttg9nzFm
         Cl7wTTEFiKFcVBAvZ279LXDF6ePu9YNMJ8Ob6shEc57jyBe668fUFv7c+HT0LxU+ywaR
         NT9Q==
X-Gm-Message-State: AOJu0Yyw+34FwmhqO12SPGSSOg6qnC+9DCk3Rc/JwzvPmwKVmX+qRUkN
	L0NGB33xptjMajmRZ1Vu5DOncw==
X-Google-Smtp-Source: AGHT+IFcNWA+eNuaKGM1iJBwEifJAMmJ6R7Kp8kjw7jQPXUFTpog7ShcxdvqW3FEv8diKT/ZtjkVHg==
X-Received: by 2002:a0d:d68d:0:b0:5d4:1d55:b677 with SMTP id y135-20020a0dd68d000000b005d41d55b677mr5218306ywd.5.1701656054802;
        Sun, 03 Dec 2023 18:14:14 -0800 (PST)
Received: from [172.19.131.145] ([216.250.210.88])
        by smtp.gmail.com with ESMTPSA id w20-20020a0ce114000000b0067ac5a570aesm620392qvk.109.2023.12.03.18.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 18:14:14 -0800 (PST)
Message-ID: <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>
Date: Sun, 3 Dec 2023 19:13:56 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Content-Language: en-US
To: NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231204014042.6754-2-neilb@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/23 6:36 PM, NeilBrown wrote:
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e157efc54023..46d640b70ca9 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1328,7 +1328,7 @@ static void mntput_no_expire(struct mount *mnt)
>  
>  	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
>  		struct task_struct *task = current;
> -		if (likely(!(task->flags & PF_KTHREAD))) {
> +		if (likely((task->flags & PF_RUNS_TASK_WORK))) {

Extraneous parens here.

> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 95a7e1b7f1da..aec19876e121 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -183,3 +183,4 @@ void task_work_run(void)
>  		} while (work);
>  	}
>  }
> +EXPORT_SYMBOL(task_work_run);

If we're exporting this, then I think that function needs a big
disclaimer on exactly when it is safe to call it. And it most certainly
needs to be a _GPL export.

-- 
Jens Axboe


