Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F82474B626
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 20:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGGSNg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 14:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjGGSNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D32691
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688753565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYp6SX4idj0K2s8mMqxJ4XFt6H9/PBaHUEfz7SiAvZA=;
        b=PsvYJEbxUBucMhQkMVERI4Y0gEC6D59jE1JTSnGBpr/j2uTq6wbAp2u6+O91yQFDF+OjMP
        8sJyE4C/cuur2Tyw3y+mt5EnJMVng6NLXk7BA2akSPXx7J9ecywqo+LxBUNktYyXkpU2GM
        bR145k8uQxS7PfmVrCbTqr+qw75cSWU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-si7khHdWM1-fiWr8xNMCkw-1; Fri, 07 Jul 2023 14:12:44 -0400
X-MC-Unique: si7khHdWM1-fiWr8xNMCkw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-262d8993033so2844156a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 11:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688753563; x=1691345563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYp6SX4idj0K2s8mMqxJ4XFt6H9/PBaHUEfz7SiAvZA=;
        b=Z4zA8g3lLdi+TpnyodJXe7WxDwGXfX9I1YtbFU/7AEPkEojDMvncJWDPk7LXJ40eyq
         dKkf0Qh6PrC2483HHvqtOCNvkZwczDD9F6XIR9tfLECOLVXG8kFpMNWjZ7ae7RA3r6Dr
         c0le+JUu6xDU6fgb1qmWjNrBVoOdpKD7y5CAdahtavAvosKM3HfeRsnRSW6KAbS/p2Bx
         JrX7K4W5bJ5hUtPUEfSlvKgkG0KbkoKzDhfmsnOE9qFuWBVRtH2/U6222qfiiH1bmWVZ
         VolsBMASISUg7Nivi1IRJZLEYeRl1eN+wWyG2cwC82ro9wUwuHjgbc9l6ypiRqNBzccq
         PKGA==
X-Gm-Message-State: ABy/qLYKRiMRohHMzzgTuL0pb25xGW3sdESjY0/G9RxLr+mes2/F6oCK
        3rPo5Nb7rBYYumMgZ4gzEZgsAKye2lS2+UpY7qloMfZCmWvCaK+cQ1VTzCb6dl0lqYMUk5BDxUu
        a+nWpgyyXrkyJ+YDJWNn15plNG2luQUZjF40UiJgmYw==
X-Received: by 2002:a17:90a:bd01:b0:262:b229:7e45 with SMTP id y1-20020a17090abd0100b00262b2297e45mr4613482pjr.11.1688753563137;
        Fri, 07 Jul 2023 11:12:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG6u68dTynLKu27IgkCmRz2kNSu4UGaUBT2IU6X1iGZYQeExxypGVXNQUOEHGzK3cyz6ytMfUjBA5GoKXPvaz8=
X-Received: by 2002:a17:90a:bd01:b0:262:b229:7e45 with SMTP id
 y1-20020a17090abd0100b00262b2297e45mr4613468pjr.11.1688753562822; Fri, 07 Jul
 2023 11:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230628104852.3391651-1-dhowells@redhat.com> <20230628104852.3391651-3-dhowells@redhat.com>
 <ZKg/J3OG3kQ9ynSO@fedora> <CAB=+i9Qbi7+o90Cd_ecd1TeaAYnWPcO-gNp7kzc95Pxecy0XTw@mail.gmail.com>
In-Reply-To: <CAB=+i9Qbi7+o90Cd_ecd1TeaAYnWPcO-gNp7kzc95Pxecy0XTw@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 7 Jul 2023 14:12:06 -0400
Message-ID: <CALF+zO=nGdoxcT-ya3aaUCBi-4iKPo3kZyzcWYCKMCf4n2wVbA@mail.gmail.com>
Subject: Re: [BUG mm-unstable] BUG: KASAN: use-after-free in shrink_folio_list+0x9f4/0x1ae0
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 7, 2023 at 12:46=E2=80=AFPM Hyeonggon Yoo <42.hyeyoo@gmail.com>=
 wrote:
>
> On Sat, Jul 8, 2023 at 1:39=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.com=
> wrote:
> >
> > On Wed, Jun 28, 2023 at 11:48:52AM +0100, David Howells wrote:
> > > Fscache has an optimisation by which reads from the cache are skipped=
 until
