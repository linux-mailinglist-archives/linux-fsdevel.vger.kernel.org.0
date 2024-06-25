Return-Path: <linux-fsdevel+bounces-22296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102959160A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401BE1C21584
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 08:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D461C147C80;
	Tue, 25 Jun 2024 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPc63nWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311161474AF;
	Tue, 25 Jun 2024 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302755; cv=none; b=OP9e4YXu4rAmPBsJXg34Nj4/cV+aeDDYN5WtpE6iYivoOtZGnbnt2DvK/eGv1yjR+6yWOAFNePodTX7vs4ZeO4/ePlC+3dldNUD84TaV9lkQnei6A11RCn/hQMocsX6WU4Ou6kPhy3Bcd57quO+fxrmBovbfST8bkq2dlgvJiG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302755; c=relaxed/simple;
	bh=Q4WtZPZO+0HqJ5fmovYwNXKFafB6NT2p7ExDBSJIJSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKGb/YoYfdHd57wcO2hNaECEAH9/R5wSpEbrBIGFhDZ92nsyzL7ejSJAEL4nncdJT2hyPYRtMjk7JVw8Dq7hNfuSs7FlFVM8uVevGK76Ul2CHrT2q5lY3fi3drEwv+PaCOzWQKK2MMd9Gn56Oa/pamyb4vhGKJqgbN07qf28ESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPc63nWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61967C32782;
	Tue, 25 Jun 2024 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719302754;
	bh=Q4WtZPZO+0HqJ5fmovYwNXKFafB6NT2p7ExDBSJIJSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPc63nWpmKiLtoW7MgVTXoRiuLzNR5BhlpG3EWldlmu5Z35Jt8YgnWiYPhMJZxS/V
	 wXuSx456qm6whH9Y/XdD2OpR5JXhB0hluKIaVofwyv523TPCOGz9+M88G50jjfxQQB
	 ubBGIjcYNAKMvGgtE4YCD87NBxH2WxBGBRs4QHqgRo2VC18NwgEHqSs2jPsAgEw9vb
	 9grxi3FrguCzS1ftVw/qa9apuihenOTqGCFJZ61MYxf8jjRlEXRGMPraV05q1wyGa+
	 Dxsn2El0KYM3Da6iRvTX50nOnYPB2ZThMzMKswage/+6RKYd4DxGUt//XOM5PIVMKM
	 TiaCRzU4jfnrw==
Date: Tue, 25 Jun 2024 10:05:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alejandro Colomar <alx@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Icenowy Zheng <uwu@icenowy.me>, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Add AT_EMPTY_PATH_NOCHECK as unchecked AT_EMPTY_PATH
Message-ID: <20240625-dinosaurier-keramik-f04310167065@brauner>
References: <20240622105621.7922-1-xry111@xry111.site>
 <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
 <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>

On Sat, Jun 22, 2024 at 03:41:19PM GMT, Linus Torvalds wrote:
> On Sat, 22 Jun 2024 at 14:25, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > +cc Linus
> 
> Thanks.
> 
> > To sum up the problem: stat and statx met with "" + AT_EMPTY_PATH have
> > more work to do than fstat and its hypotethical statx counterpart:
> > - buf alloc/free for the path
> > - userspace access (very painful on x86_64 + SMAP)
> > - lockref acquire/release
> 
> Yes. That LOOKUP_EMPTY_NOCHECK is *not* the fix.

I have explicitly NAKed an approach like this months ago in [1]. So I'm
not sure why we're getting that patch in the first place tbh.

[1]: https://lore.kernel.org/lkml/599df4a3-47a4-49be-9c81-8e21ea1f988a@xen0n.name

