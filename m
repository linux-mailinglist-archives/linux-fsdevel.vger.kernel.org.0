Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758862611D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 15:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgIHLh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 07:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbgIHL2A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:28:00 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73D32087D;
        Tue,  8 Sep 2020 11:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599564480;
        bh=6h7BCk1jsce3dtm2DNaKn8AWSjrHEgYvuEIO0UHuooQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=zqDp7ZKMLFrneISccIyxs+xdsE0U2Ijia8uv5is1hK/suKwTPODxLdkTaQCR23Hfy
         04psnv0RGGU709CXHAMT+P9JmUB2EbJLwTYTzNfMBsUO/CaO+p+bPnLctZs+OsQKl+
         /sP7LxmH4efNt8KcFjZ1f8Zh93wYB0VpLPdY5xqI=
Message-ID: <42e2de297552a8642bfe21ab082e490678b5be38.camel@kernel.org>
Subject: Re: [RFC PATCH v2 01/18] vfs: export new_inode_pseudo
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Tue, 08 Sep 2020 07:27:58 -0400
In-Reply-To: <20200908033819.GD68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-2-jlayton@kernel.org>
         <20200908033819.GD68127@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-09-07 at 20:38 -0700, Eric Biggers wrote:
> On Fri, Sep 04, 2020 at 12:05:20PM -0400, Jeff Layton wrote:
> > Ceph needs to be able to allocate inodes ahead of a create that might
> > involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
> > but it puts the inode on the sb->s_inodes list, and we don't want to
> > do that until we're ready to insert it into the hash.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/inode.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 72c4c347afb7..61554c2477ab 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -935,6 +935,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
> >  	}
> >  	return inode;
> >  }
> > +EXPORT_SYMBOL(new_inode_pseudo);
> >  
> 
> What's the problem with putting the new inode on sb->s_inodes already?
> That's what all the other filesystems do.
> 

The existing ones are all local filesystems that use
insert_inode_locked() and similar paths. Ceph needs to use the '5'
variants of those functions (inode_insert5(), iget5_locked(), etc.).

When we go to insert it into the hash in inode_insert5(), we'd need to
set I_CREATING if allocated from new_inode(). But, if you do _that_,
then you'll get back ESTALE from find_inode() if (eg.) someone calls
iget5_locked() before you can clear I_CREATING.

Hitting that race is easy with an asynchronous create. The simplest
scheme to avoid that is to just export new_inode_pseudo and keep it off
of s_inodes until we're ready to do the insert. The only real issue here
is that this inode won't be findable by evict_inodes during umount, but
that shouldn't be happening during an active syscall anyway.
-- 
Jeff Layton <jlayton@kernel.org>

