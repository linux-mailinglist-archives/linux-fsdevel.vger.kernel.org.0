Return-Path: <linux-fsdevel+bounces-35752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029E29D7B56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 06:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874581627D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 05:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9813C809;
	Mon, 25 Nov 2024 05:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwTZHOKI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C92941C;
	Mon, 25 Nov 2024 05:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513762; cv=none; b=M4G/QIoHQOj1XpxUaTAc1ccb6inFLlrNgSTSGBK52P/B4d7uUYsbjfKsTCJd0sMBWoZAqymkCqcncFvHWNS0zKc8Y+DNiAuH2QyTh8JEOevb6ElQ2oKqdPvCK0BXXALmWKWS+8mtDPZSsgtA0EAAZ86z/4jI+V4HGw+V1mKMwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513762; c=relaxed/simple;
	bh=Bju4gtfRdH7rFZ9Ag5WS5QqEfJC/M0U40ROcLJzlH5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1JAmMR6dRDj+ao2qiw/308KqGj7uPCbDM8EMzvFHj/1CZTPnH9mjoGNR8kPGpTC23dLCrG+CqjUVySL+qHVju/Dkmy7gYmFc7l8ZJAeNQyGsqRNRfIKg2/SOFINKmXeHX4L77sQ8KwnU625Ti5qgW/mXdS16kMlwGDP3MDy6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwTZHOKI; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ea4c5b8fbcso2859731a91.0;
        Sun, 24 Nov 2024 21:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732513759; x=1733118559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6rXtXgsXHFfXf1n4pYsBK6d04nGRfspgBtig8HuaZ6o=;
        b=UwTZHOKIOe6IlaIB3btH8G+QEfvrxJjnn/mTyEcgAaRRmLqFxRxFaNQ8KlVxlIwu5J
         NzKIO0HzeTXHawxD421fItvMZY2xwzXF+DAW/nl6lAio527sinlx/SeNAW9posiXdZ6j
         hpaMcwpFpZz6TuYFiLVCOZSjcgxD0BYAICa1q1reA/Lt2ljDbd9oHhXmYlz5ZIuQ2imk
         abQRVsJdlTBG9Sj3zIG8CLGL+E/SU1/DQsLwZ44VWEqDJ7LfVqUvJbwMK8x9uDI8wyLH
         5vrUz1/5LNUtinycFWgQjiAzjvAvrRVXdEeI79tAobDk/YV1z3OXRp9cvBZVrRigbLWB
         Sm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732513759; x=1733118559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rXtXgsXHFfXf1n4pYsBK6d04nGRfspgBtig8HuaZ6o=;
        b=oC6qwKDwZuSRmv10YisUhdN+rSYYLhUF7/rH/aSk5wyZfDDzkgyB4JGoEf1siwHSo/
         pf+9cJvDOUv5DwutTVIZ5SfjMa4hMAoiIp3cSKFv2IYVq+muR+CcuDtsgGPrfi3dLgVl
         kFQhc/s4/DYcjNBHegj6B6U55QCUMwN1jUFieRYMIYDA5I+X3eQPJ5mv5bRJz8rW3Lr/
         Q/ysHXYNPXtBXreVt1fhZ5UHCR8HnIaZtYqBn/E3ewwHyJmrJygOSSNmJYuhV7Wl9b/b
         t3vJpy7HcumYnpt4w/Ptrg7A7jKf9pdlnqKC6FN30OxzqzJTIw0pCyusPVJA3JSCLsPj
         bS3g==
X-Forwarded-Encrypted: i=1; AJvYcCWgwwACJUkRTLZkzQr128rre12fLq9aZNrf/HG97Ly/iLonWEompFzV5kHVmNHQofsVk/eKxd0Y15LjWw5g@vger.kernel.org, AJvYcCWwvGoVJPP/7m7shZTDPNQ1LXKvxzLJUWFEtWETeyUgH+7XXTsgQXs4khh3vFSYrGYwNxjb5Zjz3MrjtJxP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0870OFWr7P7cRspAfaMqgM+I3exXkwFDXrHpXomEr7nHR3+9I
	M2gWMdhXeBoI6sbOSy3vSKv4J5FJpI7Qx4KOlucxx7zWuN1hTiRk
