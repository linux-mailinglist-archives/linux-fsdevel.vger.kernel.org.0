Return-Path: <linux-fsdevel+bounces-68273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8D0C57CA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79B00347A96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7AB1A9FAC;
	Thu, 13 Nov 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHZQ5EQU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456112F85B;
	Thu, 13 Nov 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041534; cv=none; b=JZoeiHuqPlLBdla4NsoQBEtc0SeNIReLb5zenZOTUktnIGwa10POlZpntgUvAyj8XnHWIB33qghqwbrAfORoMELTDQrIb0aKFUtnDJCJZVsUzqelQdZwD4gEXTIuzsa0vh05Fi6Mv9edMJT9HPt4ZNf5KDsf3+Ajk0dA9aonYsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041534; c=relaxed/simple;
	bh=OeNueowFD+p0GJBxeNVwMG6jxJNUVpx4kI3sG9S51sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWGAoUqMs+EgGvf77hNPVuKISShT6KKAkGrIDS23vCcE//TEWBuS+u4QsyHB5gAVxSiOuorEfiYhDm1niDZuOfEaz07i91TopKoRz6krlrSNzcteOpgNCbdB5N4ecpi+0b1V6WVXsc9A3KzsWLSPm3VR4XGmumx40kgddhmexdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHZQ5EQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744A7C4CEF5;
	Thu, 13 Nov 2025 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763041533;
	bh=OeNueowFD+p0GJBxeNVwMG6jxJNUVpx4kI3sG9S51sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHZQ5EQU3uM4bC9fTquxoJsgtTSCxTBiGcXWSCDzkLMNeTyv+D2CDDIKLr/2+88Gk
	 U48gWjW+2b0yDtOwONNv4J4E1mNFu8EfBrU6uMw8Zsffil3+cbbjAwtfjJCw1zRohx
	 7U/ObT9EYauaJFDCbimUBJdj8VKL4Oey1lsu5RYyytWzLngYrqKc9PC/JuhbiW10jC
	 kB4B5CsbBYDGiE9GbSIRdpRnHvvnIaJRU4nlZwjuniumprxfvJnxISHhaag0pB8Lg/
	 1Tt0hrXGj4EGJP8zriPNlYrRAPSYbdHmKv4pLF4ZPGawHxzwUbLLoGWvhdLLrkP81t
	 m4YUwTh0C44Qw==
Date: Thu, 13 Nov 2025 14:45:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 03/42] ovl: port ovl_create_or_link() to cred guard
Message-ID: <20251113-laufleistung-anbringen-831f25218d61@brauner>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
 <20251113-work-ovl-cred-guard-v1-3-fa9887f17061@kernel.org>
 <CAJfpegt9LQe_L=Ki0x6G+OMuNhzof3i4KAcGWGrDNDq3tBfMtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegt9LQe_L=Ki0x6G+OMuNhzof3i4KAcGWGrDNDq3tBfMtA@mail.gmail.com>

On Thu, Nov 13, 2025 at 02:31:27PM +0100, Miklos Szeredi wrote:
> On Thu, 13 Nov 2025 at 14:02, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Use the scoped ovl cred guard.
> 
> Would it make sense to re-post the series with --ignore-space-change?

Yeah, I can do that for sure!

