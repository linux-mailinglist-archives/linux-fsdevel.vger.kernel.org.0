Return-Path: <linux-fsdevel+bounces-59300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E95B370F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 19:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DF73675D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7B22E54A1;
	Tue, 26 Aug 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="i6WEPL0p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AD2E3361
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227882; cv=none; b=eeVSXTjjZpUutJjIB5kIJogbpsixjb+bOPoYlIEcYG4AdfUROMJLfH90fAWONvorbvT3cAjEvaMvTzqOA7PwOcrSffXGt2CGTX/lHa0+FHkEPAJdTPiAtKmTyrmlzPDChwfCBpc1Htr6tSXcogTxch7+QJJCJFmI/G5y6OjJVa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227882; c=relaxed/simple;
	bh=4hli9x6NgPwP094pbyA0wxiR+cPcCetA3Wp28EfePcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYEd2ucwpvquD7+a82xVHFM8ikFMlIl+vSsKulqM/2nqmxZY+6eLpf/0BrYokiqUmkXN+tl6SpiUscKNo/EJ8IOz6sKNdAzKIRIo6E0jb/Uh0ZD7q58+ZcRJSkwZwXKrgIggPbqXbVnqFi67qMo9pfijqATRl15uE4OV8PSnoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=i6WEPL0p; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b2d501db08so27492081cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756227877; x=1756832677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VjIfaOrofazhAWITCaBIQC/PYR7khvFmaUUyG7Ja/eo=;
        b=i6WEPL0pn88fDPnRYN45hj7gOcVCBERuZ1htsz9l/CTeeHj2yJkQyh/kwjR7I/du2F
         OOmppdVKnOz9UtjGaeC/ek8tlU+qZdGkzvtOXJyrhdNduwzOxIaS0Ag2/4hve/uJ27lh
         6MViq0s1o6dKjb+y/6TEb7+3NZSSELpdY29DxuWprqUoL6MWOaSu2OJql7+Fd/CiYkAK
         0DQfpzi6kdLrwqWyBkowG5vCTf/oYiOX/6bMmo7DR4xISJkGoUn7rSXHEhqbvjSiggq3
         M7ss2/L1eit4r9HSSLDmgtCzbYagzLjZboL0DpoeQe2see7mDltPbZ69hIwMafT2bwbH
         WHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756227877; x=1756832677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjIfaOrofazhAWITCaBIQC/PYR7khvFmaUUyG7Ja/eo=;
        b=Gy8QHnEIng8Wh94JRiMR3HBHpLz6qnr4arPp6+38TDez/yfwbstuP7La0JEIUphTOr
         lFrJfvkU3ddKcXryb4PfeV4EYV90IH8CVrXQ6itFvdGutaeRlnw89E6HXpAttxJFbo5o
         2p79r6G9qcyf35OGl7FuymYZX+8yquSyeTQoowo0oRvPgMlynDQ0PNNqGSUsKmnQoSVx
         hT8k4qCWey4nHXtSFgRwtLx/3U/px2FkWiTSCo29uwFWCNE5FeFLykYFfvMbcGn/sCBD
         58MG/nDezRTNoWOU5RvZ7Z/sGoTYVwU7iuBCNMAUWE1uYjcs2f+qQNckXp0Cyr+pTPZ2
         NpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG8UvQEevIhLrzAWHWfKL4g1HwJ4X5Jfqa2U//K3kIH4+iux8B/x1gAUVsI4SZKTFJwIpiUrQYjlbBXWeW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz744dZlmF3LkqZRR6BAtMXJByJvNcGY9iOBVtHMXECbaSSQ5Ff
	IoaH9Vrns9vbQcvZSv0D1GT+IwCYL1F8ngXUwfqVAGyYWw3dzZynB9j0aNGKmO3k5/g4l2DQRc1
	tDIwKDU+EPiGlAAGV+1wcvtoaB0qxjYhN41QVqv4OiA==
X-Gm-Gg: ASbGnctloWxUCUIwEffsU4yn2JZdSum3oAjzK7+YVR2N0NyUXSn6912D+A5n0ZjbDW/
	IeGNvPY/g/jWxnnwElqZT0n/E0ry4LdCEuLHRx5w3kqyt8qciThA88Q1riCViMk18ZtipQv9nKw
	Iklvqv/iJ/JAddYJMAAMSY1EuX75dCG8ySyTrJigIU/sm6Kyag1Tgr5Cxh5tB0hgfUveIdvTlLT
	dXP8D9hHvVe//o=
X-Google-Smtp-Source: AGHT+IGhz39NCK5Fxfc9IjxwgHAO3YphwmnNvrOuu/ULmHzST7LVx0PTJH1sOUstAe48pYCpPqjEksP24bvYcCphrNY=
X-Received: by 2002:a05:622a:1213:b0:4b2:edd6:f1a2 with SMTP id
 d75a77b69052e-4b2edd6f516mr4884241cf.63.1756227876536; Tue, 26 Aug 2025
 10:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <mafs0ms7mxly1.fsf@kernel.org> <CA+CK2bBoLi9tYWHSFyDEHWd_cwvS_hR4q2HMmg-C+SJpQDNs=g@mail.gmail.com>
 <20250826142406.GE1970008@nvidia.com> <CA+CK2bBrCd8t_BUeE-sVPGjsJwmtk3mCSVhTMGbseTi_Wk+4yQ@mail.gmail.com>
 <20250826151327.GA2130239@nvidia.com> <CA+CK2bAbqMb0ZYvsC9tsf6w5myfUyqo3N4fUP3CwVA_kUDQteg@mail.gmail.com>
 <20250826162203.GE2130239@nvidia.com>
In-Reply-To: <20250826162203.GE2130239@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Aug 2025 17:03:59 +0000
X-Gm-Features: Ac12FXz3lP2hDCkW5MtqBiPoAwifNenh5414D4bEhipE2lcPWQY4sTh__rhBUIU
Message-ID: <CA+CK2bB9r_pMzd0VbLsAGTwh8kvV_o3rFM_W--drutewomr1ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > The existing interface, with the addition of passing a pidfd, provides
> > the necessary flexibility without being invasive. The change would be
> > localized to the new code that performs the FD retrieval and wouldn't
> > involve spoofing current or making widespread changes.
> > For example, to handle cgroup charging for a memfd, the flow inside
> > memfd_luo_retrieve() would look something like this:
> >
> > task = get_pid_task(target_pid, PIDTYPE_PID);
> > mm = get_task_mm(task);
> >     // ...
> >     folio = kho_restore_folio(phys);
> >     // Charge to the target mm, not 'current->mm'
> >     mem_cgroup_charge(folio, mm, ...);
> > mmput(mm);
> > put_task_struct(task);
>
> Execpt it doesn't work like that in all places, iommufd for example
> uses GFP_KERNEL_ACCOUNT which relies on current.

That's a good point. For kernel allocations, I don't see a clean way
to account for a different process.

We should not be doing major allocations during the retrieval process
itself. Ideally, the kernel would restore an FD using only the
preserved folio data (that we can cleanly charge), and then let the
user process perform any subsequent actions that might cause new
kernel memory allocations. However, I can see how that might not be
practical for all handlers.

Perhaps, we should add session extensions to the kernel as follow-up
after this series lands, we would also need to rewrite luod design
accordingly to move some of the sessions logic into the kernel.

Thank you,
Pasha

