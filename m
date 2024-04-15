Return-Path: <linux-fsdevel+bounces-16928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F1A8A4FC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFFB1F22620
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6973839E5;
	Mon, 15 Apr 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGqjMFzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAAD8289E;
	Mon, 15 Apr 2024 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185383; cv=none; b=CbLMjVrXeuIPCUSZh9yieB8g15Iq3C9CwBM9rG+7IkHQFvpxPe2oGF6Z+Vvtyr4xCl1SuDwkc0HWs6kuOrrQRF6oMruJfrLrpo1aCrboNfnm6yTorpro9FsL4AZblwmT/+8CVyMJMBGUJN+YI+38x9cqHIVudMrRww/58ifOcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185383; c=relaxed/simple;
	bh=A4QhcND1ZpufPBx/famSbhUuWoIfXwb4BwDvzp25qAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZnRI6T47+cUaOH7V6wzP6lcRNK9WisW8gw99IlyT0MjMpBi9RSs1c+7eM8OAwzrLVle1HuEgTg5xxQrLbAYReVtaIfSrCZcmZQ0eBBVe59xFpzsrWHvZ89e6MfxxZUuKsW4WYO4mM5k2frqXXO9uW4JEKUbP5IpnXBGKKPRiIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGqjMFzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86D1C2BD11;
	Mon, 15 Apr 2024 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185382;
	bh=A4QhcND1ZpufPBx/famSbhUuWoIfXwb4BwDvzp25qAE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PGqjMFzH68ZJY3XlVsWUcKaHmR7w+9vctik141QhIl9Li7zHE+dvpfrUvnbdNdKDt
	 mgd/ZO98G0exwiFgfJbjMsWtdjOnYn4TgrrRcN3byBti56dNRvyTMLL1O6jZvFP8SF
	 OMdledu7PfctzeZov12oyg5oFMC62r3VcZyVA/dxE0MXj1I8VWYlRmFRsjbFn4zV58
	 qyGUngLzfNzU1VyLjeKR3ZrEjqz2FPQL7dhOi1+sZDWhq+lOQhkj49NpXRIW7jteMz
	 LSRW4JvOCEmWOJcbLdT+na9XnS/gXvBNPHdmokI9BMdCvdC+J9n+ZIyS47bkpxDd6Q
	 SjQFHSDJFHM4A==
Message-ID: <5c905e500499a07c5e4b0dcf9983b90e8746ed81.camel@kernel.org>
Subject: Re: [PATCH 00/26] netfs, afs, 9p, cifs: Rework netfs to use
 ->writepages() to copy to cache
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner
	 <christian@brauner.io>, Gao Xiang <hsiangkao@linux.alibaba.com>, Dominique
	Martinet <asmadeus@codewreck.org>
