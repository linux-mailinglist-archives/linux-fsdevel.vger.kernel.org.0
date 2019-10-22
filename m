Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE57E0967
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfJVQnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 12:43:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731373AbfJVQnv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:43:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F66FB80B;
        Tue, 22 Oct 2019 16:33:12 +0000 (UTC)
Date:   Tue, 22 Oct 2019 18:33:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Christie <mchristi@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, martin@urbackup.org,
        Damien.LeMoal@wdc.com
Subject: Re: [PATCH] Add prctl support for controlling PF_MEMALLOC V2
Message-ID: <20191022163310.GS9379@dhcp22.suse.cz>
References: <20191021214137.8172-1-mchristi@redhat.com>
 <20191022112446.GA8213@dhcp22.suse.cz>
 <5DAF2AA0.5030500@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DAF2AA0.5030500@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 22-10-19 11:13:20, Mike Christie wrote:
> On 10/22/2019 06:24 AM, Michal Hocko wrote:
> > On Mon 21-10-19 16:41:37, Mike Christie wrote:
> >> There are several storage drivers like dm-multipath, iscsi, tcmu-runner,
> >> amd nbd that have userspace components that can run in the IO path. For
> >> example, iscsi and nbd's userspace deamons may need to recreate a socket
> >> and/or send IO on it, and dm-multipath's daemon multipathd may need to
> >> send IO to figure out the state of paths and re-set them up.
> >>
> >> In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
> >> memalloc_*_save/restore functions to control the allocation behavior,
> >> but for userspace we would end up hitting a allocation that ended up
> >> writing data back to the same device we are trying to allocate for.
> > 
> > Which code paths are we talking about here? Any ioctl or is this a
> > general syscall path? Can we mark the process in a more generic way?
> 
> It depends on the daemon. The common one for example are iscsi and nbd
> need network related calls like sendmsg, recvmsg, socket, etc.
> tcmu-runner could need the network ones and also read and write when it
> does IO to a FS or device. dm-multipath needs the sg io ioctls.

OK, so there is not a clear kernel entry point that could be explicitly
annotated. This would imply a per task context. This is an important
information. And I am wondering how those usecases ever worked in the
first place. This is not a minor detail.
 
> > E.g. we have PF_LESS_THROTTLE (used by nfsd). It doesn't affect the
> > reclaim recursion but it shows a pattern that doesn't really exhibit
> > too many internals. Maybe we need PF_IO_FLUSHER or similar?
> 
> I am not familiar with PF_IO_FLUSHER. If it prevents the recursion
> problem then please send me details and I will look into it for the next
> posting.

PF_IO_FLUSHER doesn't exist. I just wanted to point out that similarly
to PF_LESS_THROTTLE it should be a more high level per task flag rather
than something as low level as a direct control of gfp allocation
context. PF_LESS_THROTTLE simply tells that the task is a part of the
reclaim process and therefore it shouldn't be a subject of a normal
throttling - whatever that means. PF_IO_FLUSHER would mean that the user
context is a part of the IO path and therefore there are certain reclaim
recursion restrictions.
 
> >> This patch allows the userspace deamon to set the PF_MEMALLOC* flags
> >> with prctl during their initialization so later allocations cannot
> >> calling back into them.
> > 
> > TBH I am not really happy to export these to the userspace. They are
> > an internal implementation detail and the userspace shouldn't really
> 
> They care in these cases, because block/fs drivers must be able to make
> forward progress during writes. To meet this guarantee kernel block
> drivers use mempools and memalloc/GFP flags.
> 
> For these userspace components of the block/fs drivers they already do
> things normal daemons do not to meet that guarantee like mlock their
> memory, disable oom killer, and preallocate resources they have control
> over. They have no control over reclaim like the kernel drivers do so
> its easy for us to deadlock when memory gets low.

OK, fair enough. How much of a control do they really need though. Is a
single PF_IO_FLUSHER as explained above (essentially imply GPF_NOIO
context) sufficient?
-- 
Michal Hocko
SUSE Labs
