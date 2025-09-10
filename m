Return-Path: <linux-fsdevel+bounces-60728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53BAB50A9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 03:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0998169F82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316E2264D4;
	Wed, 10 Sep 2025 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcKBDT40"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E62248B8;
	Wed, 10 Sep 2025 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469585; cv=none; b=PM3B6QQraLC2zNy+nIOZU8E2TVrHORY7Q3KuQmuh6D6fCWkArh9VCBbQSvEO5ltGDuC4xt6yBcHQIEfTh/pLS3PDznH8CS0tVdz29i24jySqkQo0HYFu25Rdc5T683z9cG9EqcNmzfOQtB9gL6SA1gBYHx92lx47S6spCxbq3pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469585; c=relaxed/simple;
	bh=tY2g1ewNz2H31wMVaoYNp4hPaQ8OMzfHbr13qu9BshQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OA1PLPKy0xXD1ltGtxS2lhNnwTucfAPLBvP+astxKJN6Rmb7qR3AFQF3Q9wauyc6IOEqE5fURj7JKig9QuOt7Rj6zmb/0e1KMwj/8MeP0b2mzY9FruWNq3cydYM16RbJAhNjQ1pqqxQaLuyuj5pJ5TgYV4ZNWm3qvzRoZS+UL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcKBDT40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25188C4CEF4;
	Wed, 10 Sep 2025 01:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757469584;
	bh=tY2g1ewNz2H31wMVaoYNp4hPaQ8OMzfHbr13qu9BshQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pcKBDT40l2OFNcvFOhCpqh4mzQO1YOZw3KzEyrS9QzV8G+18vGvcGaEoauo+jdN3E
	 MfuRJbuZ8vqts5jC5guF85KMn4PHQD+4eC5qIXp5IUfsXMgGJHvwYQdt7RCCAOWUal
	 wFhVOwrs7qnIXnmwlrYxdIWQdztTWchxwCOfWw2UPdQHOjBaT1Ux5HOeRIImeUBQR9
	 S8SqUfGWsoWXQjcaDU9lvv+ve6pgHsYLf5t5MOBAFw2hqPzP1DocXUe9E+02lbeOEG
	 TYaFLnzoRxBJvs/4N8ugvmcnBLpVpJgWW7cKgLVzyRECAy8titAUxclO+VesDQDed+
	 GO0g8MpI2ajaQ==
Message-ID: <5839b964d7465a8eb7235cd01575a0af073af60d.camel@kernel.org>
Subject: Re: [PATCH v5 0/3] Initial NFS client support for RWF_DONTCACHE
From: Trond Myklebust <trondmy@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Anna Schumaker
	 <anna@kernel.org>, linux-nfs@vger.kernel.org
Date: Tue, 09 Sep 2025 21:59:42 -0400
In-Reply-To: <cover.1757177140.git.trond.myklebust@hammerspace.com>
References: <cover.1755612705.git.trond.myklebust@hammerspace.com>
	 <cover.1757177140.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andrew,

On Tue, 2025-09-09 at 21:53 -0400, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> The main issue is allowing support on 2 stage writes (i.e. unstable
> WRITE followed by a COMMIT) since those don't follow the current
> assumption that the 'dropbehind' flag can be fulfilled as soon as the
> writeback lock is dropped.
>=20
> v2:
> =C2=A0- Make use of the new iocb parameter for nfs_write_begin()
> v3:
> =C2=A0- Set/clear PG_DROPBEHIND on the head of the nfs_page group
> =C2=A0- Simplify helper folio_end_dropbehind
> v4:
> =C2=A0- Replace filemap_end_dropbehind_write() with folio_end_dropbehind(=
)
> =C2=A0- Add a helper to replace folio_end_writeback with an equivalent
> that
> =C2=A0=C2=A0 does not attempt to interpret the dropbehind flag
> =C2=A0- Keep the folio dropbehind flag set until the NFS client is ready
> to
> =C2=A0=C2=A0 call folio_end_dropbehind.
> =C2=A0- Don't try to do a read-modify-write in nfs_write_begin() if the
> folio
> =C2=A0=C2=A0 has the dropbehind flag set.
> v5:
> =C2=A0- Change helper function export types to EXPORT_SYMBOL_GPL
>=20
> Trond Myklebust (3):
> =C2=A0 filemap: Add a helper for filesystems implementing dropbehind
> =C2=A0 filemap: Add a version of folio_end_writeback that ignores
> dropbehind
> =C2=A0 NFS: Enable use of the RWF_DONTCACHE flag on the NFS client
>=20
> =C2=A0fs/nfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 9 +++++----
> =C2=A0fs/nfs/nfs4file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0fs/nfs/write.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 +++-
> =C2=A0include/linux/pagemap.h |=C2=A0 2 ++
> =C2=A0mm/filemap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 34 ++++++++++++++++++++++++++--------
> =C2=A05 files changed, 37 insertions(+), 13 deletions(-)

Since the above series has already done the rounds in the linux-nfs and
linux-fsdevel mailing lists, could you please ask you to shepherd it in
to the 6.18 merge window? As you can see above the larger set of
changes are to mm/filemap.c rather than being NFS specific.

Cheers
 Trond

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

