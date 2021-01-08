Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B892EF871
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 20:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbhAHT5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 14:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbhAHT5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:57:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78148C061381
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 11:56:36 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g3so6236649plp.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jan 2021 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R4SPTHSIUd+VlaCh32aVSBkToD1GOPyHGJmjtMY2nAc=;
        b=S7LvBMBESxvowA//Ymxnxlz5W5RNEDsPW26b6jwpZbxfGlMZfqYOjqg5jLGglciuIr
         a980IiucU+skQrBdthDD1xK/bePVGH3h34OnGQRTV1e+E+F9LV+b0K/jrGywWvW24xie
         /l+FC4c32K4+xqdOpb6Jq54hH2OFSfx0r/P8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4SPTHSIUd+VlaCh32aVSBkToD1GOPyHGJmjtMY2nAc=;
        b=C4NwoxaGzbXUYc9o/FOnsCN0HzkkdeGG5c2izgBMU2lnXSJ0zsphX4iCuAtggmCH7/
         XXMVdHuwd5zV4V5jB+0IdET56Vm2rcxfeED7xdBmpdS/jGsw6yFWmRuTLreo+u1SqXuK
         FifWE5RTt82gL7V4VAuFL3n86xdCJWTu706qVp+zwMZfdH92ivNKvyFEp8+Z15I4yyO3
         7tePclBhXoWvwpPPE7J4Ej3nLXE+VYNakfPArk+fs4xG8Hc7/QVJIMrZVNomfxLSplVO
         ALw1tvpbNNwvIw5V1b7+S2MjsuntuT1JFDS5K9L41B1wFoEm3NjHWbMftW39SzJxsEk7
         3PtQ==
X-Gm-Message-State: AOAM533ghBJB+CCfl0ICxJYFSPtk29HeF4HQvhOAZw6ZD2vVzC8ymO0s
        31uve/Xi4qSmEXFEaLzOD1KkSQ==
X-Google-Smtp-Source: ABdhPJwNfsCsgsNiBAlvV6/M/HnULmqUZTkWD35XvXYJbvquqAE4dzZDChGgGLvbXOpsF7AcC53+Cw==
X-Received: by 2002:a17:902:bcc6:b029:db:e257:9050 with SMTP id o6-20020a170902bcc6b02900dbe2579050mr5413933pls.22.1610135795867;
        Fri, 08 Jan 2021 11:56:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 19sm9669252pfu.85.2021.01.08.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 11:56:35 -0800 (PST)
Date:   Fri, 8 Jan 2021 11:56:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        linux-fsdevel@vger.kernel.org, vbabka@suse.cz,
        akpm@linux-foundation.org, wangle6@huawei.com
Subject: Re: [PATCH v2] proc_sysctl: fix oops caused by incorrect command
 parameters.
Message-ID: <202101081152.0CB22390@keescook>
References: <20210108023339.55917-1-nixiaoming@huawei.com>
 <20210108092145.GX13207@dhcp22.suse.cz>
 <829bbba0-d3bb-a114-af81-df7390082958@huawei.com>
 <20210108114718.GA13207@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108114718.GA13207@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:47:18PM +0100, Michal Hocko wrote:
