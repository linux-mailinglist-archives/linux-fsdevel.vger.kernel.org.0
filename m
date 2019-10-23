Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0048E12E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 09:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389765AbfJWHLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 03:11:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:51096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389090AbfJWHLu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:11:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C515B3F8;
        Wed, 23 Oct 2019 07:11:48 +0000 (UTC)
Date:   Wed, 23 Oct 2019 09:11:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mike Christie <mchristi@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        martin@urbackup.org, Damien.LeMoal@wdc.com
Subject: Re: [PATCH] Add prctl support for controlling PF_MEMALLOC V2
Message-ID: <20191023071146.GE754@dhcp22.suse.cz>
References: <20191021214137.8172-1-mchristi@redhat.com>
 <20191022112446.GA8213@dhcp22.suse.cz>
 <5DAF2AA0.5030500@redhat.com>
 <20191022163310.GS9379@dhcp22.suse.cz>
 <20191022204344.GB2044@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022204344.GB2044@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-10-19 07:43:44, Dave Chinner wrote:
> On Tue, Oct 22, 2019 at 06:33:10PM +0200, Michal Hocko wrote:

Thanks for more clarifiation regarding PF_LESS_THROTTLE.

[...]
> > PF_IO_FLUSHER would mean that the user
> > context is a part of the IO path and therefore there are certain reclaim
> > recursion restrictions.
> 
> If PF_IO_FLUSHER just maps to PF_LESS_THROTTLE|PF_MEMALLOC_NOIO,
> then I'm not sure we need a new definition. Maybe that's the ptrace
> flag name, but in the kernel we don't need a PF_IO_FLUSHER process
> flag...

Yes, the internal implementation would do something like that. I was
more interested in the user space visible API at this stage. Something
generic enough because exporting MEMALLOC flags is just a bad idea IMHO
(especially PF_MEMALLOC).

> > > >> This patch allows the userspace deamon to set the PF_MEMALLOC* flags
> > > >> with prctl during their initialization so later allocations cannot
> > > >> calling back into them.
> > > > 
> > > > TBH I am not really happy to export these to the userspace. They are
> > > > an internal implementation detail and the userspace shouldn't really
> > > 
> > > They care in these cases, because block/fs drivers must be able to make
> > > forward progress during writes. To meet this guarantee kernel block
> > > drivers use mempools and memalloc/GFP flags.
> > > 
> > > For these userspace components of the block/fs drivers they already do
> > > things normal daemons do not to meet that guarantee like mlock their
> > > memory, disable oom killer, and preallocate resources they have control
> > > over. They have no control over reclaim like the kernel drivers do so
> > > its easy for us to deadlock when memory gets low.
> > 
> > OK, fair enough. How much of a control do they really need though. Is a
> > single PF_IO_FLUSHER as explained above (essentially imply GPF_NOIO
> > context) sufficient?
> 
> I think some of these usrspace processes work at the filesystem
> level and so really only need GFP_NOFS allocation (fuse), while
> others work at the block device level (iscsi, nbd) so need GFP_NOIO
> allocation. So there's definitely an argument for providing both...

The main question is whether giving more APIs is really necessary. Is
there any real problem to give them only PF_IO_FLUSHER and let both
groups use this one? It will imply more reclaim restrictions for solely
FS based ones but is this a practical problem? If yes we can always add
PF_FS_$FOO later on.
-- 
Michal Hocko
SUSE Labs
