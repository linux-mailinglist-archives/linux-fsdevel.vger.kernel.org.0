Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7906257375C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiGMN1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 09:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiGMN1M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:27:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF09B7EC
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 06:27:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C161A33D85;
        Wed, 13 Jul 2022 13:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657718828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xSttkQibOdpLVJNx+valLwwJwjzjQSj9FMSHu4JsuBw=;
        b=2BmCELKzLQf1nkiT8LfUAVeuziqZCZ8EAa1qI9J3RGSC+3iIKruBmWW1U/ue0LQWPlmbbE
        Y6UK3E7xNIIvSwCXiGgsjxjdhwS+XIK1Y2uIERuU34qoa9lhfAEl5GMdXWI1EmKSNUFkmU
        pTkEqpO6GKmhupfByDzL8+SnLS4Ints=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657718828;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xSttkQibOdpLVJNx+valLwwJwjzjQSj9FMSHu4JsuBw=;
        b=WIHvBDrZ7Ij9z93tYvGYf8C3j49kL3XmRHfbZPWlJhJrKSHZyfsDj2QjwskR8F5kMBaqB8
        XVnYVAFaAD1XaaDQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EB9732C142;
        Wed, 13 Jul 2022 13:27:07 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 52EE2A0635; Wed, 13 Jul 2022 15:27:01 +0200 (CEST)
Date:   Wed, 13 Jul 2022 15:27:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot+9bd2b7adbd34b30b87e4@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] secretmem: fix unhandled fault in truncate
Message-ID: <20220713132701.rnb5eieno4gmpvqh@quack3>
References: <20220707165650.248088-1-rppt@kernel.org>
 <CAHbLzkqLPi9i3BspCLUe=eZ4huTY2ZnbfD19K_ShsaOC47En_w@mail.gmail.com>
 <YsdITMg5xZiu8Yoh@magnolia>
 <CAHbLzkpnkcFg5hOf49V=gFSvTWsWUe_M8-69knDpvSSdua+x4w@mail.gmail.com>
 <Ysfqxg9Ury1NX27N@kernel.org>
 <CAHbLzkpB59wX-U4Y4Bs4hxAZKy9JG29UtRPks1458VredwRxTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpB59wX-U4Y4Bs4hxAZKy9JG29UtRPks1458VredwRxTg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 12-07-22 10:40:11, Yang Shi wrote:
> On Fri, Jul 8, 2022 at 1:29 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Thu, Jul 07, 2022 at 03:09:32PM -0700, Yang Shi wrote:
> > > On Thu, Jul 7, 2022 at 1:55 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Thu, Jul 07, 2022 at 10:48:00AM -0700, Yang Shi wrote:
> > > > > On Thu, Jul 7, 2022 at 9:57 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > > >
> > > > > > Eric Biggers suggested that this happens when
> > > > > > secretmem_setattr()->simple_setattr() races with secretmem_fault() so
> > > > > > that a page that is faulted in by secretmem_fault() (and thus removed
> > > > > > from the direct map) is zeroed by inode truncation right afterwards.
> > > > > >
> > > > > > Since do_truncate() takes inode_lock(), adding inode_lock_shared() to
> > > > > > secretmem_fault() prevents the race.
> > > > >
> > > > > Should invalidate_lock be used to serialize between page fault and truncate?
> > > >
> > > > I would have thought so, given Documentation/filesystems/locking.rst:
> > > >
> > > > "->fault() is called when a previously not present pte is about to be
> > > > faulted in. The filesystem must find and return the page associated with
> > > > the passed in "pgoff" in the vm_fault structure. If it is possible that
> > > > the page may be truncated and/or invalidated, then the filesystem must
> > > > lock invalidate_lock, then ensure the page is not already truncated
> > > > (invalidate_lock will block subsequent truncate), and then return with
> > > > VM_FAULT_LOCKED, and the page locked. The VM will unlock the page."
> > > >
> > > > IIRC page faults aren't supposed to take i_rwsem because the fault could
> > > > be in response to someone mmaping a file into memory and then write()ing
> > > > to the same file using the mmapped region.  The write() takes
> > > > inode_lock and faults on the buffer, so the fault cannot take inode_lock
> > > > again.
> > >
> > > Do you mean writing from one part of the file to the other part of the
> > > file so the "from" buffer used by copy_from_user() is part of the
> > > mmaped region?
> > >
> > > Another possible deadlock issue by using inode_lock in page faults is
> > > mmap_lock is acquired before inode_lock, but write may acquire
> > > inode_lock before mmap_lock, it is a AB-BA lock pattern, but it should
> > > not cause real deadlock since mmap_lock is not exclusive for page
> > > faults. But such pattern should be avoided IMHO.
> > >
> > > > That said... I don't think memfd_secret files /can/ be written to?
> >
> > memfd_secret files cannot be written to, they can only be mmap()ed.
> > Synchronization is only required between
> > do_truncate()->...->simple_setatt() and secretmem->fault() and I don't see
> > how that can deadlock.
> 
> Sure, there is no deadlock.
> 
> >
> > I'm not an fs expert though, so if you think that invalidate_lock() is
> > safer, I don't mind s/inode_lock/invalidate_lock/ in the patch.
> 
> IIUC invalidate_lock should be preferred per the filesystem's locking
> document. And I found Jan Kara's email of the invalidate_lock
> patchset, please refer to
> https://lore.kernel.org/linux-mm/20210715133202.5975-1-jack@suse.cz/.

Yeah, so using invalidate_lock for such synchronization would be certainly
more standard than using inode_lock. Although I agree that for filesystems
that do not support read(2) and write(2) there does not seem to be an
immediate risk of a deadlock when inode_lock is used inside a page fault.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
