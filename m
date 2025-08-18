Return-Path: <linux-fsdevel+bounces-58187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7E6B2AD83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 17:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F6718958B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4188032A3FB;
	Mon, 18 Aug 2025 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK3K/Xla"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C3322A35;
	Mon, 18 Aug 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532593; cv=none; b=oETIYdpyTIOtPNLiFnXkuMU3K7Fj/NSy7u68iqtZyPEW265Tkv64J3tdP3I3vJp6sn31fOYWInA39/iNYat3yaCJIW/9rY3A12FX8EQTNZ/1sfR5xIHu2SpE9Eoz+UJld83J7PngL57yv/wI7snD9OgzMvxInwytCsxSnz6XYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532593; c=relaxed/simple;
	bh=YXXFRG9Emwrp9q22NXwO+qQLKNczXarZeVCaGITq1ro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGHENWdKh7Fk82dVnM9V4NjzgqNf3pBNCnTXVje4DlFbaLiI8Re+vRD0frUxatBg1kSV48LxWLM/4u7YEfiHf4QQpUDrMA3UnuYsNjq1sY0Gnsyff9WoN1cNScIiDuKBLnnHMCGQZwEibqjie7sVodEQloF3+on1cF39Frh6DBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK3K/Xla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7CEC4CEEB;
	Mon, 18 Aug 2025 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755532593;
	bh=YXXFRG9Emwrp9q22NXwO+qQLKNczXarZeVCaGITq1ro=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WK3K/XlalBaImJWa1YNKl/aCUPUdHhVJWV2VqurXbKaU0gRCuo6I26gjNpv/hYG5a
	 PR//XaM770VJyuKMpYQ6X3kJI5zIplx4HT5aSodBC7s85kJeo25i2azAqgzNss/AyS
	 0nNpW+2G3OexDNINVsQvjRuAYMKqLEA1XLSaUGmJbzCz5bkfdGJ/3L+8l9LbLKXlHk
	 kuwHFpO0/JO7Rpvos36zKMpwMnu1YPzrZL0JMHGOGqXWCmq2q372RlUQ6oH/0I2vqA
	 sgtdUrgojRtT7j3AVa1biOa4NZ47y3oXApM6cgN1kL3GbprcVaQ8W3mTwcCxBt6tUe
	 iFsZbQlUWgZPw==
Message-ID: <88e2e70a827618b5301d92b094ef07efacba0577.camel@kernel.org>
Subject: Re: [PATCH v3 2/2] NFS: Enable the RWF_DONTCACHE flag for the NFS
 client
From: Trond Myklebust <trondmy@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Date: Mon, 18 Aug 2025 08:56:31 -0700
In-Reply-To: <aKNE9UnyBoaE_UzJ@casper.infradead.org>
References: <cover.1755527537.git.trond.myklebust@hammerspace.com>
	 <001e5575d7ddbcdb925626151a7dcc7353445543.1755527537.git.trond.myklebust@hammerspace.com>
	 <aKNE9UnyBoaE_UzJ@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-18 at 16:21 +0100, Matthew Wilcox wrote:
> On Mon, Aug 18, 2025 at 07:39:50AM -0700, Trond Myklebust wrote:
> > @@ -349,8 +349,12 @@ static void nfs_folio_end_writeback(struct
> > folio *folio)
> > =C2=A0static void nfs_page_end_writeback(struct nfs_page *req)
> > =C2=A0{
> > =C2=A0	if (nfs_page_group_sync_on_bit(req, PG_WB_END)) {
> > +		struct folio *folio =3D nfs_page_to_folio(req);
> > +
> > +		if (folio_test_clear_dropbehind(folio))
> > +			set_bit(PG_DROPBEHIND, &req->wb_head-
> > >wb_flags);
> > =C2=A0		nfs_unlock_request(req);
> > @@ -787,8 +791,15 @@ static void nfs_inode_remove_request(struct
> > nfs_page *req)
> > =C2=A0			clear_bit(PG_MAPPED, &req->wb_head-
> > >wb_flags);
> > =C2=A0		}
> > =C2=A0		spin_unlock(&mapping->i_private_lock);
> > -	}
> > -	nfs_page_group_unlock(req);
> > +		nfs_page_group_unlock(req);
> > +
> > +		if (test_and_clear_bit(PG_DROPBEHIND,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &req->wb_head->wb_flags)) {
> > +			folio_set_dropbehind(folio);
> > +			folio_end_dropbehind(folio);
> > +		}
>=20
> I don't think this technique is "safe".=C2=A0 By clearing the flag early,
> the page cache can't see that a folio that was created by dropbehind
> has now been reused and should have its dropbehind flag cleared.=C2=A0 So
> we
> might see pages dropped from the cache that really should not be.

The only alternative would be to add back in a helper in mm/filemap.c
that does the normal folio_end_writeback() routine, but ignores the
dropbehind flag. (folio_end_writeback_ignore_dropbehind()?)

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

