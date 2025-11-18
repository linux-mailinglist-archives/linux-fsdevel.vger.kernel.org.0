Return-Path: <linux-fsdevel+bounces-68994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D53C6ADED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 091844EFAFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B433A8D6C;
	Tue, 18 Nov 2025 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVpuhu6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDC3A8D47
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485566; cv=none; b=O0JRfcL+5E86aMrPdduc+jIYCo8GY93ZyF3HIchZaIA/7zCCuvROPoSBH5837ZNZce69hwj55Zt+Lcc4Bn00ls7CuSfWdpW+nOptDDecoUXcGhUsCgbTNO4qjY/x1K28rLDLP0no6SucFtC03ho3Bwx6OY4AW1qTKlL24Szir1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485566; c=relaxed/simple;
	bh=c8iyZOUFGOMLU5rvPBd1mGZsPw8GXHa0miKrdp2Vaiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yq83J+v5yOYsEihnWJaPoaY1z0vhOlULmD894RXgXqBI3phRapHvcL2S9mNmatQzH5vpDSInTkQ9IGfHdoFo3iNJgt8BbXTFlR56ttHuthWUykTokZe48FgTCe1QtfEXJdbjkMqx0BQk9vC1B6O90EZVc5LzptpHLPe0tsO4Oh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVpuhu6m; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477985aea2bso3463455e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 09:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763485563; x=1764090363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4LKFLLmkHOO2YyB1FuGp5QuRpPLnDUvWV5UXKIiXfk=;
        b=jVpuhu6mHg+qDh5QLi/6d5Ipv9fp8gLAjgZTOwowRsPftT0MK64rujI/TxYG9ulxnA
         s0UBzR+WnhH6Uqjj1FTg9TerTRDyyFrBuZI4HTPQi0Cgxb+83x/5KuC6KkubDESPBsAH
         7OJ8xkISiNitkPbKj28XW7irZsEsMhL7iptCKJDi/os+yOTZ41IieDhhIPT8B7j00AIS
         F/nYlacCqvufCDOZMJAEXG5N93JvZNQcz4oYqe901tV68cLFsAmXivAEgdw2LCJjXhf0
         tW3L91HsL+7jCTKtLHWx7QHqJuyLcRbQF3HJyBnEqWbxMRQgeh4qUbvc0PvgFMZGKnUB
         78/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763485563; x=1764090363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4LKFLLmkHOO2YyB1FuGp5QuRpPLnDUvWV5UXKIiXfk=;
        b=SyfI4WjDElN6nrSs+td1Zu0xqfExHXX+Qosl7q/Cs2P95ASJCOMUZznS/11CSSzK1h
         ZjOW75QVgKLS9YvQHocBrSuk6Hs6dTWwkJ5jXL+3rpKkmblJ99/EG029ZRjTSkAwogTF
         nAO5pU/cp/TMWVOe5aonbEHtJRmmfpNlTvowU4GQSFxB6j7MEZhStGqBFM1CaaxLLMiv
         AAlyfVP5UGrHQOAJ4aNdT0kI8H06c5qGY0MerX6743uorNtfAu7tY1HdDo21OMEDT/W9
         7s4ySTCWXas4W51QU8YObgVXLebrVYwYfu9KfO3rdgpuIgst733x0N7ms5lezGc1Wsah
         Wn5g==
X-Forwarded-Encrypted: i=1; AJvYcCWw33wNobQznpmH/IZhi5NTGN79TsOVvGuhU98VoQtw3LX7FlLBdrd39t0UpTuD3J4hOvrtgvsY4MCuFf3h@vger.kernel.org
X-Gm-Message-State: AOJu0YymocJStbWfBxfKOmgrcv0jB0Si7kf6gZX4Rqc/DkfS/GFozArC
	PUbXn6MnAeptwLEaW3cOmmBipVVCTo0GqkrnqXnDgCzojY3inj3vki8P
