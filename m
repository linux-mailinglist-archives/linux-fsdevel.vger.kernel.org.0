Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53278332E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 19:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhCISa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 13:30:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhCISaZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:30:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AABB65062;
        Tue,  9 Mar 2021 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615314624;
        bh=tRYGs1afC4aUKzNs4pVIOuMVj2QEYFFqBfyuqhUD1RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FH2kFKrtY54pC3u2e3ROhnxiM6wDk5CC8+3QpDa1m6zTVYvNrCA3JfrOc6a/oTKho
         Z05NIAyL1NswHpueCktCWaYmUnnHx5QSE84qm8YBT+Itk/R852AWnoxkIyNbsShsEK
         hmzql3KVqiDNL+3adotrJt+k8YEQZYeoTsMo4h+yoYN/g64WyTD3KdWrm8wWjERfYu
         sOIZZEf8dn4tnX5nWA6aXXgI+YAA/yqD0feKqbvRzEm8RUUWam2WSSSAMJ0+qMmABq
         Neaei65ZrbW9BaoG578eNI4BOU886cUnzlkmkLU5SDPByA3m5BD7Veh/nzwNrhk1rk
         7thDaMl0h4DvQ==
Date:   Tue, 9 Mar 2021 10:30:23 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     adobriyan@gmail.com, christian@brauner.io, ebiederm@xmission.com,
        akpm@linux-foundation.org, keescook@chromium.org,
        gladkov.alexey@gmail.com, walken@google.com,
        bernd.edlinger@hotmail.de, avagin@gmail.com, deller@gmx.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: proc: fix error return code of
 proc_map_files_readdir()
Message-ID: <YEe+v+ywMrxgmj05@gmail.com>
References: <20210309095527.27969-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309095527.27969-1-baijiaju1990@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 09, 2021 at 01:55:27AM -0800, Jia-Ju Bai wrote:
> When get_task_mm() returns NULL to mm, no error return code of
> proc_map_files_readdir() is assigned.
> To fix this bug, ret is assigned with -ENOENT in this case.
> 
> Fixes: f0c3b5093add ("[readdir] convert procfs")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  fs/proc/base.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 3851bfcdba56..254cc6ac65fb 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2332,8 +2332,10 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>  		goto out_put_task;
>  
>  	mm = get_task_mm(task);
> -	if (!mm)
> +	if (!mm) {
> +		ret = -ENOENT;
>  		goto out_put_task;
> +	}
>  
>  	ret = mmap_read_lock_killable(mm);

Is there something in particular that makes you think that returning ENOENT is
the correct behavior in this case?  Try 'ls /proc/$pid/map_files' where pid is a
kernel thread; it's an empty directory, which is probably intentional.  Your
patch would change reading the directory to fail with ENOENT.

- Eric
