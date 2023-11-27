Return-Path: <linux-fsdevel+bounces-3917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78B17F9D32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 11:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63257281392
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D178182CC;
	Mon, 27 Nov 2023 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gua2LBTg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F11798D;
	Mon, 27 Nov 2023 10:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8059AC433C7;
	Mon, 27 Nov 2023 10:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701079987;
	bh=fGgNP5lLqq06gIKE/Ay6zDb25xpoQWkuhpClm6E4Od8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gua2LBTgox+kA/7qWhP6aBawjywyAf4plI5DEpsh3Ijh1TglJVJalcbdoLVzj+4dc
	 QSMDDVQUYBZq1RQQekKvMiY6PsTT6dCQ73qwrTxCOVqua3ItxtNNh1CT5mMK1rwkOo
	 pNmaaaZz8ibyvGn9pVWA4lfTSRxkUENw1NZF/9NxE7CpRhALbo9b8kxwPL+7e+tpwW
	 hsJPsy3p5qFhBnTvSRETrsFsNAloxWs+4rOiSkqNw7cPppUIDXmoc2h/jD710Ik/tG
	 IqbNDJzviU6gnDPxieDGBRlc5nKcmAT2tWnTWaAy3wiDb1nqr1v6ODL4SEN8gHX01N
	 FGTK2menaKnbw==
Date: Mon, 27 Nov 2023 11:13:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
	bpf@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com,
	fengwei.yin@intel.com
Subject: Re: [linus:master] [file] 0ede61d858: will-it-scale.per_thread_ops
 -2.9% regression
Message-ID: <20231127-protokollieren-ermuntern-748cc3855fe8@brauner>
References: <202311201406.2022ca3f-oliver.sang@intel.com>
 <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>

> I took a look at the code generation, and honestly, I think we're
> better off just making __fget_files_rcu() have special logic for this
> all, and not use __get_file_rcu().

My initial massaging of the patch did that btw. Then I sat there
wondering whether it would matter if we just made it possible to reuse
that code and I went through a bunch of iterations. Oh well, it seems to
matter.

> Comments? I also looked at that odd OPTIMIZER_HIDE_VAR() that

Concept looks sane to me.

> __get_file_rcu() does, and I don't get it. Both things come from
> volatile accesses, I don't see the point of those games, but I also
> didn't care, since it's no longer in a critical code path.
> 
> Christian?

Puts his completely imagined "I understand RCU head on".
SLAB_TYPESAFE_BY_RCU makes the RCU consume memory ordering that the
compiler doesn't officialy support (afaik) a bit wonky.

So the thinking was that we could have code patterns where you could
free the object and reallocate it while legitimatly passing the pointer
recheck. In that case there is no memory ordering between the allocation
and the pointer recheck because the last (re)allocation could have been
after the rcu_dereference().

To combat that all future loads were made to have a dependency on the
first load using the hidevar trick.

I guess that might only be theoretically possible but not in practice?
But then I liked that we explicitly commented on it as a reminder.

