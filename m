Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE613646
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2019 01:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfECXlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 19:41:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36366 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfECXlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 19:41:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id b18so6807837otq.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2019 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKALN1OkcwtQhcysb+FWH3t2vFKNjrdMKVQt2ijO0Po=;
        b=uHwVMflHMaQY3whJ1EE4nVizGRxOy/tr5WOjeZAzMUNneEi1VOxLR7ILboGXaDspKX
         EZdcTnWDLsjH5Xuv6Dpbla+mLd+ZOej6UTDsdicbg1f2NGRfNWvT53QLlViJ91MtO47Y
         +NMNZSv0/KOCCjGp/8Z6JcV8oAgctk1uHe5BjikYU+meECnNZzF0Xtb+m6Lql1RyQZ+f
         6pOCAlUul4FDKtOsuwcFiCf6Z4SU4Q97jpl1Ljx2pJqKs6Ok7cLSU5UcjCBf989disYo
         L1k/caWEqmSpv8hm8mIrQVDY6SOrZ43BcimXmBjT67ScyO4HOEunsbiGdbsaE+Lu0zj7
         pGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKALN1OkcwtQhcysb+FWH3t2vFKNjrdMKVQt2ijO0Po=;
        b=GUCUbRmBjlDkWkO2x10SSirnCPVbox6+VGhQE7mbTlR6hTD/Zg+tcBvJNnvojCp7LK
         o12hjZAsrq/NpFfd3klj06T0fcuXxKcaZUD2Ha6dNN3jITNL4pzYZTjP8WHPQ9gdvDXt
         lM8Vny5nBmeKu0gtdQ4+ozdtw+KnAxnZCxZsESmscEi9Nij3mdgSnBqFhJX+xVj8FUrx
         PX+GWrpScHGTCzx+kvn7IU/Ux0/OCET+3B1ZoWaP54fXjbd1tB6hF3Kpi8HGGsye60zc
         bundTfD06cnYRYhVVEZ4qnYgmaxqmqD3AUY82v2uvvICpwSUOtNOypKiMcVoW0zgXiZP
         JZIg==
X-Gm-Message-State: APjAAAX+QTL+YckCfRVPgc6h+astqS0hZVp68RTdmyFweM/Z+gC6vHCq
        svKAonnvZ9a/AHg8cSGA4/HHOWNteFQDf60VMIcCgA==
X-Google-Smtp-Source: APXvYqzBloPRnX50VrJGlf0zwqZMx4kE8jlcjkF1A4MmAb/1CmwV6C22Krcs7y2A5uFCH7cqu5h7HYnPPCqLvVBMptw=
X-Received: by 2002:a9d:5cc3:: with SMTP id r3mr8335667oti.338.1556926881968;
 Fri, 03 May 2019 16:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-17-brendanhiggins@google.com> <20190502110347.GE12416@kroah.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770A3A0@USCULXMSG01.am.sony.com>
 <CAFd5g471Wawu6g14p0AO3aY8VPBKLA0mjHSdfR1qStFGzp3iGQ@mail.gmail.com> <20190503064241.GC20723@kroah.com>
In-Reply-To: <20190503064241.GC20723@kroah.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 3 May 2019 16:41:10 -0700
Message-ID: <CAFd5g44NrKM9WQCF1xW-BWpFNsC05UAS9jt1-S+vNRuBDZVsHQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Bird, Timothy" <Tim.Bird@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu, May 02, 2019 at 11:45:43AM -0700, Brendan Higgins wrote:
> > On Thu, May 2, 2019 at 11:15 AM <Tim.Bird@sony.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Greg KH
> > > >
> > > > On Wed, May 01, 2019 at 04:01:25PM -0700, Brendan Higgins wrote:
> > > > > From: Iurii Zaikin <yzaikin@google.com>
> > > > >
> > > > > KUnit tests for initialized data behavior of proc_dointvec that is
> > > > > explicitly checked in the code. Includes basic parsing tests including
> > > > > int min/max overflow.
> > > > >
> > > > > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > > ---
> > > > >  kernel/Makefile      |   2 +
> > > > >  kernel/sysctl-test.c | 292
> > > > +++++++++++++++++++++++++++++++++++++++++++
> > > > >  lib/Kconfig.debug    |   6 +
> > > > >  3 files changed, 300 insertions(+)
> > > > >  create mode 100644 kernel/sysctl-test.c
> > > > >
> > > > > diff --git a/kernel/Makefile b/kernel/Makefile
> > > > > index 6c57e78817dad..c81a8976b6a4b 100644
> > > > > --- a/kernel/Makefile
> > > > > +++ b/kernel/Makefile
> > > > > @@ -112,6 +112,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomem.o
> > > > >  obj-$(CONFIG_ZONE_DEVICE) += memremap.o
> > > > >  obj-$(CONFIG_RSEQ) += rseq.o
> > > > >
> > > > > +obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
> > > >
> > > > You are going to have to have a "standard" naming scheme for test
> > > > modules, are you going to recommend "foo-test" over "test-foo"?  If so,
> > > > that's fine, we should just be consistant and document it somewhere.
> > > >
> > > > Personally, I'd prefer "test-foo", but that's just me, naming is hard...
> > >
> > > My preference would be "test-foo" as well.  Just my 2 cents.
> >
> > I definitely agree we should be consistent. My personal bias
> > (unsurprisingly) is "foo-test," but this is just because that is the
> > convention I am used to in other projects I have worked on.
> >
> > On an unbiased note, we are currently almost evenly split between the
> > two conventions with *slight* preference for "foo-test": I ran the two
> > following grep commands on v5.1-rc7:
> >
> > grep -Hrn --exclude-dir="build" -e "config [a-zA-Z_0-9]\+_TEST$" | wc -l
> > grep -Hrn --exclude-dir="build" -e "config TEST_[a-zA-Z_0-9]\+" | wc -l
> >
> > "foo-test" has 36 occurrences.
> > "test-foo" has 33 occurrences.
> >
> > The things I am more concerned about is how this would affect file
> > naming. If we have a unit test for foo.c, I think foo_test.c is more
> > consistent with our namespacing conventions. The other thing, is if we
> > already have a Kconfig symbol called FOO_TEST (or TEST_FOO) what
> > should we name the KUnit test in this case? FOO_UNIT_TEST?
> > FOO_KUNIT_TEST, like I did above?
>
> Ok, I can live with "foo-test", as you are right, in a directory listing
> and config option, it makes more sense to add it as a suffix.

Cool, so just for future reference, if we already have a Kconfig
symbol called FOO_TEST (or TEST_FOO) what should we name the KUnit
test in this case? FOO_UNIT_TEST? FOO_KUNIT_TEST, like I did above?
