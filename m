Return-Path: <linux-fsdevel+bounces-26656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77D895AAC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 04:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62791C2218C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A71E14F6C;
	Thu, 22 Aug 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO2CMoNb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7148B673;
	Thu, 22 Aug 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724292027; cv=none; b=PZN6KvH21uqEAOy4xOFaPJS5SpJZAaiCcFEjreObIATChhnvbuLX86rOULfFiJzpNI52dlPi8bb8QJBcuzZFrFLpKtUzn1/9w8fj+wto2OWEIQHASMxFpNAF1OpQEvqy4ueiEIaB/uA83ZHN+oIygOQMJyfV7HwrVFbcHcoH1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724292027; c=relaxed/simple;
	bh=uqUsAf8+/12eNEYHCiPfQspPWgo8sfX5Z0Y3h0XmXQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sei9ImxNaPDuK311iseGnK5FEfkexr250GCT1HuPVpXTeBZEVHD8nTOMLTOqKtgL2WkFGZyk79teWExuSxyMLhoFY9C+ZD3XtY1sypXBi2XQVKr9zugW//Hb9CBRaUxuZwjvWwmYM2mHo2s80nzrLSUx6RzFfQLwLA3ERrPy0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO2CMoNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A1AC4AF0E;
	Thu, 22 Aug 2024 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724292025;
	bh=uqUsAf8+/12eNEYHCiPfQspPWgo8sfX5Z0Y3h0XmXQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OO2CMoNby9sNRrhyEh/LlMnHtHvkqLN7GQn6sMcVQMtWVJeMfn2Vnb/EEoI3TBcnQ
	 CSjl9tT87onJZhacW7qkLFs6rZFpKTRMNdrpyiv2E97L6WOFvFoJIckA6+7j58w60h
	 HmGvA0KyYXYRzrdCqm4yBaLALuYdNSmwAndcUMw3xNm1RIllVsEl/xGglIkNnZkXFw
	 T4uMRSiaBDeFZ0qp1wtc5VdY2XFF+EK11/TUCm2KoTeL9guTJoekpeymYJvEtYYvcR
	 3r2+n49yhVOO30tA6VxdraR6FJ8Y82Z6TfhlVe31AkRjHMRZ8H2XBs+1etfwu9xfpN
	 kVweVlQtAQQAg==
Date: Wed, 21 Aug 2024 22:00:24 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 00/24] nfs/nfsd: add support for localio
Message-ID: <ZsabuLQPj4BJzYqF@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
 <9dc7ec9b3d8a9a722046be2626b2d05fa714c8e6.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc7ec9b3d8a9a722046be2626b2d05fa714c8e6.camel@kernel.org>

Hey Jeff,

On Wed, Aug 21, 2024 at 03:20:55PM -0400, Jeff Layton wrote:
> 
> This looks much improved. I didn't see anything that stood out at me as
> being problematic code-wise with the design or final product, aside
> from a couple of minor things.

BTW, thanks for this feedback, much appreciated!

> But...this patchset is hard to review. My main gripe is that there is a
> lot of "churn" -- places where you add code, just to rework it in a new
> way in a later patch.
> 
> For instance, the nfsd_file conversion should be integrated into the
> new infrastructure much earlier instead of having a patch that later
> does that conversion. Those kinds extraneous changes make this much
> harder to review than it would be if this were done in a way that
> avoided that churn.

I think I've addressed all your v12 review comments from earlier
today.  I've pushed the new series out to my git repo here:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next

No code changes, purely a bunch of rebasing to clean up like you
suggested.  Only outstanding thing is the nfsd tracepoints handling of
NULL rqstp (would like to get Chuck's expert feedback on that point).

Please feel free to have a look at my branch while I wait for any
other v12 feedback from Chuck and/or others before I send out v13.
I'd like to avoid spamming the list like I did in the past ;)

Thanks,
Mike

