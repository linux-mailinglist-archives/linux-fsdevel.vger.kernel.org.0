Return-Path: <linux-fsdevel+bounces-58141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EF7B2A080
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 13:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565A3560380
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6027126F290;
	Mon, 18 Aug 2025 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWbYQfj7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5131B132;
	Mon, 18 Aug 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516506; cv=none; b=TXqkJ8Kvi78B98rn4oYTTfLx97w199Z7m5ad4yzImz/dvzGNUJIDTe1urhHF1IiLx7ScqqZH02IB9q4rif/JhrxLxhXo2/hxKwaHLFfArj9mfFNYPvB9ma1tqecUpg23Be8MYH2Z6Y3L6qPjI8hPI1/9VKtahesKnXaSvYScGr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516506; c=relaxed/simple;
	bh=0cXLqzl2kIYkuFrnOJI+PvHQezksNq5IXAPpAXVsBJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AU8vALOSHD1RrWl1dv7GjpqAN5WFRbMIqdjTkt2aKucJ5U8EhALo/u7HIcu8VQMP67poDnZMUuEvsSB6IcAH7Er5mEAvtj49m/Ch7MNmmiYPEl0smFqDwWaOBklN491QVcTTB6rMR4K/POSvl4FWm2q2C5/pkGUeVw/jac9N6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWbYQfj7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286A0C19421;
	Mon, 18 Aug 2025 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755516506;
	bh=0cXLqzl2kIYkuFrnOJI+PvHQezksNq5IXAPpAXVsBJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GWbYQfj75VXNAYhYFmMCX4PGDcqOSNsrLz3wbazilJmceMu+x6Cc07epg8WvSR/Ji
	 IFtQ4MP/IKzxA2KKcyhSNsiee+nmwHvFR/M9/eHIclU9mLoy04qO8lNT7OLaR4HfxR
	 PiMYCo43Kqium9bp1qTA+xa91yBtvOOWztDhVKRPZw0OHHzkL6gSpjVgDFN97STqsn
	 KOoC5Lh+2Al0CaqJ/CmDzHjGWcKmmd/4a0dbhZ/pD4H9V2YU//qD3+s1B6UH5vlX+V
	 haphhoV/FefiaA10XPI1cMNdbSilfDoTyVWyVhTMuj5EnFRbOMXm4BPHlOS3cGUprN
	 nxQq1jSrna1IQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7a3a085so625903266b.2;
        Mon, 18 Aug 2025 04:28:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4+ZR2y8fcjRvE2pbBSwhpK/Rl0ez4s7YyuFgPFubmXODMPhXORYdppw6PApYnCCrkqoYoqnn+pTMDYbzN@vger.kernel.org, AJvYcCXHC8b0Hoa4elUcxzjkEv5KbgycDni8zLAallo2NHMIhh41NxvKIwqQaNq3BNOgfgvkKh9aWUyO8N/T8KPA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuct9K2YQOWD712KKV+zTbjxxsdO8PCbWPAmxrxXU69yOOyznq
	IHLZ+ExNteuNSuBjZCADSGWekLAUouCQg+JyaTMl3ZzHMjuQ3PznTuU0BDtmDSxwDpu0v7//yNL
	wC889iF6kiC4K103qRxx1+4urbPpboss=
X-Google-Smtp-Source: AGHT+IGTVh4XzFYQebSSJw3OOadi47fhkE/vh7j0KQC0lfEt4QSU5uHIm8E8ES2FCw5OOfPb2/YPHgm4ZPZYrdTMw0U=
X-Received: by 2002:a17:906:38c8:b0:af9:3ed3:eda2 with SMTP id
 a640c23a62f3a-afcdc375ec6mr803869666b.60.1755516504666; Mon, 18 Aug 2025
 04:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818092815.556750-1-zhao.xichao@vivo.com>
In-Reply-To: <20250818092815.556750-1-zhao.xichao@vivo.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 18 Aug 2025 20:28:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd90NvZyNdHM5-OkqOvROfPLX8X=7wUnBWZ_mPiJ3WCH1w@mail.gmail.com>
X-Gm-Features: Ac12FXyvJ6Eef0zfdHBZramoIi_sRNQuvwNIFPijNRMSwXfxGMDchY1plAVbX8A
Message-ID: <CAKYAXd90NvZyNdHM5-OkqOvROfPLX8X=7wUnBWZ_mPiJ3WCH1w@mail.gmail.com>
Subject: Re: [PATCH] exfat: drop redundant conversion to bool
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:28=E2=80=AFPM Xichao Zhao <zhao.xichao@vivo.com> =
wrote:
>
> The result of integer comparison already evaluates to bool. No need for
> explicit conversion.
>
> No functional impact.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
Applied it to #dev.
Thanks!

