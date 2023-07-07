Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFC874B707
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 21:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjGGTXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 15:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjGGTXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F8519AE;
        Fri,  7 Jul 2023 12:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1B1A61A53;
        Fri,  7 Jul 2023 19:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63501C433C7;
        Fri,  7 Jul 2023 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688757785;
        bh=94A738552oPcNLUcdadUB8TIEGBu7Z7b4zP4i/CSZhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tgLCFacDRH2vFBvGsS1BdApLvk5sLS7WaSV2sgoXnSapnBONfvmv9X8eKnvugMJHE
         jqjgRwSKqOqTX8fmIldEGKg0KhXTvE0Bema9AGOztxJ3On1k5IAODVtjRLYQSXxP2D
         t/ZQ+Qpmi+iWBisfwT5UB4sgtSMbE1mZirUi9Sv4DwscQ0HrO92bVw63QK67r9cxrQ
         QxbM6U35zant3vdXmjw3fsF5Ss+czDaGBBWJvUTejeoPPj3ruozwzQAv9CaKvhOlKV
         2nM3B31uev1RK+ZATSoyzNzgygragekkgVMBHp/70Fr46Mi/QGbs3iEtE2igexxk6o
         AYNbqLhudXizg==
From:   SeongJae Park <sj@kernel.org>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-mm@kvack.org,
        Daire Byrne <daire.byrne@gmail.com>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [BUG mm-unstable] BUG: KASAN: use-after-free in shrink_folio_list+0x9f4/0x1ae0
Date:   Fri,  7 Jul 2023 19:23:01 +0000
Message-Id: <20230707192301.27308-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CALF+zO=nGdoxcT-ya3aaUCBi-4iKPo3kZyzcWYCKMCf4n2wVbA@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Jul 2023 14:12:06 -0400 David Wysochanski <dwysocha@redhat.com> wrote:

