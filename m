Return-Path: <linux-fsdevel+bounces-29088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6B8974FB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 12:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9542628390F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579AD1714A1;
	Wed, 11 Sep 2024 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="W0oLynTp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XMJWC/RQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AE39AEB
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050675; cv=none; b=oXRN6+QL4gpeCbae1AWAr2Ha4/+hfo3QcHr7haE1pYlKzP7CT5IqymhvzpFLLLBjCEAYyT0kXmUJVU+/j9xiett3jHXrBXcflkqPDasddSBdBFXCCkaVxIlgD7blK9zMfvQTKyFhStfZ/I62Y6YVJoWBdmbTaish5NL+aNY+ezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050675; c=relaxed/simple;
	bh=4HtMSf90pkWGRf9S127bizU7iKMzn0jEnuM3MA4yZg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AL+YJeAndvL9s5EjAlfArDH9CgnRz84HXW2ZsMcQ/40Yy7kO6M8IMmXmCzEhtntDBGMJkqngD87VorqgZ0sD61HmMpAZotnEky07THidOn52vJDWfpNvRb1zLDZix+TEg6Dc+p8OPe6eH5yv9Dw+Dn+6URn/ciVVTjL/myPO/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=W0oLynTp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XMJWC/RQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 4077013800FA;
	Wed, 11 Sep 2024 06:31:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 11 Sep 2024 06:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726050672;
	 x=1726137072; bh=Nb4nKR6WT4BOv5UiZhTWIfiWJCloDNufWKEUthUix/w=; b=
	W0oLynTp9vHEJLcNm02V6c0VwGB1FqjOCyPchXZVzNMyhWdJOvu4Eko5mLewkgfR
	4e6I8LHc0d0cPtQNGxPkMv/RMRFGJBLQCY9zqyT8WeVkP+TGQk7+dEoCYXkgNmsS
	opuyEH4luYDyrFoeN3C0phmBU2pFKWV+Wb4F5J5y45j2qbxVe5Dsx/W8/gCBLGtR
	e2EJ8sNW5KU/WpkFlQ7b1/KMOd2OJqafWhbeZZepCox71NTbkdNj3sc66Fj8s2SN
	iohG0HS07jrXDBstbd85p3gIzvrwoEXOtBnx8klRIVczr0kTSv0/mfwRp+ANwjjt
	o9RwRw28uyAzEemXpNT8NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726050672; x=
	1726137072; bh=Nb4nKR6WT4BOv5UiZhTWIfiWJCloDNufWKEUthUix/w=; b=X
	MJWC/RQhM8EYsrvncwc+a5UTgQnp0pT/5GYKkA0O5jZAnMxtTWVVCgHiw02UHxLx
	9bDzQ9WvmZTARPxBugrHYpv9aO3abmILft3EowiapjzI2J6RgVJRgsa3RlR0YUrW
	Whewt/I5Z+HRtKRl0j5GwEPKHjKD5XxaCNickHqQfP77pks8WHIhzvNaTEwJOw+Y
	f4ftXt7ZNivdx2YzDcyDcIEskDcXhmcVi3lF7ntS82boUHNKtH4Aa62OIhBOWoCs
	q8eplkESwt8d1Ey6niMp0jxJ84vEFS/vjl0oUqbJSxzoIbmRhivppBaX0MP32dL3
	diQh5jAxnPgx2VFlzL94Q==
X-ME-Sender: <xms:b3HhZhCxVOp1MNsJhG5vqGQuwsU6chQUk45AbijnpjfA4RwizvzRMg>
    <xme:b3HhZvjf2T_S-BqQlfweFT83EkMcnD5ZtQ67fP9SV8ak4F_idJmr41fwAUJtAeibM
    vna-g792LMBVsyv>
