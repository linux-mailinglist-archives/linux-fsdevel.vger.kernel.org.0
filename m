Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F606D903
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 04:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfGSCUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 22:20:16 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:43943 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfGSCUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 22:20:15 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x6J2Jpp4017092;
        Fri, 19 Jul 2019 11:19:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x6J2Jpp4017092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563502792;
        bh=+sM+seELdRIbsaJZCOpd5FOhzKDSjUglYwxZ8lI5IpY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yxdGOC7h01PMpNWjoMFR3aQrxdO5yDDJLqCQxGqYKM6FyzHzHe91A5yhUiQzTtC5W
         OlkeTRP7/BRNJnUGwcPzjaWgw0Y8FtbF/VIdBp5O4He1W3hx03o1jNHI5vAXShBa5/
         psBH6zqbnPp4rzO4C0XrCs+JS7Er0Aor0txupQa1HbJETPRryqrOCI8UXwOWcORW7h
         N5JpaSSV8JMV18LyNxdwf3GjcV4agFAuKGt/jpH3G5YdlsW31L6DiN3Q87HfFDm66U
         AaA1V0sSYtyun5RVb2udp1ivpRNod9qlbye1bCdr1oyoOylv4/Itr2zwClhNrP/TWI
         Z3MuMVng0jBsg==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id r3so20521282vsr.13;
        Thu, 18 Jul 2019 19:19:52 -0700 (PDT)
X-Gm-Message-State: APjAAAWy8L7BDABd3H+NF9OTfcef+czhAs+m9vW7YQdj1eA8xI6WKlcR
        Wp3Eo27DK6lM1A/u6z8Sdjw33ifsShVJL/Tf+ys=
X-Google-Smtp-Source: APXvYqybBFz/HOYZeKsR6BcR2USXMe1xocX0bGf4StjrIgG6+mNOvEm2C5Vhfm1+zxBz6YSUHwPKd+7SVqirj8eqr8g=
X-Received: by 2002:a67:f495:: with SMTP id o21mr31554842vsn.54.1563502790950;
 Thu, 18 Jul 2019 19:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190718125509.775525-1-arnd@arndb.de> <20190718125703.GA28332@lst.de>
 <CAK8P3a2k3ddUD-b+OskpDfAkm6KGAGAOBabkXk3Uek1dShTiUA@mail.gmail.com>
 <20190718130835.GA28520@lst.de> <20190718142525.GE7116@magnolia>
In-Reply-To: <20190718142525.GE7116@magnolia>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 19 Jul 2019 11:19:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNASN5d_ppx6wJSm+fcf9HiX9i6zX4fxiR5_WuF6QUOExXQ@mail.gmail.com>
Message-ID: <CAK7LNASN5d_ppx6wJSm+fcf9HiX9i6zX4fxiR5_WuF6QUOExXQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: hide iomap_sector with CONFIG_BLOCK=n
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi.

On Thu, Jul 18, 2019 at 11:28 PM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> On Thu, Jul 18, 2019 at 03:08:35PM +0200, Christoph Hellwig wrote:
> > On Thu, Jul 18, 2019 at 03:03:15PM +0200, Arnd Bergmann wrote:
> > > The inclusion comes from the recently added header check in commit
> > > c93a0368aaa2 ("kbuild: do not create wrappers for header-test-y").
> > >
> > > This just tries to include every header by itself to see if there are build
> > > failures from missing indirect includes. We probably don't want to
> > > add an exception for iomap.h there.
> >
> > I very much disagree with that check.  We don't need to make every
> > header compilable with a setup where it should not be included.
>
> Seconded, unless there's some scenario where someone needs iomap when
> CONFIG_BLOCK=n (???)

I agree.

There is no situation that iomap.h is included when CONFIG_BLOCK=n.
So, it is pointless to surround offending code with #ifdef
just for the purpose of satisfying the header-test.


I started to think
compiling all headers is more painful than useful.


MW is closing, so I am thinking of disabling it for now
to take time to re-think.


diff --git a/init/Kconfig b/init/Kconfig
index bd7d650d4a99..cbb31d134f7e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -111,6 +111,7 @@ config HEADER_TEST
 config KERNEL_HEADER_TEST
        bool "Compile test kernel headers"
        depends on HEADER_TEST
+       depends on BROKEN
        help
          Headers in include/ are used to build external moduls.
          Compile test them to ensure they are self-contained, i.e.



Maybe, we should compile-test headers
only when it is reasonable to do so.

-- 
Best Regards
Masahiro Yamada
