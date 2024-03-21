Return-Path: <linux-fsdevel+bounces-15026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DAB88615B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 20:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F344280102
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 19:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B397134434;
	Thu, 21 Mar 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUKc5GZ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548C79F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051057; cv=none; b=iUg4uB0PotbkTNFCGXDAx2iDJaR1+qS2VT8tMSwOeSmbuwMrTUQ6yJyYKrb11VypNwS/3HjZUqdspWcVU9jx1xnmOVuXANJU3ZDRZp3IEKinS8gUv7gGOaSG2S9iG93Ai9pi16ZurBm6f9kKqh6boGNQb9i4+9mS6eTfthl9NfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051057; c=relaxed/simple;
	bh=ACQEgjHXrHrKmVUN1e84w9K08GUoD7rvTF7AzK/2oLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMeHaGdMZ074F1jUJYTPwGabvTNAi+mno/+CPknJQE1MZmGQp2yk6LHKluH+fi7EPBK1niTNqw57A8T+eqS0nz73c814xEiOxXsO16mhE3kyUT+fhFT6mqFXOWb6oW0IO63MiS7OssFujlGbSyPdImJIRmrMsWr8JruWT5rAurw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUKc5GZ0; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512e39226efso1166399e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 12:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711051054; x=1711655854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck9XtKTBgRiwFDSQngG8cInr2uoxIAAWioBX8TmAnyo=;
        b=EUKc5GZ0tCVMydYn4Zjgc59pIQW6FtI3oUrKP4tTiXmoc4Wf7NYzII4ZrHP4zdeKJP
         4ztu6DX4lhWEeF9WTMioGrhUhtLIhYI/UZNeSY4V1BsqVecn881JdG71Cw1ORYnXx7Fw
         oozS2IzoiNesxe8stXlvIE93EKHi8/yS//19piK1S62M5nZQzuU3dBLCTxQSDez193lH
         zvsmtvlnqsMAjDRwaLkV/PKjSmPuGJgvGip9fV1lw+tkxMPjyqJuhViNWrureVqF/B1p
         BuGryC1FS8bW+O2zzKxHesVlgNNFZFKur3Z/HSI8JAPbbVxYnSeEPQnkMabrmvCrn+aN
         txOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711051054; x=1711655854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck9XtKTBgRiwFDSQngG8cInr2uoxIAAWioBX8TmAnyo=;
        b=vUmGRrDl9ASgxf5HWvJ17gxpcM9Enn8JMh7VtE3rBRsXvZxWSTD9Rzd507+NmVGqOp
         zH59RpC2lycuk9WBG8Zt1ysXlJ5ecwS2PIe5a2hfK5XWy9JGTSa2CokMWWQB/b5lmIau
         xjcwWYkrXotxZb/X5hqMwFaHBTk7/wNuOytmRyxolsEmXxdRELpXupoH2LWBQPlSKjNk
         TEGzWGjTe1Nfdsbv1dzd5T1ZwurV3vSs58EXNaEJGYzT7wKrZzUSizDeOY/FVjXknj1f
         ypMW8M+o+6rSHMR0I/9tm4+n5fUxkenwAcFp0Kn0gsllf8BoH8NxR8LAszLhs210purG
         4w+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXinqdIvrwu5L6FekxPxeCVPH1o08Sdyn7BstebWPQAl4ImynSE9VucjskguCTNY/AQDfwgEKOc9WfuFcJve6lZ8iDF059QTQU+qElULA==
X-Gm-Message-State: AOJu0YyV/JH1kmKY4xJGp0zU3fXJeuoQb+o93OyR6RS5HydlU5KXHYzG
	/f/LarD5wzIU/BYnaT8pbn9V7BhMDxIqP15ej99aLPrCMaSB0xOgCgMsCQeeTMbYIPvaNT0+6lJ
	6vDzCSYy11JPWaPM1fJ+gXMAwDnUBC132Y9c5
X-Google-Smtp-Source: AGHT+IEm3LB16hV2ttktwzI7uFI9wHrobF/GyRBvFlFKy38e078SgRE+nrCXL99kg0aKWSlsYgwHdwgeQSI3HPnhMyQ=
X-Received: by 2002:a19:ca13:0:b0:513:da24:fc0b with SMTP id
 a19-20020a19ca13000000b00513da24fc0bmr247849lfg.33.1711051053968; Thu, 21 Mar
 2024 12:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-strncpy-fs-binfmt_elf_fdpic-c-v1-1-fdde26c8989e@google.com>
 <871q83eepl.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <871q83eepl.fsf@email.froward.int.ebiederm.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 21 Mar 2024 12:57:21 -0700
Message-ID: <CAFhGd8r_Z2m4akKTBvxy7s8Nwc1HLUE+uKu31mAya5QQyhBhig@mail.gmail.com>
Subject: Re: [PATCH] binfmt: replace deprecated strncpy with strscpy_pad
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 21, 2024 at 9:23=E2=80=AFAM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> I am perplexed.  Why not use get_task_comm fill_psinfo like binfmt_elf
> does?
>
> It seems very silly to copy half the function without locking and then
> not copy it's locking as well.
>
> Given that the more highly tested binfmt_elf uses get_task_comm I can't
> imagine a reason why binfmt_elf_fdpic can't use it as well.

I am not sure why the original opted for strncpy over get_task_comm
but I made the replacement without being aware of the literally
identical code present in binfmt_elf.c

I'll send a v2.

>
> Eric

Thanks
Justin