X-Gm-Gg: ASbGncsgAh9fIzG3w8NaGTtnWHjkMcXKbhdUrPOMyNuphoQyMgfYjRYrjivFouer/iD
	OJoiNvD4dBzV3BPvgqK8TMnJpFR3xS9EdMHocrt3RdQnGKBlhYEpe5kw8+HBVrwYtQyeZWsdkJ+
	wTXXWxMMm2TlJmIn2dCwiNOMIbfKcLJy3cisMY/BZrwRbDZb681IGqrHsdlgiG1AbHHSQUGhsp1
	DBTC7s3toYehZN1p/JoVxPK2NWSTvvXZy4fnbLikUmZFFqkSSLGKyfNRawTBWPz
X-Google-Smtp-Source: AGHT+IHpBio4fXdTc+xHzWIi1ziStgr+b+KkvweaC8XiYHNs4rqQXrsC1g+7Vu/wTtxYlcWckYFUJw==
X-Received: by 2002:a17:90b:1810:b0:2ea:7ba7:33b9 with SMTP id 98e67ed59e1d1-2eaebf06808mr24941369a91.14.1732513759388;
        Sun, 24 Nov 2024 21:49:19 -0800 (PST)
Received: from [192.168.0.203] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de55b4c8sm5571542b3a.164.2024.11.24.21.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 21:49:19 -0800 (PST)
Message-ID: <57995928-66c7-4612-8215-9f437816b586@gmail.com>
Date: Mon, 25 Nov 2024 11:19:13 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] WARNING in minix_unlink
To: Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <CAHiZj8jbd9SQwKj6mvDQ3Kgi2z8rrCCwsqgjOgFtCzsk5MVPzQ@mail.gmail.com>
 <6743814d.050a0220.1cc393.0049.GAE@google.com>
 <20241124194701.GY3387508@ZenIV> <20241124201009.GZ3387508@ZenIV>
 <20241125030058.GE3874922@mit.edu>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <20241125030058.GE3874922@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/24 08:30, Theodore Ts'o wrote:
> On Sun, Nov 24, 2024 at 08:10:09PM +0000, Al Viro wrote:
>>> What happens there is that on a badly corrupt image we have an on-disk
>>> inode with link count below the actual number of links.  And after
>>> unlinks remove enough of those to drive the link count to 0, inode
>>> is freed.  After that point, all remaining links are pointing to a freed
>>> on-disk inode, which is discovered when they need to decrement of link
>>> count that is already 0.  Which does deserve a warning, probably without
>>> a stack trace.
>>>
>>> There's nothing the kernel can do about that, short of scanning the entire
>>> filesystem at mount time and verifying that link counts are accurate...
>>
>> Theoretically we could check if there's an associated dentry at the time of
>> decrement-to-0 and refuse to do that decrement in such case, marking the
>> in-core inode so that no extra dentries would be associated with it
>> from that point on.  Not sure if that'd make for a good mitigation strategy,
>> though - and it wouldn't help in case of extra links we hadn't seen by
>> that point; they would become dangling pointers and reuse of on-disk inode
>> would still be possible...
> 
> Yeah, what we do with ext4 in that case is that we mark the file
> system as corrupted, and print an ext4_error() message, but we don't
> call WARN_ON.  At this point, you cam either (a) force a reboot, so
> that it can get fixed up at fsck time --- this might be appropriate if
> you have a failover setup, where bringing the system *down* so the
> backup system can do its thing without further corrupting user data,
> (b) remount the file system read-only, so that you don't actually do
> any further damage to the system, or (c) if the file system is marked
> "don't worry, be happy, continue running because some silly security
> policy says that bringing the system down is a denial of service
> attack and we can't have that (**sigh**), it might be a good idea to
> mark the block group as "corrupted" and refuse to do any further block
> or inode allocations out of that block group until the file system can
> be properly checked.
> 
> Anyway, this is why I now ignore any syzkaller report that involves a
> badly corrupted file system being mounted.  That's not something I
> consider a valid threat model, and if someone wants to pay an engineer
> to work through all of those issues, *great*, but I don't have the
> time to deal with what I consider a super-low-priority issue.
> 
> 					- Ted


Thank you for the insight, Ted. I understand the challenges of 
addressing issues caused by badly corrupted filesystems, especially when 
they fall outside typical threat models. I appreciate your perspective 
and time!


