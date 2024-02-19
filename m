Return-Path: <linux-fsdevel+bounces-11994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3606485A20F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 864CAB235B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FD62C877;
	Mon, 19 Feb 2024 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Y3kQU6YV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M3zCOEYT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211C22C850
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342574; cv=none; b=lN8m6KoBHukf5yEbbnjyGvLq3D1WfcTdbDVPsHRRR0+vocAyC74LmyVadVaoMEeOYWzeOp/lAKS/NNYePQQaZVHTX674/+3ohtsSbgvmf5u2/6qon0SpyQk0irehtmHmzIQrNUew3xfNctWL/8m3PR/CCrD0Qdez5O3T/LrfKLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342574; c=relaxed/simple;
	bh=VQDDUO+xigcRbIOf1IF6lUNCMoNgQ4FY5qD5ltpGEi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdVUaGXR14ccItXRPryk3DcaUc/c2PpTSlii2E9OrinP7+BFSFfltcrEJJQnkGIRfAzds1ID5AlWYWjM42R3xvzCGxONmgg1aei/4f9h+1XUfJKV2tneOBwHOWDTSmIYj0eA92BtqgKN/ASgkx8pmbnf0qRCTXkQrX73arKBgPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Y3kQU6YV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M3zCOEYT; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1C00A138006B;
	Mon, 19 Feb 2024 06:36:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 19 Feb 2024 06:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1708342571;
	 x=1708428971; bh=pV+8InT2CLC6M8iTegX+NrXlEDDezJFpe0i0e68gwC4=; b=
	Y3kQU6YVYq+ZgrZk7axciNqSpQy57xIrf1a59se8SbZXT6aiA6a7QQqMLmvo4LMY
	t+Vroem+CKx0++MLRZ0A0o5jKmjBl5t2XiALWq4EgtdNQKX97l5hQtD5P+owlVMc
	94gHm3JDE3ICXoKk5cUxM80hAd/uPAEIT+EWXyN7/nvdafQnvx8GjWIuCUhGs6xm
	G9UZMsgAyuc0zWxR2uOBLhCjAxoknMJNYhiXa7lST4eIvi0lJctnbbS5cS0viT77
	pIm4UxaerorvPYmCfPTwANVKVxg/aK8NES/lfgT2tMtXp9WdNAKeTCgOiAOhB6Qi
	0BMYTBQKxTYDNTTUEDfhSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708342571; x=
	1708428971; bh=pV+8InT2CLC6M8iTegX+NrXlEDDezJFpe0i0e68gwC4=; b=M
	3zCOEYTNUHiTz8dfKPnfwM1X0j+N1rhIxb9BxbQBVlW0mZu+LXAC3yXu7Kd3Sqr1
	NapAPIkI0OgPcA151pVyLGjatztN3ErhtOKWfn1I0Nw1ogNnpz7d/q8p/Z70q/nf
	s/+ZV5Ux3wb3JoJs3IrA5cXsIC9WrKUF17LVNu+Yvf5ccI20vD3/jIXXD1rLZqTb
	RtKRe1zHNl4c6wrzuLLg/5t6wkJF88k/FofjU6pQcFS+zWoKgoWRNGydkiy8REs8
	PudkqZI51NWzbrAAKmrZXW7jzDVa7To4gDpFsGhXfpzAJgxZnC1vWzM965k9HK1D
	EKzPlEVAhuMTm5LgoMeeg==
X-ME-Sender: <xms:Kj3TZcgpzqYM-rHvU0vfwwcdG38KiUbzsEcFHy2SAVhKZs3j8p6TiA>
    <xme:Kj3TZVCWp3upV0uznhclKXKROzasaJnDGVnVWJvnnxpMKWkMvcPP_vUzjUF7x2Md_
    dLuCP0WFp4OUua7>
X-ME-Received: <xmr:Kj3TZUE4hyDwUxxbJyqdyykgOaVoBJI8tXe1LQKrtD2wDiJJ0rKSrPD69BYdTsmP64CEhH_EKhuueBUTslIoBWPTUfzFP3NzHY6mLYn6sd7-TQrwN0or>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduveduveelgeelffffkedukeegveel
    gfekleeuvdehkeehheehkefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:Kj3TZdTF7NTKBZ7JpQuNtC1zOtKecMRZXKLyzTiYXUpaN1pMBlzDNA>
    <xmx:Kj3TZZx3QNZCSUXFZMaNCqENfQZXu1uv24T8OLJE19ZqVx_--OEbWA>
    <xmx:Kj3TZb6xnzHqESW7MOXaW7BgZYD6k4FR4M8Jdnj6KJDR0xemQSHbcQ>
    <xmx:Kz3TZbsD0XUOYTDLKrLgWH8LiuyKbFDjJMl1DkotgtrR7LeKZZH8mA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 06:36:10 -0500 (EST)
