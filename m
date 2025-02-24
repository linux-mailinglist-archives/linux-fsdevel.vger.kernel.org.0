Return-Path: <linux-fsdevel+bounces-42401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 326FAA41DB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 12:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EB3189EB78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CCE264A7C;
	Mon, 24 Feb 2025 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRdaFvC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431E25A2C2;
	Mon, 24 Feb 2025 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396405; cv=none; b=S/1+kWQW7LtE5FppiPUBTu++Dml2Kjxb9TAjW/kEgOL+bKg5WwWTBMypXyBiK1CMkT6rwtXzs17GaJw9vIDVzsgKW5k5RPTm4JMn4B8ScPDMZB+2dBuAFqmGPgauXOk6s1+R8DZqWPQVABCMcHXJOf/0r3z7NJJoHxMIk6h63ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396405; c=relaxed/simple;
	bh=Jgv9yHXKHy4f1AxGcFgIWkkF+lx5/Pxyh93HZVvGd28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PI8wPaZsn0AAZb1LNXCwcWce6P/elnwleTUxGc2GHWOLApvWnj5pW/atz+VgpJzRBaqyjHGhtIy9VZwGtzDCiGq0ciihkKiC3FxcP8Bsh3YJoEt0Ur/N01+O4sFxEvf5NaRgKYKfVXXtPRuALHCceDIXCkQpQRuHSvTp3Kjp+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRdaFvC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27628C4CED6;
	Mon, 24 Feb 2025 11:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396403;
	bh=Jgv9yHXKHy4f1AxGcFgIWkkF+lx5/Pxyh93HZVvGd28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRdaFvC8bTOaAO3V5ilXUCQwtBlnF+hOOUF8u/zeZeGW4xYxmaYKT6H3ULMtanDcp
	 MOtLHgBlTp0Bb9r/L9cSCngoUxALO7uu/IzfzaNka8E8Naz/7AC1ISZBsb+RunGUBc
	 ibBCM4ynL87p1Q9sMQBHCJB8V5MmWkcE3M2znWOhaDCjAB8FxQHExj+HOPmxvooP5E
	 3pEATViqK3quiBKKJU+iCpH+EuL6StRKOJfH2rCEkm72wk/IeOcrFeuHGZJWz+JzqV
	 rVwK/xjZS3oqAqQJv0WvV8aTNv86gmDTUrTunC2XKyPt8hoRnCwsOegB2CX/BpCB71
	 DgMc3dH/vwDKg==
Date: Mon, 24 Feb 2025 12:26:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Kees Cook <kees@kernel.org>, 
	Ronald Monthero <debug.penguin32@gmail.com>, al@alarsen.net, gustavoars@kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Message-ID: <20250224-aufgaben-mitgearbeitet-0392505740ed@brauner>
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
 <gfnn2owle4abn3bhhrmesubed5asqxdicuzypfrcvchz7wbwyv@bdyn7bkpwwut>
 <202502210936.8A4F1AB@keescook>
 <CAGudoHHB6CsVntmBTgXd_nP727eGg6xr_cPe2=p6FyAN=rTvzw@mail.gmail.com>
 <202502220717.3F49F76D3@keescook>
 <CAGudoHGtRdu-s=RKDbQtcOxNx8NBaCvJFmq7u+kUbVymLTZj1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGtRdu-s=RKDbQtcOxNx8NBaCvJFmq7u+kUbVymLTZj1g@mail.gmail.com>

On Sat, Feb 22, 2025 at 05:36:11PM +0100, Mateusz Guzik wrote:
> On Sat, Feb 22, 2025 at 4:17 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Sat, Feb 22, 2025 at 01:12:47PM +0100, Mateusz Guzik wrote:
> > > If it was not for the aforementioned bugfix, I would be sending a
> > > removal instead.
> >
> > Less code is fewer bugs. I'm for it. :)
> >
> 
> Removed code is debugged code.

We have both qnx4 and qnx6. Can anyone with authority speak as to the
usage of qnx4?

