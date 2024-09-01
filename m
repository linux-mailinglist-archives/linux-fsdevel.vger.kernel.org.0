Return-Path: <linux-fsdevel+bounces-28150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8867967655
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 14:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E445AB21290
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE2A16EC1B;
	Sun,  1 Sep 2024 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="A+8wLkgO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ggsk/X2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0758156C69
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Sep 2024 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725192438; cv=none; b=UdWoG93qofDEZi3W2110q6FEM9q9A/eAFwbHUxEb+ChYjrz+vapaBiIcyqMcl2pQNpu7FzBJS7AA7CaJbon5CKhcws/I9/ZJwJZS5Fo7vodBFb90wqckM8v2KwR5IsrH/Wp8ZkoUOLaY9Po96RYQnhAq7exdg4PzPsjph96HbGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725192438; c=relaxed/simple;
	bh=LEUekiBkZYVAqVnzfyUD5JwIN4lgmJ5FoakhGwMjbOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9DE0hpd31kN6sjpLk7kZPycJAiDdeO3fyZifqYRA/DowfVmAHyVZuCX9AQOM8KaAluqT1SSNEC5UFQGfblNViBq9glVl3UXZQY1C23hriC5FS42uoHH2a2lSUUdBwIFCkwCEx23ascphMzoY63kEh91uKXdv4y4GT0YXnjXsII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=A+8wLkgO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ggsk/X2b; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1B83A1380338;
	Sun,  1 Sep 2024 08:07:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Sun, 01 Sep 2024 08:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725192436;
	 x=1725278836; bh=Odk7x3xnwsxL+OJKkYWwHro+TFycjC10g7sjDo6WbIc=; b=
	A+8wLkgOG8TPQxREfQbq64NUGojQLmRj+S0uOLFnIYzJfzIyOryGHmihCbWfL00k
	883HyjF8NVOD1nsavDrIQ4Nf51p4MaLpBPfRXKQUGroHc1Ig+J9peW/tPgwOhaq7
	tsbk7qRIa9pWJsWvDeA/l6Hc6JRx1IKmz91D1zg9TXoXjBIdGUi2NbQpJtaAVNLU
	MhmNLFn5jywAdPHOKg59rcWUYYMr6J/8DgWPLDjHAiIcvcTWHk49Uh56Tq3hBS+W
	jhga29gJNXzBlfHL67/9ZF5xgBWhxmNonpDPJvRly5pggJtkGrrgTGmZYavUwitZ
	ABZTahnZd+epdq6JYugyVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725192436; x=
	1725278836; bh=Odk7x3xnwsxL+OJKkYWwHro+TFycjC10g7sjDo6WbIc=; b=G
	gsk/X2b1FLBXwBvW/qgxPs4Dhd0I+j/Z/IUDq6e+IfnZS3gk1OHWBWXr+TNwyQ2Z
	92hCCp0NEvKcRgyHkvaIms5JsJBQDL0rYVI5Dw//oj1G5S9nGgg10lt8m6RkG1jp
	bb9QiAP+hODQEIEtZOdbzQ4QTmA74C6HB3d3AV47cabFBiARMbVulq49Cu2qzIzh
	+1wCO6/M+JOJypAu2hdNpJL6glJqS8EL2mpj/vthzsuqk1W1lTznFAOFpoe5uOgc
	RRJAhJtyBVqer/+VPuC/JNV2cOG1DtPn8a+iJxVEpbI5Zy7E2Fk9MI1dsPBnoIUl
	WEzsuolPkUBrwFMyaCISw==
X-ME-Sender: <xms:81jUZmc6g27B2kJYxLORP7PBe4jjLWti1qTOp83FUbYJtYJXMbSJ-A>
    <xme:81jUZgOEQmXXPTlQ_HmfdCE1rGMVnt5ucLN6VQDN4r23YHf09gXoWPQ1gt39BJ5X4
    PpSFxKx-T9RSrdd>
