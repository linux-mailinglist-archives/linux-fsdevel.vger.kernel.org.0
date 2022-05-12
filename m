Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7385251A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 17:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356128AbiELPvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356149AbiELPvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 11:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA686163C;
        Thu, 12 May 2022 08:51:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3CD961F2A;
        Thu, 12 May 2022 15:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669F6C385B8;
        Thu, 12 May 2022 15:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652370672;
        bh=SY3HhOlt8o1bUewRQx+K0orgNTHhXBQwjaz2B7myxlY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AZdmZeHCebeN39/ldc1IOfxo2xQHd6qyyIk1XGDid37NhqrAknKVDehjnEd702hC5
         x/QuJLcVE3yoFoG2uiaOml2zItw0R39PkZIoR6meqRdx2Pl0uZoI2evsYrb5EaZ3pG
         5ikGVOjRhJzUh/QJrNo75qtxYVRrzGwSMmCMTWFrDqkwzTMzfycFaLShKlRAxB1ga6
         xxnQAU+S/42QKziJsJB/1++TnbbBzWuNBgU5DWHy549D8pPif3uy4kSXBEkrQA8VXs
         1k/r/VQtKXKtLcfX4cackUDJfyHoXnAttwZjRpeqxYMdesstJ9MRu/QjNRpVBFoCFB
         xoeTaiUowdGrw==
Message-ID: <80a5081af6c284f7bc37fb88b8c26687e3267679.camel@kernel.org>
Subject: Re: [PATCH v2] fs: change test in inode_insert5 for adding to the
 sb list
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        idryomov@gmail.com, xiubli@redhat.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 12 May 2022 11:51:09 -0400
In-Reply-To: <Yn0X6FyrosBlGnMq@rh>
References: <20220511165339.85614-1-jlayton@kernel.org>
         <Yn0X6FyrosBlGnMq@rh>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-05-13 at 00:21 +1000, Dave Chinner wrote:
> On Wed, May 11, 2022 at 12:53:39PM -0400, Jeff Layton wrote:
> > The inode_insert5 currently looks at I_CREATING to decide whether to
> > insert the inode into the sb list. This test is a bit ambiguous though
> > as I_CREATING state is not directly related to that list.
> > 
> > This test is also problematic for some upcoming ceph changes to add
> > fscrypt support. We need to be able to allocate an inode using new_inode
> > and insert it into the hash later if we end up using it, and doing that
> > now means that we double add it and corrupt the list.
> > 
> > What we really want to know in this test is whether the inode is already
> > in its superblock list, and then add it if it isn't. Have it test for
> > list_empty instead and ensure that we always initialize the list by
> > doing it in inode_init_once. It's only ever removed from the list with
> > list_del_init, so that should be sufficient.
> > 
> > There doesn't seem to be any need to hold the inode_hash_lock for this
> > operation either, so drop that before adding to to the list.
> > 
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Dave Chinner <dchinner@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > ---
> >  fs/inode.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > A small revision to the patch that I sent as part of the ceph+fscrypt
> > series. I didn't see any need to hold the inode_hash_lock when adding
> > the inode to the sb list, so do that outside the lock. I also revised
> > the comment to be more clear.
> 
> I'm not sure that's valid. The moment the hash lock is dropped,
> other lookups can find this inode in the cache. Hence there's no
> guarantee that someone else isn't already accessing the inode
> once the hash lock is dropped. Hence it's not clear to me that this
> is a safe modification to make.
> 
> Given that we already do the list add under the hash lock, I don't
> see any real gain to removing it from that context and it isn't
> necessary to address the problem.
> 
> If you are concerned about reducing inode_has_lock contention, then
> the answer to that is to convert the global lock to bit list locks
> as the dentry cache uses. I wrote a patch a while back to do this:
> 
> https://lore.kernel.org/linux-fsdevel/20210406123343.1739669-1-david@fromorbit.com/
> 
> Hence at this stage, I prefer the original version that doesn't
> change locking because there's much less risk associated with it.
> 

I didn't see anything that cares about the i_sb_list while
simultaneously holding the inode_hash_lock. It gets removed from the
list in evict, but we hold a reference to it at this point, so
nothingThe thing also has I_NEW set on it so there had better not be
anyone.

That said, iget_locked also holds it while adding it to the list and
you're correct that it's not required to fix the problem. I'll plan to
revert it to the v1 version. We can always experiment with moving it
outside the lock later if we think that's useful.

Christoph, are you OK with the original version of that patch as well? I
can resend it again if you missed it the first time.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
