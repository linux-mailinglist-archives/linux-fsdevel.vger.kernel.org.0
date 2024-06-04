Return-Path: <linux-fsdevel+bounces-20991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 904798FBE23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 23:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E517BB2623C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 21:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C450814BFA2;
	Tue,  4 Jun 2024 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="1czc91/q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jSLz8vEy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099B684E1C;
	Tue,  4 Jun 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537164; cv=none; b=ldGI2yyr/IN60MkF+Hcq2tV6EZRpGJyuccGgMIjM673mT0xGIRDcuF36TZh1y+ok6hCV8mwsfgw7xyMTVh0vHjEPxVUBEdJKWmO869J9ASU476GKcORYAoNpc2H9k972lH6fdNyLt11/t+7v2ih7M5OSUQTYw0kfBeo3Z3u7QZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537164; c=relaxed/simple;
	bh=2z3DZC6/6RzpWdBjI/R1JC8aI3Hms3Oaa43Avm5Rh9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j25ibskUTGeeNHxLlpgXgEv7ksoe7fWZTXVH1cfOKsIhYi0zuh6Cq5SzoxI4pVLPK+EIz4y9FVPbbh3eRI8IhdkeJjJFw1OSTBRd4zNcrFcrPb3oaKuqAIZW+HN3S2e5yHDhJ3wvmnIXRAPCsoa9CIXdkFRjxQ0Sa/v+Si0MiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=1czc91/q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jSLz8vEy; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id B42161800093;
	Tue,  4 Jun 2024 17:39:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 04 Jun 2024 17:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717537161;
	 x=1717623561; bh=8FTZrhL5Hr7uLOv6uusR/yWGu0GdibkgC7VFGtSazy0=; b=
	1czc91/qSzWR89UNSrj52sQNn9kg4zhZamDdkuTYeroP4MnmaExdx/bWLzo4OUaZ
	A81aNKUMTCJYG92zkOkRXCe6o+zo6g9Rms8L36Wxj3M2VAGEUXefMRDzmTn7WwNQ
	B8Nr+ug5c0zBd0rrREZTi1taLgBQCUlnJ3RlIJna9fx7yvXiEk1tK57r5W7ic0jd
	Cul3EVxyziqfoPryw1ZZC/tb9XNumEvZx3mD0pUzfPjGzaI5NzkxKAYuI5qneRFz
	QSq5kYmKmAd2S9WY3Wp7cBypi5LjPawvkQ5T1x5qh5aBEPfSLW1Z9gHVcA/s2gME
	Ku2eBw8QhUxUVbWmhRXiXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717537161; x=
	1717623561; bh=8FTZrhL5Hr7uLOv6uusR/yWGu0GdibkgC7VFGtSazy0=; b=j
	SLz8vEy1bBe90HbBGaMe8KPR8U9wLeEkfESPwG//70oNTdccdNH2gjhecaJtqwiq
	HKCS/WMj2a18IzWWshiC5v5BhSA//MjUZ+uqTtH6EzjVkxgeydBd/LVZdVkTURx9
	eYWc9PiQLrxAJu1sAbHs/UFNU6Qy+n+s7diC8NeLeDnBE5/snqZsQBeQaNplG5D9
	DJ8yqOp3upO3r0iodSgiXDzkeGXKn7UL0zB/Ip5TZYfUIEEKRX6SoNuQaekqj5zw
	2CYbld4btI3uDQ8GOPzet4Wv2n3OXeGQgTpsKwWr5YOksjMyyIhP0Bg05tnPXDz4
	CmQJ+K1HZT3Mx6USnwshA==
X-ME-Sender: <xms:h4lfZg15iKz7-bhgpHC_4Nglwfu3PcQZUdCtoOEGRgxp1EDJS56aGQ>
    <xme:h4lfZrFUzziHatzcJJmm6fRuSKLCWYvVReR2s-Xp91dZhKnjZhACXr1YnrEe9705Q
    oX6PXZ8kVK6gpHQ>
X-ME-Received: <xmr:h4lfZo5t6v6RwYnlPJtTYQy5Tj0sAND-aRsDD5hqmAXb4qdqpi1GCejzQTHtveHuFxTj1x-AUW-IA7COmJMvzJNAgkKUXsyf7z1QCFo63WuPK_HCKgue>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfh
    hmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveejieef
    veeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:h4lfZp2lCZD7Avjx9v2CDDO_jok68e4uSNnV71-846H2Vrsylav-Rg>
    <xmx:h4lfZjFW5g2hWDNt94xIEMh7-e1WrJhPKoRIZiicKZRHdCPB4pPIKQ>
    <xmx:h4lfZi9VlVBf_rxlxRwc4Zdd73N5f0o6mTloMz3u41fLM01Eo7WiTw>
    <xmx:h4lfZokQDzaGXziTleg08DU6OUy96VcT0BFpjwCtP4tVBxV2twTIIA>
    <xmx:iYlfZpbVZ6rXcB_nkRMldOqQ0kORsK_0Al4g7xNto8aQ0smNcBmAuZ69>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 17:39:18 -0400 (EDT)