> On Fri 08-01-21 18:01:52, Xiaoming Ni wrote:
> > On 2021/1/8 17:21, Michal Hocko wrote:
> > > On Fri 08-01-21 10:33:39, Xiaoming Ni wrote:
> > > > The process_sysctl_arg() does not check whether val is empty before
> > > >   invoking strlen(val). If the command line parameter () is incorrectly
> > > >   configured and val is empty, oops is triggered.
> > > > 
> > > > For example, "hung_task_panic=1" is incorrectly written as "hung_task_panic".
> > > > 
> > > > log:
> > > > 	Kernel command line: .... hung_task_panic
> > > > 	....
> > > > 	[000000000000000n] user address but active_mm is swapper
> > > > 	Internal error: Oops: 96000005 [#1] SMP
> > > > 	Modules linked in:
> > > > 	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.1 #1
> > > > 	Hardware name: linux,dummy-virt (DT)
> > > > 	pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
> > > > 	pc : __pi_strlen+0x10/0x98
> > > > 	lr : process_sysctl_arg+0x1e4/0x2ac
> > > > 	sp : ffffffc01104bd40
> > > > 	x29: ffffffc01104bd40 x28: 0000000000000000
> > > > 	x27: ffffff80c0a4691e x26: ffffffc0102a7c8c
> > > > 	x25: 0000000000000000 x24: ffffffc01104be80
> > > > 	x23: ffffff80c22f0b00 x22: ffffff80c02e28c0
> > > > 	x21: ffffffc0109f9000 x20: 0000000000000000
> > > > 	x19: ffffffc0107c08de x18: 0000000000000003
> > > > 	x17: ffffffc01105d000 x16: 0000000000000054
> > > > 	x15: ffffffffffffffff x14: 3030253078413830
> > > > 	x13: 000000000000ffff x12: 0000000000000000
> > > > 	x11: 0101010101010101 x10: 0000000000000005
> > > > 	x9 : 0000000000000003 x8 : ffffff80c0980c08
> > > > 	x7 : 0000000000000000 x6 : 0000000000000002
> > > > 	x5 : ffffff80c0235000 x4 : ffffff810f7c7ee0
> > > > 	x3 : 000000000000043a x2 : 00bdcc4ebacf1a54
> > > > 	x1 : 0000000000000000 x0 : 0000000000000000
> > > > 	Call trace:
> > > > 	 __pi_strlen+0x10/0x98
> > > > 	 parse_args+0x278/0x344
> > > > 	 do_sysctl_args+0x8c/0xfc
> > > > 	 kernel_init+0x5c/0xf4
> > > > 	 ret_from_fork+0x10/0x30
> > > > 	Code: b200c3eb 927cec01 f2400c07 54000301 (a8c10c22)
> > > > 
> > > > Fixes: 3db978d480e2843 ("kernel/sysctl: support setting sysctl parameters
> > > >   from kernel command line")
> > > > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > > 
> > > Thanks for catching this!
> > > 
> > > > ---------
> > > > v2:
> > > >     Added log output of the failure branch based on the review comments of Kees Cook.
> > > > v1: https://lore.kernel.org/lkml/20201224074256.117413-1-nixiaoming@huawei.com/
> > > > ---------
> > > > ---
> > > >   fs/proc/proc_sysctl.c | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > > > index 317899222d7f..dc1a56515e86 100644
> > > > --- a/fs/proc/proc_sysctl.c
> > > > +++ b/fs/proc/proc_sysctl.c
> > > > @@ -1757,6 +1757,11 @@ static int process_sysctl_arg(char *param, char *val,
> > > >   	loff_t pos = 0;
> > > >   	ssize_t wret;
> > > > +	if (!val) {
> > > > +		pr_err("Missing param value! Expected '%s=...value...'\n", param);
> > > > +		return 0;
> > I may need to move the validation code for val to the end of the validation
> > code for param to prevent non-sysctl arguments from triggering the current
> > print.
> 
> Why would that matter? A missing value is clearly a error path and it
> should be reported.

This test is in the correct place. I think it's just a question of the
return values.

> > Or delete the print and keep it silent for a little better performance.
> > Which is better?
> 
> I do not think there is a performance argument on the table. The generic
> code is returning EINVAL on a missing value where it is needed. Sysctl
> all require a value IIRC so EINVAL would be the right way to report
> this and let the generic code to complain.

The reason the others do a "return 0" is because other error conditions
will end up double-reporting:

                switch (ret) {
                case 0:
                        continue;
                case -ENOENT:
                        pr_err("%s: Unknown parameter `%s'\n", doing, param);
                        break;
                case -ENOSPC:
                        pr_err("%s: `%s' too large for parameter `%s'\n",
                               doing, val ?: "", param);
                        break;
                default:
                        pr_err("%s: `%s' invalid for parameter `%s'\n",
                               doing, val ?: "", param);
                        break;
                }

Also note that where the sysctl parsing happens, it calls parse_args()
without checking return codes, so that doesn't matter either.

It's possible that doing this would be sufficient, though:

+	if (!val)
+		return -EINVAL;

Since that would hit the "default" error report which looks reasonable.

-- 
Kees Cook
