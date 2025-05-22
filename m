Return-Path: <linux-fsdevel+bounces-49656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6BAC047B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 08:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE9E3ACAF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 06:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7D22173F;
	Thu, 22 May 2025 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtlqP6ON"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BBA221299;
	Thu, 22 May 2025 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894726; cv=none; b=JphN4QcOvy8b8rkS266zDNwWTe1WIzsQ/YjqN2qsXRmBIhYCO3mu/wBWJk3KbvdhHGyIvZ+ueJqjQKUkS5gWZrQTkkV5m40t87VzHOxWowZ8WiMlRZ8D4HgMfRMQqoGPkvxIlCimYOhd+eINh2qPew6o6Au2jM2h6JZV9eMqR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894726; c=relaxed/simple;
	bh=oJwpwh3y/PB/CRwAnhTVlwmZnDJ+bo5bOGacgDgyPgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elgyvn5A/paEOh8FAsZSFL/7XpJ6uuFnrIcwTqAdD5pnxT6nwtLGnxnDjaWvsvL3mKIawsridVbDKBdduraDbzuIDiTIaPq074oiM3c9vWgnY8ptt27v+N7Esf+YdZcW+AJcV5jo2hDzmDQJ0V/4WGt2bE3ddwPXjCWCfdFdJiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtlqP6ON; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f8b2682d61so64540796d6.0;
        Wed, 21 May 2025 23:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747894724; x=1748499524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAiWBeRbrCxTSOGaCOh6cmRAxFgzgObkS3PNJgd3CaA=;
        b=jtlqP6ONURCWDpLtAkvyvHvQxSOEUqu73DUOCdIOOf3CV58s7eCW17qrwGCX81Cr3l
         qe1zEyXWQPzGTAG5YkwWvFTrbv5ShjgUy3iluhl8c/QwjkcM3+NYChaSIGTOjtrbRcjn
         fV0oGYHTTcBNWlSBbhjn6J0YNN+8SzXJq4u/T8CnLsaeTxJ/WFiTEZsPSHLGxwQi4tW5
         kTQ1VDzvpfcPyavFiZ38bNoMDKtiANubeL5XBINvkjTvfjnC3ptSAGMQAYt1VWx34cfk
         q/khVoLBGcW0KWMzNq8KOLmue+sKi+9Q9YGlPUB08Roqm8ivxw/1A3UVW4u73DEaOQuQ
         hwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747894724; x=1748499524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAiWBeRbrCxTSOGaCOh6cmRAxFgzgObkS3PNJgd3CaA=;
        b=filnXYNMyGdI2o35EQ5E0PGlKyZ1laJ9M9yc/pDezZcd95lgrCvqzuyM/SQ3013rcD
         vVeI+Ke5NZ9K482TRjRODcoiEkI4C43nONj8qsvFEmWQ8UNaghEJsWHyzMJ/bfosx6MR
         d3Nimm8a8FeilXyrAeSgd0x9DSXiSZZfo0r4yK+hnIOfE1FVbKvwDhL5mcgT09l/SAWR
         QKTrvNbdqdRg9pLOFehIxKjlM4vvQ8W8a1JXuQ0ZW2LhLZUxcUc07JJ2FzlumMaGrrQQ
         zIey8KIPM6FXV/TVu1awKhXGIj5aEjx4TUlvLAoMVVDhEPzA+02Fp2fBDVcJcateSLuA
         57Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUqwXGvTsy6GmrRL58EpDENpKYF5v0x2GQfV8xAdPQiB8N97jbXhKuHMYeFGbzXM18lkWXyfoHaVXu95Qje@vger.kernel.org, AJvYcCVVk24zxwO2CfxBu5gwoXoY/Z3eSq/txoRSEXeWE9dKHIi3Mknk1EkhGbcuN8lc0cO0eV4jL71zepJSIqsC8VQnEAG3@vger.kernel.org, AJvYcCVsF540uDeOqs49t9Zsphqq71l6yABY4M5tLWhqj88CaRKsqq/vm4VeinWWeBOyxV7DX1IVNI+bknmPJbyyRg==@vger.kernel.org, AJvYcCWK7nR7r7lejoD4FhlghZSPHwXUFvGb11BWc/A+YavrsfGIboO8Kb6I8Nn5yz4+P6L0Rmp+7B4p5ZKochEzQInqQw==@vger.kernel.org, AJvYcCX6qdDuw2I1AQhz10pwaCnbqXueItJZ6SJH+QnDupV7HT03ZUWXvabygbi/9LK105B3hWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySyjIueKVYuae8O/lRaig9jeRzt1wy5uCHnn0kNXlb781o87/H
	lubtPcyAjqFq5FRHPNJKrNca2Es25H+PrMjyJxOqYPDqftCmg9k3tlDlWLjnaKXrkZPtTD6J1o7
	DBdGOBgKo8OR/ZB+HXiH7/GY1mUAGlg6yh/95WGc=
