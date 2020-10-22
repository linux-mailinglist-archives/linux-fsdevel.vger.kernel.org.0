Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2727F295FD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506312AbgJVNVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 09:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395144AbgJVNVh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:21:37 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC5C24178;
        Thu, 22 Oct 2020 13:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603372897;
        bh=d5bUI+oEWFBXElQM/JgZ8EHLv6txyWduc+tTVwSqnpE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=0d6gD7o05Vr/ASsXaalkU4P0+LkuVsUlfLxSrCVz/WzZFl09QDaz3b8LqbSasmiwS
         He1bCNjnQ2ohczOvblwzUY9yDcerRCZOzTMyz2IjD25FJ+YVMQlzoBxbyYnnRTMLcX
         KoAlAttdMR9u54urgKYi3Bgl3WnRZqV0B9WEZlPk=
Message-ID: <3cb0aeaa4e75b5dd4c0e6bb8b04f277f7162a581.camel@kernel.org>
Subject: Re: [PATCH] locks: Fix UBSAN undefined behaviour in
 flock64_to_posix_lock
From:   Jeff Layton <jlayton@kernel.org>
To:     Luo Meng <luomeng12@huawei.com>, bfields@fieldses.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Date:   Thu, 22 Oct 2020 09:21:35 -0400
In-Reply-To: <20201022020341.2434316-1-luomeng12@huawei.com>
References: <20201022020341.2434316-1-luomeng12@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-10-22 at 10:03 +0800, Luo Meng wrote:
> When the sum of fl->fl_start and l->l_len overflows,
> UBSAN shows the following warning:
> 
> UBSAN: Undefined behaviour in fs/locks.c:482:29
> signed integer overflow: 2 + 9223372036854775806
> cannot be represented in type 'long long int'
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xe4/0x14e lib/dump_stack.c:118
>  ubsan_epilogue+0xe/0x81 lib/ubsan.c:161
>  handle_overflow+0x193/0x1e2 lib/ubsan.c:192
>  flock64_to_posix_lock fs/locks.c:482 [inline]
>  flock_to_posix_lock+0x595/0x690 fs/locks.c:515
>  fcntl_setlk+0xf3/0xa90 fs/locks.c:2262
>  do_fcntl+0x456/0xf60 fs/fcntl.c:387
>  __do_sys_fcntl fs/fcntl.c:483 [inline]
>  __se_sys_fcntl fs/fcntl.c:468 [inline]
>  __x64_sys_fcntl+0x12d/0x180 fs/fcntl.c:468
>  do_syscall_64+0xc8/0x5a0 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Fix it by moving -1 forward.
> 
> Signed-off-by: Luo Meng <luomeng12@huawei.com>
> ---
>  fs/locks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 1f84a03601fe..8489787ca97e 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -542,7 +542,7 @@ static int flock64_to_posix_lock(struct file *filp, struct file_lock *fl,
>  	if (l->l_len > 0) {
>  		if (l->l_len - 1 > OFFSET_MAX - fl->fl_start)
>  			return -EOVERFLOW;
> -		fl->fl_end = fl->fl_start + l->l_len - 1;
> +		fl->fl_end = fl->fl_start - 1 + l->l_len;
>  
>  	} else if (l->l_len < 0) {
>  		if (fl->fl_start + l->l_len < 0)

Wow, ok. Interesting that the order would have such an effect here, but
it seems legit. I'll plan to merge this for v5.11. Let me know if we
need to get this in earlier.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

