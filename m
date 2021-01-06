Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFF32EC70F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 00:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbhAFXrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 18:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbhAFXrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:47:22 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87C8C061786
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 15:46:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id s15so2351916plr.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 15:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tA11nn9ae5cvgWVfh9wtHtDpSHe6PyopJBRnKzHppXM=;
        b=KQgESEvYY2Vkv50quj7FiQWHW0q6YXGW1PWoPHh6FSygQCBplRYdtGIjRMoKBCvfMH
         KEfAgvs2NWtTKBgOaaoIoSbPZtkPZnPZJAhE1P8LCEsEF1cXINtiXtQceXs9f+0HbSIo
         ZOj6S65EwepaYZVCHyHz56+4SEW8azhvCtrus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tA11nn9ae5cvgWVfh9wtHtDpSHe6PyopJBRnKzHppXM=;
        b=L8K3rvfHJbuIWhm/9zbSyxPk5USRPt828znRlCwclgz9YibLsDSXOVF/GjkKsHlqYb
         8oWWGq8y1qwHQ+/nyGxPpDVEUmBJo/GCUYL5AgChxMm+1h8ia3XsrdzKYgM7m+X3H17j
         UVSuabpIdh/QgE33GEnYUpm/W5bKQwx0+WHU+A/RTnDQFK3NBUkXsNJfsDjwlAriZ0rN
         0nM995pTEf02HlLa3EyQCr+xWutDc9oS0K1a9gGQdoAsrryV6aqoR4jvwGSGtfI889q6
         frtT+UctkDHu5S63fmmfLKd3ph/RsXaGUfKDopXg6o1xHsTUinuVSUVbwPMRVVbkoNaZ
         9xEA==
X-Gm-Message-State: AOAM531FjbgA0jLSpqajST0ESJZ0VBRH+mlqW4KHxdo/G2gbm3Mgs3IZ
        6JxuV2YnU7ZttGYT/IszBdC4IQ==
X-Google-Smtp-Source: ABdhPJwI81mzLEY+LJZAtfAoi1S/rKxmaN04K7UCpg8GFh53qvuGjRpnBd7jeLLhTbMFrxNf4WCBCw==
X-Received: by 2002:a17:90a:db96:: with SMTP id h22mr6501306pjv.204.1609976801211;
        Wed, 06 Jan 2021 15:46:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j20sm3638718pfd.106.2021.01.06.15.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 15:46:40 -0800 (PST)
Date:   Wed, 6 Jan 2021 15:46:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        yzaikin@google.com, adobriyan@gmail.com, vbabka@suse.cz,
        linux-fsdevel@vger.kernel.org, mhocko@suse.com,
        mhiramat@kernel.org, wangle6@huawei.com
Subject: Re: [PATCH] proc_sysclt: fix oops caused by incorrect command
 parameters.
Message-ID: <202101061539.966EBB293@keescook>
References: <20201224074256.117413-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224074256.117413-1-nixiaoming@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

subject typo: "sysclt" -> "sysctl"

On Thu, Dec 24, 2020 at 03:42:56PM +0800, Xiaoming Ni wrote:
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
> ---
>  fs/proc/proc_sysctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 317899222d7f..4516411a2b44 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1757,6 +1757,9 @@ static int process_sysctl_arg(char *param, char *val,
>  	loff_t pos = 0;
>  	ssize_t wret;
>  
> +	if (!val)
> +		return 0;
> +
>  	if (strncmp(param, "sysctl", sizeof("sysctl") - 1) == 0) {
>  		param += sizeof("sysctl") - 1;

Otherwise, yeah, this is a good test to add. I would make it more
verbose, though:

	if (!val) {
		pr_err("Missing param value! Expected '%s=...value...'\n", param);
		return 0;
	}

-- 
Kees Cook
