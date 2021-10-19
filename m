Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757AC432B41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhJSAqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:46:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50482 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhJSAqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:46:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2DC8F1FD80;
        Tue, 19 Oct 2021 00:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634604250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7MDIVddTTR3Nn2OmbQgxanaSoSzcymYHoV7ZFfbLL0=;
        b=nsmdlgjtsikqzwRYRpA93ruXN5FVrH9vm4r0YkTS49qakVY+NA5qUC5BYQCCr4qaw2iFy3
        GF2EoGxULtbssiz6Vkb9gmPX5dkerB/ZjJt08i1uoE3w1lpdu8DpDICfRRgsctD/7W0E2j
        IMH3ydPdO2ZF6GCoE1eeUrAmrQRGBYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634604250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+7MDIVddTTR3Nn2OmbQgxanaSoSzcymYHoV7ZFfbLL0=;
        b=wPDgyK6vgSH0rWVje3Iv8x1uFmwkDPrXxSkl+b+PvZzB2BL7+BVCGTZ27jgAcRWVmv8CaJ
        QIAYwO+6p7yZUsBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3679213F09;
        Tue, 19 Oct 2021 00:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TU7wNNUUbmG3awAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 19 Oct 2021 00:44:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Michal Hocko" <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, "Dave Chinner" <david@fromorbit.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Michal Hocko" <mhocko@suse.com>
Subject: Re: [RFC 1/3] mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc
In-reply-to: <20211018114712.9802-2-mhocko@kernel.org>
References: <20211018114712.9802-1-mhocko@kernel.org>,
 <20211018114712.9802-2-mhocko@kernel.org>
Date:   Tue, 19 Oct 2021 11:44:01 +1100
Message-id: <163460424165.17149.585825289709126969@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Oct 2021, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>=20
> vmalloc historically hasn't supported GFP_NO{FS,IO} requests because
> page table allocations do not support externally provided gfp mask
> and performed GFP_KERNEL like allocations.
>=20
> Since few years we have scope (memalloc_no{fs,io}_{save,restore}) APIs
> to enforce NOFS and NOIO constrains implicitly to all allocators within
> the scope. There was a hope that those scopes would be defined on a
> higher level when the reclaim recursion boundary starts/stops (e.g. when
> a lock required during the memory reclaim is required etc.). It seems
> that not all NOFS/NOIO users have adopted this approach and instead
> they have taken a workaround approach to wrap a single [k]vmalloc
> allocation by a scope API.
>=20
> These workarounds do not serve the purpose of a better reclaim recursion
> documentation and reduction of explicit GFP_NO{FS,IO} usege so let's
> just provide them with the semantic they are asking for without a need
> for workarounds.
>=20
> Add support for GFP_NOFS and GFP_NOIO to vmalloc directly. All internal
> allocations already comply with the given gfp_mask. The only current
> exception is vmap_pages_range which maps kernel page tables. Infer the
> proper scope API based on the given gfp mask.
>=20
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmalloc.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d77830ff604c..7455c89598d3 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2889,6 +2889,8 @@ static void *__vmalloc_area_node(struct vm_struct *ar=
ea, gfp_t gfp_mask,
>  	unsigned long array_size;
>  	unsigned int nr_small_pages =3D size >> PAGE_SHIFT;
>  	unsigned int page_order;
> +	unsigned int flags;
> +	int ret;
> =20
>  	array_size =3D (unsigned long)nr_small_pages * sizeof(struct page *);
>  	gfp_mask |=3D __GFP_NOWARN;
> @@ -2930,8 +2932,24 @@ static void *__vmalloc_area_node(struct vm_struct *a=
rea, gfp_t gfp_mask,
>  		goto fail;
>  	}
> =20
> -	if (vmap_pages_range(addr, addr + size, prot, area->pages,
> -			page_shift) < 0) {
> +	/*
> +	 * page tables allocations ignore external gfp mask, enforce it
> +	 * by the scope API
> +	 */
> +	if ((gfp_mask & (__GFP_FS | __GFP_IO)) =3D=3D __GFP_IO)
> +		flags =3D memalloc_nofs_save();
> +	else if (!(gfp_mask & (__GFP_FS | __GFP_IO)))

I would *much* rather this were written

        else if ((gfp_mask & (__GFP_FS | __GFP_IO)) =3D=3D 0)

so that the comparison with the previous test is more obvious.  Ditto
for similar code below.
It could even be

   switch (gfp_mask & (__GFP_FS | __GFP_IO)) {
   case __GFP__IO: flags =3D memalloc_nofs_save(); break;
   case 0:         flags =3D memalloc_noio_save(); break;
   }

But I'm not completely convinced that is an improvement.

In terms of functionality this looks good.
Thanks,
NeilBrown


> +		flags =3D memalloc_noio_save();
> +
> +	ret =3D vmap_pages_range(addr, addr + size, prot, area->pages,
> +			page_shift);
> +
> +	if ((gfp_mask & (__GFP_FS | __GFP_IO)) =3D=3D __GFP_IO)
> +		memalloc_nofs_restore(flags);
> +	else if (!(gfp_mask & (__GFP_FS | __GFP_IO)))
> +		memalloc_noio_restore(flags);
> +
> +	if (ret < 0) {
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, failed to map pages",
>  			area->nr_pages * PAGE_SIZE);
> --=20
> 2.30.2
>=20
>=20
