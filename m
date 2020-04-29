Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CE91BEA9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 23:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD2V5C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 17:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2V5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:57:02 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BC2C03C1AE;
        Wed, 29 Apr 2020 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JhIri9Htg0/sN4w6AP/QH7wGRCJsnU/YBI0zvtCnrSE=; b=lcgeCqTdF0/C0XnarY+tI1cLA
        aTp5plAUZgVFOpQPCrwnTtLwHs8XQhIGrDDx+4JmRdD5VmjaNjo3kqPh/BRBwYRi0ULZSpSwWY0mW
        TrgemlMVjy5uQmTWtkwO2jv40d3R3lIxts3PSghFetSH2TbL4JnhiGlJwhTroVW/CX7SpjTyhrZpn
        X/Ez408/p4adJYNff4cxI3KCA5uQPjgzUfuiEZ4LI1/jdP1WfABKNM6VQy8G4/iB464EHLhHoNUBC
        marQIPhja3Ndlo+onDkpOu7bNy8Fc8qEEX+yBrHUbV6/UqmfyOGOxXHgP9SDfhe6A2l8poddWJOzu
        YD58Ko3aw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:51674)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jTugs-0001oF-Rn; Wed, 29 Apr 2020 22:56:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jTugm-0001S9-Ad; Wed, 29 Apr 2020 22:56:20 +0100
Date:   Wed, 29 Apr 2020 22:56:20 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jann Horn <jannh@google.com>, Nicolas Pitre <nico@fluxnic.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use
 mmap_sem properly in there
Message-ID: <20200429215620.GM1551@shell.armlinux.org.uk>
References: <20200429214954.44866-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429214954.44866-1-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:49:49PM +0200, Jann Horn wrote:
> At the moment, we have that rather ugly mmget_still_valid() helper to
> work around <https://crbug.com/project-zero/1790>: ELF core dumping
> doesn't take the mmap_sem while traversing the task's VMAs, and if
> anything (like userfaultfd) then remotely messes with the VMA tree,
> fireworks ensue. So at the moment we use mmget_still_valid() to bail
> out in any writers that might be operating on a remote mm's VMAs.
> 
> With this series, I'm trying to get rid of the need for that as
> cleanly as possible.
> In particular, I want to avoid holding the mmap_sem across unbounded
> sleeps.
> 
> 
> Patches 1, 2 and 3 are relatively unrelated cleanups in the core
> dumping code.
> 
> Patches 4 and 5 implement the main change: Instead of repeatedly
> accessing the VMA list with sleeps in between, we snapshot it at the
> start with proper locking, and then later we just use our copy of
> the VMA list. This ensures that the kernel won't crash, that VMA
> metadata in the coredump is consistent even in the presence of
> concurrent modifications, and that any virtual addresses that aren't
> being concurrently modified have their contents show up in the core
> dump properly.
> 
> The disadvantage of this approach is that we need a bit more memory
> during core dumping for storing metadata about all VMAs.
> 
> After this series has landed, we should be able to rip out
> mmget_still_valid().
> 
> 
> Testing done so far:
> 
>  - Creating a simple core dump on X86-64 still works.
>  - The created coredump on X86-64 opens in GDB, and both the stack and the
>    exectutable look vaguely plausible.
>  - 32-bit ARM compiles with FDPIC support, both with MMU and !MMU config.
> 
> I'm CCing some folks from the architectures that use FDPIC in case
> anyone wants to give this a spin.

I've never had any reason to use FDPIC, and I don't have any binaries
that would use it.  Nicolas Pitre added ARM support, so I guess he
would be the one to talk to about it.  (Added Nicolas.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
