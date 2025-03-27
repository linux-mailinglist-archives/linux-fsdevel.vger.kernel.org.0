Return-Path: <linux-fsdevel+bounces-45141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A8AA7350B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 15:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB8B172A5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA3C218851;
	Thu, 27 Mar 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="Sy3JHFfr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KueJ0GjR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D25C603;
	Thu, 27 Mar 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087326; cv=none; b=KwN/0+w+SpOBzkzNmsdO0pKfI+NBbcONINx/StYbSnJdB3nsCneeX82xA81Ep2DJY+/BgbFKOvr2iuYB6h866cU6FVl3PrJYHZ8eRpQOyD1MIbFKKujl3nduPrzobuUQqZH6rhQm9sswSgbkqsEcVdzGxymaefB+g5mto8TiZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087326; c=relaxed/simple;
	bh=N8uQKQWunTMpvDqhaPC/RN2tSlaGzF2l9fFeSi2g9Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZJMT3u4qVdkj2Elnl+8AFVi4XAMvZFo3XB8CBT6/Z0WRPWSjAGieq67dbxSqWIzP7WjNqf7cMm1D5OEQ2HKaE4iRju8U85Zm09E1gv8dVqwz5x3411dpSh3fLyhEo5DGd8AehUpRFZhK3Rp3/qL3r56X/zdNVhoc+MK+DWjBq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=Sy3JHFfr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KueJ0GjR; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B987B1140206;
	Thu, 27 Mar 2025 10:55:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 27 Mar 2025 10:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743087323;
	 x=1743173723; bh=Uzqqjlk9/VUq8a8twIiFfTROmd/Z39GQ9mWXAznziTg=; b=
	Sy3JHFfrhy5gUCtGAK2QbKNxxKzF5iQW+HuIKGwWI4bSDv12CzmdjIehbebd5F6K
	gyqPP7oDyRtVnW4dq1GecySpzGGh8a5Hy+eH3EG0DDnD70LMC/7DQwpGAWi5pxDE
	Wo2uiHnV+c4wl2+gLr6m27lFmtMzp032AUZNSh+v9AkeUH0DlQWeulCu2hF0JXPd
	sCoTxGVQ3gYqMSZgWqI9g/MYKw2R7nKzhENwj+CloDyHCZZd1LbL5trt7W0v36TI
	sq2l3MSxMKRs1kANg0ozZQn1ytrclhsZPz0rBNRujWXaHunxODtlzZdhoohBdxt1
	FUJ3EnfzIXGIv+uyVIuI4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743087323; x=
	1743173723; bh=Uzqqjlk9/VUq8a8twIiFfTROmd/Z39GQ9mWXAznziTg=; b=K
	ueJ0GjR7/QrQsTI78oQr29RSJPGKvfVs4a94NT/NcMEOM3wYrftBWwPD0k1Aln+D
	a4AXH6QQ/+jlmEVl8ugGocIcU/YLx2wGtcCHIrsYrP29okPiAF/dE8VNcxTkUzQ6
	qThg2kG8JLrBDvlhwwbtl10E4yDR7T2RcCMvKD7Sm1QmtVPKbjA8bDHZKr1gkYcs
	YcSEJpJyX8ia1v/M7zTknmddeIj7+VcqD4qpRIbI/THdxXLoIo4cN5RyUIJrq0yb
	iO4ZCzPwPSelFzWVHsMFARu7CFpR7PKjGwwTN1E0cxyObET48Eci0XRSgjr8J2RR
	SJZzQM/0oyydVUFZ6Ps4w==
X-ME-Sender: <xms:22blZ-wQWkdrJ7LLu9I2Il0vMw1hvqhiNSfBjt1ts-a_qLS4XNN2ow>
    <xme:22blZ6RYE9anuKNceh6dGOBFDx7ws91H3O_AjGWL5SUAG7VKY87Q5xeXBBpsdHIru
    DEUNkuDUGYw7wXvaUE>
X-ME-Received: <xmr:22blZwVucG6H3fP673JJZ7-JtnBoQxTyvfVOxRvU-vrajZwjgUWqjdZlP16w0aI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnug
    gvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpedtuddvudetueegkeeitdefgfetveev
    geektdetvdehtdeiueeivedvtddtffelveenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgr
    nhguvggvnhesshgrnhguvggvnhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohep
    jhgrmhgvshdrsghothhtohhmlhgvhieshhgrnhhsvghnphgrrhhtnhgvrhhshhhiphdrtg
    homhdprhgtphhtthhopehhtghhsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlshhfqdhptgeslhhishhtshdrlhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprg
    hvvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghnrdgsrhhofihnsehinhht
    vghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:22blZ0jCNhBbDfoksLmMi2aw6knXqrutsMv7ymj8j6jliPdSmNJWug>
    <xmx:22blZwAtgeBaYiAd0xIIhIr6zwTIuuQR_YRKsefgiqW2OsWi7ofsKw>
    <xmx:22blZ1LFVKIIDgRqHq-jVsLJPm1U-eXd1a050Iiulhar5Oj_01AAng>
    <xmx:22blZ3BBlb1L21KuWMCe6q9ekZ7n8NrziUVCz0fUH2a-_JLvIM2mgA>
    <xmx:22blZwsFIbGdv-E9fegOAFrUY6bsUJmlcxQ8Nr4TFWgBDtd7vcE4BCBc>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 10:55:22 -0400 (EDT)
