Return-Path: <linux-fsdevel+bounces-32121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DADF9A0D40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392801C24FE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D940920E022;
	Wed, 16 Oct 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUuwdNdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A67A20ADEA
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090192; cv=none; b=gOXN8B4LgVpqhymU1WSwRNk0A0ftaE7coFDYMtGeWqST0Mrb2q6n3Ez1/uTwiugzZbD2fy+PhGkMxbjaiU5/WSsPVFyS70OdQh4u2k+nVs290z2vRZsAOZZVfCbdsDwcHKZLTNSAzWw8AFfm3bFhhyk+xzhnIfC5KkuR87EOpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090192; c=relaxed/simple;
	bh=lQ0LtJ3Jo/zhEzM8NiPCsV+Z5bnxBP0V1k/LKq7RbmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUliD44KKG0kPbLLAcdC2dFSnhidusnlay2Ap6T5XSY/8Nz5qsHh7Vhbd4IwfGllkUk19QV5HCQ3NoOzrIPqTJTBF8Lcjg2OTYVXsfs9c9RoQGyepGLV/beOXWbJyVPwkGILKb49rZEmu6ngFbkV9fTTXH1UBxfR5/7RCO/ipL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUuwdNdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BEEC4CECF;
	Wed, 16 Oct 2024 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729090191;
	bh=lQ0LtJ3Jo/zhEzM8NiPCsV+Z5bnxBP0V1k/LKq7RbmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mUuwdNdWT3lQnH7CgMkO6v1JcGkJVUf2Qv1wlNwU/zqplJoHqhWV5LJPNvLTmn81n
	 o1WMvxk5w/9Zo02BhNccvuwBADqV8e6NcpIfExK0eFYX+lkQc1gLRoAvLCLYFDShzy
	 CDLHcfWOj/HY3aer0K5n8Xbe6M4Ty9NH/m4blZGPMJIghtIitZmJbScAh16Y7BbRme
	 LP09O4OwpWcdLywxcuBtLLvGlRuiq22HScJGnhlyq7Df88MNeGemQs3y3oSvY6WzMG
	 qh/JNXqcjGej6BRDzGDL+0Ge0UZeSodCIFoHO6sxxf9rBcuS2LT30Vc0G1/C72o38V
	 PITIeAzNKxyuA==
Date: Wed, 16 Oct 2024 16:49:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241016-rennen-zeugnis-4ffec497aae7@brauner>
References: <20241009040316.GY4017910@ZenIV>
 <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016140050.GI4017910@ZenIV>

On Wed, Oct 16, 2024 at 03:00:50PM +0100, Al Viro wrote:
> On Wed, Oct 16, 2024 at 10:32:16AM +0200, Christian Brauner wrote:
> 
> > > ended up calling user_path_at() with empty pathname and nothing like LOOKUP_EMPTY
> > > in lookup_flags.  Which bails out with -ENOENT, since getname() in there does
> > > so.  My variant bails out with -EBADF and I'd argue that neither is correct.
> > > 
> > > Not sure what's the sane solution here, need to think for a while...
> > 
> > Fwiw, in the other thread we concluded to just not care about AT_FDCWD with "".
> > And so far I agree with that.
> 
> Subject:?

https://lore.kernel.org/r/CAGudoHHdccL5Lh8zAO-0swqqRCW4GXMSXhq4jQGoVj=UdBK-Lg@mail.gmail.com

Hm, this only speaks about the NULL case.


I just looked through codesearch on github and on debian and the only
example I found was
https://sources.debian.org/src/snapd/2.65.3-1/tests/main/seccomp-statx/test-snapd-statx/bin/statx.py/?hl=71#L71

So really, just special-case it for statx() imho instead of spreading
that ugliness everywhere?

