Return-Path: <linux-fsdevel+bounces-58189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3B9B2ADB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 18:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BBE5E1BBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051933375A4;
	Mon, 18 Aug 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rw+dL4ZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683125228D;
	Mon, 18 Aug 2025 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532783; cv=none; b=Sw+4xSQeGMd8sJURcVBkVM/0fuFNX+DvTppbxJTWCqdPFhc0elV2C2OlvMU5XfiZvc35dyyotfpEAyDPJXReX429JzVlOJuCKgVKVFMBdR+DwClY/vQF7OYUmaI+dGT746g8XtU8/vhSp99FeLTrwI0eaKCw4yPFan3M27EUFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532783; c=relaxed/simple;
	bh=cXEPdBZkZwIA9mk6lX7PMcOZ2tMYa2PufipnCwP5YSo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XaLkI9DA1FqLyvFc3QDr2jMHtrJeGzm5kygBZtjx6Fc9d6pBdKEYVy2u4YMuXqQvlkllQwUuCtofe6q6N2LLUCNsJuW91SbvNlRDFCkAP2bFJ7QgXQWuNdTrEhz71N5KVD2fBynM0vLB789NnI3u4KHzvqNOJpQ/M0UlnqadaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rw+dL4ZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62064C4CEEB;
	Mon, 18 Aug 2025 15:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755532782;
	bh=cXEPdBZkZwIA9mk6lX7PMcOZ2tMYa2PufipnCwP5YSo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rw+dL4ZIeGL+JGwQVJ48bSDgOXZVH6GwYOQY+2jnhNIi8Da7bphUNHsqto+r2KRSK
	 cVtmANMjDpSeKVbtrVmdiZgYbGEYxhD0+0j3xv9/6mHgfKjcTz6l8RsYCgJwRaMhf7
	 h70Y8nvTJmk9PQgfuQKDwFCS3xgSRd+qHLZFxGwmbusgYBbLXHwk/1ZwKr/FlUrVvM
	 MH3fVKoJXQHGPzitK5kQj6yiEavCo3FvF6VxE0K7EErGarUbc8WE1AuJpzs7aUa+Lj
	 Hu4jUbgRn1T47SQcDjDd0Nj8/GSCsjxuPjm+ua4Wwf27gzbsYe6K5f75VaXvK6TN/D
	 OscT6+E/i1poQ==
Message-ID: <5109a45f43249d88882400f92e0cef27503c0704.camel@kernel.org>
Subject: Re: [PATCH v3 1/2] filemap: Add a helper for filesystems
 implementing dropbehind
From: Trond Myklebust <trondmy@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Date: Mon, 18 Aug 2025 08:59:41 -0700
In-Reply-To: <aKM99bjgILBwRQus@casper.infradead.org>
References: <cover.1755527537.git.trond.myklebust@hammerspace.com>
	 <ba478422e240f18eb9331e16c1d67d309b5a72cd.1755527537.git.trond.myklebust@hammerspace.com>
	 <aKM99bjgILBwRQus@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-18 at 15:51 +0100, Matthew Wilcox wrote:
> On Mon, Aug 18, 2025 at 07:39:49AM -0700, Trond Myklebust wrote:
> > +void folio_end_dropbehind(struct folio *folio)
> > +{
> > +	filemap_end_dropbehind_write(folio);
> > +}
> > +EXPORT_SYMBOL(folio_end_dropbehind);
>=20
> Why not just export filemap_end_dropbehind_write()?

It seemed more appropriate to use the 'folio' prefix when exporting, so
that it is symmetric with folio_end_writeback().

I'm perfectly fine with changing that if people disagree.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

