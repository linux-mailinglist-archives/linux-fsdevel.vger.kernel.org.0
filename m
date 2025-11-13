Return-Path: <linux-fsdevel+bounces-68269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84657C57B75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5FC93455A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3206D1F2BAD;
	Thu, 13 Nov 2025 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgp13ZU6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA150184524
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040870; cv=none; b=uJZ9xLA44yUqscQ8Mh7YUFxC+i+AcRfOQcbplIZxCrLvwUB50WI+db7jSqcM5bGqgNuGnkIWkcfQ2xfm2gmfrP422GABbBDNZ7+WFAcr+zKKMCcDJBmVXRDDKZo4ZHEFGnJIrCT4OhcWT/EzgWWNKNuXEB1L0h9oDnaOuadarXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040870; c=relaxed/simple;
	bh=xSuAWsrB+GTJiuXftbiTStIICDoDtQ0BHogVwv2YUEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KazILE6JnKAVe7ZCb2hkBqIPs+02sl2IvgADZa/nlvHl5kzbR7GttYpAVoZ6evcOYqlP3n4IB5jz5NmIhghZQGjvqIp60+EOieB4NfzcFMy1iEVwi1zF6sYoDRO6M4fkSPepPyOry17VgDd5+xmH9d6nIEM2ixiKmdgdKp2DGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vgp13ZU6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so1597440a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 05:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763040867; x=1763645667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSuAWsrB+GTJiuXftbiTStIICDoDtQ0BHogVwv2YUEs=;
        b=Vgp13ZU6bWVPwi//9XGBzu7or398DAv2lpAdurSFoWrjKeKhpbT9E3AxFquJC6u5OS
         3Fjw4lviWwbWruFNvjfq2Ycf5LOMiSkwekR5jAR8EVzVn7fwJerNoTlc40wabFEc0n0q
         GbOtIq5cmrrxRCFZ5GnpDmU3zbH5EHjEf6VMYX+qO85jIgwc2Os2GCB4prlrIgyKr0fp
         CpcSKgi8AfSlvUCvs0c+ElD+7bkkwfD4njCdrRtp6kJ/lxY6CU8F47fvM4qrk9d08/U2
         ECrt3/fHCh8LDtwd8lD5rA0X0tPNRqPe/GkVdwJA5Xs2y7ueLHd0pqemQDrfrgmRvOV0
         AITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040867; x=1763645667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xSuAWsrB+GTJiuXftbiTStIICDoDtQ0BHogVwv2YUEs=;
        b=o4CjvjHeaIMlDNk341IYpjmLxOL5fyA1cMJLopCyiFHyDXMzBLZ/eklfvhkUD0pwzr
         ACouGwl0Qk2dgnc4QI1vbjASFihCvtU0GKpaBIN8jL4GZjHv9AGCyHym1D7ep91O75oD
         e8oeUXaMAGLAfevQrmUgNXXspgLh2xH4ElfsuP4PAY0Q7igktpnqUGuCjLN6e0frGFRy
         zqMWIeNemRCVkFblqd2ubtidC+cqGT3f5oOXZBw+iiJJdKuHNrIyKNOFdXdQPGf0H2eE
         Anw8p08ssgsPArz8sJM6rPViiex7qfTqOWfmXVQD+CY1+zuA8vzQ1wMv3VLWZFgXpEv6
         Styw==
X-Forwarded-Encrypted: i=1; AJvYcCVuOFDuEpKS3C4ZqSA9nC7PWmyjdEQUsdQbChK1Xx6KKWFVw9PmBCd1MF351pY2wgqrtBVT6rlOpF2JUwnL@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPOi5efMtXJjewHtJtjCDxB5EJSj5Crwub51NxUtHM9A47iS6
	OTgzJ1DTuUK55TppKf4zOCu1wsGKwL/Uyf1wTzVAZovmwP7fiaXCqiFu1k9dJKw6muHZwBGu/P0
	BX2tzGuyCw4t9H1i3c3fd/7bk0drXaXA=
X-Gm-Gg: ASbGncvVe1WJJIDXbRAjVb4XUDFZBb4pIpD3KlZeX+fs5bsvofQxh5/5d+jAelMLYKl
	8KKofaJ1phXjigyibyl5wLmp3KONXVkTng3dpjYYiz1ynPdlmvdCAttaC7atb91bphXBWhQLB+q
	ERZHjLNOszTDZOAmEHYxdrGxd76pIDd/OaVeZ/DtnOi1cIuuRTx3VCLJ7MeqNQuXr9nK8t3J1Pn
	cSyh6scilJa8c/N54LdD5K1K3dPsukDACweSJcZXg7T0QJ2UY34WeJ/pqjGHW7xwjbU2/EMtORf
	0zPoeAL84ZT6TPzgtiQ4mVAkXMu1Fg==
X-Google-Smtp-Source: AGHT+IGF6esb7kGa/crhjmb6/aWLvTJVqnAAYAvGO0s6QczR+42b3/p2M4bcL9sRn+PV69DMVD/y4dimDrwFh8MqTEw=
X-Received: by 2002:a05:6402:27d0:b0:640:c062:8bca with SMTP id
 4fb4d7f45d1cf-6431a5481f8mr5585662a12.18.1763040866928; Thu, 13 Nov 2025
 05:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
 <20251113-work-ovl-cred-guard-v1-3-fa9887f17061@kernel.org> <CAJfpegt9LQe_L=Ki0x6G+OMuNhzof3i4KAcGWGrDNDq3tBfMtA@mail.gmail.com>
In-Reply-To: <CAJfpegt9LQe_L=Ki0x6G+OMuNhzof3i4KAcGWGrDNDq3tBfMtA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Nov 2025 14:34:15 +0100
X-Gm-Features: AWmQ_bn1bXyA9VHVc-NJr9ApkEqL9TN4PRjFv5uuLP4grJaaT47tUE3C-uFyGpM
Message-ID: <CAOQ4uxjnmLiLzM-a1acqPpGrFYkLkdrnpuqowD=ggQ=m72zbdg@mail.gmail.com>
Subject: Re: [PATCH RFC 03/42] ovl: port ovl_create_or_link() to cred guard
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 2:31=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 13 Nov 2025 at 14:02, Christian Brauner <brauner@kernel.org> wrot=
e:
> >
> > Use the scoped ovl cred guard.
>
> Would it make sense to re-post the series with --ignore-space-change?
>
> Otherwise it's basically impossible for a human to review patches
> which mostly consist of indentation change.

Or just post a branch where a human reviewer can review changes with
--ignore-space-change?

Thanks,
Amir.

