Return-Path: <linux-fsdevel+bounces-38149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E609FCE5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 23:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77851883071
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2024 22:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDB418870C;
	Thu, 26 Dec 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="EWXqFABr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bxyaaik0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E73139E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2024 22:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735250528; cv=none; b=Gq3FlBfq3XQK3hF1/hssgDLp3V5jd5DI4OCHD1d0KyPTKs+kP8XOLe4F0vxWE8ZWtOjgR+aEU0vkAlKnmWaBXT9Z57yjGwoaMNdn5p3xg9h0gCOSxrwnUp7wISvMFiqoPsGe+g43lwRuitloS/owH3CJ1IAnaTzcgIBDYVHCAv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735250528; c=relaxed/simple;
	bh=7dvqSjhifSk1SWNbR+bwkjiNHJ7IXHokwoHxWlRmvVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fk+DhPclp6RCledkx044NutPBVPZfG/gQQ5WkoYvDOj3ocwBvSmfJogEanU/6NCCLkg2paRg57DciY56DTd/uD3wrLU04xcN1nP30gNccGgRxQcWT2ccd9KtuuZC4NqRxN+c0l+QW7qCaYsxDVlfivkPDcAL8emrc6Z9zRg66ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=EWXqFABr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bxyaaik0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D5F7F1380078;
	Thu, 26 Dec 2024 17:02:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 26 Dec 2024 17:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735250525;
	 x=1735336925; bh=kQQAmUtu/apo3KeTAhWaMdIQKeSQv/DSTiMw5mchl5A=; b=
	EWXqFABr+ffMmw7fYrsAYJ3Ll5Ov87I3vhtksa053DX2S/eEE1ccNeLC15AwOXCz
	xRvt2j5igmhZEcvjIkmCm9x0vCn2cIv5Gta63WvBRq+w7IrV/NEY5Ja5hSOytGiT
	VEBMgZWTeVhH90EiEHDkYLzEc2jvu0NWjQHrxbaSvW41htqAZz5ICPL129CkhWEg
	TGppgxuv1zFgk/qEFqs5iIfTomjGboZpj6CKCC/XIls981ZlLhO3S0AP3eArO+CZ
	lQSKpavE/F7cmVyb3IPubQdGHjVeK+vdHOJunAMZbuhDOHro81uXhTYuRvv6g222
	AjyZESW519nHMUbf4Kzsew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735250525; x=
	1735336925; bh=kQQAmUtu/apo3KeTAhWaMdIQKeSQv/DSTiMw5mchl5A=; b=B
	xyaaik0q/tKe8RZ5UF499ThkoZmPhKsHxmeml8Ogd55PNdy57704hmKgCwMiVOm4
	1bEs+zRP2531xBr/Ma9RVvz5PwajKbpNdGlENuNLEhHdxiBZ58KKhROpl2e28NuW
	YXIAyoTB5spva4G7Ye1w6zF3Ivretk0NlGDTJ2XTC/GVftMQ27gxiw2ME9EAi0Fy
	Xys+fTiyE14O1gtjRmHExV3MOJQY7i5/vNDIMLF2cbw4bNfaPYhonF/t5Wzdz/jZ
	83zZnA171O7/r09kVWfpLQypXW95VivxNXNsqBtnWt+NIidC5bAWiLL4pt5GMLTS
	T22WeAfs3zGa3k1i348HQ==
X-ME-Sender: <xms:W9JtZ9SvZ-Zgiz4-CTjXLXySjYWxUqdPEBFzlRRGvySeTiHy16AmFQ>
    <xme:W9JtZ2xxhHl4jQMOuMd8UTUU0yyT76dMpYXPdf1pQcLEBetMJS44O1-C6LpoQTRSJ
    WzjubfGwnsHSxjS>
X-ME-Received: <xmr:W9JtZy2rO-oBEzcHOWwaJmmOd-DRhmRONaQOmpufRkqQlLDg13q3h11ndJSqZHEXAyEVsyz8JRH2MmfhB-wbsVBg2b1MHcr5GJhj8JvukqlujhrzRSrZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehshhgrkhgvvghlrdgsuhhttheslhhinhhugidruggvvhdp
    rhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehjohgrnh
    hnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopeiiihihsehnvhhiughi
    rgdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtph
    htthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:W9JtZ1C8kW-0jyXxjXfUR4HCZMQnFphV97ZeXLFTUwmmR2cKTr6ylA>
    <xmx:XNJtZ2jSQKY6-gxFw_UUb09xbDjfrCW3SgGs0kzqa1--BLqR3G0Njg>
    <xmx:XNJtZ5qiaa-qnyC2f7604DnbUc5R3hZFSgZ058wCob8Da0yg_1-big>
    <xmx:XNJtZxgppnwkz0MM96CaSOTzc8cVRq17Fhgsoh7nspX2ucEA-Nt0sg>
    <xmx:XdJtZ9Rkp8BQqcFYfTywNkB7Eiv1qAzZp-SPTkpEhaptz8MYhkmmtqrs>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 17:02:02 -0500 (EST)
Message-ID: <bc855001-e7d1-4a72-8958-b77b9c60b04f@fastmail.fm>
Date: Thu, 26 Dec 2024 23:02:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>,
 David Hildenbrand <david@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Zi Yan <ziy@nvidia.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
 <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/26/24 21:13, Shakeel Butt wrote:
> On Tue, Dec 24, 2024 at 01:37:49PM +0100, David Hildenbrand wrote:
>> On 23.12.24 23:14, Shakeel Butt wrote:
>>> On Sat, Dec 21, 2024 at 05:18:20PM +0100, David Hildenbrand wrote:
>>>>
>>>
>>> I think you have valid concerns but these are not new and not unique to
>>> fuse. Any filesystem with a potential arbitrary stall can have similar
>>> issues. The arbitrary stall can be caused due to network issues or some
>>> faultly local storage.
>>
>> What concerns me more is that this is can be triggered by even unprivileged
>> user space, and that there is no default protection as far as I understood,
>> because timeouts cannot be set universally to a sane defaults.
>>
>> Again, please correct me if I got that wrong.
>>
> 
> Let's route this question to FUSE folks. More specifically: can an
> unprivileged process create a mount point backed by itself, create a
> lot of dirty (bound by cgroup) and writeback pages on it and let the
> writeback pages in that state forever?

libfuse provides 'fusermount' which has the s-bit set. I think most 
distributions take that over into their libfuse packages. 
The fuse-server process then continues to run as arbitrary user.





