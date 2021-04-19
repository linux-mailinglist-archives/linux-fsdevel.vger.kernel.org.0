Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85839363D83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 10:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbhDSIei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 04:34:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:41598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhDSIeh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:34:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 467E9AF1A;
        Mon, 19 Apr 2021 08:34:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D92A51F2C6A; Mon, 19 Apr 2021 10:34:06 +0200 (CEST)
Date:   Mon, 19 Apr 2021 10:34:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] shmem: allow reporting fanotify events with file
 handles on tmpfs
Message-ID: <20210419083406.GA8706@quack2.suse.cz>
References: <20210322173944.449469-1-amir73il@gmail.com>
 <20210322173944.449469-3-amir73il@gmail.com>
 <20210325150025.GF13673@quack2.suse.cz>
 <CAOQ4uxia0ETkPF7Af3YiYGb2QzD03UNEpvU2jyibf_+tajhe1A@mail.gmail.com>
 <alpine.LSU.2.11.2104162042130.26690@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104162042130.26690@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 16-04-21 20:54:46, Hugh Dickins wrote:
> On Fri, 16 Apr 2021, Amir Goldstein wrote:
> > On Thu, Mar 25, 2021 at 5:00 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 22-03-21 19:39:44, Amir Goldstein wrote:
> > > > Since kernel v5.1, fanotify_init(2) supports the flag FAN_REPORT_FID
> > > > for identifying objects using file handle and fsid in events.
> > > >
> > > > fanotify_mark(2) fails with -ENODEV when trying to set a mark on
> > > > filesystems that report null f_fsid in stasfs(2).
> > > >
> > > > Use the digest of uuid as f_fsid for tmpfs to uniquely identify tmpfs
> > > > objects as best as possible and allow setting an fanotify mark that
> > > > reports events with file handles on tmpfs.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Hugh, any opinion on this patch?
> > >
> > >                                                                 Honza
> > >
> > > > ---
> > > >  mm/shmem.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > index b2db4ed0fbc7..162d8f8993bb 100644
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -2846,6 +2846,9 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
> > > >               buf->f_ffree = sbinfo->free_inodes;
> > > >       }
> > > >       /* else leave those fields 0 like simple_statfs */
> > > > +
> > > > +     buf->f_fsid = uuid_to_fsid(dentry->d_sb->s_uuid.b);
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > 
> > 
> > Ping.
> > 
> > Hugh, are you ok with this change?
> > 
> > Thanks,
> > Amir.
> 
> Yes, apologies for my delay to you, Amir and Jan:
> sure I'm ok with this change, and thank you for taking care of tmpfs.
> 
> Acked-by: Hugh Dickins <hughd@google.com>

Thanks for the ack Hugh!

> But you have more valuable acks on this little series already,
> so don't bother rebasing some tree to add mine in now.  I don't yet
> see the uuid_to_fsid() 1/2 which this depends on in linux-next, and
> fear that's my fault for holding you back: sorry, please go ahead now.

Yeah, I was reluctant to push this patch without your ack and honestly I
forgot about the first patch while waiting for your ack. Anyway, both
patches are now in my tree and since Linus tagged rc8 and they are
nobrainers, I plan to push them to Linus for the next merge window.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
