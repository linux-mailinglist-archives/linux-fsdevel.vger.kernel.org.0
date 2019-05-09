Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1053C18374
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 04:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEICAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 22:00:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46167 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbfEICAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 22:00:12 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x491wvb2023686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 May 2019 21:58:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D504A420024; Wed,  8 May 2019 21:58:56 -0400 (EDT)
Date:   Wed, 8 May 2019 21:58:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190509015856.GB7031@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org,
        sboyd@kernel.org, shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
 <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 08, 2019 at 05:43:35PM -0700, Frank Rowand wrote:
> kselftest provides a mechanism for in-kernel tests via modules.  For
> example, see:
> 
>   tools/testing/selftests/vm/run_vmtests invokes:
>     tools/testing/selftests/vm/test_vmalloc.sh
>       loads module:
>         test_vmalloc
>         (which is built from lib/test_vmalloc.c if CONFIG_TEST_VMALLOC)

The majority of the kselftests are implemented as userspace programs.

You *can* run in-kernel test using modules; but there is no framework
for the in-kernel code found in the test modules, which means each of
the in-kernel code has to create their own in-kernel test
infrastructure.  

That's much like saying you can use vice grips to turn a nut or
bolt-head.  You *can*, but it might be that using a monkey wrench
would be a much better tool that is much easier.

What would you say to a wood worker objecting that a toolbox should
contain a monkey wrench because he already knows how to use vise
grips, and his tiny brain shouldn't be forced to learn how to use a
wrench when he knows how to use a vise grip, which is a perfectly good
tool?

If you want to use vice grips as a hammer, screwdriver, monkey wrench,
etc.  there's nothing stopping you from doing that.  But it's not fair
to object to other people who might want to use better tools.

The reality is that we have a lot of testing tools.  It's not just
kselftests.  There is xfstests for file system code, blktests for
block layer tests, etc.   We use the right tool for the right job.

						- Ted
