Return-Path: <linux-fsdevel+bounces-68043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF56C51D0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A491893E00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAB2309DA8;
	Wed, 12 Nov 2025 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7o6YUJP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18726AA94;
	Wed, 12 Nov 2025 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945267; cv=none; b=ivaXquCs/+/vPjh7y45jOlhtFWjkWQS19qGAjTEeVsFVxDL5MvtGIKVE5QQgBgrAEtkCovhq6yNYnUK666rl21P/xu2Pm0irCBsSXNSb2oZXUo/17flR2S4MxImpp/hW1h1rf+pFsLLGiDpTOqQAfMNA5eQlCxF4m1cqzQ/JvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945267; c=relaxed/simple;
	bh=GrGw5DguiXxlGIuns647BIgcgNu/FoVweIScp7irTmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO1n6uP90q1gtfL6AWicjMGLwmIhHZnTOcggOiVEOOKyK0PGxufG27hzCmcnUkkbDhxtHBuPAV+xdhuBtAaJfwRBQ0F/f5FxyBDcByMFaOFIozrUtm65ewfdfqTxKksJFqKlzQskHgdmu9njbGi5pk8FXjJIOpfkukYqsTjzxVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7o6YUJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E38FC116B1;
	Wed, 12 Nov 2025 11:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762945264;
	bh=GrGw5DguiXxlGIuns647BIgcgNu/FoVweIScp7irTmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7o6YUJPLuX3tPPkGgYjZarGqHPaqilK48zLk+9Wvs1nPwOqlIh4sD2GCZIy/fPf5
	 NJg12ymf/GBOXScyc5p3BUlhWOiPRMiLJq+fcEnwA08SCmHT8y95YLmy7GQOf9AsOH
	 BwkL2fywxM3OaXKGsgtVzyKsGoUOS2sv54nLuXSBxtGxaylzIwE5KZctw7z31Myk3h
	 3npzImtGSN8JCieVKTDmXtvOrRXGIJzv+zzyrwSqcKWKiMyaxFsy3rHD40LdNTjLKJ
	 20XCoKLt2AnoA/5zlPMYy0+3A+ZWsqaSNixOS0DBCZbO4wWIvgXwPzKANpL3TWALSU
	 DepLIXQLzn9lw==
Date: Wed, 12 Nov 2025 12:01:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
Message-ID: <20251112-kleckern-gebinde-d8dbe0d50e03@brauner>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net>
 <20251111-zunahm-endeffekt-c8fb3f90a365@brauner>
 <20251111102435.GW2441659@ZenIV>
 <20251111-ortseinfahrt-lithium-21455428ab30@brauner>
 <bd4fc8ce-ca3f-4e0f-86c0-f9aaa931a066@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd4fc8ce-ca3f-4e0f-86c0-f9aaa931a066@themaw.net>

On Tue, Nov 11, 2025 at 08:27:42PM +0800, Ian Kent wrote:
> On 11/11/25 18:55, Christian Brauner wrote:
> > On Tue, Nov 11, 2025 at 10:24:35AM +0000, Al Viro wrote:
> > > On Tue, Nov 11, 2025 at 11:19:59AM +0100, Christian Brauner wrote:
> > > 
> > > > > +	sbi->owner = current->nsproxy->mnt_ns;
> > > > ns_ref_get()
> > > > Can be called directly on the mount namespace.
> > > ... and would leak all mounts in the mount tree, unless I'm missing
> > > something subtle.
> > Right, I thought you actually wanted to pin it.
> > Anyway, you could take a passive reference but I think that's nonsense
> > as well. The following should do it:
> 
> Right, I'll need to think about this for a little while, I did think
> 
> of using an id for the comparison but I diverged down the wrong path so
> 
> this is a very welcome suggestion. There's still the handling of where
> 
> the daemon goes away (crash or SIGKILL, yes people deliberately do this
> 
> at times, think simulated disaster recovery) which I've missed in this

Can you describe the problem in more detail and I'm happy to help you
out here. I don't yet understand what the issue is.

