Return-Path: <linux-fsdevel+bounces-36396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CF09E33D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 08:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D707167E6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 07:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5518BB9C;
	Wed,  4 Dec 2024 07:04:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2D17BEC5;
	Wed,  4 Dec 2024 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733295898; cv=none; b=PNlLOjalpWrz8OLdW0CFMicMqfwZ2Uhtp3JEx9MV6AJCJnOT8V0Ohpmg4zTqu8LyEALdtpYh6hmHT1V+EgcW476WCFVU9J0jl6KSUIFy41ceX04yQgczAFh/wMmuvETCMDoCG4o0oulfxpzKsaLr4MBZNkYwJFgzAtoWIuwd2kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733295898; c=relaxed/simple;
	bh=wycjbWviGcxBtS/Khs5H+zQOvPvEZf97xukRN0WJi80=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DjfhM0pN4LKy5UJ6h3iZDQiOp4N1/q+glxBh6jmyYdgVwlG6NoakINSC7lkOe3Gi2E9XV/v0RfGl7+fdPDKJ42h1H2y1TyGgqzZCFrpZDLubFh9b7/wxbGWERNhLhiqmxlHvDe8y7YhVuSFfMufXqmMR9pUW7EZbF7Y6WVt1UVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y37kf48mKz1jxpx;
	Wed,  4 Dec 2024 15:02:34 +0800 (CST)
Received: from kwepemd200022.china.huawei.com (unknown [7.221.188.232])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C8691A016C;
	Wed,  4 Dec 2024 15:04:51 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemd200022.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Dec 2024 15:04:49 +0800
Subject: Re: [PATCH 00/11] fix hungtask due to repeated traversal of inodes
 list
To: Ye Bin <yebin@huaweicloud.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<axboe@kernel.dk>, <linux-block@vger.kernel.org>, <agruenba@redhat.com>,
	<gfs2@lists.linux.dev>, <amir73il@gmail.com>, <mic@digikod.net>,
	<gnoack@google.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <linux-security-module@vger.kernel.org>
References: <20241118114508.1405494-1-yebin@huaweicloud.com>
CC: <zhangxiaoxu5@huawei.com>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <674FFF03.9080403@huawei.com>
Date: Wed, 4 Dec 2024 15:04:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241118114508.1405494-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200022.china.huawei.com (7.221.188.232)

Friendly ping...

On 2024/11/18 19:44, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> As commit 04646aebd30b ("fs: avoid softlockups in s_inodes iterators")
> introduces the retry logic. In the problem environment, the 'i_count'
> of millions of files is not zero. As a result, the time slice for each
> traversal to the matching inode process is almost used up, and then the
> traversal is started from scratch. The worst-case scenario is that only
> one inode can be processed after each wakeup. Because this process holds
> a lock, other processes will be stuck for a long time, causing a series
> of problems.
> To solve the problem of repeated traversal from the beginning, each time
> the CPU needs to be freed, a cursor is inserted into the linked list, and
> the traversal continues from the cursor next time.
>
> Ye Bin (11):
>    fs: introduce I_CURSOR flag for inode
>    block: use sb_for_each_inodes API
>    fs: use sb_for_each_inodes API
>    gfs2: use sb_for_each_inodes API
>    fs: use sb_for_each_inodes_safe API
>    fsnotify: use sb_for_each_inodes API
>    quota: use sb_for_each_inodes API
>    fs/super.c: use sb_for_each_inodes API
>    landlock: use sb_for_each_inodes API
>    fs: fix hungtask due to repeated traversal of inodes list
>    fs: fix potential soft lockup when 'sb->s_inodes' has large number of
>      inodes
>
>   block/bdev.c           |  4 +--
>   fs/drop_caches.c       |  2 +-
>   fs/gfs2/ops_fstype.c   |  2 +-
>   fs/inode.c             | 59 ++++++++++++++++++++++++++++--------------
>   fs/notify/fsnotify.c   |  2 +-
>   fs/quota/dquot.c       |  4 +--
>   fs/super.c             |  2 +-
>   include/linux/fs.h     | 45 ++++++++++++++++++++++++++++++++
>   security/landlock/fs.c |  2 +-
>   9 files changed, 93 insertions(+), 29 deletions(-)
>


