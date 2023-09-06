Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA7F79433F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242082AbjIFSnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 14:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjIFSnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:43:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858B88E;
        Wed,  6 Sep 2023 11:43:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF48AC433C8;
        Wed,  6 Sep 2023 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694025817;
        bh=4LpTj4dO1DZp+wPt1j326b9RHl688VNjoFRDBK7yCjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMYo4nD1ZhlGaViMjhHsNMan5ePfVetvQknQBxgotWKktnC6a6kvmyycmIb1nX0nt
         1HTNSqKl2CAWzyv6tMz/5xA2IuIphy9Rs4r1jICSpcMmkJrqpLlVjS/j22/39fIvjE
         A8jx840OcGXTtxvPAKq5H5X6V01XRgO71UX6vMi6YimjX0Hn6+ZeSONiir3/cIyCZx
         fJgZQ201+Kz22p188mf+ZUuZOraS8DC3ZgnX7dgc0eQ/gzy308Hv9AwuuzPgMPou2X
         GhCttd85s4lUbsuP05wouMWyhd2PJAasHNi2jmVapCwDxBJzAPcu7QDH9r6K2QeYQW
         NgLGEXg6M5nrg==
Date:   Wed, 6 Sep 2023 11:43:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add inode lockdep assertions
Message-ID: <20230906184336.GH28160@frogsfrogsfrogs>
References: <20230831151414.2714750-1-mjguzik@gmail.com>
 <ZPiYp+t6JTUscc81@casper.infradead.org>
 <b0434328-01f9-dc5c-fe25-4a249130a81d@fastmail.fm>
 <20230906152948.GE28160@frogsfrogsfrogs>
 <ZPiiDj1T3lGp2w2c@casper.infradead.org>
 <20230906170724.GI28202@frogsfrogsfrogs>
 <ZPjGDGyDf2/ngML9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPjGDGyDf2/ngML9@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 07:33:48PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 06, 2023 at 10:07:24AM -0700, Darrick J. Wong wrote:
> > On Wed, Sep 06, 2023 at 05:00:14PM +0100, Matthew Wilcox wrote:
> > > +++ b/fs/xfs/xfs_inode.c
> > > @@ -361,7 +361,7 @@ xfs_isilocked(
> > >  {
> > >  	if (lock_flags & (XFS_ILOCK_EXCL|XFS_ILOCK_SHARED)) {
> > >  		if (!(lock_flags & XFS_ILOCK_SHARED))
> > > -			return !!ip->i_lock.mr_writer;
> > > +			return rwsem_is_write_locked(&ip->i_lock.mr_lock);
> > 
> > You'd be better off converting this to:
> > 
> > 	return __xfs_rwsem_islocked(&ip->i_lock.mr_lock,
> > 				(lock_flags & XFS_ILOCK_SHARED));
> > 
> > And then fixing __xfs_rwsem_islocked to do:
> > 
> > static inline bool
> > __xfs_rwsem_islocked(
> > 	struct rw_semaphore	*rwsem,
> > 	bool			shared)
> > {
> > 	if (!debug_locks) {
> > 		if (!shared)
> > 			return rwsem_is_write_locked(rwsem);
> > 		return rwsem_is_locked(rwsem);
> > 	}
> > 
> > 	...
> > }
> 
> Thanks.
> 
> > > +++ b/include/linux/rwsem.h
> > > @@ -72,6 +72,11 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
> > >  	return atomic_long_read(&sem->count) != 0;
> > >  }
> > >  
> > > +static inline int rwsem_is_write_locked(struct rw_semaphore *sem)
> > > +{
> > > +	return atomic_long_read(&sem->count) & 1;
> > 
> > 
> > atomic_long_read(&sem->count) & RWSEM_WRITER_LOCKED ?
> 
> Then this would either have to be in rwsem.c or we'd have to move the
> definition of RWSEM_WRITER_LOCKED to rwsem.h.  All three options are
> kind of bad.  I think I hate the bare '1' least.

I disagree, because using the bare 1 brings the most risk that someone
will subtly break the locking assertions some day when they get the
bright idea to move RWSEM_WRITER_LOCKED to the upper bit and fail to
notice this predicate and its magic number.  IMO moving it to the header
file (possibly with the usual __ prefix) would be preferable to leaving
a landmine.

--D
