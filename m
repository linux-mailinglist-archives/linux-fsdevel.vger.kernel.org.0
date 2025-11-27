Return-Path: <linux-fsdevel+bounces-69996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 98975C8DD25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08D74346232
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 10:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5DB324B3B;
	Thu, 27 Nov 2025 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK+/9oVV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE39329C6E
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764240204; cv=none; b=YxuUCnv/eF9Lzf0Ljmk+Lj0zWczAsPH5j0tRIxaimw06t7h4O6EJqFLcbIrcVWiSQpg4FRgm5+X9vnpzWfQWG2lwJtRRCvwi4FNXQubgbUX0x0iRFKufSaX7FqLDf4aabnL+vIGMGl5hEotbUHcyjq7/QEgfeNHfjWW9k0H2lDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764240204; c=relaxed/simple;
	bh=siBELSLEcBl/Tbnz3+2BJ0FDAgJoaLvrVZYY5RCxB3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFJwEgMH0KBVAzr7Ymq9b8y48ivbm3O+UI70IHTUbmg0qFtBTH1UIcIKUFxeOW5PFMD2pp5IZt/Eh9IArwJINimwNmskNHrqy+W5gbzn3pE8C1zbUbcH/dSYGmhlTzLH9H8cpXvgBg0cZdGdDy1h6VwC5vncIuCkdXVNdFXtN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK+/9oVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A40EC4CEF8;
	Thu, 27 Nov 2025 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764240204;
	bh=siBELSLEcBl/Tbnz3+2BJ0FDAgJoaLvrVZYY5RCxB3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dK+/9oVVDnpDqT+HaqtgLELvZjgZuSoAoYfmD00Af8A1sMm3lasV3ALbUNstRiqBS
	 PTCeIUXtY0sJFNDJnc1fZd4GQ51A4vFmRjs/GzoiNjmJDBb4/7otNngAwgBEj8pX2k
	 QCJRLqASR8qO/ZSXgV3IBNuZaXtjnc2w0zMVWw0GCRH80H4b26BMRq8bcT0wigKq7D
	 UwIgPx60aa0ZoFESq1+7MwF4kS+jPU1gXC47czXdccPDlsSuZH4zLUh1EItXXlIxc1
	 JpbAOc/qPf5QqjI9zglXKUDNZT+6tylzoq7RrhyglQ4/9ATw6xufWMGqlAKwUcoLqv
	 kyr8kgZyly+5w==
Date: Thu, 27 Nov 2025 11:43:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, 
	"Saarinen, Jani" <jani.saarinen@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: REGRESSION on linux-next (next-20251125)
Message-ID: <20251127-kaktus-gourmet-626cff3d8314@brauner>
References: <a27eb5f4-c4c9-406c-9b53-93f7888db14a@intel.com>
 <20251127-agenda-befinden-61628473b16b@brauner>
 <5ffeb0af-a3c9-4ccb-a752-ce7d48f475df@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ffeb0af-a3c9-4ccb-a752-ce7d48f475df@intel.com>

On Thu, Nov 27, 2025 at 03:03:27PM +0530, Borah, Chaitanya Kumar wrote:
> 
> 
> On 11/27/2025 2:57 PM, Christian Brauner wrote:
> > Pushing out the fix now. Can I trigger a new test myself somehow?
> 
> Thank you Christian!
> Not really. Once it makes it to linux-next, our CI will pick it up. Till
> then let us validate locally.

I just pushed:

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.19.fd_prepare

If you want to test that, please.

