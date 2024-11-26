Return-Path: <linux-fsdevel+bounces-35915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D168D9D9A19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 16:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF84B281A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5FD1D61B7;
	Tue, 26 Nov 2024 15:01:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from granite.fifsource.com (granite.fifsource.com [173.255.216.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D0282F4;
	Tue, 26 Nov 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.216.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633272; cv=none; b=glYEsvRT36eSros9KxxMsBF5JV6OC2KrgpwOUOjEcAgBs1J58sKQ3I4ONKehw0JfA4Di+1egPMW9GbGgLlIGIt+wbR+jKWe72/TR14aay6BAcwRaN9LF4lIE3vDm9EJLWHzFNLSUJuUdeBr9YQFVdTkntzoMlh3q8c+sqiqKw28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633272; c=relaxed/simple;
	bh=kYyB5DWRi6Rm6kbl+1OO96qkkjtKlDwr6cyUcun9jfo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GGdXfTKU3U6lxa5d1h2UAMSaHQiqTUjYtod8MpH2RXhnJvLfPE9wp9rw/62qbMNsorTaH4xK9muzEbeC4MmW6szdRLr8Ex/87oclBoH8FiSQc6hE72XH/DpW+yms8v71b2hT8RIxhFPKWMk+9uEAinWPW3rPca3jn0Je+Rh7FpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fifi.org; spf=pass smtp.mailfrom=fifi.org; arc=none smtp.client-ip=173.255.216.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fifi.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fifi.org
Received: from ceramic.fifi.org (107-142-44-66.lightspeed.sntcca.sbcglobal.net [107.142.44.66])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by granite.fifsource.com (Postfix) with ESMTPSA id 1B1924076;
	Tue, 26 Nov 2024 07:01:09 -0800 (PST)
Message-ID: <9a88fd5fcaad10132c00cfcbcf0f9de9fa47c99c.camel@fifi.org>
Subject: Re: [PATCH] Revert "readahead: properly shorten readahead when
 falling back to do_page_cache_ra()"
From: Philippe Troin <phil@fifi.org>
To: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, Anders Blomdell <anders.blomdell@gmail.com>,
  stable@vger.kernel.org
Date: Tue, 26 Nov 2024 07:01:08 -0800
In-Reply-To: <20241126145208.985-1-jack@suse.cz>
References: <20241126145208.985-1-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-11-26 at 15:52 +0100, Jan Kara wrote:
> This reverts commit 7c877586da3178974a8a94577b6045a48377ff25.
>=20
> Anders and Philippe have reported that recent kernels occasionally hang
> when used with NFS in readahead code. The problem has been bisected to
> 7c877586da3 ("readahead: properly shorten readahead when falling back to
> do_page_cache_ra()"). The cause of the problem is that ra->size can be
> shrunk by read_pages() call and subsequently we end up calling
> do_page_cache_ra() with negative (read huge positive) number of pages.
> Let's revert 7c877586da3 for now until we can find a proper way how the
> logic in read_pages() and page_cache_ra_order() can coexist. This can
> lead to reduced readahead throughput due to readahead window confusion
> but that's better than outright hangs.
>=20
> Reported-by: Anders Blomdell <anders.blomdell@gmail.com>
> Reported-by: Philippe Troin <phil@fifi.org>
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> =C2=A0mm/readahead.c | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 8f1cf599b572..ea650b8b02fb 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -458,8 +458,7 @@ void page_cache_ra_order(struct readahead_control *ra=
ctl,
> =C2=A0		struct file_ra_state *ra, unsigned int new_order)
> =C2=A0{
> =C2=A0	struct address_space *mapping =3D ractl->mapping;
> -	pgoff_t start =3D readahead_index(ractl);
> -	pgoff_t index =3D start;
> +	pgoff_t index =3D readahead_index(ractl);
> =C2=A0	unsigned int min_order =3D mapping_min_folio_order(mapping);
> =C2=A0	pgoff_t limit =3D (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
> =C2=A0	pgoff_t mark =3D index + ra->size - ra->async_size;
> @@ -522,7 +521,7 @@ void page_cache_ra_order(struct readahead_control *ra=
ctl,
> =C2=A0	if (!err)
> =C2=A0		return;
> =C2=A0fallback:
> -	do_page_cache_ra(ractl, ra->size - (index - start), ra->async_size);
> +	do_page_cache_ra(ractl, ra->size, ra->async_size);
> =C2=A0}
> =C2=A0
> =C2=A0static unsigned long ractl_max_pages(struct readahead_control *ract=
l,

You can add a
   Tested-by: Philippe Troin <phil@fifi.org>
tag as I did experiment and validate the fix with that revert on top of 6.1=
1.10.

Phil.

