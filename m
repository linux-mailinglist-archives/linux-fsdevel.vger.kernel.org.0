Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E77B305253
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 06:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhA0FqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 00:46:06 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59205 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234371AbhA0FhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 00:37:19 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10R5aR23030931
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 00:36:28 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B445515C3709; Wed, 27 Jan 2021 00:36:27 -0500 (EST)
Date:   Wed, 27 Jan 2021 00:36:27 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Amy Parker <enbyamy@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Getting a new fs in the kernel
Message-ID: <YBD72wlZC323yhqZ@mit.edu>
References: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
 <BYAPR04MB4965F2E2624369B34346CC5686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965F2E2624369B34346CC5686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 07:06:55PM +0000, Chaitanya Kulkarni wrote:
> From what I've seen you can post the long patch-series as an RFC and get the
> 
> discussion started.
> 
> The priority should be ease of review and not the total patch-count.

File systems are also complicated enough that it's useful to make the
patches available via a git repo, and it's highly recommended that you
are rebasing it against the latest kernel on a regular basis.

I also strongly recommend that once you get something that mostly
works, that you start doing regression testing of the file system.
Most of the major file systems in Linux use xfstests for their
testing.  One of the things that I've done is to package up xfstests
as a test appliance, suitable for running under KVM or using Google
Compute Engine, as a VM, to make it super easy for people to run
regression tests.  (One of my original goals for packaging it up was
to make it easy for graduate students who were creating research file
systems to try running regression tests so they could find potential
problems --- and understand how hard it is to make a robust,
production-ready file system, by giving them a realtively well
documented, turn-key system for running file system regression tests.)

For more information, see:

    https://thunk.org/gce-xfstests
    https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
    https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md
    https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md

The final thing I'll point out is that file system development is a
team sport.  Industry estimates are that it takes between 50 and 200
person-years to create a production-ready, general purpose enterprise
file system.  For example, ZFS took seven years to develop, starting
with a core team of 4, and growing to over 14 developers by the time
it was announced.  And that didn't include all of the QA, release
engineering, testers, performance engineers, to get it integrated into
the Solaris product.  Even after it was announced, it was a good four
years before customers trusted it for production workloads.

If you look at the major file systems in Linux: ext4, xfs, btrfs,
f2fs, etc., you'll find that none of them are solo endeavors, and all
of them have multiple companies who are employing the developers who
work on them.  Figuring out how to convince companies that there are
good business reasons for them to support the developers of your file
system is important, since in order to keep things going for the long
haul, it really needs to be more than a single person's hobby.

Good luck!

					- Ted
