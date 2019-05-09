Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1D6218AD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 15:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEINhX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 09:37:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54960 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726195AbfEINhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 09:37:23 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x49DZpAW030412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 May 2019 09:35:52 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6AC26420024; Thu,  9 May 2019 09:35:51 -0400 (EDT)
Date:   Thu, 9 May 2019 09:35:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Knut Omang <knut.omang@oracle.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
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
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190509133551.GD29703@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Knut Omang <knut.omang@oracle.com>,
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
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
 <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 09, 2019 at 01:52:15PM +0200, Knut Omang wrote:
> 1) Tests that exercises typically algorithmic or intricate, complex
>    code with relatively few outside dependencies, or where the dependencies 
>    are considered worth mocking, such as the basics of container data 
>    structures or page table code. If I get you right, Ted, the tests 
>    you refer to in this thread are such tests. I believe covering this space 
>    is the goal Brendan has in mind for KUnit.

Yes, that's correct.  I'd also add that one of the key differences is
that it sounds like Frank and you are coming from the perspective of
testing *device drivers* where in general there aren't a lot of
complex code which is hardware independent.  After all, the vast
majority of device drivers are primarily interface code to hardware,
with as much as possible abstracted away to common code.  (Take, for
example, the model of the SCSI layer; or all of the kobject code.)

> 2) Tests that exercises interaction between a module under test and other 
>    parts of the kernel, such as testing intricacies of the interaction of 
>    a driver or file system with the rest of the kernel, and with hardware, 
>    whether that is real hardware or a model/emulation. 
>    Using your testing needs as example again, Ted, from my shallow understanding,
>    you have such needs within the context of xfstests (https://github.com/tytso/xfstests)

Well, upstream is for xfstests is git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

The test framework where I can run 20 hours worth of xfstests
(multiple file system features enabled, multiple mount options, etc.)
in 3 hours of wall clock time using multiple cloud VM is something
called gce-xfstests.

I also have kvm-xfstests, which optimizes low test latency, where I
want to run a one or a small number of tests with a minimum of
overhead --- gce startup and shutdown is around 2 minutes, where as
kvm startup and shutdown is about 7 seconds.  As far as I'm concerned,
7 seconds is still too slow, but that's the best I've been able to do
given all of the other things I want a test framework to do, including
archiving test results, parsing the test results so it's easy to
interpret, etc.  Both kvm-xfstests and gce-xfstests are located at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

So if Frank's primary argument is "too many frameworks", it's already
too late.  The block layer has blktests has a seprate framework,
called blktests --- and yeah, it's a bit painful to launch or learn
how to set things up.

That's why I added support to run blktests using gce-xfstests and
kvm-xfstests, so that "gce-xfstests --blktests" or "kvm-xfstests
--xfstests" will pluck a kernel from your build tree, and launch at
test appliance VM using that kernel and run the block layer tests.

The point is we *already* have multiple test frameworks, which are
optimized for testing different parts of the kernel.  And if you plan
to do a lot of work in these parts of the kernel, you're going to have
to learn how to use some other test framework other than kselftest.
Sorry, that's just the way it goes.

Of course, I'll accept trivial patches that haven't been tested using
xfstests --- but that's because I can trivially run the smoke test for
you.  Of course, if I get a lot of patches from a contributor which
cause test regressions, I'll treat them much like someone who
contribute patches which fail to build.  I'll apply pressure to the
contributor to actually build test, or run a ten minute kvm-xfstests
smoke test.  Part of the reason why I feel comfortable to do this is
it's really easy to run the smoke test.  There are pre-compiled test
appliances, and a lot of documentation:

https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

This is why I have close to zero sympathy to Frank's complaint that
extra test frameworks are a bad thing.  To me, that's whining.  I've
done a huge amount of work to meet contributors more than half-way.
The insistence that "There Must Be One", ala the Highlander movie, is
IMHO so wrong that it's not even close.  Is it really that hard to do
a "git pull", download a test appliance, set up a config file to tell
kvm-xfstests where to find your build tree, and then run "kvm-xfstests
--smoke" or "gce-xfstests --smoke"?  Cry me a river.

There are already multiple test frameworks, and if you expect to do a
lot of work in a particular subsystem, you'll be expected to use the
Maintainer's choice of tests.  Deal with it.  We do this so we can
scale to the number of contributors we have in our subsystem.

> To 1) I agree with Frank in that the problem with using UML is that you still have to
> relate to the complexity of a kernel run time system, while what you really want for these
> types of tests is just to compile a couple of kernel source files in a normal user land
> context, to allow the use of Valgrind and other user space tools on the code.

"Just compiling a couple of kernel source files in a normal user land"
is much harder than you think.  It requires writing vast numbers of
mocking functions --- for a file system I would have to simulate the
block device layer, large portions of the VFS layer, the scheduler and
the locking layer if I want to test locking bugs, etc., etc.  In
practice, UML itself is serving as mocking layer, by its mere
existence.  So when Frank says that KUnit doesn't provide any mocking
functions, I don't at all agree.  Using KUnit and UML makes testing
internal interfaces *far* simpler, especially if the comparison is
"just compile some kernel source files as part of a userspace test
program".

Perhaps your and Frank's experience is different --- perhaps that can
be explained by your past experience and interest in testing device
drivers as opposed to file systems.

The other thing I'd add is that at least for me, a really important
consideration is how quickly we can run tests.  I consider
minimization of developer friction (e.g., all you need to do is
running "make ; kvm-xfstests --smoke" to run tests), and maximizing
developer velocity to be high priority goals.  Developer velocity is
how quickly can you run the tests; ideally, less than 5-10 seconds.

And that's the other reason why I consider unit tests to be a
complement to integration tests.  "gce-xfstests --smoke" takes 10-15
minutes.  If I can have unit tests which takes 5-15 seconds for a
smoke test of the specific part of ext4 that I am modifying (and often
with much better coverage than integration tests from userspace),
that's at really big deal.  I can do this for e2fsprogs; but if I have
to launch a VM, the VM overhead pretty much eats all or most of that
time budget right there.

From looking at your documentation of KTF, you are targetting the use
case of continuous testing.  That's a different testing scenario than
what I'm describing; with continuous testing, overhead measured in
minutes or even tens of minutes is not a big deal.  But if you are
trying to do real-time testing as part of your development process ---
*real* Test Driven Development, then test latency is a really big
deal.

I'll grant that for people who are working on device drivers where
architecture dependencies are a big deal, building for an architecture
where you can run in a virtual environment or using test hardware is
going to be a better way to go.  And Brendan has said he's willing to
look at adapting KUnit so it can be built for use in a virtual
environment to accomodate your requirements.

As far as I'm concerned, however, I would *not* be interested in KTF
unless you could demonstrate to me that launching at test VM, somehow
getting the kernel modules copied into the VM, and running the tests
as kernel modules, has zero overhead compared to using UML.

Ultimately, I'm a pragmatist.  If KTF serves your needs best, good for
you.  If other approaches are better for other parts of the kernel,
let's not try to impose a strict "There Must Be Only One" religion.
That's already not true today, and for good reason.  There are many
different kinds of kernel code, and many different types of test
philosophies.  Trying to force all kernel testing into a single
Procrustean Bed is simply not productive.

Regards,

						- Ted
