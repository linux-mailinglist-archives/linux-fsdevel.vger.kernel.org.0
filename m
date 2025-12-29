Return-Path: <linux-fsdevel+bounces-72169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE601CE6AE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 13:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A53883001615
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0FC30FC1B;
	Mon, 29 Dec 2025 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="0gMA+L0e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SdnbUH1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193823875D;
	Mon, 29 Dec 2025 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767011253; cv=none; b=EEPdu+b73SR23vSMM5wHYykK0Uc/NhApsRJ4LZ4O9Nf2U+Lx4HkPRhk7omr3HmvnG+dRG4U5acKWwLlBzGZn75NH9XSaCrku+h09nP/rrfsbCYWszKVuqUIsGIDZyXpXPLYoDz0te0g2/VfRY5NIW/pVXM0aELyIXYFcswhPb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767011253; c=relaxed/simple;
	bh=h5jqpr+aFuPBO4/6MSYFBF6Ky4t9eTzsKiyCOqf0mLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBzR7MhCCZtMRJLto3FaD0XeAfH1Bu4U8qkcgGjZiyTUCrVO4Zvrv6rZ/blO3h0lTfWpOgWInAqTt5A/j3BPRsAO89Wo2l/EVYy/+VDlaEKZZHCHZbXQ2jtzsiczgmM4/XpuPquqWEUcRVhMOHV9xTzSHkgixhnWnC9yg7+fLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=0gMA+L0e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SdnbUH1I; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6DF3D1D00086;
	Mon, 29 Dec 2025 07:27:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 29 Dec 2025 07:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1767011249;
	 x=1767097649; bh=7OsxHTtUKBB0ZAB6+cq+txavxCR8ZeckD5aCNB9GEMw=; b=
	0gMA+L0eFLbTubXGojaspGTo4zJ+d48oklMD37jb2rnYpAUAPu+zozI2nM5nljZ8
	OofZQqBlruIGN3iFomp+nFgLTC6uqv1omCajQF86o6yKUelvBEVA3Ke0e49fHRz8
	xB9MtgLwWp7BNdfb9KtoiNJjEQfvOVTfPDZJR4GZPhPrl4f4uQZr2w+NHR/sRtqM
	URo5PNQtdafqjcnbagrF8qT54jBuFnuQQ+mtd3S9f83SBmKqQMAtWLZGtVUTUQpU
	n0eFCV4VEa//2M/uVo/cjab09WyjPa5r6J5DLmnmVgldIvimRxkKBcVav7n/ugn3
	he/Uh0bTd4wns9zvDFeHPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767011249; x=
	1767097649; bh=7OsxHTtUKBB0ZAB6+cq+txavxCR8ZeckD5aCNB9GEMw=; b=S
	dnbUH1I7AvLrR3hzXGFN0hzMCDsUmgBR/IHau4ByxmhJLo1jIpCpocj7h7PQx5D/
	3aIwB/brASrsMhRoPof8SY7IVon2CroKzt0ZoivG0cFjBfEFYgJN6gaup3qHTZde
	YiJQT7JAw+bQX+cAUeGqz0mJorRzUFF0cl1pt3Mrlh7pHZfg1Aw847bXuzGChSIW
	zeg3xAXm2LRvKZEPV/EnzKlalJOd+TsbuH2EU4cxZ0FgFnfBIBo0nkyFzbYYEKCc
	TV8Boh4mv6hK4cSM2fzIan8EfWyntFSVrxZZdGbId6Gd2WAmL2Bo90nFmKeecO9m
	0llOhtM+Ev9vMgB5QmPsg==
X-ME-Sender: <xms:sHNSaX16DjpMRSD9fBwiBInHmfSOVCRivKcX0JJwwSQH_nr9RRgXTA>
    <xme:sHNSaYpVJj54TqDpXTpDh_ie0Z7IBy15MLHP7H9K8cNVPJwUU-tgWEMDf-gyLakt3
    XbooF8eRTCvx5Q71T1MfYSw2fIRLWLoflzmPaoaRPYUW4YrfsPL>
X-ME-Received: <xmr:sHNSabg8gvXqrcfgwG_CE4L4UdoSOirAYbRuHg6nQjiMaQjuVDh0USASgvyoEkAsnMt5cH4nmC3VzhDY_K6o359CQeELMaB-QfU35V4egUdmeEi3GePJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejjedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepjefgleejueffhefhueekvdduhfetteehtdehfeejhfevudethefhtdetvdek
    keevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjvg
    hffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehhsghi
    rhhthhgvlhhmvghrsehgohhoghhlvghmrghilhdrtghomhdprhgtphhtthhopehmihhklh
    hoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhsghirhhthhgvlhhmvghrseguughnrd
    gtohhmpdhrtghpthhtohepshihiigsohhtsehshiiikhgrlhhlvghrrdgrphhpshhpohht
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:sHNSac_fLSLZzrjCOes-QbxX9M2OBB-4n7dk5MMWrOg7WE_hDLUjIg>
    <xmx:sHNSafV08BqgjwZu3TZWYadkqcp-0_0Y98fo-ysfA7URZkB89yUUsw>
    <xmx:sHNSaYCg89ri_CSaGr8nwaaxFr_Eav9FyPO_42dG-QTasnHbOg0uEQ>
    <xmx:sHNSacFS9dq4zcIqVd8PvkdCCS5qrFvcuyRXE-mv-hArxDVJE3ouSA>
    <xmx:sXNSaTHWHobWFJ3KBMQ_GYkR_E_T-R8V8jZ7R7n2iEcCN80kOXQyjC9T>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 07:27:27 -0500 (EST)
Message-ID: <f3418925-6e3a-4593-b6c4-4ac7ad4d6740@bsbernd.com>
Date: Mon, 29 Dec 2025 13:27:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/2] fuse: compound commands
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 Horst Birthelmer <hbirthelmer@googlemail.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>, syzbot@syzkaller.appspotmail.com
References: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
 <be2abea2-3834-4029-ba76-e8b338e83415@linux.alibaba.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <be2abea2-3834-4029-ba76-e8b338e83415@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/25 07:03, Jingbo Xu wrote:
> Hi Horst & Bernd,
> 
> On 12/24/25 6:13 AM, Horst Birthelmer wrote:
>> In the discussion about open+getattr here [1] Bernd and Miklos talked
>> about the need for a compound command in fuse that could send multiple
>> commands to a fuse server.
>>     
>> Here's a propsal for exactly that compound command with an example
>> (the mentioned open+getattr).
>>     
>> [1] https://lore.kernel.org/linux-fsdevel/CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com/
>>
> 
> To achieve close-to-open, why not just invalidate the cached attr on
> open so that the following access to the attr would trigger a new
> FUSE_GETATTR request to fetch the latest attr from server?
> 
> 

Hi Jingbo,

because that slows down operation. Doing in 1 step is faster.

https://lore.kernel.org/r/20240820211735.2098951-1-bschubert@ddn.com

https://lore.kernel.org/all/20240813212149.1909627-1-joannelkoong@gmail.com/


Initially Joanne had created the 1st patch and I had asked to do that in
one step and created open+getattr v2 with a new op code. Miklos then
objected and asked for a compound version to avoid too many new op
codes. Horst is in the mean time also working on atomic open using
compounds and I have another use case for attribute updates on writes.
I.e. this is the 3rd attempt.


Thanks,
Bernd


