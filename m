Return-Path: <linux-fsdevel+bounces-20546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF568D5081
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 19:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BBF2B20E4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5BB41A94;
	Thu, 30 May 2024 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="bx4wQV0J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PdKE6HW/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C42E832
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088831; cv=none; b=FYJxy8WBH2mqPohy6D6UqYhXQZbDEQ+wjgpz3LRwhediv/3YvQdEDn6ciS83RIRtd3nzuWncuHrs1isadjAerlgJI0xsy/ojwbmoEjFYIMTddvuPn91uMLcq5GJx1p1MjSsENwbhAODvyfRSZXBk86Q2BP4ZlQYt4e5fHlgNJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088831; c=relaxed/simple;
	bh=Pze4JWmgktlZhIcEkdHDHpuJDqL8JuzL0NdU4OpZ/OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcJBRLTZtudQGdgVZn6SHouYRlEOsYvYf+BU2Ilx0ZmXp1Nxdz3yh0Wp3sC3rdnipKUPX/pVoxB3LqthqokgwXoSnvsUSwCAbMcAfAQnIRPoTCDgPbozcLhUImsvd0nfVYEEVKWNs2h8h43fLMdQ4elhV5kYfcxVETsO964P63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=bx4wQV0J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PdKE6HW/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E352411400D8;
	Thu, 30 May 2024 13:07:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 30 May 2024 13:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717088828;
	 x=1717175228; bh=Uct+wQBF1Nd5cFfdDzVj2Wu2zqXPNu0gAhOFt/0aWdQ=; b=
	bx4wQV0JV5VoKEzoEzND12Ol9u/8vUX1eQGEeFRm58iaHZ9P27Qj+UB5PiMsesfR
	w0kK9+2vlH7hx2CJ52P+aCY6ZEQsk8Tc+lWFW5qVFE9N+4CsHFDeenMWOGjA59Xg
	ncuWrWBgpegVyiKg88atb3A08Im3E6ntwvZL998jOHmRgVBIecJT2a0/q8ri4Mzg
	yG8oT2q+q4OTYnv6IC3BCaXwC2D+eNXOZakSzDs23GGFJ4gc7ElLZxw0MFhXyJwX
	7EMXLkj8Pu/tPJcsuXezdCrr7hSouDf7q/DjCLjK4c2tMVxauIzcq6tqLsRW9k80
	RqzE+pEvSXJ9idLaE36fqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717088828; x=
	1717175228; bh=Uct+wQBF1Nd5cFfdDzVj2Wu2zqXPNu0gAhOFt/0aWdQ=; b=P
	dKE6HW/kQtnvVasfAzPaKW2QSAVkkKMglWNf6zEMhvjC/joaE6SGOeGColuUZazT
	xyeqdjaRSC8O7QGnfIx/7aXIvElY2i0ZJA211kbR90JCaTqS2QcUe3mElHtmkxzo
	hi/68Mgd3s4Y3nCvDnHckafGFCv8vg7k2Xqevcm5E899QWV62TPU/dhZNIr0/W/d
	BKf9JTBAcOhN3/pFcro2nmim76vWEjCkVzc7wI93R3T5X+eBUoaN+2TdD2KTXvT7
	7hWuK7cj+24AHUl9KQfpsH/S8aa4HSu+sr9DyWcItQvxvHR8M/Wb1GvHXHAh4xDo
	oxzYXUM4EqaawT7slp2VA==
X-ME-Sender: <xms:O7JYZng_XRwG8SronX-03PQggVh9RhnfkF_V8Ld1aCWjve2ryvrWQw>
    <xme:O7JYZkDyT7UTYiguvtk0zdwtHsQ2NAa-rRpiXocVNUC07nH5442YmCS8qjnhgpA9T
    C1P9qTyVGO4bGeb>
X-ME-Received: <xmr:O7JYZnH9D9Fnr43IxXGSefVYg-dX1zjBpX5Q8VTEVxkSriHUda5ljw3ybVmq14F_gO5w6cPAzMkaAQMxYJEz1kww4nXz6KYgHX0py8KzzlYPCdsqIh_i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeei
    veejieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:PLJYZkTbkUhEGwSr5ZmfbnfWCTu6gMQ19pW5_bTK9erX-SlUmjR_rQ>
    <xmx:PLJYZkw4DUjZFkrwSePZVUIOnZICjdmiBP0-iJewdk7H_ADS2gY-bA>
    <xmx:PLJYZq7cK90p3JlDIg_Bf2D156yXy4LCpD0g7pSm7Iu5h65UirK9nQ>
    <xmx:PLJYZpzb9lrlJPfj17AQJu4rJW4CNW3sN3dLYn7nPkpzCPRQzYDWqQ>
    <xmx:PLJYZgdVpIhanX5ADSVAtIJ7ET8lLfE3fDC2eYACDl09bTkVq_wsXJsg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 13:07:06 -0400 (EDT)
Message-ID: <f15f8e34-7440-4dd6-b1b5-720c618aeff4@fastmail.fm>
Date: Thu, 30 May 2024 19:07:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
To: Miklos Szeredi <miklos@szeredi.hu>, Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
 Peter-Jan Gootzen <pgootzen@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yoray Zack <yorayz@nvidia.com>,
 Vivek Goyal <vgoyal@redhat.com>, virtualization@lists.linux.dev
References: <20240529155210.2543295-1-mszeredi@redhat.com>
 <af09b5d3-940f-491d-97ba-bd3bf19b750a@linux.alibaba.com>
 <CAJfpeguV0dNiyR5jzQH7H4x0vOzFTcBgnnLDHBPU9fH23A0kng@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpeguV0dNiyR5jzQH7H4x0vOzFTcBgnnLDHBPU9fH23A0kng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 11:00, Miklos Szeredi wrote:
> On Thu, 30 May 2024 at 05:20, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>>> +             if (test_bit(FR_FINISHED, &req->flags)) {
>>> +                     list_del_init(&req->intr_entry);
>>> +                     spin_unlock(&fiq->lock                  ^
>>                 missing "return" here?
> 
> Well spotted.  Thanks.
> 
>>> -             err = -ENODEV;
>>> -             spin_unlock(&fiq->lock);
>>> -             fuse_put_request(req);
>>> -     }
>>> +     fuse_send_one(fiq, req);
>>>
>>> -     return err;
>>> +     return 0;
>>>  }
>>
>> There's a minor changed behavior visible to users.  Prior to the patch,
>> the FUSE_NOTIFY_RETRIEVE will returns -ENODEV when the connection is
>> aborted, but now it returns 0.
>>
>> It seems only example/notify_store_retrieve.c has used
>> FUSE_NOTIFY_RETRIEVE in libfuse.  I'm not sure if this change really
>> matters.
> 
> It will return -ENOTCONN from  fuse_simple_notify_reply() ->
> fuse_get_req().  The -ENODEV would be a very short transient error
> during the abort, so it doesn't matter.

example/notify_store_retrieve and example/notify_inval_inode actually
get EBADF on umount. Issue is that FUSE_DESTROY is sent very late only,
but inodes already released. If server side sends a notification in the
wrong moment, it gets EBADF. We would need something like
FUSE_PREPARE_DESTROY that is being send when umount processing starts to
stop notifications. I'm not sure if that exists in the VFS and didn't
have time yet to check.


Thanks,
Bernd

