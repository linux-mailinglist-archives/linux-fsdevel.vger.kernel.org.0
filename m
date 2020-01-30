Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 163F114DC76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 15:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgA3OIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 09:08:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59472 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3OIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:08:45 -0500
Received: from [109.134.33.162] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ixAUo-0007pq-GF; Thu, 30 Jan 2020 14:08:38 +0000
Date:   Thu, 30 Jan 2020 15:08:38 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dave Chinner <david@fromorbit.com>,
        Mike Christie <mchristi@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, idryomov@gmail.com,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, martin@urbackup.org,
        Damien.LeMoal@wdc.com, Michal Hocko <mhocko@suse.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
Subject: Re: [PATCH] Add prctl support for controlling mem reclaim V4
Message-ID: <20200130140838.mfl2p3zb5f26kej6@wittgenstein>
References: <20191112001900.9206-1-mchristi@redhat.com>
 <CALvZod47XyD2x8TuZcb9PgeVY14JBwNhsUpN3RAeAt+RJJC=hg@mail.gmail.com>
 <5E2B19C9.6080907@redhat.com>
 <20200124211642.GB7216@dread.disaster.area>
 <20200127130258.2bknkl3mwpkfyml4@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127130258.2bknkl3mwpkfyml4@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 02:02:59PM +0100, Christian Brauner wrote:
> On Sat, Jan 25, 2020 at 08:16:42AM +1100, Dave Chinner wrote:
> > On Fri, Jan 24, 2020 at 10:22:33AM -0600, Mike Christie wrote:
> > > On 12/05/2019 04:43 PM, Shakeel Butt wrote:
> > > > On Mon, Nov 11, 2019 at 4:19 PM Mike Christie <mchristi@redhat.com> wrote:
> > > >> This patch adds a new prctl command that daemons can use after they have
> > > >> done their initial setup, and before they start to do allocations that
> > > >> are in the IO path. It sets the PF_MEMALLOC_NOIO and PF_LESS_THROTTLE
> > > >> flags so both userspace block and FS threads can use it to avoid the
> > > >> allocation recursion and try to prevent from being throttled while
> > > >> writing out data to free up memory.
> > > >>
> > > >> Signed-off-by: Mike Christie <mchristi@redhat.com>
> > > >> Acked-by: Michal Hocko <mhocko@suse.com>
> > > >> Tested-by: Masato Suzuki <masato.suzuki@wdc.com>
> > > >> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> > > > 
> > > > I suppose this patch should be routed through MM tree, so, CCing Andrew.
> > > >
> > > 
> > > Andrew and other mm/storage developers,
> > > 
> > > Do I need to handle anything else for this patch, or are there any other
> > > concerns? Is this maybe something we want to talk about at a quick LSF
> > > session?
> > > 
> > > I have retested it with Linus's current tree. It still applies cleanly
> > > (just some offsets), and fixes the problem described above we have been
> > > hitting.
> > 
> > I must have missed this version being posted (just looked it up on
> > lore.kernel.org). As far as I'm concerned this is good to go and it
> > is absolutely necessary for userspace IO stacks to function
> > correctly.
> > 
> > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > 
> > If no manintainer picks it up before the next merge window, then I
> 
> Since prctl() is thread-management and fs people seem to be happy and
> have acked it I can pick this up too if noone objects and send this
> along with the rest of process management.

This is upstream now
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d19f1c8e1937baf74e1962aae9f90fa3aeab463

Christian
