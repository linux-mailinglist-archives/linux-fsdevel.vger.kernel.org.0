Return-Path: <linux-fsdevel+bounces-333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D52A7C8AEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCE61C20A63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF79721116;
	Fri, 13 Oct 2023 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R14unBPR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155920B28
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D077C433C8;
	Fri, 13 Oct 2023 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697214153;
	bh=77wzV9MEoTXLXfQTuKRRmBfTs1SSurFIFiGTL+MyTDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R14unBPRHsceasa7071+fmC82i7CgNT4e9sYuWd7ckZA9bsebHSt6D3G4DtzXH11T
	 jYQtoXu9YqxIme3RHsPYrLzzNLoXtALd88VDpD6kRtX+XHt5pQUCk5pEIPcctqxmVX
	 GSLvysb1y10jRfhW9CrsGjnIhmVK6CeUSXlpP8MZZDW1SanPraU7pO9CoGbAdaLUQP
	 W41kE0Q/WQ66m2HnuVgIEvnx8QkmPmf2UJvusIbTUfTkZI47ZDVGZqqXYlNtzE0Wwm
	 SaPgTW40CJf9lH5D0+xmyf7uMuWnLTlqHt0mC4Pw9NldSOg8t5VpVrBC2YrGtrwLMV
	 AJ3t8KOb6vyuQ==
Date: Fri, 13 Oct 2023 18:22:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Dan Clash <daclash@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	dan.clash@microsoft.com, audit@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
Message-ID: <20231013-hakte-sitzt-853957a5d8da@brauner>
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20231013-karierte-mehrzahl-6a938035609e@brauner>
 <CAHC9VhTQFyyE59A3WG3Z0xkP6m31h1M0bvS=yihE7ukpUiDMug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTQFyyE59A3WG3Z0xkP6m31h1M0bvS=yihE7ukpUiDMug@mail.gmail.com>

On Fri, Oct 13, 2023 at 11:56:08AM -0400, Paul Moore wrote:
> On Fri, Oct 13, 2023 at 11:44 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, 12 Oct 2023 14:55:18 -0700, Dan Clash wrote:
> > > An io_uring openat operation can update an audit reference count
> > > from multiple threads resulting in the call trace below.
> > >
> > > A call to io_uring_submit() with a single openat op with a flag of
> > > IOSQE_ASYNC results in the following reference count updates.
> > >
> > > These first part of the system call performs two increments that do not race.
> > >
> > > [...]
> >
> > Picking this up as is. Let me know if this needs another tree.
> 
> Whoa.  A couple of things:
> 
> * Please don't merge patches into an upstream tree if all of the
> affected subsystems haven't ACK'd the patch.  I know you've got your
> boilerplate below about ACKs *after* the merge, which is fine, but I
> find it breaks decorum a bit to merge patches without an explicit ACK
> or even just a "looks good to me" from all of the relevant subsystems.

I simply read your mail:

X-Date: Fri, 13 Oct 2023 17:43:54 +0200
X-URI: https://lore.kernel.org/lkml/CAHC9VhQcSY9q=wVT7hOz9y=o3a67BVUnVGNotgAvE6vK7WAkBw@mail.gmail.com

"I'm not too concerned, either approach works for me, the important bit
 is moving to an atomic_t/refcount_t so we can protect ourselves
 against the race.  The patch looks good to me and I'd like to get this
 fix merged."

including that "The patch looks good to me [...]" part before I sent out
the application message:

X-Date: Fri, 13 Oct 2023 17:44:36 +0200
X-URI: https://lore.kernel.org/lkml/20231013-karierte-mehrzahl-6a938035609e@brauner

> Regardless, as I mentioned in my last email (I think our last emails
> raced a bit), I'm okay with this change, please add my ACK.

It's before the weekend and we're about to release -rc6. This thing
needs to be in -next, you said it looks good to you in a prior mail. I'm
not sure why I'm receiving this mail apart from the justified
clarification about -stable although that was made explicit in your
prior mail as well.

> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks for providing an explicit ACK.

