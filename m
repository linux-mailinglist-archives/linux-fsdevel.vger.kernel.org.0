Return-Path: <linux-fsdevel+bounces-31268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE2F993C8E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 03:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4239285B60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 01:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05A91CD0C;
	Tue,  8 Oct 2024 01:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hJ2iPWL7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80CEC4
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352701; cv=none; b=VsKcdgafAyWq9kn6Vgi5yUa4FtmJ6syivhxHJG21zhBxO+haUJIE9YaijdOzTINCuk22q5UnPI1QfIMwBbf6G9iGz4FM+j4X7RJX48Sc+oEBznl8ZQKA7pfd2X21dxqPFSdjJuP8O6AdgZHciRNwClbiPrzLzhfMSnAUs+lsAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352701; c=relaxed/simple;
	bh=vbri1mNMUDtzE+Gb9s0gOMl27VgUfPlsOie7dJPsx34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1rvLjEoRm3q5ry/RTQhddZVI7bf9K6mZEnIlH2tYWSKc48ZsofV6WDiwXPRneSsdHlENUl6r1nQgNUohkNsCSDySP57NixuUj0/sW2lyVrfFpeusz6vWsFfljNb1clkcp8WZdcf6/OWT+sX8mhXaZY9WHmeksgaDR/qvL6UUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hJ2iPWL7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e0946f9a8eso3474256a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 18:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728352696; x=1728957496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQm7Hfz/Lhn8DotAxXn6g8FppRUOzvGHX7r/1oq6KZY=;
        b=hJ2iPWL76eYWVF+vKSfkmtc9DkbHqvg/3Q9fk7P1SuYNodoZfnW0R4e2CVoXlDNwhY
         H6KApuKh9L1m7yJpYiNOiELuqGoJ4GorSWCZ/96y6lCYnK1UA+naXU4pYxbl+rF2mS4B
         IOLRh76Vyd5KFU6iD2ApPBxmXIGQ9CMFs8nobsUdGHL8kJ3nVrv8hBUjluOiTpBVap0m
         T+W86+BEJ/wamLnhd8V9I8uWBXSfH0hp3lp8HZ4jtdXx1h1LxEa6eddhhOxYh2HYheHX
         +gemBN+CjRuseWF8zadbFugwAqTSdYjVuxOOEzPjHsRXtd8BiTF13KIr8bFQWzwX4awk
         8tPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728352696; x=1728957496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQm7Hfz/Lhn8DotAxXn6g8FppRUOzvGHX7r/1oq6KZY=;
        b=ANzwtxJEZRM7cJUHZsjfNcyOb8U2ZoxUpvXQmCMydfmj6WvnnMO+JQjHlo6BDL4+IZ
         6qG6ywbOrRZbE09Tzm1ofOf9B8LIALKjnaQklxSYPhn1z5+Vh037mbAi1pd27c6aOTHz
         R+Xqa23aTznP5WpLFAIjX5Ui5FcsbevI1az9YaeclRUldsg3i1mIBF5eftvnRSl92XLl
         Ib1wG7/wZVDeNG/tidJHGBBJbkT1MmiEjth0/L64eQq5ihET3zWTth3EhoINt4qpiBOP
         XeTW7q9z3odNhC8AcHshbg/vTW6JTa4SxvALuaJzwMlhFa/CK8cfi4HXYfOEgsnE2DCY
         9D7A==
X-Gm-Message-State: AOJu0YyiED3qbo5J7Jwx+fKMmvguxMqFHO8+r/+oHG8vvx7PmOKzFoLq
	emZFqgBWlRk5TiZsy3j2HToJicTeL0siTXYZNU+Dejp3RT37TA6wVgRWHEM6DqI=
X-Google-Smtp-Source: AGHT+IGy/Qifh705grE6gE7k+kLP+53BLqbS1Ib2rIsydDQRwiex9A8jRJO1142gYfnZQDcf5nEOdQ==
X-Received: by 2002:a17:90b:118c:b0:2e0:d957:1b9d with SMTP id 98e67ed59e1d1-2e1e621f1d2mr17782269a91.13.1728352696606;
        Mon, 07 Oct 2024 18:58:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e866902csm7932346a91.41.2024.10.07.18.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 18:58:16 -0700 (PDT)
