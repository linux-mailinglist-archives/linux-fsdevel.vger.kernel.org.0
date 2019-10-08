Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE97CFC4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfJHOXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 10:23:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:59186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbfJHOXL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:23:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3BB1B199;
        Tue,  8 Oct 2019 14:23:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 22C2DDA7FB; Tue,  8 Oct 2019 16:23:22 +0200 (CEST)
Date:   Tue, 8 Oct 2019 16:23:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Avoid getting stuck during cyclic writebacks
Message-ID: <20191008142322.GP2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Tejun Heo <tj@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
References: <20191003142713.GA2622251@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003142713.GA2622251@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 03, 2019 at 07:27:13AM -0700, Tejun Heo wrote:
> During a cyclic writeback, extent_write_cache_pages() uses done_index
> to update the writeback_index after the current run is over.  However,
> instead of current index + 1, it gets to to the current index itself.
> 
> Unfortunately, this, combined with returning on EOF instead of looping
> back, can lead to the following pathlogical behavior.

Tricky stuff.

> 1. There is a single file which has accumulated enough dirty pages to
>    trigger balance_dirty_pages() and the writer appending to the file
>    with a series of short writes.
> 
> 2. bdp kicks in, wakes up background writeback and sleeps.

What does 'bdp' refer to?

> 3. Writeback kicks in and the cursor is on the last page of the dirty
>    file.  Writeback is started or skipped if already in progress.  As
>    it's EOF, extent_write_cache_pages() returns and the cursor is set
>    to done_index which is pointing to the last page.
> 
> 4. Writeback is done.  Nothing happens till bdp finishes, at which
>    point we go back to #1.
> 
> This can almost completely stall out writing back of the file and keep
> the system over dirty threshold for a long time which can mess up the
> whole system.  We encountered this issue in production with a package
> handling application which can reliably reproduce the issue when
> running under tight memory limits.
> 
> Reading the comment in the error handling section, this seems to be to
> avoid accidentally skipping a page in case the write attempt on the
> page doesn't succeed.  However, this concern seems bogus.
> 
> On each page, the code either:
> 
> * Skips and moves onto the next page.
> 
> * Fails issue and sets done_index to index + 1.
> 
> * Successfully issues and continue to the next page if budget allows
>   and not EOF.
> 
> IOW, as long as it's not EOF and there's budget, the code never
> retries writing back the same page.  Only when a page happens to be
> the last page of a particular run, we end up retrying the page, which
> can't possibly guarantee anything data integrity related.  Besides,
> cyclic writes are only used for non-syncing writebacks meaning that
> there's no data integrity implication to begin with.

The code was added in a91326679f2a0a4c239 ("Btrfs: make
mapping->writeback_index point to the last written page") after a user
report in https://www.spinics.net/lists/linux-btrfs/msg52628.html , slow
appends that caused fragmentation

What you describe as the cause is similar, but you're partially
reverting the fix that was supposed to fix it. As there's more code
added by the original patch, the revert won't probably bring back the
bug.

The whole function and states are hard to follow, I agree with your
reasoning about the check being bogus and overall I'd rather see fewer
special cases in the function.

Also the removed comment mentions media errors but this was not the
problem for the original report and is not a common scenario either. So
as long as the fallback in such case is sane (ie. set done = 1 and
exit), I don't see futher problems.

> Fix it by always setting done_index past the current page being
> processed.
> 
> Note that this problem exists in other writepages too.

I can see that write_cache_pages does the same done_index updates.  So
it makes sense that the page walking and writeback index tracking
behaviour is consistent, unless extent_write_cache_pages has diverged
too much.

I'll add the patch to misc-next. Thanks.
