Return-Path: <linux-fsdevel+bounces-61377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E3B57BC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 079D17B2E85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60CD30DECC;
	Mon, 15 Sep 2025 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx1DY5ft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A8530DD05;
	Mon, 15 Sep 2025 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940328; cv=none; b=mE28AEoqAbaYyScoXbozGLGiADye6EhFzIrb8c2CeiPChm1xpJ16UWERKrplBcTfGJcjApuF+1XT1Vh47AQjnVWzwMKS9ARlh6H/UAoANBz8h8d2N7TsVsuV3C9SwWEbJ2yOU6EWPqwh+ttiV5nXy+SWvKuMv+0Ujwb9MI7ij4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940328; c=relaxed/simple;
	bh=W4wMrt8Loi6Usy/3u3ShqmaZ/hjiBd1B9QeyBs3Pr2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkmyGEDndy4EhNHCb5w5xszeFrtd7bpoif6I24pP76qC+5ZrUln3XA38oW0OpH+g3+GGoGCqKloSqUCHU/SpRzzVRVZwrFp6UDW5qq23e/TwLOSMcqp7Pot2Td/r8ShsKmh0k9LxujmU6tnEx+eYeHKvYNXdbFjSXD3lf/iYXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx1DY5ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E85EC4CEF1;
	Mon, 15 Sep 2025 12:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757940327;
	bh=W4wMrt8Loi6Usy/3u3ShqmaZ/hjiBd1B9QeyBs3Pr2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hx1DY5ftgZM3+2fD+BxCzIAo3GOqGLXoqPHJ8p2n94Mk2XMY/x+7yu93G0HXYQhhZ
	 govkFBFJyls8qG+tqAEvzwpa3MRQHvchVz7iNCZIdMB+DRTjJWsQtPefSGz8QZDuHE
	 hNztRAu9Y9szHHSjQlmJgKt17kkdN+zDYwo6R9g4qoHRISiCCn8OVoq2iBe4j0UwBd
	 7UB+xtYxutdYi01iLtiVBkFL80YzAJTKhjUFNs2t+pt3CIehdHHqZ3m40L03/YRr0E
	 Etg48OdKQJDq/UP0ZUio7YUbNgeS1DNYfnXDHfnYmfth15AjJZ5uSu9kK/SDCW2UNe
	 C33EeT/MDlxew==
Date: Mon, 15 Sep 2025 14:45:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	jack@suse.cz, neil@brown.name, linux-security-module@vger.kernel.org, 
	dhowells@redhat.com, linkinjeon@kernel.org
Subject: Re: [PATCH 2/6] exfat_find(): constify qstr argument
Message-ID: <20250915-bislang-urteil-3073171a2052@brauner>
References: <20250911050149.GW31600@ZenIV>
 <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
 <20250911050534.3116491-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911050534.3116491-2-viro@zeniv.linux.org.uk>

On Thu, Sep 11, 2025 at 06:05:30AM +0100, Al Viro wrote:
> Nothing outside of fs/dcache.c has any business modifying
> dentry names; passing &dentry->d_name as an argument should
> have that argument declared as a const pointer.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

