Return-Path: <linux-fsdevel+bounces-4182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F89E7FD6DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 13:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE644282E28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 12:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980AF1DDEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU4whDs6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088EA12B72;
	Wed, 29 Nov 2023 11:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3E3C433C8;
	Wed, 29 Nov 2023 11:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701257916;
	bh=/djex4o3dqe1i42wuz9PG0/vgKzpHPhwIhOIgQXXL1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uU4whDs6Z1YKngjCmn5gwHACPMm29u1VKm7mUddhCUXuq3xjutAf+mwQ/z0cYHqWF
	 90EhlUizj3sy+E1Rq3Y8iPk5NYo9RQILX5fukZP6uGVqJjGImZB4ky8MmYNdunLRRq
	 Nx6ghWr+yFeY24UfDxeln7sZz8WV2RrCRITCFjhyLHO3lPf4Pcjmj8JtmwTIZ/27EZ
	 nVkcvIeafQJrWpbdTPhMPWp0WxHUYVJoPYs2khEESigfzVGG1E0VX1ZJMCtcAfQf97
	 zStLnBYhhxojdu5mIQuSjv41ED45qupXM8dXXCF8u7OMJW96GaKp1TFP+wHsMvmtwy
	 9mweFFhWj56tQ==
Date: Wed, 29 Nov 2023 12:38:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231129-fundort-kalligrafie-d4777374ad7a@brauner>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <20231128-arsch-halbieren-b2a95645de53@brauner>
 <20231128135258.GB22743@redhat.com>
 <20231128-elastisch-freuden-f9de91041218@brauner>
 <20231128165945.GD22743@redhat.com>
 <20231128172959.GA27265@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231128172959.GA27265@redhat.com>

On Tue, Nov 28, 2023 at 06:29:59PM +0100, Oleg Nesterov wrote:
> Forgot to menstion,
> 
> On 11/28, Oleg Nesterov wrote:
> >
> > but please
> > note irq_thread()->task_work_add(on_exit_work).
> 
> and this means that Neil's and your more patch were wrong ;)

Hm, that's all the more reason to not hang this off of PF_KTHREAD then.
I mean, it's functional but we likely wouldn't have run into this
confusion if this would be PF_FPUT_DELAYED, for example.

