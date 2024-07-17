Return-Path: <linux-fsdevel+bounces-23869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E8B93426F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 20:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F9A1C210E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 18:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0DE182A41;
	Wed, 17 Jul 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SJYfNj3b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6C1249E5
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721242405; cv=none; b=VTcm/5p3y+FjJ/niaJwgU2HozOOysAyxiTs3PXX0MG1ro4LdeaPMKBJs0RPGMgDAkRs3B05Ww2LDVTg+yOfRaKONe34nkNb3uhaOHnmnVu5gmyYkHCGi093Zpeos/iUedv1nDVdXHR8PZLXQzKdmWZCIjFqsZ1O2rE0yKUIvSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721242405; c=relaxed/simple;
	bh=Hv0Lv3vxMdF9EUCXQDjKALNMNYcXui+F13OJ3xjzVGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCcOLHmzlvOswA7N6XpvA8q6ONfWtvGSWu00arI8FEcDaR+wOJDHZrfv6zpD8W1dBWc03j7oIrS7/pCjIevSGeM8baFRBLts5U2QsO9+FzvSCKMU5bQMr0Z1KGLYMoXg954UkLSg1m5NOEqAlEQu3CkKUu62Lz2rExpAE8mcxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SJYfNj3b; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a79f9a72a99so211912866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721242402; x=1721847202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tMynJxsAoEfgNtqBQWK8foysn8xndosdDwSjU5qP3r8=;
        b=SJYfNj3bK2nMbAHHicYXGHdWyXEcpc4zqzF8MyGTLwTz3diTg1b1BL/K8snXzV5SQA
         L+mi1QyfjbDxhx6/Hesf6rYoupi1zGslPGZO2XLvWsziU3jtZe0OLoZ49RtV1dpTO8uL
         Zu+1V2+DgtUbKgZzVFWTUlfvExGoRSM+MLE+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721242402; x=1721847202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMynJxsAoEfgNtqBQWK8foysn8xndosdDwSjU5qP3r8=;
        b=fBmb1yeuK6cHnn4OqykpiX9UIyybA7mBwoJSnRI/dkUGq6kQfp4kfQvdAMgd3pwp8m
         iNB75Uh7nwVg00mDiUufRgLUkFNUVah7Pw5hKSgZjMRulrmv50o3sT1r0/ZSk0fnuALS
         ThGPGDOhQO4yoawKodU/7d7Uk6SgDSszJ9atl/Et8eZ4mhW0RezydXAojRqN9xMFyevc
         ZfxYjXzj4L1xlIuJMthXEFCUCmN93AY0WDqOlszGiSe92PbnFIW532aSjtFWsvpkLzGP
         Kg/9YQflNdsSSztrZSF/eGoR8KnGJaIoz6+ww0uQEPIRjtSf/QZQxtazK1xrlPDtbeRK
         KGpA==
X-Forwarded-Encrypted: i=1; AJvYcCX8j+e69vq6fRyzW69Me4T86BvEo84qS61ASymLm8HwU7zwXpcXth1/xEtymdE29ntGecRGaw/zct7ooRjD28OORomQ2QujsTL0bpv8Sg==
X-Gm-Message-State: AOJu0YxeBfyzvP8LXREd+cbRBc2Cnxj4f6LnOLpGz7EhL9Er9iIHONUJ
	l+IykC0B00xnpQ7xb0t39H3xUEufQYR4mJ93WqvJnaNO37qS5NNEHgDaJyhYT49saW2QClXWWPp
	23vuP2w==
X-Google-Smtp-Source: AGHT+IHgTlQC2jo4kevkBB8yGoE2fp6iqsavg6TxkATMzLWAe+A6SRxflbZ0arO6BlbppGAKgnxteQ==
X-Received: by 2002:a17:906:aed3:b0:a6f:dd93:7ffb with SMTP id a640c23a62f3a-a7a0f0c6cdbmr60995666b.1.1721242401663;
        Wed, 17 Jul 2024 11:53:21 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5d2018sm475005866b.85.2024.07.17.11.53.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 11:53:21 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so2001818a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 11:53:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY3tdxwfFIVvxdFzvXJQ88iqvSpmu0Tt4+carSlep7cBoTLDqXLNVdr7Jgm020LiMq3XJcsbrTjgDQOrxClx+ll64x+iUhkxh5qlQ9PA==
X-Received: by 2002:a05:6402:27c7:b0:58c:36e:51bf with SMTP id
 4fb4d7f45d1cf-5a1557cd64bmr545038a12.3.1721242400692; Wed, 17 Jul 2024
 11:53:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
In-Reply-To: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 11:53:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com>
Message-ID: <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.11
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jul 2024 at 18:26, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Hi Linus - another opossum for the posse:

(The kernel naming tends to be related to some random event, in this
case we had a family of opossums under our shed for a couple of
months)

> bcachefs changes for 6.11-rc1

As Stephen pointed out, all of this seems to have been rebased
basically as the merge window opened, so if it was in linux-next, I
certainly can't easily validate it without having to compare patch ids
etc. DON'T DO THIS.

Also, the changes to outside fs/bcachefs had questions that weren't answered.

So I'm just dropping this all for now.

            Linus

