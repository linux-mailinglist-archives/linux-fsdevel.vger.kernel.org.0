Return-Path: <linux-fsdevel+bounces-34859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3359CD4CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 01:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42E91F2295D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E90339AB;
	Fri, 15 Nov 2024 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v9+XPC5T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2D1EA84
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631698; cv=none; b=TPV/vQaw1/nLhmjj1gUUqpz7T56WOguOSGKZNBP1HUt26y2gH9PY7Qv1W7s3nMz/jGAR4XGaEbn9XZN279Nb3at3KopjlOIj3EvA3dnHs1KswsWtOWqJaNv128ghfgKZWEUbeJvwtk5UlPMnFEQi1OJ0HNrdNhJS/zgV5GCsX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631698; c=relaxed/simple;
	bh=505JS9qwShJm9WxsFvOgGPiPcDplS3Rd27MY9UNou3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1WSTc0aon6ou7jf/ODHTNWfCN+6TKhuR7hsZ3jKhdU9616SzolwroazMowlRWxivrju8pVhLvTEA7FazMCYoOWFZYwWZj2aQVLPKsxXZpK+Gzy1VGzIjnn37d73v5goSr8xoOUyxAyFq2HIq+w/WVlatBaXlNk5xCBps8RvFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v9+XPC5T; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731631689; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7WPYpOS6Qm8HjeGpJRcmVvRactf0o52DYDrC5BFZLQE=;
	b=v9+XPC5TOTl8LrofZuQLa+2uaEkrlKFE/UZRYG3eJaObpbwFJzCxs3t9rVcS1YLHD2sLWvgbsyF2dNRHof3JeO/+wlBuaRcQUY2MgL7zHW+0u7mhVN+64y+pYqoxbilx/9P8BgyuEEw2KB2OeVHD/vdoRPVQQzr6OI8PEoEhy5o=
Received: from 30.171.192.161(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WJQSpFp_1731631687 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Nov 2024 08:48:09 +0800
Message-ID: <07bf5e36-a726-4351-b7d1-886fd529a772@linux.alibaba.com>
Date: Fri, 15 Nov 2024 08:48:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: uncache inode which has failed entering the group
To: Dmitry Antipov <dmantipov@yandex.ru>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, akpm <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 lvc-project@linuxtesting.org,
 syzbot+453873f1588c2d75b447@syzkaller.appspotmail.com
References: <20241114043844.111847-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20241114043844.111847-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/24 12:38 PM, Dmitry Antipov wrote:
> Syzbot has reported the following BUG:
> 
> kernel BUG at fs/ocfs2/uptodate.c:509!
> ...
> Call Trace:
>  <TASK>
>  ? __die_body+0x5f/0xb0
>  ? die+0x9e/0xc0
>  ? do_trap+0x15a/0x3a0
>  ? ocfs2_set_new_buffer_uptodate+0x145/0x160
>  ? do_error_trap+0x1dc/0x2c0
>  ? ocfs2_set_new_buffer_uptodate+0x145/0x160
>  ? __pfx_do_error_trap+0x10/0x10
>  ? handle_invalid_op+0x34/0x40
>  ? ocfs2_set_new_buffer_uptodate+0x145/0x160
>  ? exc_invalid_op+0x38/0x50
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? ocfs2_set_new_buffer_uptodate+0x2e/0x160
>  ? ocfs2_set_new_buffer_uptodate+0x144/0x160
>  ? ocfs2_set_new_buffer_uptodate+0x145/0x160
>  ocfs2_group_add+0x39f/0x15a0
>  ? __pfx_ocfs2_group_add+0x10/0x10
>  ? __pfx_lock_acquire+0x10/0x10
>  ? mnt_get_write_access+0x68/0x2b0
>  ? __pfx_lock_release+0x10/0x10
>  ? rcu_read_lock_any_held+0xb7/0x160
>  ? __pfx_rcu_read_lock_any_held+0x10/0x10
>  ? smack_log+0x123/0x540
>  ? mnt_get_write_access+0x68/0x2b0
>  ? mnt_get_write_access+0x68/0x2b0
>  ? mnt_get_write_access+0x226/0x2b0
>  ocfs2_ioctl+0x65e/0x7d0
>  ? __pfx_ocfs2_ioctl+0x10/0x10
>  ? smack_file_ioctl+0x29e/0x3a0
>  ? __pfx_smack_file_ioctl+0x10/0x10
>  ? lockdep_hardirqs_on_prepare+0x43d/0x780
>  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
>  ? __pfx_ocfs2_ioctl+0x10/0x10
>  __se_sys_ioctl+0xfb/0x170
>  do_syscall_64+0xf3/0x230
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> ...
>  </TASK>
> 
> When 'ioctl(OCFS2_IOC_GROUP_ADD, ...)' has failed for the particular
> inode in 'ocfs2_verify_group_and_input()', corresponding buffer head
> remains cached and subsequent call to the same 'ioctl()' for the same
> inode issues the BUG() in 'ocfs2_set_new_buffer_uptodate()' (trying
> to cache the same buffer head of that inode). Fix this by uncaching
> the buffer head with 'ocfs2_remove_from_cache()' on error path in
> 'ocfs2_group_add()'.
> 
> Reported-by: syzbot+453873f1588c2d75b447@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=453873f1588c2d75b447
> Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")

Seems the blame commit id should be:
7909f2bf8353 ("[PATCH 2/2] ocfs2: Implement group add for online resize")

Cc: stable@vger.kernel.org
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  fs/ocfs2/resize.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/resize.c b/fs/ocfs2/resize.c
> index c4a4016d3866..b0733c08ed13 100644
> --- a/fs/ocfs2/resize.c
> +++ b/fs/ocfs2/resize.c
> @@ -574,6 +574,8 @@ int ocfs2_group_add(struct inode *inode, struct ocfs2_new_group_input *input)
>  	ocfs2_commit_trans(osb, handle);
>  
>  out_free_group_bh:
> +	if (ret < 0)
> +		ocfs2_remove_from_cache(INODE_CACHE(inode), group_bh);
>  	brelse(group_bh);
>  
>  out_unlock:


