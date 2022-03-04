Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB714CCBB5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 03:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbiCDCYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 21:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiCDCYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:24:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3668565820;
        Thu,  3 Mar 2022 18:23:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 977441F382;
        Fri,  4 Mar 2022 02:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646360604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E85sAoXCaTA9rJMXOcKl8Th+xCpRXA0b8EAqZxwZ8A0=;
        b=OHMBIepyGZT5p2vUzh9m6EF2ADllsCUvjfoI6pTTrXo7Yz0B7BDN+ge9IdtF+2ZYydZGCQ
        8WoB5pAABgNBYEPVBbEaEnFFjU93OJpcylm9mmoQGVwXSBRAGZ9mDxUgC5aU5qlMH9Ckr8
        8JdQlmMLB5FGrAN6piwNc9Z7wosEfx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646360604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E85sAoXCaTA9rJMXOcKl8Th+xCpRXA0b8EAqZxwZ8A0=;
        b=gt1xKH0idJAvV5toxul/AJtWemJaGkXOxCg34os0vjwsTU/KiA45a4f222DhjpE4Y5De+j
        w3347cZDZ/LwPhDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CAE41340A;
        Fri,  4 Mar 2022 02:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wj8UEhV4IWIXewAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 04 Mar 2022 02:23:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Jan Kara" <jack@suse.cz>, "Wu Fengguang" <fengguang.wu@intel.com>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Philipp Reisner" <philipp.reisner@linbit.com>,
        "Lars Ellenberg" <lars.ellenberg@linbit.com>,
        "Paolo Valente" <paolo.valente@linaro.org>,
        "Jens Axboe" <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        "linux-mm" <linux-mm@kvack.org>, linux-nilfs@vger.kernel.org,
        "Linux NFS list" <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        "Ext4" <linux-ext4@vger.kernel.org>, ceph-devel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] MM: improve cleanup when ->readpages doesn't
 process all pages.
In-reply-to: <CAJfpegs=DhCO62EFV0Q_i2fmqJnziJy1t4itP9deS=FuWEA=TQ@mail.gmail.com>
References: <164549971112.9187.16871723439770288255.stgit@noble.brown>,
 <164549983736.9187.16755913785880819183.stgit@noble.brown>,
 <CAJfpegs=DhCO62EFV0Q_i2fmqJnziJy1t4itP9deS=FuWEA=TQ@mail.gmail.com>
Date:   Fri, 04 Mar 2022 13:23:14 +1100
Message-id: <164636059432.13165.6442580674358743838@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 02 Mar 2022, Miklos Szeredi wrote:
> On Tue, 22 Feb 2022 at 04:18, NeilBrown <neilb@suse.de> wrote:
> >
> > If ->readpages doesn't process all the pages, then it is best to act as
> > though they weren't requested so that a subsequent readahead can try
> > again.
> > So:
> >   - remove any 'ahead' pages from the page cache so they can be loaded
> >     with ->readahead() rather then multiple ->read()s
> >   - update the file_ra_state to reflect the reads that were actually
> >     submitted.
> >
> > This allows ->readpages() to abort early due e.g.  to congestion, which
> > will then allow us to remove the inode_read_congested() test from
> > page_Cache_async_ra().
> >
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  mm/readahead.c |   19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index 73b2bc5302e0..8a97bd408cf6 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -104,7 +104,13 @@
> >   * for necessary resources (e.g.  memory or indexing information) to
> >   * become available.  Pages in the final ``async_size`` may be
> >   * considered less urgent and failure to read them is more acceptable.
> > - * They will eventually be read individually using ->readpage().
> > + * In this case it is best to use delete_from_page_cache() to remove the
> > + * pages from the page cache as is automatically done for pages that
> > + * were not fetched with readahead_page().  This will allow a
> > + * subsequent synchronous read ahead request to try them again.  If they
> > + * are left in the page cache, then they will be read individually using
> > + * ->readpage().
> > + *
> >   */
> >
> >  #include <linux/kernel.h>
> > @@ -226,8 +232,17 @@ static void read_pages(struct readahead_control *rac=
, struct list_head *pages,
> >
> >         if (aops->readahead) {
> >                 aops->readahead(rac);
> > -               /* Clean up the remaining pages */
> > +               /*
> > +                * Clean up the remaining pages.  The sizes in ->ra
> > +                * maybe be used to size next read-ahead, so make sure
> > +                * they accurately reflect what happened.
> > +                */
> >                 while ((page =3D readahead_page(rac))) {
> > +                       rac->ra->size -=3D 1;
> > +                       if (rac->ra->async_size > 0) {
> > +                               rac->ra->async_size -=3D 1;
> > +                               delete_from_page_cache(page);
> > +                       }
>=20
> Does the  above imply that filesystem should submit at least ra->size
> pages, regardless of congestion?

   ra->size - ra_async_size=20
pages should be submitted reguardless of congestion.

NeilBrown

