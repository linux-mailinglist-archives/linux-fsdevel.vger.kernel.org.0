Return-Path: <linux-fsdevel+bounces-25066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D3948812
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 05:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1501F22000
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 03:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0991BA879;
	Tue,  6 Aug 2024 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVTmZjs5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310D17C203;
	Tue,  6 Aug 2024 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722916279; cv=none; b=qJr8968gQbcWAQjCIvJWmq9q1KHXSSVMcn7Rc2+4wwnqkQWAS3L49AxBBlrsPNDMysY2Aw0bFtKt0oaCnm/Yf89qk2jI8rDkuh3E2Bxgz7617aAx30oZSviIhs8AUeqR55zbly7C4qQ6NVNXls5191KyIydZDRJW6pO4oKxkjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722916279; c=relaxed/simple;
	bh=o2qOFURtd6COH4J6FuPiVJ1ZknbpD5fuWh18UJ6DnM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/lvq5Ach1gD+89H8EFPhKNrQvqI2rd+3rZKlOhSvAgvZcbRLNVFQcdCPwhiIcVHeuYRIEID7jM4NLL8FpyWaK++efhpd1Bbk2P9c6cu5mEDPzJtERQ7iwmlj2eELUOwizRsocHKM90DgxoP7ptH5LpI55SZCDSPfzGb0sYipVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVTmZjs5; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b797fb1c4aso1840246d6.2;
        Mon, 05 Aug 2024 20:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722916277; x=1723521077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/kd4WiMmD7cvf5H5grwZdB0fA+VVTIeAtsfQV3Ag+U=;
        b=VVTmZjs5ps5PZ1tDWhb8RhFE1bgS9BEJ9OveKZV9cm36Mx9R4JgaQ9hJDwdOMjJMiv
         /SG94mlrH/JLN9cz1cxXaZ1wVCa/4wketftPb4n5jEmy1lmY+nB0Fz4wdF4KPaotsNeB
         Izwhu1/x/U8Vdua4sVdMt2MObws4WQarIIyfLiq/6ObFXasbIZe1ac+gRvYm28zrVW1o
         VB+5qIbOHrmVlg6LEqc+4axVFmWwZkmo0NqKyLOHYcPHl6wVKZuLPe/qbJ/NPeOsMWIR
         in5RphwO/PZF0KzgZZdNmltFOnS+VuM7Zo80SLXQ1hufIwkSIzDQJEW+ROY+RHEHvHxK
         PqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722916277; x=1723521077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/kd4WiMmD7cvf5H5grwZdB0fA+VVTIeAtsfQV3Ag+U=;
        b=iw/dVFNNbfZ5NJ+l8vXzNEF4f+eWPMpgIyM5eZ+xmXeKWe2NdBYzhC8RrQEdroMZkg
         WjJdekYE6oXmRDBbwiWAbYOfM/4+g+w9QUtcbhzVbuaLEnk18j51jUjou8YBk/vADg9G
         AxUvjan1vlpe7cIo5cqDt663ejthjBJZA4SS5pS6THwXzhtX7CXHH+1cpOn//Ey7Jvrf
         6/MSCj+xtoDrSjaUgdcjAITJXlTqypcOACu4Wc0K+VQvnlmcl9DQ8jLKRcIZxVwQYcLD
         Q0LyKvht/9+7LqR4mFdQZDGF4aqSr+XyO+vE6XuGRwtqYrSXSJVvwipLu6NGVQQjjeeM
         KaYA==
X-Forwarded-Encrypted: i=1; AJvYcCWGbB2URhxUzEnELooS88p8BSCxJ9lN8EBG5fu7UssUEKG7spao7IITZD3M1EX8QmeDHouGyxrdVhXKyze8Zc4VEj9m70dbwE9RIp9t7EPM+MVzJJws7nkftDeZEBeVgjFn11D4tp8ir2LCHyKCIqDr431BgeMVog/s8O6M75h83flN3JzrWpMv62O/VUCDvYO0WSLDrMVhQmnG53rBHUTg0oTGKbGdvrNs8zsxHtGnAfZzLNxDehVDeISR1jwbZhSs1lGqH6+WgqR2gyiKerjNpdJ/R2WZc97Z6IjJJM4a8HuEoknOXkSsYneDcWtVADdwyU783Q==
X-Gm-Message-State: AOJu0YxsiQVXpPfa+UCtdefoQrgjd4z3toFYC24OBUmTm+zMEg1YOAlO
	JVVT2iYoU+3CEzq7s5rhG+/SW6rBJvfPnUhMTQ33V05beFuAsvzifWk3NXRhaZdwoDuGLA5lIA5
	AncdDMRJ0DWu2Oc80EDkUCuDxD5s=
X-Google-Smtp-Source: AGHT+IE2RlAR/mG/tj72IoVOm1m9SyAB0Xj2ZC0vDvmPd0pDeOdqpJgJne85/B4nYiYlXvIL6sxOK+OpkyaCbeLF13M=
X-Received: by 2002:a05:6214:5687:b0:6b4:f973:d423 with SMTP id
 6a1803df08f44-6bb983477a8mr176949846d6.7.1722916276927; Mon, 05 Aug 2024
 20:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com> <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
 <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com> <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 6 Aug 2024 11:50:40 +0800
Message-ID: <CALOAHbDPToZDrsB2wSp6Ss5L0ksrCb1ufx3SZ1GWeqQ2jP7Daw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 11:10=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 5 Aug 2024 at 20:01, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > One concern about removing the BUILD_BUG_ON() is that if we extend
> > TASK_COMM_LEN to a larger size, such as 24, the caller with a
> > hardcoded 16-byte buffer may overflow.
>
> No, not at all. Because get_task_comm() - and the replacements - would
> never use TASK_COMM_LEN.
>
> They'd use the size of the *destination*. That's what the code already do=
es:
>
>   #define get_task_comm(buf, tsk) ({                      \
>   ...
>         __get_task_comm(buf, sizeof(buf), tsk);         \
>
> note how it uses "sizeof(buf)".
>
> Now, it might be a good idea to also verify that 'buf' is an actual
> array, and that this code doesn't do some silly "sizeof(ptr)" thing.
>
> We do have a helper for that, so we could do something like
>
>    #define get_task_comm(buf, tsk) \
>         strscpy_pad(buf, __must_be_array(buf)+sizeof(buf), (tsk)->comm)
>
> as a helper macro for this all.
>
> (Although I'm not convinced we generally want the "_pad()" version,
> but whatever).
>

Will do it.
Thanks for your explanation.

--=20
Regards
Yafang

