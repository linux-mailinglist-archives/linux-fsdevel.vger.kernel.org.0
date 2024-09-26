Return-Path: <linux-fsdevel+bounces-30147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C79986F95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 11:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F1C1C241DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589E51A7254;
	Thu, 26 Sep 2024 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRBI1dMI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D23D1509B3;
	Thu, 26 Sep 2024 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341609; cv=none; b=DACqARC6vc08Pd1ETmnXDSwkie6pSeXUjnYS+81foclFRvbdB8na4BRur2jSuX8k3CKuZif6kEAjqwOdA1W8xcrDQ59UJkZsvr0waSGKEPEwmGIcLlEM2k557wBwWhSn/OeaehLqm1Mf7tgfNTMiJw/2Q9q+BrvGxCYztqQHZOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341609; c=relaxed/simple;
	bh=xjlG4vhe5lDIlDLuoX9D3U8rTV+9xF/5Pa4Zz9WWw5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBf11rXxOJgl0Tals1SJXOwMYLuIOhDDPJ7MOnkZbI+GtNqMzNeM9q7mJK/vMHXGPsRYSjzkpuaU2H7TOjQ5DdbtU+0NURIzieMCoc9j4lyOtLe55Witic4DbA++12iq3n2+ThcTyVIny0V2eTisC6sXCUb3z5N9UVaJR0IXdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRBI1dMI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f74e468aa8so8416601fa.1;
        Thu, 26 Sep 2024 02:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727341606; x=1727946406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjlG4vhe5lDIlDLuoX9D3U8rTV+9xF/5Pa4Zz9WWw5U=;
        b=eRBI1dMIAg9wfcbIauZg2m3NJGes+nv3tWq9MQkKr4yBXfvQ1r7P3gfzcjksiqIW2O
         VxJGarTlurQcRRvaaHpBjULrNJAUQ/yJTovEQD6IZSQhP063gSJzg6UrhKR/ArPWuU3X
         BCMYc3ItGJsC1DKEJXGwyB3+1s8Zwk0XkYaR5otwOYMt+fBr6yqmV3InXbWuqMm5RCOM
         OnynPyD1zkOKEDutAEB54f8bQ8Rw4rZdwcU/EjiXsvoHcAQDzrul3tCouCRWSHoqlEp3
         xJtw20+pDGghu5tBhQOvrGIzm71Lazf61yuN9QsEdSU1lFW2kn8o/htybjMbdVolkU7U
         P6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727341606; x=1727946406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjlG4vhe5lDIlDLuoX9D3U8rTV+9xF/5Pa4Zz9WWw5U=;
        b=ZNkY0LJK5jNeuL67HcasdVLTTf7B3Q87zKBMDuji1iLI7JLmzQ0AdxUFipXQqhDDEW
         YKu2nZxDGlIxmoxCTv9pFGjqWodypyfomXj4pF7hB0jalq3xZ2WKBPZkKiLFXUWVglrp
         BmaUnTT/c/YcIMGfpnDzsfeqHO1m+c2CLskaZp9EyqqQAJ1jj91UxgyZZIbTUzV/n8f5
         UiOQ1+7qeeVBRlwyUAOEhVk+nnFYPZmLIEnpPIsbJire6jM8wCDFXcMo1YLFGpfUFBkV
         0yhnOVtBYzkatKCPASbQGGArolhKUcTJqrszmrYEtudgLxZzSZ157zznFAI3Fq1oS9Kz
         Sshg==
X-Forwarded-Encrypted: i=1; AJvYcCVJtyafZgW1AuA1USFryG7GN7a/j+1Nqb1YrKIFtsMpH3dim8J8LKNmib+VDf98qT5W+y/79kMbRyU=@vger.kernel.org, AJvYcCXA7S08Yw0/gzCHFVINu4ZiFlPnTj6VHmpBOfenbyD4k/0nkLKAKgkFdvoXE5EJnE2UxssyNpKQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuw23vtPY+Onq0Bc/c8X7D36cNr2LBaYnLL3jAhtfWo7owv6Vu
	HmOTgT4aiA23Gm2qDRTfoPiG7KIGuBC649M68Q65j+vdEnjbr6HV+hEKZssqKxUKS90zvE3VoMG
	QcsPAJ1m84C4GTAntzMH1/RRqoEM=
X-Google-Smtp-Source: AGHT+IFFCLVN7yofxMolrQ5qw3MWZ/hsjGdbAanwDrKb3Vc4Ocy11dvdGdSddKnBMI2IS+UgbAQNofxdZPCl8M2dcOk=
X-Received: by 2002:a05:6512:3d20:b0:52c:d76f:7f61 with SMTP id
 2adb3069b0e04-53877564959mr3694125e87.56.1727341605703; Thu, 26 Sep 2024
 02:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920122851.215641-1-sunjunchao2870@gmail.com> <20240925-anflug-flossen-071b110c324b@brauner>
In-Reply-To: <20240925-anflug-flossen-071b110c324b@brauner>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Thu, 26 Sep 2024 17:06:34 +0800
Message-ID: <CAHB1Naj2gZ7CuHeQXMNtYfRaMarRP85SEXq7YfWB0NQu_hzB+g@mail.gmail.com>
Subject: Re: [PATCH 2/3] vfs: Fix implicit conversion problem when testing
 overflow case
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, stable@vger.kernel.org, 
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Brauner <brauner@kernel.org> =E4=BA=8E2024=E5=B9=B49=E6=9C=8825=
=E6=97=A5=E5=91=A8=E4=B8=89 16:37=E5=86=99=E9=81=93=EF=BC=9A
>
> Unrelated to the semantics but why do you use 2/3 numbering for a single
> patch? This is really confusing.

Sorry for the inconvenience. I used git send-email --to xxx --cc xxx
./*.patch to send my patch series. My intention was to send the three
patches together as a thread, but it clearly didn=E2=80=99t work out... I=
=E2=80=99ve
tried Google and ChatGPT but couldn=E2=80=99t find any information on how t=
o
send a patch series as a single thread... The other two patches are
here[1][2], but they still need to be refined

[1]: https://lore.kernel.org/linux-fsdevel/20240920122621.215397-1-sunjunch=
ao2870@gmail.com/
[2]:https://lore.kernel.org/linux-fsdevel/20240920123022.215863-1-sunjuncha=
o2870@gmail.com/


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

