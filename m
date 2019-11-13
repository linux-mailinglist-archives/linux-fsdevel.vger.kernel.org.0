Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA8FB748
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 19:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKMSXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 13:23:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59134 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfKMSXO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:23:14 -0500
Received: from zn.tnic (p200300EC2F0FA700D5A2A5422FC158AE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:a700:d5a2:a542:2fc1:58ae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9842B1EC0CDA;
        Wed, 13 Nov 2019 19:23:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573669392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UKGEADetohk5qnCPK5X+HcgpaPOf5iaScVD2zi3G9cU=;
        b=VuoILmImVGHmfiqvnbpZZdD8095ET1xkoBZuUD/WaoOUnEYmXBkCMNQM215PWj1wep434q
        ELIldMMtM5Xlw8zi4oOMie7xRpPgNDBXvqD6zL8OyBeH4x/XjYmayI9XegTsNfAlvyI6DW
        6RZPN1xtkDS+I+buWAhVOUYnm3RlBr4=
Date:   Wed, 13 Nov 2019 19:23:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/resctrl: Add task resctrl information display
Message-ID: <20191113182306.GB1647@zn.tnic>
References: <20191107032731.7790-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107032731.7790-1-yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 07, 2019 at 11:27:31AM +0800, Chen Yu wrote:
> Monitoring tools that want to find out which resctrl CTRL
> and MONITOR groups a task belongs to must currently read
> the "tasks" file in every group until they locate the process
> ID.
> 
> Add an additional file /proc/{pid}/resctrl to provide this
> information.
> 
> For example:
>  cat /proc/1193/resctrl
> CTRL_MON:/ctrl_grp0
> MON:/ctrl_grp0/mon_groups/mon_grp0
> 
> If the resctrl filesystem has not been mounted,
> reading /proc/{pid}/resctrl returns an error:
> cat: /proc/1193/resctrl: No such device
> 
> Tested-by: Jinshi Chen <jinshi.chen@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> 
> ---
>  arch/x86/include/asm/resctrl_sched.h   |  4 +++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 46 ++++++++++++++++++++++++++
>  fs/proc/base.c                         |  9 +++++
   ^^^^^^^^^^^^^^^

So you're touching this file here and yet your Cc list doesn't have
*anyone* who might be responsible for the proc fs (yeah, you have
linux-fsdevel but I don't think that's enough). Have you heard of
scripts/get_maintainer.pl?

Use it in the future.

Cc-ing some more people for the generic /proc bits.

>  3 files changed, 59 insertions(+)
> 
> diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/resctrl_sched.h
> index f6b7fe2833cc..bba362e0e00f 100644
> --- a/arch/x86/include/asm/resctrl_sched.h
> +++ b/arch/x86/include/asm/resctrl_sched.h
> @@ -5,6 +5,7 @@
>  #ifdef CONFIG_X86_CPU_RESCTRL
>  
>  #include <linux/sched.h>
> +#include <linux/proc_fs.h>
>  #include <linux/jump_label.h>
>  
>  #define IA32_PQR_ASSOC	0x0c8f
> @@ -84,6 +85,9 @@ static inline void resctrl_sched_in(void)
>  		__resctrl_sched_in();
>  }
>  
> +int proc_resctrl_show(struct seq_file *m, struct pid_namespace *ns,
> +		      struct pid *pid, struct task_struct *tsk);
> +
>  #else
>  
>  static inline void resctrl_sched_in(void) {}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index a46dee8e78db..2317174174e9 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -727,6 +727,52 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
> +		      struct pid *pid, struct task_struct *tsk)
> +{
> +	struct rdtgroup *rdtg;
> +	int ret = 0;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	/* Make sure resctrl has been mounted. */
> +	if (!static_branch_unlikely(&rdt_enable_key)) {
> +		ret = -ENODEV;
> +		goto unlock;
> +	}
> +
> +	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +		struct rdtgroup *crg;
> +
> +		/*
> +		 * Task information is only relevant for shareable
> +		 * and exclusive groups.
> +		 */
> +		if (rdtg->mode != RDT_MODE_SHAREABLE &&
> +		    rdtg->mode != RDT_MODE_EXCLUSIVE)
> +			continue;
> +
> +		if (rdtg->closid == tsk->closid) {

Save an indentation level:

		if (rdtg->closid != tsk->closid)
			continue;

		seq_printf...

> +			seq_printf(s, "CTRL_MON:/%s\n", rdtg->kn->name);
> +			list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> +					    mon.crdtgrp_list) {
> +				if (tsk->rmid != crg->mon.rmid)
> +					continue;
> +				seq_printf(s, "MON:%s%s/mon_groups/%s\n",
> +					   rdtg == &rdtgroup_default ? "" : "/",
> +					   rdtg->kn->name, crg->kn->name);
> +				goto unlock;
> +			}
> +			goto unlock;
> +		}
> +	}
> +	ret = -ENOENT;
> +unlock:
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return ret;
> +}
> +
>  static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
>  				    struct seq_file *seq, void *v)
>  {
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ebea9501afb8..d8a61db78db5 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -95,6 +95,9 @@
>  #include <linux/sched/stat.h>
>  #include <linux/posix-timers.h>
>  #include <trace/events/oom.h>
> +#ifdef CONFIG_X86_CPU_RESCTRL
> +#include <asm/resctrl_sched.h>
> +#endif

If anything, this should be abstracted nicely into an
include/linux/resctrl.h header. Other architectures would probably wanna
use it too, I hear ARM64 has something like resctrl.

>  #include "internal.h"
>  #include "fd.h"
>  
> @@ -3060,6 +3063,9 @@ static const struct pid_entry tgid_base_stuff[] = {
>  #endif
>  #ifdef CONFIG_CGROUPS
>  	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
> +#endif
> +#ifdef CONFIG_X86_CPU_RESCTRL
> +	ONE("resctrl", S_IRUGO, proc_resctrl_show),
>  #endif
>  	ONE("oom_score",  S_IRUGO, proc_oom_score),
>  	REG("oom_adj",    S_IRUGO|S_IWUSR, proc_oom_adj_operations),
> @@ -3460,6 +3466,9 @@ static const struct pid_entry tid_base_stuff[] = {
>  #endif
>  #ifdef CONFIG_CGROUPS
>  	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
> +#endif
> +#ifdef CONFIG_X86_CPU_RESCTRL
> +	ONE("resctrl", S_IRUGO, proc_resctrl_show),
>  #endif

Same here. proc_resctrl_show() looks like a generic function but it
is x86-only. Need to call the x86-specific one in a real generic
proc_resctrl_show() which other arches can add their code to, too.

Not like that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
