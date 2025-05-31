Return-Path: <linux-fsdevel+bounces-50259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC7BAC9CCB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 23:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889F9179959
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 21:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3D01A3166;
	Sat, 31 May 2025 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q5pBbnmU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D839510E4
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 May 2025 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748725248; cv=none; b=UVsQd1f2srNdv2eABEcTXr1pKJRqFmBCwvxeXGsHKrOAxHU0q0Nxb5Df9ELQV6QWAmaXeR1zA4F8CmdYtbYA9Cu0Os7mExyOQ7+n6nlJ35JMm9eMholVxmT2c6at4a4Pfmz8PdtDJa7rxA7/NAJx9otsTcUtkhBPGN6hvbReJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748725248; c=relaxed/simple;
	bh=xHo1tRVpElZ4guAmsKjfLctNYuzwrlSSbzIrBSmNFeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOAv4ncDiFD1NbAbRWmjcUcDkt5Ix/FFc84J1jq/xRkp6TfL91aQdWFj1G0R/5d5Vc72e+RqS1PbcBdTTPyUrKHuB8tOk4GCpZNlKZ90DPJ/fnh4zkkLxfsGW+fzstqNFJaR7aqehiU8qI/DX6Jp4KjkLfvIfMLGe2ar+ACeL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q5pBbnmU; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3dc926f21d0so9644895ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 May 2025 14:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748725245; x=1749330045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64G9qsLjnSVM1NqfWJ2UFZmEUaCNdyM1xbotW0W1+Vc=;
        b=q5pBbnmUa9JXJ9VqBvkqt4CXX1zX2IEL37InTGr9yNYqqVAtxvRgquF+fouYCeUjaG
         LPt3NA9kLcK9fVURDUR3kLRKqUkYqxIIcOgcEfEKqALOQ91W5Mfh5W3SVb1k4z+FDCXd
         1op69bQowFKcNbQBlS7x/OrfjljujV4yrkLu44bKTgIFmnPSUOLrACWI5qVHhqg3YZpo
         AtqgBtmpfnXoZy4UKFIXY89HeWIGVPSV4b4Q9K1wxkKQkNFPRitGaP9ByjhjuVKfOTAu
         ZkDqYLhxgvSupydI8giO/XyUyr+wzL4KULdieASCORoZIh4qdQGVzniQOpWkwlx8w/c4
         MERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748725245; x=1749330045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64G9qsLjnSVM1NqfWJ2UFZmEUaCNdyM1xbotW0W1+Vc=;
        b=OGQlcxp2M4l/8zx4tZ0kxRh7mcrxVIzXn0X8eiy1PWjemVE2KwbjWL3syLPISrMpQK
         gqU6LB4CyvqfEaCahBXN7xA46rnVKgSG+UPu1YdshzyQfn1Cc8e+8OaiaHE70g5ubjST
         eCKudUy6B0blko6hOqSNSY/YoNDeBkBrhlMupJUpXupM5Ygo5QAAMZ5xhcx4dAJquSAV
         L5mTZ/tBD31yUaIOEaXHXrsP0eDxs7GFps1WXiOsCM4Ypsnaj/RIVgjnvCFQa4pDmGfw
         onlOrbbjkeVpOo5PIOJJdXJN6gjf8Jv2wE9atDB23LnHgfOfoUeEioncv0+kb6g9JB3y
         PEmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXL9z7Qq4x0nKxgiNwNj8YLtvO73576QF2PM0/Gctcx8s/ysJlVjfumRTcE2yRowZZEATifD6W4dGILnxH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqa6Jmy62HBQSIrabB+tqtYCU6fvga07RUxoAPR75VgxVCVYBG
	yDLOHH09wYFAu930U7+ldBcU7CwLWXK7PQf8KcmcSOXTrgI5p+mWVXM6vjVvkwuztDU=
X-Gm-Gg: ASbGncv5amBC7SovsBnGcG7Hl5AKyJhLiKZhiqMcTEBnHz6OauwXL4qRt1h8DRMdwG9
	xi4vjObcZN1EtEVxTrjmq4G3+BMVyQjT1sD+EoO1qdjHtqs0Rx1mNKrocTrD4TqAhNtQ6/Eojx0
	fk2hZsHKXxEwK+LhXvp1lhdsvigOU8OpZrdXT3hBJ+EDd8tQNW79E1KEe46nqelp5OoIuciGFrL
	zRRkl8WaDxTCPmGII0B2PuEVgznVGnULc8AuNZgny/5khgWWqnGfZrvMh5daI+Dkk1QQT/9Rzr7
	Y5jW8UDxhrI0u5DTClGUZvreOfkRExgIfIp507NWFEGekjOG
