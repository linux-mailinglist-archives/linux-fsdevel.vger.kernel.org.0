Return-Path: <linux-fsdevel+bounces-4336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA937FEACB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 09:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8223828419B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 08:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BCA364C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CmGEV7Cd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B04A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 00:18:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54c109ed07aso308622a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 00:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701332290; x=1701937090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cKKE7Wvptfoj9pwi0y5pS5V6ubXq6VvRovsHEAl+uJA=;
        b=CmGEV7CdCtgGMovq+p9crDoMfNB4Tl0POGIdU5mFxbUrhuAwEXf04s78SnFIbpMTPW
         DKOHJFUF8TMbCQ/Cc2gPv4bLO/ufZw4QmPKcUmv+Ph3RytN8WC4MgGmAaFJBuAVYpk/v
         JoVnyiymMwPVOLxozWNTS2+XnHXarLJSFB1g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701332290; x=1701937090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKKE7Wvptfoj9pwi0y5pS5V6ubXq6VvRovsHEAl+uJA=;
        b=RNqANGHxK+LgVEUEdHOKw9FKEYqXoeMRNP9lSmWRLybauP/RI6qky47wEkJdSVPRbP
         MQB8vvBA7iAHEJzmz86Ss3vhzlGh5+6v47yE7xre2JhKBYPec/TgprSDOyQCxi1XoqQM
         HyXB8UmuHKUyHi5hblhvjBXJGnYu/LNifRAUyWL2ToF8cjy4WYAKezD2MktoxEimZUVs
         9ajN96yv/xJjcZXHipk62j846ugR7aCoe+f59ft2x3pj+V3aHKYMmquSOegKZcAslvIA
         aZfVz4pIBbXPcMq7wOKQvJYZVbdf1dYNiBKhlDIC/7HXRoRWHWGU9OA93XBGEs9nfsON
         wPPA==
X-Gm-Message-State: AOJu0YzLXP3cvNomW+S9OxzUxbZLixs07Tb/p33rAuhG5ifFlbLy7P5v
	TZ6oKomafq9od9Z3j31LRQ7ujryG70iQu38to40HGw==
X-Google-Smtp-Source: AGHT+IERmxRWkW4ytehURcyX91X5+aywST0Kob2/4DGZPxL1EUV7EIx4fq3/pBI1W9AqzZ8aC5c0cmTnYdJxdsfDtEk=
X-Received: by 2002:a17:907:7b94:b0:9b2:be2f:e31a with SMTP id
 ne20-20020a1709077b9400b009b2be2fe31amr23299906ejc.31.1701332289771; Thu, 30
 Nov 2023 00:18:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016160902.2316986-1-amir73il@gmail.com> <CAOQ4uxh6sd0Eeu8z-CpCD1KEiydvQO6AagU93RQv67pAzWXFvQ@mail.gmail.com>
 <CAJfpegsoz12HRBeXzjX+x37fSdzedshOMYbcWS1QtG4add6Nfg@mail.gmail.com>
 <CAOQ4uxjEHEsBr5OgvrKNAsEeH_VUTZ-Cho2bYVPYzj_uBLLp2A@mail.gmail.com>
 <CAJfpegtH1DP19cAuKgYAssZ8nkKhnyX42AYWtAT3h=nmi2j31A@mail.gmail.com>
 <CAOQ4uxgW6xpWW=jLQJuPKOCxN=i_oNeRwNnMEpxOhVD7RVwHHw@mail.gmail.com>
 <CAJfpegtOt6MDFM3vsK+syJhpLMSm7wBazkXuxjRTXtAsn9gCuA@mail.gmail.com>
 <CAOQ4uxiCjX2uQqdikWsjnPtpNeHfFk_DnWO3Zz2QS3ULoZkGiA@mail.gmail.com>
 <2f6513fa-68d8-43c8-87a4-62416c3e1bfd@fastmail.fm> <44ff6b37-7c4b-485d-8ebf-de5fadd3c527@spawn.link>
 <CAOQ4uxgWQbuiMQ5FaXyWALAXqdF-S2MrCLNB14-1ZYPfUs_d+g@mail.gmail.com>
In-Reply-To: <CAOQ4uxgWQbuiMQ5FaXyWALAXqdF-S2MrCLNB14-1ZYPfUs_d+g@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 Nov 2023 09:17:58 +0100
Message-ID: <CAJfpeguL63u_d=N16aWgs4_kSyg9MQmzArgN_7Oo59=5kx9XRA@mail.gmail.com>
Subject: Re: [PATCH v14 00/12] FUSE passthrough for file io
To: Amir Goldstein <amir73il@gmail.com>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>, 
	Alessio Balsini <balsini@android.com>, Christian Brauner <brauner@kernel.org>, 
	fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Nov 2023 at 08:12, Amir Goldstein <amir73il@gmail.com> wrote:

> > Offtopic: What happens in passthrough mode when an error occurs?
>
> passthrough is passthrough, in sickness and in health...

Fuse *could* intercept passthrough errors (except for mmap), and fall
back to direct I/O in that case.   But this is definitely not for the
initial version.

Thanks,
Miklos

