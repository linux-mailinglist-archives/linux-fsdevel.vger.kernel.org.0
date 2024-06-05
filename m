Return-Path: <linux-fsdevel+bounces-21011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360E98FC202
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 04:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD982B220BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 02:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868C6BB26;
	Wed,  5 Jun 2024 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbDxYfSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D19F9E9;
	Wed,  5 Jun 2024 02:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555774; cv=none; b=nr9iaYB5pQQRtkK8yrWuQZ43cvqOj7jFkkYLZo/lIk+rlpbpddkuNZksjLs+jcuFOrwQ8BeOte3SdOrURNjEirQd/UGOje30COWtjDT/KmqgTeq4sw9LQk3pwbX4ocxv90JgtncjvW3xTwDq76bWJFx560gysN2p118VKvkQ5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555774; c=relaxed/simple;
	bh=F0SsIy3+W19LLpvn7Tlg14aUoOAuRRvMVsUgVQ8aDAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxnGFbNhMeeTWfTecvKyEfGiTx2sJvRAQ8uup7nobS081ELpogyrBw7gFb3GX3KWbY3WiLBEiwW0/XrVxaF1OMEe1rd+B+T1sCoTKXWWYGKP3zmjFKOvBPJf3w3UznlNbUvg0PHs13dnhNfNOZhTIyn4Kyn3ehYNlCaUn2Uxnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbDxYfSv; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6af27d0c9f8so20564986d6.2;
        Tue, 04 Jun 2024 19:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717555771; x=1718160571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2saUQpdqdIbqLGxvd8R0wiju4YwezRrdt4faqpUQys4=;
        b=gbDxYfSvspenEyveQjmbVoQhfLbxrugrohbD5BwxIdYKwytRxZJG3LEuuGAOfjaXdR
         spqfWHc9RCFCtPriT87vI1n1MlF4tqyopdaKQFN1GVYX+10tLmyFL3RLFLvyvSBqr6Fs
         1pf8Q0MVOHYhFhl/EoCRgxxDTkhQnUYB4GBTbEvfqjQ6vELr6tN215UB6+3lBOZ1h0LI
         W+lg+nw34mrqDrh8IGQ8CiLWPdMrzE1UrU6XxOnalFiWG0bZQWtE4L6nyDBF+lIcKpyX
         licf6CbHKyFg43jWU4+hVdYXQ9zO7o7+KXi4YA0AWxFC1nBfnGaUrz2U9UCksk9tTCVb
         QAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717555771; x=1718160571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2saUQpdqdIbqLGxvd8R0wiju4YwezRrdt4faqpUQys4=;
        b=JECJIAuCiThd8zcTRVo6iOihB1qTni7uoon96La9+A0hGfT435LcpHBk9LBRh21Pf7
         tGNtCUSuKSJdnKx9Wls/9M/KkjCGMMV9RFE+IDm3D1J71hgN/FPlsrIvbSDwD3AzVAWq
         0ty8/l046ePf9Ky/KFHemKYMiPRWDvfBfo7d1o/bQQPcaVIbf+wuVXQyyERekVS/7LSM
         CoybtOHWBq17UCCMTa6wJbxIG0i7FOS/aYm2vzvqbYNt+yNsox8pMfLeKfprdW1lKOaN
         DhKo87CralDtYs6AT66U8qpaOZxXTgHtsurnI91Q35CURA/0dgcCsBV/OJANLKCGm6fk
         7CvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHBItQhioDoqOiyr1Y/0hyYYVVZxL5Q0de+LJck2RBmhGDPYBHyjMVFTNFuSlfZdk22O0zf9Nf/4WpwygdGwoxPmkHCcSsp4yhSpcm31WUhskiVF5qyF06uUiub1Nz1Zx7luybarSG7aRAypwHV0lbKOnjs5nszaf/LI7/1NgmDE/HeuvVhtc6f/eyTYbfbNI297AiCLxjpxtkZWefsNlOSPS8t60O02suLE+ziBSbqmWHPxQimuTU5mzrioC5y6Y9OKzSZb6edHdK8Vs0B3lxE+L4bOCQATZDK2EZQw==
X-Gm-Message-State: AOJu0Yyv60dNijPxmrL7EC43g2WEFkIfAspFKCEkDmqw+IyiBZg426nN
	9cGYPbQqQ2oINAbe1P0owqpJpYsib6nrSozEVFnh7wwi4yR7E8LPVhp/eqXkA2hrgNSknK7It/k
	nrrBS9ZWOXYivW1j3115QWOZtjoRslewFGbaeHQ==
X-Google-Smtp-Source: AGHT+IFq+yCl5o74ZjH3g13NJDso8wQ5+sJqbQadqfrtImzCDvp3GWtQvEB2R3IWUMP4fI/FfSN1B6bVUP2acYQYprE=
X-Received: by 2002:a05:6214:4498:b0:6af:d47a:1421 with SMTP id
 6a1803df08f44-6b030a9d410mr14097896d6.60.1717555771212; Tue, 04 Jun 2024
 19:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-2-laoar.shao@gmail.com>
 <6cf37b34-c5e4-4d92-8a60-6c083e109439@stuba.sk>
In-Reply-To: <6cf37b34-c5e4-4d92-8a60-6c083e109439@stuba.sk>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 5 Jun 2024 10:48:55 +0800
Message-ID: <CALOAHbC-DDEhkTwxinLnfFo_quoNzg4ADjJAaZDWNQ0f64Dsiw@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
To: Matus Jokay <matus.jokay@stuba.sk>
Cc: torvalds@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 4:01=E2=80=AFAM Matus Jokay <matus.jokay@stuba.sk> w=
rote:
>
> Sorry guys for the mistake,
>
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index c75fd46506df..56a927393a38 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1083,7 +1083,7 @@ struct task_struct {
> >        *
> >        * - normally initialized setup_new_exec()
> >        * - access it with [gs]et_task_comm()
> > -      * - lock it with task_lock()
> > +      * - lock it with task_lock() for writing
> there should be fixed only the comment about ->comm initialization during=
 exec.
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c75fd46506df..48aa5c85ed9e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1081,9 +1081,9 @@ struct task_struct {
>         /*
>          * executable name, excluding path.
>          *
> -        * - normally initialized setup_new_exec()
> +        * - normally initialized begin_new_exec()
>          * - access it with [gs]et_task_comm()
> -        * - lock it with task_lock()
> +        * - lock it with task_lock() for writing
>          */
>         char                            comm[TASK_COMM_LEN];
>
> Again, sorry for the noise. It's a very minor fix, but maybe even a small=
 fix to the documentation can help increase the readability of the code.
>

Thank you for your improvement. It is very helpful. I will include it
in the next version.

--=20
Regards
Yafang

