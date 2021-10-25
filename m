Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4723A43A7F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 00:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhJYXCI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 19:02:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47448 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhJYXCH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:02:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 558C21FD33;
        Mon, 25 Oct 2021 22:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635202783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1cKWxIeUcucJel063hg8FOuYcQ7CNUDdSMhSQkwdb8=;
        b=JVBLNg/1G9y82k1V452mb4uLSeNfJrhV6/xpgVjF7hypt21RH8fU8ShHKRaYrFPPiemFXs
        ykUO0z1Omox6SM+yNDqgNkM3t7Hb1Nk6KEnZI9aR3njTBF0yF93Jw+p/hgi4/17wpP1Zsd
        Hsoz4oP6/smyyJslkGKL1YUXBeQMZpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635202783;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1cKWxIeUcucJel063hg8FOuYcQ7CNUDdSMhSQkwdb8=;
        b=gHKZ5JIItNsnUp4DTnmQiAtvuz4r8DzJ2mUSEAatnc5VU/t17ZsNedIvbLWz4lUNozMg8m
        9wJ75dOttNFUeFDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 201CC13CB7;
        Mon, 25 Oct 2021 22:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iiWRM9s2d2GHRgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 25 Oct 2021 22:59:39 +0000
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
Subject: Re: [PATCH 2/4] mm/vmalloc: add support for __GFP_NOFAIL
In-reply-to: <20211025150223.13621-3-mhocko@kernel.org>
References: <20211025150223.13621-1-mhocko@kernel.org>,
 <20211025150223.13621-3-mhocko@kernel.org>
Date:   Tue, 26 Oct 2021 09:59:36 +1100
Message-id: <163520277623.16092.15759069160856953654@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Oct 2021, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>=20
> Dave Chinner has mentioned that some of the xfs code would benefit from
> kvmalloc support for __GFP_NOFAIL because they have allocations that
> cannot fail and they do not fit into a single page.
>=20
> The larg part of the vmalloc implementation already complies with the

*large*

> given gfp flags so there is no work for those to be done. The area
> and page table allocations are an exception to that. Implement a retry
> loop for those.
>=20
> Add a short sleep before retrying. 1 jiffy is a completely random
> timeout. Ideally the retry would wait for an explicit event - e.g.
> a change to the vmalloc space change if the failure was caused by
> the space fragmentation or depletion. But there are multiple different
> reasons to retry and this could become much more complex. Keep the retry
> simple for now and just sleep to prevent from hogging CPUs.
>=20
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmalloc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c6cc77d2f366..602649919a9d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2941,8 +2941,12 @@ static void *__vmalloc_area_node(struct vm_struct *a=
rea, gfp_t gfp_mask,
>  	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) =3D=3D 0)
>  		flags =3D memalloc_noio_save();
> =20
> -	ret =3D vmap_pages_range(addr, addr + size, prot, area->pages,
> +	do {
> +		ret =3D vmap_pages_range(addr, addr + size, prot, area->pages,
>  			page_shift);
> +		if (ret < 0)
> +			schedule_timeout_uninterruptible(1);
> +	} while ((gfp_mask & __GFP_NOFAIL) && (ret < 0));
> =20
>  	if ((gfp_mask & (__GFP_FS | __GFP_IO)) =3D=3D __GFP_IO)
>  		memalloc_nofs_restore(flags);
> @@ -3032,6 +3036,10 @@ void *__vmalloc_node_range(unsigned long size, unsig=
ned long align,
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, vm_struct allocation failed",
>  			real_size);
> +		if (gfp_mask & __GFP_NOFAIL) {
> +			schedule_timeout_uninterruptible(1);
> +			goto again;
> +		}

Shouldn't the retry happen *before* the warning?

NeilBrown


>  		goto fail;
>  	}
> =20
> --=20
> 2.30.2
>=20
>=20
