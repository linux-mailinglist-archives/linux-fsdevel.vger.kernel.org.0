Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD07DE21E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 19:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfJWRf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 13:35:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:46004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730453AbfJWRf1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:35:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E590AD29;
        Wed, 23 Oct 2019 17:35:25 +0000 (UTC)
Date:   Wed, 23 Oct 2019 19:35:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Christie <mchristi@redhat.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        martin@urbackup.org, Damien.LeMoal@wdc.com
Subject: Re: [PATCH] Add prctl support for controlling PF_MEMALLOC V2
Message-ID: <20191023173524.GM17610@dhcp22.suse.cz>
References: <20191021214137.8172-1-mchristi@redhat.com>
 <20191022112446.GA8213@dhcp22.suse.cz>
 <5DAF2AA0.5030500@redhat.com>
 <20191022163310.GS9379@dhcp22.suse.cz>
 <20191022204344.GB2044@dread.disaster.area>
 <20191023071146.GE754@dhcp22.suse.cz>
 <5DB08D81.8050300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DB08D81.8050300@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-10-19 12:27:29, Mike Christie wrote:
> On 10/23/2019 02:11 AM, Michal Hocko wrote:
> > On Wed 23-10-19 07:43:44, Dave Chinner wrote:
> >> On Tue, Oct 22, 2019 at 06:33:10PM +0200, Michal Hocko wrote:
> > 
> > Thanks for more clarifiation regarding PF_LESS_THROTTLE.
> > 
> > [...]
> >>> PF_IO_FLUSHER would mean that the user
> >>> context is a part of the IO path and therefore there are certain reclaim
> >>> recursion restrictions.
> >>
> >> If PF_IO_FLUSHER just maps to PF_LESS_THROTTLE|PF_MEMALLOC_NOIO,
> >> then I'm not sure we need a new definition. Maybe that's the ptrace
> >> flag name, but in the kernel we don't need a PF_IO_FLUSHER process
> >> flag...
> > 
> > Yes, the internal implementation would do something like that. I was
> > more interested in the user space visible API at this stage. Something
> > generic enough because exporting MEMALLOC flags is just a bad idea IMHO
> > (especially PF_MEMALLOC).
> 
> Do you mean we would do something like:
> 
> prctl()
> ....
> case PF_SET_IO_FLUSHER:
>         current->flags |= PF_MEMALLOC_NOIO;
> ....

yes, along with PF_LESS_THROTTLE.

-- 
Michal Hocko
SUSE Labs
