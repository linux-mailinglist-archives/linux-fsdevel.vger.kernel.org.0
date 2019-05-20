Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42F22FF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 11:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfETJQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 05:16:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:37692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730677AbfETJQC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 05:16:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE23FAE4B;
        Mon, 20 May 2019 09:15:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F16311E3C5F; Mon, 20 May 2019 11:15:58 +0200 (CEST)
Date:   Mon, 20 May 2019 11:15:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, jack@suse.cz,
        jmoyer@redhat.com, amakhalov@vmware.com, anishs@vmware.com,
        srivatsab@vmware.com
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Message-ID: <20190520091558.GC2172@quack2.suse.cz>
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <20190518192847.GB14277@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518192847.GB14277@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 18-05-19 15:28:47, Theodore Ts'o wrote:
> On Sat, May 18, 2019 at 08:39:54PM +0200, Paolo Valente wrote:
> > I've addressed these issues in my last batch of improvements for
> > BFQ, which landed in the upcoming 5.2. If you give it a try, and
> > still see the problem, then I'll be glad to reproduce it, and
> > hopefully fix it for you.
> 
> Hi Paolo, I'm curious if you could give a quick summary about what you
> changed in BFQ?
> 
> I was considering adding support so that if userspace calls fsync(2)
> or fdatasync(2), to attach the process's CSS to the transaction, and
> then charge all of the journal metadata writes the process's CSS.  If
> there are multiple fsync's batched into the transaction, the first
> process which forced the early transaction commit would get charged
> the entire journal write.  OTOH, journal writes are sequential I/O, so
> the amount of disk time for writing the journal is going to be
> relatively small, and especially, the fact that work from other
> cgroups is going to be minimal, especially if hadn't issued an
> fsync().

But this makes priority-inversion problems with ext4 journal worse, doesn't
it? If we submit journal commit in blkio cgroup of some random process, it
may get throttled which then effectively blocks the whole filesystem. Or do
you want to implement a more complex back-pressure mechanism where you'd
just account to different blkio cgroup during journal commit and then
throttle as different point where you are not blocking other tasks from
progress?

> In the case where you have three cgroups all issuing fsync(2) and they
> all landed in the same jbd2 transaction thanks to commit batching, in
> the ideal world we would split up the disk time usage equally across
> those three cgroups.  But it's probably not worth doing that...
> 
> That being said, we probably do need some BFQ support, since in the
> case where we have multiple processes doing buffered writes w/o fsync,
> we do charnge the data=ordered writeback to each block cgroup.  Worse,
> the commit can't complete until the all of the data integrity
> writebacks have completed.  And if there are N cgroups with dirty
> inodes, and slice_idle set to 8ms, there is going to be 8*N ms worth
> of idle time tacked onto the commit time.

Yeah. At least in some cases, we know there won't be any more IO from a
particular cgroup in the near future (e.g. transaction commit completing,
or when the layers above IO scheduler already know which IO they are going
to submit next) and in that case idling is just a waste of time. But so far
I haven't decided how should look a reasonably clean interface for this
that isn't specific to a particular IO scheduler implementation.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
