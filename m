Return-Path: <linux-fsdevel+bounces-25287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960F694A669
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB6E5B2C039
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4DE1E213A;
	Wed,  7 Aug 2024 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrlQpPB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052AD1B9B43;
	Wed,  7 Aug 2024 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027902; cv=none; b=X2swa0UEaWezmsNgUp2IK92izaNPan15s0Q+kwdpa4zxSGXg/mgO0JA0eD2nt8Ia2CPoKNsRZwqRQO1u1M9rzAKvvpvEptvqImLnOHT7HoJZFQhBwSEfgzaH41AM1V3SeSkIkKHhlbqsLqW1BIu5UJRbN3M+IMJjygcw/6kEG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027902; c=relaxed/simple;
	bh=z3VztNRFvFOACRJq3oRSplynpBrn+dFcZiCR3aH2fc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG7aX7GXitvAX6bsl5dHU5WHSY3hRGm1/WgYDL7WiH/VZMDRDjkLnjbeYDNlg5LEDaWUgmUs7zHor37cKa04/2jkDh15/l/FJuqlxWCt/bFP1iEVdt3SY2ya9DiDYXyt2rQnTlq9bzguRF2SZe5IfQsIzo4sJgCgpsLiazpg6ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrlQpPB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B56C32782;
	Wed,  7 Aug 2024 10:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027901;
	bh=z3VztNRFvFOACRJq3oRSplynpBrn+dFcZiCR3aH2fc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qrlQpPB4oPry++opeSLCcUbxdICFCBI+nQjl+3PIzC+8WqhYZZaR76bXMYFrPJyg9
	 g3f2QkWLZIpSdjSONDz39c1g+OMczaUVyDFyqcqfHHt0Z6BQ40n7jklS0q5LslTocU
	 LRQZnYLuIRlvtFFAdTlvF0pEWmSx5T1DxGEVB5PWFSr/pf70oLFVJ86esevxPnNfKm
	 axg9EGVzcpPCXEUucVprOKxbwP6o26se3orRlWEX8mt3zGN3ZA88RwypV23y5g9LJ4
	 Ywmlzu80H0hbxt2XOn8YSLVXbT60tHX9tWdQYGGUcz4n6lii41u4nAWJfps2Is+pxr
	 wg19vZnyyZDgw==
Date: Wed, 7 Aug 2024 12:51:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	kvm@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCHSET][RFC] struct fd and memory safety
Message-ID: <20240807-ostbahnhof-kaltfront-0f4476fd7587@brauner>
References: <20240730050927.GC5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730050927.GC5334@ZenIV>

On Tue, Jul 30, 2024 at 06:09:27AM GMT, Al Viro wrote:
> 		Background
> 		==========

That series looks good and pretty simple to me. There was nothing really
suprising in that code.