Message-ID: <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm>
Date: Mon, 19 Feb 2024 12:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Antonio SJ Musumeci <trapexit@spawn.link>,
 Amir Goldstein <amir73il@gmail.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 fuse-devel <fuse-devel@lists.sourceforge.net>
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com>
 <b9cec6b7-0973-4d61-9bef-120e3c4654d7@spawn.link>
 <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com>
 <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/18/24 01:48, Antonio SJ Musumeci wrote:
> On 2/7/24 01:04, Amir Goldstein wrote:
>> On Wed, Feb 7, 2024 at 5:05 AM Antonio SJ Musumeci <trapexit@spawn.link> wrote:
>>>
>>> On 2/6/24 00:53, Amir Goldstein wrote:
>> only for a specific inode object to which you have an open fd for.
>> Certainly not at the sb/mount level.
>>
>> Thanks,
>> Amir.
> 
> Thanks again Amir.
> 
> I've narrowed down the situation but I'm still struggling to pinpoint 
> the specifics. And I'm unfortunately currently unable to replicate using 
> any of the passthrough examples. Perhaps some feature I'm enabling (or 
> not). My next steps are looking at exactly what differences there are in 
> the INIT reply.
> 
> I'm seeing a FUSE_LOOKUP request coming in for ".." of nodeid 1.
> 
> I have my FUSE fs setup about as simply as I can. Single threaded. attr 
> and entry/neg-entry caching off. direct-io on. EXPORT_SUPPORT is 
> enabled. The mountpoint is exported via NFS. On the same host I mount 
> NFS. I mount it on another host as well.
> 
> On the local machine I loop reading a large file using dd 
> (if=/mnt/nfs/file, of=/dev/null). After it finished I echo 3 > 
> drop_caches. That alone will go forever. If on the second machine I 
> start issuing `ls -lh /mnt/nfs` repeatedly after a moment it will 
> trigger the issue.
> 
> `ls` will successfully statx /mnt/nfs and the following openat and 
> getdents also return successfully. As it iterates over the output of 
> getdents statx's for directories fail with EIO and files succeed as 
> normal. In my FUSE server for each EIO failure I'm seeing a lookup for 
> ".." on nodeid 1. Afterwards all lookups fail on /mnt/nfs. The only 
> request that seems to work is statfs.
> 
> This was happening some time ago without me being able to reproduce it 
> so I put a check to see if that was happening and return -ENOENT. 
> However, looking over libfuse HLAPI it looks like fuse_lib_lookup 
> doesn't handle this situation. Perhaps a segv waiting to happen?
> 
> If I remove EXPORT_SUPPORT I'm no longer triggering the issue (which I 
> guess makes sense.)
> 
> Any ideas on how/why ".." for root node is coming in? Is that valid? It 
> only happens when using NFS? I know there is talk of adding the ability 
> of refusing export but what is the consequence of disabling 
> EXPORT_SUPPORT? Is there a performance or capability difference? If it 
> is a valid request what should I be returning?

If you don't set EXPORT_SUPPORT, it just returns -ESTALE in the kernel
side functions - which is then probably handled by the NFS client. I
don't think it can handle that in all situations, though. With
EXPORT_SUPPORT an uncached inode is attempted to be opened with the name
"." and the node-id set in the lookup call. Similar for parent, but
".." is used.

A simple case were this would already fail without NFS, but with the
same API

name_to_handle_at()
umount fuse
mount fuse
open_by_handle_at


I will see if I can come up with a simple patch that just passes these
through to fuse-server


static const struct export_operations fuse_export_operations = {
	.fh_to_dentry	= fuse_fh_to_dentry,
	.fh_to_parent	= fuse_fh_to_parent,
	.encode_fh	= fuse_encode_fh,
	.get_parent	= fuse_get_parent,
};




Cheers,
Bernd

