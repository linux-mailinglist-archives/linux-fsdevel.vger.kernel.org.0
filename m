Return-Path: <linux-fsdevel+bounces-55762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8ACB0E65F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 00:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D893B8F48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 22:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9112877E8;
	Tue, 22 Jul 2025 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="krlmCL+K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BK8EJ05n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB93A76025
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222868; cv=none; b=XDeLpjQkJhAaAIhSWNGb91H6hP/OgP2012CTDHgXg2ACMLQMHFYKFF+hMF/dVsL+D3Nj4WPx/+gqV2+gppHzTByW60Bu9mwTTXIIK8sLoJ122ZUhg/fwjOFEPTJJHfaUbvuwO29GloIqzCJa+EmQ8+Rr/HxiyHkjDpFWx7m8nwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222868; c=relaxed/simple;
	bh=38UGYQoGHOIWt87eNzaRwSetOqGVMFOw/4H1ZdBqPFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuVyw0NvHHH/0oIvxcc1e82GkFuHIlZoqLSI3EY2Nfhnq1u3FLfWTMUI12a/owZpU9VWDd8iRE65voykpf9Uq3S4c1PE0PBTmWrMI4XCumLAPn1Kt4dKZ8KeigZ5pI9Q7dGjxH/FZANeXWgzHtZB9tgsB1VXuNzopUMlUu3q1Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=krlmCL+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BK8EJ05n; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 900027A037E;
	Tue, 22 Jul 2025 18:21:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 22 Jul 2025 18:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753222862;
	 x=1753309262; bh=5+03m8Bpbehi5Z5DzmTbUx6spG4Kzt7CPiYnYWZ8WJw=; b=
	krlmCL+Kri6X3iSBTJAW8WjPthl9LbOJIB45zQqsoWHmzR4LZob/AG/CI++Jjncu
	XsUPnZgtTsGC/b5AZOJGhoKgm8pyDWCCNdTCf6dKbUXsGlVPkFtvLjlReAbSE9lp
	j4Ph1TVnndGvXoaOcnp7RpcZbkdBXpkFGzsRY+yrJvn+B36WEaa3ebcP4uGQVMdW
	GS19AbEhLRDr67re/VMLUl1S11A7OeKhLExWvPC5tHPe+YJynLxUHivuQcpHcFn/
	0y4IJ8bJmQ8h8EObkRBO56PQfI2niUoVNP2VCma3ksQh9yArhhgh/ojmgpWoThKX
	iA49hmZK+r/Zl2pzZJXGNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753222862; x=
	1753309262; bh=5+03m8Bpbehi5Z5DzmTbUx6spG4Kzt7CPiYnYWZ8WJw=; b=B
	K8EJ05nQciu0uGRb5UtiwprvXMaCdZNSg96yo2egVrEEX0obygDiRfi06jBQV7Te
	rK7v1SffMduFbVDNTVureU+DP/wee8QvcGHzvROewyrAiR9megYLQ8lSj0f5EFH4
	+XA27NMvBNyERbm2pTw3JcNjmx4KOqYXStnkEpsJv0cDAcGpEXgAMoD+WdldMg8V
	CL1ftDtAfIzmHIBTJFIrs1IhsHeX3c1VC7eOQoZ8LG1KNHrGkEsZIH2KgtdQHn84
	BT+zbYig8hhHjCnb7s3qnhORbQpsUBhjaj5KXiycPxFPR37sz1s59cWPvQGE0Zlb
	EBMqCdHrcVVKwFm0XXyGA==
X-ME-Sender: <xms:zQ6AaHgDXNU1mULD6onExwnR9JSs0G-DRPCRyqLHX9uRMYdgyws_mA>
    <xme:zQ6AaMekrg7gkLoDOraCUHG5U5Dtl3lPajb5FchWJjQA2n-VUrnB7j79pSsRS0KeX
    hb77SiJOWLhe1nT>
