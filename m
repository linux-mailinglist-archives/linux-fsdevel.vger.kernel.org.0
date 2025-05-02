Return-Path: <linux-fsdevel+bounces-47924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC5EAA736F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 15:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF36E1C04FF0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CE22561CC;
	Fri,  2 May 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Pc93X485";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SbpPpx23"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73232561C3
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192156; cv=none; b=SViJd+l5+PAyT+Ec0bNQ3eeaagA/hbhikFlXKiYMNW4f+wDWD0DOxfyUbqnNJThxLutroUuTyEHUnJAxzWDIGmphNnQETElbxsN3mooAnQCpFoG23Dy8u5Pij8S4ZQabbtCFV6aUNK5uT7/YRKggTU0v4Q10GU9DGmlBRM55DV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192156; c=relaxed/simple;
	bh=wVYRuXNWvXPFFKnnfDz3wCjx48iLAjedm1kTXCi4C00=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Oaa4bIqgmfDeaAh+diWRVsrS7y4IHrGnMhgqupu7JxciFnWwLeQUslk14PII4POz6BrgGI9jxvx6zT5COHxM17/hZKefj8koEPx3KLw5iJKkd61s1SQHzMzJtbgfXj6+12qRrWoHbS9Cu5gvjnrG5UsgEMdiyBQepTfbeTVdTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Pc93X485; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SbpPpx23; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B0CA411401CA;
	Fri,  2 May 2025 09:22:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 02 May 2025 09:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1746192152;
	 x=1746278552; bh=1R64tR7/yI77hMx4+u564pCl17JPquewAAB4WlNMWGQ=; b=
	Pc93X4853PVVPbGWlOuQL0znI6VsJSdKCkazEP0dX7nzbwmu+wIq4HPHzNE120HA
	GwcQwo/NZN+NwcgY7OHMnsWgeLy7slG0czrmK4HxVNu5SxqRI5Z2v/6CNNiAERo4
	UWdTTTwBkQLYatcXRKwhlk8Gv06NvtXeN/WZK75WMiImQmi2cuoCO1B7fg0TRR8a
	a56/+LtrjE3orW244gYFWFwZNsRlRQCQ/3LyclCCLIlQOM0uOCX/CseC7OTtqnhl
	EDWCIpfD6TsAbamGzNAyBnAACcKZON4rEprim5YXFB5+ayt1/+tDL0LiniNGX4cC
	Ik40cweICT7sOAiaGn+XyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746192152; x=1746278552; bh=1
	R64tR7/yI77hMx4+u564pCl17JPquewAAB4WlNMWGQ=; b=SbpPpx233Jv6k7Mud
	F+SMt9iq/C09pSp4/vXuvtVkfnq+3IzInRLI2bBZzN8732/j9zY3ULQmK/HeuwyM
	EUA7p+B2dNzN14jLxCdLssxP0rJm7BX+rRdkHM/hAoDtOE1yB45+GwjekJ6sPQ1n
	EwchygNeAKX/5oWO4clL4DBhVy6feB3/evL7fG+94LRDxgOJ6+o+k8n+rmkvR+Nn
	W4f21yGvNgmAK9fWz9nO4ZM5omXt8eGVlGxCdjRgqRHKhm615aN3eLKe2zejxg5D
	BTHCaJA8tJaiTvME+Hkw4/JBCMAM8e3ytEpByhNY6xjbACn841qGKrAovxSxkJ0r
	V+ReA==
X-ME-Sender: <xms:F8cUaNNa52URRgAWYkSNnIa4SFAbUaKaIoAfWPzZ2HQrfBdEH42GJA>
    <xme:F8cUaP9ZlTubdpBG9ngcXEH6Rg5tk4uGT1RbrD_D1AbD05gSHAdLmEqWbt9QvEsks
    J4SUzl6t4Gp_Upp>
