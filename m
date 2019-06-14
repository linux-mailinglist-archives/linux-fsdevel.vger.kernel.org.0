Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B0C465D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 19:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfFNRiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 13:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfFNRiR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:38:17 -0400
Received: from vulcan.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BA7D217D6;
        Fri, 14 Jun 2019 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560533896;
        bh=+yP5wi3wnLDRDdHK0vuOYEPDsVjMoYvGf6QmAdcsQ8k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ObPN6ko5DRFwZ9uLj/AJbCS367Rm9N7NOmZppxvRlsZErKeTlKiLtbBBxs2X76z5G
         J579UBbB/JwhWSOhjcVcWVLJNubw6kuGof5RXOflMEj14/PE4KaIMo3KeoHiByOCxr
         aaJmIWTUlk4IXwPJ05ttAkAy/6b3HakOojk/wQfI=
Message-ID: <7cc694cd3acd1873a469062cf76e32423ff9487f.camel@kernel.org>
Subject: Re: [PATCH] ceph: copy_file_range needs to strip setuid bits and
 update timestamps
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
Date:   Fri, 14 Jun 2019 13:38:13 -0400
In-Reply-To: <e9d51b85eef556f5ebe74bd581961953c5d9f2b4.camel@kernel.org>
References: <20190610174007.4818-1-amir73il@gmail.com>
         <ed2e4b5d26890e96ba9dafcb3dba88427e36e619.camel@kernel.org>
         <87zhml7ada.fsf@suse.com>
         <38f6f71f6be0b5baaea75417aa4bcf072e625567.camel@kernel.org>
         <87v9x87dmi.fsf@suse.com>
         <e9d51b85eef556f5ebe74bd581961953c5d9f2b4.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-06-14 at 07:43 -0400, Jeff Layton wrote:
> On Fri, 2019-06-14 at 09:52 +0100, Luis Henriques wrote:
> > So, do you think the patch below would be enough?  It's totally
> > untested, but I wanted to know if that would be acceptable before
> > running some tests on it.
> > 
> > Cheers,
> > --
> > Luis
> > 
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index c5517ffeb11c..f6b0683dd8dc 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -1949,6 +1949,21 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> >                 goto out;
> >         }
> >  
> > +       ret = ceph_do_getattr(dst_inode, CEPH_CAP_AUTH_SHARED, false);
> > +       if (ret < 0) {
> > +               dout("failed to get auth caps on dst file (%zd)\n", ret);
> > +               goto out;
> > +       }
> > +
> 
> I think this is still racy. You could lose As caps before file_modified
> is called. IMO, this code should hold a reference to As caps until the
> c_f_r operation is complete.
> 
> That may get tricky however if you do need to issue a setattr to change
> the mode, as the MDS may try to recall As caps at that point. You won't
> be able to release them until you drop the reference, so will that
> deadlock? I'm not sure.
> 

That said...in many (most?) cases the client will already have As caps
on the file from the permission check during open, and mode changes
(and AUTH cap revokes) are relatively rare. So, the race I'm talking
about probably almost never happens in practice.

But...privilege escalation attacks often involve setuid changes, so I
think we really ought to be careful here.

In any case, if holding a reference to As is not feasible, then I we
could take the original version of the patch, and maybe pair it with
the getattr above. It's not ideal, but it's better than nothing.


> > +       /* Should dst_inode lock be held throughout the copy operation? */
> > +       inode_lock(dst_inode);
> > +       ret = file_modified(dst_file);
> > +       inode_unlock(dst_inode);
> > +       if (ret < 0) {
> > +               dout("failed to modify dst file before copy (%zd)\n", ret);
> > +               goto out;
> > +       }
> > +
> >         /*
> >          * We need FILE_WR caps for dst_ci and FILE_RD for src_ci as other
> >          * clients may have dirty data in their caches.  And OSDs know nothing

