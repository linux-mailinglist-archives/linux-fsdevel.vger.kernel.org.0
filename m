Return-Path: <linux-fsdevel+bounces-59499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD66AB3A1F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21382567F47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6C1E51EA;
	Thu, 28 Aug 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iKFLOpjR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968CD21CA00
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756390999; cv=none; b=Y4Bcml9asRFa650GBoiRhiqiC7d7zi3gEs83bNgyHCXSLwjfbjITtaIxkqDYtlRevxKN77PBf6w1mnbEj4HgHaYiCE/V1DqHEx9ugGHM7+tUIxCEk3dhN5EAzA07CDEOdWJYv29C3oyeMM6j6DY5Xm6zaTW/3f9dV8nWC66Ej9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756390999; c=relaxed/simple;
	bh=B3Lt9BIrmFjmuOYfZJFxP1AKD8cY7VtTyiCdtko2u2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXWt9xgaoHourstaWZdzqVKE1+CZsibQ3wmonuZl4Xgt36V3pHnlWZqnKIbWupkOf4Ggmq1hB/n0xugMvGJHyifYkCxsHwV2Paq8F+irbtAEQW9xS5hUXCU7aqQP6urjPb7znj5f0T0WX2bc+4OI26eOnMtJHP/ESLNo1A+uN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iKFLOpjR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7f777836c94so104457285a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756390996; x=1756995796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B3Lt9BIrmFjmuOYfZJFxP1AKD8cY7VtTyiCdtko2u2g=;
        b=iKFLOpjRmA59eWSQVlt7dHIBDm8/Xb+G6maCT2k+Sa8HGLaF92QHDmJzrsyddEeWCq
         Dib5RjuVtzfFeFqEoXzILn2PCiZSUE15QkZQITClRC+mC/qef8tStDDNRgaoJpTrN6df
         R1baK5XAIJsoKRAy1RZVRlAdhvIm7fCbTRw1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756390996; x=1756995796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3Lt9BIrmFjmuOYfZJFxP1AKD8cY7VtTyiCdtko2u2g=;
        b=ET4/45shc/3Jktj58dUHEPxBzLFXGoUI1PSjoeMJgwSMjaIXUtV4nSoH15IhVumaL1
         gvYLVONsaWRYhvlHhKK1I4D3H3F5W/5wChSLO3/EWsmU2S/550A4znhjWcbrsWaTgSqL
         lV3hlQxE7r8CyRh3U5ZETVHFAvT31vHNKGuR0ahDA3cE+F34BMhH2/Mg8EGZrb/PKRk6
         OYsAZWZQG1JrrwAXto+5qWbyVo2jLt0aPMmpT23oNyR/y2eIRgWahRXUSublBgCy4Fm7
         PM7SBGMajUmNWbczj/AW3ypd6yOZwRM9iYdcaF/CYa/DNuIxtslArKP201PcUJP66AMf
         7ELA==
X-Forwarded-Encrypted: i=1; AJvYcCW4XwQLr5jJ/ZdznclSY8OuMWXQbEH8Ki5kjWen43eEpwdRTuKyZI+7VominKjeDn6W0qCX5hksBreuzXyL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XLS6qmph/hVu2V9RlV/Kr2aPJ3NryyTYoDx4fCvbr464NxZ3
	RVvE6S5Eep3iRf7bo6J3nnewlFUx9ewBon+4X3XaFxJbKUCKY6tjLwy1vLXfPbdHkppoYRHLzQd
	cx8Yf6yHCurXFtNVdERt9nMkfb1Jk9lf2aTaHA5X5dA==
X-Gm-Gg: ASbGncuodvg0puWBmvvlnTx0PxeV7Cw4q7rYz3+tSq9Rsg/AvOEJuRkYdJ76JbkJjLX
	vx1ghqm4/p9hpvXEvnmhl8cB5yy9X+069R2Wvz21TYstrmZ8eNvX1SAHZ9FpjGOT56l8iCAnbFk
	kSXImqmA9q/4W0tFctrMQ7VxHFyYWKnC9Fcf0A8BdIQcl26AquTKxMEO9FqkGDKBs2l0zVQbCtS
	UP2Hm5wXjTEXiTLLrP95t6+YQEIWG0=
X-Google-Smtp-Source: AGHT+IHSlluuBcHxy//9ul6l4IjFl1AmZ5Hv7A0/Av8Qh14pE8y0/wqV7Kh4Ag1gROfcn8unkSFJs9y0PHBRv2ybvbA=
X-Received: by 2002:a05:620a:3189:b0:7fb:84b2:274a with SMTP id
 af79cd13be357-7fb84b22d5dmr112513385a.33.1756390996027; Thu, 28 Aug 2025
 07:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
 <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
 <20250821222811.GQ7981@frogsfrogsfrogs> <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
 <CAL_uBtfa-+oG9zd-eJmTAyfL-usqe+AXv15usunYdL1LvCHeoA@mail.gmail.com>
 <CAJnrk1aoZbfRGk+uhWsgq2q+0+GR2kCLpvNJUwV4YRj4089SEg@mail.gmail.com>
 <20250826193154.GE19809@frogsfrogsfrogs> <CAJnrk1YMLTPYFzTkc_w-5wkc-BXUrFezXcU-jM0mHg1LeJrZeA@mail.gmail.com>
 <CAJfpegsRw3kSbJU7-OS7XS3xPTRvgAi+J_twMUFQQA661bM9zA@mail.gmail.com>
 <20250827191238.GC8117@frogsfrogsfrogs> <CAJfpegu5n=Y58TXCWDG3gw87BnjOmHzSHs3PSLisA8VqV+Y-Fw@mail.gmail.com>
In-Reply-To: <CAJfpegu5n=Y58TXCWDG3gw87BnjOmHzSHs3PSLisA8VqV+Y-Fw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Aug 2025 16:23:04 +0200
X-Gm-Features: Ac12FXyffUNPj3eegYBghz6plHAlypGo4AqqSBgBTw6TQ2PERJWgdAoaUtM_oHo
Message-ID: <CAJfpegtJfsgPJUC=8rZwjTgTazNfBNoPwV2hRGHcoe9jRj_h9A@mail.gmail.com>
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, synarete@gmail.com, 
	Bernd Schubert <bernd@bsbernd.com>, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 16:08, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 27 Aug 2025 at 21:12, Darrick J. Wong <djwong@kernel.org> wrote:
>
> > Well sync() will poke all the fuse filesystems, right?
>
> Only those with writeback_cache enabled.

And when servicing shared write mmaps...

Thanks,
Miklos

