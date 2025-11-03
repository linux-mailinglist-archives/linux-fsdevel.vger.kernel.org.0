Return-Path: <linux-fsdevel+bounces-66823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3630C2D079
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCEE46387D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED8A3128DF;
	Mon,  3 Nov 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="gY+Djymc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F02D12F3
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184207; cv=none; b=Fw2JwlrU2M/5HvIVBeelXUqSyG/TXcC/tP4+z2EXCAtqzAuHhSb0MsI2OIC5dx7EF2dfLSqcy1MSEDABasAMNzrmXU+u9jttpG+oPsFuoWcJtUvHi5F3TZRZhcmNfIQBrWYrCxkyzTpJRb/NQ9d6u4E3K8Fpim1CMsJi+tah6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184207; c=relaxed/simple;
	bh=ikVP98TfiRRScnRxsnU1IXkxvzvmFrY/j1DS2qMbV4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iB4PT8MvBXUNns6dOy2sBI0fSQ3gpUDerPHI1gHkyQ17SmP4UYgZBaG/AaIUa5C2SxT8Lh9OXBao/bUNthpSQK9288/P1ZJKUqKqJusd6haiZPfQw5jPFAQegVgzQFG5gE9BFKw4CWXE2zwk/+LhK2cfZ4k3XWofjEhULbDiDKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=gY+Djymc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37775ed97daso54408461fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 07:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762184204; x=1762789004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MYFXjvaUMn3RT9j1VhXINzYM8N/jgwBZb//bniINmBM=;
        b=gY+Djymc1FioOPBYjn12Q/Amebgth4LSUPz439X+b2xDKLT9ruzKJrmdvQ9CwVx0SL
         azMpWeM5l6UgQdGXMxBH77bRe8PHPykQwDsNfbtw3/ljOsnczRsqA0HuMxbZeQZiFHvr
         4lfga6g5BTDKuBCF2KVvZ904nS4ymA1pPHZWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184204; x=1762789004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYFXjvaUMn3RT9j1VhXINzYM8N/jgwBZb//bniINmBM=;
        b=JFcTL7h5lopyBplGoOkv1cJClI1pmVAwgUMouicVl1lP6pT6UO/RJ70cDRbA/KjmNg
         7+ZVqMDcjWLQeKw99GMb91iP0+MDgLOMR9f2IVT0jdfZy2uy2v4h0g7xfPmQgh0zxOFM
         q5EV3JAcRZIYKs20LI4IDX66C9Kn+KmbirKum9TRhw7ovVYKpmqbaEZpKOI8WM07AO0n
         HOIMrOYJLWicZOBY+Nzu+OhybhnBLyYAcNTw3obP+uS0XJ1zA4NIdVfFp4Jf1EJpEgp4
         QAldciTdSpLFSlWGVHBlbzoknPrLPf7D9f3gG0x4GjAGHYvWNaPll3c7XF+vVPD8e7/o
         Lgkg==
X-Gm-Message-State: AOJu0Yz7WZwukjEGg+t5wZa6A+f+VsYwo6k0grbd/NmvD3uIxnYCCV0/
	TwOKMgJof2HezQkPd4K5c5AJe/tBDHXMu2cCYaqqfRzMm0WMRirqu8hUtpdu6EpnW0tOpIHua/p
	GvM8AaGcwrZgDLX7LYiDvDTgYG6oAuksW5OAKX/z+1w==
X-Gm-Gg: ASbGncvwuEmvR7RrgUu8zsHyyrOiq3YRTe+6V9pu3JHWE7UaLyjy1kJ24lpWZNtV2x1
	56N5iJlOQx/k0RzwYQvM6jApxyIblxxYE/J6un2fWQTJe4Gb7Xuox+jSOtP8XFuc/vLsyDxVVd2
	9SB2CddRPUE2rafkyzSDqgHkviJ0me/qtdbIM5tH4ZKH6HfjAZbjCu56dfFa3247DPhWxN4SP9G
	aRW+x/0eft3fhX3T/OMlyrijMdPR1F6Q7sY6OYF9uhDgNX8fFfxxcGz62Tu
X-Google-Smtp-Source: AGHT+IFi7UO7rnjoss1+fg9U6YEcUF6hllcQqEKbYq0KWBD+AXmqXAUDoWxNdc50GuqKKu3zTdKQDg2CK1jYQhNpAWA=
X-Received: by 2002:a05:6512:159c:b0:594:2c42:abd4 with SMTP id
 2adb3069b0e04-5942c42afafmr1339827e87.5.1762184203826; Mon, 03 Nov 2025
 07:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-4-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-4-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 3 Nov 2025 16:36:32 +0100
X-Gm-Features: AWmQ_bkajVHUGOSjuUyvKnAOM48UBvvzrT4R0yioBSGxJGk2W9s55McYYFL6ZJg
Message-ID: <CAJqdLrpdwVu-aPpk_+7tqrjez6h7nW4Eb+-aDK=gSUnY7JCcJg@mail.gmail.com>
Subject: Re: [PATCH 04/22] pidfs: add missing BUILD_BUG_ON() assert on struct pidfd_info
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Yu Watanabe <watanabe.yu+github@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 28. Okt. 2025 um 09:46 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Validate that the size of struct pidfd_info is correctly updated.
>
> Fixes: 1d8db6fd698d ("pidfs, coredump: add PIDFD_INFO_COREDUMP")
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index c0f410903c3f..7e4d90cc74ff 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -306,6 +306,8 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>         const struct cred *c;
>         __u64 mask;
>
> +       BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER1);
> +
>         if (!uinfo)
>                 return -EINVAL;
>         if (usize < PIDFD_INFO_SIZE_VER0)
>
> --
> 2.47.3
>

