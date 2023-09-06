Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDD279400C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbjIFPNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 11:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjIFPNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:13:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697AE64;
        Wed,  6 Sep 2023 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Hh8RP/bfISLAqmB2G73yXjalsG6Q4wl2Hr38dodQdY=; b=n4YGjuv73LiTnQqadLgKOVENLx
        cMw5iBfWSIbk/Ks2NvN7CyDZ2DLnOw6HpziRzJ89JHejiCq07MBiNkmjY1xgt9UM7zw3qPK0OPLMM
        FUtT8yuM2da5FHpqA+B34I6e+cZwrk02qnSx6UAsHFY/Teyakhkjn+CuZjs/2m10tZaCMeiRrdbFH
        c7y1zUmyZSNb8pUi0qQ0AZu62yM5k2l389RQ7/eB9tY/0/ymlg1qHLibf3mC8YcJoSN9Fix8TCEx3
        LDVTttv+uC6A8moJ6veUoGOkGaYhq0zZS7HFiLKp7F9k1a9I7u2Er8jIQcpGOgGeJbPov2s8TlxPi
        Fl1CUx+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qduDs-003Nfv-Of; Wed, 06 Sep 2023 15:13:41 +0000
Date:   Wed, 6 Sep 2023 16:13:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        bernd.schubert@fastmail.fm, miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/2] Use exclusive lock for file_remove_privs
Message-ID: <ZPiXJMh/qYQ09Y2R@casper.infradead.org>
References: <20230830181519.2964941-1-bschubert@ddn.com>
 <20230831101824.qdko4daizgh7phav@f>
 <ZPHNJVU+T79oVGY9@casper.infradead.org>
 <CAGudoHE6LVCFU6w6+4WHY=Bx7SSTCggzO+CihWeaRgWRy+EXtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHE6LVCFU6w6+4WHY=Bx7SSTCggzO+CihWeaRgWRy+EXtg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:47:10PM +0200, Mateusz Guzik wrote:
> On 9/1/23, Matthew Wilcox <willy@infradead.org> wrote:
> > On Thu, Aug 31, 2023 at 12:18:24PM +0200, Mateusz Guzik wrote:
> >> So I figured an assert should be there on the write lock held, then the
> >> issue would have been automagically reported.
> >>
> >> Turns out notify_change has the following:
> >>         WARN_ON_ONCE(!inode_is_locked(inode));
> >>
> >> Which expands to:
> >> static inline int rwsem_is_locked(struct rw_semaphore *sem)
> >> {
> >>         return atomic_long_read(&sem->count) != 0;
> >> }
> >>
> >> So it does check the lock, except it passes *any* locked state,
> >> including just readers.
> >>
> >> According to git blame this regressed from commit 5955102c9984
> >> ("wrappers for ->i_mutex access") by Al -- a bunch of mutex_is_locked
> >> were replaced with inode_is_locked, which unintentionally provides
> >> weaker guarantees.
> >>
> >> I don't see a rwsem helper for wlock check and I don't think it is all
> >> that beneficial to add. Instead, how about a bunch of lockdep, like so:
> >> diff --git a/fs/attr.c b/fs/attr.c
> >> index a8ae5f6d9b16..f47e718766d1 100644
> >> --- a/fs/attr.c
> >> +++ b/fs/attr.c
> >> @@ -387,7 +387,7 @@ int notify_change(struct mnt_idmap *idmap, struct
> >> dentry *dentry,
> >>         struct timespec64 now;
> >>         unsigned int ia_valid = attr->ia_valid;
> >>
> >> -       WARN_ON_ONCE(!inode_is_locked(inode));
> >> +       lockdep_assert_held_write(&inode->i_rwsem);
> >>
> >>         error = may_setattr(idmap, inode, ia_valid);
> >>         if (error)
> >>
> >> Alternatively hide it behind inode_assert_is_wlocked() or whatever other
> >> name.
> >
> > Better to do it like mmap_lock:
> >
> > static inline void mmap_assert_write_locked(struct mm_struct *mm)
> > {
> >         lockdep_assert_held_write(&mm->mmap_lock);
> >         VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> > }
> >
> 
> May I suggest continuing this with responses to the patch I sent? ;)

That's annoying.  Don't split this kind of conversation up if you don't
have to.

> [RFC PATCH] vfs: add inode lockdep assertions on -fsdevel
> 
> I made it line up with asserts for i_mmap_rwsem.
> 
> btw your non-lockdep check suffers the very problem I'm trying to fix
> here -- checking for *any* locked state.

I'll respond to this over there then.
