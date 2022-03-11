Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EEB4D6A9D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Mar 2022 00:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiCKWnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 17:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCKWnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:43:47 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4122D186B82
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 14:18:48 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22BM4b9T021054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Mar 2022 17:04:38 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6738015C3E98; Fri, 11 Mar 2022 17:04:37 -0500 (EST)
Date:   Fri, 11 Mar 2022 17:04:37 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <YivHdetTMVW260df@mit.edu>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
 <YiepUS/bDKTNA5El@sashalap>
 <Yij4lD19KGloWPJw@bombadil.infradead.org>
 <Yirc69JyH5N/pXKJ@mit.edu>
 <Yiu2mRwguHhbVpLJ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yiu2mRwguHhbVpLJ@bombadil.infradead.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 12:52:41PM -0800, Luis Chamberlain wrote:
> 
> The only way to move forward with enabling more automation for kernel
> code integration is through better and improved kernel test automation.
> And it is *exactly* why I've been working so hard on that problem.

I think we're on the same page here.

> Also let's recall that just because you have your own test framework
> it does not mean we could not benefit from others testing our
> filesystems on their own silly hardware at home as well. Yes tons
> of projects can be used which wrap fstests...

No argument from me!  I'm strongly in favor of diversity in test
framework automation as well as test environments.

In particular, I think there are some valuable things we can learn
from each other, in terms of cross polination in terms of features and
as well as feedback about how easy it is to use a particular test
framework.

For example: README.md doesn't say anything about running make as root
when running "make" as kdevops.  At least, I *think* this is why
running make as kdevops failed:

fatal: [localhost]: FAILED! => {"changed": true, "cmd": ["/usr/sbin/apparmor_status", "--enabled"], "delta": "0:00:00.001426", "end": "2022-03-11 16:23:11.769658", "failed_when_result": true, "rc": 0, "start": "2022-03-11 16:23:11.768232", "stderr": "", "stderr_lines": [], "stdout": "", "stdout_lines": []}

(I do have apparmor installed, but it's currently not enabled.  I
haven't done more experimentation since I'm a bit scared of running
"make XXX" as root for any package I randomly download from the net,
so I haven't explored trying to use kdevops, at least not until I set
up a sandboxed VM.  :-)

Including the Debian package names that should be installed would also
be helpful in kdevops/doc/requirements.md.  That's not a problem for
the experienced Debian developer, but one of my personal goals for
kvm-xfstests and gce-xfstests is to allow a random graduate student
who has presented some research file system like Betrfs at the Usenix
FAST conference to be able to easily run fstests.  And it sounds like
you have similar goals of "enabling the average user to also easily
run tests".


> but I never found one
> as easy to use as compiling the kernel and running a few make commands.

I've actually done a lot of work to optimize developer velocity using
my test framework.  So for example:

kvm-xfstests install-kconfig    # set up a kernel Kconfig suitable for kvm-xfstests and gce-xfstests
make
kvm-xfstests smoke     # boot the test appliance VM, using the kernel that was just built

And a user can test a particular stable kernel using a single command
line (this will checkout a particular kernel, and build it on a build
VM, and then launch tests in parallel on a dozen or so VM's):

gce-xfstests ltm -c ext4/all -g auto --repo stable.git --commit v5.15.28

... or if we want to bisect a particular test failure, we might do
something like this:

gce-xfstests ltm -c ext4 generic/361 --bisect-good v5.15 --bisect-bad v5.16

... or I can establish a watcher that will automatically build a git
tree when a branch on a git tree changes:

gce-xfstests ltm -c ext4/4k -g auto --repo next.git --watch master

Granted, this only works on GCE --- but feel free to take these ideas
and integrate them into kdevops if you feel inspired to do so.  :-)

> There is the concept of results too and a possible way to share things..
> but this is getting a bit off topic and I don't want to bore people more.

This would be worth chatting about, perhaps at LSF/MM.  xfstests
already supports junit results files; we could convert it to TAP
format, but junit has more functionality, so perhaps the right
approach is to have tools that can support both TAP and junit?  What
about some way to establish interchange of test artifacts?  i.e.,
saving the kernel logs, and the generic/NNN.full and
generic/NNN.out.bad files?

I have a large library of these test results and test artifacts, and
perhaps others would find it useful if we had a way sharing test
results between developers, especially we have multiple test
infrastructures that might be running ext4, f2fs, and xfs tests?

Cheers,

						- Ted
