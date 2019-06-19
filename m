Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E504BF3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 19:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfFSREt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 13:04:49 -0400
Received: from foss.arm.com ([217.140.110.172]:49174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfFSREt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:04:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D1E2344;
        Wed, 19 Jun 2019 10:04:48 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A7C13F246;
        Wed, 19 Jun 2019 10:04:47 -0700 (PDT)
Date:   Wed, 19 Jun 2019 18:04:45 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Vicente Bergas <vicencb@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: d_lookup: Unable to handle kernel paging request
Message-ID: <20190619170445.GI7767@fuggles.cambridge.arm.com>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
 <20190522135331.GM17978@ZenIV.linux.org.uk>
 <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
 <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
 <20190618183548.GB17978@ZenIV.linux.org.uk>
 <bf2b3aa6-bda1-43f1-9a01-e4ad3df81c0b@gmail.com>
 <20190619162802.GF17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619162802.GF17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

On Wed, Jun 19, 2019 at 05:28:02PM +0100, Al Viro wrote:
> [arm64 maintainers Cc'd; I'm not adding a Cc to moderated list,
> sorry]

Thanks for adding us.

> On Wed, Jun 19, 2019 at 02:42:16PM +0200, Vicente Bergas wrote:
> 
> > Hi Al,
> > i have been running the distro-provided kernel the last few weeks
> > and had no issues at all.
> > https://archlinuxarm.org/packages/aarch64/linux-aarch64
> > It is from the v5.1 branch and is compiled with gcc 8.3.
> > 
> > IIRC, i also tested
> > https://archlinuxarm.org/packages/aarch64/linux-aarch64-rc
> > v5.2-rc1 and v5.2-rc2 (which at that time where compiled with
> > gcc 8.2) with no issues.
> > 
> > This week tested v5.2-rc4 and v5.2-rc5 from archlinuxarm but
> > there are regressions unrelated to d_lookup.
> > 
> > At this point i was convinced it was a gcc 9.1 issue and had
> > nothing to do with the kernel, but anyways i gave your patch a try.
> > The tested kernel is v5.2-rc5-224-gbed3c0d84e7e and
> > it has been compiled with gcc 8.3.
> > The sentinel you put there has triggered!
> > So, it is not a gcc 9.1 issue.
> > 
> > In any case, i have no idea if those addresses are arm64-specific
> > in any way.
> 
> Cute...  So *all* of those are in dentry_hashtable itself.  IOW, we have
> these two values (1<<24 and (1<<24)|(0x88L<<40)) cropping up in
> dentry_hashtable[...].first on that config.

Unfortunately, those values don't jump out at me as something particularly
meaningful on arm64. Bloody weird though.

> There shouldn't be any pointers to hashtable elements other than ->d_hash.pprev
> of various dentries.  And ->d_hash is not a part of anon unions in struct
> dentry, so it can't be mistaken access through the aliasing member.
> 
> Of course, there's always a possibility of something stomping on random places
> in memory and shitting those values all over, with the hashtable being the
> hottest place on the loads where it happens...  Hell knows...
> 
> What's your config, BTW?  SMP and DEBUG_SPINLOCK, specifically...

I'd also be interesting in seeing the .config (the pastebin link earlier in
the thread appears to have expired). Two areas where we've had issues
recently are (1) module relocations and (2) CONFIG_OPTIMIZE_INLINING.
However, this is the first report I've seen of the sort of crash you're
reporting.

Will
