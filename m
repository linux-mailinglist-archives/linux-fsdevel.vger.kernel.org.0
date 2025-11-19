Return-Path: <linux-fsdevel+bounces-69114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD598C6FAD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 16:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9987834B8EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE6C364028;
	Wed, 19 Nov 2025 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbR7yRWD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8293364049
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566071; cv=none; b=PGvEAkDYB9OEk6Y7iL0CJzAE18HOAsOVdvwBup5HTrXSp1hhwJj8trr40/nCww2Mn1EINVSgLRHgGMd27+OL1z4RTKhuHW5Oe4XI5aYtW6AWXOU1AAjf8lxSp4cMFnYojx1zVo+3r6qHPJ5Uvi8fQIQsvXOYOthXJcWY6QMAZ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566071; c=relaxed/simple;
	bh=zc0c92v94+c39p1GxVGMWNJwmp8GnlSUT+L0SN1NYIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fL0DTnr71Wx0DeDvKnw8giiPdS1CQuVXzSnXAEoIqObQWnbsTwI1oIKnxYsJHGlnl0sS+//3tNb0csKqt/4xDgAxa7OJ6h5XcrY9LPO5xDVpJ0ZBV822+uJeQYozcWCdrbxewaDRKdlDRdYkOiTIWSdiaam7iA7CnAvrnkaOCEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbR7yRWD; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b2dd19681so813756f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 07:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763566067; x=1764170867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8koxPyuC5jyMlaKzeByoi15oYsrGRaCW8yGrTb2Etg4=;
        b=HbR7yRWDlc5kdRnpKpX9sM6D6Hq3mzy/e4V8iNo19PRl4pDHxAJ49iOBA/buMbkQW4
         YSuC1eMZ6oKsvs5lVMjZbqiOaxCHU/vfXzfMA6GH66JtC4nF1LO8yglmacMykU4m1Pq0
         Ld3VnXnKd8vS73B3vfG1HNpGmswHAyPtVG6/vJvnh71qtKp2iuQbTwfXId6+3N9sFWuZ
         ls6QA/Ry/1NYByZqQVcmvj0PU0ZwIxVO2/hiYS5Mys3giBNaYUiAq+T8ReQEGDkEs5aG
         HWsIK7pK+zvJ8YKcxJIkobkmFyQ2VcAlCnwQa91+WuR9w77oq1E/ZOuz5ST+2XSmeta9
         SOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763566067; x=1764170867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8koxPyuC5jyMlaKzeByoi15oYsrGRaCW8yGrTb2Etg4=;
        b=swmwzEwZD7aYD3HjZtgyZAE1PWO+MhIBiDCoQ4dKdNhy8tJTJuA+3GN/wDgAQWcWH0
         fspqIi3prqk8qn2q/5FM+sdlM+bqG2nVa1I87oemnUMWJxe0U1oudxLcvgihyYbrE3KC
         OF9aTy1sAIDBYny3z/thv7Zt2ygpiUfMNb7KAUdPnHXHT0LuWmTA8zCt9tflJVumFRMr
         7Fd/5tWFfAT+qskNaSta2X+SJSzThNiAEfiD9JoMFmYLVhWOjUkmruGJiaHjaBes4qjR
         VVvb8lHcSSqwJdtPsIwmANrtpw0SZTV7Vnrkw3B2sQtUAxOGxzpDGJ6rfasrv3SzFFum
         KE4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtqZJEQZCZPuWaMzvYssf++PeQI0fYojLdCOi1x8wPpj1StnomfRkGqYl//7bONhvlEtxFuu9Uq8Wy/bXg@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnkJcSTKr8ZqL8t5UGp/IX4iIt+Gh84nuWt7FfeZiNMRJhsoa
	jNqR6lFaxsqe96DChrV0iSrtN+3kLDNQJbl495k2krjMK/3hQCruRc08
X-Gm-Gg: ASbGnctBqz6Od+Rtl1R2m26A2GE3bntsVUTjQLjJbDNjh+mJsUO0kCbOS7fWAq1llhb
	GRzIfuUqRO7h5OwtRGCNZIvh+lCeTBkS/FjMIppw2JStk3vbt72hdHrZ31QluM4fytf+YHMW/Cm
	EmWuMVpRp3Aq0kirlKwglcTUFz8A56daOCJ6xUayy0qw9HnZSxS26YND3bgiyul+HNrEjxRyK9e
	yxGhqCcoPHlsU2ujgA8ap/4SrkrfPLUaI06Ik5bfBmb1SEAsMXE4/36WnZXMkz5wkgXt7JQ7yRw
	Fkwc0DIHpaGCqZFml9j1UJsg/VD1Rh8WbrmWHXUHDJyywXhS0OPsFiztt3RfMyfDI25wE9lieJx
	qNGOeyxoldt11/RNq/0mY6tjl+gbI2vSrpwb1PKexainew7cQpBq0p2OnFTUXPhpaZclGMEQ+bZ
	qh6QBBzMUGCQo8fw0ALaVDjuOozEWlVus=
