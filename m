Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A44C6E26B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 17:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjDNPSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 11:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjDNPSC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:18:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DA02D78;
        Fri, 14 Apr 2023 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=1zvOv9GfpoYzPQgu2dV2BHsiyqH+yrGSH0VX1lFo210=; b=qUyBwIOylBuzcrBoPBUCdda21X
        Zqwz9IC/4mvVmnE0+bu07RjCCDVEi7bKEUdcEmMTWPxTMGuxmcDEzYrCnLVaVzcPOxJTYXfydV5Mi
        r6tzGu134C8TAEOFZXKRy/1blRC6qQRabbVYxdzMUh9Xf+KbtKyzta3Zen+JxB3c0m6+zQfoh1ep9
        Jyisu/woZQglASPwH1H+islTNzQz4vyQKMf8mWQ+PEwuv0bEJeiwMpHqDJAlUDWa3RRzoGEv7ac41
        serGsfUP1f/5j+VbBetsqnzDUzplJNzEuMacc7IVIWQ+oMqlKF4SbSzpv3S/dYCro53t6NcBrWd9V
        95jLxXvw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pnLBX-009vPh-0k;
        Fri, 14 Apr 2023 15:17:59 +0000
Message-ID: <78b365a7-0a4d-6606-ccac-239cd8e632b3@infradead.org>
Date:   Fri, 14 Apr 2023 08:17:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] fs/proc: add Kthread flag to /proc/$pid/status
Content-Language: en-US
To:     Chunguang Wu <fullspring2018@gmail.com>, akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230414092751.10636-1-fullspring2018@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230414092751.10636-1-fullspring2018@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 4/14/23 02:27, Chunguang Wu wrote:
> The command `ps -ef ` and `top -c` mark kernel thread by '['
> and ']', but sometimes the result is not correct.
> The task->flags in /proc/$pid/stat is good, but we need remember
> the value of PF_KTHREAD is 0x00200000 and convert dec to hex.
> If we have no binary program and shell script which read
> /proc/$pid/stat, we can know it directly by
> `cat /proc/$pid/status`.
> 

Please update Documentation/filesystems/proc.rst:

(1) the example:
For example, to get the status information of a process, all you have to do is
read the file /proc/PID/status::

and (2): table 1-2

Thanks.

> Signed-off-by: Chunguang Wu <fullspring2018@gmail.com>
> ---
>  fs/proc/array.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
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
>  	if (mm) {
>  		task_mem(m, mm);
>  		task_core_dumping(m, task);

-- 
~Randy
