Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EE422A151
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 23:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgGVVY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 17:24:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:22865 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgGVVY4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:24:56 -0400
IronPort-SDR: MLjwpzdYEols+TgsOVwd9Y2ZrR3Y9drI4v6FvgnBkJiLNg9a2I8EU06sYUVFmCtICAJSuIJhS0
 3a+LqePvyANg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="151741102"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="151741102"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 14:24:55 -0700
IronPort-SDR: p5zyt6Ywxk6hDop9+BDEKiB046MiPxW2wQnWR/E0KDvbjCTytb1mS6wSjVyE8+bhKFWfuFYmks
 9R4za+v4EkBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="302089077"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga002.jf.intel.com with ESMTP; 22 Jul 2020 14:24:55 -0700
Date:   Wed, 22 Jul 2020 14:24:55 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200722212455.GA844235@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-18-ira.weiny@intel.com>
 <20200717100610.GH10769@hirez.programming.kicks-ass.net>
 <20200722052709.GB478587@iweiny-DESK2.sc.intel.com>
 <20200722094853.GM10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722094853.GM10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:48:53AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 21, 2020 at 10:27:09PM -0700, Ira Weiny wrote:
> 
> > I've been really digging into this today and I'm very concerned that I'm
> > completely missing something WRT idtentry_enter() and idtentry_exit().
> > 
> > I've instrumented idt_{save,restore}_pkrs(), and __dev_access_{en,dis}able()
> > with trace_printk()'s.
> > 
> > With this debug code, I have found an instance where it seems like
> > idtentry_enter() is called without a corresponding idtentry_exit().  This has
> > left the thread ref counter at 0 which results in very bad things happening
> > when __dev_access_disable() is called and the ref count goes negative.
> > 
> > Effectively this seems to be happening:
> > 
> > ...
> > 	// ref == 0
> > 	dev_access_enable()  // ref += 1 ==> disable protection
> > 		// exception  (which one I don't know)
> > 			idtentry_enter()
> > 				// ref = 0
> > 				_handler() // or whatever code...
> > 			// *_exit() not called [at least there is no trace_printk() output]...
> > 			// Regardless of trace output, the ref is left at 0
> > 	dev_access_disable() // ref -= 1 ==> -1 ==> does not enable protection
> > 	(Bad stuff is bound to happen now...)
> > ...
> > 
> > The ref count ends up completely messed up after this sequence...  and the PKRS
> > register gets out of sync as well.  This is starting to make some sense of how
> > I was getting what seemed like random crashes before.
> > 
> > Unfortunately I don't understand the idt entry/exit code well enough to see
> > clearly what is going on.  Is there any reason idtentry_exit() is not called
> > after idtentry_enter()?  Perhaps some NMI/MCE or 'not normal' exception code
> > path I'm not seeing?  In my searches I see a corresponding exit for every
> > enter.  But MCE is pretty hard to follow.
> > 
> > Also is there any chance that the process could be getting scheduled and that
> > is causing an issue?
> 
> Ooh, I think I see the problem. We also use idtentry_enter() for #PF,
> and #PF can schedule, exactly as you observed. Argh!

I dug more and I don't see this?  I threw a WARN_ON in the idt_save_pkrs().

Its showing most of these are coming from asm_sysvec_acpi_timer_interrupt().[1]

I don't see that call schedule() between idtentry_enter() and *_exit()...

I do see page faults.  But that is not the first instance where the count gets
messed up.

> 
> This then means you need to go frob something in
> arch/x86/include/asm/idtentry.h, which is somewhat unfortunate.
> 
> Thomas, would it make sense to add a type parameter to
> idtentry_{enter,exit}() ?

Ira

[1] Example trace.

