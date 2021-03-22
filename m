Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1390E3445E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 14:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCVNgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 09:36:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:52782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhCVNfo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:35:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616420142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bNwpWnU/mOEb8vDk9U6PPMjzkSSiO3GF6Uf0hvYy86c=;
        b=T/88LUerDCEZ5aLb09F83ICr41UqeH2rh4J7zrGpXp20VeYsZHJpi/YuD6UnXQW4pyzMJd
        jBAgDV46TT0Kz09FM1vI9JNZIIaETu438nFrfjiK/6ELDm8IlG80pWXjuPGHfOvQ9qSqDa
        nwk9Za/1Mcrl0+PJNnBW15dSnFPW4Rw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2DDD7AC1F;
        Mon, 22 Mar 2021 13:35:42 +0000 (UTC)
Date:   Mon, 22 Mar 2021 14:35:41 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Minchan Kim <minchan@kernel.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Rob Herring <robh@kernel.org>,
        "Pavel Machek (CIP)" <pavel@denx.de>,
        Theodore Dubois <tblodt@icloud.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Robert Richter <rric@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Kairui Song <kasong@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] drivers/char: remove /dev/kmem for good
Message-ID: <YFidLVQs+/zw4aIF@dhcp22.suse.cz>
References: <20210319143452.25948-1-david@redhat.com>
 <20210319143452.25948-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319143452.25948-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 19-03-21 15:34:50, David Hildenbrand wrote:
> Exploring /dev/kmem and /dev/mem in the context of memory hot(un)plug and
> memory ballooning, I started questioning the existance of /dev/kmem.
> 
> Comparing it with the /proc/kcore implementation, it does not seem to be
> able to deal with things like
> a) Pages unmapped from the direct mapping (e.g., to be used by secretmem)
>   -> kern_addr_valid(). virt_addr_valid() is not sufficient.
> b) Special cases like gart aperture memory that is not to be touched
>   -> mem_pfn_is_ram()
> Unless I am missing something, it's at least broken in some cases and might
> fault/crash the machine.
> 
> Looks like its existance has been questioned before in 2005 and 2010
> [1], after ~11 additional years, it might make sense to revive the
> discussion.
> 
> CONFIG_DEVKMEM is only enabled in a single defconfig (on purpose or by
> mistake?). All distributions I looked at disable it.
> 
> 1) /dev/kmem was popular for rootkits [2] before it got disabled
>    basically everywhere. Ubuntu documents [3] "There is no modern user of
>    /dev/kmem any more beyond attackers using it to load kernel rootkits.".
>    RHEL documents in a BZ [5] "it served no practical purpose other than to
>    serve as a potential security problem or to enable binary module drivers
>    to access structures/functions they shouldn't be touching"
> 
> 2) /proc/kcore is a decent interface to have a controlled way to read
>    kernel memory for debugging puposes. (will need some extensions to
>    deal with memory offlining/unplug, memory ballooning, and poisoned
>    pages, though)
> 
> 3) It might be useful for corner case debugging [1]. KDB/KGDB might be a
>    better fit, especially, to write random memory; harder to shoot
>    yourself into the foot.
> 
> 4) "Kernel Memory Editor" hasn't seen any updates since 2000 and seems
>    to be incompatible with 64bit [1]. For educational purposes,
>    /proc/kcore might be used to monitor value updates -- or older
>    kernels can be used.
> 
> 5) It's broken on arm64, and therefore, completely disabled there.
> 
> Looks like it's essentially unused and has been replaced by better
> suited interfaces for individual tasks (/proc/kcore, KDB/KGDB). Let's
> just remove it.
> 
> [1] https://lwn.net/Articles/147901/
> [2] https://www.linuxjournal.com/article/10505
> [3] https://wiki.ubuntu.com/Security/Features#A.2Fdev.2Fkmem_disabled
> [4] https://sourceforge.net/projects/kme/
> [5] https://bugzilla.redhat.com/show_bug.cgi?id=154796
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: huang ying <huang.ying.caritas@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Brian Cain <bcain@codeaurora.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Rich Felker <dalias@libc.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Pavel Machek (CIP)" <pavel@denx.de>
> Cc: Theodore Dubois <tblodt@icloud.com>
> Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
> Cc: Robert Richter <rric@kernel.org>
> Cc: William Cohen <wcohen@redhat.com>
> Cc: Corentin Labbe <clabbe@baylibre.com>
> Cc: Kairui Song <kasong@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: openrisc@lists.librecores.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Linux API <linux-api@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