Cc: Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>,
  Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara
 <pc@manguebit.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey
 <tom@talpey.com>, Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov
 <idryomov@gmail.com>, netfs@lists.linux.dev,  linux-cachefs@redhat.com,
 linux-afs@lists.infradead.org,  linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org,  ceph-devel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 15 Apr 2024 08:49:39 -0400
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 16:33 +0000, David Howells wrote:
> Hi Christian, Willy,
>=20
> The primary purpose of these patches is to rework the netfslib writeback
> implementation such that pages read from the cache are written to the cac=
he
> through ->writepages(), thereby allowing the fscache page flag to be
> retired.
>=20
> The reworking also:
>=20
>  (1) builds on top of the new writeback_iter() infrastructure;
>=20
>  (2) makes it possible to use vectored write RPCs as discontiguous stream=
s
>      of pages can be accommodated;
>=20
>  (3) makes it easier to do simultaneous content crypto and stream divisio=
n.
>=20
>  (4) provides support for retrying writes and re-dividing a stream;
>=20
>  (5) replaces the ->launder_folio() op, so that ->writepages() is used
>      instead;
>=20
>  (6) uses mempools to allocate the netfs_io_request and netfs_io_subreque=
st
>      structs to avoid allocation failure in the writeback path.
>=20
> Some code that uses the fscache page flag is retained for compatibility
> purposes with nfs and ceph.  The code is switched to using the synonymous
> private_2 label instead and marked with deprecation comments.  I have a
> separate set of patches that convert cifs to use this code.
>=20
> -~-
>=20
> In this new implementation, writeback_iter() is used to pump folios,
> progressively creating two parallel, but separate streams.  Either or bot=
h
> streams can contain gaps, and the subrequests in each stream can be of
> variable size, don't need to align with each other and don't need to alig=
n
> with the folios.  (Note that more streams can be added if we have multipl=
e
> servers to duplicate data to).
>=20
> Indeed, subrequests can cross folio boundaries, may cover several folios =
or
> a folio may be spanned by multiple subrequests, e.g.:
>=20
>          +---+---+-----+-----+---+----------+
> Folios:  |   |   |     |     |   |          |
>          +---+---+-----+-----+---+----------+
>=20
>            +------+------+     +----+----+
> Upload:    |      |      |.....|    |    |
>            +------+------+     +----+----+
>=20
>          +------+------+------+------+------+
> Cache:   |      |      |      |      |      |
>          +------+------+------+------+------+
>=20
> Data that got read from the server that needs copying to the cache is
> stored in folios that are marked dirty and have folio->private set to a
> special value.
>=20
> The progressive subrequest construction permits the algorithm to be
> preparing both the next upload to the server and the next write to the
> cache whilst the previous ones are already in progress.  Throttling can b=
e
> applied to control the rate of production of subrequests - and, in any
> case, we probably want to write them to the server in ascending order,
> particularly if the file will be extended.
>=20
> Content crypto can also be prepared at the same time as the subrequests a=
nd
> run asynchronously, with the prepped requests being stalled until the
> crypto catches up with them.  This might also be useful for transport
> crypto, but that happens at a lower layer, so probably would be harder to
> pull off.
>=20
> The algorithm is split into three parts:
>=20
>  (1) The issuer.  This walks through the data, packaging it up, encryptin=
g
>      it and creating subrequests.  The part of this that generates
>      subrequests only deals with file positions and spans and so is usabl=
e
>      for DIO/unbuffered writes as well as buffered writes.
>=20
>  (2) The collector.  This asynchronously collects completed subrequests,
>      unlocks folios, frees crypto buffers and performs any retries.  This
>      runs in a work queue so that the issuer can return to the caller for
>      writeback (so that the VM can have its kswapd thread back) or async
>      writes.
>=20
>      Collection is slightly complex as the collector has to work out wher=
e
>      discontiguities happen in the folio list so that it doesn't try and
>      collect folios that weren't included in the write out.
>=20
>  (3) The retryer.  This pauses the issuer, waits for all outstanding
>      subrequests to complete and then goes through the failed subrequests
>      to reissue them.  This may involve reprepping them (with cifs, the
>      credits must be renegotiated and a subrequest may need splitting), a=
nd
>      doing RMW for content crypto if there's a conflicting change on the
>      server.
>=20
> David
>=20
> David Howells (26):
>   cifs: Fix duplicate fscache cookie warnings
>   9p: Clean up some kdoc and unused var warnings.
>   netfs: Update i_blocks when write committed to pagecache
>   netfs: Replace PG_fscache by setting folio->private and marking dirty
>   mm: Remove the PG_fscache alias for PG_private_2
>   netfs: Remove deprecated use of PG_private_2 as a second writeback
>     flag
>   netfs: Make netfs_io_request::subreq_counter an atomic_t
>   netfs: Use subreq_counter to allocate subreq debug_index values
>   mm: Provide a means of invalidation without using launder_folio
>   cifs: Use alternative invalidation to using launder_folio
>   9p: Use alternative invalidation to using launder_folio
>   afs: Use alternative invalidation to using launder_folio
>   netfs: Remove ->launder_folio() support
>   netfs: Use mempools for allocating requests and subrequests
>   mm: Export writeback_iter()
>   netfs: Switch to using unsigned long long rather than loff_t
>   netfs: Fix writethrough-mode error handling
>   netfs: Add some write-side stats and clean up some stat names
>   netfs: New writeback implementation
>   netfs, afs: Implement helpers for new write code
>   netfs, 9p: Implement helpers for new write code
>   netfs, cachefiles: Implement helpers for new write code
>   netfs: Cut over to using new writeback code
>   netfs: Remove the old writeback code
>   netfs: Miscellaneous tidy ups
>   netfs, afs: Use writeback retry to deal with alternate keys
>=20
>  fs/9p/vfs_addr.c             |  60 +--
>  fs/9p/vfs_inode_dotl.c       |   4 -
>  fs/afs/file.c                |   8 +-
>  fs/afs/internal.h            |   6 +-
>  fs/afs/validation.c          |   4 +-
>  fs/afs/write.c               | 187 ++++----
>  fs/cachefiles/io.c           |  75 +++-
>  fs/ceph/addr.c               |  24 +-
>  fs/ceph/inode.c              |   2 +
>  fs/netfs/Makefile            |   3 +-
>  fs/netfs/buffered_read.c     |  40 +-
>  fs/netfs/buffered_write.c    | 832 ++++-------------------------------
>  fs/netfs/direct_write.c      |  30 +-
>  fs/netfs/fscache_io.c        |  14 +-
>  fs/netfs/internal.h          |  55 ++-
>  fs/netfs/io.c                | 155 +------
>  fs/netfs/main.c              |  55 ++-
>  fs/netfs/misc.c              |  10 +-
>  fs/netfs/objects.c           |  81 +++-
>  fs/netfs/output.c            | 478 --------------------
>  fs/netfs/stats.c             |  17 +-
>  fs/netfs/write_collect.c     | 813 ++++++++++++++++++++++++++++++++++
>  fs/netfs/write_issue.c       | 673 ++++++++++++++++++++++++++++
>  fs/nfs/file.c                |   8 +-
>  fs/nfs/fscache.h             |   6 +-
>  fs/nfs/write.c               |   4 +-
>  fs/smb/client/cifsfs.h       |   1 -
>  fs/smb/client/file.c         | 136 +-----
>  fs/smb/client/fscache.c      |  16 +-
>  fs/smb/client/inode.c        |  27 +-
>  include/linux/fscache.h      |  22 +-
>  include/linux/netfs.h        | 196 +++++----
>  include/linux/pagemap.h      |   1 +
>  include/net/9p/client.h      |   2 +
>  include/trace/events/netfs.h | 249 ++++++++++-
>  mm/filemap.c                 |  52 ++-
>  mm/page-writeback.c          |   1 +
>  net/9p/Kconfig               |   1 +
>  net/9p/client.c              |  49 +++
>  net/9p/trans_fd.c            |   1 -
>  40 files changed, 2492 insertions(+), 1906 deletions(-)
>  delete mode 100644 fs/netfs/output.c
>  create mode 100644 fs/netfs/write_collect.c
>  create mode 100644 fs/netfs/write_issue.c
>=20

This all looks pretty reasonable. There is at least one bugfix that
looks like it ought to go in independently (#17). #19 is huge, complex
and hard to review. That will need some cycles in -next, I think. In any
case, on any that I didn't send comments you can add:

    Reviewed-by: Jeff Layton <jlayton@kernel.org>

