Return-Path: <linux-fsdevel+bounces-51588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0AAD8C3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 14:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D673B8238
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 12:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BBD4A2D;
	Fri, 13 Jun 2025 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="owsnpGSH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kNO8FS6T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D93FE5
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818156; cv=none; b=cUdJr8wqhBbtP/2zXQh9J2EDWEG+2Ea+oMspzi93cFUgGTLl0TvtPsCKEFlCbxO09U31dDlImmRHWBypFBra3KpEMb/a+53MfpQI1blbBCkOU+Aw5WdyqiSLhnRmCBOgPxGtwlRLoTjIt9Gjh0kQycNkUoHFGk2WGjTiRCL8kNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818156; c=relaxed/simple;
	bh=CvQCCFBQKt4yskJ1+0A6VSXR5u5/81wQOWXsxOdy3pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KF3m1Z5hEOW7FVOpsKHdNwzkjfuG2IJWbs25WRbX6krsL+tz0u5Lg1hWmoLkjlmQfJVIQdrufYnMoFwjVyCSfEIACxa4lsrp2LTEdHVyGxdkq8ZFUayj8ir/cleUt2HDFe3O7JRmpNMKi1VzomYdQ+5j02FXO7/0Twrx5+Nd8Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=owsnpGSH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kNO8FS6T; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 68C941380409;
	Fri, 13 Jun 2025 08:35:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 13 Jun 2025 08:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749818152;
	 x=1749904552; bh=T0NUTOyAiE3pDG1oMbcNeZZhGpjActdzYVcr9JQ9PaQ=; b=
	owsnpGSH/db9iYxVb7v7SWrLRv79SUcyUKM/87iCl/n+XSIwQUf4OnAgneKHU84q
	Zddcr3SgKJVH3Q0rDlmAtaktDIb68i4T/D5JgUMTf91CrVmWWrRvcboJXw3v2Hv3
	x1iQ/bE+hj7ndc18iGkhe69bC71WzDho4NRYALO9xdKYfDjNPxJQt34PKWDSS5eI
	v/vMSt2Ve+dSyyGrit/5FGeUzPnMuhKlFVMW+KxoaUEQ+KjWQJPH8eqLHyrkHL82
	SrbZBmKgr1VJYdXK71t2o+HGDQQZ5YgKISM7wrB+hfLpSU+hEw4qvdqI3+CKcofC
	vXPofKwsk5Fga/3yLNXxoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749818152; x=
	1749904552; bh=T0NUTOyAiE3pDG1oMbcNeZZhGpjActdzYVcr9JQ9PaQ=; b=k
	NO8FS6TFo54kPxW2KUIgWiUWiRwe9+FOc4p5hiRG4v+A6wc1PseXPDWX1DeznPvr
	aZ7F2OSBb+BXycLLpS7As3JEhVI+kRS2IPTE1GC66ATrE462c3VHzcyh08R8VXYe
	E5GTPllNtVCZlFhZ4DHHwNEa5epq5ij+euZIW2MkxT6cn3hnMxn7J7ixl1G4NvOs
	EVN6j7HTHN5lasR7ucL/+9oWV+rqwXbjrN7/19Smly38Lfcn6vy2ywTQ7cPqZNDn
	eIoyJA4hf/EM5JahDKND0xM/QHlb+CBX0/+5cTSkvuKgiVd0F7+ZAXjPcUqtrO10
	o7AnFhVPzCPxQGvqoQuhQ==
X-ME-Sender: <xms:KBtMaPj2NcjZzuxpK5EYqkI64nHl-0s5Hv6FgR-xw2r-Gbwiuc8O7A>
    <xme:KBtMaMATc7_GREOTdjKch3a_iIJp3IJyQV7437RTalkwsn_OtiYwyBL4TzpiQDccI
    dMQxzya1W4-pGBs>
