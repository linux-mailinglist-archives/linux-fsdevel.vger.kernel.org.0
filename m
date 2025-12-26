Return-Path: <linux-fsdevel+bounces-72123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AEDCDF249
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 00:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84E3C300789A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 23:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AA128980A;
	Fri, 26 Dec 2025 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="k6Op2MFL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9hD+4bO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE36F4F1;
	Fri, 26 Dec 2025 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766793500; cv=none; b=Nsa+xUkQ0O8vZW6EYxqQ5uqGllbZNk/RqGSCj/1PiD73LNUYLnk9p3zflF6bMCm2ZgyRiQDeVbu1toDvRJXH7tzRzGgoQif+blOZ164fxSfLHBKMf13DOkRgpEGMWLIsy9suaF6xF6t4XpyBUTcPeWPYthwnEBCUsC1ztGZoKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766793500; c=relaxed/simple;
	bh=zRLmVnYeRSFcZlCjgIszfhNKuakh2j2GEY/j42RfBtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CU1rTitiqwRVIVx3gqkviBf86lKIW/hyVcFgfAZY0HhSFUrQy0Mmoc0OMjHbyCOk+1hFAiTayWKx6T9ESk4Pis86f+Aq7bP6P+qr3ZbDWx9lIbOlqOYdUzqHLudiCopxDCxpl6pPC3/DetD8hDA6uEJC0yFJtb8Sh4ayr/eFTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=k6Op2MFL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p9hD+4bO; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BBA217A006A;
	Fri, 26 Dec 2025 18:58:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 26 Dec 2025 18:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766793496;
	 x=1766879896; bh=d+03CflXQCI16mDu2/y/gDZidxMLNdelGVGnEAD9RCg=; b=
	k6Op2MFLM4gTA/hYHX8xWwC6csvtWfeQzuo3FxV0uwHsfyJaPTagjg0leUTBf6Bc
	KMvnQhO5tgZTjuwcL0V8ozh7L+aswrsxcfAezz0piakssxAyYbOSKMuFaagpdokL
	oWmzxHfWcqEJQrBljVza4Xtq31bVI7mnVAh7/zYDyvsT7IHZ2/XKw9u5PqJx0tdi
	RXfs7a3raRtuMEe0gEuPY2pDxiUESDufsV2oXhmZ/IFeOsztumxPyG/Nxql86Q9t
	+q0ljC+rq3uhPghMUXSNNKGNKxpGONvnTNdc1HZ5/Xqb+o14M8uMMFMht7MlZMWi
	CCSv5V4LTUtlXNPmmg4COA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766793496; x=
	1766879896; bh=d+03CflXQCI16mDu2/y/gDZidxMLNdelGVGnEAD9RCg=; b=p
	9hD+4bOW1P0R6kx6R7wpEgJqEKLeyCO/Hvd2emu7fe1dNogRyIiJoauD6ZB3eoZG
	+IvlPaxtuv4MHNManXhzx8uvPyGF0P4gEXA8CwDZeAvlMhxa184z6KYR3H607CMU
	NHqPO1Q0/AQRQpL8u3dvqsWtiEVcSWE1hGA9cH+E6HGsC8gwJexQ6WgMua/OqTcC
	Fl7BqRpx6Tf8Aw2YwQGBfHStX+xNANSwUQ3U3Wf3SKH+JntP+EGZij6INrD2cJTm
	oqsFrWZBgCQ4DrkFoCjBmPUFa5Fs6Y48RyhFqxQPKPRZBcUPgy+VZoSfCuCk6JqH
	ipUxrCuF1Q3lLkRwVOkvg==
X-ME-Sender: <xms:GCFPaZ0iGGK9QOPUDzuXWLg9WD04TCsJ-bYGSL2bJdVwD6eAgpFtCA>
    <xme:GCFPabDpSxGnCBFRkRYwC641UVXHpLVF4xK_-PG4v4GQ6Jty4FXx3o9tTbDVZeeX0
    04A1JhWugyWFqxnlJzZHxZ85c47eqjZONphcLHtUOcwmXSw>
X-ME-Received: <xmr:GCFPaY4Wj60QmCx0e991QVxEFEnW4cubU55yycJq3N8XprdNA9WeUW9yvKWOF8gbOsu1IjWEzJy4bXXGUjzSmd7_tWwNg5HoCPZGOSEq1rNPHsLMmwwCTWs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeileekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpeefke
    fhgeeigeetleffgeelteejkeduvdfhheejhfehueeitdehuefhkeeukeffheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughjfi
    honhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgvgihtgeesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdigfhhssehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthht
    oheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GCFPacIy5mEeyvjbNoV7ZWO9F7VJkKetvs5LJfkW5eso3pCRDQLC-Q>
    <xmx:GCFPaZvEuXLsOThMxfRsEu6NNnTX1q2G6xZVDMcqgiboOVh1O7ojOg>
    <xmx:GCFPaTJmT_eKJX-RLJfZ9dfRRrog9xWy8NqzFSpM-Lde2SmEMLyaaQ>
    <xmx:GCFPaa9DbHwnAu0BB27tmYpZ3AKkjFpaYrNK9fegOEGJadkTK2oxJA>
    <xmx:GCFPadQJBATT6J_uMz_91-7NUjc67ViIyq3szfL2LuykLf9rlD7dMspr>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Dec 2025 18:58:14 -0500 (EST)
Message-ID: <284c79aa-7088-40a5-a6f5-31de8404e62f@themaw.net>
Date: Sat, 27 Dec 2025 07:58:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] fs: send uevents for filesystem mount events
To: Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
 linux-fsdevel@vger.kernel.org
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
 <176602332527.688213.9644123318095990966.stgit@frogsfrogsfrogs>
 <20251224-imitieren-flugtauglich-dcef25c57c8d@brauner>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20251224-imitieren-flugtauglich-dcef25c57c8d@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 24/12/25 20:47, Christian Brauner wrote:
> On Wed, Dec 17, 2025 at 06:04:29PM -0800, Darrick J. Wong wrote:
>> From: Darrick J. Wong <djwong@kernel.org>
>>
>> Add the ability to send uevents whenever a filesystem mounts, unmounts,
>> or goes down.  This will enable XFS to start daemons whenever a
>> filesystem is first mounted.
>>
>> Regrettably, we can't wire this directly into get_tree_bdev_flags or
>> generic_shutdown_super because not all filesystems set up a kobject
>> representation in sysfs, and the VFS has no idea if a filesystem
>> actually does that.
>>
>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>> ---
> I have issues with uevents as a mechanism for this. Uevents are tied to
> network namespaces and they are not really namespaced appropriately. Any
> filesystem that hooks into this mechanism will spew uevents into the
> initial network namespace unconditionally. Any container mountable
> filesystem that wants to use this interface will spam the host with
> this event though the even is completely useless without appropriate
> meta information about the relevant mount namespaces and further
> parameters. This is a design dead end going forward imho. So please
> let's not do this.
>
> Instead ties this to fanotify which is the right interface for this.
> My suggestion would be to tie this to mount namespaces as that's the
> appropriate object. Fanotify already supports listening for general
> mount/umount events on mount namespaces. So extend it to send filesystem
> creation/destruction events so that a caller may listen on the initial
> mount namespace - where xfs fses can be mounted - you could even make it
> filterable per filesystem type right away.

Seconded, there are way too many sources of mount events for them to not

be specific and targeted.


Just my opinion, ;),

Ian