Message-ID: <10fe7485-a672-4a66-9080-c8824b79a030@kernel.dk>
Date: Mon, 7 Oct 2024 19:58:15 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] replace do_setxattr() with saner helpers.
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 io-uring@vger.kernel.org, cgzones@googlemail.com
References: <12334e67-80a6-4509-9826-90d16483835e@kernel.dk>
 <20241002020857.GC4017910@ZenIV>
 <a2730d25-3998-4d76-8c12-dde7ce1be719@kernel.dk>
 <20241002211939.GE4017910@ZenIV>
 <d69b33f9-31a0-4c70-baf2-a72dc28139e0@kernel.dk>
 <20241006052859.GD4017910@ZenIV>
 <69e696d7-637a-4cb2-912c-6066d23afd72@kernel.dk>
 <965e59b5-615a-4d20-bb04-a462c33ad84b@kernel.dk>
 <20241007212034.GS4017910@ZenIV>
 <2da6c045-3e55-4137-b646-f2da69032fff@kernel.dk>
 <20241007235815.GT4017910@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241007235815.GT4017910@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 5:58 PM, Al Viro wrote:
> On Mon, Oct 07, 2024 at 04:29:29PM -0600, Jens Axboe wrote:
>>> Can I put your s-o-b on that, with e.g.
>>>
>>> io_uring: IORING_OP_F[GS]ETXATTR is fine with REQ_F_FIXED_FILE
>>>
>>> Rejection of IOSQE_FIXED_FILE combined with IORING_OP_[GS]ETXATTR
>>> is fine - these do not take a file descriptor, so such combination
>>> makes no sense.  The checks are misplaced, though - as it is, they
>>> triggers on IORING_OP_F[GS]ETXATTR as well, and those do take 
>>> a file reference, no matter the origin. 
>>
>> Yep that's perfect, officially:
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> Thanks Al!
> 
> OK, updated and force-pushed (with slight reordering).  I can almost
> promise no-rebase mode for that thing from now on, as long as nobody
> on fsdevel objects to fs/xattr.c part of things after I repost the
> series in the current form.

No worries on my end in terms of rebasing, I have no plans to touch
xattr.c for the coming series. Risk of conflict should be very low, so I
don't even need to pull that in.

> One possible exception: I'm not sure that fs/internal.h is a good
> place for those primitives.  OTOH, any bikeshedding in that direction
> can be delayed until the next cycle...

It ended up just being the defacto place to shove declarations for
things like that. But it always felt a bit dirty, particularly needing
to include that from the io_uring side as it moved out of fs/ as well.
Would indeed be nice to get that cleaned up a bit.

> To expand the circle of potential bikeshedders: s/do_mkdirat/filename_mkdirat/
> is a reasonable idea for this series, innit?  How about turning e.g.
> 
> int __init init_mkdir(const char *pathname, umode_t mode)
> {
>         struct dentry *dentry;
>         struct path path;
>         int error;
> 
>         dentry = kern_path_create(AT_FDCWD, pathname, &path, LOOKUP_DIRECTORY);
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>         mode = mode_strip_umask(d_inode(path.dentry), mode);
>         error = security_path_mkdir(&path, dentry, mode);
>         if (!error)
>                 error = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
>                                   dentry, mode);
>         done_path_create(&path, dentry);
>         return error;
> }
> 
> into
> 
> int __init init_mkdir(const char *pathname, umode_t mode)
> {
> 	return filename_mkdirat(AT_FDCWD, getname_kernel(pathname), mode);
> }
> 
> reducing the duplication?  It really should not be accessible to random
> places in the kernel, but syscalls in core VFS + io_uring interface for
> the same + possibly init/*.c...
> 
> OTOH, I'm afraid to let the "but our driver is sooo special!" crowd play
> with the full set of syscalls...  init_syscalls.h is already bad enough.
> Hell knows, fs/internal.h just might be a bit of deterrent...

Deduping it is a good thing, suggestion looks good to me. For random
drivers, very much agree. But are there any of these symbols we end up
exporting? That tends to put a damper on the enthusiasm...

-- 
Jens Axboe

