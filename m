Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70199341D61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 13:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhCSMvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 08:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhCSMvI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:51:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3733F64E5B;
        Fri, 19 Mar 2021 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616158267;
        bh=sQHLIKwbaMF7hOUffsEhCxkiAwFT5EoYOc7T+xubrG8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YQPAT/tSGvMP9LbxauzWp+0XaGCpFeijdyXYmcVxEWcF3diz0OCVEPUzC+w1I0Mgj
         LLktMXByokAYobbTPVWzEKdqkJKXXW2Bug9aqUuXATLAOpxYMpGqii+ftcMeuVMyhp
         TqcujXFBHSlGfcEyRyy8Rrpy7cSjbAqAZ/LJ7t1i7x7fJjH7toPGxg46fsaq52tE+X
         SanVouI/kIa+la4prh03KBoQRABuBBvhj/5cVC3OrBMApU50IMbKM76xZlOtgR6IVx
         +p+Y8FjI/pBneGf6/ooYzcl5sgxQWxh+npMyZLUHcDKJw2dMGauyUnE2wqFi6C3JRw
         pNDBm2WFdbn3A==
Message-ID: <9d87dd0e8b0597caf71863b9321e312e320178e1.camel@kernel.org>
Subject: Re: [PATCH 1/2] ceph: don't clobber i_snap_caps on non-I_NEW inode
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org,
        idryomov@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Date:   Fri, 19 Mar 2021 08:51:06 -0400
In-Reply-To: <e70eb841-5669-83e0-4c61-ec8153cc5a9b@redhat.com>
References: <20210315180717.266155-1-jlayton@kernel.org>
         <20210315180717.266155-2-jlayton@kernel.org>
         <e70eb841-5669-83e0-4c61-ec8153cc5a9b@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-03-19 at 13:03 +0800, Xiubo Li wrote:
> On 2021/3/16 2:07, Jeff Layton wrote:
> > We want the snapdir to mirror the non-snapped directory's attributes for
> > most things, but i_snap_caps represents the caps granted on the snapshot
> > directory by the MDS itself. A misbehaving MDS could issue different
> > caps for the snapdir and we lose them here.
> > 
> > Only reset i_snap_caps when the inode is I_NEW.
> > 
> > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/ceph/inode.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index 26dc7a296f6b..fc7f4bf63306 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -101,12 +101,13 @@ struct inode *ceph_get_snapdir(struct inode *parent)
> >   	inode->i_atime = parent->i_atime;
> >   	inode->i_op = &ceph_snapdir_iops;
> >   	inode->i_fop = &ceph_snapdir_fops;
> > -	ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
> > -	ci->i_rbytes = 0;
> >   	ci->i_btime = ceph_inode(parent)->i_btime;
> > +	ci->i_rbytes = 0;
> >   
> > 
> > 
> > 
> 
> Hi Jeff,
> 
> BTW, why we need to set other members here if the i_state is not I_NEW ?
> 
> Are they necessary ?
> 

I think so, at least for most of them.

IIUC, we want the .snap directory's metadata to mirror that of the
parent directory, so we want stuff like the ownership and mtime to track
changes in the parent.

I can move the setting of i_op and i_fop into the if block though. Those
should never change anyway, though setting them is harmless here since
we're checking to make sure the type is correct above.

I'll go ahead and do that, but I won't bother re-posting the v2 patch
since it's a trivial change.

> > -	if (inode->i_state & I_NEW)
> > +	if (inode->i_state & I_NEW) {
> > +		ci->i_snap_caps = CEPH_CAP_PIN; /* so we can open */
> >   		unlock_new_inode(inode);
> > +	}
> >   
> > 
> > 
> > 
> >   	return inode;
> >   }
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>

