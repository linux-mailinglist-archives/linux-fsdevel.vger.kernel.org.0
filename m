Return-Path: <linux-fsdevel+bounces-55285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C675B09413
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 20:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB4F3AB7E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 18:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C9520E31B;
	Thu, 17 Jul 2025 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fp2L17nc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14F20A5F3
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777366; cv=none; b=j7y4yaAgT+FldtY7t8e7rWP7wk3aBhoLb60ydNCWU3wVE/AjcjgrLp+NuvgEoXvOeT+0lN6HLDQlGBptvtpE4dEsoGXOr9Pu7qPgI7t/7jkS7nGXloWRISo9c6Xo6wT7WJrmPjrbMqBHHxqpG2bgfs7ddRjjt9VZeSK0Kyw49BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777366; c=relaxed/simple;
	bh=nT1GppLNav7xgnl/ObI19ndyqjnUwbm8v4pO3iyByg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIG+fUgfAW/BwuyNNUhSsxojy6ZPyhVBN87xZOJqoZ8YhuUjCBjgZCG6SU+Or/fPaTCOIR3yi2qH8q7i7l+r5uPAcVYw+ycqG/wuvpqNBK6xSnOyDDr7/gQdFVkzzA32a1HuL0j8G7y3LuAMuzrH/wKxKfoLqrjHFgYa5zVZ5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fp2L17nc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aec46b50f33so244228966b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752777363; x=1753382163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aieKFP+WlFpL5D5yzi8pvP6vZRe7mbkNZOfzzhMJB0Y=;
        b=Fp2L17ncI5wICc2c3vrZt9B23oheclQIt1FJKetProM1QUmQCmGDQWdsGTLAF5NiaT
         uLnnVV+tiwb0hnRO+mn9U3/3O+mYcZUVcJ5xfnC05sBbkwd1dBgMjFRQfkSN5qe7z9fL
         2P0P3esHhCq5uJA1jrjW2jRUzSdbts+ACO4gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777363; x=1753382163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aieKFP+WlFpL5D5yzi8pvP6vZRe7mbkNZOfzzhMJB0Y=;
        b=LMKvAg3rUqq+kGQsNWpthrOKFlxkg0skSljAMArsq97mGSDBKfGeurcHh0X5MkKXSS
         qyam6tEPReY8uAUu60nkSOiuczSgos2dcn0QtZGHAu4+CtOYU2PfMYLWQkSftRqjf+uF
         0bPteVOS+XZzg9xFb0W50vl3JLtW/h1hjnFsTaqrSLhLESj1OzPY5JD2S86Sy/lvM9Gr
         pDd7kRIxZpJDWNgKKMUMzbuie++sVfy2IGX19ZnEh8yswFyDjbGm8PbgGZWS7LKOTxak
         SPmvBG8ab+WUnEJHoVpuo6TgX1kV2leUwNLkiv9200CkWLsnYOiwhbs3t8dbqtrWP5eP
         8kXw==
X-Forwarded-Encrypted: i=1; AJvYcCXzVGGQFm4USwbfVifMxQfyqDlQoNJBIFReecCJBKulYLjVGZuawn0Qu5ikhQuNhRDllq7DCwTMQEBqEpka@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2VSs7YJipnPOBOQ1sOOQ+vWw0mNIRKfPap26OoPZOJwqIONC9
	2UaLPBd5XcKrDL71z+Vo+UCTM7tRdmw3wgKW7GwIgjMpbprNdXqE7gvxQkLlDtEUyE7Hf9ZpPn/
	+AybusA4=
X-Gm-Gg: ASbGncspqgAsu3ztf8RGF5wrEZ4XJwx9Qkj4wSThYv+gVoTtcCuRhNiVCGKmNQIMn+O
	fyHeXoeAt4KDZM5+bdMTLoDRA6TH9z4WLQlbqyY96xGzllYJSqvmWx2FpFmCXeQLggvao1Bnhex
	vtA0BfSRzg6tNcSQw71+JwFUa8ByPF4q61tMZvoiiISwmWZ+QIK3m5POCnU4EGZ20FBZh2uLCtf
	H4lPkCtiB0YV7JLWZ+5v3m60hU80cdUcUG3TUFVIIZMLV+Y+e23U5NI0lzZp5PKb2XjtGucibpZ
	12eu71pF2qAufNTt8/21faAZeT80IUqmiWe27FfauXUSAnBVksEQVyWqVvQgztUp+qbSluqtADs
	UnvHYpHsLgFGV/aHlkFA+c5tljEDmFwbnT2WCs16gmJzH1D7mtVqQTS71AHuovokpdx+GUsoy
X-Google-Smtp-Source: AGHT+IGoq50JMOjiOmSYUD3KuLv2a/BOg4i3n9Uk3cuLhhrDEnAWNTAI3SEPmADQM54LGeJ3fdlDGg==
X-Received: by 2002:a17:907:1ca9:b0:aec:6257:c22e with SMTP id a640c23a62f3a-aec6257c2afmr179271266b.14.1752777362764;
        Thu, 17 Jul 2025 11:36:02 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91a1bsm1402596866b.29.2025.07.17.11.36.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 11:36:01 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso2414281a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 11:36:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAJ9KwB/KYQSBBpEIptT51BMF3mktiIu7n3cwtAXajf+iaZ9WfzqYBPnNDzkJnE78Qege1FCzo4naHfCPl@vger.kernel.org
X-Received: by 2002:a05:6402:34d6:b0:608:6754:ec67 with SMTP id
 4fb4d7f45d1cf-61285bf3730mr7487110a12.30.1752777361408; Thu, 17 Jul 2025
 11:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123916.511889-1-bhupesh@igalia.com> <20250716123916.511889-4-bhupesh@igalia.com>
 <CAEf4BzaGRz6A1wzBa2ZyQWY_4AvUHvLgBF36iCxc9wJJ1ppH0g@mail.gmail.com>
 <c6a0b682-a1a5-f19c-acf5-5b08abf80a24@igalia.com> <CAEf4BzaJiCLH8nwWa5eM4D+n1nyCn3X-v0+W4-CwLg7hB2Wthg@mail.gmail.com>
In-Reply-To: <CAEf4BzaJiCLH8nwWa5eM4D+n1nyCn3X-v0+W4-CwLg7hB2Wthg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 Jul 2025 11:35:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCDEuSH7w=zQBpGkustvis26O=_6cEdjwCanz=ig8=4g@mail.gmail.com>
X-Gm-Features: Ac12FXw_kNIbTRokcm7T_S0XklVgvPSebW7F_Vtc8CMTkt7DzdcMPhb6rT3qzqo
Message-ID: <CAHk-=whCDEuSH7w=zQBpGkustvis26O=_6cEdjwCanz=ig8=4g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str
 which is 64 bytes long
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bhupesh Sharma <bhsharma@igalia.com>, Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, 
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org, 
	willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk, 
	keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org, 
	jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-trace-kernel@vger.kernel.org, 
	kees@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 13:47, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> But given how frequently task->comm is referenced (pretty much any
> profiler or tracer will capture this), it's just the widespread nature
> of accessing task->comm in BPF programs/scripts that will cause a lot
> of adaptation churn. And given the reason for renaming was to catch
> missing cases during refactoring, my ask was to do this renaming
> locally, validate all kernel code was modified, and then switch the
> field name back to "comm" (which you already did, so the remaining
> part would be just to rename comm_str back to comm).

Yes. Please.

Renaming the field is a great way to have the compiler scream loudly
of any missed cases, but keep it local (without committing it), and
rename it back after checking everything.

Then just talk about how every case has been checked in the commit message.

             Linus

