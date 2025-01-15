Return-Path: <linux-fsdevel+bounces-39318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC98A12AB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 19:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B257A2D71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 18:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14AA1D5146;
	Wed, 15 Jan 2025 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="OrdLejU6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s+FUP+w8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891424A7D5;
	Wed, 15 Jan 2025 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965061; cv=none; b=A7/Q0U6S07mVM0CZU5oayiaHbPrXS5ZmxHNJU6Nt/eg2Ako2esxhBGzfx3zXJdj0nPrQI5yrcmUP160GV0fOY53EKg0rfTzhTdlaQbAsod35B8JhoQSAxhjNMTRs5CjJFy3hf6NnkOuPb892rIbyYkAJd9D1rhng06gtv5/Y0j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965061; c=relaxed/simple;
	bh=i+8X0AyxnIN5+DkwsutelQ0BBvo9WwAuhTnZQ1g8Q5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iayw91UJkgVv4yDDfDmWU8A9ZrdBGUGR5Br03jY1lRjvZA/xyijxYOGxKsVZfln+mJsWUsfMuy5Mi2FIUDZBwrP8He813EAbvg0Iav+a3yY2MQM+DRNfHNTu3kGYgcu5q0wG9sdp1T5IkuGrHsr0PyaFpNxzxA0bBHG8g+aVces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=OrdLejU6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s+FUP+w8; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3FD3A25401B3;
	Wed, 15 Jan 2025 13:17:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jan 2025 13:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736965057;
	 x=1737051457; bh=2FsnBPd7qdIl5YeTqql0QnhSXuY9QHBbETVFoHyBHi4=; b=
	OrdLejU665oEeYTdsLiZve8ZXfU9NAjidcsG31gPwJkOJiDS/tGzy0+mTPHwHL5z
	OOipyK36JJNkDSG8ZtjR4PxZbG9gehv8kTNmbWERURGixwdbo+SPyMFfCxVzcNUR
	ei0U+1wPvvM/vKOic0bbL4jY3BQt28CLWiNzQagLBX8uE/9gyYgQJf0upAiPpjdA
	PYKMx8fvKTXPmk+7b+qhookF7xYwAy+YKYmEeqPd9TfKBcSpiBaIWmlp1UypGpeM
	279pTq5gDmBRtR4zU0jHCidcvPoLuIgNq3EYLxn2guZStermkRfrY8DDq/5Nshtx
	MmjOi/jlPfeByuCmysyAKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736965057; x=
	1737051457; bh=2FsnBPd7qdIl5YeTqql0QnhSXuY9QHBbETVFoHyBHi4=; b=s
	+FUP+w8XoeLn/fc8LJs0DORHsu9amBqIHLHIRLEMW/4mIxShMNOLjG8mgS1ecfwE
	RUKvrQMw443g+6IZSBQQIOn3M8GY8pq9VUXCWsxyUP1fYtb+nuK7BqDnBn7pPXuJ
	xdXEtXDxSBup65XBH8TzDPEQQglNA2zBMnqSA2ktguGbD8ql0+KhUuMaWUsHVcwk
	p4UC+3Jj3ktGvmOwenQzjOgPQFv/QJGEXFENOl40O79BybgMzp5OHMApRrM411bn
	JIsO38GuNw+CdjRV0vf92NMzLhoONOtl17OrcN10laKVGoAUF3+e2vgI75cruow5
	k3bn8a+ij5c51ObGG2MMg==
X-ME-Sender: <xms:wPuHZ_JLdWocYX0WdDigf0HplbkOI-tQyvrMN6fyG2-m1zpsa0n12Q>
    <xme:wPuHZzLeOt0Rgzm0LPfi7c36szYzOg3l0Ac9bUBU7FxOhPxo-RGeFaTI6uie94MoI
    K9vw5eh0PAR0kog>
X-ME-Received: <xmr:wPuHZ3vfKT8MXQLI7TwR97XPZaQkq5hz3qncjg-YWSqEKrIBYhpHcqHPHauOvECDoRjtysLzzcllN6BZ5jtT0FbAgQ7fEaDQgvSHSIWLIEH4aacls37L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnh
    gurdgtohhmqeenucggtffrrghtthgvrhhnpeejgfeljeeuffehhfeukedvudfhteethedt
    heefjefhveduteehhfdttedvkeekveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheplhhuihhssehighgrlhhirgdrtghomhdprhgtphhtthhopehm
    ihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhhgrrhhvvgihse
    hjuhhmphhtrhgrughinhhgrdgtohhm
