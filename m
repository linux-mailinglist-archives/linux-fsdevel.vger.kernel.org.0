Return-Path: <linux-fsdevel+bounces-42284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC5AA3FDA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 18:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB40164313
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE947250BFA;
	Fri, 21 Feb 2025 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PEwpl9Gw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC81CEACB;
	Fri, 21 Feb 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159654; cv=none; b=dJgNBM118CK6QasQR2B+B7uA+SiS6cNsFCgIhNJlmBl4cS2I37nFiQdnUhqkqIQO/yJQGjMXEIYySc3cpWIgk0CzGdxXlLf6rdLIPvOpcn0GFmJaCTXvne0xWG4JShlKUS/uB+aRl8eitARYnVHRNfLsXdNRJ3BDtIfdJb+5FwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159654; c=relaxed/simple;
	bh=0KVGQtUJupg5iG64wesQGLbyGFQHr7S30VQSzvx3D24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t5k04m2wJQZ0e1Bpdk5ggxI03RXdsIcKMnqDPW3QJRQLLJF/2+BYclS2QvRzvmjAgVPT1Oz3Jvnk/NrFdusT3KieYlGtpkMNyuSk3Kwu6JQZtCWFNYFD7hg/2YeJ/Sx0guggmexmo0K/gKNfRwwWH7ei/Z5pyp7il3DQsCIbb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PEwpl9Gw; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LqtyheHGLjlz2EPDUM42+j8ZzSm0QKQ0xbER1KmW6RU=; b=PEwpl9Gw86fh1AFNDtEM8YI+Nz
	32VghDCY6PNdaQfa5f6FprPsO/ZkkrQpvf2EhoDqjb7oxECVf8MQNP8LclcNgoZJhgq/yKwAjoYAi
	CLD56vgO3FHGKQPKc5mh3XXchrgrMxs03Y4RBaQaoxYbsESMG17AWgUEm/HXxQOk3wNbhTWpIQAZx
	XasMVioddwCTYu4/lRe1O6KUWLqqs4ySmURAwXxLreRJCLIP6+OJ4ljBCS8XrmeVKSs8R5GJ2WCj7
	f/OTimFUc/Hb3GfHhd5r7fNh6OKO/W7bXJx/pu8ZPX0RH3iBpuWiPO1OlvUQDMaJG7mlIMTVHDNSR
	dx2FZ20Q==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tlX0s-00GCc6-DG; Fri, 21 Feb 2025 18:40:40 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Bernd
 Schubert <bernd@bsbernd.com>,  Teng Qin <tqin@jumptrading.com>,
    Matt Harvey <mharvey@jumptrading.com>
Subject: Re: [RFC PATCH v2] fuse: fix race in fuse_notify_store()
In-Reply-To: <20250130101607.21756-1-luis@igalia.com> (Luis Henriques's
	message of "Thu, 30 Jan 2025 10:16:07 +0000")
References: <20250130101607.21756-1-luis@igalia.com>
Date: Fri, 21 Feb 2025 17:40:39 +0000
Message-ID: <87eczrgprc.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30 2025, Luis Henriques wrote:

> Userspace filesystems can push data for a specific inode without it being
> explicitly requested.  This can be accomplished by using NOTIFY_STORE.
> However, this may race against another process performing different
> operations on the same inode.
>
> If, for example, there is a process reading from it, it may happen that it
> will block waiting for data to be available (locking the folio), while the
> FUSE server will also block trying to lock the same folio to update it wi=
th
> the inode data.
>
> The easiest solution, as suggested by Miklos, is to allow the userspace
> filesystem to skip locked folios.
>
> Link: https://lore.kernel.org/CH2PR14MB41040692ABC50334F500789ED6C89@CH2P=
R14MB4104.namprd14.prod.outlook.com
> Reported-by: Teng Qin <tqin@jumptrading.com>
> Originally-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
> Hi!
>
> Here's v2.  Other than fixing the bug pointed out by Bernd (thanks!), I've
> also added an explanation to the 'XXX' comment.  As a matter of fact, I've
> took another look at that code, and I felt compelled to remove that comme=
nt,
> as using PAGE_SIZE seems to be the right thing.
>
> Anyway, I'm still thinking that probably NOTIFY_STORE should *always* have
> this behaviour, without the need for userspace to explicitly setting a fl=
ag.

