Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DC474B63F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 20:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGGS2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 14:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGGS2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:28:01 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F44B2685;
        Fri,  7 Jul 2023 11:27:59 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39ca120c103so1799715b6e.2;
        Fri, 07 Jul 2023 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688754479; x=1691346479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iYQfxXiGIbONBSMq6Yza7HFvxxB0EcOOzA9wruYd9/s=;
        b=j3geTWRkEi3aeiGz2BF4fSfBPYHNsjFbdUALg4Z6+wh1OZhMpmxe/qUenhsbvBmC7j
         yHrk29Qw2/fd222QSd/7L4e5lvCPVgiE7jHmQo3vZhwwMY5ZLYMj1UogKzNP8cKCecVd
         XQSML42ydPCsukuqBl2iATBWJF7vYK2eoHPL3XioEeZsm9U83H+9t46w1o/iePkULvMn
         ghR0Nyuna3L17isRB+Xifod3A37dAqVGRhZvZZ2GSnkZd1Fkp1+FrJ0mN9myunq1zU0c
         7DtBuaWasks/8OCl45eKLTPffT2APC4cQVO8IKkIGOTZ8naNNY/joAXdt62xDiY8be+U
         ZfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688754479; x=1691346479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYQfxXiGIbONBSMq6Yza7HFvxxB0EcOOzA9wruYd9/s=;
        b=RWgW/SjFf8gF2LcLCSOkVn7sYEJWnGxiakKA7f6OK11xxKCvQJ4yupdfkxdIgMChrR
         SepiRhJqHzG5v00NstkKM+s5fZysPJQHcbIJhhh30sK8dmxu6H07Ton2e5fdhKlGACU2
         7sxSIkO4YS+F1Gf21VaI7Fa38vFtqAU0Ssci5vyyR1umj0c+3VmB5T80cpmDQM+0/5+l
         dJ/F1xWMdotGx8BS/JXagqbwGKo0NVkUOadJjPqPzy/IM3GOe0ra6IGFDWsSjOjMkPak
         WMQ4lyB9RG6s0+uuVJZAHcIxJeD7RgBy+ZjGJMBgztv+N58hqg8V/Nr+o5ydP39tid1S
         63fg==
X-Gm-Message-State: ABy/qLZ9H8qTNOgG5BI4TDVHz5eXmfZrl7lcUu+i0jfyHJyGE3NfiVTY
        NBMXRedY+ibOx1rhNkQLPek=
X-Google-Smtp-Source: APBJJlGyNnx65V8DrUjHW0YCJrqFGc33K7OB7NDJ9VF8y/PY5FmBu9OfcUtqWP5Qz4NxceHxptdnHQ==
X-Received: by 2002:a05:6808:202a:b0:3a3:d153:2723 with SMTP id q42-20020a056808202a00b003a3d1532723mr6588090oiw.29.1688754478621;
        Fri, 07 Jul 2023 11:27:58 -0700 (PDT)
Received: from fedora ([121.135.181.61])
        by smtp.gmail.com with ESMTPSA id fe27-20020a056a002f1b00b0064d47cd117esm3189901pfb.39.2023.07.07.11.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 11:27:58 -0700 (PDT)
Date:   Sat, 8 Jul 2023 03:27:42 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
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
        Daire Byrne <daire.byrne@gmail.com>
Subject: Re: [BUG mm-unstable] BUG: KASAN: use-after-free in
 shrink_folio_list+0x9f4/0x1ae0
Message-ID: <ZKhZHg6LSGnvryIe@fedora>
References: <20230628104852.3391651-1-dhowells@redhat.com>
 <20230628104852.3391651-3-dhowells@redhat.com>
 <ZKg/J3OG3kQ9ynSO@fedora>
 <CAB=+i9Qbi7+o90Cd_ecd1TeaAYnWPcO-gNp7kzc95Pxecy0XTw@mail.gmail.com>
 <CALF+zO=nGdoxcT-ya3aaUCBi-4iKPo3kZyzcWYCKMCf4n2wVbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALF+zO=nGdoxcT-ya3aaUCBi-4iKPo3kZyzcWYCKMCf4n2wVbA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 07, 2023 at 02:12:06PM -0400, David Wysochanski wrote:
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

Oh, it does not crash with the patch applied.

Hmm, was it UAF because it references wrong field ->mapping,
instead of swapper address space?

