Return-Path: <linux-fsdevel+bounces-10940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1008984F4D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EE228C998
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2362E84F;
	Fri,  9 Feb 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="kk4YB3LC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sx1UmmJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005382E821
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479288; cv=none; b=L7FlzbXT1pGp91yvqHZaoY62qFzz7hrly3ECPpr1lGzxLm1iARknaTREChm/8jIQYPpHCfBfMlXaG7KxcROPb/RrcFpXK+YBJHW/txa3IQG4MpRLrtTzMexgDqSG2BlPafgqQu6I5j0PyxiJ6BCIhT3uYVB0Uotq0iFGjhLHQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479288; c=relaxed/simple;
	bh=NFAgzTV/pCc9pwS5djqKfejxxgrFg52+gnz9vYbwDug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krGSQWHqQK1GytySQrwUGEqUDQaS3nMgtH33qa+uynxUgyoWCQpHI0Fzk6RH0/8Znl8Yu6AyBL9JWyBpOe4cbgqSr/CQJLysNjMTDIfhOfYvD09Z2g0KyOzs36AkcIKr/jAQybIshtDf3AvFWxcRCb9IqNr0oTWJKkmmOZualxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=kk4YB3LC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sx1UmmJl; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id A3E123200AFA;
	Fri,  9 Feb 2024 06:48:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 09 Feb 2024 06:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707479285;
	 x=1707565685; bh=2G/9345amfKEIoEsMPnBDm3W58I07RtAvo6wBGvkhHE=; b=
	kk4YB3LCCfyBqbMMzZ9PhZOkb98TEmckUe09SqP/LO0lFBEudU8oMni9pbKNtliP
	yTxj/LI9G8GJTzEhJ4U2zZ7emWNt0kCN2IC1IBig92UJBU/S7L7WNh+FE0avDfaj
	LFxtPQ1estQxELumA50WHbDDePFHFYALhVN9aBauGz9OH1mLgf6aNRLAte5Zmrld
	sA0ui71ajXSSPJ+xlBkijBhHF6LrQYkq64N+1GjbWFsOfnBXwtZvF2ao9y39cusr
	v6JNgmUrM/ZA+zZCz4wbdPMFLLVUxWKPH349+VKURDx4boi8/bkYoDSmcntysJ0z
	m0JZM8IvznI+l57mk4YCpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707479285; x=
	1707565685; bh=2G/9345amfKEIoEsMPnBDm3W58I07RtAvo6wBGvkhHE=; b=s
	x1UmmJld213rT/Fe/LOtDv5VgeVOJS+qtY2Fhlxym0wUG+tQ7uTKp0mHWTThOO/M
	6K7QdQmaxBKGRAOIKAGt8vOARhHYNBHUG3gV/TSQnjEqCUM/3H4X0xr4UeQpQb75
	iCdhgCZTcM2snqXVr6Ua2kf5x25kZMiXU7nGLIB3rIzH10cmOha+Hgyiv6D8CjgK
	IrldQcgXqSxJLU2Z8Rylblewpll+z6pv/wz7IQEt3QQxCMmUtAqAJu9sStrvcwk/
	y2PmNBQ9xDPaOFqYqphZM20tHtOxQAFPwxwvyC/dnRDnALvjPCENjSy5oW8kPpwQ
	KRJWjxrDo8eiXwntPcP4A==
X-ME-Sender: <xms:9BDGZbptD7SY7bkhh2MVUTD959YkjpchbpQy_GmOOs6Q8lrS_OZilQ>
    <xme:9BDGZVrwlELI_uDXtDBOlB4TphroD2UzNMda4t7pY5ivAaImH7e3dWC53pjAoqaQ5
    Xxa42ggd_6iSFMx>
