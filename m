Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C96794065
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 17:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242614AbjIFP3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 11:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjIFP3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:29:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543A4E6B;
        Wed,  6 Sep 2023 08:29:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1902C433C7;
        Wed,  6 Sep 2023 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694014188;
        bh=yPIKHivU99a/V2wrPQLBZTJtxUZbBoyAdSHgdSVbW5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VWnCa6V4PW3i8j4jYKKXLou8KIeCEyyj37WwmoRm2etNW4Sl2leRgfxTkMNcvnnsX
         WKqLHbKQFYIbH21hf1v+ym2fXg5XuykVT3NBoRc44WacLOYSNHvCypOW8alwNnRU3X
         3DiRmILjoMHNuUTpPg4Uq3oq7ND2XffCjtJMqb18B6A2E4PjtOUhKam/yRs3dkWUvL
         J7xeKkfRqQY7/t/9zHn8v3/dKQThSFXDpQti37LMzLqtT2EsDsYD4fDtUngVuEK/oO
         vRvyqACEsWfnzJLdxJeAgGANPwuDWIwGOffKEBSIbsRgQozFsj+kEB4KiYHVXMM+cc
         PsGX9drpA0b3w==
Date:   Wed, 6 Sep 2023 08:29:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add inode lockdep assertions
Message-ID: <20230906152948.GE28160@frogsfrogsfrogs>
References: <20230831151414.2714750-1-mjguzik@gmail.com>
 <ZPiYp+t6JTUscc81@casper.infradead.org>
 <b0434328-01f9-dc5c-fe25-4a249130a81d@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0434328-01f9-dc5c-fe25-4a249130a81d@fastmail.fm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:23:42PM +0200, Bernd Schubert wrote:
> 
> 
> On 9/6/23 17:20, Matthew Wilcox wrote:
> > On Thu, Aug 31, 2023 at 05:14:14PM +0200, Mateusz Guzik wrote:
> > > +++ b/include/linux/fs.h
> > > @@ -842,6 +842,16 @@ static inline void inode_lock_shared_nested(struct inode *inode, unsigned subcla
> > >   	down_read_nested(&inode->i_rwsem, subclass);
> > >   }
> > > +static inline void inode_assert_locked(struct inode *inode)
> > > +{
> > > +	lockdep_assert_held(&inode->i_rwsem);
> > > +}
> > > +
> > > +static inline void inode_assert_write_locked(struct inode *inode)
> > > +{
> > > +	lockdep_assert_held_write(&inode->i_rwsem);
> > > +}
> > 
> > This mirrors what we have in mm, but it's only going to trigger on
> > builds that have lockdep enabled.  Lockdep is very expensive; it
> > easily doubles the time it takes to run xfstests on my laptop, so
> > I don't generally enable it.  So what we also have in MM is:
> > 
> > static inline void mmap_assert_write_locked(struct mm_struct *mm)
> > {
> >          lockdep_assert_held_write(&mm->mmap_lock);
> >          VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> > }
> > 
> > Now if you have lockdep enabled, you get the lockdep check which
> > gives you all the lovely lockdep information, but if you don't, you
> > at least get the cheap check that someone is holding the lock at all.
> > 
> > ie I would make this:
> > 
> > +static inline void inode_assert_write_locked(struct inode *inode)
> > +{
> > +	lockdep_assert_held_write(&inode->i_rwsem);
> > +	WARN_ON_ONCE(!inode_is_locked(inode));
> > +}
> > 
> > Maybe the locking people could give us a rwsem_is_write_locked()
> > predicate, but until then, this is the best solution we came up with.
> 
> 
> Which is exactly what I had suggested in the other thread :)

Or hoist the XFS mrlock, because it actually /does/ know if the rwsem is
held in shared or exclusive mode.

--D
