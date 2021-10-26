Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1951143B079
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 12:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhJZKuj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 06:50:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57292 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhJZKui (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:50:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 714D221954;
        Tue, 26 Oct 2021 10:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635245292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dx6hgE8dCAMGrTJldNwNzdTARa/RAij/+n/eTsUcDvU=;
        b=pRNhmR5uhIJ10FzdEdtNIbiYu10HA8z0qf7HtIcUga5r6/ac+96Oi8qMEVL9t8zOrW3whK
        bKVfDiOtb+uU6g3ImiZesH/txUVP4O5yp9IENGmiVwhumRVx0skWhtNFzb4+wZLR1fLpGe
        1UwJIpUvQLsL8Zee4/Pt+spfF2dyIDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635245292;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dx6hgE8dCAMGrTJldNwNzdTARa/RAij/+n/eTsUcDvU=;
        b=3EJlcgepH4Kg85IOlUbJiUAB+Exb9mHxQGDE1+lYiq5l5IMntXdXRr5o5PQL/mbBxMGBf5
        3yIaPwuwcAlEo/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B58413D43;
        Tue, 26 Oct 2021 10:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uSdrLejcd2HNHgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Oct 2021 10:48:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Michal Hocko" <mhocko@suse.com>
Cc:     linux-mm@kvack.org, "Dave Chinner" <david@fromorbit.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 4/4] mm: allow !GFP_KERNEL allocations for kvmalloc
In-reply-to: <YXerCVllHB9g+JnI@dhcp22.suse.cz>
References: <20211025150223.13621-1-mhocko@kernel.org>,
 <20211025150223.13621-5-mhocko@kernel.org>,
 <163520487423.16092.18303917539436351482@noble.neil.brown.name>,
 <YXerCVllHB9g+JnI@dhcp22.suse.cz>
Date:   Tue, 26 Oct 2021 21:48:05 +1100
Message-id: <163524528594.8576.8070122002785265336@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Oct 2021, Michal Hocko wrote:
> On Tue 26-10-21 10:34:34, Neil Brown wrote:
> > On Tue, 26 Oct 2021, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > >=20
> > > A support for GFP_NO{FS,IO} and __GFP_NOFAIL has been implemented
> > > by previous patches so we can allow the support for kvmalloc. This
> > > will allow some external users to simplify or completely remove
> > > their helpers.
> > >=20
> > > GFP_NOWAIT semantic hasn't been supported so far but it hasn't been
> > > explicitly documented so let's add a note about that.
> > >=20
> > > ceph_kvmalloc is the first helper to be dropped and changed to
> > > kvmalloc.
> > >=20
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > ---
> > >  include/linux/ceph/libceph.h |  1 -
> > >  mm/util.c                    | 15 ++++-----------
> > >  net/ceph/buffer.c            |  4 ++--
> > >  net/ceph/ceph_common.c       | 27 ---------------------------
> > >  net/ceph/crypto.c            |  2 +-
> > >  net/ceph/messenger.c         |  2 +-
> > >  net/ceph/messenger_v2.c      |  2 +-
> > >  net/ceph/osdmap.c            | 12 ++++++------
> > >  8 files changed, 15 insertions(+), 50 deletions(-)
> > >=20
> > > diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> > > index 409d8c29bc4f..309acbcb5a8a 100644
> > > --- a/include/linux/ceph/libceph.h
> > > +++ b/include/linux/ceph/libceph.h
> > > @@ -295,7 +295,6 @@ extern bool libceph_compatible(void *data);
> > > =20
> > >  extern const char *ceph_msg_type_name(int type);
> > >  extern int ceph_check_fsid(struct ceph_client *client, struct ceph_fsi=
d *fsid);
> > > -extern void *ceph_kvmalloc(size_t size, gfp_t flags);
> > > =20
> > >  struct fs_parameter;
> > >  struct fc_log;
> > > diff --git a/mm/util.c b/mm/util.c
> > > index bacabe446906..fdec6b4b1267 100644
> > > --- a/mm/util.c
> > > +++ b/mm/util.c
> > > @@ -549,13 +549,10 @@ EXPORT_SYMBOL(vm_mmap);
> > >   * Uses kmalloc to get the memory but if the allocation fails then fal=
ls back
> > >   * to the vmalloc allocator. Use kvfree for freeing the memory.
> > >   *
> > > - * Reclaim modifiers - __GFP_NORETRY and __GFP_NOFAIL are not supporte=
d.
> > > + * Reclaim modifiers - __GFP_NORETRY and GFP_NOWAIT are not supported.
> >=20
> > GFP_NOWAIT is not a modifier.  It is a base value that can be modified.
> > I think you mean that
> >     __GFP_NORETRY is not supported and __GFP_DIRECT_RECLAIM is required
>=20
> I thought naming the higher level gfp mask would be more helpful here.
> Most people do not tend to think in terms of __GFP_DIRECT_RECLAIM but
> rather GFP_NOWAIT or GFP_ATOMIC.

Maybe it would.  But the text says "Reclaim modifiers" and then lists
one modifier and one mask.  That is confusing.
If you want to mention both, keep them separate.

  GFP_NOWAIT and GFP_ATOMIC are not supported, neither is the
  __GFP_NORETRY modifier.

or something like that.

Thanks,
NeilBrown


>=20
> > But I really cannot see why either of these statements are true.
>=20
> The reason is same as why vmalloc do not support neither of them.
>=20
> > Before your patch, __GFP_NORETRY would have forced use of kmalloc, so
> > that would mean it isn't really supported.  But that doesn't happen any m=
ore.
>=20
> __GFP_NORETRY is used internaly by kvmalloc but that doesn't mean it is
> supported by the caller. In fact __GFP_NORETRY is used to implement a
> higher level logic of the prioritization between kmalloc and vmalloc
> fallback because some users would rather see vmalloc fallback even for
> smaller allocations which do not really fail otherwise (e.g. < order-4).
> --=20
> Michal Hocko
> SUSE Labs
>=20
>=20
