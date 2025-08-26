Return-Path: <linux-fsdevel+bounces-59214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC624B3678D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 16:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381CE98220F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172235207D;
	Tue, 26 Aug 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OMAzL0Rk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4447635082A
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216511; cv=none; b=ooQAfqlfvAMN0ubKQ5oCLF151h6cZHRtD3M2s/rNli4Pd02iQAojyRJtZaEOl3gZJj2LF6Xjio7o4gFy/1Fmhw+ylbt7NGm2Kv4be/U8JlFuxoCtiKX/Nn/xS4tTUiIY3pBp6g5rpMyz3ynkaZeYu+FCG6J+Ne/qIpNmgUlVqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216511; c=relaxed/simple;
	bh=UY4PAtYCPhfTFvflgw9McFBL8GDEV1IGg0cYHqj+SP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPtzZ8kZkH4TlUnIsKQ+YbXKkOzSXR0nWYbbRwLpBFEWOWZG8CTPMsNdAkoOzOWPPUr/Y9OrrsFzwaqGy3ZYqN8hd9XzKOCwNurhjOOvdO1Q4VWdGKAT8ElwYvQ7XpdWpOaJsyN3aPDuzi0m875vHSZmcfvwgx9yY2/heTLiSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=OMAzL0Rk; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b10c1abfe4so86990641cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756216508; x=1756821308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WXrsBqa903YM8Bb/iVPoGxewN+EOL3SzPn1F/Ek/XpU=;
        b=OMAzL0RklIwJFcqgzEc6yGluGUmxfi/KxSKTicurIEIH9poMz8tj1w8ld9oh24Q29b
         ZgILejwmV3r7VTOC5uhGPVa6popGpqQIFb66SOpdZ3tENHivn8HMV7mXO2PVYOWEbnSP
         1fn9TN281vwcIO8qFVAIsIMrvjMd5PIeLt1s3nc9suDmvKeVvco2KFH0jwewM+kb3ZrI
         3ntiOPJ6DQt7Np+Bj5xBShG3e6RYJpWgf87BNsJNc7317EtQ60LjF6dRGyMG54SaRH0D
         DLCZ4uHNm9WyjVB27zZuaiWwc139BRIbI7DgW8PgEr+q5iCe2g1XQZuteFydZoc+CUvY
         LD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216508; x=1756821308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXrsBqa903YM8Bb/iVPoGxewN+EOL3SzPn1F/Ek/XpU=;
        b=C9fklUGbIt9skUyPBULJ7i3IbVV+MSVoqwTATpbKIlT+ISV5Np+VNufxFPo2ubGsYF
         JQ9i7p0r4DJH7Zb//rLuNIXiqvGgiIwberlGBV4KmxpoagCJmR3AQ8SqssSCgejsUH2q
         mkW9LBjKj6R87AMdL8f2CQQBNqXVU7TdGA1v6leqC75dOw4pE+zaKcwTMrEC1IeZ0ohq
         wjlg4+fBUEEYkscUgxpgskTM39BWOdhGM5PwgcdC5UDhEl2hzcBrwirhbJ5a+RZbyx6b
         VgrT28ApK/lMj+Jxsg9acM9G0hS0hS2R0WRGz9/YcfGFuNHxhHzBWKyoheimWmHQW8rI
         Xcyg==
X-Forwarded-Encrypted: i=1; AJvYcCXj97uqzCstZMoFifFZKuPggZL1TpPqjdv+YMi2tVg5JSCjGYwAPfq0TqtIE3yBoGwzUlACior2DS1Yb3uL@vger.kernel.org
X-Gm-Message-State: AOJu0YwFhjnx1UURhiQet5xjYtC4ZkGdJxEYs76EwndiAoWNNfcChs0N
	d+9w7eIMBxNZmu9Bc6rsIMZ7umAZ+8ekNkyzOYhHOPuZfu9q7Dn/UhxHQLXKZVtcdJjxamXu7Q5
	ZcEJQLd8s9ub+sf/Ij4uNoc9h9n8XL09Y3QhZQBI+oQ==
X-Gm-Gg: ASbGncsbq96lB2ZKkwERNDD2uilS+gw7kpdlmrqQ+OagwFJsWxjpPqcPv6IHxqvFKCR
	oLizrbaFGt3AKlwhqaJIfFSQm+A7H5F16aoZg/o7Pr07nnzrQI4zEjX1alju7LwwX/KPLdqx8h7
	QS2lSVWyU0DNXekpn3UpWwgMmv9b8RnRUKEdgxOgxOmKO/B7G53xafHaK8OpkCwk+/HAFtKmywE
	KTh
X-Google-Smtp-Source: AGHT+IGcGuep7n1ZMQbOLWojaFaiFK2h2fVsewAul/Hz9Pfb7IpF4bpoR5o0QPDcbUbeNlPIwhAjeljdyRG6U6RmHSA=
X-Received: by 2002:a05:622a:4083:b0:4b0:851c:538a with SMTP id
 d75a77b69052e-4b2aaa81e96mr162452241cf.8.1756216507983; Tue, 26 Aug 2025
 06:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com> <mafs0ms7mxly1.fsf@kernel.org>
In-Reply-To: <mafs0ms7mxly1.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Aug 2025 13:54:31 +0000
X-Gm-Features: Ac12FXyb-9ofKcB5jLMNzC24BIRSCWuL4lKgd8Qnfh0hAm4ydgvkrr7-UIknHkA
Message-ID: <CA+CK2bBoLi9tYWHSFyDEHWd_cwvS_hR4q2HMmg-C+SJpQDNs=g@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3
> >
> > Changelog from v2:
> > - Addressed comments from Mike Rapoport and Jason Gunthorpe
> > - Only one user agent (LiveupdateD) can open /dev/liveupdate
> > - With the above changes, sessions are not needed, and should be
> >   maintained by the user-agent itself, so removed support for
> >   sessions.
>
> If all the FDs are restored in the agent's context, this assigns all the
> resources to the agent. For example, if the agent restores a memfd, all
> the memory gets charged to the agent's cgroup, and the client gets none
> of it. This makes it impossible to do any kind of resource limits.
>
> This was one of the advantages of being able to pass around sessions
> instead of FDs. The agent can pass on the right session to the right
> client, and then the client does the restore, getting all the resources
> charged to it.
>
> If we don't allow this, I think we will make LUO/LiveupdateD unsuitable
> for many kinds of workloads. Do you have any ideas on how to do proper
> resource attribution with the current patches? If not, then perhaps we
> should reconsider this change?

Hi Pratyush,

That's an excellent point, and you're right that we must have a
solution for correct resource charging.

I'd prefer to keep the session logic in the userspace agent (luod
https://tinyurl.com/luoddesign).

For the charging problem, I believe there's a clear path forward with
the current ioctl-based API. The design of the ioctl commands (with a
size field in each struct) is intentionally extensible. In a follow-up
patch, we can extend the liveupdate_ioctl_fd_restore struct to include
a target pid field. The luod agent, would then be able to restore an
FD on behalf of a client and instruct the kernel to charge the
associated resources to that client's PID.

This keeps the responsibilities clean: luod manages sessions and
authorization, while the kernel provides the specific mechanism for
resource attribution. I agree this is a must-have feature, but I think
it can be cleanly added on top of the current foundation.

Pasha

>
> [...]
>
> --
> Regards,
> Pratyush Yadav

