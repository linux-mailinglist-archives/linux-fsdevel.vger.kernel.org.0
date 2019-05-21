Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3322580C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 21:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfEUTLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 15:11:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43247 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726419AbfEUTLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 15:11:13 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4LJAYLu009279
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 May 2019 15:10:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0FC18420481; Tue, 21 May 2019 15:10:34 -0400 (EDT)
Date:   Tue, 21 May 2019 15:10:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jan Kara <jack@suse.cz>, Paolo Valente <paolo.valente@linaro.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, jmoyer@redhat.com,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Message-ID: <20190521191033.GA4855@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, jmoyer@redhat.com,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <20190518192847.GB14277@mit.edu>
 <20190520091558.GC2172@quack2.suse.cz>
 <20190521164814.GC2591@mit.edu>
 <20190521181952.4vpruone2mzbczpw@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521181952.4vpruone2mzbczpw@MacBook-Pro-91.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 02:19:53PM -0400, Josef Bacik wrote:
> Chris is adding a REQ_ROOT (or something) flag that means don't throttle me now,
> but the the blkcg attached to the bio is the one that is responsible for this
> IO.  Then for io.latency we'll let the io go through unmolested but it gets
> counted to the right cgroup, and if then we're exceeding latency guarantees we
> have the ability to schedule throttling for that cgroup in a safer place.  This
> would eliminate the data=ordered issue for ext4, you guys keep doing what you
> are doing and we'll handle throttling elsewhere, just so long as the bio's are
> tagged with the correct source then all is well.  Thanks,

Great, it sounds like Chris also came up with the the entangled writes
flag idea (although with probably a better name than I did :-).  So
now all we need to do is to plumb a flag through the writeback code so
that file systems (or the VFS player) implementing syncfs(2) or
fsync(2) can arrange to have that flag set if necessary.

Speaking of syncfs(2), something which we considered doing at Google
many years ago (but never did) was to implement a hack so that someone
calling syncfs(2) or sync(2) when they were not root, would make that
sys call be a no-op.  The reason for this was on heavy loaded
machines, an SRE logged in as a non-root user might absent-mindly type
"sync", and that would cause a storm of I/O traffic that would really
mess up the machine.  The jobs that were in the low latency bucket
would be protected (since we didn't run with journalling), but those
that were in the best efforts bucket would be really unhappy.

If we have a "don't throttle me now" REQ_ROOT flag combined with
journalling, then someone running "sync", even if it's by accident,
could really ruin a low-latency job's day, and in a container
environment, there really is no reason for a non-root user to be
wanting to request a syncfs(2) or sync(2).  So maybe we should have a
way to make it be a no-op (or return an error, but that might surprise
some applications) for non-privileged users.  Maybe as a per-mount
flag/option, or via some other tunable?

						- Ted
