Return-Path: <linux-fsdevel+bounces-34126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A60F9C28DA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEE02838F9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0D79CF;
	Sat,  9 Nov 2024 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="QLIdSrbX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YNQzAs5U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53D33FD
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112382; cv=none; b=jQVNUCiPEQM1NTeOkhv+EMU+mEgrYY5rJ2VQctFaaK7NQEmf8tBxQVQaTfnbk7M89Zu/48VJD+lTcz/34InW5PjcTRQ4eIgq0M3msobWLAewy6OQsZu20i09cfHQg0CSeyb9lZ/27+Rh44+1SufXflKlCm0Qi/hJAjbWIBBmIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112382; c=relaxed/simple;
	bh=3KfHMnig3R7dC5eXjMwyLYxCzfzE19yqfWKlrIK/88M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5g4f+8LsvUhX9guPKOn1ZuMm311GOuK3+YeMBHJwRS4TrRc9CwF/NkQGijP+mkeGm4/KbeNhLb+G/XrSZrVchbB73G3Jun/o6bTEZXffiU2Bw3vTu67LrEPz5k4PQLaqJtwusAfPVJe+Y+fso6ntrJg0du8k3H3bRj0ypRGeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=QLIdSrbX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YNQzAs5U; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 18CFE11400AB;
	Fri,  8 Nov 2024 19:32:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 08 Nov 2024 19:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731112378;
	 x=1731198778; bh=sKErXZ0cZ5MqAJ62XmeQIsulSXyFMX+VUzA9LA05WII=; b=
	QLIdSrbXXFyo3PvDWT/QJuiJUG+H9yUZTJV2Wbyar0I2UuoKzKUMzG3SiqWTW/Nf
	UiUTTeAui1OC7nAD7GTUYmLypjFchpB8PbM9dHD8oqPdoB0AM/i79YrAhi7xae/N
	sEsGZd3+vIJCNcGXLKLLjkd1esfRmRHLajjDVam25WT7wppE+rAhiflHameCzH8K
	q0FOtA4QLPcLkBzruUozS9zwrc4xh4G+3c2cjFoYuNII+E93cEeuk3p1esSCmAoD
	Tvpi6rwmf1+C3foKmN2awY9Bd1yIbPO3yUrjmSRnavdvnkRh2opQqWhW4AVp7vi3
	c7vbcP35XqbDMRRRnWae8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731112378; x=
	1731198778; bh=sKErXZ0cZ5MqAJ62XmeQIsulSXyFMX+VUzA9LA05WII=; b=Y
	NQzAs5UPDxkz4enA5YI7B8d5/Nkcg13wjwY9jWTOjwvYpHAtPD66ovxy2Jfuno3a
	MTnKJzSuYqE3klPjDZPhRDTAyofJ1B7vfHGbu9TieDuRmxnhUlkYwrKB3/853pLG
	2YWzek221ZqITQRMsUb5BsSWCLZHKwr7Q5Sp3s+RbMSDJjV5cTiNMt7RshkRR6b6
	69jLEEa4LBByhqxV/PNFhmbE4uPP21wBNgBHt7+Ptq3ZuejDE5SiBoav4XGzdj/U
	evYXrdyCRyglSdgC2Oa7bP/8Ya4eo1AysTY0E50yosLdu/GMC+jDvaa4K62AB64D
	+Ja5mxIxnjCoBDP6nPxNA==
X-ME-Sender: <xms:uK0uZ48Z0Mj9akvpshYCSycIG9ApgqLZ2mZbzJIUevOthB4SLlqudA>
    <xme:uK0uZwt4W1EbpaprWqbsP2MiI9yXTONv-bjN8o46Zk99YIzCq96g9rOj3Y8DhqeIp
    6nr-vq1upxkBrP7>
X-ME-Received: <xmr:uK0uZ-BWUP2ZBiOJUW1JD6wJuc8CuerjBkD2p2qhWOFTmVvRXqKa8hHWySz50zfWIiUdy39VdJXM7LAw9I0WETQCVQCOmaV0ua5HTzfZ2HkFeYOAXUcY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdejgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrh
    htsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeeutdekieelgeehudek
    gffhtdduvddugfehleejjeegleeuffeukeehfeehffevleenucffohhmrghinhepghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsggprh
    gtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghl
    khhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvg
    guihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomh
    dprhgtphhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtghomhdp
    rhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepsh
    hhrghkvggvlhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohepkhgvrhhnvghl
    qdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:uK0uZ4eppaTxZ1FWxfF-c0mDYiSyOD49CyatbfPkw7jSNEPAC3_Ntw>
    <xmx:uK0uZ9M8kIfhNyFNtYF59FtNoDBkR80TJ7CkkC6QKaF2og-T5s_Eqw>
    <xmx:uK0uZykUetws1HY7WJnUNLK8ts8Gk9pnw2FOHfrvRFXChfegHzKJuA>
    <xmx:uK0uZ_v8gCSnJzf8aKBnoM1kH7P1bWn9WUg-oUbdOMXreyyt4GTBrA>
    <xmx:uq0uZ2i3QocFipiisJXFpDVFmabIDFXmVDr2eMUfpSp5vbqj47mi930C>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 19:32:55 -0500 (EST)
Message-ID: <9f8310d3-882f-4710-ad48-9a7b96fd6bf7@fastmail.fm>
Date: Sat, 9 Nov 2024 01:32:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] fuse: support large folios
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, jefflexu@linux.alibaba.com, willy@infradead.org,
 shakeel.butt@linux.dev, kernel-team@meta.com
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <CAJnrk1ZhK6kAvPzjnzZYFg7XyytBKR=6d4ED9=dTDVwuskosxg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1ZhK6kAvPzjnzZYFg7XyytBKR=6d4ED9=dTDVwuskosxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joanne,

thanks a lot for working on this!

On 11/9/24 01:22, Joanne Koong wrote:
> On Fri, Nov 8, 2024 at 4:13 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> This patchset adds support for folios larger than one page size in FUSE.
>>
>> This patchset is rebased on top of the (unmerged) patchset that removes temp
>> folios in writeback [1]. (There is also a version of this patchset that is
>> independent from that change, but that version has two additional patches
>> needed to account for temp folios and temp folio copying, which may require
>> some debate to get the API right for as these two patches add generic
>> (non-FUSE) helpers. For simplicity's sake for now, I sent out this patchset
>> version rebased on top of the patchset that removes temp pages)
>>
>> This patchset was tested by running it through fstests on passthrough_hp.
> 
> Will be updating this thread with some fio benchmark results early next week.

I will try to find some time over the weekend to improve this patch 

https://github.com/libfuse/libfuse/pull/807/commits/e83789cc6e83ca42ccc9899c4f7f8c69f31cbff9

It basically should give you the fuse interface speed, without being IO bound.



Best,
Bernd

