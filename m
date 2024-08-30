Return-Path: <linux-fsdevel+bounces-28007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E71965FBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 12:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A201C23430
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37E718FDD7;
	Fri, 30 Aug 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt3qmPvY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196B815C147;
	Fri, 30 Aug 2024 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015455; cv=none; b=ECO5Cf56Pqy1IC9AXRzUat/LACnjnsm4R29tpfdK14Sem8vKi0cpeD+PGUk4yaYKqlOUc7ePxt06eo5HodI7eM61bPCLDdzrWUrL8lw6dxPDa1Lw07ZBLbm0qyqZYGih67/VrPgyoesPJTpryE+Dt5I//N3d5CIZnNerRdD4I80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015455; c=relaxed/simple;
	bh=ynbAFWuspTvAxIDVBDSLIUOKEfrOG3Reb+vJBsOmIOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfHIeWKVmx4Vlp5jO3+2oFi7r01esf+TcECRHwwxhfh3yE7q082YjDl9z5x7x36bClo2FST55/9v9HYiasPlj/wwvvNhXHt5bMZgHmwWBGI9SvtBYC0l00DxiNISTT4fqk0jRYvb4IgiSaZn1CkvA/FKN6HjvgZzIDsW1ZuBrpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt3qmPvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6412DC4CEC2;
	Fri, 30 Aug 2024 10:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015454;
	bh=ynbAFWuspTvAxIDVBDSLIUOKEfrOG3Reb+vJBsOmIOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gt3qmPvYnzBpq92O2vv2AFYzVeAgpZuLM8K3hqdYn4yraRrB6l20Kxhsbgky5VAtJ
	 NPj7e1ZqaWNpV0kBRtrVwZ5dSW4B413dERpWJ0HNbpxQ1BRPxhRyO4dO8xNITwLCHQ
	 R/2ff/N00Qji+Om1Hu6ALgvFXPiyqhWAa5YmkhJifzqxCyka8Gn2UXey36UDbXMlyk
	 u1m/2+2FZUGEsnII9cPy+Sb+d5zqJETSNomvGady6ugv7UODnaynOwZ/aP2klSSeE9
	 Mci2uP7xUT2kjs29cU9/cAiI355Eh5Cau1ZGDoWbHK6T9ZBfwIK/e9xP1RICOmKmel
	 jKYJBZsJxPd3w==
Date: Fri, 30 Aug 2024 12:57:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	mszeredi@redhat.com, stgraber@stgraber.org, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
Message-ID: <20240830-quantenphysik-kraulen-6ca8cfcaed70@brauner>
References: <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
 <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com>
 <20240829-hurtig-vakuum-5011fdeca0ed@brauner>
 <CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com>
 <CAEivzxdPmLZ7rW1aUtqxzJEP0_ScGTnP2oRhJO2CRWS8fb3OLQ@mail.gmail.com>
 <CAJfpegvC9Ekp7+PUpmkTRsAvUq2pH2UMAHc7dOOCXAdbfHPvwg@mail.gmail.com>
 <CAEivzxd1NtpY_GNnN2=bzwoejn7uUK6Quj_f0_LnnJTBxkE8zQ@mail.gmail.com>
 <CAJfpegtHQsEUuFq1k4ZbTD3E1h-GsrN3PWyv7X8cg6sfU_W2Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtHQsEUuFq1k4ZbTD3E1h-GsrN3PWyv7X8cg6sfU_W2Yw@mail.gmail.com>

On Thu, Aug 29, 2024 at 08:58:55PM GMT, Miklos Szeredi wrote:
> On Thu, 29 Aug 2024 at 19:41, Aleksandr Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> 
> > Let's think about it a bit more and if you confirm that we want to go
> > this way, then I'll rework my patches.
> 
> And ACK from Christian would be good.

Yeah, that all sounds good to me. I think Alex just followed the
cephfs precedent.

