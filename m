Return-Path: <linux-fsdevel+bounces-38002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EC49FA2B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 22:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FFCC7A25FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAE71DACAA;
	Sat, 21 Dec 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="h/l26oJM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BoW6RJNc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47E1714A0
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734818373; cv=none; b=t4dlwZonolm9LTWNFlKm3/iIpsw0dLqOPxDKuQ+rkohYhWiypVdFuZEzDR3WIQAFiKd8J6klzDewyETQtDHhpSaOYw9dzWBIFyxhpz5q/lKaMPqxMcQd4P2lAiGgEKSsu7egw0NCZ142MtnuKX3ZMSpND7dLxCjJ7bSuJ3xsIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734818373; c=relaxed/simple;
	bh=o2oRjhE676TFjnetPIFKWPaoypf9SUFtuT8i15n2+CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kt7Y1XEaGKDM0aNjX19Tj0mL0LoHvOLMKBQP4tzaFvaOKOJ9piguehhjSx0arXvAaX2heuwfvwwNjKLcs7IyMcCZvFxcHpHSvA9CaLpsxyGSnIUuItfJDmLJd1ik51HBjgCZWr+5ZZj7SA1ff6CIRkDSmAr2Q3c5UAWltzCo3Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=h/l26oJM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BoW6RJNc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 316781140101;
	Sat, 21 Dec 2024 16:59:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sat, 21 Dec 2024 16:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734818369;
	 x=1734904769; bh=sMGbqJqaLo+swNjh111fv03CGQ/wQb7AIIBGCNupw9o=; b=
	h/l26oJMT2ZaFKN2+ZqbphzoibEwtsEn0NsE+l+2Bhd62PbJZUM2+928gwAEN9e/
	EIqabgFPucqqyVe3KoOyP914HV0h71oBZsdtaKLjrydYPGNejE8JrnRCTm03hG6N
	dMe54mvONLV8NkulpcBjHV78MGZ6xpwdqtRd8xY0nX9WckbJ2Vwp5dmqKLj8LnLE
	VOxsZE/UPxqlljjGNYVeSX0BleT6jH3BQHLNEHO7Zz1xTW/1gIWyr/YBcPr1/qPh
	ORGn0Ar9r1FcfWwJ7czl89nDW3dAuGaVn1XBruIpKUNMccQDF0kJwnaPZPE/Mtxi
	+4/JuD5tBP4phDT4AFtGJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734818369; x=
	1734904769; bh=sMGbqJqaLo+swNjh111fv03CGQ/wQb7AIIBGCNupw9o=; b=B
	oW6RJNc+9nNxY39lNtBT/Do1thudEp1EC1xnSxUq1cFip5nyxbojDJJ8IgYPt422
	0eZihszioJVi9rpK4psM/PGBvLZnY5KhaHBZJwOjxqFxBj2D4QgXb0gyxj5i15K/
	1QvHpDIjLMz4uiCMbhpNU2iFhNg3JE6n2czxO0xzx/nTqpbVZNMF7XlRO84Rrs5E
	zd4P4y//QXgLL9L3DhlzzwcZC7a6sKiuurUCmoQFfOGVOERnRy4FvGa8iGU7+E3X
	IfEvMX8TP4bXq6YpdjPBOCcWwRv58JQPHTNAD8Kb64984GPEFrhwSPCqwiAOv5Oa
	eBNIrJ6CLjZ9jfJ+RNM2Q==
X-ME-Sender: <xms:PjpnZ3nuAUHZ6NNAyoDez0yZf0TbWnXvF1wUgt7NIARlrah06oqFCw>
    <xme:PjpnZ61blXcSQBCf-bBo-5FpXiRXv4xxpoSH6OXBh9tRUCfDVfBHqn-651SnrgX-o
    5hnVQC9NDwJf_jt>
