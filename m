Return-Path: <linux-fsdevel+bounces-62399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16035B914B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 15:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF1118A3479
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD65030AAC8;
	Mon, 22 Sep 2025 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b7Xag655"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8811F309EEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546434; cv=none; b=L4yO6UY33aWCeYlj2nmnuV/TZKioOUM6Fg4Y8Q1mzfVrD1Mbl1zVz+AMKX7iaczd1rE0eGiFFiODt/HeQPfTTt5GWG2my6DvTprzNRBIYlG13btmGrH09Oc0SGgmtcsp7JDC0UYmzGIriuyde+TxJHQCgwblTfJCbsdesxBEoic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546434; c=relaxed/simple;
	bh=zv879v8IpLvhbadVbPUjTIXbDPFELh7WD4HC8x/76us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAbAW2w7iE82gbffXn9uu197caV961Mr0KY5UnaCLHpMLNheKkgloB8+Hx91bQURV22Vc12a2DqiBLUdkv1fNZYcrsXdURbG/8gKCdZ8zKnOk04aSeKHHwclXDH1ek2pB2uoaNqeMFHUdhbS2u+VS4Lc9aVb59ouIaQ1SEow0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b7Xag655; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fbfeb097eso4597850a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 06:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758546430; x=1759151230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5I0E6zUKzQLaX/EzSWa7WfLXYyAGyIhbG839ROFjSY=;
        b=b7Xag655ujxeaHHd0nYiQRUs9TVEYWKtYCm00NYFkGsKq2edg4tYdqcnkIkyZtxGjO
         tkduQ+yHkBBhUZUWYzNDfE3j/osAwZWmr78spqrMi11jhNo5lVk+hjom8Ue3xz2tbQUu
         UUWp0DMQjf6QGUgbSFUVLquCOA64Jvu/DJzItbpvSLBbCxbr3n9UCqbkTgfSMnHDrZnQ
         ule8MLzVLhbgz6FWT+lyEnb5gWVWjIdFzte8sybPZOVQLFv5u2CkSmw0GAns9C0XbBPg
         SZBO1JQNlIfCkcqJlz0Tlnjdai9MqpHiisDN7igKuPU2g4zPXLmAe4WRCLZaxwN5Cs/m
         8bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546430; x=1759151230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5I0E6zUKzQLaX/EzSWa7WfLXYyAGyIhbG839ROFjSY=;
        b=xScqGgqxauTp9XkoWJEFqVeiKjHQtC1ICSrS1gGN7gID1RYfbfQIgjSZgoJwk1ZOJp
         EeLh3mlRfth92UUPLq4JHki3xz0RcU2HJrU/DJMs2NpUr8Xi4ogeAhPafPemn92tAslR
         w0JAsiUGmkqyegYjy4Cuv4Caaqn6FYxw9UD4sl6rqTZ7LiqFT0dKFiVFu5Dn2cTh7qPs
         +E07KDK0t2hIPoGZMBLze2+44M+Ls79/8BDktZzKz/DdBWzEa4JepLuBKFUBBdVctXwT
         OXOR6EdlK+Vz2piQFTUnVdpyg07IUYR+77IGpykVmvYicR9UurDy6DxgBGR63vidyLU9
         uTzg==
X-Forwarded-Encrypted: i=1; AJvYcCWQIsDbe77cdQot+xa1s5s8E3FOiaGqs3lhxC/WcBBRE6XZ1HU2s/dZ8bXSpCfvAX4i9okWh9s9DpeLOBno@vger.kernel.org
X-Gm-Message-State: AOJu0YwjiOYY2h49EN4GgNsndK0vjDuGheiTUmaQRY3bXdti3J5fXdSq
	5y0msx7TEY/Z+xRZd3fOvgcxCmBQpCuAISlDe5phAjRzldmi9zu1rhzrtQLEdJZwBds=
X-Gm-Gg: ASbGncu4cVmWoiYlZDac61ShKqKEKA3umtezGmGzFvmR6XFDNW5ezInleaMZROZO5Cn
	59yTuUskvblOY0dgPF7xgHQmijMUI6ttTs3Te0JbrHudJzPpNqCyO5i2cdlKA2mj1w7lZes0pW2
	Dh9Qzbe4X1SdGUG46KEyDfD2WXjsF6JFMMXwCLNxte+1MEFPLki1N2MopB17X5RNp2HIHM0XUOL
	/6+VzQGzOWa7NberQSUmGu4wHYsVY1/5lFkqzgHpUjmIgcKVTw2oAfLEueb8GzkxLBu4PyY97xZ
	Gj9XUD4A32CLZ7Ts44uhfNC3h8DfhSPgHOZplORiN5/52zTlbh2O4k7aSefthniJwU7CUM1o7pn
	+DQHij8ZTM/KxO2Fe1kE8Q4cJ/bVoAoTiDA==
X-Google-Smtp-Source: AGHT+IHjQTvK8GvwSXsCGHP+yjQ8SIPT2LP8nwGDGqdQKPBmQ+zHQYGgHfCPA13wqo8OaxL+Zcu3vg==
X-Received: by 2002:a05:6402:5212:b0:634:4d7b:45c2 with SMTP id 4fb4d7f45d1cf-6344d7b4f0bmr1491168a12.0.1758546429819;
        Mon, 22 Sep 2025 06:07:09 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62fa5f4173csm9072355a12.49.2025.09.22.06.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:07:09 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:07:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, akpm@linux-foundation.org,
	lance.yang@linux.dev, mhiramat@kernel.org, agruenba@redhat.com,
	hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Message-ID: <aNFJ_EKj4fnRDg1_@tiehlicka>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922094146.708272-1-sunjunchao@bytedance.com>

On Mon 22-09-25 17:41:43, Julian Sun wrote:
> As suggested by Andrew Morton in [1], we need a general mechanism 

what is the reference?

> that allows the hung task detector to ignore unnecessary hung 
> tasks. This patch set implements this functionality.
> 
> Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will 
> ignores all tasks that have the PF_DONT_HUNG flag set.
> 
> Patch 2 introduces wait_event_no_hung() and wb_wait_for_completion_no_hung(), 
> which enable the hung task detector to ignore hung tasks caused by these
> wait events.
> 
> Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of memcg 
> teardown to eliminate the hung task warning.
> 
> Julian Sun (3):
>   sched: Introduce a new flag PF_DONT_HUNG.
>   writeback: Introduce wb_wait_for_completion_no_hung().
>   memcg: Don't trigger hung task when memcg is releasing.
> 
>  fs/fs-writeback.c           | 15 +++++++++++++++
>  include/linux/backing-dev.h |  1 +
>  include/linux/sched.h       | 12 +++++++++++-
>  include/linux/wait.h        | 15 +++++++++++++++
>  kernel/hung_task.c          |  6 ++++++
>  mm/memcontrol.c             |  2 +-
>  6 files changed, 49 insertions(+), 2 deletions(-)
> 
> -- 
> 2.39.5

-- 
Michal Hocko
SUSE Labs

