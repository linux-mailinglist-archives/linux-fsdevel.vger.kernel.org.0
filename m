Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBEE794320
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbjIFSeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 14:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243631AbjIFSeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:34:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A5510F7;
        Wed,  6 Sep 2023 11:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VrOdvh8kHXIQCpSneIKwhFboMgDOlQRf+mb5hgY9zo8=; b=hHKYhZEIWge8qdgHCn5WUa1v1O
        wKxVc74N6zvaNL+SJWEqMeXei6ZgFE8LFamytQffRqBcgBxNVeGqk3JoXaLfvkfapMWstk2B4voAA
        ysRSZ6gbppBfzP6c/Z5p6BZEPwaA8X7v0YXdVF+s7ElH0MjN8y2LP3KZlzsBldUwln7lqvCYWHrxP
        f8pvG3U+o2xGEbUramz1eUBeE9Dndz7row+c2wZ15w6jwAr1BIxvWN5P8eNJrdMfDP3j3Vj9hcvAC
        K5E/S33uHKR2y9FKYCs2HnhNkHFRPUXLwP7KdG5tgWjMnwtEMPPmgyxpmGyxK6vMDVEVh8AwdDEu2
        q742nWhw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdxLY-004eER-RG; Wed, 06 Sep 2023 18:33:48 +0000
Date:   Wed, 6 Sep 2023 19:33:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add inode lockdep assertions
Message-ID: <ZPjGDGyDf2/ngML9@casper.infradead.org>
References: <20230831151414.2714750-1-mjguzik@gmail.com>
 <ZPiYp+t6JTUscc81@casper.infradead.org>
 <b0434328-01f9-dc5c-fe25-4a249130a81d@fastmail.fm>
 <20230906152948.GE28160@frogsfrogsfrogs>
 <ZPiiDj1T3lGp2w2c@casper.infradead.org>
 <20230906170724.GI28202@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906170724.GI28202@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:07:24AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 06, 2023 at 05:00:14PM +0100, Matthew Wilcox wrote:
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -361,7 +361,7 @@ xfs_isilocked(
> >  {
> >  	if (lock_flags & (XFS_ILOCK_EXCL|XFS_ILOCK_SHARED)) {
> >  		if (!(lock_flags & XFS_ILOCK_SHARED))
> > -			return !!ip->i_lock.mr_writer;
> > +			return rwsem_is_write_locked(&ip->i_lock.mr_lock);
> 
> You'd be better off converting this to:
> 
> 	return __xfs_rwsem_islocked(&ip->i_lock.mr_lock,
> 				(lock_flags & XFS_ILOCK_SHARED));
> 
> And then fixing __xfs_rwsem_islocked to do:
> 
> static inline bool
> __xfs_rwsem_islocked(
> 	struct rw_semaphore	*rwsem,
> 	bool			shared)
> {
> 	if (!debug_locks) {
> 		if (!shared)
> 			return rwsem_is_write_locked(rwsem);
> 		return rwsem_is_locked(rwsem);
> 	}
> 
> 	...
> }

Thanks.

> > +++ b/include/linux/rwsem.h
> > @@ -72,6 +72,11 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
> >  	return atomic_long_read(&sem->count) != 0;
> >  }
> >  
> > +static inline int rwsem_is_write_locked(struct rw_semaphore *sem)
> > +{
> > +	return atomic_long_read(&sem->count) & 1;
> 
> 
> atomic_long_read(&sem->count) & RWSEM_WRITER_LOCKED ?

Then this would either have to be in rwsem.c or we'd have to move the
definition of RWSEM_WRITER_LOCKED to rwsem.h.  All three options are
kind of bad.  I think I hate the bare '1' least.
