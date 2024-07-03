Return-Path: <linux-fsdevel+bounces-23048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A1F9265A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 18:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C616D1C217BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E219A1836F0;
	Wed,  3 Jul 2024 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="mxmAWi6j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TzskAufh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADFD181CEC;
	Wed,  3 Jul 2024 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022947; cv=none; b=llXnLj6SYonjlm9eJ/GKC6U0B1ehVH8oSaGIXi1MPJlQMc7iMDaeBtEUoTVxs+I51v+WwI8pdg5MiR6eDk2WMfEW9Ed9fsde0/M/YE1UIVvvTbL5w9s1tFTD4vHTgxTnkWu6aXEAAZ7xLyOA3G98ImdctqG+4PvcmXA5lsvDI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022947; c=relaxed/simple;
	bh=PppQHhvqKsdwAr4qP4L+d8nug9/blPOWkp+39LUg6eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rntS+uhznkqk6wXfMCV8zF+gXAlFB7ju9QzMmM6opnd0pzIXqsoBDRJfgQKICwXfWXybgiXcXRxbkU5Nk3knIHapsq5HZYtgSQN77EFAKjOkf43JLcbvdL61GoCogIaiE0U/WUmDnU9l6W2NdT0XWE3Cs0x3z6Ij7BUu48vtenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=mxmAWi6j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TzskAufh; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7A23E11401BC;
	Wed,  3 Jul 2024 12:09:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 03 Jul 2024 12:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720022944;
	 x=1720109344; bh=ua/AYUPes9aWxEV7mFuIJxJfyBeCcW87pVq+a/vjK0E=; b=
	mxmAWi6jX9hG4KMRUCxmuIE3d9C4K11jP7xKLj9vk9mnO8r+P7Yuyl0eOxIz1VCN
	VVPuRsd49Mh8rJOLWZLGuD7YpHg8UBGspKvo8LDyDDAND3tAtpxUxMBKEF3++s6W
	MxSiU/XvIYVc3deGiCJDNREJc1ylpmh6tLEP8JJV16Z12WjFGsfTdqBPD6RbldA3
	QQosWLbOMHmIalG6/F6ToeKCY3YWSY/FnvmSD+Eh6p83O51NgUKUOZbfgrjtGHaQ
	7z5D+y7kueKBdvZCWM2fmYfVF6O4DAmUHUsY6lANqWgNu/BN6mEgsgBbMmLNPbhL
	BnZWeBh+92A2v787Ydjv2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720022944; x=
	1720109344; bh=ua/AYUPes9aWxEV7mFuIJxJfyBeCcW87pVq+a/vjK0E=; b=T
	zskAufhvZMvg/1pSSiOUUf8AvKYkRkMZbl8hhbLp/xasAXfiy+4yF+50UOHZyVOD
	J/HlYguSuT+U268sLL9YHrp0hWd+6tixnRePQZMd9zCTYLikjQhR4gPy79/IT8d8
	VaEEhHpkz/9L9C/ug1TV91ZzA3sH7bGbr1ObY8Fd6oi/si11bl4hORhtpP+5JRMw
	O/Cns3xpCW9cMehFi6tCzWq22/laibPfTN/cczGanU2QoCqdJAjpqh1lUbc2wf2d
	g3DxvVrsbd9tFWH+l9o3iWARckK1GCsYE5JtNeMJJDC3ybe2LhmWQ7KLDLFLnGVm
	ltp8K/h4iS5yvzPDoEpvw==
X-ME-Sender: <xms:n3eFZngPjjbVrx4K-esw7saqVrjN7L_jEuFwCDXVBChRS4Ay6hEFHA>
    <xme:n3eFZkCC-HZfgpsd_jwNijGgEnep1JNYEmKKf6VTl9scNVJ8p2I6DTjjinKSpdYZY
    R2wI23hH2ndspGZ>
X-ME-Received: <xmr:n3eFZnFNNXcubQ1VGPSMGzHdz86ckMrNxt1MdDhRhQhixCIRAXPe8yDywoGIUxxSKYrRE487R56sMY4AGGAgDSn6fYhdzhDc7iPCsw_tlbJfsxj8-KgZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevgfeukedtfeeugfekueeikeeileejheffjeeh
    leduieefteeufefhteeuhefhfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:n3eFZkTrVEx3La84J69BNb2ycfi_ayxkTbpsQYAvITSsZySGGiBl3Q>
    <xmx:n3eFZkwIe-I3-zFedIKQJfoi6BgDRPDRrBXTl60ReGHdtvb2kZdjew>
    <xmx:n3eFZq5szQYerOO87WWvjxe9nvEqZqe_JSAQpnOoOMu5r_FFCllIAQ>
    <xmx:n3eFZpwrIfzBqNoiw_2P_E2dVF4qIm_m8eiGiRTJycoOQvCiVhod4w>
    <xmx:oHeFZrlC_qOPUHOMmO1BHyObA4vkbOmV4co01bmWPBWxkazRfJNB9r4H>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 12:09:02 -0400 (EDT)