> > > we know that (a) there's data there to be read and (b) that data isn'=
t
> > > entirely covered by pages resident in the netfs pagecache.  This is d=
one
> > > with two flags manipulated by fscache_note_page_release():
> > >
> > >       if (...
> > >           test_bit(FSCACHE_COOKIE_HAVE_DATA, &cookie->flags) &&
> > >           test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
> > >               clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flag=
s);
> > >
> > > where the NO_DATA_TO_READ flag causes cachefiles_prepare_read() to in=
dicate
> > > that netfslib should download from the server or clear the page inste=
ad.
> > >
> > > The fscache_note_page_release() function is intended to be called fro=
m
> > > ->releasepage() - but that only gets called if PG_private or PG_priva=
te_2
> > > is set - and currently the former is at the discretion of the network
> > > filesystem and the latter is only set whilst a page is being written =
to the
> > > cache, so sometimes we miss clearing the optimisation.
> > >
> > > Fix this by following Willy's suggestion[1] and adding an address_spa=
ce
> > > flag, AS_RELEASE_ALWAYS, that causes filemap_release_folio() to alway=
s call
> > > ->release_folio() if it's set, even if PG_private or PG_private_2 are=
n't
> > > set.
> > >
> > > Note that this would require folio_test_private() and page_has_privat=
e() to
> > > become more complicated.  To avoid that, in the places[*] where these=
 are
> > > used to conditionalise calls to filemap_release_folio() and
> > > try_to_release_page(), the tests are removed the those functions just
> > > jumped to unconditionally and the test is performed there.
> > >
> > > [*] There are some exceptions in vmscan.c where the check guards more=
 than
> > > just a call to the releaser.  I've added a function, folio_needs_rele=
ase()
> > > to wrap all the checks for that.
> > >
> > > AS_RELEASE_ALWAYS should be set if a non-NULL cookie is obtained from
> > > fscache and cleared in ->evict_inode() before truncate_inode_pages_fi=
nal()
> > > is called.
> > >
> > > Additionally, the FSCACHE_COOKIE_NO_DATA_TO_READ flag needs to be cle=
ared
> > > and the optimisation cancelled if a cachefiles object already contain=
s data
> > > when we open it.
> > >
> > > Fixes: 1f67e6d0b188 ("fscache: Provide a function to note the release=
 of a page")
> > > Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
> > > Reported-by: Rohith Surabattula <rohiths.msft@gmail.com>
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> >
> > Hi David,
> >
> > I was bisecting a use-after-free BUG on the latest mm-unstable,
> > where HEAD is 347e208de0e4 ("rmap: pass the folio to __page_check_anon_=
rmap()").
> >
> > According to my bisection, this is the first bad commit.
> > Use-After-Free is triggered on reclamation path when swap is enabled.
>
> This was originally occurred during kernel compilation but
> can easily be reproduced via:
>
> stress-ng --bigheap $(nproc)
>
> > (and couldn't trigger without swap enabled)
> >
> > the config, KASAN splat, bisect log are attached.
> > hope this isn't too late :(
> >
> > > cc: Matthew Wilcox <willy@infradead.org>
> > > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > cc: Steve French <sfrench@samba.org>
> > > cc: Shyam Prasad N <nspmangalore@gmail.com>
> > > cc: Rohith Surabattula <rohiths.msft@gmail.com>
> > > cc: Dave Wysochanski <dwysocha@redhat.com>
> > > cc: Dominique Martinet <asmadeus@codewreck.org>
> > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > cc: linux-cachefs@redhat.com
> > > cc: linux-cifs@vger.kernel.org
> > > cc: linux-afs@lists.infradead.org
> > > cc: v9fs-developer@lists.sourceforge.net
> > > cc: ceph-devel@vger.kernel.org
> > > cc: linux-nfs@vger.kernel.org
> > > cc: linux-fsdevel@vger.kernel.org
> > > cc: linux-mm@kvack.org
> > > ---
> > >
> > > Notes:
> > >     ver #7)
> > >      - Make NFS set AS_RELEASE_ALWAYS.
> > >
> > >     ver #4)
> > >      - Split out merging of folio_has_private()/filemap_release_folio=
() call
> > >        pairs into a preceding patch.
> > >      - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
> > >
> > >     ver #3)
> > >      - Fixed mapping_clear_release_always() to use clear_bit() not se=
t_bit().
> > >      - Moved a '&&' to the correct line.
> > >
> > >     ver #2)
> > >      - Rewrote entirely according to Willy's suggestion[1].
> > >
> > >  fs/9p/cache.c           |  2 ++
> > >  fs/afs/internal.h       |  2 ++
> > >  fs/cachefiles/namei.c   |  2 ++
> > >  fs/ceph/cache.c         |  2 ++
> > >  fs/nfs/fscache.c        |  3 +++
> > >  fs/smb/client/fscache.c |  2 ++
> > >  include/linux/pagemap.h | 16 ++++++++++++++++
> > >  mm/internal.h           |  5 ++++-
> > >  8 files changed, 33 insertions(+), 1 deletion(-)


I think myself / Daire Byrne may have already tracked this down and I
found a 1-liner that fixed a similar crash in his environment.

Can you try this patch on top and let me know if it still crashes?
https://github.com/DaveWysochanskiRH/kernel/commit/902c990e311120179fa5de99=
d68364b2947b79ec