X-ME-Received: <xmr:b3HhZsmE_W4IlEySl8Smu7J0xBGpLStTskhiFr9GCpZ1ihEBXH_mbGpfejZSyy9qu5b-BsM7rFtdduROSs-aVikxzqnTf0FuWGiyemaX00Gx-x941phO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejuddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepleeffeeljeeijeef
    udehleeltdfgleehueetieetheffjeefvdfghfejfeeiieevnecuffhomhgrihhnpegsoh
    hothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghnfigv
    nhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhu
X-ME-Proxy: <xmx:b3HhZryLbQMVhPh9XrlsbTTWh7PYEUbYLIXimtIoQGzeT5FzzXnrzg>
    <xmx:b3HhZmQrw_YBONrOpe-KrSfGoiA1i1sQWeYkggi1tKh4KA7T_fvyUg>
    <xmx:b3HhZubtK6PNEnQod1-3ryMPufi4lVGkNvzqRFVOzHMBJd1rIArTDA>
    <xmx:b3HhZnSAFii6oa88VK7sF5IY5YA1S8EkD9Xj54RyihAIDiywLUcFbw>
    <xmx:cHHhZsMpZBYAket3WS2g-WOxPR2f6woiJY3BzH729TW21xok5xVw2d_D>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Sep 2024 06:31:11 -0400 (EDT)
Message-ID: <be572f0c-e992-4f3f-8da0-03e0e2fa3b1e@fastmail.fm>
Date: Wed, 11 Sep 2024 12:31:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interrupt on readdirplus?
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
 <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm>
 <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
 <CAJnrk1YxUqmV4uMJbokrsOajhtwuuXHRpB1T9r4DY-zoU7JZmQ@mail.gmail.com>
 <CAOw_e7YSyq8C+_Qu_dkxS2k4qEECcySGdmAtqPcyTXBtaeiQ7w@mail.gmail.com>
 <0a122714-8835-4658-b364-10f4709456e7@fastmail.fm>
 <CAOw_e7YvF5GVhR1Ozkw18w+kbe6s+Wf8EVCocEbVNh03b23THg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAOw_e7YvF5GVhR1Ozkw18w+kbe6s+Wf8EVCocEbVNh03b23THg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/11/24 12:07, Han-Wen Nienhuys wrote:
> On Wed, Sep 11, 2024 at 11:51 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>> If I don't ignore the offset, I have to implement a workaround on my
>>> side which is expensive and clumsy (which is what the `mustSeek`
>>> variable controls.)
>>>
>>
>> That is the part I still do not understand - what is the issue if you do
>> not ignore the offset? Is it maybe just the test suite that expects
>> offset 25?
> 
> Not ignoring the offset means that I have to be prepared to support
> some form of directory seeks.
> 
> Directory seeking is notoriously difficult to implement in general, so
> few if any users have actually done this. If you don't have to support
> directory seeks, a FS can just compile a list of entries on the
> OPENDIR call, which the library can then return piecewise. This is not
> correct enough to export the FS over NFS, but this works well enough
> for almost any other application.
> 
> I can probably kludge up something if I remember what I sent in the
> last readdirplus call, but then I would like to be really sure that I
> only have to deal with the last READDIRPLUS call (or READDIR as well?
> not sure.) having to be redone.
> 
> Besides being annoying to write, the kludge also takes up memory and
> time on every call of readdirplus.
> 

Ok, it was a bit hard to extract that information. Basically kernel
behavior doesn't match your expectations and causes overhead. As I wrote
in the evening, I think the behavior comes from static bool filldir64()
(or other filldir functions) in fs.readdir.c. Oh, I just notice I had
posted the wrong line, correct one should be here

https://elixir.bootlin.com/linux/v6.10.9/source/fs/readdir.c#L350


As you can see, that is fs/readdir.c - not fuse alone. And I guess it is
right to stop on a pending signal. For me a but surprising that the
first entry is still accepted and only then the signal is checked.
One option would be to ignore that signal in userspace before readdir
and to reset after that?


Thanks,
Bernd