X-Google-Smtp-Source: AGHT+IGmcs/ijfQpxwyqnmCNTQIUwm9J8y0zVTa9t7azKCtRyKlkdqKG6wKiny9IvR5MH+HFqGC4kQ==
X-Received: by 2002:a05:6000:4010:b0:42b:3ad7:fdbb with SMTP id ffacd0b85a97d-42caa05f14bmr4061111f8f.3.1763566066814;
        Wed, 19 Nov 2025 07:27:46 -0800 (PST)
Received: from [192.168.1.111] ([165.50.116.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae16sm38958846f8f.3.2025.11.19.07.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 07:27:46 -0800 (PST)
Message-ID: <dc78b78d-14fc-456d-ae21-e79225b77afa@gmail.com>
Date: Wed, 19 Nov 2025 16:27:47 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
To: Christian Brauner <brauner@kernel.org>
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 jack@suse.cz, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
 <20251119-delfin-bioladen-6bf291941d4f@brauner>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251119-delfin-bioladen-6bf291941d4f@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 3:14 PM, Christian Brauner wrote:
> On Wed, Nov 19, 2025 at 08:38:20AM +0100, Mehdi Ben Hadj Khelifa wrote:
>> The regression introduced by commit aca740cecbe5 ("fs: open block device
>> after superblock creation") allows setup_bdev_super() to fail after a new
>> superblock has been allocated by sget_fc(), but before hfs_fill_super()
>> takes ownership of the filesystem-specific s_fs_info data.
>>
>> In that case, hfs_put_super() and the failure paths of hfs_fill_super()
>> are never reached, leaving the HFS mdb structures attached to s->s_fs_info
>> unreleased.The default kill_block_super() teardown also does not free
>> HFS-specific resources, resulting in a memory leak on early mount failure.
>>
>> Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
>> hfs_put_super() and the hfs_fill_super() failure path into a dedicated
>> hfs_kill_sb() implementation. This ensures that both normal unmount and
>> early teardown paths (including setup_bdev_super() failure) correctly
>> release HFS metadata.
>>
>> This also preserves the intended layering: generic_shutdown_super()
>> handles VFS-side cleanup, while HFS filesystem state is fully destroyed
>> afterwards.
>>
>> Fixes: aca740cecbe5 ("fs: open block device after superblock creation")
> 
> I don't think that's correct.
> 
> The bug was introduced when hfs was converted to the new mount api as
> this was the point where sb->s_fs_info allocation was moved from
> fill_super() to init_fs_context() in ffcd06b6d13b ("hfs: convert hfs to
> use the new mount api") which was way after that commit.
Ah, That then is definitely the cause since the allocation is from 
init_fs_context() and in this error path that leaks it didn't call 
fill_super() yet where in old code would be the allocation of the 
s_fs_info struct that is being leaked... so that would be where the bug 
is introduced as you have mentionned thanks for pointing that out!

> 
> I also think this isn't the best way to do it. There's no need to
> open-code kill_block_super() at all.
> 
I did think do call kill_block_super() instead in hfs_kill_sb() instead 
of open-coding it but I went with what Al Viro has suggested...
> That whole hfs_mdb_get() calling hfs_mdb_put() is completely backwards
> and the cleanup labels make no sense - predated anything you did ofc. It
> should not call hfs_mdb_put(). It's only caller is fill_super() which
> already cleans everything up. So really hfs_kill_super() should just
> free the allocation and it should be moved out of hfs_mdb_put().
> 
I also thought of such solution to make things clearer of the 
deallocation of the memory of s_fs_info and to separate it from the 
deloading/freeing of it's contents.
> And that solution is already something I mentioned in my earlier review.
I thought you have suggested the same as what the al viro has suggested 
by your second point here:"
or add a wrapper
around kill_block_super() for hfs and free it after ->kill_sb() has run.
"

> Let me test a patch.
I just checked your patch and seems to be what I'm thinking about except 
the stuff that is in hfs_mdb_get() which I didn't know about.But since 
the hfs_kill_super() is now implemented with freeing the s_fs_info 
instead of just referring to kill_block_super(), It should fix the issue.

I did just download your patch and test it by running local repro, boot 
the kernel, run selftests before and after with no seen regression.Does 
that add the Tested-by tag?

Thanks for you insights Christian! Tell me if I should send something as 
a follow up for my patch.

Best Regards,
Mehdi Ben Hadj Khelifa

