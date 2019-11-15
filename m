Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD14FD8C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 10:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKOJY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 04:24:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:32984 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOJY1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:24:27 -0500
Received: from zn.tnic (p200300EC2F0CC300B4C5AF24BE56B25A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:c300:b4c5:af24:be56:b25a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 533251EC0D06;
        Fri, 15 Nov 2019 10:24:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573809866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E5NJCPvuc3oH2wYFT9cv75IPz3w+7olilEdrf/3xSRU=;
        b=g9AgrIO9wgjkcYp8jRyNKRcrDnssjEh83KqxdpQWp2fIdYqh9E/PcsilJGdsWdKVCN8Xf2
        LjvjtcxyGOCbcWmiVpRKbv7FPRg6kwHcRq6ekSGPqwOzTz/sa8NMLhQHAAsSjJoyPNVgQF
        7qJDlykU9nRi7aBcsSDXvh5o1xqDSlg=
Date:   Fri, 15 Nov 2019 10:24:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
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
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2][v2] x86/resctrl: Add task resctrl information display
Message-ID: <20191115092420.GF18929@zn.tnic>
References: <cover.1573788882.git.yu.c.chen@intel.com>
 <5dcd6580b51342c0803db6bc27866dd569914b0d.1573788882.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5dcd6580b51342c0803db6bc27866dd569914b0d.1573788882.git.yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 01:25:06PM +0800, Chen Yu wrote:
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

Eww, this doesn't sound very user-friendly. How is the user supposed to
know that the resctrl fs needs to be mounted for this to work?

Why does the resctrl fs need to be mounted at all to show this?

I'm guessing if it is not mounted, you have no groups so you don't have
to return an error - you simply return "". Right?

> Tested-by: Jinshi Chen <jinshi.chen@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

When you send a new version which has non-trivial changes, you should
drop those tags because they don't apply anymore. Unless those people
have managed to review and test the new version ...

Looking at CONFIG_PROC_PID_ARCH_STATUS for an example of proc/ calling
arch-specific functions, I guess you need to do:

select CPU_RESCTRL if PROC_FS

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
