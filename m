Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E59D28EA91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 03:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbgJOB7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 21:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732521AbgJOB7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:59:38 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A0AC0613DA
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 14:12:42 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r4so1187352ioh.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 14:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MgIottc27IodWM5GJleHD1Awup/i7CxkOaAMBh4aorw=;
        b=YLQHxRGPkKKEwYIn7zXFjRkwau5MpUA3xsoAmrm3OQF+XG752hMs7pBjKkQzJn+2Pp
         3P00TsbbCoFglnQnmkjzjCB656mVVmrDKgI27zCGxzYwlKwieK+qVNpqBejYqlojIYMG
         nHn6pNk4KeiZIV6ALq7AKsFP8QR64VaENWzDCTNyENHWN3nZHVMUkDZFI45e5uGX8YN6
         rHjvbA62IW5qX60O9wlVg8jgaWML3HrfZvoHtoq73brfIm5aa/+xC9inpSXJC4xpNtIw
         PU+kh3AjMHoDID1WJ6QKytelGGfP+jvqOXbwRO7MO93GBZEl1cDe5t6IGvGd/KxLvB1N
         BhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MgIottc27IodWM5GJleHD1Awup/i7CxkOaAMBh4aorw=;
        b=f/8NWHv8nFuZoyePOblF8oILUC64RCPSsq6fyDBB9gC0GUDsLWlPbHBdDaCVBUt2ua
         /tEazOxQCjxzeEuWZZOfYxBAsObelQ2LImNzpulb9Knjvg/J6pVoQrntUVAwHf92Bwsy
         OckQK1+rD0MWipJ/r/KKryezx/3T12Afm+nmT3++TurxgsFES97Oo54LkMzBBaqxWvEb
         Cnal7XDb6DetJBM3wO7+km+ogXZnfhJQXSUtRbSuzt8Y0m2TJ74r6qrQZWXdsfV7kq0y
         bamax/cUqSGVEQVOIAWgJTOrhwE5FBSXa5mnAvdBBzd2FJVSanPzFjWNfP4BM54qfPku
         6iiA==
X-Gm-Message-State: AOAM530k/jDQouF3OkicFP3cqeQ7kuTGboSQq/vqPDHD6e1usXx+TVH1
        dRk7FtvrLUw7B8hKCj3fYs3noA==
X-Google-Smtp-Source: ABdhPJxr4WUUzaYmP4Vs1JF/4aMvZKSsxbb8JYZKoxGERT/cvzeTUI6bpnTw+ao4F/fitjAY4a4CyQ==
X-Received: by 2002:a05:6602:2b90:: with SMTP id r16mr1029944iov.31.1602709961964;
        Wed, 14 Oct 2020 14:12:41 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::1116? ([2620:10d:c091:480::1:6b7a])
        by smtp.gmail.com with ESMTPSA id h14sm496298ilc.38.2020.10.14.14.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 14:12:41 -0700 (PDT)
Subject: Re: [PATCH] fs: fix NULL dereference due to data race in
 prepend_path()
To:     Andrii Nakryiko <andrii@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
References: <20201014204529.934574-1-andrii@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0f91e494-1f81-d4ee-7b96-ce231bddbdb3@toxicpanda.com>
Date:   Wed, 14 Oct 2020 17:12:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201014204529.934574-1-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/14/20 4:45 PM, Andrii Nakryiko wrote:
> Fix data race in prepend_path() with re-reading mnt->mnt_ns twice without
> holding the lock. is_mounted() does check for NULL, but is_anon_ns(mnt->mnt_ns)
> might re-read the pointer again which could be NULL already, if in between
> reads one of kern_unmount()/kern_unmount_array()/umount_tree() sets mnt->mnt_ns
> to NULL.
> 
> This is seen in production with the following stack trace:
> 
> [22942.418012] BUG: kernel NULL pointer dereference, address: 0000000000000048
> ...
> [22942.976884] RIP: 0010:prepend_path.isra.4+0x1ce/0x2e0
> [22943.037706] Code: 89 c6 e9 0d ff ff ff 49 8b 85 c0 00 00 00 48 85 c0 0f 84 9d 00 00 00 48 3d 00 f0 ff ff 0f 87 91 00 00 00 49 8b 86 e0 00 00 00 <48> 83 78 48 00 0f 94 c0 0f b6 c0 83 c0 01 e9 3b ff ff ff 39 0d 29
> [22943.264141] RSP: 0018:ffffc90020d6fd98 EFLAGS: 00010283
> [22943.327058] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000007e5ee
> [22943.413041] RDX: ffff889fb56ac0c0 RSI: ffffffd05dc8147e RDI: ffff88b1f845ab7b
> [22943.499015] RBP: ffff889fbf8100c0 R08: ffffc90020d6fe30 R09: ffffc90020d6fe2c
> [22943.584992] R10: ffffc90020d6fe2c R11: ffffea00095836c0 R12: ffffc90020d6fe30
> [22943.670968] R13: ffff88b7d336bea0 R14: ffff88b7d336be80 R15: ffff88aeb78db980
> [22943.756944] FS:  00007f228447e980(0000) GS:ffff889fc00c0000(0000) knlGS:0000000000000000
> [22943.854448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [22943.923653] CR2: 0000000000000048 CR3: 0000001ed235e001 CR4: 00000000007606e0
> [22944.009630] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [22944.095604] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [22944.181581] PKRU: 55555554
> [22944.214100] Call Trace:
> [22944.243485]  d_path+0xe6/0x150
> [22944.280202]  proc_pid_readlink+0x8f/0x100
> [22944.328449]  vfs_readlink+0xf8/0x110
> [22944.371456]  ? touch_atime+0x33/0xd0
> [22944.414466]  do_readlinkat+0xfd/0x120
> [22944.458522]  __x64_sys_readlinkat+0x1a/0x20
> [22944.508868]  do_syscall_64+0x42/0x110
> [22944.552928]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: f2683bd8d5bd ("[PATCH] fix d_absolute_path() interplay with fsmount()")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   fs/d_path.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 0f1fc1743302..a69e2cd36e6e 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -102,6 +102,8 @@ static int prepend_path(const struct path *path,
>   
>   		if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {
>   			struct mount *parent = READ_ONCE(mnt->mnt_parent);
> +			struct mnt_namespace *mnt_ns;
> +
>   			/* Escaped? */
>   			if (dentry != vfsmnt->mnt_root) {
>   				bptr = *buffer;
> @@ -116,7 +118,9 @@ static int prepend_path(const struct path *path,
>   				vfsmnt = &mnt->mnt;
>   				continue;
>   			}
> -			if (is_mounted(vfsmnt) && !is_anon_ns(mnt->mnt_ns))
> +			mnt_ns = READ_ONCE(mnt->mnt_ns);
> +			/* open-coded is_mounted() to use local mnt_ns */
> +			if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
>   				error = 1;	// absolute root
>   			else

I had to go look at this code carefully to make sure that mnt == 
real_mount(vfsmnt), which it does.  I was also afraid that if we could have 
mnt->mnt_ns change in between checks that we were just trading a possible NULL 
deref with a UAF, but we're under RCU here so we're good there as well.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
