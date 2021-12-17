Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48907479108
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 17:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbhLQQMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 11:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238885AbhLQQMx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:12:53 -0500
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2F1C06173E
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Dec 2021 08:12:53 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4JFvCQ0TrvzMqY50;
        Fri, 17 Dec 2021 17:12:50 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4JFvCL6NPdzlj3vw;
        Fri, 17 Dec 2021 17:12:46 +0100 (CET)
Message-ID: <d20861d0-8432-76d7-bcda-1b80401e0a22@digikod.net>
Date:   Fri, 17 Dec 2021 17:15:01 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, keescook@chromium.org, yzaikin@google.com,
        nixiaoming@huawei.com, ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, andriy.shevchenko@linux.intel.com,
        jlayton@kernel.org, bfields@fieldses.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211129205548.605569-1-mcgrof@kernel.org>
 <20211129205548.605569-5-mcgrof@kernel.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH 4/9] sysctl: move maxolduid as a sysctl specific const
In-Reply-To: <20211129205548.605569-5-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces a bug in -next:

On 29/11/2021 21:55, Luis Chamberlain wrote:
> The maxolduid value is only shared for sysctl purposes for
> use on a max range. Just stuff this into our shared const
> array.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   fs/proc/proc_sysctl.c  |  2 +-
>   include/linux/sysctl.h |  3 +++
>   kernel/sysctl.c        | 12 ++++--------
>   3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 7dec3d5a9ed4..675b625fa898 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -26,7 +26,7 @@ static const struct file_operations proc_sys_dir_file_operations;
>   static const struct inode_operations proc_sys_dir_operations;
>   
>   /* shared constants to be used in various sysctls */
> -const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, INT_MAX };
> +const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 65535, INT_MAX };

The new SYSCTL_MAXOLDUID uses the index 10 of sysctl_vals[] but the same
commit replaces index 8 (SYSCTL_THREE_THOUSAND used by
vm.watermark_scale_factor) instead of adding a new entry.

It should be:
+const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, 
INT_MAX, 65535 };



>   EXPORT_SYMBOL(sysctl_vals);
>   
>   const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 2de6d20d191b..bb921eb8a02d 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -49,6 +49,9 @@ struct ctl_dir;
>   #define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[8])
>   #define SYSCTL_INT_MAX			((void *)&sysctl_vals[9])
>   
> +/* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
> +#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[10])
> +
>   extern const int sysctl_vals[];
>   
>   #define SYSCTL_LONG_ZERO	((void *)&sysctl_long_vals[0])
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index dbd267d0f014..05d9dd85e17f 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -109,10 +109,6 @@ static const int six_hundred_forty_kb = 640 * 1024;
>   /* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
>   static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
>   
> -/* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
> -static const int maxolduid = 65535;
> -/* minolduid is SYSCTL_ZERO */
> -
>   static const int ngroups_max = NGROUPS_MAX;
>   static const int cap_last_cap = CAP_LAST_CAP;
>   
> @@ -2126,7 +2122,7 @@ static struct ctl_table kern_table[] = {
>   		.mode		= 0644,
>   		.proc_handler	= proc_dointvec_minmax,
>   		.extra1		= SYSCTL_ZERO,
> -		.extra2		= (void *)&maxolduid,
> +		.extra2		= SYSCTL_MAXOLDUID,
>   	},
>   	{
>   		.procname	= "overflowgid",
> @@ -2135,7 +2131,7 @@ static struct ctl_table kern_table[] = {
>   		.mode		= 0644,
>   		.proc_handler	= proc_dointvec_minmax,
>   		.extra1		= SYSCTL_ZERO,
> -		.extra2		= (void *)&maxolduid,
> +		.extra2		= SYSCTL_MAXOLDUID,
>   	},
>   #ifdef CONFIG_S390
>   	{
> @@ -2907,7 +2903,7 @@ static struct ctl_table fs_table[] = {
>   		.mode		= 0644,
>   		.proc_handler	= proc_dointvec_minmax,
>   		.extra1		= SYSCTL_ZERO,
> -		.extra2		= (void *)&maxolduid,
> +		.extra2		= SYSCTL_MAXOLDUID,
>   	},
>   	{
>   		.procname	= "overflowgid",
> @@ -2916,7 +2912,7 @@ static struct ctl_table fs_table[] = {
>   		.mode		= 0644,
>   		.proc_handler	= proc_dointvec_minmax,
>   		.extra1		= SYSCTL_ZERO,
> -		.extra2		= (void *)&maxolduid,
> +		.extra2		= SYSCTL_MAXOLDUID,
>   	},
>   #ifdef CONFIG_FILE_LOCKING
>   	{
> 
