Return-Path: <linux-fsdevel+bounces-70825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4327ACA86EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 17:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16B233022B54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA44B2DCC03;
	Fri,  5 Dec 2025 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AE7wy9OA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56871BBBE5
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953396; cv=none; b=KvWQ5QyP9RcoAgEhJJ/Ol7hAIEexNYpIc41DliUoj3YJXf/as/XTcTe8BwpF/jkgqWx61H0Qdo/kWk2YByn5XILGKFiTLBthDtSVAm4LZVZE2/DOUJHZJ9OriYIemzqXl89R+ko4XzPgdwQDnL0fPIBcWzaZSizLWV3aoOpyH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953396; c=relaxed/simple;
	bh=S44aWYDgH/L//m5SJH8feoTD7x5AMZ2hYNyqwCckyWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbNUWsxlP2tddPyncRv+UsBy5ioc9bvvYLMXhO1zFxAG+LYD/sks2xNd69Z79SS2uR5wQEUi/Y1vZICYplhnQrWy1ApQQyzekw5tcAP75Tl+/7gz4BNVp6KXu5fG8QhxdqYkPs7dtu58FGRENNWLbkadPIH21T2M63115bW0NKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AE7wy9OA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343dfb673a8so2300371a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 08:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1764953389; x=1765558189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFta1eTe061x4aiEFe5juzgftswqmH5K8rJIx5K4PRg=;
        b=AE7wy9OAbs4QrmVIBK++VC2379+yCH7XzbBJu9O6jInGQlBTsI6LBCRFAh8GzUC7t/
         RBO1r0lIx6g1eT7wJbf+8pylREjgHGDLIavvuuAb7Q8MI4d3RDa04eXi/pIWD9T4Ul46
         QUiryhP4HoXJHgvLtjxlYxSqAa4TrkWSPuSoPCFC36x3IeHybuGUgo0GY2AfX2fxKQRg
         NCgHygCuxhCnEyZodLfQM6QqYWxNJTlhNIST8daII+RhBGJHZEJKLBtX40VxSpwMCiRz
         SQp3n014Is2TP1CLA3xEQKF009ZPH8IXCIfgACu/eDWLyu0McIxvrE8I1JyxQLx1fB3d
         7BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764953389; x=1765558189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mFta1eTe061x4aiEFe5juzgftswqmH5K8rJIx5K4PRg=;
        b=MTRWrP8Uvg8KJTSOmkO22QbAKLCjMCUuHLEf7rLQPzOtLgwee5NS3mLgRBscrOxJof
         QQoVvM/F1nLy+fOjnFED67Db+xxmuxMj47LRTGnYsAi3vpWgA3PcwJSZgQjn96T0OrF3
         CsRx0ElyTQzKElQulBkMrP67uq9LX5+LyKCCfwCzwc93tZOz/kXqk9XdI5upwaYIsneE
         ElyU9BfaRw/Sib7mcTuj3dtr3fFyLsSiU0XraRiC4DOlGVzwcd2CXHbwsottpmxPSzRB
         I49ptDbwIylIHcuNo/aq5DsNacCRBChC0wDhEkq0jPM3dyL8XyHhssQAqOy0FgWurhC/
         TFIg==
X-Forwarded-Encrypted: i=1; AJvYcCUjtrFckXosHMCCB37JqAXs3mvzMnVqo5iEaSijUhocC5qsJYZdRoQ02iqzIqzB4eoxSyW726z71kfb/fnI@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrSYg6hyZ2NlrAuvIzvOWxdjrh7C1gEW3JLWWUkOPRawTKkzq
	CcvqgceuYlM32t8kdpszOE8qmXttuyjTrWtLl5tKjiMo3LKyMtjCCg8R8A/8yv/ArY81VVzaWCF
	267XE6KpNOPNE1R5XXePdkV3Drd9kgxVORdqOwqgD
X-Gm-Gg: ASbGnct0XpDn2DIvxtmD3S9X+Bu3EDlRnDa6nfuTTRqwHuaMqW2hTrHtep4YioC7t+Y
	zhcjITpAfiQ9u+rL51cEcp8aaDYm7ONVMpHkZ0gaCxbElZMDrkqbp0VVgI0q5pFD6a/bvHNujr1
	e9yHAQ/PZDrQc/IWZ7GhUW3vtvkH/uWYeZ0uU+Wx8A2VIv0DirPjyawk6pDQJMPlRNMLuUzjwez
	zxzafzlF9kyPBp9TulcVuUn9NJd3GAi6Lb5gRU2V9O+09rIeqNQ5WSmFvwTUaE23JCqyAE=
X-Google-Smtp-Source: AGHT+IFlgcm08Zi3P6+2oJVUXwfdUw7sv3b82zhNSHjaEBOQwXrzMMtqEuxbJwYy1uEuAcGXQwXxrAFNrkMjorAMSZ4=
X-Received: by 2002:a17:90b:6c5:b0:349:1597:5938 with SMTP id
 98e67ed59e1d1-349159759cbmr9821798a91.23.1764953389394; Fri, 05 Dec 2025
 08:49:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-tortur-amtieren-1273b2eef469@brauner> <CAFqZXNvMxoTk1MQq96r=QQGjLqWwLrbdUVJ+nkSD3dzB2yTEYA@mail.gmail.com>
In-Reply-To: <CAFqZXNvMxoTk1MQq96r=QQGjLqWwLrbdUVJ+nkSD3dzB2yTEYA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Dec 2025 11:49:37 -0500
X-Gm-Features: AWmQ_bnDRXn8-Q-vXQyXQXeKQ75yPkmrhCwaLV1ifzTgMIqsDQEG5-wcwGbDB3s
Message-ID: <CAHC9VhTh9mmSFf0m7Hd7A59Q8cXN5j_rfTGP7_A_ic=1M283Dw@mail.gmail.com>
Subject: Re: [PATCH] ovl: pass original credentials, not mounter credentials
 during create
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, selinux@vger.kernel.org, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 8:57=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
> On Fri, Dec 5, 2025 at 1:11=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> >
> > When creating new files the security layer expects the original
> > credentials to be passed. When cleaning up the code this was accidently
> > changed to pass the mounter's credentials by relying on current->cred
> > which is already overriden at this point. Pass the original credentials
> > directly.
> >
> > Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Reported-by: Paul Moore <paul@paul-moore.com>
> > Fixes: e566bff96322 ("ovl: port ovl_create_or_link() to new ovl_overrid=
e_creator_creds")
> > Link: https://lore.kernel.org/CAFqZXNvL1ciLXMhHrnoyBmQu1PAApH41LkSWEhrc=
vzAAbFij8Q@mail.gmail.com
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
>
> Fixes the issue according to my testing.
>
> Tested-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks everyone.  For the SELinux crowd, I've added this patch to the
kernel-secnext builds/packages, but as the Rawhide kernel broke
yesterday (unpackaged files) it may be a day or so before you see a
new kernel package.

--=20
paul-moore.com

