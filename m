Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3031F6C80FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 16:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjCXPRW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 11:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCXPRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:17:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBE4131;
        Fri, 24 Mar 2023 08:17:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D912D1FEF6;
        Fri, 24 Mar 2023 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679671038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwervvL2VqoJp7Lysjwx0FFEhlsKTjSqVYYrPqe2D7Q=;
        b=TgmwsbLl+DA5Nt70AmZzlhUhFnz2I8NZtHoXA9KZt0n0xrFCGQ/YcA+FBZzx5Gd9YKiOCI
        bHaGK3KdSJtjWhbFYpt8xp9g3zTgsEdqgjVpEmsD/3IKuaTKEB23gX1Z7Zdt3DkXUwoRe5
        7mksq3ezMiaJva+j+TCZ+oYN/uUqCH0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BAF4138ED;
        Fri, 24 Mar 2023 15:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EG8sHf6+HWQUZwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 24 Mar 2023 15:17:18 +0000
Date:   Fri, 24 Mar 2023 16:17:17 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: page_owner: add support for splitting to any
 order in split page_owner.
Message-ID: <20230324151717.hawuy5gs6cnxql55@blackpad>
References: <20230321004829.2012847-1-zi.yan@sent.com>
 <20230321004829.2012847-3-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="exvxtogrhnfaw26c"
Content-Disposition: inline
In-Reply-To: <20230321004829.2012847-3-zi.yan@sent.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--exvxtogrhnfaw26c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, Mar 20, 2023 at 08:48:26PM -0400, Zi Yan <zi.yan@sent.com> wrote:
> @@ -5746,8 +5746,8 @@ static void *make_alloc_exact(unsigned long addr, u=
nsigned int order,
>  		struct page *page =3D virt_to_page((void *)addr);
>  		struct page *last =3D page + nr;
> =20
> -		split_page_owner(page, 1 << order);
> -		split_page_memcg(page, 1 << order);
> +		split_page_owner(page, 1 << order, 1);
> +		split_page_memcg(page, 1 << order, 1);

I think here should be

> +		split_page_owner(page, order, 0);
> +		split_page_memcg(page, 1 << order, 1);

because I was wondering why split_page_memcg() doesn't use orders too?
(E.g. it wouldn't work well if nr % new_new !=3D 0).

Thanks,
Michal

--exvxtogrhnfaw26c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZB2++wAKCRAkDQmsBEOq
uZYWAQCFTMigwoG6hG2bxKjAJtYDo8OWh0BZq1aPs9LM+QVdBwEAvayit0OXGxQ2
MDrtNVNB0nXobbi8EK0m4EAaSr9tCQA=
=FNxP
-----END PGP SIGNATURE-----

--exvxtogrhnfaw26c--