X-ME-Received: <xmr:PjpnZ9rO0ZtztdP_hVmxjrR6HtZAfGkbr39uZ6s48TTmtMw8ZK26Y8IlNdqdiqkrPuCkkzDECqzatFayVB9P_CbbHBFOxeLOsVAeDvu_XdysFhnoaOBl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehshhgrkh
    gvvghlrdgsuhhttheslhhinhhugidruggvvhdprhgtphhtthhopeiiihihsehnvhhiughi
    rgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtph
    htthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:PjpnZ_laCNosBas0AD0-HHGKYCmf4UnxPSuuU9xN0uuqRogcq7aw_w>
    <xmx:PjpnZ102Gl-KtZrMQYraQEaJusPAElaB3kR2bYSqkhStQEk0zEPA9Q>
    <xmx:PjpnZ-tPo0_i2zD5dQUwLZzyTUErWaY4UVV2IQj7Sxw1XSRpjiEkUA>
    <xmx:PjpnZ5W6l4uiOGUwasGxHMw1lO0I23hCMfcyvgM3mee_RH7HWDRjXQ>
    <xmx:QTpnZ00lGXMmxFF1lmSM7eaVWFyyINvWZYQU1c4fFHNBqIMO3Npx2qLo>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 16:59:25 -0500 (EST)
Message-ID: <166a147e-fdd7-4ea6-b545-dd8fb7ef7c2f@fastmail.fm>
Date: Sat, 21 Dec 2024 22:59:23 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: David Hildenbrand <david@redhat.com>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <CAJnrk1YWJKcMT41Boa_NcMEgx1rd5YN-Qau3VV6v3uiFcZoGgQ@mail.gmail.com>
 <61a4bcb1-8043-42b1-bf68-1792ee854f33@redhat.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <61a4bcb1-8043-42b1-bf68-1792ee854f33@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/21/24 17:25, David Hildenbrand wrote:
> On 20.12.24 22:01, Joanne Koong wrote:
>> On Fri, Dec 20, 2024 at 6:49 AM David Hildenbrand <david@redhat.com>
>> wrote:
>>>
>>>>> I'm wondering if there would be a way to just "cancel" the
>>>>> writeback and
>>>>> mark the folio dirty again. That way it could be migrated, but not
>>>>> reclaimed. At least we could avoid the whole
>>>>> AS_WRITEBACK_INDETERMINATE
>>>>> thing.
>>>>>
>>>>
>>>> That is what I basically meant with short timeouts. Obviously it is not
>>>> that simple to cancel the request and to retry - it would add in quite
>>>> some complexity, if all the issues that arise can be solved at all.
>>>
>>> At least it would keep that out of core-mm.
>>>
>>> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we should
>>> try to improve such scenarios, not acknowledge and integrate them, then
>>> work around using timeouts that must be manually configured, and ca
>>> likely no be default enabled because it could hurt reasonable use
>>> cases :(
>>>
>>> Right now we clear the writeback flag immediately, indicating that data
>>> was written back, when in fact it was not written back at all. I suspect
>>> fsync() currently handles that manually already, to wait for any of the
>>> allocated pages to actually get written back by user space, so we have
>>> control over when something was *actually* written back.
>>>
>>>
>>> Similar to your proposal, I wonder if there could be a way to request
>>> fuse to "abort" a writeback request (instead of using fixed timeouts per
>>> request). Meaning, when we stumble over a folio that is under writeback
>>> on some paths, we would tell fuse to "end writeback now", or "end
>>> writeback now if it takes longer than X". Essentially hidden inside
>>> folio_wait_writeback().
>>>
>>> When aborting a request, as I said, we would essentially "end writeback"
>>> and mark the folio as dirty again. The interesting thing is likely how
>>> to handle user space that wants to process this request right now (stuck
>>> in fuse_send_writepage() I assume?), correct?
>>
>> This would be fine if the writeback request hasn't been sent yet to
>> userspace but if it has and the pages are spliced
> 
> Can you point me at the code where that splicing happens?

fuse_dev_splice_read()
  fuse_dev_do_read()
    fuse_copy_args()
      fuse_copy_page


Btw, for the non splice case, disabling migration should be
only needed while it is copying to the userspace buffer?



Thanks,
Bernd

