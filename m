Return-Path: <linux-fsdevel+bounces-3919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 605387F9D75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 11:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188602812DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 10:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791B718C08;
	Mon, 27 Nov 2023 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFFL9zxn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF731DDA6;
	Mon, 27 Nov 2023 10:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F719C433C7;
	Mon, 27 Nov 2023 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701080870;
	bh=mqtFeeqGki//5Nb3R143+AqRimwbXXJttWageC3NiuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFFL9zxnJAnhIv2QZsihLuUq6mKSrEU3HutEewWqBmC8wj4Ey9kZH08HHHrY0s6OK
	 zJZxiyeDHaSXmt6RujDPBPT7LJnhuRH9OJliQMqLiUJp4RCXcxAYeyVDXQO0JCd49W
	 1/eL8pYNWxbPBunN/ikK7aPYUr/nI0d2EHTOaXGxw2yoz6PMFwt1FvDvVsUmkD09L5
	 u2TWtfr0bZ6oFm5a37f1YH5il4ot9Gs6cja1OS1Y66a9X9mqmQfbz9s3dTyGaD1cz1
	 MOYYUotox20liwe8wOlhOdEtPTGsk7EHvqPuaSiHrypK3q+f/CrUaOAa1Ia9Vk/I6a
	 nuBmvgv0yHIYQ==
Date: Mon, 27 Nov 2023 11:27:43 +0100
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
Message-ID: <20231127-kirschen-dissens-b511900fa85a@brauner>
References: <202311201406.2022ca3f-oliver.sang@intel.com>
 <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>
 <CAHk-=wiCJtLbFWNURB34b9a_R_unaH3CiMRXfkR0-iihB_z68A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiCJtLbFWNURB34b9a_R_unaH3CiMRXfkR0-iihB_z68A@mail.gmail.com>

> So that nobody else would waste any time on this, attached is a new
> attempt. This time actually tested *after* the changes.

So I've picked up your patch (vfs.misc). It's clever alright so thanks
for the comments in there otherwise I would've stared at this for far
too long.

It's a little unpleasant because of the cast-orama going on before we
check the file pointer but I don't see that it's in any way wrong. And
given how focussed people are with __fget_* performance I think it might
even be the right thing to do.

But the cleverness means we have the same logic slightly differently
twice. Not too bad ofc but not too nice either especially because that
rcu lookup is pretty complicated already.

A few days ago I did just write a long explanatory off-list email to
someone who had questions about this and who is fairly experienced so
we're not making it easy on people. But performance or simplicity; one
can't necessarily always have both.