X-Google-Smtp-Source: AGHT+IFotBamljdQeXLkafFFCVXUK3gsB3E1uiDpiNBHxcNN9K2SnFGqJ4paIlnX/TZlS7B5VTHsVg==
X-Received: by 2002:a05:6e02:198b:b0:3dd:869e:d1f0 with SMTP id e9e14a558f8ab-3dd9c9af4dbmr59812675ab.9.1748725244816;
        Sat, 31 May 2025 14:00:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7efc764sm1032445173.110.2025.05.31.14.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 May 2025 14:00:44 -0700 (PDT)
Message-ID: <0315c56c-5fe1-460d-8b34-a356e42ccae5@kernel.dk>
Date: Sat, 31 May 2025 15:00:42 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
To: "Darrick J. Wong" <djwong@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
References: <20250525083209.GS2023217@ZenIV>
 <20250529015637.GA8286@frogsfrogsfrogs>
 <20250531011050.GB8286@frogsfrogsfrogs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250531011050.GB8286@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/25 7:10 PM, Darrick J. Wong wrote:
> On Wed, May 28, 2025 at 06:56:37PM -0700, Darrick J. Wong wrote:
>> On Sun, May 25, 2025 at 09:32:09AM +0100, Al Viro wrote:
>>> generic/127 with xfstests built on debian-testing (trixie) ends up with
>>> assorted memory corruption; trace below is with CONFIG_DEBUG_PAGEALLOC and
>>> CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT and it looks like a double free
>>> somewhere in iomap.  Unfortunately, commit in question is just making
>>> xfs use the infrastructure built in earlier series - not that useful
>>> for isolating the breakage.
>>>
>>> [   22.001529] run fstests generic/127 at 2025-05-25 04:13:23
>>> [   35.498573] BUG: Bad page state in process kworker/2:1  pfn:112ce9
>>> [   35.499260] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x3e 9
>>> [   35.499764] flags: 0x800000000000000e(referenced|uptodate|writeback|zone=2)
>>> [   35.500302] raw: 800000000000000e dead000000000100 dead000000000122 000000000
>>> [   35.500786] raw: 000000000000003e 0000000000000000 00000000ffffffff 000000000
>>> [   35.501248] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>>> [   35.501624] Modules linked in: xfs autofs4 fuse nfsd auth_rpcgss nfs_acl nfs0
>>> [   35.503209] CPU: 2 UID: 0 PID: 85 Comm: kworker/2:1 Not tainted 6.14.0-rc1+ 7
>>> [   35.503211] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.164
>>> [   35.503212] Workqueue: xfs-conv/sdb1 xfs_end_io [xfs]
>>> [   35.503279] Call Trace:
>>> [   35.503281]  <TASK>
>>> [   35.503282]  dump_stack_lvl+0x4f/0x60
>>> [   35.503296]  bad_page+0x6f/0x100
>>> [   35.503300]  free_frozen_pages+0x303/0x550
>>> [   35.503301]  iomap_finish_ioend+0xf6/0x380
>>> [   35.503304]  iomap_finish_ioends+0x83/0xc0
>>> [   35.503305]  xfs_end_ioend+0x64/0x140 [xfs]
>>> [   35.503342]  xfs_end_io+0x93/0xc0 [xfs]
>>> [   35.503378]  process_one_work+0x153/0x390
>>> [   35.503382]  worker_thread+0x2ab/0x3b0
>>>
>>> It's 4:30am here, so I'm going to leave attempts to actually debug that
>>> thing until tomorrow; I do have a kvm where it's reliably reproduced
>>> within a few minutes, so if anyone comes up with patches, I'll be able
>>> to test them.
>>>
>>> Breakage is still present in the current mainline ;-/
>>
>> Hey Al,
>>
>> Welll this certainly looks like the same report I made a month ago.
>> I'll go run 6.15 final (with the #define RWF_DONTCACHE 0) overnight to
>> confirm if that makes my problem go away.  If these are one and the same
>> bug, then thank you for finding a better reproducer! :)
>>
>> https://lore.kernel.org/linux-fsdevel/20250416180837.GN25675@frogsfrogsfrogs/
> 
> After a full QA run, 6.15 final passes fstests with flying colors.  So I
> guess we now know the culprit.  Will test the new RWF_DONTCACHE fixes
> whenever they appear in upstream.

Please do! Unfortunately I never saw your original report as I wasn't
CC'ed on it, which I can't really fault anyone for as there was no
reason to suspect it so far.

-- 
Jens Axboe