> On Fri, Jul 7, 2023 at 12:46 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > On Sat, Jul 8, 2023 at 1:39 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > >
> > > On Wed, Jun 28, 2023 at 11:48:52AM +0100, David Howells wrote:
> > > > Fscache has an optimisation by which reads from the cache are skipped until
> > > > we know that (a) there's data there to be read and (b) that data isn't
> > > > entirely covered by pages resident in the netfs pagecache.  This is done
> > > > with two flags manipulated by fscache_note_page_release():
> > > >
> > > >       if (...
> > > >           test_bit(FSCACHE_COOKIE_HAVE_DATA, &cookie->flags) &&
> > > >           test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
> > > >               clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
> > > >
> > > > where the NO_DATA_TO_READ flag causes cachefiles_prepare_read() to indicate
> > > > that netfslib should download from the server or clear the page instead.
> > > >
> > > > The fscache_note_page_release() function is intended to be called from
> > > > ->releasepage() - but that only gets called if PG_private or PG_private_2
> > > > is set - and currently the former is at the discretion of the network
> > > > filesystem and the latter is only set whilst a page is being written to the
> > > > cache, so sometimes we miss clearing the optimisation.
> > > >
> > > > Fix this by following Willy's suggestion[1] and adding an address_space
> > > > flag, AS_RELEASE_ALWAYS, that causes filemap_release_folio() to always call
> > > > ->release_folio() if it's set, even if PG_private or PG_private_2 aren't
> > > > set.
> > > >
> > > > Note that this would require folio_test_private() and page_has_private() to
> > > > become more complicated.  To avoid that, in the places[*] where these are
> > > > used to conditionalise calls to filemap_release_folio() and
> > > > try_to_release_page(), the tests are removed the those functions just
> > > > jumped to unconditionally and the test is performed there.
> > > >
> > > > [*] There are some exceptions in vmscan.c where the check guards more than
> > > > just a call to the releaser.  I've added a function, folio_needs_release()
> > > > to wrap all the checks for that.
> > > >
> > > > AS_RELEASE_ALWAYS should be set if a non-NULL cookie is obtained from
> > > > fscache and cleared in ->evict_inode() before truncate_inode_pages_final()
> > > > is called.
> > > >
> > > > Additionally, the FSCACHE_COOKIE_NO_DATA_TO_READ flag needs to be cleared
> > > > and the optimisation cancelled if a cachefiles object already contains data
> > > > when we open it.
> > > >
> > > > Fixes: 1f67e6d0b188 ("fscache: Provide a function to note the release of a page")
> > > > Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
> > > > Reported-by: Rohith Surabattula <rohiths.msft@gmail.com>
> > > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > > Signed-off-by: David Howells <dhowells@redhat.com>
> > >
> > > Hi David,
> > >
> > > I was bisecting a use-after-free BUG on the latest mm-unstable,
> > > where HEAD is 347e208de0e4 ("rmap: pass the folio to __page_check_anon_rmap()").
> > >
> > > According to my bisection, this is the first bad commit.
> > > Use-After-Free is triggered on reclamation path when swap is enabled.
> >
> > This was originally occurred during kernel compilation but
> > can easily be reproduced via:
> >
> > stress-ng --bigheap $(nproc)
> >
> > > (and couldn't trigger without swap enabled)
> > >
> > > the config, KASAN splat, bisect log are attached.
> > > hope this isn't too late :(
> > >
> > > > cc: Matthew Wilcox <willy@infradead.org>
> > > > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > > cc: Steve French <sfrench@samba.org>
> > > > cc: Shyam Prasad N <nspmangalore@gmail.com>
> > > > cc: Rohith Surabattula <rohiths.msft@gmail.com>
> > > > cc: Dave Wysochanski <dwysocha@redhat.com>
> > > > cc: Dominique Martinet <asmadeus@codewreck.org>
> > > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > > cc: linux-cachefs@redhat.com
> > > > cc: linux-cifs@vger.kernel.org
> > > > cc: linux-afs@lists.infradead.org
> > > > cc: v9fs-developer@lists.sourceforge.net
> > > > cc: ceph-devel@vger.kernel.org
> > > > cc: linux-nfs@vger.kernel.org
> > > > cc: linux-fsdevel@vger.kernel.org
> > > > cc: linux-mm@kvack.org
> > > > ---
> > > >
> > > > Notes:
> > > >     ver #7)
> > > >      - Make NFS set AS_RELEASE_ALWAYS.
> > > >
> > > >     ver #4)
> > > >      - Split out merging of folio_has_private()/filemap_release_folio() call
> > > >        pairs into a preceding patch.
> > > >      - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
> > > >
> > > >     ver #3)
> > > >      - Fixed mapping_clear_release_always() to use clear_bit() not set_bit().
> > > >      - Moved a '&&' to the correct line.
> > > >
> > > >     ver #2)
> > > >      - Rewrote entirely according to Willy's suggestion[1].
> > > >
> > > >  fs/9p/cache.c           |  2 ++
> > > >  fs/afs/internal.h       |  2 ++
> > > >  fs/cachefiles/namei.c   |  2 ++
> > > >  fs/ceph/cache.c         |  2 ++
> > > >  fs/nfs/fscache.c        |  3 +++
> > > >  fs/smb/client/fscache.c |  2 ++
> > > >  include/linux/pagemap.h | 16 ++++++++++++++++
> > > >  mm/internal.h           |  5 ++++-
> > > >  8 files changed, 33 insertions(+), 1 deletion(-)
> 
> 
> I think myself / Daire Byrne may have already tracked this down and I
> found a 1-liner that fixed a similar crash in his environment.
> 
> Can you try this patch on top and let me know if it still crashes?
> https://github.com/DaveWysochanskiRH/kernel/commit/902c990e311120179fa5de99d68364b2947b79ec

I also encountered this issue with my DAMON tests, and was trying to find a
time slot for deep dive.  And I confirmed your fix works.  Thank you for this
great work.  Please Cc me when you post the patch if possible.

Tested-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> 
> 
