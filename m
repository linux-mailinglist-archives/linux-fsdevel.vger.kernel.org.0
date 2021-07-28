Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A5C3D8EC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhG1NQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 09:16:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45674 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1NQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:16:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 182DB201A2;
        Wed, 28 Jul 2021 13:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627478167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1z3R9jRABBLTOL9uK9qEcaMzZB5VnqeimAFu5k0n4J0=;
        b=wwiFbaCa3v7VFowN7jAzHI4iZ6M44t5GfH8fISM84l40MekXMsLU4CumT9RqK2hqunspwD
        APCBLGvB2egO+6tbUamgagBLbZNe8q5GH2X8iZ3gk1BccR3cN+CEoTTWkE4jBaC5wllG4u
        DM5Ub9xblItkgKGxoGKamJubuOZpnmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627478167;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1z3R9jRABBLTOL9uK9qEcaMzZB5VnqeimAFu5k0n4J0=;
        b=/XdGfB/jAOhNzB/TPAOoIA5qIeUQREmy7BEL7zYB2YmSsVUj9g/Zb9LgjnuB51c2zL8RTw
        U+X21+deGfOzUxCQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 07105A3B87;
        Wed, 28 Jul 2021 13:16:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D55BC1E1321; Wed, 28 Jul 2021 15:16:06 +0200 (CEST)
Date:   Wed, 28 Jul 2021 15:16:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Cluster-devel] [GFS2 PATCH 10/10] gfs2: replace sd_aspace with
 sd_inode
Message-ID: <20210728131606.GF29619@quack2.suse.cz>
References: <20210713180958.66995-1-rpeterso@redhat.com>
 <20210713180958.66995-11-rpeterso@redhat.com>
 <34e7b795c97d781b8788d965dd7caf48d8b8ec24.camel@redhat.com>
 <76779e30-76b3-b867-7d1c-46a96b56a741@redhat.com>
 <CAHc6FU6NNG3M8ewuehy50G4PVJ7v_aWgoUpZfNitJSzU1ajzdA@mail.gmail.com>
 <d2f338843211059e4f35996c4771fdbfa80aab65.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2f338843211059e4f35996c4771fdbfa80aab65.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-07-21 09:57:01, Steven Whitehouse wrote:
> On Wed, 2021-07-28 at 08:50 +0200, Andreas Gruenbacher wrote:
> > On Tue, Jul 13, 2021 at 9:34 PM Bob Peterson <rpeterso@redhat.com>
> > wrote:
> > > On 7/13/21 1:26 PM, Steven Whitehouse wrote:
> > > 
> > > Hi,
> > > 
> > > On Tue, 2021-07-13 at 13:09 -0500, Bob Peterson wrote:
> > > 
> > > Before this patch, gfs2 kept its own address space for rgrps, but
> > > this
> > > caused a lockdep problem because vfs assumes a 1:1 relationship
> > > between
> > > address spaces and their inode. One problematic area is this:
> > > 
> > > I don't think that is the case. The reason that the address space
> > > is a
> > > separate structure in the first place is to allow them to exist
> > > without
> > > an inode. Maybe that has changed, but we should see why that is, in
> > > that case rather than just making this change immediately.
> > > 
> > > I can't see any reason why if we have to have an inode here that it
> > > needs to be hashed... what would need to look it up via the hashes?
> > > 
> > > Steve.
> > > 
> > > Hi,
> > > 
> > > The actual use case, which is easily demonstrated with lockdep, is
> > > given
> > > in the patch text shortly after where you placed your comment. This
> > > goes
> > > back to this discussion from April 2018:
> > > 
> > > https://listman.redhat.com/archives/cluster-devel/2018-April/msg00017.html
> > > 
> > > in which Jan Kara pointed out that:
> > > 
> > > "The problem is we really do expect mapping->host->i_mapping ==
> > > mapping as
> > > we pass mapping and inode interchangeably in the mm code. The
> > > address_space
> > > and inodes are separate structures because you can have many inodes
> > > pointing to one address space (block devices). However it is not
> > > allowed
> > > for several address_spaces to point to one inode!"
> > 
> > This is fundamentally at adds with how we manage inodes: we have
> > inode->i_mapping which is the logical address space of the inode, and
> > we have gfs2_glock2aspace(GFS2_I(inode)->i_gl) which is the metadata
> > address space of the inode. The most important function of the
> > metadata address space is to remove the inode's metadata from memory
> > by truncating the metadata address space (inode_go_inval). We need
> > that when moving an inode to another node. I don't have the faintest
> > idea how we could otherwise achieve that in a somewhat efficient way.
> > 
> > Thanks,
> > Andreas
> > 
> 
> In addition, I'm fairly sure also that we were told to use this
> solution (i.e. a separate address space) back in the day because it was
> expected that they didn't have a 1:1 relationship with inodes. I don't
> think we'd have used that solution otherwise. I've not had enough time
> to go digging back in my email to check, but it might be worth looking
> to see when we introduced the use of the second address space (removing
> a whole additional inode structure) and any discussions around that
> change,

AFAIK in last 20 years it has never been the case that multiple
address_space structs for an inode would be handled by the VFS/MM code
properly. There can be multiple 'struct inode' for one 'struct
address_space'. That is handled just fine and is being used. The trouble is
that once you allow multiple address_space structs pointing to one struct
inode, you have some hard questions to answer (at least for VFS) - e.g. you
get a request to writeback the inode, how you do that when you have
multiple address spaces? Writeback them all? And how do you iterate them?

And there are similar questions regarding how to determine inode's
dirtiness or whether some inode's page is under writeback. Tied to that are
locking questions where inode->i_mapping->i_pages->xa_lock lock is used to
protect some of the inode state transitions. But when you have multiple
address spaces pointing to the inode it is not clear which of these many
locks would be protecting it (and the warning syzbot is hitting exactly
says that these state transitions are not properly serialized).

Of course all this can be decided and implemented but it is not a trivial
task there needs to be good motivation for the added complexity in the code
used by everybody. And AFAIU GFS2 even doesn't strictly need it. It uses a
very limited subset of functions that can operate on address_space for
these special address spaces. Andreas mentions you use metadata
address_space for tracking and evicting cached metadata associated with the
inode. Quickly checking the code, another heavy use seems to be metadata
dirtiness tracking and writeback. I'd note that other filesystems
traditionally use mapping->private_list for exactly these purposes (through
helpers like mark_buffer_dirty_inode, sync_mapping_buffers, etc.). Any
reason why you don't use these?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
