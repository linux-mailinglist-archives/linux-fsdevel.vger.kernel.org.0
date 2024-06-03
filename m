Return-Path: <linux-fsdevel+bounces-20850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB6E8D8617
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 17:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3521A1F22ABE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE11304BA;
	Mon,  3 Jun 2024 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="FIWJPd3l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fkjra8FF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB821EF1A;
	Mon,  3 Jun 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428763; cv=none; b=qQzPtGKLDyFd7gkkT29Y2JQabTRNMLTCuaLwCGmQA+K8nCXdkaJmK7UkctstLcSLOvhQZW4EuXiSN5fLbmWZKmcYXp1jRKba9exy+vzf2DnqgdhcHifZbD5/1j1o+EY8+87aPEqTaKmFqgAmxZ0SjoAxrLeNTLKl9z2J60Cd7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428763; c=relaxed/simple;
	bh=1PB5TAZWxS/S7OzA5Yx0jsbtLvaHqz8kwPOK5A57Bhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fn6jaFzS2MB7V5AZLaagsjBcG6yeL8tlk5Pyu03I8ZcSSiFm6I6a9FKQYOKa7+eENy/5nPmtwYRrIG33L+Eet7jsLpWMRo2ZiyfgNskEo5O8KTYXwuXloH3WIso85o2NYhEYa9PlSay6NDGyJAWJEdtCyTqWLBbN3ZE0767uqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=FIWJPd3l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fkjra8FF; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 24A7313800D4;
	Mon,  3 Jun 2024 11:32:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 11:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717428761;
	 x=1717515161; bh=/TZQ0dkrHtiebumwKyexBxCJNAE82zu8Fq9CXg3TirY=; b=
	FIWJPd3lO3IbyjBq1T358WBBsg49l+qrtihAccUkUtpax0B7TZ4IAzu4Dk15YUz9
	oR2aPD6QsxACU42UmQscdjfNSDz1cz9Ly7retRalj2xIvLe7WRWn4Kk9o0OF0Nvm
	yXwgMSr9xucrlS/I/4hpWg1imjc+82EUGBD4iK2zb0IeavRlbai42hb+w12Rfyao
	iYdhvsOKrPl2MWiKKRbTnUsdd6wmeiK46e43qsHeDbGaCh5MXqcyn3BTrZNjzB+Y
	DEHvGxd/dbUeVkPGLOJ2fNQuQesAZvvjG+FN7JQGr10a0/jYj5EUEs+kBP2jMd1n
	PbtvhxIMTwFQ/SGigXzvkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717428761; x=
	1717515161; bh=/TZQ0dkrHtiebumwKyexBxCJNAE82zu8Fq9CXg3TirY=; b=F
	kjra8FF/JcxV4aWFINBDv2Pq4p5vGBJJY33XUzsNYl+j9qD9kPxyA+wTrJLQECNR
	JyaTjCSJlR94KrUd0iIWasMJYShV84rtGbvsmLVUILQonZ2KAVtb0okptQA13Rvr
	dlfDcIZdbVtJ9xNM5ONIpQE3A2A106T/PBQHy+wpxvjquQpIgefV/nCyLBAOmedO
	6j5SR4iuSsu7yTu5Zs49HplwyZM+nGadWA3HmQwP1LFpeqHt0JygecTZ6/qFJbgv
	1SttApnG3/CwmA7e4T/Z/09wPjGFaIdMOmz+/Gg2dHaxMFu7FDKsLGkA4gVmCVWK
	i0ch8Rv+IZaWtvXF8wnog==
X-ME-Sender: <xms:GOJdZi-zgAIbVI8HbgqXUYxVcIq0WgKA_tp0JYh6in9nROiCg4mG4g>
    <xme:GOJdZiuhEutFf4a-h3CQ33fGF3ydYeO9P4PMDOKvNmikA7hQmhjDO0i4mCA_C3OEB
    RKQRfoLzdZJ_0Rt>
X-ME-Received: <xmr:GOJdZoCZv6hLDd7qMjpmff7CQn4PHUO_TZUIw4UQBRCGn_lLFJHMFwAgwGyfpl84BQ7WGYxYCm5iN0wNHvhM_nJ288sqDk1W7ifBsQ5QgQXM6JJkjc6_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:GOJdZqfHYMTjCH-XhXTRY_qFG5KL0x5zn6LmyADj-Bw3p1SUcyIopg>
    <xmx:GOJdZnPQzKwEnOZi1QB9f-7RQ444p4Mkve4kS4iBd5mEpbVsifYflA>
    <xmx:GOJdZkmvZvuOeK4yWRqQzua1rywEBJehYJVRNuIxswhEvIOQE3iP0Q>
    <xmx:GOJdZpvJHaSMbo_F2xXJZ0YRpF1K-U2VIpAxE2shbThOhnGAArnpYw>
    <xmx:GeJdZi1Y3Wa6YulPVs5fs1H6zO1wnOwy7FCS95LL5CAKj2Dx-UEvIirL>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 11:32:39 -0400 (EDT)
Message-ID: <233a9fdf-13ea-488b-a593-5566fc9f5d92@fastmail.fm>
Date: Mon, 3 Jun 2024 17:32:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 lege.wang@jaguarmicro.com
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/24 17:19, Miklos Szeredi wrote:
> On Mon, 3 Jun 2024 at 16:43, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 6/3/24 08:17, Jingbo Xu wrote:
>>> Hi, Miklos,
>>>
>>> We spotted a performance bottleneck for FUSE writeback in which the
>>> writeback kworker has consumed nearly 100% CPU, among which 40% CPU is
>>> used for copy_page().
>>>
>>> fuse_writepages_fill
>>>   alloc tmp_page
>>>   copy_highpage
>>>
>>> This is because of FUSE writeback design (see commit 3be5a52b30aa
>>> ("fuse: support writable mmap")), which newly allocates a temp page for
>>> each dirty page to be written back, copy content of dirty page to temp
>>> page, and then write back the temp page instead.  This special design is
>>> intentional to avoid potential deadlocked due to buggy or even malicious
>>> fuse user daemon.
>>
>> I also noticed that and I admin that I don't understand it yet. The commit says
>>
>> <quote>
>>     The basic problem is that there can be no guarantee about the time in which
>>     the userspace filesystem will complete a write.  It may be buggy or even
>>     malicious, and fail to complete WRITE requests.  We don't want unrelated parts
>>     of the system to grind to a halt in such cases.
>> </quote>
>>
>>
>> Timing - NFS/cifs/etc have the same issue? Even a local file system has no guarantees
>> how fast storage is?
> 
> I don't have the details but it boils down to the fact that the
> allocation context provided by GFP_NOFS (PF_MEMALLOC_NOFS) cannot be
> used by the unprivileged userspace server (and even if it could,
> there's no guarantee, that it would).
> 
> When this mechanism was introduced, the deadlock was a real
> possibility.  I'm not sure that it can still happen, but proving that
> it cannot might be difficult.

Thanks Miklos!
I need to go through all of the GFP_NOFS allocation, but I wonder if we
could introduce cached allocations and fall back to the slow path if
that didn't work.


Thanks,
Bernd

