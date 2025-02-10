Return-Path: <linux-fsdevel+bounces-41412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8109DA2F151
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 16:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16D23A819F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736C2206AB;
	Mon, 10 Feb 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="ZvP4+NX9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c2o8fP2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C504C2528E1;
	Mon, 10 Feb 2025 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200719; cv=none; b=sen9wh6zlOdpyEVg34cucyKmDb3Hm3xlZyUCQh8UnM68jNvWN8+0aCfozwgSpfJsxDh27LHqMmHBKQ0KbKC6H6NmMbWI0NADZ8MlIU1pM99Rvrhluh/F0UhEMzqVtX+M+qqvm+OUKLFKh719b2Bki4cDVmeZF6lDUX1exIwwaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200719; c=relaxed/simple;
	bh=HQXa2XZpLkFsDl+MGL2N9ezPt2El0y7jK/+k0k9ydJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTCk6uzZIK6m5rqbOrrAhZWbPOTill/2h5F3iL25afnJH7HQ3qJy6luKrJsfKFuldhwnrTJQj4nmEnP5/hBLcPt3z2AG+m59wTxI0bontAr5PpjK6tUfJGefft1VgD/g/LvoIfFsEl//T54R73nFsLeLNm79uA4F0P1AA1iMgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=ZvP4+NX9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c2o8fP2V; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 923AB11400A1;
	Mon, 10 Feb 2025 10:18:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 10 Feb 2025 10:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739200714;
	 x=1739287114; bh=l2o7Ctl/b1mebUuS5v7a27TgU4ZziO9MD5ZdLF//IwQ=; b=
	ZvP4+NX9BZ71Pu1Tlh20l3SfUghq6zl/vx+CCbZ+ymwIzQb7olhr+/OxlwiKZBP6
	yOYanjdOiiNGTPuCVAdsLwz+fgxe2faZ9h5KkpYM5cqdrJw9bh1un6ZfTcmGPNkO
	TYB/gkYwIAlq+ybI83z3CLoBMMmfFk1IXSIIi1la4ydTNCWNGN4K3pnnysQRgS4m
	SSKJQCWTVAZnCUogC5bv3gZfYnffeUWwjKhfpAc5zjDiu5xhNGtjQ+85fvVquG1R
	kxuYgmqxKI64kObeVMB4sti/jsNyya0GTOwF/3gm/ZMJ+lzlRjQfHy2aEcxiuuaN
	JVDHoC4gV0RCmUICHziOFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739200714; x=
	1739287114; bh=l2o7Ctl/b1mebUuS5v7a27TgU4ZziO9MD5ZdLF//IwQ=; b=c
	2o8fP2VKkOVeJLvycq/uJNUGFjb7inbe1S6+rEE/w5D6Hj1osxK6rqhVLa4B4YlX
	aXX2ps40Fk+1aus+LbG9TCTAPSXYZIp5ak7BHhbBp+0M5aEGSOVtdpZ8sKZWlsKw
	GQN4tId/1cxBMpt6mCngMgrgwJ1X2JhvFn7IFegWsVRQyswN1j2+nfFf0lyavBy7
	jKT09hnQY0LW3/sfpy9K2G+C2tDqMMqrIZUAX62qv91AwQtnV8O/0a0ejy0yuRJg
	m1h0rfYFDKewSNsVbInuZ2MO+4Nvz5YjT216UX4I4z/plus3cnSDxtDT7DKnVWbG
	EPRKZsqF22+IhhWiV+a+Q==
X-ME-Sender: <xms:yRiqZ8VW9OfQDbvMGKE7lX6GNNmGDKR5KWv6wfrsmB6yFLiPbTTS2g>
    <xme:yRiqZwkMkGS62Dj7PN6_OvDmDJJSYVb11H0MrIe8IqU7cBR4b9uioghUbQMQ78tRQ
    8SFse3hHJM0jn3d>