Message-ID: <3b5d42a0-933a-457b-aca9-3eaf7c7f947f@sandeen.net>
Date: Thu, 27 Mar 2025 09:55:21 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
To: Jan Kara <jack@suse.cz>,
 James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 lsf-pc@lists.linux-foundation.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
 <Z9xG2l8lm7ha3Pf2@infradead.org>
 <acae7a99f8acb0ebf408bb6fc82ab53fb687559c.camel@HansenPartnership.com>
 <Z9z32X7k_eVLrYjR@infradead.org>
 <576418420308d2511a4c155cc57cf0b1420c273b.camel@HansenPartnership.com>
 <62bfd49bc06a58e435431610256e722651e1e5ca.camel@HansenPartnership.com>
 <vnb6flqo3hhijz4kb3yio5rxzaugvaxharocvtf4j4s5o5xynm@nbccfx5xqvnk>
 <9f5bea0af3e32de0e338481d6438676d99f40be7.camel@HansenPartnership.com>
 <jlnc33bmqefx3273msuzq3yyei7la2ttwzqyyavohzm2k66sl6@gtqq6jpueipz>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <jlnc33bmqefx3273msuzq3yyei7la2ttwzqyyavohzm2k66sl6@gtqq6jpueipz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/24/25 2:28 PM, Jan Kara wrote:
> On Mon 24-03-25 10:34:56, James Bottomley wrote:
>> On Mon, 2025-03-24 at 12:38 +0100, Jan Kara wrote:
>>> On Fri 21-03-25 13:00:24, James Bottomley via Lsf-pc wrote:
>>>> On Fri, 2025-03-21 at 08:34 -0400, James Bottomley wrote:
>>>> [...]
>>>>> Let me digest all that and see if we have more hope this time
>>>>> around.
>>>>
>>>> OK, I think I've gone over it all.  The biggest problem with
>>>> resurrecting the patch was bugs in ext3, which isn't a problem now.
>>>> Most of the suspend system has been rearchitected to separate
>>>> suspending user space processes from kernel ones.  The sync it
>>>> currently does occurs before even user processes are frozen.  I
>>>> think
>>>> (as most of the original proposals did) that we just do freeze all
>>>> supers (using the reverse list) after user processes are frozen but
>>>> just before kernel threads are (this shouldn't perturb the image
>>>> allocation in hibernate, which was another source of bugs in xfs).
>>>
>>> So as far as my memory serves the fundamental problem with this
>>> approach was FUSE - once userspace is frozen, you cannot write to
>>> FUSE filesystems so filesystem freezing of FUSE would block if
>>> userspace is already suspended. You may even have a setup like:
>>>
>>> bdev <- fs <- FUSE filesystem <- loopback file <- loop device <-
>>> another fs
>>>
>>> So you really have to be careful to freeze this stack without causing
>>> deadlocks.
>>
>> Ah, so that explains why the sys_sync() sits in suspend resume *before*
>> freezing userspace ... that always appeared odd to me.
>>
>>>  So you need to be freezing userspace after filesystems are
>>> frozen but then you have to deal with the fact that parts of your
>>> userspace will be blocked in the kernel (trying to do some write)
>>> waiting for the filesystem to thaw. But it might be tractable these
>>> days since I have a vague recollection that system suspend is now
>>> able to gracefully handle even tasks in uninterruptible sleep.
>>
>> There is another thing I thought about: we don't actually have to
>> freeze across the sleep.  It might be possible simply to invoke
>> freeze/thaw where sys_sync() is now done to get a better on stable
>> storage image?  That should have fewer deadlock issues.
> 
> Well, there's not going to be a huge difference between doing sync(2) and
> doing freeze+thaw for each filesystem. After you thaw the filesystem
> drivers usually mark that the fs is in inconsistent state and that triggers
> journal replay / fsck on next mount.

For XFS, IIRC we only do that (mark the log dirty) so that we will process
orphan inodes if we crash while frozen, which today happens only during log
replay. I tried to remove that behavior long ago but didn't get very far.
(Since then maybe we have grown other reasons to mark dirty, not sure.)

https://lore.kernel.org/linux-xfs/83696ce6-4054-0e77-b4b8-e82a1a9fbbc3@redhat.com/

Does ext4 mark it dirty too? I actually thought it left a clean journal when
freezing.

Thanks,
-Eric
 
> 								Honza


