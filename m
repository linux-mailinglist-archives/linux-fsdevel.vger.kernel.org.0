Return-Path: <linux-fsdevel+bounces-61971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDEAB81246
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9F34A7B40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD52FD7BD;
	Wed, 17 Sep 2025 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8mTjvDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F802FCC1D;
	Wed, 17 Sep 2025 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129270; cv=none; b=f+uszTjuqyL9ZeKPDhCYh/+PpLza0r3eRpt42ksWQotjp+vhBoCX0TYuLNECo3o+u7r+mdCYfpyb57Uh+4J60Lqr+3vS1ac9d7PA74/AnQq8nYUN5kHeih1Bf2BLbwvDDs/8VX10k+RqzADBCTCVIo3oagTCIGqcX6Mksi+fCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129270; c=relaxed/simple;
	bh=tmdsQ+Xu5/oIWo6bRP1Mnp6X483CCjaQbZUxpCmtk14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOdrLqX3EBs+B+dSwFZwQYb1fbJpluzHFSfsvbqB2iBmAZS9C8zTFK6rkOYOKnC3/LNrY0ZOTZVhIQOB0wQjqYsOq2krHanUVR1OUbBHQ1YsnMkTdYJUQjnTG31Cn5X1FcSBoEAXnUSV7TcaMTz+O91HxlriimwhetD3fLzThqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8mTjvDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28E4C4CEE7;
	Wed, 17 Sep 2025 17:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758129270;
	bh=tmdsQ+Xu5/oIWo6bRP1Mnp6X483CCjaQbZUxpCmtk14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8mTjvDTIvoAMnydYGhJ7895qPxNZclTPIRFnuKmk7B9Sszb3v9rKYQ6nv1m3Ph8L
	 HWydvAOhH4p0yh5ZfRbEcv/oVIRFdYrBKP1+0fUgyFRmC3qy1dAEvSisNGR4Wmmv+M
	 9yzivsDxdgXgurH8vgZjCSu+BZLIDP7lkFzRjjxICViHMqV/U2UBrweXvisOPHXsDg
	 om3vG1FeYTiM3Y7FSF2z+KktBvNXABNqdNfObsAA7DcUlDQ3yQXYrK8pWQphTxKSbb
	 M6goTtaWKHdh3QZPrsdcBFRPRI1D+Pnba4aZkXbeTnmtoO9aTyGfY+/Prr01xVdo/+
	 guQjLec6nE7Rg==
Date: Wed, 17 Sep 2025 10:14:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	kernel test robot <lkp@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V2 1/6] ARM: uaccess: Implement missing
 __get_user_asm_dword()
Message-ID: <20250917171424.GB1457869@ax162>
References: <aMnV-hAwRnLJflC7@shell.armlinux.org.uk>
 <875xdhaaun.ffs@tglx>
 <aMqCPVmOArg8dIqR@shell.armlinux.org.uk>
 <87y0qd89q9.ffs@tglx>
 <aMrREvFIXlZc1W5k@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMrREvFIXlZc1W5k@shell.armlinux.org.uk>

On Wed, Sep 17, 2025 at 04:17:38PM +0100, Russell King (Oracle) wrote:
> For me, this produces:
> 
> get-user-test.c:41:16: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>    41 |         (x) = *(__force __typeof__(*(ptr)) *) &__gu_val;                \
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> with arm-linux-gnueabihf-gcc (Debian 14.2.0-19) 14.2.0
> 
> Maybe you're using a different compiler that doesn't issue that warning?

Maybe because the kernel uses -fno-strict-aliasing, which presumably
turns off -Wstrict-aliasing?

Cheers,
Nathan

