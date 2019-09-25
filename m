Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC33BDE5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405804AbfIYMyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 08:54:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52301 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405798AbfIYMyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 08:54:36 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8PCsAFi024978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Sep 2019 08:54:17 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D5A834200BF; Wed, 25 Sep 2019 08:54:09 -0400 (EDT)
Date:   Wed, 25 Sep 2019 08:54:09 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
Message-ID: <20190925125409.GD18094@mit.edu>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <875f3b55-4fe1-e2c3-5bee-ca79e4668e72@yandex-team.ru>
 <20190923145242.GF2233839@devbig004.ftw2.facebook.com>
 <ed5d930c-88c6-c8e4-4a6c-529701caa993@yandex-team.ru>
 <20190924073940.GM6636@dread.disaster.area>
 <edafed8a-5269-1e54-fe31-7ba87393eb34@yandex-team.ru>
 <20190925071854.GC804@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925071854.GC804@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 25, 2019 at 05:18:54PM +1000, Dave Chinner wrote:
> > > ANd, really such strict writebehind behaviour is going to cause all
> > > sorts of unintended problesm with filesystems because there will be
> > > adverse interactions with delayed allocation. We need a substantial
> > > amount of dirty data to be cached for writeback for fragmentation
> > > minimisation algorithms to be able to do their job....
> > 
> > I think most sequentially written files never change after close.
> 
> There are lots of apps that write zeros to initialise and allocate
> space, then go write real data to them. Database WAL files are
> commonly initialised like this...

Fortunately, most of the time Enterprise Database files which are
initialized with a fd which is then kept open.  And it's only a single
file.  So that's a hueristic that's not too bad to handle so long as
it's only triggered when there are no open file descriptors on said
inode.  If something is still keeping the file open, then we do need
to be very careful about writebehind.

That behind said, with databases, they are goind to be calling
fdatasync(2) and fsync(2) all the time, so it's unlikely writebehind
is goint to be that much of an issue, so long as the max writebehind
knob isn't set too insanely low.  It's been over ten years since I
last looked at this, and so things may have very likely changed, but
one enterprise database I looked at would fallocate 32M, and then
write 32M of zeros to make sure blocks were marked as initialized, so
that further random writes wouldn't cause metadata updates.

Now, there *are* applications which log to files via append, and in
the worst case, they don't actually keep a fd open.  Examples of this
would include scripts that call logger(1) very often.  But in general,
taking into account whether or not there is still a fd holding the
inode open to influence how aggressively we do writeback does make
sense.

Finally, we should remember that this will impact battery life on
laptops.  Perhaps not so much now that most laptops have SSD's instead
of HDD's, but aggressive writebehind does certainly have tradeoffs,
and what makes sense for a NVMe attached SSD is going to be very
different for a $2 USB thumb drive picked up at the checkout aisle of
Staples....

						- Ted
