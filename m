Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A842C525D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 11:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbgKZKs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 05:48:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:58680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388281AbgKZKs6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:48:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48D03AC23;
        Thu, 26 Nov 2020 10:48:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 240441E130F; Thu, 26 Nov 2020 11:48:56 +0100 (CET)
Date:   Thu, 26 Nov 2020 11:48:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, Borislav Petkov <bp@alien8.de>,
        =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201126104856.GB422@quack2.suse.cz>
References: <20201101212738.GA16924@gmail.com>
 <20201102122638.GB23988@quack2.suse.cz>
 <20201103211747.GA3688@gmail.com>
 <20201123164622.GJ27294@quack2.suse.cz>
 <20201123224651.GA27809@gmail.com>
 <20201124084507.GA4009@zn.tnic>
 <20201124102033.GA19336@quack2.suse.cz>
 <CA+G9fYtKKmoYUJpPFLBtFVB6MRJwJTsVjtYtRcXmJxc5PbHAZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtKKmoYUJpPFLBtFVB6MRJwJTsVjtYtRcXmJxc5PbHAZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 01:01:30, Naresh Kamboju wrote:
> On Tue, 24 Nov 2020 at 15:50, Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 24-11-20 09:45:07, Borislav Petkov wrote:
> > > On Mon, Nov 23, 2020 at 11:46:51PM +0100, Paweł Jasiak wrote:
> > > > On 23/11/20, Jan Kara wrote:
> > > > > OK, with a help of Boris Petkov I think I have a fix that looks correct
> > > > > (attach). Can you please try whether it works for you? Thanks!
> > > >
> <trim>
> >
> > Thanks for checking! I didn't realize I needed to change the ifdefs as well
> > (I missed that bit in 121b32a58a3a). So do I understand correctly that
> > whenever the kernel is 64-bit, 64-bit syscall args (e.g. defined as u64) are
> > passed just fine regardless of whether the userspace is 32-bit or not?
> >
> > Also how about other 32-bit archs? Because I now realized that
> > CONFIG_COMPAT as well as the COMPAT_SYSCALL_DEFINE6() is also utilized by
> > other 32-bit archs (I can see a reference to compat_sys_fanotify_mark e.g.
> > in sparc, powerpc, and other args). So I probably need to actually keep
> > that for other archs but do the modification only for x86, don't I?
> >
> > So something like attached patch?
> 
> I have tested the attached patch on i386 and qemu_i386 and the reported problem
> got fixed.
> 
> Test links,
> https://lkft.validation.linaro.org/scheduler/job/1985236#L1176
> https://lkft.validation.linaro.org/scheduler/job/1985238#L801

Thanks for testing! I've added your tested-by tag.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