X-ME-Received: <xmr:F8cUaMTD5p0ojJyUP8sM2KWMPO82BBaDIkRev9ZJZmIf_WwkyjtrlHV25KepMPh3nfF9JpTDhdAeLKMgosxzNorHkmOVLRj7pql_VqMBruyxfEPAayDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghssggvrh
    hnugdrtghomheqnecuggftrfgrthhtvghrnhepvdellefhuefghedugfefteeuffejgfet
    hfeuleegueethfegffegueffteehgeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhishesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
    dprhgtphhtthhopegthhgvnhhlihhngihurghnsehunhhiohhnthgvtghhrdgtohhm
X-ME-Proxy: <xmx:F8cUaJvetkTLhhOCQPwjfJ_kHtUKaToz2vnxNSx8oEChmd6Jh4nu2A>
    <xmx:F8cUaFfOA2sRlIe4fneAo3ewiDIf2B_gjblSEvC3RiVRciIChOUFZA>
    <xmx:F8cUaF2hGyeYSMndS1OxMU_ONx3o2fLZ8DkJ21gj7xbUZBUGlpX_tA>
    <xmx:F8cUaB_UFlQV9IWxaOLv2lgCY8Z1GszU0Dsba7RNAfHE1LTgeAFwUA>
    <xmx:GMcUaFAGkF0uVam20Ntv3g8AS6qZ8bWV7ct_MKVcUbhmwkBiV8P_n_AR>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 09:22:31 -0400 (EDT)
Message-ID: <ec87f7f4-5c12-4e71-952c-861f67dc4603@bsbernd.com>
Date: Fri, 2 May 2025 15:22:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CAP_SYS_ADMIN restriction for passthrough fds (fuse)
To: Allison Karlitskaya <lis@redhat.com>, linux-fsdevel@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>
References: <CAOYeF9V_FM+0iZcsvi22XvHJuXLXP6wUYPwRYfwVFThajww9YA@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAOYeF9V_FM+0iZcsvi22XvHJuXLXP6wUYPwRYfwVFThajww9YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/2/25 10:16, Allison Karlitskaya wrote:
> hi,
> 
> Please excuse me if these are dumb questions.  I'm not great at this stuff. :)
> 
> In fuse_backing_open() there's a check with an interesting comment:
> 
>     /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
>     res = -EPERM;
>     if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
>         goto out;
> 
> I've done some research into this but I wasn't able to find any
> original discussion about what led to this, or about current plans to
> "relax" this restriction -- only speculation about it being a
> potential mechanism to "hide" open files.
> 
> It would be nice to have an official story about this, on the record.
> What's the concrete problem here, and what would it take to solve it?
> Are there plans?  Is help required?  Would it be possible to relax the
> check to having CAP_SYS_ADMIN in the userns which owns the mount (ie:
> ns_capable(...))?  What would it take to do that?  It would be
> wonderful to be able to use this inside of containers.
> 
> The most obvious guess about direction (based on the comment) is that
> we need to do something to make sure that fds that are registered with
> backing IDs remain visible in the output of `lsof` even after the
> original fd is closed?
> 
> Thanks in advance for any information you can give.  Even if the
> answer is "no, it's impossible" it would be great to have that on
> record.

There is a private discussion, Chen and Amir are discussing exactly this topic.

<quote>

>>Chen
>>    Additionally, according to previous discussions, backing files are >somewhat
>>    similar to the fixed files in `io_uring`.
>>    If it is considered acceptable for the fixed files in `io_uring` to
>>    have their status visible in `fdinfo`,
>>    then exposing backing file information via `/sys/fs/fuse/connections`
>>    also seems like a feasible approach.

>Amir
> Yes I agree.
> That sounds like a good approach to expose the backing files to userspace and allow admin to force close then by aborting the connection.

> In fact if you want you can start with that.
> I don't think it will be controversial.
> I think this will be useful step towards relaxing cap sys admin.

</quote>


I think it would be good to document all these details somewhere,
really hard to follow all of it.


Thanks,
Bernd









> 
> Cheers
> 
> lis
> 
> 


