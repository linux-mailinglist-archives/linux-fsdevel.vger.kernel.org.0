Return-Path: <linux-fsdevel+bounces-34903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B01A9CE022
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171C9B2761C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA61CDA18;
	Fri, 15 Nov 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HCXdOAuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D600374FF
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677666; cv=none; b=Zv+FzLZLzpwSKBPnvTTe5Ed7uxPGteCmwmXCrcLqAiADAIeJeXqZyf3BrO0cxzmVtZ1XVVcCzxFpN6UFjhYLjGNm6wVFljsGZidELluaNRval/jj6+MEWNcjVL8RWL5E72hRdEPdv4LWrNpVSsRzmCNe5QLVR/7rLKy0CqA9rZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677666; c=relaxed/simple;
	bh=gLbDLLFaCm+pneJ0ecZSsUz4EzSQvHIor0UF/fLR+1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBFD9ZJ9EXld1SV4AGZbtHHMPoawMw+Vly4gA6LidsOFfrdBTW0ng/5V6AKRWRdtf9C/S0JujF0YZqWin5ZwXsMw33YJkh/pux2oH4rMILCc0fDdjksbHvZx35mG/qSM80niwdBo7yrTTX3fkZNFIZa2r4t8F+TCBuBzz4ceSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HCXdOAuq; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-119-105.bstnma.fios.verizon.net [173.48.119.105])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AFDY7rU014540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 08:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731677650; bh=YXeu00rAkkBMx+jCW+Umq2TqKt3Mm3W0qM6ehUOiUGQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=HCXdOAuqIff8JiBA+SBbi/24u8UbEcsuWvhHECXJwMtaea6XMUhQ8BpksgSVVUNQE
	 +t4yP0l/T+Wd/bWC9xsdiSG+q+njib6F70qvRObkSyD712Noh6FDprtJHFOGY2uSN+
	 ccagrW96Jv0F6FwCkVeIceLRjkC3U3ZYGHvN8vnyHZMw75gXLw+DP9YpcCyNWJUNwG
	 JrEBYBqbyN9mev6VkIti12/P5edZh61O8RQHD293ZsJTmRfcK22b4M5oz3j5NCuMFF
	 o8ba5W1WHo4d8S/rSXmfsdEF1turAm1X/L/lq3PBJwsq71kY9MnacCYFhM3QDd47pt
	 9X0xI88FotM5A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CB07215C0317; Fri, 15 Nov 2024 08:34:07 -0500 (EST)
Date: Fri, 15 Nov 2024 08:34:07 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christian Brauner <brauner@kernel.org>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        fstests@vger.kernel.org, stable@vger.kernel.org,
        Leah Rumancik <leah.rumancik@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: generic/645 failing on ext4, xfs (probably others) on all LTS
 kernels
Message-ID: <20241115133407.GB582565@mit.edu>
References: <20241110180533.GA200429@mit.edu>
 <20241111-tragik-busfahren-483825df1c00@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-tragik-busfahren-483825df1c00@brauner>

On Mon, Nov 11, 2024 at 09:52:07AM +0100, Christian Brauner wrote:

> behavior would be well-specified so the patch changed that quite some
> time ago.
> 
> Backporting this to older LTS kernels isn't difficult. We just need
> custom patches for the LTS kernels but they should all be very simple.
> 
> Alternatively, you can just ignore the test on older kernels.

Well, what the custom patch to look like wasn't obvious to me, but
that's because I'm not sufficiently familiar with the id mapping code.

So I'll just ignore the test on older kernels.  If someone wants to
create the custom patch, I'll revert the versioned exclude for
{kvm,gce}-xfsteests.

Thanks,

						- Ted


