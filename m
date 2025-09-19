Return-Path: <linux-fsdevel+bounces-62202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014E2B88203
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 09:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A509D3B1555
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 07:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1972BF012;
	Fri, 19 Sep 2025 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JVQrOxNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81F2BEC3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266047; cv=none; b=ttmCZEHIjzMsrkjY9tU3tui7VxTUBKg9n+Bk/BuwrMTXi9WFcfD6tBNstYBsuboyjjWmGrXyZc8nhcIzGQKCoJB7bXF6pfPsd8yw9yifjujZzHM3ectjFSSJf70ORgrW6rifLlXxDPhcbSJOUODKwP2FIr3M/xswxWasvGP85rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266047; c=relaxed/simple;
	bh=HWdLkZOt1eo65Hw9C2VJLQGvyauAaqfW7dH7XTRry48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loEtQfkivmPFAZBxDfHtoxgngIvLwjoOAk8ZMAjz+ryCQvVd+QCbuqzk3WyYbVVCs0WfxmmUdJthBjvz2IxrbyEt65L1RJwLI9bOYV+DmqEtaDrBnHd+r9LE2pffAoGMh5OHTAE+kn7MuRVKEqGwdcqgjSr9rJaYZjVTpjXwU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JVQrOxNB; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b5e88d9994so20514871cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758266044; x=1758870844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FwZbH6t8CGqEFqmrm0ZFV29P2Rt2NmMLrFnZUIngW4=;
        b=JVQrOxNB9aklAqUCsbrzaBhSVhLRu1ViPAdrmaaCv+00+KH7K8IDB2fqaT0xPhCk/F
         GwhtwHi2DsiJO4ar4JKuAOymywdrOGeH8AHCnoiiD3jn/WceRCJIRe9mxJM3WtTmQxkV
         sVz5y7Z5KjFHcuUXUkcDHOj2mO/QidX/CrOPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758266044; x=1758870844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FwZbH6t8CGqEFqmrm0ZFV29P2Rt2NmMLrFnZUIngW4=;
        b=gxsYZEYyPqxikIrYQwBCKtU/jHNlF2kCN0qv7tqmRTqCOQsjjS0o0SxGgYBeac/rvG
         LmZrJQZIwH/AWdFMvme7gHcnw7aC0+5B9D/IJGE7QQyVAMOPwlfmgTdQhaOmxxvthKZN
         qafjrQTuwvOkUQ8uxhM8Mj2uxLFlEb0aNdDeaxaC7WBFgNo4pnbdkV+6QHSrTtusk24u
         nV7okUi2DS8pVz9ZrertZ2Rr9UwCXmYV/s2aY/Q3Br9Kq1ptCp8+DU29zL3spd+SOfwt
         3VJl82FlGtydtpNRViUaRpQSAtonhzAH1QAqOk100PEACpYLORKNI4zH020sfJvNu1HJ
         ztBw==
X-Forwarded-Encrypted: i=1; AJvYcCWi1rCnaqnPuO1BdukQMb3dm2CEC4/ysocXC3rD/K4nub/8RpdA98xLXX91KRnMbw5P75rcO7xiHh7wd3p6@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr7bjQV5pVgJ1MEjbXb0TtkbsEWTv+In2Knltk81AaZbGuC60c
	74HBVfCVaUViqs7yzvPoa2ykxaB43dBFAp1i1kVEMqsWuBZrvTGR0aLoi6ytX7tKjFT37DeD/PX
	UIiMmeEAsNaiiVO79V47yPomXxN6znJgy5ecJ+E7vug==
X-Gm-Gg: ASbGncts+gOtl3lNvkBBpg9YFeua6l+r+bxI+TyNIgjS1mlg8UoYevBoGrSWScEpZAS
	RGFwc6jonWix3+gUHyTRGGXfLnfrwhVB1qT/YmoEtKAd+WCOfjrGPzkcYv9703QX60SPn0tS8Os
	MEXhe/mJfdtfuQSI3nitYnUWHz72Nht8/AuTwJWVPaeX4K8jqqJJCSAKHhlRP9dwXlFfA0E60Z0
	q01iTaueBH1iMsun2E7Dzq966RotkDwpSwthI14ovYh8cM5Rg==
X-Google-Smtp-Source: AGHT+IHgJSRV8ByiNY7ouVWHU1k4CdL9EQdnatTgwryNMr4/Omqqdm3U+SYbq5QYyRAZT3wSH4j4TBKjh1SPN/pjHcw=
X-Received: by 2002:ac8:5754:0:b0:4b7:a885:9659 with SMTP id
 d75a77b69052e-4c0720ad96fmr24093771cf.41.1758266044383; Fri, 19 Sep 2025
 00:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
 <175798151352.382724.799745519035147130.stgit@frogsfrogsfrogs>
 <CAOQ4uxibHLq7YVpjtXdrHk74rXrOLSc7sAW7s=RADc7OYN2ndA@mail.gmail.com>
 <20250918181703.GR1587915@frogsfrogsfrogs> <CAOQ4uxiH1d3fV0kgiO3-JjqGH4DKboXdtEpe=Z=gKooPgz7B8g@mail.gmail.com>
In-Reply-To: <CAOQ4uxiH1d3fV0kgiO3-JjqGH4DKboXdtEpe=Z=gKooPgz7B8g@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Sep 2025 09:13:53 +0200
X-Gm-Features: AS18NWD11PNB3svk5L_DyA4P7FLTVC_7xWPTnVo1mAtDh-XBIofxbbIK0S55ieo
Message-ID: <CAJfpegsrBN9uSmKzYbrbdbP2mKxFTGkMS_0Hx4094e4PtiAXHg@mail.gmail.com>
Subject: Re: [PATCH 04/28] fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to
 add new iomap devices
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sept 2025 at 20:42, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Sep 18, 2025 at 8:17=E2=80=AFPM Darrick J. Wong <djwong@kernel.or=
g> wrote:

> > How about restricting the backing ids to RLIMIT_NOFILE?  The @end param
> > to idr_alloc_cyclic constrains them in exactly that way.
>
> IDK. My impression was that Miklos didn't like having a large number
> of unaccounted files, but it's up to him.

There's no 1:1 mapping between a fuse instance and a "fuse server
process", so the question is whose RLIMIT_NOFILE?  Accounting to the
process that registered the fd would be good, but implementing it
looks exceedingly complex.  Just taking RLIMIT_NOFILE value from the
process that is doing the fd registering should work, I guess.

There's still the question of unhiding these files.  Latest discussion
ended with lets create a proper directory tree for open files in proc.
I.e. /proc/PID/fdtree/FD/hidden/...

Thanks,
Miklos

