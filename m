Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CADC6E323E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 18:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDOQDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 12:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjDOQDn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:03:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DFB3A8E;
        Sat, 15 Apr 2023 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=IvR+KTULywCa9KcsMX/Vvku+X+SUD7cXl4deynP11rw=; b=NXgdWGOJ25IYCZlHiYT0mbyGZx
        naD9urTP2DUiBJUjKQlNEH2DS40R77jvtbEq4XAy/5vWSl02rzMkRT5TAq0rbz2Nh0NH632JDAr+I
        SJgPoAJEhkTTr5JtR5IUWePoHpwTwg/zFOJ2QMkyVic84BqzLYKT9cYZjFVgv8/TvC3I8irmVZcS9
        7oJkfHnzWx/Xq5P3mWtQaBn1W5zG8JXNJivfnrkYUURJT+lI9WO0HvPCrF9WJUFjRIkrK9636g+gJ
        rMxcVteiYdZnU9nRzXRm1p4BVkyPgZ0dQHkUZ3bvrFhzarIgT8TMdSujWFBKbERhlzwtNTA0nkRqP
        BqL7H2NA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pniMy-00CPZ1-07;
        Sat, 15 Apr 2023 16:03:20 +0000
Message-ID: <dac32cfb-6cb6-613d-169e-f1445492418c@infradead.org>
Date:   Sat, 15 Apr 2023 09:03:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] fs/proc: add Kthread flag to /proc/$pid/status
Content-Language: en-US
To:     Chunguang Wu <fullspring2018@gmail.com>, akpm@linux-foundation.org,
        corbet@lwn.net
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230415082155.5298-1-fullspring2018@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230415082155.5298-1-fullspring2018@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 4/15/23 01:21, Chunguang Wu wrote:
> The command `ps -ef ` and `top -c` mark kernel thread by '['
> and ']', but sometimes the result is not correct.
> The task->flags in /proc/$pid/stat is good, but we need remember
> the value of PF_KTHREAD is 0x00200000 and convert dec to hex.
> If we have no binary program and shell script which read
> /proc/$pid/stat, we can know it directly by
> `cat /proc/$pid/status`.
> 
> Signed-off-by: Chunguang Wu <fullspring2018@gmail.com>
> ---
>  Documentation/filesystems/proc.rst | 2 ++
>  fs/proc/array.c                    | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 9d5fd9424e8b..8a563684586c 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -179,6 +179,7 @@ read the file /proc/PID/status::
>    Gid:    100     100     100     100
>    FDSize: 256
>    Groups: 100 14 16
> +  Kthread:    0
>    VmPeak:     5004 kB
>    VmSize:     5004 kB
>    VmLck:         0 kB
> @@ -256,6 +257,7 @@ It's slow but very precise.
>   NSpid                       descendant namespace process ID hierarchy
>   NSpgid                      descendant namespace process group ID hierarchy
>   NSsid                       descendant namespace session ID hierarchy
> + Kthread                     kernel thread flag, 1 is yes, 0 is no
>   VmPeak                      peak virtual memory size
>   VmSize                      total program size
>   VmLck                       locked memory size

The Documentation changes look good, except that they may need to be moved
if you do the changes indicated below.


Now that I have looked at the rest of the patch:

> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 9b0315d34c58..fde6a0b92728 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -434,6 +434,13 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
>  
>  	task_state(m, ns, pid, task);
>  
> +	seq_puts(m, "Kthread:\t");
> +	if (task->flags & PF_KTHREAD) {
> +		seq_puts(m, "1\n");
> +	} else {
> +		seq_puts(m, "0\n");
> +	}
> +

I would put that patch fragment inside task_state(), but I'll leave that
to others to decide on.

and condense it to one line, e.g.:

	seq_puts(m, "Kthread: %c\n", task->flags & PF_KTHREAD ? '1' : '0');


>  	if (mm) {
>  		task_mem(m, mm);
>  		task_core_dumping(m, task);


Please add version info to your future patches.

Thanks.
-- 
~Randy