X-ME-Received: <xmr:KBtMaPFAHpRWN1K1wzFB39JpHnXfiMQSQkAv4ZiB1dHr5yBoWf3cwtaWmGK-8COfbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghssggvrh
    hnugdrtghomheqnecuggftrfgrthhtvghrnhepjeffuddtgefhfffggfejheetjeeukeei
    teeiheevheetueeigfeiueelkeejkeeunecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghr
    nhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehprhhinhgtvghrsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprgguihhtihhmvgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghshhhm
    vggvnhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:KBtMaMSYSWAcAaRcBUO2l3vxweUBWIFOEMWv9TyMxxbkSBlPbRZOCw>
    <xmx:KBtMaMzniSdmFHT-LjG7gSamN1H4gnibyOBD1KEtVvvZSoh73eZL8A>
    <xmx:KBtMaC6W79Sfcmfq0IrgKMQjmIDiT64R6_4YJeGcT57m3ZhCHf9CmA>
    <xmx:KBtMaBzX9bMaLL1pvdre6iqfdcYOzVdyB1ifhbg4t8wDII27dB9yPA>
    <xmx:KBtMaNq_nOho4OhnEz4vzGzX2W2gqFbBTT5boi5NQm8ZkYp2zjJ5ginD>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 08:35:51 -0400 (EDT)
Message-ID: <44b12b64-aa03-414d-ab51-86a2eb864b1f@bsbernd.com>
Date: Fri, 13 Jun 2025 14:35:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse] Getting Unexpected Lookup entries calls after Readdirplus
To: Prince Kumar <princer@google.com>, linux-fsdevel@vger.kernel.org
Cc: Aditi Mittal <aditime@google.com>, Ashmeen Kaur <ashmeen@google.com>
References: <CAEW=TRpJ89GmQym_RHSxyQ=x97btBBaJBT7hOtbQFKyk4jkzDQ@mail.gmail.com>
 <CAEW=TRp9t2dTsp+Fd6szDdSrn4j350j0Yrju0GLtFDzzG7i_xw@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <CAEW=TRp9t2dTsp+Fd6szDdSrn4j350j0Yrju0GLtFDzzG7i_xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/12/25 17:56, Prince Kumar wrote:
> Gentle reminder!!

It would be ways more visible, if you would add [fuse] to the subject
line. I only noticed by accident during lunch break when I scanned
through fsdevel...

> 
> -Prince.
> 
> On Thu, Jun 5, 2025 at 2:53 PM Prince Kumar <princer@google.com> wrote:
>>
>> Hello Team,
>>
>> I'm implementing Readdirplus support in GCSFuse
>> (https://github.com/googlecloudplatform/gcsfuse) and have observed
>> behavior that seems to contradict my understanding of its purpose.
>>
>> When Readdirplus returns ChildInodeEntry, I expect the kernel to use
>> this information and avoid subsequent lookup calls for those entries.
>> However, I'm seeing lookup calls persist for these entries unless an
>> entry_timeout is explicitly set.
>>
>> One similar open issue on the libfuse github repo:
>> https://github.com/libfuse/libfuse/issues/235, which is closed but
>> seems un-resolved.
>>
>> 1. Could you confirm if this is the expected behavior, or a kernel side issue?
>> 2. Also, is there a way other than setting entry_timeout, to suppress
>> these lookup entries calls after the Readdirplus call?

I guess the problem is that there is no readdir-plus system call.

Try something like "strace -f ls -l /tmp"

Results in

getdents64(3, 0x6119da3c3640 /* 28 entries */, 32768) = 1768
statx(AT_FDCWD, "/tmp/snap-private-tmp", AT_STATX_SYNC_AS_STAT|AT_SYMLINK_NOFOLLOW|AT_NO_AUTOMOUNT, STATX_MODE|STATX_NLINK|STATX_UID|STATX_GID|STATX_MTIME|STATX_SIZE, {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID, stx_attributes=0, stx_mode=S_IFDIR|0700, stx_size=120, ...}) = 0
lgetxattr("/tmp/snap-private-tmp", "security.selinux", 0x6119da3c1f40, 255) = -1 ENODATA (No data available)

getdents64() eventually becomes FUSE_READDIRPLUS and libfuse returns
the entries with their attributes. And these attributes get
filled into the inodes.

A bit later statx() is called and since there is no cache on the attributes
it has to assume that the attributes are outdated and fetches them again.

Without cache you would need a single application call, but that syscall
does not exist.


Hope it helps,
Bernd