X-ME-Received: <xmr:81jUZng_ESTbBXrMq9f5K8-uRpkvuWkuOGpR_KghAnoj5JDr4THahULYgkg0d9Aiw1saawoeyLbQcBKeNtF0G4icj9lzjjBhFu8IFoav8smER2IIoDa8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeghedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphht
    thhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtohepjhhoshgvfhesth
    hogihitghprghnuggrrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughi
    rdhhuhdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghvrghgihhnse
    hgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:81jUZj9C4bFKGj3NkZZOzQs2xJ4aNPovTbORQQmgF5dSqRHxcZD_0g>
    <xmx:81jUZiuTxQ5sp74Nfzkj9r-tTyNl4voeHbtGvfedXvwYtZ0qduVFog>
    <xmx:81jUZqHn4kKRMnPziB3AuHDDQzw8LErEnuIgDGgwndnIk7z2QgWw-w>
    <xmx:81jUZhPXwO-vIdxLf1LQbKY2eQREr2x7ERFjM-d0ALlb-_n29CR1eg>
    <xmx:9FjUZgD27kTBIpHJeV9DJMCaeEnowZsbAjJ03nnb7U7iAa2oL57aAxQI>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Sep 2024 08:07:14 -0400 (EDT)
Message-ID: <e58a3506-3b61-4449-9877-de9440b7e379@fastmail.fm>
Date: Sun, 1 Sep 2024 14:07:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 15/19] export __wake_on_current_cpu
To: Peter Zijlstra <peterz@infradead.org>, Bernd Schubert <bschubert@ddn.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Andrei Vagin <avagin@google.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-15-d149476b1d65@ddn.com>
 <20240530203729.GG2210558@perftesting>
 <20240604092635.GN26599@noisy.programming.kicks-ass.net>
 <f1989554-35f2-4f42-af98-69521f620143@ddn.com>
 <20240604192752.GQ40213@noisy.programming.kicks-ass.net>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240604192752.GQ40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 21:27, Peter Zijlstra wrote:
> On Tue, Jun 04, 2024 at 09:36:08AM +0000, Bernd Schubert wrote:
>> On 6/4/24 11:26, Peter Zijlstra wrote:
>>> On Thu, May 30, 2024 at 04:37:29PM -0400, Josef Bacik wrote:
>>>> On Wed, May 29, 2024 at 08:00:50PM +0200, Bernd Schubert wrote:
>>>>> This is needed by fuse-over-io-uring to wake up the waiting
>>>>> application thread on the core it was submitted from.
>>>>> Avoiding core switching is actually a major factor for
>>>>> fuse performance improvements of fuse-over-io-uring.
>>>>>
>>>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Cc: Andrei Vagin <avagin@google.com>
>>>>
>>>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>>>>
>>>> Probably best to submit this as a one-off so the sched guys can take it and it's
>>>> not in the middle of a fuse patchset they may be ignoring.  Thanks,
>>>
>>> On its own its going to not be applied. Never merge an EXPORT without a
>>> user.
>>>
>>> As is, I don't have enough of the series to even see the user, so yeah,
>>> not happy :/
>>>
>>> And as hch said, this very much needs to be a GPL export.
>>
>> Sorry, accidentally done without the _GPL. What is the right way to get this merged? 
>> First merge the entire fuse-io-uring series and then add on this? I already have these 
>> optimization patches at the end of the series... The user for this is in the next patch
> 
> Yeah, but you didn't send me the next patch, did you? So I have no
> clue.. :-)
> 
> Anyway, if you could add a wee comment to __wake_up_con_current_cpu()
> along with the EXPORT_SYMBOL_GPL() that might be nice. I suppose you can
> copy paste from __wake_up() and then edit a wee bit.
> 
>> [PATCH RFC v2 16/19] fuse: {uring} Wake requests on the the current cpu
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index c7fd3849a105..851c5fa99946 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -333,7 +333,10 @@ void fuse_request_end(struct fuse_req *req)
>>                 spin_unlock(&fc->bg_lock);
>>         } else {
>>                 /* Wake up waiter sleeping in request_wait_answer() */
>> -               wake_up(&req->waitq);
>> +               if (fuse_per_core_queue(fc))
>> +                       __wake_up_on_current_cpu(&req->waitq, TASK_NORMAL, NULL);
>> +               else
>> +                       wake_up(&req->waitq);
>>         }
>>
>>         if (test_bit(FR_ASYNC, &req->flags))
> 
> Fair enough, although do we want a helper like wake_up() -- something
> like wake_up_on_current_cpu() ?

Thank you and yes sure!
I remove the patch and optimization from RFCv3, we first need to agree
on the taken approach and get that merged. Will send submit this
optimization immediately after.


Thanks,
Bernd

