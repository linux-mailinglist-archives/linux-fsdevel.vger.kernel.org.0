Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69AEE127EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 08:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfECGmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 02:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfECGmo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 02:42:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8DA92075E;
        Fri,  3 May 2019 06:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556865763;
        bh=eSwQ5MQqLLW9fJpp5z5L5wdOX/D46QfRbdkcz2wVbPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8bRpPlYbJzGxvGVmp2uL9uXUULFTshM8QSJGuUzKTk19JZNQGVZMB/Y6WWZUO0Xk
         +Bv6ggtukUnBovktNVzoNapiH66e7QwUF2ou6Nv/zJgv58EYkE7vJAmpFpEvKEp4BX
         kligVpalV/krymcpGsId8WYpq006/flMnMSyr3rA=
Date:   Fri, 3 May 2019 08:42:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     "Bird, Timothy" <Tim.Bird@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah@kernel.org, devicetree <devicetree@vger.kernel.org>,
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
Subject: Re: [PATCH v2 16/17] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
Message-ID: <20190503064241.GC20723@kroah.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-17-brendanhiggins@google.com>
 <20190502110347.GE12416@kroah.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770A3A0@USCULXMSG01.am.sony.com>
 <CAFd5g471Wawu6g14p0AO3aY8VPBKLA0mjHSdfR1qStFGzp3iGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g471Wawu6g14p0AO3aY8VPBKLA0mjHSdfR1qStFGzp3iGQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 02, 2019 at 11:45:43AM -0700, Brendan Higgins wrote:
> On Thu, May 2, 2019 at 11:15 AM <Tim.Bird@sony.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Greg KH
> > >
> > > On Wed, May 01, 2019 at 04:01:25PM -0700, Brendan Higgins wrote:
> > > > From: Iurii Zaikin <yzaikin@google.com>
> > > >
> > > > KUnit tests for initialized data behavior of proc_dointvec that is
> > > > explicitly checked in the code. Includes basic parsing tests including
> > > > int min/max overflow.
> > > >
> > > > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > ---
> > > >  kernel/Makefile      |   2 +
> > > >  kernel/sysctl-test.c | 292
> > > +++++++++++++++++++++++++++++++++++++++++++
> > > >  lib/Kconfig.debug    |   6 +
> > > >  3 files changed, 300 insertions(+)
> > > >  create mode 100644 kernel/sysctl-test.c
> > > >
> > > > diff --git a/kernel/Makefile b/kernel/Makefile
> > > > index 6c57e78817dad..c81a8976b6a4b 100644
> > > > --- a/kernel/Makefile
> > > > +++ b/kernel/Makefile
> > > > @@ -112,6 +112,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomem.o
> > > >  obj-$(CONFIG_ZONE_DEVICE) += memremap.o
> > > >  obj-$(CONFIG_RSEQ) += rseq.o
> > > >
> > > > +obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
> > >
> > > You are going to have to have a "standard" naming scheme for test
> > > modules, are you going to recommend "foo-test" over "test-foo"?  If so,
> > > that's fine, we should just be consistant and document it somewhere.
> > >
> > > Personally, I'd prefer "test-foo", but that's just me, naming is hard...
> >
> > My preference would be "test-foo" as well.  Just my 2 cents.
> 
> I definitely agree we should be consistent. My personal bias
> (unsurprisingly) is "foo-test," but this is just because that is the
> convention I am used to in other projects I have worked on.
> 
> On an unbiased note, we are currently almost evenly split between the
> two conventions with *slight* preference for "foo-test": I ran the two
> following grep commands on v5.1-rc7:
> 
> grep -Hrn --exclude-dir="build" -e "config [a-zA-Z_0-9]\+_TEST$" | wc -l
> grep -Hrn --exclude-dir="build" -e "config TEST_[a-zA-Z_0-9]\+" | wc -l
> 
> "foo-test" has 36 occurrences.
> "test-foo" has 33 occurrences.
> 
> The things I am more concerned about is how this would affect file
> naming. If we have a unit test for foo.c, I think foo_test.c is more
> consistent with our namespacing conventions. The other thing, is if we
> already have a Kconfig symbol called FOO_TEST (or TEST_FOO) what
> should we name the KUnit test in this case? FOO_UNIT_TEST?
> FOO_KUNIT_TEST, like I did above?

Ok, I can live with "foo-test", as you are right, in a directory listing
and config option, it makes more sense to add it as a suffix.

thanks,

greg k-h
