Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6968C1007A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 15:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfKROsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 09:48:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36018 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfKROsO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:48:14 -0500
Received: from zn.tnic (p200300EC2F27B50084A11D83797EBEC7.dip0.t-ipconnect.de [IPv6:2003:ec:2f27:b500:84a1:1d83:797e:bec7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEC0E1EC05DE;
        Mon, 18 Nov 2019 15:48:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574088491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dKQCpCI9/H+bPIZWKf5d2LDECsFIi9hdS2TrAmqbdqc=;
        b=esgT1nnDXt2e2LkqH0ymdvLL2007+CVgDTaMj6MoQeIArYq595o0AHLL9IIY5mZDqq3Zec
        +puR4uV9zIWyjkPGgnr5Ky4EoC3DVKw+pMRV6HZQthBtjHOTGPx509yytz428Fd749mj4j
        koCosOwYezY8XJz5MJqh+w/IvfLiJmU=
Date:   Mon, 18 Nov 2019 15:48:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ryan Chen <yu.chen.surf@gmail.com>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Shakeel Butt <shakeelb@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2][v2] x86/resctrl: Add task resctrl information display
Message-ID: <20191118144807.GE6363@zn.tnic>
References: <cover.1573788882.git.yu.c.chen@intel.com>
 <5dcd6580b51342c0803db6bc27866dd569914b0d.1573788882.git.yu.c.chen@intel.com>
 <20191115092420.GF18929@zn.tnic>
 <CADjb_WR_DNAR_4jVEJ1C4LO7Xfnc54J2u2AoqyCjZT39+AhrWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADjb_WR_DNAR_4jVEJ1C4LO7Xfnc54J2u2AoqyCjZT39+AhrWA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 16, 2019 at 11:01:12PM +0800, Ryan Chen wrote:
> Right, we can return 'blank' to user and let the user to parse the information.

There is nothing to parse - the task doesn't belong to any groups. That's it.

> And there is a similar behavior in cgroup that, for kernel thread that
> does not belong
> to any cgroup, /proc/{pid}/cgroup just show 'blank' without returning an error.

By 'blank' I assume you mean the empty string '' ?

> Yes, only when PROC_FS is set, /proc/{pid}/resctrl
> can be displayed. However, CPU_RESCTRL might not
> depend on proc fs, it is possible that the CPU_RESCTRL
> is enabled but without PROC_FS set. If I understand correctly,
>  CPU_RESCTRL is the 'root' config for X86_CPU_RESCTRL,
> after reading this thread:
> https://lists.gt.net/linux/kernel/3211659

I'm not sure I know what you mean here. There's no CPU_RESCTRL option - you've
added it in the previous patch:

[ ~/kernel/linux> git grep -E CONFIG_CPU_RESCTRL
[ ~/kernel/linux> git grep -E "\WCPU_RESCTRL"
[ ~/kernel/linux>

And if you want to use that option in proc/, then it needs
to depend on PROC_FS, like the the example I gave you with
CONFIG_PROC_PID_ARCH_STATUS.

Or do you mean something else?

>  If this is the case, shall we add the new file at kernel/resctrl/resctrl.c?
> And the generic proc_resctrl_show() could be put into this file. In the future
> the generic code for resctrl could be added/moved to kernel/resctrl/resctrl.c

Not worth it for a single function. Leave it in
arch/x86/kernel/cpu/resctrl/rdtgroup.c where you had it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