X-ME-Received: <xmr:9BDGZYOKs79bS6ivZAfquJ26fMKBlZLODN4o4Ng936bU8VCArEAC0HxT_WPxjWNw7k5caVD-bj8f8GliTeKMwSepHLj6Nf_td_OxbHg1VzSPQzAR6buY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:9BDGZe4Xi30m4Vd4qXyYyJBx3idSbKB0k1BbTSotJX6JyO-TCozIUQ>
    <xmx:9BDGZa7IZBvbVlyAayDP7YlL3OS8nR3GWhSBku4_YCZRNb_HgFtSSw>
    <xmx:9BDGZWhihJtrCt8NZWjLfzDc2VxXkUcv5DC2aewQkqcVFligWTIhhw>
    <xmx:9RDGZaH9kvDnZdvm-yKDstkgroLv-ZLHTqDxeVpJZvu5z-iKL65gxA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 06:48:04 -0500 (EST)
Message-ID: <f44c0101-0016-4f82-a02d-0dcfefbf4e96@fastmail.fm>
Date: Fri, 9 Feb 2024 12:48:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] fuse: allow parallel dio writes with
 FUSE_DIRECT_IO_ALLOW_MMAP
Content-Language: en-US, de-DE, fr
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
References: <20240208170603.2078871-1-amir73il@gmail.com>
 <20240208170603.2078871-10-amir73il@gmail.com>
 <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
 <1be6f498-2d56-4c19-9f93-0678ad76e775@fastmail.fm>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <1be6f498-2d56-4c19-9f93-0678ad76e775@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/9/24 12:21, Bernd Schubert wrote:
> 
> 
> On 2/9/24 11:50, Miklos Szeredi wrote:
>> On Thu, 8 Feb 2024 at 18:09, Amir Goldstein <amir73il@gmail.com> wrote:
>>
>>>  static int fuse_inode_get_io_cache(struct fuse_inode *fi)
>>>  {
>>> +       int err = 0;
>>> +
>>>         assert_spin_locked(&fi->lock);
>>> -       if (fi->iocachectr < 0)
>>> -               return -ETXTBSY;
>>> -       if (fi->iocachectr++ == 0)
>>> -               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>>> -       return 0;
>>> +       /*
>>> +        * Setting the bit advises new direct-io writes to use an exclusive
>>> +        * lock - without it the wait below might be forever.
>>> +        */
>>> +       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>>> +       while (!err && fuse_is_io_cache_wait(fi)) {
>>> +               spin_unlock(&fi->lock);
>>> +               err = wait_event_killable(fi->direct_io_waitq,
>>> +                                         !fuse_is_io_cache_wait(fi));
>>> +               spin_lock(&fi->lock);
>>> +       }
>>> +       /*
>>> +        * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if we
>>> +        * failed to enter caching mode and no other caching open exists.
>>> +        */
>>> +       if (!err)
>>> +               fi->iocachectr++;
>>> +       else if (fi->iocachectr <= 0)
>>> +               clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>>
>> This seems wrong:  if the current task is killed, and there's anther
>> task trying to get cached open mode, then clearing
>> FUSE_I_CACHE_IO_MODE will allow new parallel writes, breaking this
>> logic.
> 
> This is called holding a spin lock, another task cannot enter here?
> Neither can direct-IO, because it is also locked out. The bit helps DIO
> code to avoid trying to do parallel DIO without the need to take a spin
> lock. When DIO decides it wants to do parallel IO, it first has to get
> past fi->iocachectr < 0 - if there is another task trying to do cache
> IO, either DIO gets < 0 first and the other cache task has to wait, or
> cache tasks gets > 0 and dio will continue with the exclusive lock. Or
> do I miss something?

Now I see what you mean, there is an unlock and another task might have also already set the bit

I think this should do

diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index acd0833ae873..7c22edd674cb 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -41,6 +41,8 @@ static int fuse_inode_get_io_cache(struct fuse_inode *fi)
                err = wait_event_killable(fi->direct_io_waitq,
                                          !fuse_is_io_cache_wait(fi));
                spin_lock(&fi->lock);
+               if (!err)
+			/* Another interrupted task might have unset it */
+                       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
        }
        /*
         * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if we

