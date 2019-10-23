Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49290E26C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 00:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405969AbfJWW6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 18:58:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34567 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392721AbfJWW6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:58:36 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9NMwPcW028147
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 18:58:26 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CB9B4420456; Wed, 23 Oct 2019 18:58:24 -0400 (EDT)
Date:   Wed, 23 Oct 2019 18:58:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Cyril Hrubis <chrubis@suse.cz>, Yong Sun <yosun@suse.com>
Subject: Re: "New" ext4 features tests in LTP
Message-ID: <20191023225824.GB7630@mit.edu>
References: <20191023155846.GA28604@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023155846.GA28604@dell5510>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 05:58:46PM +0200, Petr Vorel wrote:
> ext4-inode-version [4]
> ------------------
> Directory containing the shell script which is used to test inode version field
> on disk of ext4.

This is basically testing whether or not i_version gets incremented
after various file system operations.  There's some checks about
whether i_version is 32 bit or 64 bit based on the inode size, which
seems a bit pointless, and also checking whether the file system can
be mounted as ext3, which is even more pointless.

The i_version increment check can be done in a much more general (file
systme independant) way by using the FS_IOC_GETVERSION ioctl (there is
also an FS_IOC_SETVERSION).  

> ext4-journal-checksum [5]
> ---------------------
> Directory containing the shell script which is used to test journal checksumming
> of ext4.

This is basically checking whether you can mount an ext4 file system
with the journal checksum options.  Seems kinda pointless to me.  I'm
guessing that perhaps the test authors were trying to hit some
artificial code coverage metric, perhaps?

> ext4-nsec-timestamps [6]
> --------------------
> Directory containing the shell script which is used to test nanosec timestamps
> of ext4.

This basically tests that the file system supports nanosecond
timestamps, with a 0.3% false positive failure rate.   Again, why?

> ext4-online-defrag [7]
> ------------------
> Directory containing the shell script which is used to test online defrag
> feature of ext4.

We already have tests of online defrag in xfstests: ext4/301,
ext4/302, ext4/303, and ext4/304.  And they do a much better job of
stress testing the defrag code than the very simple "let's tickle the
code paths to hit the code coverage metric" style of testing in this
script.

> ext4-persist-prealloc [8]
> ---------------------
> Directory containing the shell script which is used to test persist prealloc
> feature of ext4.

We have lots and lots of fallocate tests in xfstests.  what is in ltp
is just "let's run fallocate in the happy path, without any stress
tests" style test.  There's a reason why a lot of people really like
to hate on pointed-haired managers who push for code coverage
metrics....

> ext4-subdir-limit [9]
> -----------------
> Directory containing the shell script which is used to test subdirectory limit
> of ext4. According to the kernel documentation, we create more than 32000
> subdirectorys on the ext4 filesystem.

This is a valid test, although it's not what I would call a "high
value" test.  (As in, it's testing maybe a total of four simple lines
of code that are highly unlikely to fail.)

> ext4-uninit-groups [10]
> ------------------
> Directory containing the shell script which is used to test uninitialized groups
> feature of ext4.

The uninitialized block group feature is enabled by default for ext4
these days, and we do extensive testing with it enabled.  I also test
in ext3 compatibility mode, which tests the "not unitialized groups
case".  The oldalloc mount option is a no-op these days, so the fact
that the ltp test tries to test orlov versus oldalloc is pointless.

Cheers,

							- Ted
