Return-Path: <linux-fsdevel+bounces-24340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84B993D7DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 19:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37BAFB2313B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4344F17B42F;
	Fri, 26 Jul 2024 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C66Y9G9F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9B918AEA;
	Fri, 26 Jul 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016593; cv=none; b=u1lKiAFOxtErW8Dh9GKK6FJh4wQ1A5Unn/JJY4kgw1eA09vSVonZ2q86ZczTzcozpgWPHpH6WTXMexItPH2aebnf68+Y+nZil0UqRO8z8u0WrwOVaXr+6F/+Kayq5cc7r32GMRFt2/f78lalPnDC4dn/XKLnOtNsHTjhIiZjdCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016593; c=relaxed/simple;
	bh=7gew2TJiCIV3EXl/ZglhQ3Naz7+SUr6HaXCbbEnNGn0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fRwsiONH8hTT2rUoZIFXeItoxOIONYK0IjtslZLx1+Wc+moYz/SDt/62O+qaoHP/uvuH0bttFSl+JF7BOnn6j78sa2tBkSQhzt15rU0teGbMEJdZmvTNsAcrT/X6UHvrUYNn0klP6Zx1ESDqWotnzceAbNjs19oWZt6Q+xcX9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C66Y9G9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F87FC4AF07;
	Fri, 26 Jul 2024 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722016593;
	bh=7gew2TJiCIV3EXl/ZglhQ3Naz7+SUr6HaXCbbEnNGn0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=C66Y9G9FUqqBcz0YAFgC5BIHpq5s27vuEfMGyx+cC3jBJlg/dRXF96Nm5mC1c5wEM
	 03ZbYmIVWfIFoIOgGzcwvAR9pzZybfx1OgNkK5aiFAwLOnvgFSEw45xD4lGbhccpPn
	 jevvRWszkOdn2uFSRSq/7WMuMfK9/Hr8xOw26CnkmMFB6c1yhQO+js7aOoPS40UR0b
	 g4h6udzCGZiJ0pR4J6ewjgO6yEugXYOhjlrVx8kkiTICBNJs6JIjmg6cho1PZ4psO/
	 PyKRt/EAXqTlACnmPenUZNTtRooi8dDASiL4ZKAIWzw7WtEYQ3qJiRy2hyWm+Wyn2X
	 l3hbKymHQ9ZnQ==
Message-ID: <1d5d8c10ccd94b3b69a8f7bff2e5c44da812c407.camel@kernel.org>
Subject: Re: [PATCH] netfs: Fault in smaller chunks for non-large folio
 mappings
From: Jeff Layton <jlayton@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Howells
	 <dhowells@redhat.com>
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, Xu Yang
	 <xu.yang_2@nxp.com>
Date: Fri, 26 Jul 2024 13:56:31 -0400
In-Reply-To: <20240527201735.1898381-1-willy@infradead.org>
References: <20240527201735.1898381-1-willy@infradead.org>
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

On Mon, 2024-05-27 at 21:17 +0100, Matthew Wilcox (Oracle) wrote:
> As in commit 4e527d5841e2 ("iomap: fault in smaller chunks for non-
> large
> folio mappings"), we can see a performance loss for filesystems
> which have not yet been converted to large folios.
>=20
> Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache
> for buffered write")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> =C2=A0fs/netfs/buffered_write.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index 07bc1fd43530..3288561e98dd 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -184,7 +184,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb,
> struct iov_iter *iter,
> =C2=A0	unsigned int bdp_flags =3D (iocb->ki_flags & IOCB_NOWAIT) ?
> BDP_ASYNC : 0;
> =C2=A0	ssize_t written =3D 0, ret, ret2;
> =C2=A0	loff_t i_size, pos =3D iocb->ki_pos, from, to;
> -	size_t max_chunk =3D PAGE_SIZE << MAX_PAGECACHE_ORDER;
> +	size_t max_chunk =3D mapping_max_folio_size(mapping);
> =C2=A0	bool maybe_trouble =3D false;
> =C2=A0
> =C2=A0	if (unlikely(test_bit(NETFS_ICTX_WRITETHROUGH, &ctx->flags)
> ||

Reviewed-by: Jeff Layton <jlayton@kernel.org>

