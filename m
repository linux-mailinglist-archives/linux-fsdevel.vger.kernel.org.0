Return-Path: <linux-fsdevel+bounces-43725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C034BA5CCDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 18:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279293AA56E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CDB25FA2A;
	Tue, 11 Mar 2025 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNrFe7Rl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211502627F3;
	Tue, 11 Mar 2025 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715650; cv=none; b=mhQ2m+dN1OJpl6PDg5YrPalGK5MtcnFrghIS/2pWs0ht5eIqF0Cpa2QyIP9Kpq274jd7OnVW/A5/nEqX7+gWvZY284CPj7y77GV69Mv0ptbS7ip2h3XEkLNDXfxq/OJWWuI2ikCu3jEmr7xuC1e29/Kd1hlFroNo+bAzN/xeFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715650; c=relaxed/simple;
	bh=mYb88c1j2IxD1ARD1xjDedenXF15c3Ny/hI3T7iIDxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOFYADwTDdm2+wL1njCCl+H4PqNCSLKVSz3cs0fuyQIH8GM/0amILkyRIiJkJjiBhKCaY802jdj3h60/hR6N++/8CWYlArHsSSreGEDC7tZKU7/QsxoYP3Hr6PFY0S0ovBVjlVUueVFWAzHrYzWKEoRdM34z61zlKmovfpiOMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNrFe7Rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAD8C4CEEA;
	Tue, 11 Mar 2025 17:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715649;
	bh=mYb88c1j2IxD1ARD1xjDedenXF15c3Ny/hI3T7iIDxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNrFe7RlO492tdPP34gBGThTwqYvGGJNuPjHNoyhPu+DNbnnC6kJFcsWNnsvHeiHK
	 Y0ncsiw72hjVonAzxSSunpAMl3SYhZxcC8L9mTJBqveEBvQ29TSlvDtWsxN2sSbTnU
	 GR9RIEtcupP6OPTGbeuLrFeRVTuoh/3IgCGHP0swLxKmBhPhn4GB5k5jt7LEnnd82u
	 5cVOXz7ose7QGkhK+MBsU9unID3Oix4MHZpgVcL5FvecGprssCzDGBHZEtV3GQQnUl
	 38/lfIWe6+W4MaaUPmHuxgbqQGKrVcg2yC9igw2eDkoIZk25tAENWsSy0Vquw8fPzH
	 xDfwPCBr9KHBw==
Date: Tue, 11 Mar 2025 10:54:07 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Demi Marie Obenour <demi@invisiblethingslab.com>, cve@kernel.org,
	gnoack@google.com, gregkh@linuxfoundation.org,
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <20250311175407.GC1268@sol.localdomain>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8_Q4nOR5X3iZq3j@dread.disaster.area>

On Tue, Mar 11, 2025 at 04:57:54PM +1100, Dave Chinner wrote:
> And is this a real attack vector that Android must defend against,
> why isn't that device and filesystem image cryptographically signed
> and verified at boot time to prevent such attacks? That will prevent
> the entire class of malicious tampering exploits completely without
> having to care about undiscovered filesystem bugs - that's a much
> more robust solution from a verified boot and system security
> perspective...

That's exactly how it works.  See
https://source.android.com/docs/security/features/verifiedboot and
https://source.android.com/docs/security/features/verifiedboot/dm-verity.

- Eric

