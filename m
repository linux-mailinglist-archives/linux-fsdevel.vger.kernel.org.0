Return-Path: <linux-fsdevel+bounces-46401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C557A8887E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 18:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B513B16CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C342820A1;
	Mon, 14 Apr 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSCVX8gj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D1B27F73B
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647702; cv=none; b=iMOkFiBYmR8zbEBz1ivgRSVPF/DsPOgBE5RSz5EleFa+beZGRiLRkGW6xYJMf/UZ2TsL0wqZAoHGFml6w2C3BwKkQRSqteqLf6FM85JWtT7Goa5UdHoE9MizmX5goJdggM/hDLwRAskdT0PIvOcDECYwiYiOc7krOjIfT7/92mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647702; c=relaxed/simple;
	bh=N76imMJRmJyC7nLc75KACPJaELJHuJGRNC1IaMueYFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iVc59QrSspN6rKIo6CCL+3zgaeYw6zhfwDlVbWpYBjmx0AgB0V2QVlzueiEXMa7Cnqg8GSYCXaxWXOHp43c8EgInP1WPbq9e+rTCFnp/WuuROnaATDrtVRlqmMWbY3PUdVlSkQxC5mQZcvoY/VPB/Oo7bheLQf9E+nepcWD24f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSCVX8gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9782BC4CEE2;
	Mon, 14 Apr 2025 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744647701;
	bh=N76imMJRmJyC7nLc75KACPJaELJHuJGRNC1IaMueYFc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bSCVX8gjO1RsYubXFH6hVublFMd7sHZfe4R9crDPC6G4hbKNh5Bmq7mSTy+S2vJ75
	 3uhlE//p/jj7H2XpSrRmJT1uyB2RhbDXdqJpTQuDlFYl25cY0MSOYD1GcI2VkoIONt
	 B8/hfjxGBOd1cHC0sWCupG3VffkFxovIZOEeJAIGbigbw/poFu6DzpofCnJeBRBjRx
	 M5gFQ+EThqvrBuRsEaZO3/Twz9ZwfZhzCf2JS6LnLCZVh81e+mtHTnnj8vwj1f6tC/
	 hz5K0ko1THYTIEKGuUQ7pK4Uf1SRTM0UuhgG16cTL4Pvs6NnWuRUrUeMzsI15My1ek
	 MdohUYZVZPwGg==
Message-ID: <0e00e8b306620c781868f375a462127d72b26289.camel@kernel.org>
Subject: Re: [PATCH v7 0/3] fuse: remove temp page copies in writeback
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc: jefflexu@linux.alibaba.com, shakeel.butt@linux.dev, david@redhat.com, 
	bernd.schubert@fastmail.fm, ziy@nvidia.com, kernel-team@meta.com
Date: Mon, 14 Apr 2025 12:21:39 -0400
In-Reply-To: <20250404181443.1363005-1-joannelkoong@gmail.com>
References: <20250404181443.1363005-1-joannelkoong@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-04 at 11:14 -0700, Joanne Koong wrote:
> The purpose of this patchset is to help make writeback in FUSE filesystem=
s as
> fast as possible.
>=20
> In the current FUSE writeback design (see commit 3be5a52b30aa
> ("fuse: support writable mmap"))), a temp page is allocated for every dir=
ty
> page to be written back, the contents of the dirty page are copied over t=
o the
> temp page, and the temp page gets handed to the server to write back. Thi=
s is
> done so that writeback may be immediately cleared on the dirty page, and =
this=20
> in turn is done in order to mitigate the following deadlock scenario that=
 may
