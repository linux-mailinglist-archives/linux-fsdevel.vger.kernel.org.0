Return-Path: <linux-fsdevel+bounces-68951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E424FC6A4E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35EA34E8FC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D523364024;
	Tue, 18 Nov 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM+HfwLi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB03559FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479342; cv=none; b=g/xuSWTuWtSUsd9Nj0CC+QE7qlEMEDoOmsWN1v8G5ECa4x94K1MIEqyGrtqqL8/cdSkzw9r3mhOYMLzfienc5zXlI3/yCZPbVOrt2Tiigvx4TWnQMoV1CoSWPJaumz9ZPGVfYfpPwHYwuQNpd6z005IGIcauzGICyxs9AGwWEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479342; c=relaxed/simple;
	bh=pIX1ASwg7OhBsi3EZ3XfrBnxCe6n/AJc03zsxsrHwP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9mi7NfjyL9qgXnop2h9gu7OCOi8iEPmmy8E0OnjgGuPUJbtTPUWXxdhvIDh1AVyUNiw3nE0YYD9hW+CAJO1O27TjoIT8xCDhifTHXEI/4Rz4OJkJH1//8PJvxkbubcgvF58COkZpy7i5gQ4qUiCGX5KTH/a87Xkong6ecxwNyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM+HfwLi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477782a42a8so3822085e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 07:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763479339; x=1764084139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00wCf0bwjC2Ib9qVy8nbg3pTPrjzk9HywzDkbpGaRDY=;
        b=PM+HfwLiPbU2+zR5eXYlkj9L4Oco2jVRXiJhj+WzE2/E6GXJnQpPiqVe42p0wtbAvy
         qIZ5GAKt5B3QUTMXon89q7eqIULta7YwRX2DVRY6Sh+9ZtEUSTFSj2/p90UasDho7giR
         rHnYIfj8KlK2Y1IIt6ve8K4cEfdXw17xkgBE1TgIaKMITb8D8PYn99Jym/7i1aBg6vOR
         zX+UcsAczajZM+V94AbPDjDwn4eWDCGUdCoXNQdev8wI3KOzxyMlZ5FzYWbxvDm/aMJl
         0dipssG/7W3loY2zzI2PtGnm11LKlOBrnUKoFjOS46f/1b1UEFtt8q/tuUP+J670or9h
         DAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763479339; x=1764084139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00wCf0bwjC2Ib9qVy8nbg3pTPrjzk9HywzDkbpGaRDY=;
        b=cSOxbjhAsBC5VHkO7iLLYaFnj0xRJORMd1YnI9I5DMVuQ/9PBz1vJyHzmAVSqdKk40
         RUwE8xZME0ltfCz/tkUsN3XdPIOYpFtanZyOo94d9KVdB5+jYh0hGlKjAEJpUVljXHFT
         u9SzF/4OFxwbXo/zrb/np9lOo6tEJEjxk9Qh0i3X5NqWd8xdTRD0Z4iYVR2ziUPuVY13
         n9cbRGnk9woVhL9TNyXZQtdU5TefjFlDTBzVUqUHmTxrW0eTVpK1oMs914MCQYXK9eL1
         y/OYMRsbRHuxm33290GOIG4bO0jJM+h/613PPAG76gABvc/CmGbS5lnCzpDy4qWNK6cl
         ROPw==
X-Forwarded-Encrypted: i=1; AJvYcCVYE6FQoQtUdVUKnuOjOaX+NFNPEuMfkZy+sSd1LYaDSq7k3Lxgd4TzBlj7fctDZxy0dKvef8jTw2o/tkIK@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTTXkNpcN5pVQIQsIb/pMnijnkQ8CLKhMWi/NEjlifUYPhZ+E
	9IfxaD7P5RjRxSizfmDmgfT8ElUJ2RvH/if+6oOSKCtHA92m15JZbuQg
X-Gm-Gg: ASbGncvxvFVbo0KLozVMon4m8X51lhBEiMJ8itwoBE4ikssPLLF73AIoyFI52VSbCDT
	koGfT2OmYC9+M3NpP5qb1NueWzPVGZHCxyk/HOEuRhH3HxwmVYsVqT16nkkODtcujKsEAKJS86R
	LQW+Zx5c3Da5unjVHY1Brsa0YpuYCD+PUDbk17KFIUA49hibU6JANS5rUJrsMpne/S/k47ODkwK
	FekeqFsX63nU01T8zFY3UQ7StZrLE2MWyd8qAhHMU0MZz+Sf1xiAPg86kMlo5aLPU/PceSfy/4X
	mli4FDA07z3JmYnhYO2S4HHmf4nizZjhs0hu53iBjrnkPeXPGxU+l/cXbO/CkGCIEWi8Iwfk+wM
	SROi4Q6C+UTVAlbC9iRQYBGnXRJppjfax2zLb+8DREII+M4C7taEo/43P4YQjXIArorPk+5kg5o
	Jpk1xDBdWm5nDjavQZuBc=
X-Google-Smtp-Source: AGHT+IE6FmLDcglT4gILuNBc5RTAP0dPVN+aT7yWU1j9JzA4iMRVSgkf9aSmY0C/KZIkLhmEkiHEHA==
X-Received: by 2002:a05:600c:1c1f:b0:477:a478:3f94 with SMTP id 5b1f17b1804b1-477a9c3c5efmr19525875e9.5.1763479339217;
        Tue, 18 Nov 2025 07:22:19 -0800 (PST)
Received: from [192.168.1.105] ([165.50.73.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779920f2cdsm228071925e9.10.2025.11.18.07.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 07:22:18 -0800 (PST)
Message-ID: <6c482108-78b8-4e09-814a-67820a5c021e@gmail.com>
Date: Tue, 18 Nov 2025 17:21:59 +0100
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
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251118145957.GD2441659@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/25 3:59 PM, Al Viro wrote:
> On Fri, Nov 14, 2025 at 05:52:27PM +0100, Mehdi Ben Hadj Khelifa wrote:
>> Failure in setup_bdev_super() triggers an error path where
>> fc->s_fs_info ownership has already been transferred to the superblock via
>> sget_fc() call in get_tree_bdev_flags() and calling put_fs_context() in
>> do_new_mount() to free the s_fs_info for the specific filesystem gets
>> passed in a NULL pointer.
>>
>> Pass back the ownership of the s_fs_info pointer to the filesystem context
>> once the error path has been triggered to be cleaned up gracefully in
>> put_fs_context().
>>
>> Fixes: cb50b348c71f ("convenience helpers: vfs_get_super() and sget_fc()")
>> Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>> Note:This patch might need some more testing as I only did run selftests
>> with no regression, check dmesg output for no regression, run reproducer
>> with no bug.
> 
> Almost certainly bogus; quite a few fill_super() callbacks seriously count
> upon "->kill_sb() will take care care of cleanup if we return an error".

So should I then free the allocated s_fs_info in the kill_block_super 
instead and check for the null pointer in put_fs_context to not execute 
kfree in subsequent call to hfs_free_fc()?

Because the error generated in setup_bdev_super() when returned to 
do_new_mount() (after a lot of error propagation) it doesn't get handled:	
	if (!err)
		err = do_new_mount_fc(fc, path, mnt_flags);
	put_fs_context(fc);
	return err;

Also doesn't get handled anywhere in the call stack after IIUC:

In path_mount:
	return do_new_mount(path, type_page, sb_flags, mnt_flags, dev_name,
			    data_page);

In do_mount:
	return path_mount(dev_name, &path, type_page, flags, data_page);

So what is recommended in this case ?

Best Regards,
Mehdi Ben Hadj Khelifa