X-Gm-Gg: ASbGncsp6439ghwdYm14x2E0zoUXDqo+F5BNFytwpyVqyPJuK5nIKM6CtbiPPoOPRxF
	/qWOOGCnm4mTp95vQyK+zaNuaC69HLuMcSinMmbhfdidNKA6NC7P7unRQdHLo6eDbaEpxGbBA3j
	2fmLMlRfSVU8raK8/tSuHpdMUBJPDcF+k+Eg==
X-Google-Smtp-Source: AGHT+IF095o7KgziV/OiFOYLZCRqF+WnHMajqtqVaevy/ymBVxl78I9yj22rngIrp0rCYHfgWrpJMft76skDMOt1D4U=
X-Received: by 2002:ad4:5aa3:0:b0:6e4:2e5b:8d3f with SMTP id
 6a1803df08f44-6f8b12bab99mr292229976d6.14.1747894724203; Wed, 21 May 2025
 23:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521062337.53262-1-bhupesh@igalia.com> <20250521062337.53262-2-bhupesh@igalia.com>
In-Reply-To: <20250521062337.53262-2-bhupesh@igalia.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 22 May 2025 14:18:08 +0800
X-Gm-Features: AX0GCFun7VcY0TRnwHC-yCRhsLLHNlgDgzjUoPDV-Se0yjKg_DkRUffEwpWoMp8
Message-ID: <CALOAHbA9P0af7oVg+QTfFfn5TAyV0+vu+jeNG3DVHcO-OEsVVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] exec: Remove obsolete comments
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, pmladek@suse.com, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org, 
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz, mingo@redhat.com, 
	juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 2:24=E2=80=AFPM Bhupesh <bhupesh@igalia.com> wrote:
>
> Patch 3a3f61ce5e0b ("exec: Make sure task->comm is always NUL-terminated"=
),
> replaced 'strscpy_pad()' with 'memcpy()' implementations inside
> '__set_task_comm()'.
>
> However a few left-over comments are still there, which mention
> the usage of 'strscpy_pad()' inside '__set_task_comm()'.
>
> Remove those obsolete comments.
>
> While at it, also remove an obsolete comment regarding 'task_lock()'
> usage while handing 'task->comm'.
>
> Signed-off-by: Bhupesh <bhupesh@igalia.com>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  include/linux/sched.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8c60a42f9d00..704222114dcc 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1162,10 +1162,8 @@ struct task_struct {
>          *
>          * - normally initialized begin_new_exec()
>          * - set it with set_task_comm()
> -        *   - strscpy_pad() to ensure it is always NUL-terminated and
> +        *   - logic inside set_task_comm() will ensure it is always NUL-=
terminated and
>          *     zero-padded
> -        *   - task_lock() to ensure the operation is atomic and the name=
 is
> -        *     fully updated.
>          */
>         char                            comm[TASK_COMM_LEN];
>
> @@ -1997,7 +1995,7 @@ extern void __set_task_comm(struct task_struct *tsk=
, const char *from, bool exec
>   *   User space can randomly change their names anyway, so locking for r=
eaders
>   *   doesn't make sense. For writers, locking is probably necessary, as =
a race
>   *   condition could lead to long-term mixed results.
> - *   The strscpy_pad() in __set_task_comm() can ensure that the task com=
m is
> + *   The logic inside __set_task_comm() should ensure that the task comm=
 is
>   *   always NUL-terminated and zero-padded. Therefore the race condition=
 between
>   *   reader and writer is not an issue.
>   *
> --
> 2.38.1
>


--=20
Regards
Yafang

