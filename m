Return-Path: <linux-fsdevel+bounces-45755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286DEA7BCD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 14:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83CA189F408
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15861E1C29;
	Fri,  4 Apr 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TJ9KNLm+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975F11F94C
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743770630; cv=none; b=lO3NpjZAQ5ji9RNi6VcdUJTqU9gZOH+5znhosjKakq0cv4pclpgokqnwOS3cyaZPQ0DVgruMERofVp54mwhGGgFImmqFD+1e3Zd56xKD5AKO9fkwiO87k5BHoEwxaCtyOTRC4VRvbwppm9uqpnqtFude/YWOT7CSqEr927NkfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743770630; c=relaxed/simple;
	bh=S4rZB5hGz7UtyTpR7ZwtYILly61oCYwWrl16u4zduSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+jkmsUeY3rD4PREjXl7UUlpMyNvez/phScRaAr43j8T3eWt8l1Sv/F5hkW/3nmHSlKDpmFr35iCjipnp4pQRaAn4jPk7Vq3XkHyxf4xl3wZ9isLk5lIpzBQ1RLPZNcCSduUtFou4Tkqx/pTTE/l1aedBz2KcP3cqX+0omlj6OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=TJ9KNLm+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3bf231660so217971385a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1743770624; x=1744375424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JjKzlOmUKPc1xTEANiBgCEKSRxXRPdmXnOJElHilTek=;
        b=TJ9KNLm+JosoOysHUbrePz4HOiIp7z0AHNXSFbIDWchbxxX9PhsXO+r4Q4RusW4TaZ
         uYD27kzjX08YUDCiXQd1DWuwnygGE4P79dzDQUye9oiMi1EyzBBe6Ht2aHsdTPz+lqcf
         NfIjS/a7lpYBgEAL3V2xN48UbKy7Q5XRq+Hro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743770624; x=1744375424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjKzlOmUKPc1xTEANiBgCEKSRxXRPdmXnOJElHilTek=;
        b=G52Lcqpio+qAnoSzSQKRozN1Z8wLb0RwofPWfCMdfkJRfnBVlMYaNq8fIT1gGF7AIT
         PrKz0I7RR6MxTMR0O4X5dB/+1aN8TgyUWJaa/Hyzn4D6+We1FCnwlVgxSY7lTc+dL3pY
         mvuDbg1yUR+jO6wgl9khjfpRDokjyRIUyWjRv57qB33BIR9QC8BrYmrh/WPb2Ppzx34h
         fYkQ0dgv54/OnBEaM6Igk/ZFQuGQytM3VQjIbHglJb4JaeWenHjz4nwPHjNGOdHZUJCQ
         47pmHENySjykfkoWvyVuuesatFZHzrcqjKiqpO8CUrsqeW24XYPgpd3LcAOeR+1OLE/y
         qCwg==
X-Forwarded-Encrypted: i=1; AJvYcCUAhmxM2uVNA/hl9/xXhfr7rjaU34ZhhkDnMAMcQ9uNSPUcPOCCe0SoE5uTizRkSaCUVVbgxW2E9iBKjma1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ne1eCBwsIzZ+4PNjHIEENlKS7nLVXm0V2qRpN2KddJM9r1Ou
	TSsAnxgvXq7jh7JJLdIuII5nHr+ki4oo6Rtd6ioX6Vj+uWA+mJlV82pHPLuhROP52NaC+op0r2K
	DBM9sk+nOupdjoKeTXGwpz8SWD2n13LL7D6WwAg==
X-Gm-Gg: ASbGnctVBSXIkjWysx/y2b8LcFawSuUKCdMwP3kXQLWP6WrcmxJOBs2ohBs8vqCr8gz
	exEXWgSsT0G6xx5qwUh1bQSTojrSxhpploEpujz782ESMVo5iMTGcwW/Th+P+7LgM5Zz0o2kyFT
	z9Gwprdvx26UqqJt0JEO4ANiEzYg==
X-Google-Smtp-Source: AGHT+IFLFAMa1kp5WPR/RFPCbgOrMit7iAC3Bf42Bq3gGVdjjkZK5IlGBpt0Hw/GidJr7pVNsIWCm8ZnH8Y6L1osZuY=
X-Received: by 2002:a05:620a:4252:b0:7c5:49c9:e4ae with SMTP id
 af79cd13be357-7c774d6543emr340844585a.32.1743770624321; Fri, 04 Apr 2025
 05:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com> <20250403-fuse-io-uring-trace-points-v3-1-35340aa31d9c@ddn.com>
In-Reply-To: <20250403-fuse-io-uring-trace-points-v3-1-35340aa31d9c@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 4 Apr 2025 14:43:32 +0200
X-Gm-Features: AQ5f1JoZ9HYoHJFB7knP1SsLyAdFeve_riKsVjJO9gYeMk1U0qf3NRyZeQ6yCiw
Message-ID: <CAJfpegtBinmb_D=R0zYWF3AoXscwFugRhCMQKP_aRehq5Y_Wfg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] fuse: Make the fuse unique value a per-cpu counter
To: Bernd Schubert <bschubert@ddn.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 22:23, Bernd Schubert <bschubert@ddn.com> wrote:

> +/**
> + * Get the next unique ID for a request
> + */
> +static inline u64 fuse_get_unique(struct fuse_iqueue *fiq)
> +{
> +       int step = FUSE_REQ_ID_STEP * (task_cpu(current));
> +       u64 cntr = this_cpu_inc_return(*fiq->reqctr);
> +
> +       return cntr * FUSE_REQ_ID_STEP * NR_CPUS + step;

Thinking a bit... this looks wrong.

The reason is that the task could be migrated to a different CPU
between the task_cpu() and the this_cpu_inc_return(), resulting in a
possibly duplicated value.

This could be fixed with a preempt_disable()/preempt_enable() pair,
but I think it would be cleaner to go with my original idea and
initialize the percpu counters to  CPUID and increment by NR_CPU *
FUSE_REQ_ID_STEP when fetching a new value.

Thanks,
Miklos

