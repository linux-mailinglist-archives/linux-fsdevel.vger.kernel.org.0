Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEEF2F17FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 15:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbhAKOWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 09:22:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:42166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbhAKOWS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:22:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610374892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JuR0HuBMLIDnEYv5E22nWr8owemJ74DzkLUjmpc1fUw=;
        b=uTNG2XeJedGaESO9SdJgAo+QP6NFhhtFGRGI2VjGWXe+u+AaFrSb2xTfqqIewR4iyBi9Xv
        +dCepl6KmWHYj5Hi4tyjyQZjlZ8KJujGzMxzj5E42CrbV/IAz8WliOJ00BlsUABM4xTe6o
        4CSBlbTJjogXqaPkcvtMqf4Vit0mG70=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 217F2B73F;
        Mon, 11 Jan 2021 14:21:32 +0000 (UTC)
Date:   Mon, 11 Jan 2021 15:21:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        yzaikin@google.com, adobriyan@gmail.com,
        linux-fsdevel@vger.kernel.org, vbabka@suse.cz, wangle6@huawei.com
Subject: Re: [PATCH v2] proc_sysctl: fix oops caused by incorrect command
 parameters.
Message-ID: <20210111142131.GA22493@dhcp22.suse.cz>
References: <20210108023339.55917-1-nixiaoming@huawei.com>
 <20210108092145.GX13207@dhcp22.suse.cz>
 <829bbba0-d3bb-a114-af81-df7390082958@huawei.com>
 <20210108114718.GA13207@dhcp22.suse.cz>
 <202101081152.0CB22390@keescook>
 <20210108201025.GA17019@dhcp22.suse.cz>
 <20210108175008.da3c60a6e402f5f1ddab2a65@linux-foundation.org>
 <bc098af4-c0cd-212e-d09d-46d617d0acab@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc098af4-c0cd-212e-d09d-46d617d0acab@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 11-01-21 11:48:19, Xiaoming Ni wrote:
[...]
> patch3:
> 	+++ b/fs/proc/proc_sysctl.c
> 	@@ -1770,6 +1770,9 @@ static int process_sysctl_arg(char *param, char *val,
> 							return 0;
> 			}
> 
> 	+       if (!val)
> 	+               return -EINVAL;
> 	+
> 			/*
> 			 * To set sysctl options, we use a temporary mount of proc, look up the
> 			 * respective sys/ file and write to it. To avoid mounting it when no
> 
> sysctl log for patch3:
> 	Setting sysctl args: `' invalid for parameter `hung_task_panic'
[...]
> When process_sysctl_arg() is called, the param parameter may not be the
> sysctl parameter.
> 
> Patch3 or patch4, which is better?

Patch3

-- 
Michal Hocko
SUSE Labs
