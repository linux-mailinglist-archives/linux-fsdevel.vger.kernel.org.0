Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B28211DBCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 02:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbfLMBrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 20:47:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53481 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727084AbfLMBrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 20:47:48 -0500
Received: from callcc.thunk.org (guestnat-104-132-34-105.corp.google.com [104.132.34.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBD1lgYQ028228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 20:47:43 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 54047421A4A; Thu, 12 Dec 2019 20:47:42 -0500 (EST)
Date:   Thu, 12 Dec 2019 20:47:42 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] automating file system benchmarks
Message-ID: <20191213014742.GA250928@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'd like to have a discussion at LSF/MM about making it easier and
more accessible for file system developers to run benchmarks as part
of their development processes.

My interest in this was sparked a few weeks ago, when there was a
click-bait article published on Phoronix, "The Disappointing Direction
Of Linux Performance From 4.16 To 5.4 Kernels"[1], wherein the author
published results which seem to indicate a radical decrease in
performance in a pre-5.4 kernel, which showed the 5.4(-ish) kernel
performance four times worse on a SQLite test.

[1] https://www.phoronix.com/scan.php?page=article&item=linux-416-54&num=1

I tried to reproduce this, and trying to replicate the exact
benchmark, I decided to try using the Phoronix Test Suite (PTS).
Somewhat to my surprise, it was well documented[2], straightforward to
set up, and a lot of care was put into being able to get repeatable
results from running a large set of benchmarks.  And so I added
support[3] for running to my gce-xfstests test automation framework.

[2] https://www.phoronix-test-suite.com/documentation/phoronix-test-suite.html
[3] https://github.com/tytso/xfstests-bld/commit/b8236c94caf0686b1cfacb1348b5a46fa1f52f48

Fortunately, using a controlled set kernel configs it I could find no
evidence of a massive performance regression a few days before 5.4 was
released by Linus.  These results were reproduced by Jan Kara using mmtests.

Josef Bacik added a fio benchmark to xfstests in late 2017[4], and
this was discussed at the 2018 LSF/MM.  Unfortunately, there doesn't
seem to have been any additional work to add benchmarking
functionality to xfstests.

[4] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=e0d95552fdb2948c63b29af4a8169a2027f84a1d

In addition to using xfstests, I have started using PTS to as a way to
sanity check patch submissions to ext4.  I've also started
investigating using mmtests as well; mmtests isn't quite as polished
and well documented, but has better support for running running
monitoring scripts (e.g., iostat, perf, systemtap, etc.) in parallel
with running benchmarks as workloads.

I'd like to share what I've learned, and also hopefully learn what
other file system developers have been using to automate measuring
file system performance as a part of their development workflow,
especially if it has been packaged up so other people can more easily
replicate their findings.

Cheers,

							- Ted
