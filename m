Return-Path: <linux-fsdevel+bounces-41687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC48A34F82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 21:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C93C16A184
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 20:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612232661AC;
	Thu, 13 Feb 2025 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="vMkTh/Jv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WsI1nZAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B28324BC04
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479073; cv=none; b=JnuD3ctxqg6QaJQB/t99BR/COTAvx5RZwPGBVSiKB1g9V4WK5NEqLK8YPzONcabZvSoup2ssdFPqCY+2dLX/Tsd1KVtuo7jeelN+q+xZplNf3yqWaMy6bX4S08Xo5QMoOFBOb5tQPE5Gb90jOoExW4gEnMUxWMZKDTb4c4i4CEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479073; c=relaxed/simple;
	bh=bT0q75LP+8fvDTvm9Cg/Qvhjj+asBA5hB+FwWqjoxGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnLxhnJ15zjqF30zFUMimMmp7LkjqGhkeZZa2NRw+3YZwS5QgQJHJjTzjuz6sJZqXKdyfAMXB2Z1zxry7gzBck5kKDO3HZN42DIBDXtCtaMYIPzW1e8iag9INLt0x4JjNwpgy64O4C2PB0L4oG41GYhezSTf8O8hBJm+koWXEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=vMkTh/Jv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WsI1nZAn; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7148D114017B;
	Thu, 13 Feb 2025 15:37:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 13 Feb 2025 15:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739479069;
	 x=1739565469; bh=iRcRstUeQWp3n42PM78DjwB7BDVal38XD4+uBuvUxLs=; b=
	vMkTh/Jv2uCOW10pjzWL78LJiTs/3+gRj4fJaUID2PtgN/V3tHahkvJfHv5ZX7Vk
	FoAVMZJtmCbAd+4whygzrVvnxX4rJiso5todlizbV1huj8RSed/HZqi2ZyUC+/Q5
	yII+GB8+qcm/nXJJ3zZESwgXyCjnA7g8MRx7qLfivagAuO44vy9sv4BO2aQlkoXU
	ts2XbHmwugs5GuihhWzt7hygLNGaB5mNZV3F9C0iq0OZnLTNaPJNRF3OJJF6oKDM
	Xzadoj2FCM7JY38Uq0C5NmJx0P1ZToUjn5KPJWUAxCB82AfP1L6hgzQNsZwinPFF
	JJpPr6VwwaLyuHgx1MG5Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739479069; x=
	1739565469; bh=iRcRstUeQWp3n42PM78DjwB7BDVal38XD4+uBuvUxLs=; b=W
	sI1nZAnffvKUx+P7SYh9sVI1AgQ9B6n1WAXzSbEiJZF3+WBtELGvt4fNHIy9K2rw
	oHhkmYVJKOXdf2Iw9VcXH1tCy83KRR2U2sLaODm8SwkebagGM2luNWZAkINLUgTt
	GZGjFIVkegPoeBc53ivkQOrbJXTGClE8vGREXLodNDGW6pJCVtwuIO+YbD6HOVSd
	c99GP3sm2HovTjqbRMcrbUYzoUT5dEqFtMhkf/dpx0d28qHMHrLUkt4MNGEB8UcW
	B6ZPa6yGH4WkR3aXvGpzKAkVTIsENiTevu+M4jrOz5liJGdFCHRXfXi3b89Do6py
	j02t8mvNS00/r2kQPagpw==
X-ME-Sender: <xms:HFiuZ07n7QXyr8AOeqUUu1GEI6eCoRjswbOwmLrDkbmKICRT9GNMsQ>
    <xme:HFiuZ16s-Wt10cXj0AEaWdrkJhFaYdWvl8CM2xLFzcbP70FMiaJhj-LgiHgiyoRZI
    OZ4s3ObCezLXk5N>
X-ME-Received: <xmr:HFiuZzcwM6xOHrAPO2fDSAgerdUdnyfZUXm2sPOiyE1_epdYdWPHSlKhv15kCuo9ComSIirV3whg7MU_D3anDgFg4QPItZ6Ij593wm2mSVz6jC-JjqSD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghssggvrh
    hnugdrtghomheqnecuggftrfgrthhtvghrnhepfeeggeefffekudduleefheelleehgfff
    hedujedvgfetvedvtdefieehfeelgfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughshhgrfiesjh
    grsggsvghrfihotghkhidrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvggu
    ihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:HFiuZ5JdtLiNGRtZLBkyn7f4pT2ywLeegXremVjnZiODaqLo2YP2_Q>
    <xmx:HFiuZ4LHuMtBlaFFPB-aG5UTTtXdmluCWRgAy_bm_pfuYvc3mu6J3A>
    <xmx:HFiuZ6xaqukM5KUua03VrSKj855mLEdExT6XCFQcrraml3Rr3NyMLA>
    <xmx:HFiuZ8K0LLycYogDVn5ETwarVhTnLRys66otSR2Up11kz85ZBv7Qog>
    <xmx:HViuZ83pysGoj9rgjfKn0YisYzgZNm6Smu9J9QdcftMCuRenFuOM1CBg>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 15:37:47 -0500 (EST)
Message-ID: <ebd9aaae-a5bb-43cb-b802-75d95026bc74@bsbernd.com>
Date: Thu, 13 Feb 2025 21:37:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Odd split writes in fuse when going from kernel 3.10 to 4.18
To: Daphne Shaw <dshaw@jabberwocky.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <34823B36-2354-49B0-AC44-A8C02BCD1D9D@jabberwocky.com>
 <CAJfpeguq5phZwqCDv0OtMkubmAmo6LnQxZaex2=z4Xhe4Mz3fw@mail.gmail.com>
 <8BE8C6E7-FB3A-4ABA-8493-E37B69732E50@jabberwocky.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <8BE8C6E7-FB3A-4ABA-8493-E37B69732E50@jabberwocky.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/13/25 19:14, Daphne Shaw wrote:
> On Feb 13, 2025, at 4:58 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Wed, 12 Feb 2025 at 21:01, Daphne Shaw <dshaw@jabberwocky.com> wrote:
>>
>>> Can anyone help explain why one of the 4000-byte writes is being split into a 96-byte and then 3904-byte write?
>>
>> Commit 4f06dd92b5d0 ("fuse: fix write deadlock") introduced this
>> behavior change and has a good description of the problem and the
>> solution.  Here's an excerpt:
>>
>> "...serialize the synchronous write with reads from
>>    the partial pages.  The easiest way to do this is to keep the partial pages
>>    locked.  The problem is that a write() may involve two such pages (one head
>>    and one tail).  This patch fixes it by only locking the partial tail page.
>>    If there's a partial head page as well, then split that off as a separate
>>    WRITE request."
>>
>> Your example triggered exactly this "two partial pages" case.
> 
> Ah, we suspected something like this. Thanks for the pointer.
> 
>> One way out of this is to switch to writeback_cache mode.  Would that
>> work for your case?
> 
> I will run some tests - it should, as the only access is via fuse so nobody can modify the files behind its back. Even so, you said that was "one way out". What would be another way out of this?
> 

You could also set fi.direct_io (FOPEN_DIRECT_IO) in open/create, which
will bypass pages altogether.


Bernd

