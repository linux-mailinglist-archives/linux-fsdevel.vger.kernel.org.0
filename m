Return-Path: <linux-fsdevel+bounces-72873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 566D9D04255
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 17:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D45B351BF09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1DD318ECE;
	Thu,  8 Jan 2026 15:31:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A725A50097B;
	Thu,  8 Jan 2026 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767886316; cv=none; b=q0jGr9RvZvxt6RH95ZaZIAwVA9Xf4PZA0ehTTCIsyhckPNzzOxmnq2UbDISdjCRJRf6G4IJA7wKsoOr+ZioSpb+3EAPreH1jJI+dta/Q6pbwH8OrxifsrLYlje8ZrIBEOourzFSeEpTJzeMj6FX2urYsCL6sKKfZQFsiGkEWizQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767886316; c=relaxed/simple;
	bh=hAAxZIvlvT50VHBWiwEYz2hEYF8NCKsZqeikTIBdozo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOd2UW242a1cmbiXwVsZscgwzab8+coSfWxvA1PZIiEYEPNLKnShWfBXHBtfHlWQJD3AcCHd3V7QVivMkQgvxllFi4hqoog7h1E+jEqvoS8o8ck0dPJD3lJYQCH7859HHLuQLcRPWm4l66GLneT7zNW9+/XYQ0J5kYUqI4ZAKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn85Z5SX1zJ46D8;
	Thu,  8 Jan 2026 23:31:46 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C282540570;
	Thu,  8 Jan 2026 23:31:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 15:31:50 +0000
Date: Thu, 8 Jan 2026 15:31:48 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: John Groves <John@Groves.net>
CC: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams
	<dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, "Alison
 Schofield" <alison.schofield@intel.com>, John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "David
 Hildenbrand" <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Stefan
 Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef
 Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Chen
 Linxuan <chenlinxuan@uniontech.com>, "James Morse" <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>, "Sean Christopherson" <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>, Ajay
 Joshi <ajayjoshi@micron.com>, <venkataravis@micron.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V3 4/4] fuse: add famfs DAX fmap support
Message-ID: <20260108153148.00001e63@huawei.com>
In-Reply-To: <20260107153443.64794-5-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153443.64794-1-john@groves.net>
	<20260107153443.64794-5-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  7 Jan 2026 09:34:43 -0600
John Groves <John@Groves.net> wrote:

> Add new FUSE operations and capability for famfs DAX file mapping:
>=20
> - FUSE_CAP_DAX_FMAP: New capability flag at bit 32 (using want_ext/capabl=
e_ext
>   fields) to indicate kernel and userspace support for DAX fmaps
>=20
> - GET_FMAP: New operation to retrieve a file map for DAX-mapped files.
>   Returns a fuse_famfs_fmap_header followed by simple or interleaved
>   extent descriptors. The kernel passes the file size as an argument.
>=20
> - GET_DAXDEV: New operation to retrieve DAX device info by index.
>   Called when GET_FMAP returns an fmap referencing a previously
>   unknown DAX device.
>=20
> These operations enable FUSE filesystems to provide direct access
> mappings to persistent memory, allowing the kernel to map files
> directly to DAX devices without page cache intermediation.
>=20
> Signed-off-by: John Groves <john@groves.net>


> ---
>  include/fuse_common.h   |  5 +++++
>  include/fuse_lowlevel.h | 37 +++++++++++++++++++++++++++++++++++++
>  lib/fuse_lowlevel.c     | 31 ++++++++++++++++++++++++++++++-
>  3 files changed, 72 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/fuse_common.h b/include/fuse_common.h
> index 041188e..e428ddb 100644
> --- a/include/fuse_common.h
> +++ b/include/fuse_common.h
> @@ -512,6 +512,11 @@ struct fuse_loop_config_v1 {
>   */
>  #define FUSE_CAP_OVER_IO_URING (1UL << 31)
> =20
> +/**
> + * handle files that use famfs dax fmaps
> + */
> +#define FUSE_CAP_DAX_FMAP (1UL<<32)

=46rom the context above, looks like local style is spaces around <<

That's about the level of my understanding of the fuse code ;)

> +
>  /**
>   * Ioctl flags
>   *


