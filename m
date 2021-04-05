Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6130F3545E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 19:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbhDERQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 13:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbhDERQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:16:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1DEC061794
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Apr 2021 10:16:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso8163836pji.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Apr 2021 10:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ai3CdCbkrXPSlQhahzdlfMoVkl12Ktt9EKKlkNpbqIk=;
        b=T5OZIJi1a+S0UmB8ju9dRtp9RWLpyoSfUudALSFJBsooFu63xRQSZft0M3qzy93k0r
         z7x2JAHldp19Jlo5384VoYUVNQ2yeLvjJ5z5R7QVmttinVeV9VjzoAdj8fejaeiR8lyF
         62143nJ12x8hml5vfS8LwEeOZj9TXLo/W5cC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ai3CdCbkrXPSlQhahzdlfMoVkl12Ktt9EKKlkNpbqIk=;
        b=ukyhYj5epyhYg/Shllxatw7zxVyaZVdGR5wVdd6AZTiLK8Kto14589hxpirszNVxCu
         776gCaESdQu/3xEmCYdbdzBOzSgEsmoRIRHwPpGwIUOGC5+u+Xnszg6yPf9tjxJfEekn
         cdA4/NyUIPtuqPQuQCDnLF4xH/UmvWnDnAAK9dnrkDNeVoP96QMw52JBfGPTeiXh5qRP
         5ce4LvOdHCFz9JxuqoRuuge4EIPXB0EzyijuhQKDPNezkPtuu+1MecLthx8kNkm+YR2h
         QcFTeU68otN4XfN4x9BTlAfZIvrysl8zVzYHyK3R2ai0esxvJlT2HtKq1lXgNwrS2r1e
         zX2A==
X-Gm-Message-State: AOAM5302nvhWvcSQAfMM5PKMLoDTTbOUZUs/F+71beoRi/FKXfjvWGXy
        ePnRBvMhDGUc39WlLhb1fJAVsA==
X-Google-Smtp-Source: ABdhPJz2wXjLIg6rNu7hKfJ8t7qCHdoSv+LbFw67gBgLuT/syvhnAuVwrV+h3lzUsevbyEgwDBzhiQ==
X-Received: by 2002:a17:902:6546:b029:e9:1e31:3351 with SMTP id d6-20020a1709026546b02900e91e313351mr3882734pln.26.1617642997543;
        Mon, 05 Apr 2021 10:16:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t18sm16339996pfh.57.2021.04.05.10.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 10:16:36 -0700 (PDT)
Date:   Mon, 5 Apr 2021 10:16:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
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
Message-ID: <202104051013.F432CAC4@keescook>
References: <20210319143452.25948-1-david@redhat.com>
 <20210319143452.25948-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319143452.25948-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 19, 2021 at 03:34:50PM +0100, David Hildenbrand wrote:
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
> [...]
> Cc: Linux API <linux-api@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Yes please! As James Troup pointed out already, this was turned off in
Ubuntu in 2008. I don't remember a single complaint from anyone who
wasn't a rootkit author. ;)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
