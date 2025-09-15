Return-Path: <linux-fsdevel+bounces-61450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A5DB585D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 22:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A35A2A3A33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 20:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65611F1315;
	Mon, 15 Sep 2025 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="YMGM1w+9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iw1jzV8K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F300D1C5F2C
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967321; cv=none; b=sGY7SfQ3GEvKVvuQ5T+RXn5gyo77MypFAVFn7EedD900VYovqVbPDYBkDvQz2QAYD9PzPWMm0l5mczEDllPZtXAirJmVbOGboGBDSLMxXlceetsdQc9HVtkP07spWRISEy/HaiWUE5oV//YgYXu++98qcCx4wDHLhPN4hX+ag8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967321; c=relaxed/simple;
	bh=87qjBILmqiE2nQ9mOgi/LvIM8Ng8wCdxk2keCc+qX2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTorstd1y4gfzELfEbWKB/d70+1PjMUV3nPlDjZYupnxlx24SEY3mYYlSzqfE3XRzdxbhcDR7yVCaKDHaPf2T4gjecbbR3fBDrVe4YtZkr82HaxerWmpcx4sVLFC4nVWNUCguNobPX7p0hxHWNFsVFqEKHxWa4pOBoZaEeEtqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=YMGM1w+9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iw1jzV8K; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B92731D0018C;
	Mon, 15 Sep 2025 16:15:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 15 Sep 2025 16:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757967317;
	 x=1758053717; bh=5jSyboztpjWPeC62xp6NoJm1YqmF35MP8CduqPzzhuQ=; b=
	YMGM1w+9aMY5iBDYMhB0V9t9Vjscq/Ns9MzPcBcZtz++11ILSlTPfV1uWRcuyyl5
	JBVVUf4/qkOJFqkfvPnr8TZlFFWuHGA/xkNoKjixfoB0TQdf8DkR2xWNQ8m6Cfby
	Twm6JUc1gfANI6sVPBNLDgWsUfcnZ0CGpMR5GcKpD6ZrcafMHh7xpUXPVcPZ7LuV
	RhEBDbs7vaS8WIkP5IIB+gxil8e6mKbL7aIq2wUSHNRpMtkqjPdyfJYGUe+WwgvC
	5ATf9kDSlWeU2La9TbFsEr+kAGdLZcYrzhoGiZEgGKP62qSUXM3eaPb5Op8Auc2u
	ntCEaK7wyoENcS+TbRAG1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757967317; x=
	1758053717; bh=5jSyboztpjWPeC62xp6NoJm1YqmF35MP8CduqPzzhuQ=; b=i
	w1jzV8KS4e4obhN7IItt7+z6k8xLiWKWErhbOlRZ8zxD0EjIx8WXdMDl4qz3C4rY
	32b6DTwmecqysfwU5RWnIdW14QS3ZMQe+e2FuDNyi057yQ1+coYoR3zwa+fcRX34
	EXMxyqXKbAm2ZWYQGCVTQ9JrXpzweK8zLREZ/mhyKbaIqVFWLXe6VTcqC/fith/P
	PDSIYwFdAWpcZTDneBqOk+hLqSMHNzFPPJ5PDJX5JwZIpJIwIxiMp4VK4awm1p0T
	zZAMtt535ogVq4LEKvb6wWl8nQdyzWiEUTowySMEIWn/EktAh67Co0zKLr1ZTuT6
	HnlJmtB9WAzzewp+9jcdw==
X-ME-Sender: <xms:1HPIaFH4i9AvQ14fLma1bsT_uhyNI97JPRA3yTsUv0Su6nAmWOpU0Q>
    <xme:1HPIaE6ORyNR834u1ZdeNraaHxWs1RRg2AQu_aNxZq4fbbSIo7N6GkLGiSJxnxmKt
    mnDrbW3k_R4NImZ>
X-ME-Received: <xmr:1HPIaDu5WfxcjUZNUJPJJwcUjTgxlc01WmMvyuRFSEoIluVHE2euqb7WVpreYk0dMq5r8zGETOmnpMnom1o-O_O22KQNVGOgLAOwI-JpbQern1POVBSe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprghlihesuggunhdrtghomhdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhhloh
    hssehsiigvrhgvughirdhhuh
