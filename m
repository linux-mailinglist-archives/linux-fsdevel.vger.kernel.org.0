Return-Path: <linux-fsdevel+bounces-30428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E688898B0C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 01:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63FAEB20D7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 23:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510FB189F35;
	Mon, 30 Sep 2024 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="TUY3biKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from antelope.elm.relay.mailchannels.net (antelope.elm.relay.mailchannels.net [23.83.212.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A832F17332B;
	Mon, 30 Sep 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738580; cv=pass; b=Cj3ZxzLL7j1pi9QcBDY02bo6p6GOOTn3FMwX9/0kYMYbE5f1Y5VbPBvNOnJtUk8WRf9CkrgSC8Z+vyxFrdgBn9dvzqi2ilErOjzx0C2zt4Xk1THMOr3sbIxFeerivNRlg69oDCHnGGPwmjX+pureXSon5tUsFZfGnBnfaFxPKL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738580; c=relaxed/simple;
	bh=KuWYaVWKp7Y+khtrf4Tw07FIwkFQfxcX5Lty0r61JlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUW0KE+2OhvS/nzYOaH/Zp8d6681bMvaFZwKeteTwZobhI2peKyKjg+jhDOBhUQzOYfq2dWLNggqITc0g2YaUXrTLP1Y+aKPn9UFWrt6FqNxByjkATTUNggzMgWxWRGoME+riHeertAkXJkHABVXPXGsjHKfPJ12L5c+mx7SP6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=TUY3biKg; arc=pass smtp.client-ip=23.83.212.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 40EB4321942;
	Mon, 30 Sep 2024 22:43:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (100-96-89-39.trex-nlb.outbound.svc.cluster.local [100.96.89.39])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BD29532194D;
	Mon, 30 Sep 2024 22:43:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727736234; a=rsa-sha256;
	cv=none;
	b=muQHMFRXN3C/adqoY/sPI2MLe8tqrQwN5k2w5ZtV2LnBnnjJ8E38rhJlQiFINKlJkLVSaC
	WvsC5qoErzOk6ITHgIHgKR673/I1zaGqMxox++4xl6it+wy59Zau6+wa3j29QHL9AInRD9
	gdk4W/g7i8zSfLydhhLxvQWAec4Ee9WQKDhFEdPDZ5S7JMH7/XUQEmf9bnm4MWRrPMXhKp
	09WyxQX4uvchZpJSgEycZeFfLLU8XHB5AKDuE1TkYKFdyLjUzBQub1vbBVj9dvBNO7f5HA
	rz4xlC6er/GLdbdlhIhQ/qeOhok69kuG7IBkAXJx1vaefj5FpBSun+tixlK8uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727736234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1w0tpQyukzCFtuLGpM8ycIFWg9JzhAhfgoalyyzoLVQ=;
	b=21bMOOT4abstJs3g5nIsvv+BuknM78ZWGyuiLobft8Mvt5qPFavzq7Cvz1KitpV8zXOvng
	w32pD4fCXl4HjssB5JN+nPE6CEdi1ztFP2h///upLIiDErmc35Lm9i27OhetpUnyReWaMH
	72s2hVPwXCA29Uwz1jQ6uFRv2KMSnUlBOAQbVhcs6hpdjMkTXtaVjxN7LyTIDEhWzeToaC
	OreXqQ+fJqKE5bnW94NM0+EDtiE2nsSfZfjaJSvQ2QAPe2iOPq2PHmiy5oaOFjrCSr1t2r
	2htvUmHxptI3bpIbojTgf99U/JxOFnq6+gHlW5tBkAd5apvdxski8Qsbgzpqjg==
ARC-Authentication-Results: i=1;
	rspamd-9d66c6866-nmtlj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Broad: 517ec72679099906_1727736235078_1270078056
X-MC-Loop-Signature: 1727736235078:327392066
X-MC-Ingress-Time: 1727736235078
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.89.39 (trex/7.0.2);
	Mon, 30 Sep 2024 22:43:55 +0000
