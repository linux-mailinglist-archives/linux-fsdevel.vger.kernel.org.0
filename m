Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EA020F48A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 14:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbgF3MY3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 08:24:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37386 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731651AbgF3MY2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:24:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C0D66490216AAB71B2EA;
        Tue, 30 Jun 2020 20:24:14 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.106) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 30 Jun 2020
 20:24:12 +0800
Subject: Re: [PATCH] cifs: remove the retry in cifs_poxis_lock_set
From:   yangerkun <yangerkun@huawei.com>
To:     <sfrench@samba.org>, <jlayton@kernel.org>, <neilb@suse.de>,
        <neilb@suse.com>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20200624071053.993784-1-yangerkun@huawei.com>
Message-ID: <62b291ab-291c-339f-e8e8-ba7b0c4f6670@huawei.com>
Date:   Tue, 30 Jun 2020 20:24:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200624071053.993784-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping...

ÔÚ 2020/6/24 15:10, yangerkun Ð´µÀ:
> The caller of cifs_posix_lock_set will do retry(like
> fcntl_setlk64->do_lock_file_wait) if we will wait for any file_lock.
> So the retry in cifs_poxis_lock_set seems duplicated, remove it to
> make a cleanup.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>   fs/cifs/file.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 9b0f8f33f832..2c9c24b1805d 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -1162,7 +1162,6 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
>   	if ((flock->fl_flags & FL_POSIX) == 0)
>   		return rc;
>   
> -try_again:
>   	cifs_down_write(&cinode->lock_sem);
>   	if (!cinode->can_cache_brlcks) {
>   		up_write(&cinode->lock_sem);
> @@ -1171,13 +1170,6 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
>   
>   	rc = posix_lock_file(file, flock, NULL);
>   	up_write(&cinode->lock_sem);
> -	if (rc == FILE_LOCK_DEFERRED) {
> -		rc = wait_event_interruptible(flock->fl_wait,
> -					list_empty(&flock->fl_blocked_member));
> -		if (!rc)
> -			goto try_again;
> -		locks_delete_block(flock);
> -	}
>   	return rc;
>   }
>   
> 

