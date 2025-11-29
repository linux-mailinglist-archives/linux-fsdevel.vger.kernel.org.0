Return-Path: <linux-fsdevel+bounces-70196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 788AAC9361E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 02:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20627348E07
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 01:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676621A0BE0;
	Sat, 29 Nov 2025 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JyvKvBt6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B893B2BA
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764380161; cv=none; b=mkYudumw8xmW6XMfjo7waI9ezh/PUGX2/tCHXhnKQ4SfaoaTtflAmHSqCkoABe1/WwCaoVAvZ3/1fiIChLMbT1gB6UCRhcxKuRwTpo+oFC7cB5fv4l71SUrpprPefcHYWkWCbo4QEkirDXXMmaxGuSg9cNd2x6H+5oWdlyfVhO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764380161; c=relaxed/simple;
	bh=kadI3XiZrxU+5zDXeKfhxT1JJz79Lbon//hs7FOgStE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eB7BysxV8X85N8BZReNZk7Lz81zbwaPkmG8o6FZOV62eeStuHsCKyTmeO0f4jjMkRJYWbrRfAffq/p9iqVyuh0mBkJhXD+p68/5XiJV3W0Rlbk8kICnIXvcwk4v3AtGDliEBJfbxstEMAMcGagm3yEpYnYkGUuu/vzI4Moc9TI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JyvKvBt6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso3657122a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 17:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764380156; x=1764984956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q/WIom7gz7NUO3fE19+reH06dlDelQ6m/UOlLG0sWa0=;
        b=JyvKvBt610rw0Y+Lc79Mc/DnSEbnXg9Fva50/XfVEDWnqiuyTohgWiPQIiSmSsiS0F
         pz131utAQeRPqw61TEAaY12YtJSzyl19Lzx7Iki0cUHIqh+csRcOjVUc30E3dZ2H5aTY
         HmFuCWq39GZ40WSur16HAgwK0ATirx291qWxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764380156; x=1764984956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/WIom7gz7NUO3fE19+reH06dlDelQ6m/UOlLG0sWa0=;
        b=MgDpRZKkIbm5kprZi6qWBonWXLfOZyCAW6YeE5vu0xSo5xS0cPCkcZ8/Iag6N+b9pK
         nCXvpZk7u1Ow/nWCjXA/P4vwhlFPzQkXqJlm7dkD47q9A71iRjFf5yrGTUb/kHv5tcB2
         Nnhls01akr/vumXIPD7HllF2p01+2zs2er9mNX+VAAnNTh5A1OHzZJUa86QInSdrBSQf
         QbCtHgvVpzBeZLcjrrhPrZzmkwBJvO6QexmMJk8MWzBayaleIhDeCUR4DDhC7ssqmCuh
         CzGBQgn+VXNclYakvHPTct3mtC2RDg/BSnglM93/flBrTSbqO7z/4MLKCoNEnN35yOzW
         MBUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmegMvJJ5YV+mBzsLWFNBnPOJnn2zHQwzJErk6U3OpQlEIvZcGiPe2qqPgjHRbiR2B59R5FXTMiMgPtWSk@vger.kernel.org
X-Gm-Message-State: AOJu0YxMw7WZcYWcRzRDjjf/lmYIxcJlDCJtvhfn9wwBcHf7R6HkxoiP
	tlBQ74VX/EbksRllPDXKx+oeyKuQyKQSE5YeA6/zj5N3QlHtWvOggoamijZmftuVs7fp2PRqt+N
	/SuY9A75MUw==
X-Gm-Gg: ASbGncumSMH1i0K8FCGFsq5bzfcmDhU+uwdbspyuPOWBRpv+EnScvQVmGkunQBn+owS
	FPsYCWe4LtvYZv7ids8qUv4Y5LtZbZoZFyu+xUvyhSJmGFP5mWEi2xB/tl/SVNHiId4OhEpmVVI
	ph0kem4MyYw+Zk+RpYs0N3FYy+fFF+qXDF24uyOnPF8YGmnaY/8pwWiOLttV3MpiGiWJZAkzdRD
	87zAnhDWwqDzjVyblO5a3gWKW9I6jBvB1PfMXesE5OD2rupof+fdqw3aVO7NxiCAly9mAPSEQQU
	8CC3QKjvDSE0m97WcWsxhUfPjXrtilsHXA6eDGvcvBZRDhVr70q0co9CUP+0KfdzFi0IFsfPgCk
	990mJTz98avULBui4JKacR6ebQR8HuSWbRQrAvVx8kETcz3x2/1Q/6qP7HaxPDg2gsMll5f5zn+
	L64eriD7I6/TlFOxZ9F+L4HpSr67hMIBoE0j0MVL/vp1rolPrpQ1zgEQMnUWEp
X-Google-Smtp-Source: AGHT+IHUHdswYmbEqZQCUAsC7OS3TsYvuh7wV0ecRqaGbeDZL7ihFGCQOTCs7UnnX2yY99dl1NxSsg==
X-Received: by 2002:a17:907:72ca:b0:b73:16fc:d469 with SMTP id a640c23a62f3a-b76719f90f6mr2976514966b.51.1764380156395;
        Fri, 28 Nov 2025 17:35:56 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59a63dfsm556770266b.37.2025.11.28.17.35.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 17:35:55 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so3117755a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 17:35:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZzwper7TssSEvDrPs0cX+lHZ2GJsFoetdYAshXn8g8nkQWBL2d0WlhMo90sAfuZLiuJc17lvEVWwy8+9A@vger.kernel.org
X-Received: by 2002:a05:6402:3494:b0:647:5c27:5440 with SMTP id
 4fb4d7f45d1cf-6475c2754b6mr4287616a12.24.1764380154354; Fri, 28 Nov 2025
 17:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <33ab4aef-020e-49e7-8539-31bf78dac61a@huaweicloud.com> <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>
 <aSgut4QcBsbXDEo9@shell.armlinux.org.uk> <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>
 <3d590a6d-07d1-433c-add1-8b7d53018854@huaweicloud.com>
In-Reply-To: <3d590a6d-07d1-433c-add1-8b7d53018854@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 28 Nov 2025 17:35:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjA20ear0hDOvUS7g5-A=YAUifphcf-iFJ1pach0=3ubw@mail.gmail.com>
X-Gm-Features: AWmQ_bn2YLtZkenhhdk984gAsTyb0rIufR4Br-TkPYHMl26wv1MEf1_t31IUh7g
Message-ID: <CAHk-=wjA20ear0hDOvUS7g5-A=YAUifphcf-iFJ1pach0=3ubw@mail.gmail.com>
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, jack@suse.com, brauner@kernel.org, hch@lst.de, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, yangerkun@huawei.com, 
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com, xieyuanbin1@huawei.com, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Nov 2025 at 17:01, Zizhi Wo <wozizhi@huaweicloud.com> wrote:
>
> Thank you for your answer. In fact, this solution is similar to the one
> provided by Al.

Hmm. I'm not seeing the replies from Al for some reason. Maybe he didn't cc me.

> It has an additional check to determine reg:
>
> if (unlikely(addr > TASK_SIZE) && !user_mode(regs))
>         goto no_context;
>
> I'd like to ask if this "regs" examination also needs to be brought
> along?

That seems unnecessary.

Yes, in this case the original problem you reported with sleeping in
an RCU region was triggered by a kernel access, and a user-space
access would never have caused any such issues.

So checking for !user_mode(regs) isn't exactly *wrong*.

But while it isn't wrong, I think it's also kind of pointless.

Because regardless of whether it's a kernel or user space access, an
access outside TASK_SIZE shouldn't be associated with a valid user
space context, so the code might as well just go to the "no_context"
label directly.

That said, somebody should  definitely double-check me - because I
think arm also did the vdso trick at high addresses that i386 used to
do, so there is the fake VDSO thing up there.

But if you get a page fault on that, it's not going to be fixed up, so
even if user space can access it, there's no point in looking that
fake vm area up for page faults.

I think.

> I'm even thinking if we directly have the corresponding processing
> replaced by do_translation_fault(), is that also correct?
>
> ```
> -       { do_page_fault,        SIGSEGV, SEGV_MAPERR,   "page
> translation fault"           },
> +       { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "page
> translation fault"           },

I think that might break kprobes.

Looking around, I think my patch might also be a bit broken: I think
it might be better to move it further down to below the check for
FSR_LNX_PF.

But somebody who knows the exact arm page fault handling better than
me should verify both that and my VDSO gate page thinking.

           Linus