X-Gm-Gg: ASbGncurAd2WuhyX25K/QpcTZu/9Jei6ctZa/oa3LDEeZrEM07yS3wYlz/fxe2wd0Es
	aOzoCAuhwZiZlJijp/pGc2ymV/rRtTDWgSXIfvJGnaTQN7UwXDzv6EjpwnQnZlj25FQBtOwGPGb
	Mu7heAD1+uE8ndXF/WLqd+RRnO2CkhJefCgOYbUHZY1tvMJumrk7nEsczhgB7uZ/T+AsY8j6r6e
	WbAhmsgcfuYnEJp7de2bnH1jfy675q1iUvkL2DqjH6Dd6L/JGuDrtAx63W2CoYA8hX1Zo8PJTDO
	KLNhYyGPuMIyjxQpTyJBgeBmq7NrtMGUPHfMAUHIrXqBYc4c3OkkhLo9unD2Da6EbwP3I9+C3IB
	QdiYdheUc3L2htZbGjlonUpqkox3xCUec0LgxFAZeUc36au6UiKFakoTyy2EjiE2zdD0snVB1tx
	KD2dTVoHK5/k0rgNQGybQNHHV+0OHeT0Wd47YNh9xn
X-Google-Smtp-Source: AGHT+IEry1hEqU9c+Efos00n6PiUk5jPDLkd+/hqr8m0S/JkYYA1s82T4mTqsPxXSNj4jy8GNkox2A==
X-Received: by 2002:a05:600c:1d26:b0:477:9fd6:7a53 with SMTP id 5b1f17b1804b1-477a9bf23f8mr19857245e9.2.1763485563223;
        Tue, 18 Nov 2025 09:06:03 -0800 (PST)
Received: from [192.168.1.105] ([165.50.73.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm21111345e9.8.2025.11.18.09.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 09:06:02 -0800 (PST)
Message-ID: <86897b3b-23b7-400a-b8d6-4169e78bf5d9@gmail.com>
Date: Tue, 18 Nov 2025 19:05:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/super: fix memory leak of s_fs_info on
 setup_bdev_super failure
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz,
 syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com, frank.li@vivo.com,
 glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, slava@dubeyko.com,
 syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com>
 <20251118145957.GD2441659@ZenIV>
 <6c482108-78b8-4e09-814a-67820a5c021e@gmail.com>
 <20251118163509.GE2441659@ZenIV> <20251118165553.GF2441659@ZenIV>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251118165553.GF2441659@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/25 5:55 PM, Al Viro wrote:
> On Tue, Nov 18, 2025 at 04:35:09PM +0000, Al Viro wrote:
> 


>> For HFS I would expect that hfs_fill_super() would call hfs_mdb_put(sb)
>> on all failures and have it called from subsequent ->put_super() if
>> we succeed and later unmount the filesystem.  That seems to be where
>> ->s_fs_info is taken out of superblock and freed.
>>
>> What do you observe getting leaked and in which case does that happen?
Sorry for my other late reply. My thunderbird client had some issues and 
got delayed and seperated emails somehow...
> 
> AFAICS, the problem is with aca740cecbe5 "fs: open block device after superblock
> creation" where you get a failure exit stuck between getting a new superblock
> from sget_fc() and calling fill_super().
> 

Yes this is what I mentionned in my earlier mail.(not the commit causing 
the issue though).
> That is where the gap has been introduced.  I see two possible solutions:
> one is to have failure of setup_bdev_super() (and only it) steal ->s_fs_info
> back, on the theory that filesystem didn't have a chance to do anything
> yet.  Another is to move the call of hfs_mdb_put() from failure exits of
> hfs_fill_super() *and* from hfs_put_super() into hfs_kill_sb(), that
> would do that:
> 
> 	generic_shutdown_super(sb);
> 	hfs_mdb_put(sb);
> 	if (sb->s_bdev) {
> 		sync_blockdev(sb->s_bdev);
> 		bdev_fput(sb->s_bdev_file);
> 	}

I will do the second approach, test it send it for review shortly.

Best regards,
Mehdi Ben Hadj Khelifa