Message-ID: <6853a389-031b-4bd6-a300-dea878979d8c@fastmail.fm>
Date: Tue, 4 Jun 2024 23:39:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Josef Bacik <josef@toxicpanda.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jingbo Xu
 <jefflexu@linux.alibaba.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 lege.wang@jaguarmicro.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
 <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com>
 <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
 <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
 <21741978-a604-4054-8af9-793085925c82@fastmail.fm>
 <20240604165319.GG3413@localhost.localdomain>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240604165319.GG3413@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 18:53, Josef Bacik wrote:
> On Tue, Jun 04, 2024 at 04:13:25PM +0200, Bernd Schubert wrote:
>>
>>
>> On 6/4/24 12:02, Miklos Szeredi wrote:
>>> On Tue, 4 Jun 2024 at 11:32, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>>
>>>> Back to the background for the copy, so it copies pages to avoid
>>>> blocking on memory reclaim. With that allocation it in fact increases
>>>> memory pressure even more. Isn't the right solution to mark those pages
>>>> as not reclaimable and to avoid blocking on it? Which is what the tmp
>>>> pages do, just not in beautiful way.
>>>
>>> Copying to the tmp page is the same as marking the pages as
>>> non-reclaimable and non-syncable.
>>>
>>> Conceptually it would be nice to only copy when there's something
>>> actually waiting for writeback on the page.
>>>
>>> Note: normally the WRITE request would be copied to userspace along
>>> with the contents of the pages very soon after starting writeback.
>>> After this the contents of the page no longer matter, and we can just
>>> clear writeback without doing the copy.
>>>
>>> But if the request gets stuck in the input queue before being copied
>>> to userspace, then deadlock can still happen if the server blocks on
>>> direct reclaim and won't continue with processing the queue.   And
>>> sync(2) will also block in that case.>
>>> So we'd somehow need to handle stuck WRITE requests.   I don't see an
>>> easy way to do this "on demand", when something actually starts
>>> waiting on PG_writeback.  Alternatively the page copy could be done
>>> after a timeout, which is ugly, but much easier to implement.
>>
>> I think the timeout method would only work if we have already allocated
>> the pages, under memory pressure page allocation might not work well.
>> But then this still seems to be a workaround, because we don't take any
>> less memory with these copied pages.
>> I'm going to look into mm/ if there isn't a better solution.
> 
> I've thought a bit about this, and I still don't have a good solution, so I'm
> going to throw out my random thoughts and see if it helps us get to a good spot.
> 
> 1. Generally we are moving away from GFP_NOFS/GFP_NOIO to instead use
>    memalloc_*_save/memalloc_*_restore, so instead the process is marked being in
>    these contexts.  We could do something similar for FUSE, tho this gets hairy
>    with things that async off request handling to other threads (which is all of
>    the FUSE file systems we have internally).  We'd need to have some way to
>    apply this to an entire process group, but this could be a workable solution.
> 

I'm not sure how either of of both (GFP_ and memalloc_) would work for
userspace allocations.
Wouldn't we basically need to have a feature to disable memory
allocations for fuse userspace tasks? Hmm, maybe through mem_cgroup.
Although even then, the file system might depend on other kernel
resources (backend file system or block device or even network) that
might do allocations on their own without the knowledge of the fuse server.

> 2. Per-request timeouts.  This is something we're planning on tackling for other
>    reasons, but it could fit nicely here to say "if this fuse fs has a
>    per-request timeout, skip the copy".  That way we at least know we're upper
>    bound on how long we would be "deadlocked".  I don't love this approach
>    because it's still a deadlock until the timeout elapsed, but it's an idea.

Hmm, how do we know "this fuse fs has a per-request timeout"? I don't
think we could trust initialization flags set by userspace.

> 
> 3. Since we're limiting writeout per the BDI, we could just say FUSE is special,
>    only one memory reclaim related writeout at a time.  We flag when we're doing
>    a write via memory reclaim, and then if we try to trigger writeout via memory
>    reclaim again we simply reject it to avoid the deadlock.  This has the
>    downside of making it so non-fuse related things that may be triggering
>    direct reclaim through FUSE means they'll reclaim something else, and if the
>    dirty pages from FUSE are the ones causing the problem we could spin a bunch
>    evicting pages that we don't care about and thrashing a bit.


Isn't that what we have right now? Reclaim basically ignores fuse tmp pages.


Thanks,
Bernd


