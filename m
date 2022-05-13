Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7338B526345
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 15:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiEMNuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 09:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381022AbiEMNis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 09:38:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA27463A6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=6EANG6Acvsj4Eq9TPhovf18SNxieYr8hCZ9OR4DBOHc=; b=l8atmwrDLrxyeQ2PKNl3L2+dUO
        +QlEXxIRwTqVp3vSnMZAgKkxfNMYxmjXv062gzIIWrbvAjEoEOqDy+aZyqqdGxOj+huxfpqfx9bt8
        KiMfrtGsb1abPWkDpYr9c+2NxIiP3MnIQ6yFD0rQCOy36Kf8Ic8usQpndsYe8To+9XCu9zhbnE+UM
        v39MoOiDIFsgu3bwJzHrG2kejNC9ibfH2VbMRUlfYhittQNW7x4J84WCM/MhOleQVrtooGJfHRAbE
        ZSHQZ+3VGK90zcBD7hvw+Iir8lHa7O9FVLvygciADnc/UISiHKYUrCcgOekrrznS8X69dxAJIuIli
        ucjTf2Rg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npVV8-007Njr-Du; Fri, 13 May 2022 13:38:38 +0000
Date:   Fri, 13 May 2022 14:38:38 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Freeing page flags
Message-ID: <Yn5fXm83IfUWkv8w@casper.infradead.org>
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
 <Yn3FZSZbEDssbRnk@localhost.localdomain>
 <Yn3S8A9I/G5F4u80@casper.infradead.org>
 <87sfpd22kq.fsf@brahms.olymp>
 <Yn5Uu/ZZkNfbdhGA@casper.infradead.org>
 <baaab6c574d975aaa08ee99f09dd299d9be008ec.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <baaab6c574d975aaa08ee99f09dd299d9be008ec.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 09:21:11AM -0400, Jeff Layton wrote:
> On Fri, 2022-05-13 at 13:53 +0100, Matthew Wilcox wrote:
> > On Fri, May 13, 2022 at 10:40:05AM +0100, Luís Henriques wrote:
> > > Matthew Wilcox <willy@infradead.org> writes:
> > > 
> > > > On Thu, May 12, 2022 at 10:41:41PM -0400, Josef Bacik wrote:
> > > > > On Thu, May 12, 2022 at 09:54:59PM +0100, Matthew Wilcox wrote:
> > > > > > The LWN writeup [1] on merging the MGLRU reminded me that I need to send
> > > > > > out a plan for removing page flags that we can do without.
> > > > > > 
> > > > > > 1. PG_error.  It's basically useless.  If the page was read successfully,
> > > > > > PG_uptodate is set.  If not, PG_uptodate is clear.  The page cache
> > > > > > doesn't use PG_error.  Some filesystems do, and we need to transition
> > > > > > them away from using it.
> > > > > > 
> > > > > 
> > > > > What about writes?  A cursory look shows we don't clear Uptodate if we fail to
> > > > > write, which is correct I think.  The only way to indicate we had a write error
> > > > > to check later is the page error.
> > > > 
> > > > On encountering a write error, we're supposed to call mapping_set_error(),
> > > > not SetPageError().
> > > > 
> > > > > > 2. PG_private.  This tells us whether we have anything stored at
> > > > > > page->private.  We can just check if page->private is NULL or not.
> > > > > > No need to have this extra bit.  Again, there may be some filesystems
> > > > > > that are a bit wonky here, but I'm sure they're fixable.
> > > > > > 
> > > > > 
> > > > > At least for Btrfs we serialize the page->private with the private_lock, so we
> > > > > could probably just drop PG_private, but it's kind of nice to check first before
> > > > > we have to take the spin lock.  I suppose we can just do
> > > > > 
> > > > > if (page->private)
> > > > > 	// do lock and check thingy
> > > > 
> > > > That's my hope!  I think btrfs is already using folio_attach_private() /
> > > > attach_page_private(), which makes everything easier.  Some filesystems
> > > > still manipulate page->private and PagePrivate by hand.
> > > 
> > > In ceph we've recently [1] spent a bit of time debugging a bug related
> > > with ->private not being NULL even though we expected it to be.  The
> > > solution found was to replace the check for NULL and use
> > > folio_test_private() instead, but we _may_ have not figured the whole
> > > thing out.
> > > 
> > > We assumed that folios were being recycled and not cleaned-up.  The values
> > > we were seeing in ->private looked like they were some sort of flags as
> > > only a few bits were set (e.g. 0x0200000):
> > > 
> > > [ 1672.578313] page:00000000e23868c1 refcount:2 mapcount:0 mapping:0000000022e0d3b4 index:0xd8 pfn:0x74e83
> > > [ 1672.581934] aops:ceph_aops [ceph] ino:10000016c9e dentry name:"faed"
> > > [ 1672.584457] flags: 0x4000000000000015(locked|uptodate|lru|zone=1)
> > > [ 1672.586878] raw: 4000000000000015 ffffea0001d3a108 ffffea0001d3a088 ffff888003491948
> > > [ 1672.589894] raw: 00000000000000d8 0000000000200000 00000002ffffffff 0000000000000000
> > > [ 1672.592935] page dumped because: VM_BUG_ON_FOLIO(1)
> > > 
> > > [1] https://lore.kernel.org/all/20220508061543.318394-1-xiubli@redhat.com/
> > 
> > I remember Jeff asking me about this problem a few days ago.  A folio
> > passed to you in ->dirty_folio() or ->invalidate_folio() belongs to
> > your filesystem.  Nobody else should be storing to the ->private field;
> > there's no race that could lead to it being freed while you see it.
> > There may, of course, be bugs that are overwriting folio->private, but
> > it's definitely not supposed to happen.  I agree with you that it looks
> > like a bit has been set (is it possibly bad RAM?)
> > 
> > We do use page->private in the buddy allocator, but that stores the order
> > of the page; it wouldn't be storing 1<<21.  PG flag 21 is PG_mlocked,
> > which seems like a weird one to be setting in the wrong field, so probably
> > not that.
> > 
> > Is it always bit 21 that gets set?
> 
> No, it varies, but it was always just a few bits in the field that end
> up being set. I was never able to reproduce it locally, but saw it in a
> run in ceph's teuthology lab a few times. Xiubo did the most digging
> here, so he may be able to add more info.
> 
> Basically though, we call __filemap_get_folio in netfs_write_begin and
> it will sometimes give us a folio that has PG_private clear, but the
> ->private field has just a few bits that aren't zeroed out. I'm pretty
> sure we zero out that field in ceph, so the theory was that the page was
> traveling through some other subsystem before coming to us.

It _shouldn't_ be.  __filemap_get_folio() may return a page that was
already in the page cache (and so may have had page->private set by
the filesystem originally), or it may allocate a fresh page in
filemap_alloc_folio() which _should_ come with page->private clear.
Adding an assert that is true might be a good debugging tactic:

+++ b/mm/filemap.c
@@ -2008,6 +2008,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
                                goto repeat;
                }

+VM_BUG_ON_FOLIO(folio->private, folio);
                /*
                 * filemap_add_folio locks the page, and for mmap
                 * we expect an unlocked page.

> He wasn't able to ascertain the cause, and just decided to check for
> PG_private instead since you (presumably) shouldn't trust ->private
> unless that's set anyway.

They are usually in sync ... which means we can reclaim the flag ;-)