X-ME-Proxy: <xmx:wPuHZ4YV5Hcf1mdljxvAw9qEvcmlV6YxO5zS8WET4o9NLkFcrFegqA>
    <xmx:wPuHZ2ZSPz9DF0LkMnj6f7-w48zrn1SWbOvu0FcLYnirys0HkRLgUA>
    <xmx:wPuHZ8BV7LzcHRQolJiS2lLTEW1gEPvx9zIJaGuinKqbL049b8WPog>
    <xmx:wPuHZ0aUSMVP6i6d3yn0uK5dO6xr56-q4xB0kfex3YWgumqRU_RnRA>
    <xmx:wfuHZ9xvDEPvBMB3gzexQ1IIWgHwQaeCXJMZQKtgfqQUw894cgKf-Y7o>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 13:17:35 -0500 (EST)
Message-ID: <71aaa745-59a2-4627-9de2-c3359710d7b2@bsbernd.com>
Date: Wed, 15 Jan 2025 19:17:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fuse: add new function to invalidate cache for all
 inodes
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>
References: <20250115163253.8402-1-luis@igalia.com>
 <9e876952-4603-4bf4-a3a0-9369d99d74c6@bsbernd.com>
 <87h660lzm3.fsf@igalia.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <87h660lzm3.fsf@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/25 19:07, Luis Henriques wrote:
> Hi Bernd,
> 
> On Wed, Jan 15 2025, Bernd Schubert wrote:
> 
>> On 1/15/25 17:32, Luis Henriques wrote:
>>> Currently userspace is able to notify the kernel to invalidate the cache
>>> for an inode.  This means that, if all the inodes in a filesystem need to
>>> be invalidated, then userspace needs to iterate through all of them and do
>>> this kernel notification separately.
>>>
>>> This patch adds a new option that allows userspace to invalidate all the
>>> inodes with a single notification operation.  In addition to invalidate all
>>> the inodes, it also shrinks the superblock dcache.
>>
>> Out of interest, what is the use case?
> 
> This is for a read-only filesystem.  However, the filesystem objects
> (files, directories, ...) may change dramatically in an atomic way, so
> that a totally different set of objects replaces the old one.
> 
> Obviously, this patch would help with the process of getting rid of the
> old generation of the filesystem.
> 
>>>
>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>>> ---
>>> Just an additional note that this patch could eventually be simplified if
>>> Dave Chinner patch to iterate through the superblock inodes[1] is merged.
>>>
>>> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.com
>>>
>>>  fs/fuse/inode.c           | 53 +++++++++++++++++++++++++++++++++++++++
>>>  include/uapi/linux/fuse.h |  3 +++
>>>  2 files changed, 56 insertions(+)
>>>
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index 3ce4f4e81d09..1fd9a5f303da 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -546,6 +546,56 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
>>>  	return NULL;
>>>  }
>>>  
>>> +static int fuse_reverse_inval_all(struct fuse_conn *fc)
>>> +{
>>> +	struct fuse_mount *fm;
>>> +	struct super_block *sb;
>>> +	struct inode *inode, *old_inode = NULL;
>>> +	struct fuse_inode *fi;
>>> +
>>> +	inode = fuse_ilookup(fc, FUSE_ROOT_ID, NULL);
>>> +	if (!inode)
>>> +		return -ENOENT;
>>> +
>>> +	fm = get_fuse_mount(inode);
>>> +	iput(inode);
>>> +	if (!fm)
>>> +		return -ENOENT;
>>> +	sb = fm->sb;
>>> +
>>> +	spin_lock(&sb->s_inode_list_lock);
>>> +	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>>
>> Maybe list_for_each_entry_safe() and then you can iput(inode) before the
>> next iteration?
> 
> I can rework this loop, but are you sure it's safe to use that?  (Genuine
> question!)
> 
> I could only find two places where list_for_each_entry_safe() is being
> used to walk through the sb inodes.  And they both use an auxiliary list
> that holds the inodes to be processed later.  All other places use the
> pattern I'm following here.
> 
> Or did I misunderstood your suggestion?


Actually my mistake, yeah you cannot use list_for_each_entry_safe() 
because you are giving up the list lock and the next entry, which
is already obtained by _safe might not be valid anymore.

Sorry for the noise!


Thanks,
Bernd

