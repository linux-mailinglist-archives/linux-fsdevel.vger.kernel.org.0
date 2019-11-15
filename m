Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0493BFD397
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 05:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKOENO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 23:13:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:9456 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfKOENN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 23:13:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 20:13:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,307,1569308400"; 
   d="scan'208";a="203487356"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga007.fm.intel.com with ESMTP; 14 Nov 2019 20:13:10 -0800
Date:   Fri, 15 Nov 2019 12:24:11 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20191115042411.GA11061@chenyu-office.sh.intel.com>
References: <20191107032731.7790-1-yu.c.chen@intel.com>
 <20191113182306.GB1647@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113182306.GB1647@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Boris,
Thanks for looking at the patch.
On Wed, Nov 13, 2019 at 07:23:07PM +0100, Borislav Petkov wrote:
> On Thu, Nov 07, 2019 at 11:27:31AM +0800, Chen Yu wrote:
> > Monitoring tools that want to find out which resctrl CTRL
> > and MONITOR groups a task belongs to must currently read
> > the "tasks" file in every group until they locate the process
> > ID.
> > 
> > Add an additional file /proc/{pid}/resctrl to provide this
> > information.
> > 
> > For example:
> >  cat /proc/1193/resctrl
> > CTRL_MON:/ctrl_grp0
> > MON:/ctrl_grp0/mon_groups/mon_grp0
> > 
> > If the resctrl filesystem has not been mounted,
> > reading /proc/{pid}/resctrl returns an error:
> > cat: /proc/1193/resctrl: No such device
> > 
> > Tested-by: Jinshi Chen <jinshi.chen@intel.com>
> > Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> > Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > 
> > ---
> >  arch/x86/include/asm/resctrl_sched.h   |  4 +++
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 46 ++++++++++++++++++++++++++
> >  fs/proc/base.c                         |  9 +++++
>    ^^^^^^^^^^^^^^^
> 
> So you're touching this file here and yet your Cc list doesn't have
> *anyone* who might be responsible for the proc fs (yeah, you have
> linux-fsdevel but I don't think that's enough). Have you heard of
> scripts/get_maintainer.pl?
> 
> Use it in the future.
> 
> Cc-ing some more people for the generic /proc bits.
> 
Okay, thanks.
> >  3 files changed, 59 insertions(+)
> > 
> > +
> > +		if (rdtg->closid == tsk->closid) {
> 
> Save an indentation level:
> 
> 		if (rdtg->closid != tsk->closid)
> 			continue;
> 
> 		seq_printf...
>
Okay.
> > +#ifdef CONFIG_X86_CPU_RESCTRL
> > +#include <asm/resctrl_sched.h>
> > +#endif
> 
> If anything, this should be abstracted nicely into an
> include/linux/resctrl.h header. Other architectures would probably wanna
> use it too, I hear ARM64 has something like resctrl.
>
Okay, created this header in the next version.
> > +#endif
> > +#ifdef CONFIG_X86_CPU_RESCTRL
> > +	ONE("resctrl", S_IRUGO, proc_resctrl_show),
> >  #endif
> 
> Same here. proc_resctrl_show() looks like a generic function but it
> is x86-only. Need to call the x86-specific one in a real generic
> proc_resctrl_show() which other arches can add their code to, too.
> 
> Not like that.
> 
Okay, in next version proc_resctrl_show() is declared in resctrl.h.
However since there's no common c source file for resctrl currently,
different architectures might need to implement proc_resctrl_show()
accordingly - currently only x86 needs to do that.

Thanks,
Chenyu
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
