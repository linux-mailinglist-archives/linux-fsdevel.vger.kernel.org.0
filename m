Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA9143A823
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 01:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhJYX2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 19:28:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56224 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhJYX2h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:28:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F358E218BB;
        Mon, 25 Oct 2021 23:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635204373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+IZGWtLl4OAI1X2s3DZ+k9SXIzlQxPOueBj83cICGg=;
        b=o46aXyIBvq04uicCYVfiWFAdkB0uSORlCyXssW87c2JNPnffaJXld9wNI+lwslecrRwTvd
        h2OrWNyuJ/hyY7Y9hfDLp7DvyFcMCxy75bIxnS9dnFoCOmKWYrMiBzAhYyatDOHRvNa8L8
        mPVcjeVNrBCspCBuelG+IGo7PXmhP9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635204373;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m+IZGWtLl4OAI1X2s3DZ+k9SXIzlQxPOueBj83cICGg=;
        b=yyFaepim+hepauLwuzIED+cuD/Vqwybq3vBfs1uaNBttaPuYfnkhsgceoVf7YCnLtzyQbk
        ss+OdnH9nO5reqBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D146D13B44;
        Mon, 25 Oct 2021 23:26:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 32KfIxE9d2GoTgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 25 Oct 2021 23:26:09 +0000
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
Subject: Re: [PATCH 3/4] mm/vmalloc: be more explicit about supported gfp flags.
In-reply-to: <20211025150223.13621-4-mhocko@kernel.org>
References: <20211025150223.13621-1-mhocko@kernel.org>,
 <20211025150223.13621-4-mhocko@kernel.org>
Date:   Tue, 26 Oct 2021 10:26:06 +1100
Message-id: <163520436674.16092.18372437960890952300@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 26 Oct 2021, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>=20
> The core of the vmalloc allocator __vmalloc_area_node doesn't say
> anything about gfp mask argument. Not all gfp flags are supported
> though. Be more explicit about constrains.
>=20
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/vmalloc.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 602649919a9d..2199d821c981 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2980,8 +2980,16 @@ static void *__vmalloc_area_node(struct vm_struct *a=
rea, gfp_t gfp_mask,
>   * @caller:		  caller's return address
>   *
>   * Allocate enough pages to cover @size from the page level
> - * allocator with @gfp_mask flags.  Map them into contiguous
> - * kernel virtual space, using a pagetable protection of @prot.
> + * allocator with @gfp_mask flags. Please note that the full set of gfp
> + * flags are not supported. GFP_KERNEL would be a preferred allocation mode
> + * but GFP_NOFS and GFP_NOIO are supported as well. Zone modifiers are not

In what sense is GFP_KERNEL "preferred"??
The choice of GFP_NOFS, when necessary, isn't based on preference but
on need.

I understand that you would prefer no one ever used GFP_NOFs ever - just
use the scope API.  I even agree.  But this is not the place to make
that case.=20

> + * supported. From the reclaim modifiers__GFP_DIRECT_RECLAIM is required (=
aka
> + * GFP_NOWAIT is not supported) and only __GFP_NOFAIL is supported (aka

I don't think "aka" is the right thing to use here.  It is short for
"also known as" and there is nothing that is being known as something
else.
It would be appropriate to say (i.e. GFP_NOWAIT is not supported).
"i.e." is short for the Latin "id est" which means "that is" and
normally introduces an alternate description (whereas aka introduces an
alternate name).


> + * __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported).

Why do you think __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported.

> + * __GFP_NOWARN can be used to suppress error messages about failures.

Surely "NOWARN" suppresses warning messages, not error messages ....

Thanks,
NeilBrown


> + *=20
> + * Map them into contiguous kernel virtual space, using a pagetable
> + * protection of @prot.
>   *
>   * Return: the address of the area or %NULL on failure
>   */
> --=20
> 2.30.2
>=20
>=20
