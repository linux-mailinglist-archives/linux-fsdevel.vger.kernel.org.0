Return-Path: <linux-fsdevel+bounces-45617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B7A79FCB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 11:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6833F1641B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61881242936;
	Thu,  3 Apr 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="P8CRbVRv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQRg07i5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2F2CA6
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743671769; cv=none; b=UBoYoGXxChJnIlQ5zxaV01C9mhfPmVTfUapg8+Z6Q1v4oPWrR+IzuIM0ucHlZ5/nYaUnAC6TJq8TiQilgVETP3OxNzBsN4Y1Bb3KYrEcMl4vJZARv31KymcPX8/GbFTM5+ge4PsEU1eVMJ/yh8KLafCOlhV0kWAZsQ5UV20TkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743671769; c=relaxed/simple;
	bh=5HjRxBu0r1qRE2N9HjkX5OJxMvhXmWgahcLbPcqYunw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBZYu78GrioztfdgocjaJM4DR7VrW5lTF39j/a/rUYW03/0k18QY7RH7mGfx5++MgfE4ltACZVbAG0pxvrBCQOemV6L7uNdfVCgNOz/rQpy32ONOm5J9xoSssnQ9qjUtdW6/Vq0Pb4Uj3EknoZISUSusWX1lz/V4yIsGs0y3r+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=P8CRbVRv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQRg07i5; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D67E52540271;
	Thu,  3 Apr 2025 05:16:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 03 Apr 2025 05:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1743671764;
	 x=1743758164; bh=ffaEaMQYCnbRZPuCVFBvqnzi3mMC+nEJW0y/ozKy3ec=; b=
	P8CRbVRvul7OLxKGgfDVpY+qfWaO76HsQ/W1V1/3bXQVcofCBsBziShAWVps8E67
	0JM95SD2yfqbMew5L38naiNwfhBCvE10qKPEkUt4LN5HxQ5x8yYkfcKqzlOcTkdZ
	9LU+tcIdAbZO1u5sn7JzfmOiCfzV7rRNMVjP0YDt0jnY+VjGEdENib8BE2kpRN/h
	Wkms883uPCYw0R3xdoEyHk/1MyjDiK20JIb/dLyEMlekfFDbEmNkDFzY6oKIkXue
	xUux8PDS3QFgF6d7H0qp9NrCF4l7lrwqB9V+9f9iyeMFZDsCyxsfHE6QGpo4wlRE
	cZLJFHQZxuWSG0HVAn5KLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743671764; x=
	1743758164; bh=ffaEaMQYCnbRZPuCVFBvqnzi3mMC+nEJW0y/ozKy3ec=; b=T
	QRg07i5MNzw/kutWqpFT0X+MYljKbczdxJx64mLPEQ8eETuAxQCJd/PV1rL03O9z
	IOrG/VCmpjgsGDeFZBdFSWg9V8h3GUj+jeWe0vw0+BzzZTkbr4u/c3MIxErGuu4p
	CG/zyODZjd5aDd6o5hWXD9csxKoR+13BKPBsS7/2pAjnL2mDyfx92Qc9v7GiMcXV
	CPAytIiCGJsOqBcIcFwAIfGLK0isOabarBUnxGkoyi3WZL+YhhtrbeMbAOJdLwrb
	+uMbQW7dXI7n4R+1YGqwiMBuVjhYfrRVFW9VqNHjQilYdspPfyN79ryux49rXxzK
	T2qp8dNyNGoE7wiAFaLPA==
X-ME-Sender: <xms:1FHuZ32E8aZr4rJdyVLzriTVO3lhVvZ1sJJoXn4NlPwq2PtgU1MHUA>
    <xme:1FHuZ2HTD-P4irpwMxFmqCoNAxErHMQuQHVciDU8RBeptz40r4T7Lw28GsxMfCnW4
    pzjzSovG25_ZWOy>
X-ME-Received: <xmr:1FHuZ35-ctheOQjMaR7g2b0AsizbzD-9UCbXlnZ3LNjNzeNdy1012eXCc7mrJGw4dn1I-t5__b6YBV8STfnkK87BkBy0c18uKIFqNxV1SOmSi-1GSJ65>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvg
    hrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpeehhfejueejleehtdehteefvdfgtdel
    ffeuudejhfehgedufedvhfehueevudeugeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhklhhosh
    esshiivghrvgguihdrhhhupdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtgho
    mhdprhgtphhtthhopehvghhohigrlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsh
    htvghfrghnhhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegvphgvrhgviihmrges
    rhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhm
    rghilhdrtghomhdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomh
X-ME-Proxy: <xmx:1FHuZ817cCuYoiz8md2gCgYBuq4BBobjV_UH0R8JzTgNW0o7r5HgUw>
    <xmx:1FHuZ6GoXrFVpBzivAFJfWuGL4nUlcdRDUh1JP04cbzi2yECvnUxFA>
    <xmx:1FHuZ98OISTdoBI2o-D_fzYeEB5jJQuDPPyzREwvoI-Tq4ZDridtQQ>
    <xmx:1FHuZ3lAoZ-GMWcdO0a8qNu5hUYqX_QAYL0U9oA_D3Q_plOgj1XKGw>
    <xmx:1FHuZxp27_qcISZ-V_J1VASxEcX4yFxCbZLdEmulR1pe88n8Xf7pzpYb>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 05:16:03 -0400 (EDT)