X-ME-Received: <xmr:zQ6AaHhiyIU4U7cnYHIv78VvA61_1Ldw83zZs_k0D_MUG7SgKQ5Xko-m8JTC7pPbuQaXulL7OFN51pWGk4qpawIUuBeU7LtnQMiw9bBZBmd0nszZeixL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejiedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnheptdeghffgueduvdeuuedutdduhfevteeiiefhtddvueffhfevffefieeuhedu
    kedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnuges
    sghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepjhhohhhnsehgrhhovhgvshdr
    nhgvthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoh
    epjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:zQ6AaEyM3zuHOTERw0Wnn-hQueWlVMZv2C54N6VFYwpVB1Y-FBj7ig>
    <xmx:zQ6AaDMjeyP_eu6XwEdEZZlg7ECNiFTRFbbwa_NVfyYIBSGvTUmgCA>
    <xmx:zQ6AaFVFGnh8MYAa0V2deqFOC3-BrSJM8YkRJMU-LjSTOsEXG87I9Q>
    <xmx:zQ6AaH3no1wMcyJgpxrEXuadKAWO8wbyguQ3zTIAT2rrg-xwd6Qo9Q>
    <xmx:zg6AaJHFUrQ6JhuTJNiyd-0DGN6dinTADv7Wu1SJFTubtqetq89aa9DP>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 18:21:00 -0400 (EDT)
Message-ID: <73b8b50f-359f-4534-a522-c65c5c75b6a3@bsbernd.com>
Date: Wed, 23 Jul 2025 00:20:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] fuse: capture the unique id of fuse commands being
 sent
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, joannelkoong@gmail.com
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449522.710975.4006041367649303770.stgit@frogsfrogsfrogs>
 <3f65b1e1-828a-4023-9c1d-0535caf7c4be@bsbernd.com>
 <20250718181312.GW2672029@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250718181312.GW2672029@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/18/25 20:13, Darrick J. Wong wrote:
> On Fri, Jul 18, 2025 at 07:10:37PM +0200, Bernd Schubert wrote:
>>
>>
>> On 7/18/25 01:27, Darrick J. Wong wrote:
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> The fuse_request_{send,end} tracepoints capture the value of
>>> req->in.h.unique in the trace output.  It would be really nice if we
>>> could use this to match a request to its response for debugging and
>>> latency analysis, but the call to trace_fuse_request_send occurs before
>>> the unique id has been set:
>>>
>>> fuse_request_send:    connection 8388608 req 0 opcode 1 (FUSE_LOOKUP) len 107
>>> fuse_request_end:     connection 8388608 req 6 len 16 error -2
>>>
>>> Move the callsites to trace_fuse_request_send to after the unique id has
>>> been set, or right before we decide to cancel a request having not set
>>> one.
>>
>> Sorry, my fault, I have a branch for that already. Just occupied and
>> then just didn't send v4.
>>
>> https://lore.kernel.org/all/20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com/
> 
> (Aha, that was before I started paying attention to the fuse patches on
> fsdevel.)
> 
>> The updated branch is here
>>
>> https://github.com/bsbernd/linux/commits/fuse-io-uring-trace-points/
>>
>> Objections if we go with that version, as it adds a few more tracepoints
>> and removes the lock to get the unique ID.
> 
> Let me look through the branch --
> 
>  * fuse: Make the fuse unique value a per-cpu counter
> 
> Is there any reason you didn't use percpu_counter_init() ?  It does the
> same per-cpu batching that (I think) your version does.
> 
>  * fuse: Set request unique on allocation
>  * fuse: {io-uring} Avoid _send code dup
> 
> Looks good,
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
>  * fuse: fine-grained request ftraces
> 
> Are these three new tracepoints exactly identical except in name?
> If you declare an event class for them, that will save a lot of memory
> (~5K per tracepoint according to rostedt) over definining them
> individually.
> 
>  * per cpu cntr fix
> 
> I think you can avoid this if you use the kernel struct percpu_counter.

Thanks a lot for your review! I was hoping I would get it updated before
I got on vacation, but much too late now. I will that I get some work
done next week, but no way before Saturday - traveling the next days.


Thanks,
Bernd