> arise if reclaim waits on writeback on the dirty page to complete (more d=
etails
> can be found in this thread [1]):
> * single-threaded FUSE server is in the middle of handling a request
>   that needs a memory allocation
> * memory allocation triggers direct reclaim
> * direct reclaim waits on a folio under writeback
> * the FUSE server can't write back the folio since it's stuck in
>   direct reclaim
>=20
> Allocating and copying dirty pages to temp pages is the biggest performan=
ce
> bottleneck for FUSE writeback. This patchset aims to get rid of the temp =
page
> altogether (which will also allow us to get rid of the internal FUSE rb t=
ree
> that is needed to keep track of writeback status on the temp pages).
> Benchmarks show approximately a 20% improvement in throughput for 4k
> block-size writes and a 45% improvement for 1M block-size writes.
>=20
> In the current reclaim code, there is one scenario where writeback is wai=
ted
> on, which is the case where the system is running legacy cgroupv1 and rec=
laim
> encounters a folio that already has the reclaim flag set and the caller d=
id
> not have __GFP_FS (or __GFP_IO if swap) set.
>=20
> This patchset adds a new mapping flag, AS_WRITEBACK_INDETERMINATE, which
> filesystems may set on its inode mappings to indicate that writeback
> operations may take an indeterminate amount of time to complete. FUSE wil=
l set
> this flag on its mappings. Reclaim for the legacy cgroup v1 case describe=
d
> above will skip reclaim of folios with that flag set.
>=20
> With this change, writeback state is now only cleared on the dirty page a=
fter
> the server has written it back to disk. If the server is deliberately
> malicious or well-intentioned but buggy, this may stall sync(2) and page
> migration, but for sync(2), a malicious server may already stall this by =
not
> replying to the FUSE_SYNCFS request and for page migration, there are alr=
eady
> many easier ways to stall this by having FUSE permanently hold the folio =
lock.
> A fuller discussion on this can be found in [2]. Long-term, there needs t=
o be
> a more comprehensive solution for addressing migration of FUSE pages that
> handles all scenarios where FUSE may permanently hold the lock, but that =
is
> outside the scope of this patchset and will be done as future work. Pleas=
e
> also note that this change also now ensures that when sync(2) returns, FU=
SE
> filesystems will have persisted writeback changes.
>=20
> [1] https://lore.kernel.org/linux-kernel/495d2400-1d96-4924-99d3-8b2952e0=
5fc3@linux.alibaba.com/
> [2] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannel=
koong@gmail.com/
>=20
> Changelog
> ---------
> v6:
> https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelkoon=
g@gmail.com/
> Changes from v6 -> v7:
> * Drop migration and sync patches, as they are useless if a server is
>   determined to be malicious
>=20
> v5:
> https://lore.kernel.org/linux-fsdevel/20241115224459.427610-1-joannelkoon=
g@gmail.com/
> Changes from v5 -> v6:
> * Add Shakeel and Jingbo's reviewed-bys=20
> * Move folio_end_writeback() to fuse_writepage_finish() (Jingbo)
> * Embed fuse_writepage_finish_stat() logic inline (Jingbo)
> * Remove node_stat NR_WRITEBACK inc/sub (Jingbo)
>=20
> v4:
> https://lore.kernel.org/linux-fsdevel/20241107235614.3637221-1-joannelkoo=
ng@gmail.com/
> Changes from v4 -> v5:
> * AS_WRITEBACK_MAY_BLOCK -> AS_WRITEBACK_INDETERMINATE (Shakeel)
> * Drop memory hotplug patch (David and Shakeel)
> * Remove some more kunnecessary writeback waits in fuse code (Jingbo)
> * Make commit message for reclaim patch more concise - drop part about
>   deadlock and just focus on how it may stall waits
>=20
> v3:
> https://lore.kernel.org/linux-fsdevel/20241107191618.2011146-1-joannelkoo=
ng@gmail.com/
> Changes from v3 -> v4:
> * Use filemap_fdatawait_range() instead of filemap_range_has_writeback() =
in
>   readahead
>=20
> v2:
> https://lore.kernel.org/linux-fsdevel/20241014182228.1941246-1-joannelkoo=
ng@gmail.com/
> Changes from v2 -> v3:
> * Account for sync and page migration cases as well (Miklos)
> * Change AS_NO_WRITEBACK_RECLAIM to the more generic AS_WRITEBACK_MAY_BLO=
CK
> * For fuse inodes, set mapping_writeback_may_block only if fc->writeback_=
cache
>   is enabled
>=20
> v1:
> https://lore.kernel.org/linux-fsdevel/20241011223434.1307300-1-joannelkoo=
ng@gmail.com/T/#t
> Changes from v1 -> v2:
> * Have flag in "enum mapping_flags" instead of creating asop_flags (Shake=
el)
> * Set fuse inodes to use AS_NO_WRITEBACK_RECLAIM (Shakeel)
>=20
> Joanne Koong (3):
>   mm: add AS_WRITEBACK_INDETERMINATE mapping flag
>   mm: skip reclaiming folios in legacy memcg writeback indeterminate
>     contexts
>   fuse: remove tmp folio for writebacks and internal rb tree
>=20
>  fs/fuse/file.c          | 360 ++++------------------------------------
>  fs/fuse/fuse_i.h        |   3 -
>  include/linux/pagemap.h |  11 ++
>  mm/vmscan.c             |  10 +-
>  4 files changed, 46 insertions(+), 338 deletions(-)
>=20

This looks sane, and I love that diffstat.

I also agree with David about changing the flag name to something more
specific. As a kernel engineer, anything with "INDETERMINATE" in the
name gives me the ick.

Assuming that the only real change in v8 will be the flag name change,
you can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

Assuming others are ok with this, how do you see this going in? Maybe
Andrew could pick up the mm bits and Miklos could take the FUSE patch?