X-ME-Received: <xmr:yRiqZwaO0RlJU3QwdylFQV2XdC9MU_MIagDDY0meeylYHPB-ME70eIGZ5mwi1InJ6eE_X64LihrvtouJQPvSXrZqejOiaUSPyX9SwWmATktcNmkXUia_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghssggvrh
    hnugdrtghomheqnecuggftrfgrthhtvghrnhepjefgleejueffhefhueekvdduhfetteeh
    tdehfeejhfevudethefhtdetvdekkeevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghr
    nhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehluhhishesihhgrghlihgrrdgtohhmpdhrtghpthhtohep
    sghstghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivg
    hrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yRiqZ7VIPqqJ5WGAzmV1tocJWpadgUEJicjBc0VcgZq7WfebAAvEBw>
    <xmx:yRiqZ2lX96rQyBUGCqPnQt4S_p60_hGiXyes0WHgwYv9EofCSgH6vg>
    <xmx:yRiqZwcqiyfMng4kq46HVYUcdeRt-iwVeCpA-IydLAdSkKJhTUCupw>
    <xmx:yRiqZ4HAFCEUJlv8k4WZSEp0K9KwhjwSR0Lgg2MdK2EA2GgqMpAQ1g>
    <xmx:yhiqZ9trLqp3pMIYIsUXAq5R8svZB1emeK39A9kxOqfYBKDv4rO18lnX>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 10:18:32 -0500 (EST)
Message-ID: <400ffcf9-9b98-4e94-81eb-3e33177ba334@bsbernd.com>
Date: Mon, 10 Feb 2025 16:18:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] fuse: add new function to invalidate cache for all
 inodes
To: Luis Henriques <luis@igalia.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250210094840.5627-1-luis@igalia.com>
 <b5db41a7-1b26-4d12-b99f-c630f3054585@ddn.com> <87pljqyt10.fsf@igalia.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <87pljqyt10.fsf@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/10/25 11:48, Luis Henriques wrote:
> [re-sending -- for some reason I did a simple 'reply', not a 'reply-all'.]
> 
> On Mon, Feb 10 2025, Bernd Schubert wrote:
> 
>> On 2/10/25 10:48, Luis Henriques wrote:
>>> Currently userspace is able to notify the kernel to invalidate the cache for
>>> an inode.  This means that, if all the inodes in a filesystem need to be
>>> invalidated, then userspace needs to iterate through all of them and do this
>>> kernel notification separately.
>>>
>>> This patch adds a new option that allows userspace to invalidate all the
>>> inodes with a single notification operation.  In addition to invalidate all
>>> the inodes, it also shrinks the sb dcache.
>>>
>>> Signed-off-by: Luis Henriques <luis@igalia.com>
>>> ---
>>> Hi!
>>>
>>> As suggested by Bernd, this patch v2 simply adds an helper function that
>>> will make it easier to replace most of it's code by a call to function
>>> super_iter_inodes() when Dave Chinner's patch[1] eventually gets merged.
>>>
>>> [1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.com
>>>
>>>  fs/fuse/inode.c           | 59 +++++++++++++++++++++++++++++++++++++++
>>>  include/uapi/linux/fuse.h |  3 ++
>>>  2 files changed, 62 insertions(+)
>>>
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index e9db2cb8c150..be51b53006d8 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -547,6 +547,62 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
>>>  	return NULL;
>>>  }
>>>  
>>> +static void inval_single_inode(struct inode *inode, struct fuse_conn *fc)
>>> +{
>>> +	struct fuse_inode *fi;
>>> +
>>> +	fi = get_fuse_inode(inode);
>>> +	spin_lock(&fi->lock);
>>> +	fi->attr_version = atomic64_inc_return(&fc->attr_version);
>>> +	spin_unlock(&fi->lock);
>>> +	fuse_invalidate_attr(inode);
>>> +	forget_all_cached_acls(inode);
>>
>>
>> Thank you, much easier to read.
>>
>> Could fuse_reverse_inval_inode() call into this?
> 
> Yep, it could indeed.  I'll do that in the next iteration, thanks!
> 
>> What are the semantics 
>> for  invalidate_inode_pages2_range() in this case? Totally invalidate?
>> No page cache invalidation at all as right now? If so, why?
> 
> So, if I change fuse_reverse_inval_inode() to use this help, it will still
> need to keep the call to invalidate_inode_pages2_range().  But in the new
> function fuse_reverse_inval_all(), I'm not doing it explicitly.  Instead,
> that function calls into shrink_dcache_sb().  I *think* that by doing so
> the invalidation will eventually happen.  Or am I wrong assuming that?

I think it will drop it, if the dentry cache is the last user/reference
of the inode. My issue is that it changes semantics a bit - without
FUSE_INVAL_ALL_INODES the page cache is invalidated based on the given
offset. Obviously we cannot give the offset for all inodes, but we
at least document the different semantics in a comment above
FUSE_INVAL_ALL_INODES? Sorry, should have asked earlier for it, just
busy with multiple things in parallel...


Thanks,
Bernd

