Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B6914A465
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgA0NDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 08:03:06 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53846 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgA0NDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 08:03:05 -0500
Received: from ip5f5bd665.dynamic.kabel-deutschland.de ([95.91.214.101] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iw42e-0001Yk-8w; Mon, 27 Jan 2020 13:03:00 +0000
Date:   Mon, 27 Jan 2020 14:02:59 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, idryomov@gmail.com,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, martin@urbackup.org,
        Damien.LeMoal@wdc.com, Michal Hocko <mhocko@suse.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
Subject: Re: [PATCH] Add prctl support for controlling mem reclaim V4
Message-ID: <20200127130258.2bknkl3mwpkfyml4@wittgenstein>
References: <20191112001900.9206-1-mchristi@redhat.com>
 <CALvZod47XyD2x8TuZcb9PgeVY14JBwNhsUpN3RAeAt+RJJC=hg@mail.gmail.com>
 <5E2B19C9.6080907@redhat.com>
 <20200124211642.GB7216@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200124211642.GB7216@dread.disaster.area>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 25, 2020 at 08:16:42AM +1100, Dave Chinner wrote:
> On Fri, Jan 24, 2020 at 10:22:33AM -0600, Mike Christie wrote:
> > On 12/05/2019 04:43 PM, Shakeel Butt wrote:
> > > On Mon, Nov 11, 2019 at 4:19 PM Mike Christie <mchristi@redhat.com> wrote:
> > >> This patch adds a new prctl command that daemons can use after they have
> > >> done their initial setup, and before they start to do allocations that
> > >> are in the IO path. It sets the PF_MEMALLOC_NOIO and PF_LESS_THROTTLE
> > >> flags so both userspace block and FS threads can use it to avoid the
> > >> allocation recursion and try to prevent from being throttled while
> > >> writing out data to free up memory.
> > >>
> > >> Signed-off-by: Mike Christie <mchristi@redhat.com>
> > >> Acked-by: Michal Hocko <mhocko@suse.com>
> > >> Tested-by: Masato Suzuki <masato.suzuki@wdc.com>
> > >> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> > > 
> > > I suppose this patch should be routed through MM tree, so, CCing Andrew.
> > >
> > 
> > Andrew and other mm/storage developers,
> > 
> > Do I need to handle anything else for this patch, or are there any other
> > concerns? Is this maybe something we want to talk about at a quick LSF
> > session?
> > 
> > I have retested it with Linus's current tree. It still applies cleanly
> > (just some offsets), and fixes the problem described above we have been
> > hitting.
> 
> I must have missed this version being posted (just looked it up on
> lore.kernel.org). As far as I'm concerned this is good to go and it
> is absolutely necessary for userspace IO stacks to function
> correctly.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> 
> If no manintainer picks it up before the next merge window, then I

Since prctl() is thread-management and fs people seem to be happy and
have acked it I can pick this up too if noone objects and send this
along with the rest of process management.

Christian
