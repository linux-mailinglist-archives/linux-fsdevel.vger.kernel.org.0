Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB4481BA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 12:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbhL3LTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 06:19:55 -0500
Received: from smtp-8fa9.mail.infomaniak.ch ([83.166.143.169]:56341 "EHLO
        smtp-8fa9.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235325AbhL3LTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:19:54 -0500
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4JPm5P291czMqGcQ;
        Thu, 30 Dec 2021 12:19:53 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4JPm5K5jgszlkSYb;
        Thu, 30 Dec 2021 12:19:49 +0100 (CET)
Message-ID: <9281f237-3b26-f828-c4bd-2f039174be7f@digikod.net>
Date:   Thu, 30 Dec 2021 12:24:29 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org, yzaikin@google.com,
        nixiaoming@huawei.com, ebiederm@xmission.com, steve@sk2.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211129205548.605569-1-mcgrof@kernel.org>
 <20211129205548.605569-5-mcgrof@kernel.org>
 <d20861d0-8432-76d7-bcda-1b80401e0a22@digikod.net>
 <YcDYtcJG+ON1bowf@bombadil.infradead.org>
 <20211229164624.bbf08e1ed4350e97282344e2@linux-foundation.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH 4/9] sysctl: move maxolduid as a sysctl specific const
In-Reply-To: <20211229164624.bbf08e1ed4350e97282344e2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 30/12/2021 01:46, Andrew Morton wrote:
> On Mon, 20 Dec 2021 11:25:41 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
>> On Fri, Dec 17, 2021 at 05:15:01PM +0100, Mickaël Salaün wrote:
>>>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>>>> index 7dec3d5a9ed4..675b625fa898 100644
>>>> --- a/fs/proc/proc_sysctl.c
>>>> +++ b/fs/proc/proc_sysctl.c
>>>> @@ -26,7 +26,7 @@ static const struct file_operations proc_sys_dir_file_operations;
>>>>    static const struct inode_operations proc_sys_dir_operations;
>>>>    /* shared constants to be used in various sysctls */
>>>> -const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, INT_MAX };
>>>> +const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 65535, INT_MAX };
>>>
>>> The new SYSCTL_MAXOLDUID uses the index 10 of sysctl_vals[] but the same
>>> commit replaces index 8 (SYSCTL_THREE_THOUSAND used by
>>> vm.watermark_scale_factor) instead of adding a new entry.
>>>
>>> It should be:
>>> +const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, INT_MAX,
>>> 65535 };
>>
>> Can you send a proper patch which properly fixes this and identifies
>> the commit name with a Fixes tag. Since thi sis on Andrew's tree no
>> commit ID is required given that they are ephemeral.
> 
> I did this:
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: sysctl-move-maxolduid-as-a-sysctl-specific-const-fix
> 
> fix sysctl_vals[], per Mickaël.
> 
> Cc: Mickaël Salaün <mic@digikonet>

Except a typo in my email

Signed-off-by: Mickaël Salaün <mic@digikod.net>

Thanks!

> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Antti Palosaari <crope@iki.fi>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Iurii Zaikin <yzaikin@google.com>
> Cc: "J. Bruce Fields" <bfields@fieldses.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Lukas Middendorf <kernel@tuxforce.de>
> Cc: Stephen Kitt <steve@sk2.org>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   fs/proc/proc_sysctl.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/fs/proc/proc_sysctl.c~sysctl-move-maxolduid-as-a-sysctl-specific-const-fix
> +++ a/fs/proc/proc_sysctl.c
> @@ -26,7 +26,7 @@ static const struct file_operations proc
>   static const struct inode_operations proc_sys_dir_operations;
>   
>   /* shared constants to be used in various sysctls */
> -const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 65535, INT_MAX };
> +const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, 3000, INT_MAX, 65535 };
>   EXPORT_SYMBOL(sysctl_vals);
>   
>   const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
> _
> 
