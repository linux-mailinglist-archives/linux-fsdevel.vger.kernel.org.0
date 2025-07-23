Return-Path: <linux-fsdevel+bounces-55835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94D8B0F4A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4A61C828D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71772EF2A6;
	Wed, 23 Jul 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="0GRqWnHh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A632E54A1
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278996; cv=none; b=NDPTvzE9hOaJm5L1iDLTlOyNRvTFsWiUfGFPRS9dvdnPXZ4JBTk2IWHPQdTCUJMhhjCfSU8WoopNwozLKv/sE6TYTySfNFuHNTIrh+N6ZStXZ134AKccbvGU1/31JJqvEy+mqomL5twGLhGWG/nIL5gQ2JLYjGY2X8z3wKK/08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278996; c=relaxed/simple;
	bh=fU/APBcfC/XfQLmB1N+H1jx5bb6LCvVVTvhPnEoXAWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnvtJaH/q0MxpLwZ1porPDpSUmHwJtWyk0aNDp/dop8bKMmqp7MDkJpzKVt3091kmxe5LBVp1bMH7agh2/f5F4zLdy7hb+dVLjQe61TzbEEX0D5jY+dachDxNEO+qnzS2iJaxYFyqdzbINFTqJ13bhazCxmwE/E9ZQg0we5IJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=0GRqWnHh; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab5e2ae630so79935031cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753278993; x=1753883793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Neb4DMdHL9YN2qZdu5HnMhnwFlw4q4ExiBgUXTApsC8=;
        b=0GRqWnHhO3ay88oPAUoxJl8XZDjHPi8BzJvlkjTgq5HQJ3x4LiqP8ACuWAYQ9UpwTn
         +AitDW5EJImW5H5KsQVufvpuj8nzfKLDbUR+2fGbUrRHGclFYKue/+fC6PXYf5q5yWh9
         DlKcUZGBbmVknvLBUqpqVM7/8qMvDMWhIXT5CNBY1D4WvR8HvbG45OApWOKJSgOzGW4f
         BAw5tmCRNzoWfb0ulY/HqwOZahDbLR++1wTFu/gaSLOYG9xeRlUNTiB/30igi/HjyIbp
         Ewmx/T7k/kW90uCv5RXoTVOvD4jZLr2XqszPZ6XxaUzfseyeeQGrJ1kynh8E+rI5S7tr
         iZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753278993; x=1753883793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Neb4DMdHL9YN2qZdu5HnMhnwFlw4q4ExiBgUXTApsC8=;
        b=bg08KebdtiSn8G5x8zk+4UU+VDW9s2qTJnbAC5HyaS7eklghKfZjBogjYWNpZtX3/q
         7Km1XaB7DI9UMXBG65NHQ78yF9vSu1yZ5rCct9M65Z2CYM4BUeylrirESIZ4EIkB0kIL
         ikWWoXgCye9MxH7etATsbMozgO5hGxgL8LV+at/OZCqHcwIbYmAqu8aFTVe+1VnSbEeA
         Ck6BePk5DT7X+iCh9WEhxhOJmArhUFBmVIPlGT/kmFEIC4SQSq31ARWTijZQrrXj0K6V
         p5YTqpdXHmmRGnLMaIU5U9Xtf7gBQnSaTMFMKh138ZgGjK3WJxleGR27MTjZ0pKbjvg9
         jjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNOvFfQ97Rjjfl1Wl8cCes07v1owYmMIQAZAxm2nAkIGiyByq2p6MlP2lOPrGDSqax2TCbkjqIzF2rCTRM@vger.kernel.org
X-Gm-Message-State: AOJu0YxTz8Gvhm086SQMISJqaLbAWbAFALhz5Rs36OPYBo5VibshJAbq
	N/Aa9BkF34SCjxWvWWWktBrveqGTtmeTOVfvOdCwZGCjumnbYaMga5q6DT/WzSdjzQU+eUdzF+3
	IuOXoaUFg1QBokL/aLmfav6e3fR0Wk4ATcxtdSEkETQ==
X-Gm-Gg: ASbGncs6B6RE3aB8vwhfBMtfoIohkT9gC2Fc3OfJv93HZKwZ5elh+61iDPBjUZH+ZGw
	YAN+bxmyTv65n5h4qiG/a/36luZ0Nh7T+4AtlyLi4a4+WLmPxIZrxrqgvpATJlnPNS+sfc7ugok
	Ea/FOor6oVuaQ4AvHxQ2rwFKaUAY6fod7ZL1LYlWUYl6VHgvxyme8yPbPIa1b9UrnH09OcP8ZnF
	lIl
X-Google-Smtp-Source: AGHT+IGrYMZ5lZ4waeYztYzZWeus2W5lvUIGBJomoilBWhgY/xZwdg1u51Z0y6Byizn2RRUk43nSuTfOAFLec5SGqvE=
X-Received: by 2002:ac8:7fd3:0:b0:4ab:6c5a:1fe7 with SMTP id
 d75a77b69052e-4ae6dfc4f62mr48555621cf.52.1753278993220; Wed, 23 Jul 2025
 06:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625231838.1897085-22-pasha.tatashin@soleen.com> <829fa3b2-58be-493f-b26c-8d68063b96ed@infradead.org>
In-Reply-To: <829fa3b2-58be-493f-b26c-8d68063b96ed@infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Jul 2025 13:55:56 +0000
X-Gm-Features: Ac12FXwxkGX-ZyVenfoKJwxXGBSrng0apcRfW2jRFbfKFQccJBpZH-g5RuQibpg
Message-ID: <CA+CK2bDi+urd9FRftrDn3bwp2VCvb1f3rFsD+dhegLrMRPC4Zw@mail.gmail.com>
Subject: Re: [PATCH v1 21/32] liveupdate: add selftests for subsystems un/registration
To: Randy Dunlap <rdunlap@infradead.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, ilpo.jarvinen@linux.intel.com, 
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com, 
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:06=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 6/25/25 4:18 PM, Pasha Tatashin wrote:
> > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> > index 75a17ca8a592..db7bbff3edec 100644
> > --- a/kernel/liveupdate/Kconfig
> > +++ b/kernel/liveupdate/Kconfig
> > @@ -47,6 +47,21 @@ config LIVEUPDATE_SYSFS_API
> >
> >         If unsure, say N.
> >
> > +config LIVEUPDATE_SELFTESTS
> > +     bool "Live Update Orchestrator - self tests"
>
>                                          self-tests"
>
> as below...

Done.

