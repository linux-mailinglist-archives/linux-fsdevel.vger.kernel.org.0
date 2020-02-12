Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE1015A3EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 09:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgBLIud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 03:50:33 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35430 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgBLIuc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NpTlCgYb/z6Vi+BVrieZmKjPIGNXZC/UxztwFhX/oFk=; b=1GpmvKdEeXdDZ/5zRSW5wO/Ao
        nIujDFAzKzE3wq0D2nTcxVjtYyGVdgu1Jd5MgAcflDcQotS08VoIoR0OIO/fNaU0VVhPk8cID0BAL
        QEAkby765VihaP7Gjoam3MhHORaKOqUuSWkPj7RvVZXr+I34PhC2m7RFnanmtkN8r7DQrlrm1G7DI
        ArD1iqCp0xPVPiIUKYD+Gob2cBT0UT4YUKEWG2R3mNUdWaA7FXqEQd2nGm4WtJhllzYfyZE9AYJUT
        TA43u+2ZLmgsFKARTkcG9MICatJ953z6e8k5lEgMM03lkQDPJkMtQjKyp7zW/IwKFqKSCHzzLLK0G
        0D0f9OELg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50926)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j1nim-0001dz-8f; Wed, 12 Feb 2020 08:50:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j1nie-0001HG-SN; Wed, 12 Feb 2020 08:50:04 +0000
Date:   Wed, 12 Feb 2020 08:50:04 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200212085004.GL25745@shell.armlinux.org.uk>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org>
 <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:03:02PM -0800, Linus Torvalds wrote:
> On Tue, Feb 11, 2020 at 4:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > What's the situation with highmem on ARM?
> 
> Afaik it's exactly the same as highmem on x86 - only 32-bit ARM ever
> needed it, and I was ranting at some people for repeating all the
> mistakes Intel did.
> 
> But arm64 doesn't need it, and while 32-bit arm is obviosuly still
> selling, I think that in many ways the switch-over to 64-bit has been
> quicker on ARM than it was on x86. Partly because it happened later
> (so all the 64-bit teething pains were dealt with), but largely
> because everybody ended up actively discouraging 32-bit on the Android
> side.
> 
> There were a couple of unfortunate early 32-bit arm server attempts,
> but they were - predictably - complete garbage and nobody bought them.
> They don't exist any more.
> 
> So at least my gut feel is that the arm people don't have any big
> reason to push for maintaining HIGHMEM support either.
> 
> But I'm adding a couple of arm people and the arm list just in case
> they have some input.
> 
> [ Obvious background for newly added people: we're talking about
> making CONFIG_HIGHMEM a deprecated feature and saying that if you want
> to run with lots of memory on a 32-bit kernel, you're doing legacy
> stuff and can use a legacy kernel ]

Well, the recent 32-bit ARM systems generally have more than 1G
of memory, so make use of highmem as a rule.  You're probably
talking about crippling support for any 32-bit ARM system produced
in the last 8 to 10 years.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
