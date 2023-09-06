Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93927943BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 21:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbjIFTT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 15:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244221AbjIFTTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:19:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250D61BDC;
        Wed,  6 Sep 2023 12:19:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00D7C433C7;
        Wed,  6 Sep 2023 19:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694027951;
        bh=fDiQ1DFoxubnMjhSHE4t+Y28KnhW4AGvaGOqfQ+YewY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCs2csUwRXVlc+RT23GNCY8Mk7/cvHz/ZMCJ+CWctYefv6TC0Vw3p53LF/+lI1fwy
         cr/SUEwI3DEt6diAtE6GGZX5w8mrvJg/oqcF1DbdZC3w+IlRbez7PwUuUgB6C6lmcf
         AmlitduG2UOOeip1gmUymKo+KVjRDNubn7VEsUNNG7DEco3r+dbjfcQojEbBaH2vNc
         oQLaSZEXBL58VDC7NrDerrJpSrRkXVDX4flOPRANASDbVd6uQ292Z7lzALVorHmiKs
         KL0dTvxD1QxogPW6Y6KlwSxizwSACIXd92fnqcwpaO8dXdrnoxgddgNMKtaKIytHAD
         oAvvs4KnLwpvQ==
Date:   Wed, 6 Sep 2023 12:19:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add inode lockdep assertions
Message-ID: <20230906191911.GJ28202@frogsfrogsfrogs>
References: <20230831151414.2714750-1-mjguzik@gmail.com>
 <ZPiYp+t6JTUscc81@casper.infradead.org>
 <b0434328-01f9-dc5c-fe25-4a249130a81d@fastmail.fm>
 <20230906152948.GE28160@frogsfrogsfrogs>
 <ZPiiDj1T3lGp2w2c@casper.infradead.org>
 <20230906170724.GI28202@frogsfrogsfrogs>
 <ZPjGDGyDf2/ngML9@casper.infradead.org>
 <20230906184336.GH28160@frogsfrogsfrogs>
 <ZPjMpIKh+xxLbEZI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPjMpIKh+xxLbEZI@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 08:01:56PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 06, 2023 at 11:43:36AM -0700, Darrick J. Wong wrote:
> > On Wed, Sep 06, 2023 at 07:33:48PM +0100, Matthew Wilcox wrote:
> > > On Wed, Sep 06, 2023 at 10:07:24AM -0700, Darrick J. Wong wrote:
> > > > On Wed, Sep 06, 2023 at 05:00:14PM +0100, Matthew Wilcox wrote:
> > > > > +++ b/fs/xfs/xfs_inode.c
> > > > > @@ -361,7 +361,7 @@ xfs_isilocked(
> > > > >  {
> > > > >  	if (lock_flags & (XFS_ILOCK_EXCL|XFS_ILOCK_SHARED)) {
> > > > >  		if (!(lock_flags & XFS_ILOCK_SHARED))
> > > > > -			return !!ip->i_lock.mr_writer;
> > > > > +			return rwsem_is_write_locked(&ip->i_lock.mr_lock);
> > > > 
> > > > You'd be better off converting this to:
> > > > 
> > > > 	return __xfs_rwsem_islocked(&ip->i_lock.mr_lock,
> > > > 				(lock_flags & XFS_ILOCK_SHARED));
> > > > 
> > > > And then fixing __xfs_rwsem_islocked to do:
> > > > 
> > > > static inline bool
> > > > __xfs_rwsem_islocked(
> > > > 	struct rw_semaphore	*rwsem,
> > > > 	bool			shared)
> > > > {
> > > > 	if (!debug_locks) {
> > > > 		if (!shared)
> > > > 			return rwsem_is_write_locked(rwsem);
> > > > 		return rwsem_is_locked(rwsem);
> > > > 	}
> > > > 
> > > > 	...
> > > > }
> > > 
> > > Thanks.
> > > 
> > > > > +++ b/include/linux/rwsem.h
> > > > > @@ -72,6 +72,11 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
> > > > >  	return atomic_long_read(&sem->count) != 0;
> > > > >  }
> > > > >  
> > > > > +static inline int rwsem_is_write_locked(struct rw_semaphore *sem)
> > > > > +{
> > > > > +	return atomic_long_read(&sem->count) & 1;
> > > > 
> > > > 
> > > > atomic_long_read(&sem->count) & RWSEM_WRITER_LOCKED ?
> > > 
> > > Then this would either have to be in rwsem.c or we'd have to move the
> > > definition of RWSEM_WRITER_LOCKED to rwsem.h.  All three options are
> > > kind of bad.  I think I hate the bare '1' least.
> > 
> > I disagree, because using the bare 1 brings the most risk that someone
> > will subtly break the locking assertions some day when they get the
> > bright idea to move RWSEM_WRITER_LOCKED to the upper bit and fail to
> > notice this predicate and its magic number.  IMO moving it to the header
> > file (possibly with the usual __ prefix) would be preferable to leaving
> > a landmine.
> 
> +       return atomic_long_read(&sem->count) & 1 /* RWSEM_WRITER_LOCKED */;
> 
> works for you?

Yeah I guess that works.

--D