Gentle ping.  I was wondering if you have any thoughts on this patch.
Specially regarding the behaviour change I'm suggesting above.

(Also, as I've mentioned before, I'm using the 'Originally-by' tag; not
sure this is the right thing to do.  Obviously, I'm fine dropping my
s-o-b, as I'm not the original author.)

Cheers,
--=20
Lu=C3=ADs


> Changes since v1:
> - Only skip if __filemap_get_folio() returns -EAGAIN (Bernd)
>
>  fs/fuse/dev.c             | 30 +++++++++++++++++++++++-------
>  include/uapi/linux/fuse.h |  8 +++++++-
>  2 files changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 27ccae63495d..309651f82ca4 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1630,6 +1630,7 @@ static int fuse_notify_store(struct fuse_conn *fc, =
unsigned int size,
>  	unsigned int num;
>  	loff_t file_size;
>  	loff_t end;
> +	int fgp_flags =3D FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
>=20=20
>  	err =3D -EINVAL;
>  	if (size < sizeof(outarg))
> @@ -1645,6 +1646,9 @@ static int fuse_notify_store(struct fuse_conn *fc, =
unsigned int size,
>=20=20
>  	nodeid =3D outarg.nodeid;
>=20=20
> +	if (outarg.flags & FUSE_NOTIFY_STORE_NOWAIT)
> +		fgp_flags |=3D FGP_NOWAIT;
> +
>  	down_read(&fc->killsb);
>=20=20
>  	err =3D -ENOENT;
> @@ -1668,14 +1672,26 @@ static int fuse_notify_store(struct fuse_conn *fc=
, unsigned int size,
>  		struct page *page;
>  		unsigned int this_num;
>=20=20
> -		folio =3D filemap_grab_folio(mapping, index);
> -		err =3D PTR_ERR(folio);
> -		if (IS_ERR(folio))
> -			goto out_iput;
> +		folio =3D __filemap_get_folio(mapping, index, fgp_flags,
> +					    mapping_gfp_mask(mapping));
> +		err =3D PTR_ERR_OR_ZERO(folio);
> +		if (err) {
> +			if (!(outarg.flags & FUSE_NOTIFY_STORE_NOWAIT) ||
> +			    (err !=3D -EAGAIN))
> +				goto out_iput;
> +			page =3D NULL;
> +			/* XXX is it OK to use PAGE_SIZE here? */
> +			this_num =3D min_t(unsigned int, num, PAGE_SIZE - offset);
> +		} else {
> +			page =3D &folio->page;
> +			this_num =3D min_t(unsigned int, num,
> +					 folio_size(folio) - offset);
> +		}
>=20=20
> -		page =3D &folio->page;
> -		this_num =3D min_t(unsigned, num, folio_size(folio) - offset);
>  		err =3D fuse_copy_page(cs, &page, offset, this_num, 0);
> +		if (!page)
> +			goto skip;
> +
>  		if (!folio_test_uptodate(folio) && !err && offset =3D=3D 0 &&
>  		    (this_num =3D=3D folio_size(folio) || file_size =3D=3D end)) {
>  			folio_zero_segment(folio, this_num, folio_size(folio));
> @@ -1683,7 +1699,7 @@ static int fuse_notify_store(struct fuse_conn *fc, =
unsigned int size,
>  		}
>  		folio_unlock(folio);
>  		folio_put(folio);
> -
> +skip:
>  		if (err)
>  			goto out_iput;
>=20=20
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index e9e78292d107..59725f89340e 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -576,6 +576,12 @@ struct fuse_file_lock {
>   */
>  #define FUSE_EXPIRE_ONLY		(1 << 0)
>=20=20
> +/**
> + * notify_store flags
> + * FUSE_NOTIFY_STORE_NOWAIT: skip locked pages
> + */
> +#define FUSE_NOTIFY_STORE_NOWAIT	(1 << 0)
> +
>  /**
>   * extension type
>   * FUSE_MAX_NR_SECCTX: maximum value of &fuse_secctx_header.nr_secctx
> @@ -1075,7 +1081,7 @@ struct fuse_notify_store_out {
>  	uint64_t	nodeid;
>  	uint64_t	offset;
>  	uint32_t	size;
> -	uint32_t	padding;
> +	uint32_t	flags;
>  };
>=20=20
>  struct fuse_notify_retrieve_out {