Message-ID: <b1f59622-5d4b-48d5-b153-a8e124979879@bsbernd.com>
Date: Thu, 3 Apr 2025 11:16:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] fuse: Make the fuse_send_one request counter atomic
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 Josef Bacik <josef@toxicpanda.com>
References: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com>
 <20250402-fuse-io-uring-trace-points-v1-1-11b0211fa658@ddn.com>
 <CAJfpegsZmx2f8XVJDNLBYmGd+oAtiov9p9NjpGZ4f9-D_3q_PA@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegsZmx2f8XVJDNLBYmGd+oAtiov9p9NjpGZ4f9-D_3q_PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miklos,

thanks for the quick reply.

On 4/2/25 20:29, Miklos Szeredi wrote:
> On Wed, 2 Apr 2025 at 19:41, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> No need to take lock, we can have that in atomic way.
>> fuse-io-uring and virtiofs especially benefit from it
>> as they don't need the fiq lock at all.
> 
> This is good.
> 
> It would be even better to have per-cpu counters, each initialized to
> a cpuid * FUSE_REQ_ID_STEP and jumping by NR_CPU * FUSE_REQ_ID_STEP.
> 
> Hmm?

/**
 * Get the next unique ID for a request
 */
static inline u64 fuse_get_unique(struct fuse_iqueue *fiq)
{
	int step = FUSE_REQ_ID_STEP * (task_cpu(current) + 1);
	u64 cntr = this_cpu_inc_return(*fiq->reqctr);

	return cntr * step;
}



  passthrough_hp-10113   [028] ...1. 79978.381908: fuse_request_bg_enqueue: connection 43 req 58 opcode 26 (FUSE_INIT) len 0 
  passthrough_hp-10113   [028] ...2. 79978.382032: fuse_request_enqueue: connection 43 req 58 opcode 26 (FUSE_INIT) len 104 
     fuse_worker-10115   [008] ...1. 79978.485348: fuse_request_send: connection 43 req 58 opcode 26 (FUSE_INIT) len 104 
     fuse_worker-10115   [008] ...1. 79978.489948: fuse_request_end: connection 43 req 58 len 80 error 0
              df-10153   [012] ...1. 79981.776173: fuse_request_enqueue: connection 43 req 26 opcode 3 (FUSE_GETATTR) len 56 
    fuse-ring-12-10131   [012] ...1. 79981.776345: fuse_request_send: connection 43 req 26 opcode 3 (FUSE_GETATTR) len 56 
    fuse-ring-12-10131   [012] ...1. 79981.776628: fuse_request_end: connection 43 req 26 len 56 error 0
              df-10153   [012] ...1. 79981.778866: fuse_request_enqueue: connection 43 req 52 opcode 17 (FUSE_STATFS) len 40 
    fuse-ring-12-10131   [012] ...1. 79981.778887: fuse_request_send: connection 43 req 52 opcode 17 (FUSE_STATFS) len 40 
    fuse-ring-12-10131   [012] ...1. 79981.779050: fuse_request_end: connection 43 req 52 len 40 error 0
              ls-10154   [013] ...1. 79986.145078: fuse_request_enqueue: connection 43 req 28 opcode 22 (FUSE_GETXATTR) len 65 
    fuse-ring-13-10132   [013] ...1. 79986.145440: fuse_request_send: connection 43 req 28 opcode 22 (FUSE_GETXATTR) len 65 
    fuse-ring-13-10132   [013] ...1. 79986.146932: fuse_request_end: connection 43 req 28 len 65 error -95
              ls-10154   [013] ...1. 79986.147172: fuse_request_enqueue: connection 43 req 56 opcode 22 (FUSE_GETXATTR) len 72 
    fuse-ring-13-10132   [013] ...1. 79986.147219: fuse_request_send: connection 43 req 56 opcode 22 (FUSE_GETXATTR) len 72 
    fuse-ring-13-10132   [013] ...1. 79986.148048: fuse_request_end: connection 43 req 56 len 72 error -95
              ls-10154   [013] ...1. 79986.152345: fuse_request_enqueue: connection 43 req 84 opcode 27 (FUSE_OPENDIR) len 48 
    fuse-ring-13-10132   [013] ...1. 79986.152385: fuse_request_send: connection 43 req 84 opcode 27 (FUSE_OPENDIR) len 48 
    fuse-ring-13-10132   [013] ...1. 79986.153214: fuse_request_end: connection 43 req 84 len 48 error 0
              ls-10154   [013] ...1. 79986.154291: fuse_request_enqueue: connection 43 req 112 opcode 44 (FUSE_READDIRPLUS) len 80 
    fuse-ring-13-10132   [013] ...1. 79986.154405: fuse_request_send: connection 43 req 112 opcode 44 (FUSE_READDIRPLUS) len 80 
    fuse-ring-13-10132   [013] ...1. 79986.171515: fuse_request_end: connection 43 req 112 len 80 error 0
              ls-10154   [013] ...1. 79986.174221: fuse_request_enqueue: connection 43 req 140 opcode 44 (FUSE_READDIRPLUS) len 80 
    fuse-ring-13-10132   [013] ...1. 79986.174264: fuse_request_send: connection 43 req 140 opcode 44 (FUSE_READDIRPLUS) len 80 
    fuse-ring-13-10132   [013] ...1. 79986.174510: fuse_request_end: connection 43 req 140 len 80 error 0
              ls-10154   [013] ...1. 79986.174739: fuse_request_bg_enqueue: connection 43 req 168 opcode 29 (FUSE_RELEASEDIR) len 0 
    fuse-ring-13-10132   [013] ...1. 79986.179691: fuse_request_send: connection 43 req 168 opcode 29 (FUSE_RELEASEDIR) len 64 
    fuse-ring-13-10132   [013] ...1. 79986.180011: fuse_request_end: connection 43 req 168 len 64 error 0



Slight issue is that request IDs now have quite an up down,
even more than patch 2/4. Ok with you?


Thanks,
Bernd

