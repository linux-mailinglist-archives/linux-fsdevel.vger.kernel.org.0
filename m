Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD4915EBE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 10:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEGIBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 04:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfEGIBX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 04:01:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6057820B7C;
        Tue,  7 May 2019 08:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557216081;
        bh=QzyiMEIgGcOHF7/0RhAcYYAteXaKFmx6V5mlxAloU/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYZnGuH3Pbk4yrhdCzdKoMJOLOSIlgRBPlakGO9b31IdpbGDZVFQSkxHJZke5YiqF
         kLlxf+8LdYwPSAUw422OvFILYSfk5W9idQInw+r9Pj1esrAbnpH/5dYqp76eoeqJjE
         y7EgY8L7QWLFChBoIcI/eDpJ/HS6IYXXX+xBrQeg=
Date:   Tue, 7 May 2019 10:01:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190507080119.GB28121@kroah.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 06, 2019 at 08:14:12PM -0700, Frank Rowand wrote:
> On 5/1/19 4:01 PM, Brendan Higgins wrote:
> > ## TLDR
> > 
> > I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
> > 5.2.
> > 
> > Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
> > we would merge through your tree when the time came? Am I remembering
> > correctly?
> > 
> > ## Background
> > 
> > This patch set proposes KUnit, a lightweight unit testing and mocking
> > framework for the Linux kernel.
> > 
> > Unlike Autotest and kselftest, KUnit is a true unit testing framework;
> > it does not require installing the kernel on a test machine or in a VM
> > and does not require tests to be written in userspace running on a host
> > kernel. Additionally, KUnit is fast: From invocation to completion KUnit
> > can run several dozen tests in under a second. Currently, the entire
> > KUnit test suite for KUnit runs in under a second from the initial
> > invocation (build time excluded).
> > 
> > KUnit is heavily inspired by JUnit, Python's unittest.mock, and
> > Googletest/Googlemock for C++. KUnit provides facilities for defining
> > unit test cases, grouping related test cases into test suites, providing
> > common infrastructure for running tests, mocking, spying, and much more.
> 
> As a result of the emails replying to this patch thread, I am now
> starting to look at kselftest.  My level of understanding is based
> on some slide presentations, an LWN article, https://kselftest.wiki.kernel.org/
> and a _tiny_ bit of looking at kselftest code.
> 
> tl;dr; I don't really understand kselftest yet.
> 
> 
> (1) why KUnit exists
> 
> > ## What's so special about unit testing?
> > 
> > A unit test is supposed to test a single unit of code in isolation,
> > hence the name. There should be no dependencies outside the control of
> > the test; this means no external dependencies, which makes tests orders
> > of magnitudes faster. Likewise, since there are no external dependencies,
> > there are no hoops to jump through to run the tests. Additionally, this
> > makes unit tests deterministic: a failing unit test always indicates a
> > problem. Finally, because unit tests necessarily have finer granularity,
> > they are able to test all code paths easily solving the classic problem
> > of difficulty in exercising error handling code.
> 
> (2) KUnit is not meant to replace kselftest
> 
> > ## Is KUnit trying to replace other testing frameworks for the kernel?
> > 
> > No. Most existing tests for the Linux kernel are end-to-end tests, which
> > have their place. A well tested system has lots of unit tests, a
> > reasonable number of integration tests, and some end-to-end tests. KUnit
> > is just trying to address the unit test space which is currently not
> > being addressed.
> 
> My understanding is that the intent of KUnit is to avoid booting a kernel on
> real hardware or in a virtual machine.  That seems to be a matter of semantics
> to me because isn't invoking a UML Linux just running the Linux kernel in
> a different form of virtualization?
> 
> So I do not understand why KUnit is an improvement over kselftest.
> 
> It seems to me that KUnit is just another piece of infrastructure that I
> am going to have to be familiar with as a kernel developer.  More overhead,
> more information to stuff into my tiny little brain.
> 
> I would guess that some developers will focus on just one of the two test
> environments (and some will focus on both), splitting the development
> resources instead of pooling them on a common infrastructure.
> 
> What am I missing?

kselftest provides no in-kernel framework for testing kernel code
specifically.  That should be what kunit provides, an "easy" way to
write in-kernel tests for things.

Brendan, did I get it right?

thanks,

greg k-h
