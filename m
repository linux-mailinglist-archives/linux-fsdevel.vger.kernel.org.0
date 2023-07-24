Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598CE75F5E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 14:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGXMQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 08:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGXMQD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:16:03 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D4E6D;
        Mon, 24 Jul 2023 05:15:37 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tmb.nu;
        s=protonmail; t=1690200927; x=1690460127;
        bh=xGE6QjHm3ej4AxAX+5EXNKI8Zly3g7JGtmwu3HuYvhg=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=TZIQN1Xh+XdlLYOxt0udbKtWWMD3wL/AZ82adZufAkHSESK0ulr1Ld0VhavgA+fhG
         fpqAmGis3d8uxiftYfSDBGI4vUr1mPrEHSrzJUIyQwCnZgm0YNy76Tje7fsRqomibM
         uHnIWGMjv9CmjOouHdW6z0ayVwmaCUXnETfPaZuA=
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
From:   Thomas Backlund <tmb@tmb.nu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] Revert "page cache: fix page_cache_next/prev_miss off by one"
Message-ID: <bf744801-96a1-bdf1-79b5-5e8a21c05be3@tmb.nu>
Feedback-ID: 19711308:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Den 2023-06-22 kl. 00:24, skrev Mike Kravetz:
> This reverts commit 9425c591e06a9ab27a145ba655fb50532cf0bcc9
>=20
> The reverted commit fixed up routines primarily used by readahead code
> such that they could also be used by hugetlb.  Unfortunately, this
> caused a performance regression as pointed out by the Closes: tag.
>=20
> The hugetlb code which uses page_cache_next_miss will be addressed in
> a subsequent patch.
>=20
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202306211346.1e9ff03e-oliver.sang@=
intel.com
> Fixes: 9425c591e06a ("page cache: fix page_cache_next/prev_miss off by on=
e")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>


Should not this one be submitted to 6.4 stable branch too ?


git describe --contains 9425c591e06a
v6.4-rc7~29^2~1

The other one (hugetlb: revert use of page_cache_next_miss()) of this=20
patch series landed in 6.4.2

Or am I missing something ?

--
Thomas

> ---
>   mm/filemap.c | 26 ++++++++++----------------
>   1 file changed, 10 insertions(+), 16 deletions(-)
>=20
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 3b73101f9f86..9e44a49bbd74 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1728,9 +1728,7 @@ bool __folio_lock_or_retry(struct folio *folio, str=
uct mm_struct *mm,
>    *
>    * Return: The index of the gap if found, otherwise an index outside th=
e
>    * range specified (in which case 'return - index >=3D max_scan' will b=
e true).
> - * In the rare case of index wrap-around, 0 will be returned.  0 will al=
so
> - * be returned if index =3D=3D 0 and there is a gap at the index.  We ca=
n not
> - * wrap-around if passed index =3D=3D 0.
> + * In the rare case of index wrap-around, 0 will be returned.
>    */
>   pgoff_t page_cache_next_miss(struct address_space *mapping,
>   =09=09=09     pgoff_t index, unsigned long max_scan)
> @@ -1740,13 +1738,12 @@ pgoff_t page_cache_next_miss(struct address_space=
 *mapping,
>   =09while (max_scan--) {
>   =09=09void *entry =3D xas_next(&xas);
>   =09=09if (!entry || xa_is_value(entry))
> -=09=09=09return xas.xa_index;
> -=09=09if (xas.xa_index =3D=3D 0 && index !=3D 0)
> -=09=09=09return xas.xa_index;
> +=09=09=09break;
> +=09=09if (xas.xa_index =3D=3D 0)
> +=09=09=09break;
>   =09}
>  =20
> -=09/* No gaps in range and no wrap-around, return index beyond range */
> -=09return xas.xa_index + 1;
> +=09return xas.xa_index;
>   }
>   EXPORT_SYMBOL(page_cache_next_miss);
>  =20
> @@ -1767,9 +1764,7 @@ EXPORT_SYMBOL(page_cache_next_miss);
>    *
>    * Return: The index of the gap if found, otherwise an index outside th=
e
>    * range specified (in which case 'index - return >=3D max_scan' will b=
e true).
> - * In the rare case of wrap-around, ULONG_MAX will be returned.  ULONG_M=
AX
> - * will also be returned if index =3D=3D ULONG_MAX and there is a gap at=
 the
> - * index.  We can not wrap-around if passed index =3D=3D ULONG_MAX.
> + * In the rare case of wrap-around, ULONG_MAX will be returned.
>    */
>   pgoff_t page_cache_prev_miss(struct address_space *mapping,
>   =09=09=09     pgoff_t index, unsigned long max_scan)
> @@ -1779,13 +1774,12 @@ pgoff_t page_cache_prev_miss(struct address_space=
 *mapping,
>   =09while (max_scan--) {
>   =09=09void *entry =3D xas_prev(&xas);
>   =09=09if (!entry || xa_is_value(entry))
> -=09=09=09return xas.xa_index;
> -=09=09if (xas.xa_index =3D=3D ULONG_MAX && index !=3D ULONG_MAX)
> -=09=09=09return xas.xa_index;
> +=09=09=09break;
> +=09=09if (xas.xa_index =3D=3D ULONG_MAX)
> +=09=09=09break;
>   =09}
>  =20
> -=09/* No gaps in range and no wrap-around, return index beyond range */
> -=09return xas.xa_index - 1;
> +=09return xas.xa_index;
>   }
>   EXPORT_SYMBOL(page_cache_prev_miss);
>  =20


