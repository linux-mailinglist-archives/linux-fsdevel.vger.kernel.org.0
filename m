Return-Path: <linux-fsdevel+bounces-51505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE451AD772C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 17:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB75F7ADC97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C1D298CA3;
	Thu, 12 Jun 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd4WUjaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05311AAA2F;
	Thu, 12 Jun 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743790; cv=none; b=h+vRER6OXVuY1KyjL1cOjBT9g0Z5VIFwtowC5tO7XE9TxqyTuWM5c+fLKOFe+KihJ+v5Fl9SNEsMzaIbLgqXUx1pjfPESrG3NInUSe4JHFwc9888E5mrzuQlBWgKbwKKror5Hc6u4rv5T63b6ZGq4BdkpTXV0lo+1BfJMaBn3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743790; c=relaxed/simple;
	bh=fPHaHi2HxEdBwj2oG5SqlCNxzhdpeu3yvO6FzaXVGDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rE7la4eLBaQcTrQPebCj654tguT/0968evs/6q6Qj7469OBo19TniFLrlMn3oMvoucGMIGL2L1LyBQvdmY5u0HCGyRB/hWISPDiVEbEw8gmvgsyzXS0YWZA0RH/rQZ2EQzEwTub14rpQL5G0GpRpPui21rVvKfzBw6QEuZaE9fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd4WUjaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F2BC4CEEB;
	Thu, 12 Jun 2025 15:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749743790;
	bh=fPHaHi2HxEdBwj2oG5SqlCNxzhdpeu3yvO6FzaXVGDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vd4WUjaHdTJw5ReK7mTYSl7gNzWyKtYcw/9DADXColvdbygo4YDGFHejQv3XGmims
	 aIJc2kmhKmoWrehoCyyqwIT/ENfKA51+giXhoin8fxGnHK9tHklYzJCKaJpe+BQ8qW
	 9UBQCprGYwvxbeUusZfKhR2xMqbTnPB8ydx5XNMJ/gzV2YEXIa9RGotIZWZAiwVgNi
	 Hkb12Qjp+AYHRJ9NOJt26k4KfE3KlSJFKdLt28D5YeFuPck9kINk6NWD6R2XOnp614
	 JLE99SKiDrwbuG6E7yHo1vg51l3fvw/gCiHqfxDOvTRVJ06obC1WvnyLKsWd2vuR4h
	 vqc8rvThTAy8A==
Date: Thu, 12 Jun 2025 11:56:28 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
Message-ID: <aEr4rAbQiT1yGMsI@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <5D9EA89B-A65F-40A1-B78F-547A42734FC2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D9EA89B-A65F-40A1-B78F-547A42734FC2@redhat.com>

On Thu, Jun 12, 2025 at 10:17:22AM -0400, Benjamin Coddington wrote:
> 
> What's already been mentioned elsewhere, but not yet here:
> 
> The transmitter could always just tell the receiver where the data is, we'd
> need an NFS v3.1 and an extension for v4.2?
> 
> Pot Stirred,
> Ben

Yeah, forgot to mention giving serious consideration to extending
specs to make this happen easier.  Pros and cons to doing so.

Thanks for raising it.

Mike