Message-ID: <d98fefc9-fbb4-44b8-9050-61378176dcf1@fastmail.fm>
Date: Wed, 3 Jul 2024 18:09:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Fuse Passthrough cache issues
To: Amir Goldstein <amir73il@gmail.com>
Cc: Daniel Rosenberg <drosen@google.com>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-team@android.com
References: <20240703010215.2013266-1-drosen@google.com>
 <315aef06-794d-478f-93a3-8a2da14ec18c@fastmail.fm>
 <CAOQ4uxhYcNvQc-Y+ZZSGyX1Un8WCJuE-aeiRrgLm91HwJ48gWA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US
In-Reply-To: <CAOQ4uxhYcNvQc-Y+ZZSGyX1Un8WCJuE-aeiRrgLm91HwJ48gWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/3/24 16:41, Amir Goldstein wrote:
> On Wed, Jul 3, 2024 at 4:27 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 7/3/24 03:02, Daniel Rosenberg wrote:
>>> I've been attempting to recreate Android's usage of Fuse Passthrough with the
>>> version now merged in the kernel, and I've run into a couple issues. The first
>>> one was pretty straightforward, and I've included a patch, although I'm not
>>> convinced that it should be conditional, and it may need to do more to ensure
>>> that the cache is up to date.
>>>
>>> If your fuse daemon is running with writeback cache enabled, writes with
>>> passthrough files will cause problems. Fuse will invalidate attributes on
>>> write, but because it's in writeback cache mode, it will ignore the requested
>>> attributes when the daemon provides them. The kernel is the source of truth in
>>> this case, and should update the cached values during the passthrough write.
>>
>> Could you explain why you want to have the combination passthrough and
>> writeback cache?
>>
>> I think Amirs intention was to have passthrough and cache writes
>> conflicting, see fuse_file_passthrough_open() and
>> fuse_file_cached_io_open().
> 
> Yes, this was an explicit design requirement from Miklos [1].
> I also have use cases to handle some read/writes from server
> and the compromise was that for the first version these cases should
> use FOPEN_DIRECT_IO, which does not conflict with FOPEN_PASSTHROUGH.
> 
> I guess this is not good enough for Android applications opening photos
> that need the FUSE readahead cache for performance?
> 
> In that case, a future BPF filter can decide whether to send the IO direct
> to server or to backing inode.
> 
> Or a future backing inode mapping API could map part of the file to
> backing inode
> and the metadata portion will not be mapped to backing inode will fall back to
> direct IO to server.
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAJfpegtWdGVm9iHgVyXfY2mnR98XJ=6HtpaA+W83vvQea5PycQ@mail.gmail.com/
> 
>>
>> Also in <libfuse>/example/passthrough_hp.cc in sfs_init():
>>
>>     /* Passthrough and writeback cache are conflicting modes */
>>
>>
>>
>> With that I wonder if either fc->writeback_cache should be ignored when
>> a file is opened in passthrough mode, or if fuse_file_io_open() should
>> ignore FOPEN_PASSTHROUGH when fc->writeback_cache is set. Either of both
>> would result in the opposite of what you are trying to achieve - which
>> is why I think it is important to understand what is your actual goal.
>>
> 
> Is there no standard way for FUSE client to tell the server that the
> INIT response is invalid?

Problem is that at FUSE_INIT time it is already mounted. process_init_reply()
can set an error state, but fuse_get_req*() will just result in ECONNREFUSED.*

> 
> Anyway, we already ignore  FUSE_PASSTHROUGH in INIT response
> for several cases, so this could be another case.
> Then FOPEN_PASSTHROUGH will fail with EIO (not be ignored).

So basically this?

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 573550e7bbe1..36c6dcd47a53 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1327,7 +1327,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
                        if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) &&
                            (flags & FUSE_PASSTHROUGH) &&
                            arg->max_stack_depth > 0 &&
-                           arg->max_stack_depth <= FILESYSTEM_MAX_STACK_DEPTH) {
+                           arg->max_stack_depth <= FILESYSTEM_MAX_STACK_DEPTH &&
+                           !(flags & FUSE_WRITEBACK_CACHE)) {
                                fc->passthrough = 1;
                                fc->max_stack_depth = arg->max_stack_depth;
                                fm->sb->s_stack_depth = arg->max_stack_depth;




Thanks,
Bernd

