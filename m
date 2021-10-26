Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000A943B064
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 12:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhJZKpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 06:45:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48706 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhJZKpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:45:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 840C31F770;
        Tue, 26 Oct 2021 10:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635245003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUWC6kRvFrBZ/khLHEZn47cIYMvYz0u1VgaJCPHSq0I=;
        b=yPn8McOOf5tamAdrJt8EEw9IK32OVCG2aiIjBzxckmGtZlQOtzeJ6UodKvNkrw0pipwxmG
        Ri1o4X9vbX6pQEtkXdwspJ2NOPM20oMxKbWbILyQqjf3ACqmsId/ihNKn2kCTwRxJrf5Xk
        xng+L5Bg2xiNkQb+9XyYDGrOqduoCB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635245003;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUWC6kRvFrBZ/khLHEZn47cIYMvYz0u1VgaJCPHSq0I=;
        b=OXoFuXs5TNC+z8W0lHHOg9lP5nbHQv6SjAkAPBrdsLVKQQ/ePJHenaqMoAVFUgmkDq6azi
        K48YgKsSy1OlHqBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A26E813D43;
        Tue, 26 Oct 2021 10:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Cb4vGMjbd2GBHAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 26 Oct 2021 10:43:20 +0000
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
Subject: Re: [PATCH 3/4] mm/vmalloc: be more explicit about supported gfp flags.
In-reply-to: <YXep1ctN1wPP+1a8@dhcp22.suse.cz>
References: <20211025150223.13621-1-mhocko@kernel.org>,
 <20211025150223.13621-4-mhocko@kernel.org>,
 <163520436674.16092.18372437960890952300@noble.neil.brown.name>,
 <YXep1ctN1wPP+1a8@dhcp22.suse.cz>
Date:   Tue, 26 Oct 2021 21:43:17 +1100
Message-id: <163524499768.8576.4634415079916744478@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Oct 2021, Michal Hocko wrote:
> On Tue 26-10-21 10:26:06, Neil Brown wrote:
> > On Tue, 26 Oct 2021, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > >=20
> > > The core of the vmalloc allocator __vmalloc_area_node doesn't say
> > > anything about gfp mask argument. Not all gfp flags are supported
> > > though. Be more explicit about constrains.
> > >=20
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > ---
> > >  mm/vmalloc.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 602649919a9d..2199d821c981 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2980,8 +2980,16 @@ static void *__vmalloc_area_node(struct vm_struc=
t *area, gfp_t gfp_mask,
> > >   * @caller:		  caller's return address
> > >   *
> > >   * Allocate enough pages to cover @size from the page level
> > > - * allocator with @gfp_mask flags.  Map them into contiguous
> > > - * kernel virtual space, using a pagetable protection of @prot.
> > > + * allocator with @gfp_mask flags. Please note that the full set of gfp
> > > + * flags are not supported. GFP_KERNEL would be a preferred allocation=
 mode
> > > + * but GFP_NOFS and GFP_NOIO are supported as well. Zone modifiers are=
 not
> >=20
> > In what sense is GFP_KERNEL "preferred"??
> > The choice of GFP_NOFS, when necessary, isn't based on preference but
> > on need.
> >=20
> > I understand that you would prefer no one ever used GFP_NOFs ever - just
> > use the scope API.  I even agree.  But this is not the place to make
> > that case.=20
>=20
> Any suggestion for a better wording?

 "GFP_KERNEL, GFP_NOFS, and GFP_NOIO are all supported".

>=20
> > > + * supported. From the reclaim modifiers__GFP_DIRECT_RECLAIM is requir=
ed (aka
> > > + * GFP_NOWAIT is not supported) and only __GFP_NOFAIL is supported (aka
> >=20
> > I don't think "aka" is the right thing to use here.  It is short for
> > "also known as" and there is nothing that is being known as something
> > else.
> > It would be appropriate to say (i.e. GFP_NOWAIT is not supported).
> > "i.e." is short for the Latin "id est" which means "that is" and
> > normally introduces an alternate description (whereas aka introduces an
> > alternate name).
>=20
> OK
> =20
> > > + * __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported).
> >=20
> > Why do you think __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported.
>=20
> Because they cannot be passed to the page table allocator. In both cases
> the allocation would fail when system is short on memory. GFP_KERNEL
> used for ptes implicitly doesn't behave that way.

Could you please point me to the particular allocation which uses
GFP_KERNEL rather than the flags passed to __vmalloc_node()?  I cannot
find it.

>=20
> >=20
> > > + * __GFP_NOWARN can be used to suppress error messages about failures.
> >=20
> > Surely "NOWARN" suppresses warning messages, not error messages ....
>=20
> I am not sure I follow. NOWARN means "do not warn" independently on the
> log level chosen for the message. Is an allocation failure an error
> message? Is the "vmalloc error: size %lu, failed to map pages" an error
> message?

If guess working with a C compiler has trained me to think that
"warnings" are different from "errors".

>=20
> Anyway I will go with "__GFP_NOWARN can be used to suppress failure message=
s"
>=20
> Is that better?

Yes, that's an excellent solution!  Thanks.

NeilBrown


> --=20
> Michal Hocko
> SUSE Labs
>=20
>=20
