Return-Path: <linux-fsdevel+bounces-9100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CDF83E2C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 20:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AFF281304
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D81225D7;
	Fri, 26 Jan 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pM9p+DFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDC1DDEA;
	Fri, 26 Jan 2024 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298111; cv=none; b=SgwMF+8sR/MdSSofvX1d1ItycEoEUUoGlAD7VUJYLvfQYSTlNPGvbHLQ0irj3Rj35Xdl1BN82L1nET+SatT6aRdSETv4OfyIgNAPcDls0JbjLXhX1qzSyEi6HMdSunAqNh5FaSh9Xq5T3c8/vaQ3CV7d1e15q4/mQtIY/lfHqMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298111; c=relaxed/simple;
	bh=CBZ+J6S9RdRbbtTXo+VlAsnSPg7u6GA155LrshMp1yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK2F7neKO4emZL3TtqUf07+cUd4AcBWUei/yyrb9SzUfwpm35LuGfsc434IsTv4gEdtyLkMSN5cna35n+m5Yv3jhB2MAiXMxkymU5nLyb7E7yw+/L+Kkw4WBUxb3wGG8keKxn2dzoflJfWYRKSpwsL5AwS3JpoR2gj6eV9LsORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pM9p+DFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1C2C43390;
	Fri, 26 Jan 2024 19:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706298111;
	bh=CBZ+J6S9RdRbbtTXo+VlAsnSPg7u6GA155LrshMp1yM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pM9p+DFcsjEEP20b8WVertpY4ouFDFOiUdqCMy5SmBJucmcEgHDZHGkZ9AQy7krgj
	 0RcYBBpS1NHCNKLdjDmLHsnyxeGW/u+s05Yd0wOOJpiSLtPsb9YEeSQh03UjHzqDNR
	 XJuCKsVbbWqDeR2MApQJvj4UsJ6jiA289nT59rT/Re57DfMwLYs0jVcQcje5cWHspH
	 iDyNMaaCcXSEc6mG4PJCJtLMxZD4eJr463B3Omr3BLd+8VV61Z2/Hz3HlF6yK0O5p6
	 27K0PSvXT9s0XcQalvCzad0M9SygDD5PUYS6rz1FHGPzfRKXxYnBtY/nPAcBAEe7Ra
	 6YHucqTHz5Mhg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-20451ecbb80so395728fac.2;
        Fri, 26 Jan 2024 11:41:51 -0800 (PST)
X-Gm-Message-State: AOJu0YzLKMPev+dcAHOq6exRLHVKqHR3sI+3hXVGUCPTCS+YkVeqfScj
	kjC9zCtpM4r91x4UBk3K8NgKGs2ggNV/0klxEuQTabsI27T+a/iTMrJdPBc34tcaM8XMqGnqrhE
	4XdqGr6oUlDzxsAx9Osi0U+iv5fo=
X-Google-Smtp-Source: AGHT+IHZvRiQEf8wAo3wUkkTo/ouDUD8ffSn+dV1E2i8xeRgoYrzI3JmI7twzN3Qz8ehUcT8UMvga0+c/7ug/YlYNk8=
X-Received: by 2002:a05:6870:c192:b0:210:c59c:dae8 with SMTP id
 h18-20020a056870c19200b00210c59cdae8mr152610oad.55.1706298110530; Fri, 26 Jan
 2024 11:41:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126163032.1613731-1-yoann.congal@smile.fr> <CAK7LNATBvhcyQXt58j74Q++Y74ZgjdC3r3rtnAuU0YMt_K_A7g@mail.gmail.com>
In-Reply-To: <CAK7LNATBvhcyQXt58j74Q++Y74ZgjdC3r3rtnAuU0YMt_K_A7g@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 27 Jan 2024 04:41:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAp6mHqepAJsbFXCsMEX6zmAP6owfSPwmYbV_2PHvGvA@mail.gmail.com>
Message-ID: <CAK7LNATAp6mHqepAJsbFXCsMEX6zmAP6owfSPwmYbV_2PHvGvA@mail.gmail.com>
Subject: Re: [PATCH] treewide: Change CONFIG_BASE_SMALL to bool type
To: Yoann Congal <yoann.congal@smile.fr>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 4:28=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> (+CC: Luis R. Rodriguez, author of 23b2899f7f194)



Just a nit.


I think "printk:" is more suitable for the subject prefix
than "treewide:".

Thanks.








--=20
Best Regards
Masahiro Yamada

