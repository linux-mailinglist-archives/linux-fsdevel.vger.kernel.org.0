Return-Path: <linux-fsdevel+bounces-23423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC0D92C211
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2181D1F255C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A42518C161;
	Tue,  9 Jul 2024 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dg3hD66Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YsMw5RrY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25791B86CC;
	Tue,  9 Jul 2024 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544809; cv=none; b=kbvUcwDZTW2OgJO5Kas7DtIzkBoHTsCV3r1kNXAM8aA6bdrDMS5YD/nn6Cf8WzlIGbEwKxMddEo71KbCZ6vMRneDKDVfemaAv5NqSbM9et8LHQgBuDV/ZAY0w3WALjZvtRgAKouJgRshhcfQgGOhNApznzGorBQQJ1ZM1CDZ2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544809; c=relaxed/simple;
	bh=ZqJG0wg/C3aFDJJmfPLpDLDKejbIR04eebcxTMSTEJ8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=i69zxcJ0F4CR0qMMYPMFBiuNTAujGjZkzPDv6bZOIFRMRVgTc1AIKxA7V5X1OFE1X+wdQoCsH43r3PJqGoyujCUGzCHuSNW9PF1E1344nuxfBl9k5mARpvxhcXGrVdcmCsAs+Eo/4gVn3R+7mt4CAtLFw6znHQYQgxQuOdL0ofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dg3hD66Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YsMw5RrY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BED451140459;
	Tue,  9 Jul 2024 13:06:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Jul 2024 13:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720544806; x=1720631206; bh=thlpn3IW/x
	SugcCxmZ9N0SJbK2pVR7lvBRzalO9m2Oc=; b=dg3hD66QLQP0LzfeBhlwFJU80d
	43NNkYdOslU6fMRItB2X8Ik1dTAQV0y0ENysaQ3mU2yJPWG7PHcVWJTGAozQy3Br
	jB5+3xcUVLmoLHsVo2MQumcBffGBVfuJa7tGK1TlfJ43I0UsF7g7lVhNsI5Bl6/0
	BuyzJpJk+rO/9I3cuoNo7OclvkhYzIVyAJasartHulfOWBtWRoO3+J7ZC0cI007u
	cj+fa5vh03XQUcI9VMyAg6oCKwwIKiGSNPw2KqFXh3m1tRAYRksAPd5DyzbBTOha
	+R4SGALc6VROGss/i40m+2O0U/E8oh1JbHD1vpzcGt4kZWRJsWf7NW8/z5HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720544806; x=1720631206; bh=thlpn3IW/xSugcCxmZ9N0SJbK2pV
	R7lvBRzalO9m2Oc=; b=YsMw5RrYDZOqnokpGflUSQhmb5kuZaIT276tP0MxWkVY
	N5ky8vArJYUuuVr+hBZr2ZYfSUOIxAR0gBgmn98tryfTTKYEd99haGVHV0wYKwSG
	T4XtpQ2HcPIJAHzNsG+obzTTVf4UtOTjm7CCGBiBB25zea/VPAU44JqMuffelLiD
	oEFOMrgHPAMkY10b/2WLt0yoGSf6MF6l+jR3RKjq0xh601I1bl1gQa4XEX5gSj/q
	kf2brlSxAnYgVEWeduFCSq1TUC2RIiO6GE0wrHS9EEa8L89ZIkWaoVEsI81QUgv9
	CedmA84j8tW+Q8vXCWhzWIr+1azA4SHmzP2DsQDEBA==
X-ME-Sender: <xms:Jm6NZtmw6I3T-sjNn7eLDsZAt2E9C0vEL6tCYu7Ak9zONeSNSwImvQ>
    <xme:Jm6NZo1e-PiZEskkbxMbMHswgdZ9omXqnEY7y-1pCidTLvljjZ6wuZdplqUIvfuPR
    3g3WLa-uB5eeKjmrCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Jm6NZjpID45NV_0o1jUw848YR4l1TMgvUgkjHKg2NL8kXP0bNvpPSg>
    <xmx:Jm6NZtlIwV1jYkBOcgtpjEuk0qqWk8KIS0I5d4Lew0XpRK0aqodWtQ>
    <xmx:Jm6NZr2-DiXzzCjaqgd_oXe2TNPxXj5QTBGHc5AKShkixxx1Yk7w9Q>
    <xmx:Jm6NZsugx0MKCFOSsqryX-cJiBRd-dBR-dmf-r_o_z3t-tqKMD-6Tg>
    <xmx:Jm6NZmRiTvC7gfiZrtHbZCzgORhsLFEx-61Rua3uKeX753NWmA2N66ZZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 260ADB6008D; Tue,  9 Jul 2024 13:06:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c8e44728-6c09-4fbe-9583-1f8298c3ea39@app.fastmail.com>
In-Reply-To: <edd2d831320fb14333e605e77d4b284b1123eb86.camel@kernel.org>
References: <202407091931.mztaeJHw-lkp@intel.com>
 <c1d4fcee3098a58625bb03c8461b92af02d93d15.camel@kernel.org>
 <CAMuHMdVsDSBdz2axqTqrV4XP8UVTsN5pPS4ny9QXMUoxrTOU3w@mail.gmail.com>
 <c4df5f73-2687-4160-801c-5011193c9046@app.fastmail.com>
 <6ab599393503a50b4b708767f320a46388aa95f2.camel@kernel.org>
 <92726965-19a0-433b-9b49-69af84b25081@app.fastmail.com>
 <edd2d831320fb14333e605e77d4b284b1123eb86.camel@kernel.org>
Date: Tue, 09 Jul 2024 19:06:25 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [jlayton:mgtime 5/13] inode.c:undefined reference to
 `__invalid_cmpxchg_size'
Content-Type: text/plain

On Tue, Jul 9, 2024, at 17:27, Jeff Layton wrote:
> On Tue, 2024-07-09 at 17:07 +0200, Arnd Bergmann wrote:
>> On Tue, Jul 9, 2024, at 16:23, Jeff Layton wrote:
>
> The context for this is generally a write or other change to an inode,
> so I too am hoping the overhead won't be too bad. It does take great
> pains to avoid changing the ctime_floor value whenever possible.

Ok, I see. Have you considered hooking directly into the code
in kernel/time/timekeeping.c then? 

Since the coarse time is backed by the timekeeper that itself
is a cache of the current time, this would potentially avoid
some duplication:

- whenever the tk_core code gets updated, you can update
  the ctime_floor along with it, or integrate ctime_floor
  itself into the timekeeper

- you can use the same sequence count logic, either with the
  same &tk_core.seq or using a separate counter for the
  ctime updates

      Arnd

