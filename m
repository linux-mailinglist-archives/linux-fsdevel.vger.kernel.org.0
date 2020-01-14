Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA16C13A3BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 10:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgANJY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 04:24:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45848 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgANJY7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:24:59 -0500
Received: from zn.tnic (p200300EC2F0C7700ADC3CAC9BB95AB92.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7700:adc3:cac9:bb95:ab92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 13E9D1EC0C76;
        Tue, 14 Jan 2020 10:24:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578993898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lCPS559Qb2dkos6z5zHaZpTmRiSzeCBjtEVcicxIAhk=;
        b=TAfXd23q2G31h+y6K9ys2x9wxFX0poAJ6s/65OyI0W4MRRtWsM3q/2ee2IGoJBOmdkwMG5
        9rEEIlATqqvsYcdbqdsZfTTgkUFlH0Bs4+3WG1rIMuoWjVtTMu7Mqt5ZDht/qYpY+ZSzKL
        XJaydJSSUaf7LmAn7axl/FsLIcdmC6U=
Date:   Tue, 14 Jan 2020 10:24:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     x86@kernel.org, Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Chris Down <chris@chrisdown.name>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v6] x86/resctrl: Add task resctrl information display
Message-ID: <20200114092450.GA31032@zn.tnic>
References: <20200110070608.18902-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110070608.18902-1-yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 10, 2020 at 03:06:08PM +0800, Chen Yu wrote:
> Monitoring tools that want to find out which resctrl control
> and monitor groups a task belongs to must currently read
> the "tasks" file in every group until they locate the process
> ID.
> 
> Add an additional file /proc/{pid}/cpu_resctrl to provide this
> information.
> 
> The output is as followed, for example:
> 
>  1)   ""
>       Resctrl is not available.
> 
>  2)   "/"
>       Task is part of the root group, task is not associated to
>       any monitor group.
> 
>  3)   "/mon_groups/mon0"
>       Task is part of the root group and monitor group mon0.
> 
>  4)   "/group0"
>       Task is part of resctrl control group group0, task is not
>       associated to any monitor group.
> 
>  5)   "/group0/mon_groups/mon1"
>       Task is part of resctrl control group group0 and monitor
>       group mon1.

So this way to present the information is totally non-intuitive,
IMNSVHO. What's wrong with:

1)
	res_group:
	mon_group:

2)
	res_group: /
	mon_group:

3)
	res_group: /
	mon_group: mon0

4)
	res_group: group0
	mon_group:

5)
	res_group: group0
	mon_group: mon1

?

You can even call the file "cpu_resctrl_groups" so that it is clear that
it will dump groups and then do:

	res: group0
	mon: mon1

which is both human-readable and easily greppable.

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 2e3b06d6bbc6..dcbf62d6b689 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -725,6 +725,85 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PROC_CPU_RESCTRL
> +
> +/*
> + * A task can only be part of one resctrl
> + * control group and of one monitor
> + * group which is associated to that resctrl
> + * control group.

Extend those comments to 80 cols.

> + * So one line is simple and clear enough:

Actually, the one line format you've done is confusing and can be done
much more human- and tool-readable.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
