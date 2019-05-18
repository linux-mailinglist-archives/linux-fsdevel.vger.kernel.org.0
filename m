Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C36B224AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 21:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfERT3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 May 2019 15:29:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52260 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729206AbfERT3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 May 2019 15:29:48 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4IJT0Gx030129
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 May 2019 15:29:01 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5DC5E420027; Sat, 18 May 2019 15:28:47 -0400 (EDT)
Date:   Sat, 18 May 2019 15:28:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, jack@suse.cz,
        jmoyer@redhat.com, amakhalov@vmware.com, anishs@vmware.com,
        srivatsab@vmware.com
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Message-ID: <20190518192847.GB14277@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Paolo Valente <paolo.valente@linaro.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, jack@suse.cz,
        jmoyer@redhat.com, amakhalov@vmware.com, anishs@vmware.com,
        srivatsab@vmware.com
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 18, 2019 at 08:39:54PM +0200, Paolo Valente wrote:
> I've addressed these issues in my last batch of improvements for
> BFQ, which landed in the upcoming 5.2. If you give it a try, and
> still see the problem, then I'll be glad to reproduce it, and
> hopefully fix it for you.

Hi Paolo, I'm curious if you could give a quick summary about what you
changed in BFQ?

I was considering adding support so that if userspace calls fsync(2)
or fdatasync(2), to attach the process's CSS to the transaction, and
then charge all of the journal metadata writes the process's CSS.  If
there are multiple fsync's batched into the transaction, the first
process which forced the early transaction commit would get charged
the entire journal write.  OTOH, journal writes are sequential I/O, so
the amount of disk time for writing the journal is going to be
relatively small, and especially, the fact that work from other
cgroups is going to be minimal, especially if hadn't issued an
fsync().

In the case where you have three cgroups all issuing fsync(2) and they
all landed in the same jbd2 transaction thanks to commit batching, in
the ideal world we would split up the disk time usage equally across
those three cgroups.  But it's probably not worth doing that...

That being said, we probably do need some BFQ support, since in the
case where we have multiple processes doing buffered writes w/o fsync,
we do charnge the data=ordered writeback to each block cgroup.  Worse,
the commit can't complete until the all of the data integrity
writebacks have completed.  And if there are N cgroups with dirty
inodes, and slice_idle set to 8ms, there is going to be 8*N ms worth
of idle time tacked onto the commit time.

If we charge the journal I/O to the cgroup, and there's only one
process doing the 

   dd if=/dev/zero of=/root/test.img bs=512 count=10000 oflags=dsync

then we don't need to worry about this failure mode, since both the
journal I/O and the data writeback will be hitting the same cgroup.
But that's arguably an artificial use case, and much more commonly
there will be multiple cgroups all trying to at least some file system
I/O.

						- Ted
