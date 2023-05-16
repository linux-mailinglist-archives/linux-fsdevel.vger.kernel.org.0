Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5337970571C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 21:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjEPTah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 15:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEPTag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 15:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92A36583
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 12:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684265387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9UrkqIYKxvK9jQQrJXRaqEAIFWUC38gkJPtkDfF+s0=;
        b=a2M/0NvE3X/qJXIr3cM4tRJJFnwsy7pmiPf2is5NR9JX3GOTVo+sQM35mgZWpuRA7qsvMe
        XCF99pVFJ97ltGBCTcszuTISkNF5x94lIlqDPpix3Q1knEWaWhEySqTkloip0BQ3t9bqa9
        0yI1ZxgHgSM8JlhLnQyX3Q7h47opKTE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Zu3X5UNEPD-aqsNoC0mGnw-1; Tue, 16 May 2023 15:29:46 -0400
X-MC-Unique: Zu3X5UNEPD-aqsNoC0mGnw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-24df8644eaeso13616a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 12:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684265386; x=1686857386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9UrkqIYKxvK9jQQrJXRaqEAIFWUC38gkJPtkDfF+s0=;
        b=GPq7ojdYw+Y+z53843zSVUty02o0gaTfjb4kBnDzDgoqEued9EmRB0Rp+EFegDNiM/
         mInwWp6FKfANKXGoJOh0zMVBXSnOqlE5BtXkj0O/5vtsd/kpRdIbhOY/Z7yjhra7Dp5d
         1CV2eXwgtTHcAbaWf2i0p8ELv28BxkmdgkkOklfXV3BcwKTAsk7lRKvXarurP2e0QOZy
         v0/LJnB6+fWRhVqvCVCxq3ZhjBJRQDJQXQ75pgpQBGrMXpHcMpeWMI+Sc+Pquv0u3xAU
         8tj3zIKUTeQhvWEc7aZ/AJVEkukARY6qdJ7aa7CMOEmQmkLO8yFJkDX4nUMyWGt8znA1
         trfA==
X-Gm-Message-State: AC+VfDy8sK0jk0S4ysLTDjxKygJVDe1w3oX4m1DK/F8jzB7P6zM4C3lM
        1rGtGO5+ZVCyynhQOOaDrvLmJ2IdC7esYmx7nSWrIph4KyqTF1CLRU4/2JWCYfSbqyQDB75EcIY
        /wSPicG+BvDz+YKtDJmAUxme0p2LA/HUBov4uK6JHUw==
X-Received: by 2002:a17:90a:8049:b0:24d:e929:56cf with SMTP id e9-20020a17090a804900b0024de92956cfmr37452329pjw.39.1684265385703;
        Tue, 16 May 2023 12:29:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gBFGff4dAZMhxmbGkiocJy63rZyONMUQ6rm3VRtZFYy02jZIS98cu+nLLPRraC5I03lzcx85+v3rvPJQsVd4=
X-Received: by 2002:a17:90a:8049:b0:24d:e929:56cf with SMTP id
 e9-20020a17090a804900b0024de92956cfmr37452303pjw.39.1684265385415; Tue, 16
 May 2023 12:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230216150701.3654894-1-dhowells@redhat.com>
In-Reply-To: <20230216150701.3654894-1-dhowells@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 16 May 2023 15:29:09 -0400
Message-ID: <CALF+zO=w2Gyz6JtzEoFgTVjH67-_CuTaK7e+2yoHEwXZ8bPx_A@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH v6 0/2] mm, netfs, fscache: Stop read
 optimisation when folio removed from pagecache
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:07=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Hi Willy,
>
> Is this okay by you?  You said you wanted to look at the remaining uses o=
f
> page_has_private(), of which there are then three after these patches, no=
t
> counting folio_has_private():
>
>         arch/s390/kernel/uv.c:          if (page_has_private(page))
>         mm/khugepaged.c:                    1 + page_mapcount(page) + pag=
e_has_private(page)) {
>         mm/migrate_device.c:            extra +=3D 1 + page_has_private(p=
age);
>
> --
> I've split the folio_has_private()/filemap_release_folio() call pair
> merging into its own patch, separate from the actual bugfix and pulled ou=
t
> the folio_needs_release() function into mm/internal.h and made
> filemap_release_folio() use it.  I've also got rid of the bit clearances
> from the network filesystem evict_inode functions as they doesn't seem to
> be necessary.
>
> Note that the last vestiges of try_to_release_page() got swept away, so I
> rebased and dealt with that.  One comment remained, which is removed by t=
he
> first patch.
>
> David
>
> Changes:
> =3D=3D=3D=3D=3D=3D=3D=3D
> ver #6)
>  - Drop the third patch which removes a duplicate check in vmscan().
>
> ver #5)
>  - Rebased on linus/master.  try_to_release_page() has now been entirely
>    replaced by filemap_release_folio(), barring one comment.
>  - Cleaned up some pairs in ext4.
>
> ver #4)
>  - Split has_private/release call pairs into own patch.
>  - Moved folio_needs_release() to mm/internal.h and removed open-coded
>    version from filemap_release_folio().
>  - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
>  - Added experimental patch to reduce shrink_folio_list().
>
> ver #3)
>  - Fixed mapping_clear_release_always() to use clear_bit() not set_bit().
>  - Moved a '&&' to the correct line.
>
> ver #2)
>  - Rewrote entirely according to Willy's suggestion[1].
>
> Link: https://lore.kernel.org/r/Yk9V/03wgdYi65Lb@casper.infradead.org/ [1=
]
> Link: https://lore.kernel.org/r/164928630577.457102.8519251179327601178.s=
tgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/166844174069.1124521.10890506360974169994=
.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/166869495238.3720468.4878151409085146764.=
stgit@warthog.procyon.org.uk/ # v3
> Link: https://lore.kernel.org/r/1459152.1669208550@warthog.procyon.org.uk=
/ # v3 also
> Link: https://lore.kernel.org/r/166924370539.1772793.13730698360771821317=
.stgit@warthog.procyon.org.uk/ # v4
> Link: https://lore.kernel.org/r/167172131368.2334525.8569808925687731937.=
stgit@warthog.procyon.org.uk/ # v5
> ---
> %(shortlog)s
> %(diffstat)s
>
> David Howells (2):
>   mm: Merge folio_has_private()/filemap_release_folio() call pairs
>   mm, netfs, fscache: Stop read optimisation when folio removed from
>     pagecache
>
>  fs/9p/cache.c           |  2 ++
>  fs/afs/internal.h       |  2 ++
>  fs/cachefiles/namei.c   |  2 ++
>  fs/ceph/cache.c         |  2 ++
>  fs/cifs/fscache.c       |  2 ++
>  fs/ext4/move_extent.c   | 12 ++++--------
>  fs/splice.c             |  3 +--
>  include/linux/pagemap.h | 16 ++++++++++++++++
>  mm/filemap.c            |  2 ++
>  mm/huge_memory.c        |  3 +--
>  mm/internal.h           | 11 +++++++++++
>  mm/khugepaged.c         |  3 +--
>  mm/memory-failure.c     |  8 +++-----
>  mm/migrate.c            |  3 +--
>  mm/truncate.c           |  6 ++----
>  mm/vmscan.c             |  8 ++++----
>  16 files changed, 56 insertions(+), 29 deletions(-)
>
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
>

Willy, and David,

Can this series move forward?
This just got mentioned again [1] after Chris tested the NFS netfs
patches that were merged in 6.4-rc1

[1] https://lore.kernel.org/linux-nfs/CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWKnU=
Qs4r8fkW=3D6RW9g@mail.gmail.com/