X-ME-Proxy: <xmx:1HPIaN4VRKg9IEJ1bTJPPNvdA7fldV_tKRtUyXu_OJtUdkSFcYyuCw>
    <xmx:1HPIaGUR4cvjgVMw3HXfK5BzIZovAieDop5aqfZlWIwAmMhLg7HEFw>
    <xmx:1HPIaH85fCuuQrb8C66UfnhCtbE31nPN6jNSRX9f3cvmGC6WuwL0FA>
    <xmx:1HPIaKl7zV15EUcTndg77bSpqpGJrkjFRXMsDigEjOGshE7LSB0a3A>
    <xmx:1XPIaCizbW7cW7BzTCguFW5X-9gEdsrncihKEQqzKEzUEmGGr7-R8wJP>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 16:15:16 -0400 (EDT)
Message-ID: <99313bf9-963f-430e-a929-faa915d77202@bsbernd.com>
Date: Mon, 15 Sep 2025 22:15:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/fuse: fix potential memory leak from
 fuse_uring_cancel
To: Joanne Koong <joannelkoong@gmail.com>, Jian Huang Li <ali@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
References: <94377ddf-9d04-4181-a632-d8c393dcd240@ddn.com>
 <CAJnrk1ZHfd3r1+s0fV209LROO1kixM=_T7Derm+GrR_hYa_wpw@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1ZHfd3r1+s0fV209LROO1kixM=_T7Derm+GrR_hYa_wpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joanne,

thanks for looking into this.

On 9/15/25 20:15, Joanne Koong wrote:
> On Thu, Sep 11, 2025 at 3:34 AM Jian Huang Li <ali@ddn.com> wrote:
>>
>> This issue could be observed sometimes during libfuse xfstests, from
>> dmseg prints some like "kernel: WARNING: CPU: 4 PID: 0 at
>> fs/fuse/dev_uring.c:204 fuse_uring_destruct+0x1f5/0x200 [fuse]".
>>
>> The cause is, if when fuse daemon just submitted
>> FUSE_IO_URING_CMD_REGISTER SQEs, then umount or fuse daemon quits at
>> this very early stage. After all uring queues stopped, might have one or
>> more unprocessed FUSE_IO_URING_CMD_REGISTER SQEs get processed then some
>> new ring entities are created and added to ent_avail_queue, and
>> immediately fuse_uring_cancel moves them to ent_in_userspace after SQEs
>> get canceled. These ring entities will not be moved to ent_released, and
>> will stay in ent_in_userspace when fuse_uring_destruct is called, needed
>> be freed by the function.
> 
> Hi Jian,
> 
> Does it suffice to fix this race by tearing down the entries from the
> available queue first before tearing down the entries in the userspace
> queue? eg something like
> 
>  static void fuse_uring_teardown_entries(struct fuse_ring_queue *queue)
>  {
> -       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
> -                                    FRRS_USERSPACE);
>         fuse_uring_stop_list_entries(&queue->ent_avail_queue, queue,
>                                      FRRS_AVAILABLE);
> +       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
> +                                    FRRS_USERSPACE);
>  }
> 
> AFAICT, the race happens right now because when fuse_uring_cancel()
> moves the FRRS_AVAILABLE entries on the ent_avail_queue to the
> ent_in_userspace queue, fuse_uring_teardown_entries() may have already
> called fuse_uring_stop_list_entries() on the ent_in_userspace queue,
> thereby now missing the just-moved entries altogether, eg this logical
> flow
> 
> -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
>     -> fuse_uring_cancel() moves entry from avail q to userspace q
> -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
> 
> If instead fuse_uring_teardown_entries() stops the available queue first, then
> -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
>     -> fuse_uring_cancel()
> -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
> 
> seems fine now and fuse_uring_cancel() would basically be a no-op
> since ent->state is now FRRS_TEARDOWN.
> 

I'm not sure. Let's say we have

task 1                                   task2
fuse_uring_cmd()
    fuse_uring_register()
         [slowness here]
					fuse_abort_conn()
                                          fuse_uring_teardown_entries()
	 [slowness continue]
         fuse_uring_do_register()
            fuse_uring_prepare_cancel()
            fuse_uring_ent_avail()


I.e. fuse_uring_teardown_entries() might be called before
the command gets marked cancel-able and before it is
moved to the avail queue. I think we should extend the patch
and actually not set the ring to ready when fc->connected
is set to 0.


Thanks,
Bernd





