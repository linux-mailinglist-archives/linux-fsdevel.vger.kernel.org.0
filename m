Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7041F628B54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 22:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiKNV1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 16:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbiKNV07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:26:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F3B18B2E;
        Mon, 14 Nov 2022 13:26:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A676B81250;
        Mon, 14 Nov 2022 21:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C699C433B5;
        Mon, 14 Nov 2022 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668461216;
        bh=aw6Eu94o9FzQ3heNKd/9r6U5egp9CZqfTQsCFBZLqC4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O9V4kZ18lZZo0cpS4m8+HUCNTCobNph0D2p407sYDNAT8AA/OFXvDP+LaG6S196VU
         69ME5/AKwmOeHzvVk/dGBNnxH+wlCdBJxbKryMcFk943QWxXmBjfLkReM9yR1+rYxW
         4m2qiBIg8K6lWs+idBzpJ2JsviKy/SxaSxR/CLNWQxZ2o94On6j5pnjuqA3UnpY4R/
         hrozSdH6Z8SfRq1B9RWygsyDPa5OfwNWJldvD1S4J9lCvwCur9ypnXGip46yf1qfNM
         p9qGi+0zFuzomtod56/SSdeeO4xLO5YkhNKvBg5vM0BTxz9dK3EuTnb5L0vkO/u+p6
         FlOpN3dIyTFmA==
Message-ID: <39851a8767b32c495c6b9146a601c37f28645466.camel@kernel.org>
Subject: Re: [Linux-cachefs] [PATCH v2 2/2] netfs: Fix dodgy maths
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 14 Nov 2022 16:26:54 -0500
In-Reply-To: <166757988611.950645.7626959069846893164.stgit@warthog.procyon.org.uk>
References: <166757987929.950645.12595273010425381286.stgit@warthog.procyon.org.uk>
         <166757988611.950645.7626959069846893164.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-11-04 at 16:38 +0000, David Howells wrote:
> Fix the dodgy maths in netfs_rreq_unlock_folios().  start_page could be
> inside the folio, in which case the calculation of pgpos will be come up
> with a negative number (though for the moment rreq->start is rounded down
> earlier and folios would have to get merged whilst locked)
>=20
> Alter how this works to just frame the tracking in terms of absolute file
> positions, rather than offsets from the start of the I/O request.  This
> simplifies the maths and makes it easier to follow.
>=20
> Fix the issue by using folio_pos() and folio_size() to calculate the end
> position of the page.
>=20
> Fixes: 3d3c95046742 ("netfs: Provide readahead and readpage netfs helpers=
")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/Y2SJw7w1IsIik3nb@casper.infradead.org/
> ---
>=20
>  fs/netfs/buffered_read.c |   17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index baf668fb4315..7679a68e8193 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -17,9 +17,9 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *=
rreq)
>  {
>  	struct netfs_io_subrequest *subreq;
>  	struct folio *folio;
> -	unsigned int iopos, account =3D 0;
>  	pgoff_t start_page =3D rreq->start / PAGE_SIZE;
>  	pgoff_t last_page =3D ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
> +	size_t account =3D 0;
>  	bool subreq_failed =3D false;
> =20
>  	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
> @@ -39,23 +39,23 @@ void netfs_rreq_unlock_folios(struct netfs_io_request=
 *rreq)
>  	 */
>  	subreq =3D list_first_entry(&rreq->subrequests,
>  				  struct netfs_io_subrequest, rreq_link);
> -	iopos =3D 0;
>  	subreq_failed =3D (subreq->error < 0);
> =20
>  	trace_netfs_rreq(rreq, netfs_rreq_trace_unlock);
> =20
>  	rcu_read_lock();
>  	xas_for_each(&xas, folio, last_page) {
> -		unsigned int pgpos, pgend;
> +		loff_t pg_end;
>  		bool pg_failed =3D false;
> =20
>  		if (xas_retry(&xas, folio))
>  			continue;
> =20
> -		pgpos =3D (folio_index(folio) - start_page) * PAGE_SIZE;
> -		pgend =3D pgpos + folio_size(folio);
> +		pg_end =3D folio_pos(folio) + folio_size(folio) - 1;
> =20
>  		for (;;) {
> +			loff_t sreq_end;
> +
>  			if (!subreq) {
>  				pg_failed =3D true;
>  				break;
> @@ -63,11 +63,11 @@ void netfs_rreq_unlock_folios(struct netfs_io_request=
 *rreq)
>  			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
>  				folio_start_fscache(folio);
>  			pg_failed |=3D subreq_failed;
> -			if (pgend < iopos + subreq->len)
> +			sreq_end =3D subreq->start + subreq->len - 1;
> +			if (pg_end < sreq_end)
>  				break;
> =20
>  			account +=3D subreq->transferred;
> -			iopos +=3D subreq->len;
>  			if (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
>  				subreq =3D list_next_entry(subreq, rreq_link);
>  				subreq_failed =3D (subreq->error < 0);
> @@ -75,7 +75,8 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *=
rreq)
>  				subreq =3D NULL;
>  				subreq_failed =3D false;
>  			}
> -			if (pgend =3D=3D iopos)
> +
> +			if (pg_end =3D=3D sreq_end)
>  				break;
>  		}
> =20
>=20
>=20
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
