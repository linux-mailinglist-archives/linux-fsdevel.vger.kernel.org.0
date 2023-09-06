Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F17D79405B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 17:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbjIFP1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 11:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242620AbjIFP1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:27:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81805199C;
        Wed,  6 Sep 2023 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h6ulJViuQWjxq6lzZiww+qH62G6UOtP0FWuJOUQoXnY=; b=Wkyzg8fTRw+lBBs5qTiqPbv5NZ
        T26Uh5rTUzeBrJhKKfW6R0Y+KmrRdvY8e9gdOIaKTHbg+r96r2emSzcQWOz84u0P7PGPHp2hIStg4
        sAWIBE4T5THlWxLChO0xPty//leBMdnWIPlBUZPYjmjwK37k3gqdV6ZDTh2otlyWbRPgkhbULr1hM
        8EukQND8SLa6zbzVYZcARQsm4pXNE4Q0Fw7czVPNEztJ4eM/p0rbNW/JvATDMnSEhXlHKReScVQvN
        y07BTOmY2vbzuJADAUmi+rp+pFl3F4/Dgs+mLM/oLzRuqksOCB6ljA7/6/Aa89WJlq0Pg6fFngwaz
        ZB+/PYow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qduRG-003RqM-MP; Wed, 06 Sep 2023 15:27:30 +0000
Date:   Wed, 6 Sep 2023 16:27:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: add inode lockdep assertions
Message-ID: <ZPiaYjcTMyuM0JL5@casper.infradead.org>
References: <20230831151414.2714750-1-mjguzik@gmail.com>
 <ZPiYp+t6JTUscc81@casper.infradead.org>
 <b0434328-01f9-dc5c-fe25-4a249130a81d@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0434328-01f9-dc5c-fe25-4a249130a81d@fastmail.fm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Yes, but apparently comments in that thread don't count :eyeroll:
