Return-Path: <linux-fsdevel+bounces-24445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10B093F5F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 14:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262D7B233F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C5B149C78;
	Mon, 29 Jul 2024 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6UmZnse"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3148148826;
	Mon, 29 Jul 2024 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257797; cv=none; b=PykRiMcFCH3E6SeErfZtSCVAIYQgTKWuKBpHYqassUIz5wHK+1CgMRYw+7Kc0Kh1IzebnXs95nePrO1zQBujjVzIuD7owubNzuC5wQnhFS5HVNuCRYQUR0/kjWHdL4DeDsjZpBUfIul8uhTIuxmDlhOcanW3aNXlKnNvvedBNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257797; c=relaxed/simple;
	bh=EFxAYFwmzKy4wKIyTLivCBfzm2/dqZDDCKA7xmh5fSc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OS/qt6CoJNkKPznOaO5jZYzC4MLIWqFgawgvi2haerEkx3F0m59jrjs2L/Pr5bERamLf+0CIxtY0oGPOegk3ok/U3v5yzRYIaHVaBOzCGpFRcbkzDoVEocvdeHGzqS6HgdhBqapBi2L8dhyFLSPVa9QrG0LUa5Ok3sL4oTE4oZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6UmZnse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23ADC32786;
	Mon, 29 Jul 2024 12:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722257796;
	bh=EFxAYFwmzKy4wKIyTLivCBfzm2/dqZDDCKA7xmh5fSc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=s6UmZnseImCkerW7hLd8ipbWBT07nhG1c5+VZfVtIb/SIkICLu2jk4ImMj+g4bf75
	 Ifj8Lv3T+p54Bdn7X3eyFDNBoL224ELNvct6FgCSUHRrdK6qwMMyt7rPK4nuhunVSn
	 yukd2X5fpwFJrQr0nKv6Woy48HaaFNyoZn/L/ZpDzZj7RmuuCX6py35Nl23hkjlJcH
	 nUeIDk9aC/bRYJDKOu5wEc/EBqmyTbsMlMWppHc1eamfgJd46HR2zdyXNo6sEuD5Ar
	 b3Qj669X1OBezCW3iQBIYlasTnWLlw2+bDLNA37stvlvIVsQtjZ39C06JhyZ3yPe2q
	 28h6ODWyVx5JA==
Message-ID: <d03ba5c264de1d3601853d91810108d9897661fb.camel@kernel.org>
Subject: Re: [PATCH] fs/netfs/fscache_io: remove the obsolete
 "using_pgpriv2" flag
From: Jeff Layton <jlayton@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>, dhowells@redhat.com
Cc: willy@infradead.org, linux-cachefs@redhat.com, 
 linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, xiubli@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 29 Jul 2024 08:56:34 -0400
In-Reply-To: <20240729091532.855688-1-max.kellermann@ionos.com>
References: <20240729091532.855688-1-max.kellermann@ionos.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-29 at 11:15 +0200, Max Kellermann wrote:
> This fixes a crash bug caused by commit ae678317b95e ("netfs: Remove
> deprecated use of PG_private_2 as a second writeback flag") by
> removing a leftover folio_end_private_2() call after all calls to
> folio_start_private_2() had been removed by the commit.
>=20
> By calling folio_end_private_2() without folio_start_private_2(), the
> folio refcounter breaks and causes trouble like RCU stalls and general
> protection faults.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Fixes: ae678317b95e ("netfs: Remove deprecated use of PG_private_2 as a s=
econd writeback flag")
> Link: https://lore.kernel.org/ceph-devel/CAKPOu+_DA8XiMAA2ApMj7Pyshve_YWk=
nw8Hdt1=3DzCy9Y87R1qw@mail.gmail.com/
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> =C2=A0fs/ceph/addr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +-
> =C2=A0fs/netfs/fscache_io.c=C2=A0=C2=A0 | 29 +---------------------------=
-
> =C2=A0include/linux/fscache.h | 30 ++++--------------------------
> =C2=A03 files changed, 6 insertions(+), 55 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 8c16bc5250ef..485cbd1730d1 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -512,7 +512,7 @@ static void ceph_fscache_write_to_cache(struct inode =
*inode, u64 off, u64 len, b
> =C2=A0	struct fscache_cookie *cookie =3D ceph_fscache_cookie(ci);
> =C2=A0
> =C2=A0	fscache_write_to_cache(cookie, inode->i_mapping, off, len, i_size_=
read(inode),
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_fscache_write_terminated, i=
node, true, caching);
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_fscache_write_terminated, i=
node, caching);
> =C2=A0}
> =C2=A0#else
> =C2=A0static inline void ceph_fscache_write_to_cache(struct inode *inode,=
 u64 off, u64 len, bool caching)
> diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
> index 38637e5c9b57..0d8f3f646598 100644
> --- a/fs/netfs/fscache_io.c
> +++ b/fs/netfs/fscache_io.c
> @@ -166,30 +166,10 @@ struct fscache_write_request {
> =C2=A0	loff_t			start;
> =C2=A0	size_t			len;
> =C2=A0	bool			set_bits;
> -	bool			using_pgpriv2;
> =C2=A0	netfs_io_terminated_t	term_func;
> =C2=A0	void			*term_func_priv;
> =C2=A0};
> =C2=A0
> -void __fscache_clear_page_bits(struct address_space *mapping,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loff_t start, size_t len)
> -{
> -	pgoff_t first =3D start / PAGE_SIZE;
> -	pgoff_t last =3D (start + len - 1) / PAGE_SIZE;
> -	struct page *page;
> -
> -	if (len) {
> -		XA_STATE(xas, &mapping->i_pages, first);
> -
> -		rcu_read_lock();
> -		xas_for_each(&xas, page, last) {
> -			folio_end_private_2(page_folio(page));
> -		}
> -		rcu_read_unlock();
> -	}
> -}
> -EXPORT_SYMBOL(__fscache_clear_page_bits);
> -
> =C2=A0/*
> =C2=A0 * Deal with the completion of writing the data to the cache.
> =C2=A0 */
> @@ -198,10 +178,6 @@ static void fscache_wreq_done(void *priv, ssize_t tr=
ansferred_or_error,
> =C2=A0{
> =C2=A0	struct fscache_write_request *wreq =3D priv;
> =C2=A0
> -	if (wreq->using_pgpriv2)
> -		fscache_clear_page_bits(wreq->mapping, wreq->start, wreq->len,
> -					wreq->set_bits);
> -
> =C2=A0	if (wreq->term_func)
> =C2=A0		wreq->term_func(wreq->term_func_priv, transferred_or_error,
> =C2=A0				was_async);
> @@ -214,7 +190,7 @@ void __fscache_write_to_cache(struct fscache_cookie *=
cookie,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loff_t start, size_t len, loff_t =
i_size,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netfs_io_terminated_t term_func,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *term_func_priv,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool using_pgpriv2, bool cond)
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool cond)
> =C2=A0{
> =C2=A0	struct fscache_write_request *wreq;
> =C2=A0	struct netfs_cache_resources *cres;
> @@ -232,7 +208,6 @@ void __fscache_write_to_cache(struct fscache_cookie *=
cookie,
> =C2=A0	wreq->mapping		=3D mapping;
> =C2=A0	wreq->start		=3D start;
> =C2=A0	wreq->len		=3D len;
> -	wreq->using_pgpriv2	=3D using_pgpriv2;
> =C2=A0	wreq->set_bits		=3D cond;
> =C2=A0	wreq->term_func		=3D term_func;
> =C2=A0	wreq->term_func_priv	=3D term_func_priv;
> @@ -260,8 +235,6 @@ void __fscache_write_to_cache(struct fscache_cookie *=
cookie,
> =C2=A0abandon_free:
> =C2=A0	kfree(wreq);
> =C2=A0abandon:
> -	if (using_pgpriv2)
> -		fscache_clear_page_bits(mapping, start, len, cond);
> =C2=A0	if (term_func)
> =C2=A0		term_func(term_func_priv, ret, false);
> =C2=A0}
> diff --git a/include/linux/fscache.h b/include/linux/fscache.h
> index 9de27643607f..f8c52bddaa15 100644
> --- a/include/linux/fscache.h
> +++ b/include/linux/fscache.h
> @@ -177,8 +177,7 @@ void __fscache_write_to_cache(struct fscache_cookie *=
cookie,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loff_t start, size_t len, loff_t =
i_size,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netfs_io_terminated_t term_func,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *term_func_priv,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool using_pgpriv2, bool cond);
> -extern void __fscache_clear_page_bits(struct address_space *, loff_t, si=
ze_t);
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool cond);
> =C2=A0
> =C2=A0/**
> =C2=A0 * fscache_acquire_volume - Register a volume as desiring caching s=
ervices
> @@ -573,24 +572,6 @@ int fscache_write(struct netfs_cache_resources *cres=
,
> =C2=A0	return ops->write(cres, start_pos, iter, term_func, term_func_priv=
);
> =C2=A0}
> =C2=A0
> -/**
> - * fscache_clear_page_bits - Clear the PG_fscache bits from a set of pag=
es
> - * @mapping: The netfs inode to use as the source
> - * @start: The start position in @mapping
> - * @len: The amount of data to unlock
> - * @caching: If PG_fscache has been set
> - *
> - * Clear the PG_fscache flag from a sequence of pages and wake up anyone=
 who's
> - * waiting.
> - */
> -static inline void fscache_clear_page_bits(struct address_space *mapping=
,
> -					=C2=A0=C2=A0 loff_t start, size_t len,
> -					=C2=A0=C2=A0 bool caching)
> -{
> -	if (caching)
> -		__fscache_clear_page_bits(mapping, start, len);
> -}
> -
> =C2=A0/**
> =C2=A0 * fscache_write_to_cache - Save a write to the cache and clear PG_=
fscache
> =C2=A0 * @cookie: The cookie representing the cache object
> @@ -600,7 +581,6 @@ static inline void fscache_clear_page_bits(struct add=
ress_space *mapping,
> =C2=A0 * @i_size: The new size of the inode
> =C2=A0 * @term_func: The function to call upon completion
> =C2=A0 * @term_func_priv: The private data for @term_func
> - * @using_pgpriv2: If we're using PG_private_2 to mark in-progress write
> =C2=A0 * @caching: If we actually want to do the caching
> =C2=A0 *
> =C2=A0 * Helper function for a netfs to write dirty data from an inode in=
to the cache
> @@ -612,21 +592,19 @@ static inline void fscache_clear_page_bits(struct a=
ddress_space *mapping,
> =C2=A0 * marked with PG_fscache.
> =C2=A0 *
> =C2=A0 * If given, @term_func will be called upon completion and supplied=
 with
> - * @term_func_priv.=C2=A0 Note that if @using_pgpriv2 is set, the PG_pri=
vate_2 flags
> - * will have been cleared by this point, so the netfs must retain its ow=
n pin
> - * on the mapping.
> + * @term_func_priv.
> =C2=A0 */
> =C2=A0static inline void fscache_write_to_cache(struct fscache_cookie *co=
okie,
> =C2=A0					=C2=A0 struct address_space *mapping,
> =C2=A0					=C2=A0 loff_t start, size_t len, loff_t i_size,
> =C2=A0					=C2=A0 netfs_io_terminated_t term_func,
> =C2=A0					=C2=A0 void *term_func_priv,
> -					=C2=A0 bool using_pgpriv2, bool caching)
> +					=C2=A0 bool caching)
> =C2=A0{
> =C2=A0	if (caching)
> =C2=A0		__fscache_write_to_cache(cookie, mapping, start, len, i_size,
> =C2=A0					 term_func, term_func_priv,
> -					 using_pgpriv2, caching);
> +					 caching);
> =C2=A0	else if (term_func)
> =C2=A0		term_func(term_func_priv, -ENOBUFS, false);
> =C2=A0


(cc'ing the cephfs maintainers too)

Nice work! I'd prefer this patch over the first one. It looks like the
Fixes: commit went into v6.10. Did it go into earlier kernels too?

If so, what might be best is to take both of your patches. Have the
simple one first that just flips the flag, and mark that one for
stable. Then we can add the second patch on top to remove all of this
stuff for mainline.

Either way, you can add this to both patches:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

