Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4151086D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 04:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKYD2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 22:28:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:18031 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKYD2j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 22:28:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 19:28:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,240,1571727600"; 
   d="scan'208";a="239353795"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga002.fm.intel.com with ESMTP; 24 Nov 2019 19:28:36 -0800
Date:   Mon, 25 Nov 2019 11:39:30 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH][v4] x86/resctrl: Add task resctrl information display
Message-ID: <20191125033930.GA28301@chenyu-office.sh.intel.com>
References: <20191122095833.20861-1-yu.c.chen@intel.com>
 <20191124132513.GA30453@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191124132513.GA30453@avx2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alexey,
thanks for looking at this patch.
On Sun, Nov 24, 2019 at 04:25:13PM +0300, Alexey Dobriyan wrote:
> On Fri, Nov 22, 2019 at 05:58:33PM +0800, Chen Yu wrote:
> > Monitoring tools that want to find out which resctrl control
> > and monitor groups a task belongs to must currently read
> > the "tasks" file in every group until they locate the process
> > ID.
> > 
> > Add an additional file /proc/{pid}/resctrl to provide this
> > information.
> 
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> 
> > +		seq_printf(s, "/%s", rdtg->kn->name);
> > +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> > +				    mon.crdtgrp_list) {
> > +			if (tsk->rmid != crg->mon.rmid)
> > +				continue;
> > +			seq_printf(s, "%smon_groups/%s",
> > +				   rdtg == &rdtgroup_default ? "" : "/",
> > +				   crg->kn->name);
> > +			break;
> > +		}
> > +		seq_puts(s, "\n");
> 
> This should be seq_putc().
> 
> 
Okay, changed in next version.
> > --- /dev/null
> > +++ b/include/linux/resctrl.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _RESCTRL_H
> > +#define _RESCTRL_H
> > +
> > +#ifdef CONFIG_PROC_CPU_RESCTRL
> > +
> > +#include <linux/proc_fs.h>
> 
> Forward declaring stuff should be more than enough.
> 
Okay, deleted in next version.
Then after removing this header, the .c files(besides proc/fs/base.c)
who include resctrl.h should be responsible to import corresondling
headers themselves.

Thanks,
Chenyu
> > +int proc_resctrl_show(struct seq_file *m,
> > +		      struct pid_namespace *ns,
> > +		      struct pid *pid,
> > +		      struct task_struct *tsk);
> > +
> > +#endif
> > +
> > +#endif /* _RESCTRL_H */
