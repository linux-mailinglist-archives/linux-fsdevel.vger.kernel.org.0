Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34D3DF818
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 00:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhHCWtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 18:49:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35432 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230141AbhHCWtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:49:20 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 173MmaxP028414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Aug 2021 18:48:36 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 291E015C3DEA; Tue,  3 Aug 2021 18:48:36 -0400 (EDT)
Date:   Tue, 3 Aug 2021 18:48:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        zajec5@gmail.com, "Darrick J. Wong" <djwong@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <YQnHxIU+EAAxIjZA@mit.edu>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 11:07:29AM -0700, Linus Torvalds wrote:
> 
> The argument that "it's already in a much better state than the old
> ntfs driver" may not be a very strong technical argument (not because
> of any Paragon problems - just because the old ntfs driver is not
> great), but it _is_ a fairly strong argument for merging the new one
> from Paragon.

I'm not 100% sure that "it's better than the old driver", actually.
Konstantin has not been responding to Darrick and my questions about
what sort of QA and testing they were doing.

So over the weekend, I decided to take efforts into my own hands, and
made the relatively simple changes to fstests needed to add support
for ntfs and ntfs3 file systems.  The results show that the number
fstests failures in ntfs3 is 23% *more* than ntfs.  This includes a
potential deadlock bug, and generic/475 reliably livelocking.  Ntfs3
is also currently not container compatible, because it's not properly
handling user namespaces.

For more details, please see [1] and [2] for the complete set of test
artifacts.

[1] https://www.kernel.org/pub/linux/kernel/people/tytso/fstests-results/results-ntfs-2021-08-02.tar.xz
[2] https://www.kernel.org/pub/linux/kernel/people/tytso/fstests-results/results-ntfs3-2021-08-03.tar.xz

> And I don't think there has been any huge _complaints_ about the code,
> and I don't think there's been any sign that being outside the kernel
> helps.

Historically, the file system community at large have pushed for a
fairly high bar before a file system is merged into the kernel,
because there was a concern that once a file system got dumped into
fs/ if the maintainers weren't going to commit to continuous
improvement of their file system --- the only leverage we might have
is what effectively amounts to "hazing" to make sure that the
propsective maintainers would actually be serious about continuing to
work on the file system.

One argument for why this should be the case is that unlike a dodgy
driver that "just" causes the kernel to crash, if data ends up getting
corrupted, simply rebooting won't recover the user's data.  And once a
file system is added to mainline, it's a lot harder to remove it if it
turns out to be buggy as all h*ck. 

It's not clear this has been an effective strategy.  And there are
other ways we could handle an abandonware file system --- we could
liberally festoon its Kconfig with warnings and printk "DANGER WILL
ROBINSON" messages when someone attempts to use a dodgy file system in
mainline.  But I think whatever rationale we give for accepting --- or
holding off --- on ntfs3, we should also think about how we should be
handling requests from other file systems such as bcachefs, reiserfs4,
tux3, etc.

Maybe this should be a maintainers summit discussion topic?  I
dunno....

					- Ted

P.S.  Here is the summary of the test results of running ntfs and
ntfs3 on 5.14-rc2, with the latest ntfs3 patches applied.  Note that
for ntfs3, I had to manually exclude generic/475, since running that
test will cause the kernel to lock up and prevent the rest of the
tesets from running.  So that's really 68 fstests failures for ntfs3,
versus 55 fstests failures for ntfs.

And it's really not the absolute number of test failures that bothers
me, so much as the complete radio silence from Konstantin after you've
indicated that you are willing to take the ntfs3 merge request.  It
increases the concerns I personally have that ntfs3 might end up
becoming abandonware after it's been accepted.

ntfs/default: 670 tests, 55 failures, 211 skipped, 34783 seconds
  Failures: generic/003 generic/035 generic/053 generic/062 
    generic/087 generic/088 generic/093 generic/097 generic/099 
    generic/102 generic/105 generic/123 generic/126 generic/193 
    generic/226 generic/237 generic/260 generic/294 generic/306 
    generic/307 generic/314 generic/317 generic/318 generic/319 
    generic/321 generic/355 generic/375 generic/378 generic/409 
    generic/410 generic/411 generic/416 generic/423 generic/424 
    generic/426 generic/427 generic/441 generic/444 generic/452 
    generic/466 generic/467 generic/475 generic/477 generic/500 
    generic/525 generic/529 generic/545 generic/547 generic/553 
    generic/555 generic/564 generic/589 generic/597 generic/629 
    generic/631 

ntfs3/default: 664 tests, 67 failures, 206 skipped, 8106 seconds
  Failures: generic/013 generic/015 generic/034 generic/039 
    generic/040 generic/041 generic/056 generic/057 generic/065 
    generic/066 generic/073 generic/083 generic/090 generic/091 
    generic/092 generic/094 generic/101 generic/102 generic/104 
    generic/106 generic/107 generic/130 generic/225 generic/226 
    generic/228 generic/240 generic/258 generic/263 generic/311 
    generic/317 generic/320 generic/321 generic/322 generic/335 
    generic/336 generic/341 generic/342 generic/343 generic/348 
    generic/360 generic/361 generic/371 generic/376 generic/416 
    generic/427 generic/441 generic/476 generic/480 generic/481 
    generic/483 generic/489 generic/498 generic/502 generic/510 
    generic/512 generic/520 generic/526 generic/527 generic/534 
    generic/538 generic/547 generic/551 generic/552 generic/557 
    generic/598 generic/631 generic/640 

Other file systems for reference:

f2fs/default: 646 tests, 13 failures, 154 skipped, 1812 seconds
  Failures: generic/018 generic/026 generic/050 generic/064
    generic/066 generic/103 generic/219 generic/260 generic/342
    generic/502 generic/506 generic/526 generic/527

btrfs/default: 1075 tests, 8 failures, 219 skipped, 9143 seconds
  Failures: btrfs/012 btrfs/154 btrfs/219 btrfs/220 btrfs/235
    btrfs/241 generic/260 shared/298

xfs/4k: 922 tests, 1 failures, 136 skipped, 5452 seconds
  Failures: xfs/506

ext4/4k: 504 tests, 0 failures, 25 skipped, 6877 seconds

nfs/filestore_v3: 743 tests, 1 failures, 307 skipped, 9261 seconds
  Failures: generic/551

(Note: GCE Filestore uses a Linux kernel so this is testing the nfsv3
client versus a Linux nfsv3 server --- I think the Filestore kernel is
currently using 5.4.129 if I remember correctly.)