Received: from offworld (unknown [104.36.31.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4XHbhn6DJ5z2J;
	Mon, 30 Sep 2024 15:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1727736234;
	bh=1w0tpQyukzCFtuLGpM8ycIFWg9JzhAhfgoalyyzoLVQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=TUY3biKgg42trn3IoLk0/DZp2IMqhEGNxyKNE8+dITdU6gb/z0LzTA5wCGsXwiIfg
	 o18/ad/GiSsE+qskJJwAyXTz9PzBLhasu02jhlAuwL3i9F24o7JmotOiAIpx9SNxiN
	 Ah+5s7XE+m+2mNSuN0A1RfCqr8WK3KiYICuLfIO/8UczWqVju/2azj789TR7luiWda
	 5SVUsBSBi9kgMYPdgsRqhEBkAy/SKTIgBFqQ4qJqgV0YgA+5BsrnQsNfT7DyyO8v1R
	 MD20KPs2k5x9WwbAz0aZhx4LHOKauxLQ9xcKragDPZhCG3arRKVLd0zGO9pYI9bMql
	 OT1JFYSJTdnEA==
Date: Mon, 30 Sep 2024 15:42:27 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Theune <ct@flyingcircus.io>, Dave Chinner <david@fromorbit.com>, Chris Mason <clm@meta.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev, regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <cldkpg3wtz2ovbyh53verlcauhqla7x2bi5ru4qo3kf4ehbiwz@ou56y3qjr5cv>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Theune <ct@flyingcircus.io>, 
	Dave Chinner <david@fromorbit.com>, Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-mm@kvack.org, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
References: <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
 <E6728F3E-374A-4A86-A5F2-C67CCECD6F7D@flyingcircus.io>
 <CAHk-=wgtHDOxi+1uXo8gJcDKO7yjswQr5eMs0cgAB6=mp+yWxw@mail.gmail.com>
 <D49C9D27-7523-41C9-8B8D-82B2A7CBE97B@flyingcircus.io>
 <02121707-E630-4E7E-837B-8F53B4C28721@flyingcircus.io>
 <CAHk-=wj6YRm2fpYHjZxNfKCC_N+X=T=ay+69g7tJ2cnziYT8=g@mail.gmail.com>
 <295BE120-8BF4-41AE-A506-3D6B10965F2B@flyingcircus.io>
 <CAHk-=wgF3LV2wuOYvd+gqri7=ZHfHjKpwLbdYjUnZpo49Hh4tA@mail.gmail.com>
 <ZvsQmJM2q7zMf69e@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZvsQmJM2q7zMf69e@casper.infradead.org>
User-Agent: NeoMutt/20240425

On Mon, 30 Sep 2024, Matthew Wilcox wrote:\n
>On Mon, Sep 30, 2024 at 01:12:37PM -0700, Linus Torvalds wrote:
>> It's basically been that way forever. The code has changed many times,
>> but we've basically always had that "wait on bit will wait not until
>> the next wakeup, but until it actually sees the bit being clear".
>>
>> And by "always" I mean "going back at least to before the git tree". I
>> didn't search further. It's not new.
>>
>> The only reason I pointed at that (relatively recent) commit from 2021
>> is that when we rewrote the page bit waiting logic (for some unrelated
>> horrendous scalability issues with tens of thousands of pages on wait
>> queues), the rewritten code _tried_ to not do it, and instead go "we
>> were woken up by a bit clear op, so now we've waited enough".
>>
>> And that then caused problems as explained in that commit c2407cf7d22d
>> ("mm: make wait_on_page_writeback() wait for multiple pending
>> writebacks") because the wakeups aren't atomic wrt the actual bit
>> setting/clearing/testing.
>
>Could we break out if folio->mapping has changed?  Clearly if it has,
>we're no longer waiting for the folio we thought we were waiting for,
>but for a folio which now belongs to a different file.
>
>maybe this:
>
>+void __folio_wait_writeback(struct address_space *mapping, struct folio *folio)
>+{
>+       while (folio_test_writeback(folio) && folio->mapping == mapping) {

READ_ONCE(folio->mapping)?

>+               trace_folio_wait_writeback(folio, mapping);
>+               folio_wait_bit(folio, PG_writeback);
>+       }
>+}
>
>[...]
>
> void folio_wait_writeback(struct folio *folio)
> {
>-       while (folio_test_writeback(folio)) {
>-               trace_folio_wait_writeback(folio, folio_mapping(folio));
>-               folio_wait_bit(folio, PG_writeback);
>-       }
>+       __folio_wait_writeback(folio->mapping, folio);
> }

Also, the last sentence in the description would need to be dropped.

Thanks,
Davidlohr

