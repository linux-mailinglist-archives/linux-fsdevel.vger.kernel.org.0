Return-Path: <linux-fsdevel+bounces-24348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D13E93DA44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 23:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9EE1F23CA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 21:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34572149E15;
	Fri, 26 Jul 2024 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nN4oc0S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B828DCC
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722030580; cv=none; b=eOTg13/ZNKcn0XOJpOkIrpQOwyAi++fUgUV0dkj1mRj95FKIdc5x/AxdJMs0cqAbZjn/j5deOQJ7edTdOeWgT4KsUSGaQjClXI1DWeU9yuT7EdrKDI+mCA3M4kKafIndbKont1xsCObi+ALRwOp7EF9YdiO9WjbSNoDFYdlnRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722030580; c=relaxed/simple;
	bh=ADZtYYxf96z9z4D23CRWwaRkEZxvbTeXx3gF8SqqvlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX7HQTYEIjuLOk8PBMeUZjGVNvvZQ+r0z0WTvbZ25VCnOm0FfG/G8SuWwGg/nfkLJdh82EbO3kclFSnTYTohU6bK3CbkX1eY5olTBA29JUv7/vB4I60DSLT/ywrkgl43ca0hBWjeYrD7rpCL07yHR3UrUdE/k51Ar3lwBvT0Ea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nN4oc0S; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so6448392a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 14:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722030577; x=1722635377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KR5C4E3vW0MD+HuH8szSgeR8H1u2mdzLNpa9LUydU6w=;
        b=0nN4oc0S3sLs814YNdATLKeZ9UplWc5paYPr6goxEuzw73vhi4XkDzNYmB5xxAPfSA
         k7oJHDP1+Sq0yrfOvSNdfq08xS9OW5/g/q0FJg2V2TQ31S+vFJa6e2HqSRW4mzTMgJx2
         XeqybyRbd6RBOMi7agnn1v11dlarRTWmwK4wZWq1bFj4Em4a+UZtREy8SPSRdXqv9s8Z
         yaOk5QhlgBHzMSW7/o057ryJNGiDMTcvkdtW32WxFKPd/qSV2DRauBKVPA2ttQg5tbOj
         WDdcQpY5YSyKpSj7CsMELB4SBlD7c1r+B/lxmfMFGyXmVC0Cq1BkAtmCZZGAp8vEAn9f
         aSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722030577; x=1722635377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KR5C4E3vW0MD+HuH8szSgeR8H1u2mdzLNpa9LUydU6w=;
        b=gUIvQcoqhSoXzuXrXZQNkK7XtDpdrdPhH8t3Vufz5ApbhRFCPk+t0NKaAy5oPdiP8G
         imOPjsqMzmV7I0KXkmCgMR+evrZWgbm1ZmjLsI0lV0DU3mQ6wPQ+kIPlxDCe48c4lRXV
         LUEBz4D7sEf1aAKbfRqc+OEqfCPFCZq8325USW4JLl9Y0sma9qZMTP9zx5zzVij0GEp2
         8QqI1XGxscC+DTGWTGK5StOjbuGi1r+qLKUAcljqJOpgXNDarHxH3RPHQ2WA7QlDkBaq
         MQMQhu3ThusXpBwzbb9GFpr9iT/UWC9pjA4oDMqnR9fasiYynvWPXvzOmnLn5Gk2iyUV
         o1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM+6qVgs9OEny/DS/r3RCiIDdxopFOMfE3qJrSigzNU7mA2jxjMCr5P8J2IEJNeo4EWuY2O+JT0FoT6wkQ96Rnd2lptgWrnTpxpbm12A==
X-Gm-Message-State: AOJu0YzMyKTiSoBiJH74xSZ9WQ6LaHIaTevHUl+X8AaBz5IolJV/Nk+2
	M4GTrMTglc+zgVdVNoHLo4Ed8D68VWju59FT6d+YAl4xGpRLlHp6WBHpEdBJgw==
X-Google-Smtp-Source: AGHT+IGiVSE1aqhxTcotYin0T6nVT5UfpQFvqfGBOr4PTOYBrxBPKl+kbQ4l1XbafZLDs51BOIfGJA==
X-Received: by 2002:a17:906:fd88:b0:a7a:a138:dbc6 with SMTP id a640c23a62f3a-a7d3f86b83bmr74894066b.8.1722030576831;
        Fri, 26 Jul 2024 14:49:36 -0700 (PDT)
Received: from google.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41621sm216753966b.113.2024.07.26.14.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 14:49:36 -0700 (PDT)
Date: Fri, 26 Jul 2024 21:49:32 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org,
	andrii@kernel.org, jannh@google.com, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, jolsa@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
Message-ID: <ZqQZ7EBooVcv0_hm@google.com>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726085604.2369469-2-mattbobrowski@google.com>
 <CAPhsuW7fOvLM+LUf11+iYQH1vAiC0wUonXhq3ewrEvb40eYMdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7fOvLM+LUf11+iYQH1vAiC0wUonXhq3ewrEvb40eYMdQ@mail.gmail.com>

On Fri, Jul 26, 2024 at 02:25:26PM -0700, Song Liu wrote:
> On Fri, Jul 26, 2024 at 1:56 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> [...]
> > +       len = buf + buf__sz - ret;
> > +       memmove(buf, ret, len);
> > +       return len;
> > +}
> > +__bpf_kfunc_end_defs();
> > +
> > +BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> > +BTF_ID_FLAGS(func, bpf_get_task_exe_file,
> > +            KF_ACQUIRE | KF_TRUSTED_ARGS | KF_SLEEPABLE | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE | KF_SLEEPABLE)
> 
> Do we really need KF_SLEEPABLE for bpf_put_file?

Well, the guts of fput() is annotated w/ might_sleep(), so the calling
thread may presumably be involuntarily put to sleep? You can also see
the guts of fput() invoking various indirect function calls
i.e. ->release(), and depending on the implementation of those, they
could be initiating resource release related actions which
consequently could result in waiting for some I/O to be done? fput()
also calls dput() and mntput() and these too can also do a bunch of
teardown.

Please correct me if I've misunderstood something.

/M

