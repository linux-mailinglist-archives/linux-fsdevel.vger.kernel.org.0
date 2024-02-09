Return-Path: <linux-fsdevel+bounces-10931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A45DE84F48A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A45CB2BB01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89AD31A81;
	Fri,  9 Feb 2024 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="I0jbW6Sm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+Km/FkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680EE2E834
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477717; cv=none; b=b7z8ANU13xAKHHT364rWFv4H+eenKL7PN/zmkg9UoH4yk1G1tOcg1ZCsORvXkYC4wOsuGnrzUurnwiwXrhpVdaqL6kpm7YXjkIKi2luCJymYxHYJ3BpweiIegSAA7qIbBAAVJjfH+pDQ5HePbMEHL2YWzD4Zz6mms9svXg5JJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477717; c=relaxed/simple;
	bh=0UFpr/aw56ok0VlDuU9hBAcxGM+NC3zcZkGwUH4A1Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PW7O/+LOpmNsM7OvTwsY6xznovCAp1+r5zy4+cvkFT4/Z1VNYsAaglum0zipD91xfah4sEt2/bwahBmOjoDK/fwY4q+m13IbwfdhA2JVcr53i38ow1OQDI1EFmDdjv27En5Ylo+J9tC79E+DcLw79BvFDc6+ccOBnBB0xf+F994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=I0jbW6Sm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X+Km/FkO; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 1A41D3200A1F;
	Fri,  9 Feb 2024 06:21:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 09 Feb 2024 06:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707477713;
	 x=1707564113; bh=g0YTe/2o/KwwGrnzah1IL6nM916gx5N0k6HDOcEAucg=; b=
	I0jbW6SmCFZT0dVzo0IU5Lv2lRYNzsCJ1JI9auGAVCNd+1TZEamIUoPVsJXMvrOi
	1ZDnih5pDEmNN7X1kJImqSPj5GJeu0a2tT/6k1zZ+XFgu6TzTe9buM9e1A6FVLCV
	fqtKUM9VVYghg1ZeN4PBg6E4R4cj7MHVSEjfRd4FeWI86nMP1iQjk79kXYBKjXpT
	caHs4O6HcZo+zclY+drp37f3ZfpuN70EP0ehq3YqahqXVSC63x8UQdY3i/dtd0qG
	7ehqnUxZwpi/Wzz9r91EtY1299YVsWvX2aWDHw88k8RV2crzo5TRK+IOAnpvAq+w
	CfO3+t9CD/qfDZHc9QUKaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707477713; x=
	1707564113; bh=g0YTe/2o/KwwGrnzah1IL6nM916gx5N0k6HDOcEAucg=; b=X
	+Km/FkOAUnTlwAR1EYnTk41WhJEBTwhKmjzWeOeIHBdpzw07rO7BKu2JMyItp/rX
	Qm+UUFICZwXB2Alpp33WvRIphf8fGQvtdYncQEmEp+bevzbeNvFiRLSK+14Md+aX
	mX+Irv6S5m/qBEuDAC+4Fl9gUVAHDZ4LpDtO6h2Xk3LP37yo7eeHnR+aGw3gDmOL
	9MsHUN/535TnuH74DsvFapjTTCi8cKXaDO3YevltnCgZyNw3mfoarAFp+DyoeC7f
	fueneVMxsZJbWZVr6VBvQyQoJagdTgEc6OzrcrVMBww4GGrqU2OGVpmBV66AFdQQ
	Jtcgjcu6czHmSv8NAYQHw==
X-ME-Sender: <xms:0QrGZevdV21l3A4M7V6tOzbjTNwcnlFBs6YoMYJLKUA_pO3MJr7k2g>
    <xme:0QrGZTe7ZCaxEyH_IyKz3FKWVkxtqMD4Oix6RQL2Dbuw_9YGbX38jH_IQMEoMVdPC
    8s80c88n-9rS-LA>
X-ME-Received: <xmr:0QrGZZx4KxkMxoGcH2YK6lsDVTeIrcF4D-W-f8BGZIEw5ZGM2vqi5ieruuVeKYowfnqjZpoB0WBd1-hojo-NQS3N-P2HtvDUKkU-HlhZvIARk-MlXHJ2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:0QrGZZPukYKXlsLhFBxtOK9dy99ei0th17w0hBPC-E5gP0FecleQlg>
    <xmx:0QrGZe9qQlopO2ZcA9UQ4q3JAaC4K4VJEz7wwDs90xR4eMPPv-9pYA>
    <xmx:0QrGZRXelHEwjLDO6LNwVAi7fCet5AXh-ad6HFWv2BNmfZf_ArwSmw>
    <xmx:0QrGZQJHUIWgh4t1i3gKb6Xutzv_tRZZ-QhQYEVsKq5ln4SZOEXyiQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 06:21:52 -0500 (EST)
Message-ID: <1be6f498-2d56-4c19-9f93-0678ad76e775@fastmail.fm>
Date: Fri, 9 Feb 2024 12:21:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] fuse: allow parallel dio writes with
 FUSE_DIRECT_IO_ALLOW_MMAP
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
References: <20240208170603.2078871-1-amir73il@gmail.com>
 <20240208170603.2078871-10-amir73il@gmail.com>
 <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/9/24 11:50, Miklos Szeredi wrote:
> On Thu, 8 Feb 2024 at 18:09, Amir Goldstein <amir73il@gmail.com> wrote:
> 
>>  static int fuse_inode_get_io_cache(struct fuse_inode *fi)
>>  {
>> +       int err = 0;
>> +
>>         assert_spin_locked(&fi->lock);
>> -       if (fi->iocachectr < 0)
>> -               return -ETXTBSY;
>> -       if (fi->iocachectr++ == 0)
>> -               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>> -       return 0;
>> +       /*
>> +        * Setting the bit advises new direct-io writes to use an exclusive
>> +        * lock - without it the wait below might be forever.
>> +        */
>> +       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>> +       while (!err && fuse_is_io_cache_wait(fi)) {
>> +               spin_unlock(&fi->lock);
>> +               err = wait_event_killable(fi->direct_io_waitq,
>> +                                         !fuse_is_io_cache_wait(fi));
>> +               spin_lock(&fi->lock);
>> +       }
>> +       /*
>> +        * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if we
>> +        * failed to enter caching mode and no other caching open exists.
>> +        */
>> +       if (!err)
>> +               fi->iocachectr++;
>> +       else if (fi->iocachectr <= 0)
>> +               clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> 
> This seems wrong:  if the current task is killed, and there's anther
> task trying to get cached open mode, then clearing
> FUSE_I_CACHE_IO_MODE will allow new parallel writes, breaking this
> logic.

This is called holding a spin lock, another task cannot enter here?
Neither can direct-IO, because it is also locked out. The bit helps DIO
code to avoid trying to do parallel DIO without the need to take a spin
lock. When DIO decides it wants to do parallel IO, it first has to get
past fi->iocachectr < 0 - if there is another task trying to do cache
IO, either DIO gets < 0 first and the other cache task has to wait, or
cache tasks gets > 0 and dio will continue with the exclusive lock. Or
do I miss something?


> 
> I'd suggest fixing this by not making the wait killable.  It's just a
> nice to have, but without all the other waits being killable (e.g.
> filesystem locks) it's just a drop in the ocean.


Thanks,
Bernd

