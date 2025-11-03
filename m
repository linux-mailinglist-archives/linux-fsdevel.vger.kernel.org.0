Return-Path: <linux-fsdevel+bounces-66819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A073BC2CD3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C43189A0D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21A431CA46;
	Mon,  3 Nov 2025 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="XWIY9mFt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4724C31AF3C
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183212; cv=none; b=WNXBJUwwRA+vWKeLAd76qn0hz5RZ38O6IuOzgwa4LY0FORmhfgp339Z1L/wf3K1qXOqrngNh1XCm4dso5izZ+T+ssyCsop925RH/+MnQ60Gc0VSLX2TRdhT4CqnYhkCP2vJWLmMQr3q5QQbA5r2t17b7b8ElckJWsrWr3M8JdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183212; c=relaxed/simple;
	bh=QS1ElmiWGQ8d6SqToAtWmVYVs7aFmR5jmQxgEOOJtxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VG9xzaE4y3V/+5XaImQMEWtP6Z/3GHGfXj/MCa1+TRITFjAmoj7/vGs5PcQ4LfnrB+Tx7gJOOsSB4lE3LtmAvfF3t0vCzN16odJcN0iUbnQGjZxsRFAtKToOkG1heKJ+lS7r80HTmWVgNQ6cdazpuadXJ3xPUddRSQTtAf//yM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=XWIY9mFt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59428d2d975so1445943e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 07:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762183207; x=1762788007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=swWtueJTD1lLAj0Vx8RWi3wNNzWbJ/rmL7j4fFwS3eg=;
        b=XWIY9mFtpXyhud5yq+Ux+/lo5PGYQuUSCVSRU36fC5DaZL+ChWTAUCuMTBr9Z8+Pkc
         mHJ5hkC73UVOJ3C7EVaYhFxQ6AjU53+HUiMSA9ImZzxDYv3GVgrgxqa4i7NsEhLTnQRg
         ZN/P84hLzTSANHXCZAva9VblzrgI5UCoRppeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183207; x=1762788007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swWtueJTD1lLAj0Vx8RWi3wNNzWbJ/rmL7j4fFwS3eg=;
        b=acS7S0lU5KhdxR0G1v+/KcAFLRwK3G9++4fnBh5PmSjMJACUhG/V7M4WNZiQjWY4FW
         Bet/2EjKZpR18cc2UFMNvdoBH5CBHwwREH+8QM0nQoAkIihRvq9cSgLA9keT0pk+fFYp
         n66XQrj/wv5G94Npz9Ld8PSROuS5H+jIBZOymQXVhNl4bebIOAm1QHfG4BDZcoGoxvy8
         kPSwiiT2iegUAcXPS5LmL/ghWtd/VLpfwB3V9wpMDTibzkb+WuqN1YNz6vKcP9Imx7sv
         JM4jQnJTc+yWCNhZdPP3MIIuktL/M003GnBLI9KdUzrZWvGqdc6Xec1No66zIP014VVJ
         ZtAQ==
X-Gm-Message-State: AOJu0YylOh8p8hQv5jJfUQVi2WCn2hva/sOt17TzOnSVjhQY3SCALdL1
	KomVwmwC58XAoTnRRxud/j3AZmgLUqhsi39mKYR0q4IB26un5lWMEBfnEvAgx+Ov67JOO93ChYK
	Qv/baMgHxRKETY1P+VsRDNvbKf4xluwU+Q/eI4HXleQ==
X-Gm-Gg: ASbGncvqQrmDtgaHT5RHTqvyg6pytEHEVtrcd0ckZEHeDEKLeeHvzb2cHBIo2AA3n6c
	a5azRcq3fxeKTSgBLTc77PwgakLFrgGCPbBOCadfi5XiLUQds8U5Q5xKhu02psEk/aUhmn942+R
	bx1P3HwnUT3sVFrGUxrcC6QB14/DWt8y7F/jUvZuzVyrujNfE/MCoZELxZGs54+GZ8fxYT27+Uy
	CeAqVHW1JpO7AvHxHBH0gjrzLLtCeJPPCIcbAcEHcLZFb0LwLLLjMyOsdHa
X-Google-Smtp-Source: AGHT+IH1cXvY32biC6d9IC8g8KBhsDvrUFBnAjz78J5RdRKUTPT5+cM+MWvSntweydUvtixKj17jmykz9aBU3OYssOo=
X-Received: by 2002:a05:6512:2212:b0:594:292f:bbe9 with SMTP id
 2adb3069b0e04-594292fc192mr1635258e87.36.1762183206953; Mon, 03 Nov 2025
 07:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-1-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-1-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 3 Nov 2025 16:19:55 +0100
X-Gm-Features: AWmQ_bkzsjh63BlFZ4oGK_EUFCxELlywhVux4yTLgGIGyeMzLSBxiwaHojVQJLo
Message-ID: <CAJqdLrqy8OoGtzobGdRO=+AqMejesUnYcgzjrk8q4iueHiHJjQ@mail.gmail.com>
Subject: Re: [PATCH 01/22] pidfs: use guard() for task_lock
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
> Use a guard().
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 0ef5b47d796a..c2f0b7091cd7 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -356,13 +356,12 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>                 return -ESRCH;
>
>         if ((kinfo.mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask)) {
> -               task_lock(task);
> +               guard(task_lock)(task);
>                 if (task->mm) {
>                         unsigned long flags = __mm_flags_get_dumpable(task->mm);
>
>                         kinfo.coredump_mask = pidfs_coredump_mask(flags);
>                 }
> -               task_unlock(task);
>         }
>
>         /* Unconditionally return identifiers and credentials, the rest only on request */
>
> --
> 2.47.3
>

