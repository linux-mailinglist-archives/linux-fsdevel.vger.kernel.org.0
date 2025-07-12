Return-Path: <linux-fsdevel+bounces-54765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EC8B02CA5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 21:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C187B2A22
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 19:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A2928DF01;
	Sat, 12 Jul 2025 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="aMHnatfJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HM+934w3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DE19CD01;
	Sat, 12 Jul 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349364; cv=none; b=XgnNq5MjF1x6a0lsUuyN+awKlasHUWD/1/iBEeX9JZdhPU0ZwKg4H4/x9GlvAFfN8UWbMdS99Nm4hzIctD5hnmbVR/lvTghLAG6NnoDZZUDsps27xycidbLGu3VxmyTToHd8mHvGyHjuJNhVESFxBC6ibJ37MZUWrE5dXmY7uGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349364; c=relaxed/simple;
	bh=AFNSgcHm8fzdGVvETXtLSUJHaNjrPTnNj5w1Gf6P3YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcTrxhCLnlrZRjWt3xtalVa230Pjway7Sf4JjBFOJOvMwgPXFXKPTux5rLQdeY8pZtP038zz+EJq7ZiHiz5DA+7Djq7q8fkW2oo67hZCd4JkZofSJuXSQCnh4Uts+k80U9O3Ch87eYB/tlKNMT/TlS0JgxFvc5GSADk7MSJH+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=aMHnatfJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HM+934w3; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 388C57A00A3;
	Sat, 12 Jul 2025 15:42:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 12 Jul 2025 15:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752349361; x=1752435761; bh=JXPGbLR2nO
	I+XzchXqaSbWCZ3qfJoJ1LIKJbuE/u2Wc=; b=aMHnatfJxFH0baQBcnIsLjabSj
	wKCDY7rNrBMhUk8itAd9KQl15AOxx8jcxAR8ARzy3sd6jwEhcpn1EmjOVkvbkIa2
	FzEAEpzgBwHP7Ml4NaPhMiFHqyURMidm3ppCxeBBPp4uiP2rp3UTdikllAGDbOws
	hIRQ8KIhI0T5KLxfwI9FOuXq5K+OmApMi2hlfD5sGPec8JxkmeiAmR9yh3tcYtbR
	DA1EIhVdsVSOBx21EFCBq9t5M+2p7Zk+kVmBq8TLamYxwe96m5sLGMaNfPUaczqB
	BMMmuBI4/Ov7UuS42n7mFI0zzk8jt+GCIRAc+L8RwHfeTiKFZJPDUS+1lU3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752349361; x=1752435761; bh=JXPGbLR2nOI+XzchXqaSbWCZ3qfJoJ1LIKJ
	buE/u2Wc=; b=HM+934w3aUY7TzdG8N8WY9y69b1ZlkIZ8AwKqEaTakW81Q637Lj
	aoAJM/4d67FxEuUxs4ixXAOIH2mKIc7glqTMGsnyA/Tb/n8QsttfR+ZbdD0SIXZ8
	PooV6MuQfc2CWR0g/00eJ7BsYYO8cyCj0GVGARzct9g8dJcsp6v3L6jwqUAKUBPC
	gIU/8b4GwchssvPMBP2HBh2GaalXAxUYX+UmREFUcbJ5I0PZGcBs7mzCRlCRmv5N
	AkdvGxwGV9sGZlyGSAyJ4t+t+pYCXWtaCkzjJ3uywZRUOsh7oF22CVC7WVV/+GG0
	Qji0ZQq3XmfmfkbzweTHdgoDSto3DcSszOw==
X-ME-Sender: <xms:sLpyaM_4xP3dJyhRzsG_dTJQk7CpA9g1zVMoTCKuPyY3HoyEs8_qwg>
    <xme:sLpyaNeFZIIik75IACGrJZYe3lEbFAIZlMqmYZITuONscKYfFIa-yqwwlgl7jEAZf
    ahGE_3NPtJghsICHjY>
X-ME-Received: <xmr:sLpyaAtG3_NBfyo9k1A-283R2A5ktQknVP54dq-nhM3GBS0XscfirdCMnti8K916bMU3k_lwqR4zGux9N73E7F5IdvTGLHbsFik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegjedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvff
    evleegudejfeefheehkeehleehfefgjefffeetudegtefhuedufeehfeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurd
    hnvghtpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorh
    hgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhih
    sehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtoh
    hnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:sLpyaO1LPe2w6GH3DbYiPT53CnSUqbM-3MFZAi6daOyWWsZsOHqTOQ>
    <xmx:sLpyaFABgzUfCuPlVZKXFAsZq-g5sWFLbvLPZvTKSDyvzyr971cbNw>
    <xmx:sLpyaLclrBXUQhhaUo9wPsRZorbdo2VGe33m0HAGLJ0t4OeCHm-qeQ>
    <xmx:sLpyaHyCiHDFEfSU14h3U8Xo0_WBwLsJuFGpr_YLAAC5t9vDzbyJZg>
    <xmx:sbpyaGoQTEHXEa5g92PNCl3NUiVw--7hy-eNo0p0MQfRAg8DqYzno9Wq>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Jul 2025 15:42:39 -0400 (EDT)
Date: Sat, 12 Jul 2025 21:42:37 +0200
From: Janne Grunau <j@jannau.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH 0/3] rust: xarray: add `insert` and `reserve`
Message-ID: <20250712194237.GA264217@robin.jannau.net>
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>

On Tue, Jul 01, 2025 at 12:27:16PM -0400, Tamir Duberstein wrote:
> Please see individual patches.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Tamir Duberstein (3):
>       rust: xarray: use the prelude
>       rust: xarray: implement Default for AllocKind
>       rust: xarray: add `insert` and `reserve`
> 
>  include/linux/xarray.h |   2 +
>  lib/xarray.c           |  28 ++-
>  rust/helpers/xarray.c  |   5 +
>  rust/kernel/xarray.rs  | 460 +++++++++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 472 insertions(+), 23 deletions(-)

thanks, series is tested with the asahi driver and works as expected.
Usage is limited to ::reserve_limits() and ::fill() of the reservation
so only covering a part of the change.

Whole series
Tested-by: Janne Grunau <j@jannau.net>
Reviewed-by: Janne Grunau <j@jannau.net>

Janne

