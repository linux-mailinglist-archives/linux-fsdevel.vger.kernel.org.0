Return-Path: <linux-fsdevel+bounces-47445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D902CA9D7A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 07:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51554C2BD2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 05:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B0019DF6A;
	Sat, 26 Apr 2025 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FIcO4hed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABA729B0
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745644764; cv=none; b=fl5k8sGVyZoTRyn68EhVE0Qz0fdZAcmg+inrDa2M22PNZX26B6PcdLktlM5JVSKjUw/5L/oIxacKS13Kg/KTa9SovwEKFz33g9aDQ4LDAVs0VQ8WQQ9ESQccQhg3zhoLzKK/kWBJJDeLSzmFMDuQ5Gnx/TNUEwRhvD50y8Wz//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745644764; c=relaxed/simple;
	bh=bB5XztPcwhGgq0w4hFRaWniz6quIVBbnVp/gaAwzoUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7HnDFPBIrJkk+UoAwDcUzdUvb1L20n9zh4ziaSSE86O74FDPs62tREkkDzZCt96ONcGWT+3v4CZg9jqfn3c4NTKBa+462h+JnW+bcg2VuQjFcDJshhNviKclzsYoz68nPxhboEXVu1KZIW5MlMo8NkZJthkj1gfiC8hfY7Xk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FIcO4hed; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 26 Apr 2025 01:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745644750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SjzGeYFc1rskazNUv+0k9pTt5tEX8drK3NYo3dasRKw=;
	b=FIcO4hed44HoGLxPSgpaJvSf1ptubwjR9rqYAtdw2qjVS1zIq7sNNsTGgBP8qTUa95PuqF
	Iv+PZc5ATuScTNaECA0S6Frr9TZQwZpAkZcY+bpcHpCqMoGnPQfORx9yfP0ganteyY92hW
	1r/WOPBmva/atfnOb7fMaBNFCObk3zQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <tu2cvzmxdhqtzaoykggbksosqziaghoyswokpvfyy4iv4okdyy@cpis5wvp3msy>
References: <q3thzkbsq6bwur7baoxvxijnlvnobyt6cx4sckonhgdkviwz76@45b6xlzvrtkr>
 <CAHk-=wh09TvgFu3WKaeLu8jAxCmwZa24N7spAXi=jrVGW7X9ZA@mail.gmail.com>
 <mlsjl7qigswkjvvqg2bheyagebpm2eo66nyysztnrbpjau2czt@pdxzjedm5nqw>
 <CAHk-=wiSXnaqfv0+YkOkJOotWKW6w5oHFB5xU=0yJKUf8ZFb-Q@mail.gmail.com>
 <lmp73ynmvpl55lnfym3ry76ftegc6bu35akltfdwtwtjyyy46z@d3oygrswoiki>
 <CAHk-=wiZ=ZBZyKfg-pyA3wmEq+RkscKB1s68c7k=3GaT48e9Jg@mail.gmail.com>
 <opsx7zniuyrf5uef3x4vbmbusu34ymdt5myyq47ajiefigrg4n@ky74wpog4gr4>
 <CAHk-=wjGiu1BA_hOBYdaYWE0yMyJvMqw66_0wGe_M9FBznm9JQ@mail.gmail.com>
 <rn2bojnk2h3z6xavoap6phjbib55poltxclv64xaijtikg4f5v@npknltjjnzan>
 <CAHk-=wiLE9BkSiq8F-mFW5NOtPzYrtrXsXiLrn+qXTx4-Sy6MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiLE9BkSiq8F-mFW5NOtPzYrtrXsXiLrn+qXTx4-Sy6MA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 25, 2025 at 10:01:20PM -0700, Linus Torvalds wrote:
> On Fri, 25 Apr 2025 at 21:49, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > And you never noticed that the complaints I had about the dcache bits
> > didn't make sense and how I said it should work was how it actually does
> > work? Heh.
> 
> That's a funny way of saying
> 
>   "Oh, Linus, you were right in the first place when you called me out
> on my bullshit"

You started out going off about how filesystem developers don't know how
Unicode works, and when I brought up the dcache all you had to say was
how wrong I was.

Sorry, I'm not going to give you credit for being "right" when you're
just trying to play gotcha.

