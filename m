Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA105287D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 11:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfFYJqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 05:46:06 -0400
Received: from foss.arm.com ([217.140.110.172]:37146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfFYJqG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:46:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BAF8C0A;
        Tue, 25 Jun 2019 02:46:05 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94A833F71E;
        Tue, 25 Jun 2019 02:46:04 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:46:02 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Vicente Bergas <vicencb@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>, marc.zyngier@arm.com
Subject: Re: d_lookup: Unable to handle kernel paging request
Message-ID: <20190625094602.GC13263@fuggles.cambridge.arm.com>
References: <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
 <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
 <20190618183548.GB17978@ZenIV.linux.org.uk>
 <bf2b3aa6-bda1-43f1-9a01-e4ad3df81c0b@gmail.com>
 <20190619162802.GF17978@ZenIV.linux.org.uk>
 <bc774f6b-711e-4a20-ad85-c282f9761392@gmail.com>
 <20190619170940.GG17978@ZenIV.linux.org.uk>
 <cd84de0e-909e-4117-a20a-6cde42079267@gmail.com>
 <20190624114741.i542cb3wbhfbk4q4@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624114741.i542cb3wbhfbk4q4@willie-the-truck>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+Marc]

Hi again, Vicente,

On Mon, Jun 24, 2019 at 12:47:41PM +0100, Will Deacon wrote:
> On Sat, Jun 22, 2019 at 08:02:19PM +0200, Vicente Bergas wrote:
> > Hi Al,
> > i think have a hint of what is going on.
> > With the last kernel built with your sentinels at hlist_bl_*lock
> > it is very easy to reproduce the issue.
> > In fact it is so unstable that i had to connect a serial port
> > in order to save the kernel trace.
> > Unfortunately all the traces are at different addresses and
> > your sentinel did not trigger.
> > 
> > Now i am writing this email from that same buggy kernel, which is
> > v5.2-rc5-224-gbed3c0d84e7e.
> > 
> > The difference is that I changed the bootloader.
> > Before was booting 5.1.12 and kexec into this one.
> > Now booting from u-boot into this one.
> > I will continue booting with u-boot for some time to be sure it is
> > stable and confirm this is the cause.
> > 
> > In case it is, who is the most probable offender?
> > the kernel before kexec or the kernel after?
> 
> Has kexec ever worked reliably on this board? If you used to kexec
> successfully, then we can try to hunt down the regression using memtest.
> If you kexec into a problematic kernel with CONFIG_MEMTEST=y and pass
> "memtest=17" on the command-line, it will hopefully reveal any active
> memory corruption.
> 
> My first thought is that there is ongoing DMA which corrupts the dentry
> hash. The rk3399 SoC also has an IOMMU, which could contribute to the fun
> if it's not shutdown correctly (i.e. if it enters bypass mode).
> 
> > The original report was sent to you because you appeared as the maintainer
> > of fs/dcache.c, which appeared on the trace. Should this be redirected
> > somewhere else now?
> 
> linux-arm-kernel@lists.infradead.org
> 
> Probably worth adding Heiko Stuebner <heiko@sntech.de> to cc.

Before you rush over to LAKML, please could you provide your full dmesg
output from the kernel that was crashing (i.e. the dmesg you see in the
kexec'd kernel)? We've got a theory that the issue may be related to the
interrupt controller, and the dmesg output should help to establish whether
that is plausible or not.

Thanks,

Will
