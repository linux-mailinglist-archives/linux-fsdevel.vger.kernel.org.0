Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964E92EEF6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 10:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbhAHJWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 04:22:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:48696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbhAHJWe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:22:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610097707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JufPMU+Z5aR6Jq7ic5Qmbg6VVDO0Iuq2jNr22wPn5iw=;
        b=cBm6D/5oAs+bA8Z6AMyV9IXMZYJ0/WHmfIYxKdIDNbu5PCAPETyycJVL/pipG2FAB/SyIb
        fmHWV3oR6BiVTkbNwBYlrn6Ka8xmHsqpdxVKYYIA6pSS1iugshjPVYD5V2OrRcwNDdf8i+
        X1St1s7PG1OiOYcF+ugUj8cPhE9TX4U=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B563AFBF;
        Fri,  8 Jan 2021 09:21:47 +0000 (UTC)
Date:   Fri, 8 Jan 2021 10:21:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, adobriyan@gmail.com,
        linux-fsdevel@vger.kernel.org, vbabka@suse.cz,
        akpm@linux-foundation.org, wangle6@huawei.com
Subject: Re: [PATCH v2] proc_sysctl: fix oops caused by incorrect command
 parameters.
Message-ID: <20210108092145.GX13207@dhcp22.suse.cz>
References: <20210108023339.55917-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108023339.55917-1-nixiaoming@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-01-21 10:33:39, Xiaoming Ni wrote:
> The process_sysctl_arg() does not check whether val is empty before
>  invoking strlen(val). If the command line parameter () is incorrectly
>  configured and val is empty, oops is triggered.
> 
> For example, "hung_task_panic=1" is incorrectly written as "hung_task_panic".
> 
> log:
> 	Kernel command line: .... hung_task_panic
> 	....
> 	[000000000000000n] user address but active_mm is swapper
> 	Internal error: Oops: 96000005 [#1] SMP
> 	Modules linked in:
> 	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.1 #1
> 	Hardware name: linux,dummy-virt (DT)
> 	pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
> 	pc : __pi_strlen+0x10/0x98
> 	lr : process_sysctl_arg+0x1e4/0x2ac
> 	sp : ffffffc01104bd40
> 	x29: ffffffc01104bd40 x28: 0000000000000000
> 	x27: ffffff80c0a4691e x26: ffffffc0102a7c8c
> 	x25: 0000000000000000 x24: ffffffc01104be80
> 	x23: ffffff80c22f0b00 x22: ffffff80c02e28c0
> 	x21: ffffffc0109f9000 x20: 0000000000000000
> 	x19: ffffffc0107c08de x18: 0000000000000003
> 	x17: ffffffc01105d000 x16: 0000000000000054
> 	x15: ffffffffffffffff x14: 3030253078413830
> 	x13: 000000000000ffff x12: 0000000000000000
> 	x11: 0101010101010101 x10: 0000000000000005
> 	x9 : 0000000000000003 x8 : ffffff80c0980c08
> 	x7 : 0000000000000000 x6 : 0000000000000002
> 	x5 : ffffff80c0235000 x4 : ffffff810f7c7ee0
> 	x3 : 000000000000043a x2 : 00bdcc4ebacf1a54
> 	x1 : 0000000000000000 x0 : 0000000000000000
> 	Call trace:
> 	 __pi_strlen+0x10/0x98
> 	 parse_args+0x278/0x344
> 	 do_sysctl_args+0x8c/0xfc
> 	 kernel_init+0x5c/0xf4
> 	 ret_from_fork+0x10/0x30
> 	Code: b200c3eb 927cec01 f2400c07 54000301 (a8c10c22)
> 
> Fixes: 3db978d480e2843 ("kernel/sysctl: support setting sysctl parameters
>  from kernel command line")
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Thanks for catching this!

> ---------
> v2:
>    Added log output of the failure branch based on the review comments of Kees Cook.
> v1: https://lore.kernel.org/lkml/20201224074256.117413-1-nixiaoming@huawei.com/
> ---------
> ---
>  fs/proc/proc_sysctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 317899222d7f..dc1a56515e86 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1757,6 +1757,11 @@ static int process_sysctl_arg(char *param, char *val,
>  	loff_t pos = 0;
>  	ssize_t wret;
>  
> +	if (!val) {
> +		pr_err("Missing param value! Expected '%s=...value...'\n", param);
> +		return 0;
> +	}

Shouldn't you return an error here? Also my understanding is that
parse_args is responsible for reporting the error.

> +
>  	if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
>  		param += sizeof("sysctl") - 1;
>  
> -- 
> 2.27.0

-- 
Michal Hocko
SUSE Labs
