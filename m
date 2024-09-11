Return-Path: <linux-fsdevel+bounces-29091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC51B9750EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1198EB2353A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA14187329;
	Wed, 11 Sep 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvaGNp5b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E231865EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054855; cv=none; b=FwIdhnfc9ASz6GGpmPDNTQ4gVVWmyKKhtyb7ny2VpKoKxvFeyMZNsqJNaZRP0XOQJ8xkGzMwscGaumiNKa9g+b1lWM+ixse6TtrTVZLfjxNEzEk+B1cFsRDX9YB65ty82K/dbuCUxDwCydp1/KxlG6Y1fDCpjT4xGVYNx9mausY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054855; c=relaxed/simple;
	bh=VjhQBTU8pNHDsHxRwTDmqyKZXcXulhiVTYntlEbiMNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQ2+c3mlijhzlVaEFFwoYnaYo1COoTMo1CBeh1buYSW6sAvS5XlnwwJWBsPXHEwCzeCbWlgtsznBsN/6NI7t8OQB5nCdpwq8FDCJCGDWALtwKffF86WyV12xFzMYeMjEfIMpzgweLZb5l+b5jsPpkBqqU9J/N5Eg9VOzKBaIl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvaGNp5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F15C4CECE
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726054855;
	bh=VjhQBTU8pNHDsHxRwTDmqyKZXcXulhiVTYntlEbiMNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QvaGNp5bjLGyjBIOWMozKYzsvgXKnBn0BW3WfN1pJewHi4SjK9PoLt0Q+aw+HJI2J
	 dmQbE+DLZBDhFhUwqXgspPQw3rJq5V+CranXojmQRhaseWex4cqz2d1LIbHOjVrjUb
	 otoU8X3C/YM3QFkrb968Qkpe6L4K3NsVhAXhuS1+Nhy2BreDzeHrusSL3jf9KA/dVY
	 rv0Vk0dovjlA2INNpmkrfXYICkIOHPGzAfItyhlRcDw8hEAgVR914McuHp9K/PTY8Z
	 nNoBkzH4ZPx8kpDs5GCWwF73ZYz77sAqDhEPE6TeX1U+QYXA5VpwiH5ovcz2u4zuFt
	 TEXYw8httAznA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5de8b17db8dso890918eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 04:40:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKBaXKHpiScLRnHyZp3HMMukX2yo4CuCTMMYaLDP6BJtsxZxo1BVwm8fHngfuATF4Um9SqVMWUY5/hmeKG@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLBBEICgpHfJzH/Y+rnU15D+lcyQX5/0SAXcnIFXIA4UjJx+V
	DhS5ucxcUjYCS31Vpqnlc8uNfPgdyQFIoPHMbU/l97SAYfULahrrLjP0M4u4KooY7iA45cIvxST
	8jgYGg5RrP6R6MfS6pgJfmgug/8Y=
X-Google-Smtp-Source: AGHT+IGLYQ8OpIIogAgOtJzjs4f/O0xCX2LeGL6BKjJzd/7e96XVWbA2Ij0ErSdy6rAJfxGTHmDkvkoYyrdy5IZ3RYE=
X-Received: by 2002:a05:6870:3910:b0:270:1fc6:18 with SMTP id
 586e51a60fabf-27c1b47ddbbmr1751742fac.3.1726054854643; Wed, 11 Sep 2024
 04:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR04MB6316152C6E22EF7D5D5973C3819B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316152C6E22EF7D5D5973C3819B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 11 Sep 2024 20:40:43 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_uiQq4ear3hMgcZPj8PdcOfzdxrBknyzTS4Qv-_=KkRg@mail.gmail.com>
Message-ID: <CAKYAXd_uiQq4ear3hMgcZPj8PdcOfzdxrBknyzTS4Qv-_=KkRg@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix memory leak in exfat_load_bitmap()
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 10:46=E2=80=AFAM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> If the first directory entry in the root directory is not a bitmap
> directory entry, 'bh' will not be released and reassigned, which
> will cause a memory leak.
>
> Fixes: 1e49a94cf707 ("exfat: add bitmap operations")
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Applied it to #dev.
Thank you!