[   30.289514] ------------[ cut here ]------------^M
[   30.290706] WARNING: CPU: 0 PID: 485 at arch/x86/entry/common.c:596 idt_save_pkrs.isra.0.constprop.0+0x45/0xc0^M
[   30.293178] Modules linked in: kvm_intel(+) dax_pmem bochs_drm dax_pmem_core snd_hwdep kvm drm_vram_helper nd_pmem(+) snd_seq nd_btt snd_seq_device irqbypass snd_pcm drm_ttm_helper crct10dif_pclmul ttm crc32_pclmul drm_kms_helper snd_timer nd_e820 ghash_clmulni_intel libnvdimm cec snd drm pcspkr joydev soundcore i2c_ismt ipmi_ssif acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter ip_tables crc32c_intel e1000e wmi pinctrl_sunrisepoint pinctrl_intel fuse^M
[   30.303437] CPU: 0 PID: 485 Comm: systemd-udevd Not tainted 5.8.0-rc5+ #7^M
[   30.305132] Hardware name: Intel Corporation XXXX/YYYY, BIOS EGSDCRB1.86B.0034.D09.2005061015 05/06/2020^M
[   30.307774] RIP: 0010:idt_save_pkrs.isra.0.constprop.0+0x45/0xc0^M
[   30.309281] Code: 85 c0 74 2d 45 8b 88 58 22 00 00 48 8b 35 bb 65 dd 00 ba 51 02 00 00 48 c7 c7 1f 97 a6 a8 65 8b 0d 20 7c 5a 57 e8 cb ba 77 ff <0f> 0b bb 01 00 00 00 65 48 8b 04 25 c0 7b 01 00 8b a8 58 22 00 00^M
[   30.313879] RSP: 0018:ff5ba73f008e73f0 EFLAGS: 00010046^M
[   30.315196] RAX: 0000000000000005 RBX: 0000000000000000 RCX: 0000000000000000^M
[   30.316975] RDX: ff24c78be0c17400 RSI: 0000000000000080 RDI: ff24c78be0c01300^M
[   30.318754] RBP: ff5ba73f008e7430 R08: ff24c78be0e3dd00 R09: ff24c78be0e71000^M
[   30.320533] R10: ff24c78be0e7110c R11: 0000000000000000 R12: ff5ba73f008e7468^M
[   30.322312] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000^M
[   30.324091] FS:  00007efd21acb940(0000) GS:ff24c78be4000000(0000) knlGS:0000000000000000^M
[   30.326102] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
[   30.327544] CR2: 0000559609d33940 CR3: 0000000833b70003 CR4: 0000000001761ef0^M
[   30.332593] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M
[   30.337638] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400^M
[   30.342632] PKRU: 55555554^M
[   30.346545] Call Trace:^M
[   30.350342]  idtentry_enter+0x1a/0xa0^M
[   30.354389]  sysvec_apic_timer_interrupt+0x12/0xa0^M
[   30.358681]  ? __dev_access_enable+0x82/0xe0^M
[   30.362846]  asm_sysvec_apic_timer_interrupt+0x12/0x20^M
[   30.367225] RIP: 0010:__dev_access_enable+0xad/0xe0^M
[   30.371517] Code: 8b 88 58 22 00 00 48 8b 35 d8 62 51 01 ba 86 00 00 00 48 c7 c7 22 9a 32 a8 65 8b 0d 1d 79 ce 57 e8 c8 b7 eb ff 48 89 df 57 9d <0f> 1f 44 00 00 5b 5d c3 8b bd 1c 23 00 00 8b 35 0f 8a 3d 01 31 d2^M
[   30.382320] RSP: 0018:ff5ba73f008e7510 EFLAGS: 00000246^M
[   30.386760] RAX: 0000000000000005 RBX: 0000000000000246 RCX: 0000000000000000^M
[   30.391651] RDX: ff24c78be0c17400 RSI: 0000000000000080 RDI: 0000000000000246^M
[   30.396525] RBP: ff24c78bb4fe4000 R08: ff24c78be0e3dd00 R09: ff24c78be0e71000^M
[   30.401393] R10: ff24c78be0e710dc R11: ff24c78bdbb81468 R12: ffd1de5920d38040^M
[   30.406246] R13: 0000000000000008 R14: 0000000000001000 R15: 0000000000000000^M
[   30.411101]  pmem_do_read+0x1a4/0x230 [nd_pmem]^M
[   30.415329]  pmem_make_request+0x147/0x2a0 [nd_pmem]^M
[   30.419678]  generic_make_request+0xeb/0x350^M
[   30.423846]  submit_bio+0x4b/0x1a0^M
[   30.427818]  ? bio_add_page+0x62/0x90^M
[   30.431825]  submit_bh_wbc+0x16a/0x190^M
[   30.435806]  block_read_full_page+0x344/0x460^M
[   30.439915]  ? blkdev_direct_IO+0x4a0/0x4a0^M
[   30.443960]  ? memcg_drain_all_list_lrus+0x1d0/0x1d0^M
[   30.448170]  do_read_cache_page+0x61e/0x890^M
[   30.452163]  ? do_read_cache_page+0x2af/0x890^M
[   30.456177]  read_part_sector+0x32/0xf7^M

...

