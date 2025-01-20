Return-Path: <linux-fsdevel+bounces-39661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF2CA16A99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 11:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481173A470D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 10:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00A31AED5C;
	Mon, 20 Jan 2025 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CwHqjdtn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA01B4240
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368113; cv=none; b=EJyd2Syx05i2jnvIO7UGwoGWtF42cq29fHw1Zr8WPiebwqbfok8Pyuadj0SFKdyDHiFvhPmAozzKz5SYLCf7wcjUE1Fb7ZTC+uP5fDgrfsUhXYNxtkI5u5GZypqOuzfyRax6VnG9C/yWPwXy8scv7pefVaPO1ZsAqiWKLeXCNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368113; c=relaxed/simple;
	bh=LJkNNxD1U1gXVPrjrH3DyhzbSIm2nOoE+uOkfGMyC2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YxgIXaDVNNWMHqMo92RB9LFaRmRb+rxMY16SA+2j2sYTabgQEgPtET3CyEDoZIONPfP4qwLCI/O65uJow34tU36DFYJW+jjme4bENfgnS8eCPOcT73WGt+mBj1HTVTnUpPuxFY17P1HG14HiAkwfRpS/31dICklj6P1VRDflFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CwHqjdtn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MPH1fYDAL8xE+g+BWJUzZW9nEwI1bkoCpJ2SMJRb0CM=; b=CwHqjdtnjGSAYZJk1HuToVaZGR
	aztsmUnmXfStAhSqbmft9nIuqa5nbKS8b2Rznx/lFkXXxMQKQcbrtFtcLnQTupzkMV6F0MLnLycga
	l66QTrSRs0yrriinfch/v+ssSbNEM2jQ6o1xffsC1pyCOrreNs5Lxq0kwuiIDjai9EnHNmFdVGnsl
	/wPovpg7QP7S7kZs5e/OxKRrvoicw39PtSsZHBHBndwml95Zq2KrK4tg1zPwYvXqodf40KKchSt59
	39a/mwr/6wA3t0kXgLRBcwmpqHhDwVBa6CwQL/8eBJhb5iaaomUoIaShz/ybROuvYu0rqI0yJSrgl
	DhfLpW9Q==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tZoo5-000hpJ-2h; Mon, 20 Jan 2025 11:14:57 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Teng Qin <tqin@jumptrading.com>,  linux-fsdevel@vger.kernel.org
Subject: Re: [FUSE] notify_store usage: deadlocks with other read / write
 requests
In-Reply-To: <YTiGyDIdIG05Gakm@miu.piliscsaba.redhat.com> (Miklos Szeredi's
	message of "Wed, 8 Sep 2021 11:47:52 +0200")
References: <CH2PR14MB410492CB0C3AB8EA0833F963D6C69@CH2PR14MB4104.namprd14.prod.outlook.com>
	<CH2PR14MB41040692ABC50334F500789ED6C89@CH2PR14MB4104.namprd14.prod.outlook.com>
	<YTiCpY1nDXntelkc@miu.piliscsaba.redhat.com>
	<YTiGyDIdIG05Gakm@miu.piliscsaba.redhat.com>
Date: Mon, 20 Jan 2025 10:14:08 +0000
Message-ID: <87v7u93i8f.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Sep 08 2021, Miklos Szeredi wrote:

> On Wed, Sep 08, 2021 at 11:30:13AM +0200, Miklos Szeredi wrote:
>> On Fri, Aug 27, 2021 at 05:31:18PM +0000, Teng Qin wrote:
>> > I am developing a file system that has underlying block size way large=
r than the number of pages VFS would request to the FUSE daemon (2MB / 4MB =
vs 32 pages =3D 128K).
>> > I currently cache the block data in user space, but it would be more i=
deal
>> > to have Kernel manage this with page cache, and save round-trips betwe=
en VFS
>> > and FUSE daemon. So I was looking at use FUSE_NOTIFY_STORE to proactiv=
ely
>> > offer the data to Kernel. However, I found that the notify store often
>> > deadlocks with user read requests.
>> >=20
>> > For example, say the user process is doing sequential read from offset=
 0.
>> > Kernel requests a 128K read to FUSE daemon and I fetch the 2MB block f=
rom
>> > underlying storage. After replying the read request, I would like to o=
ffer
>> > the rest of the 1920K data to Kernel from offset 128K. However, at this
>> > point Kernel most likely alraedy started the next read request also at
>> > offset 128K, and have those page locked:
>> >=20
>> >   wait_on_page_locked_killable
>> >   generic_file_buffered_read
>> >   generic_file_read_iter
>> >=20
>> > On the other hand, the notify store is also waiting on locking those p=
ages:
>> >=20
>> >   __lock_page
>> >   __find_lock_page
>> >   find_or_create_page
>> >   fuse_notify_store
>> >=20
>> > This normally deadlocks the FUSE daemon.
>> >=20
>> > The notify store is a pretty old feature so I'm not sure if this is re=
ally
>> > an issue or I'm using it wrong. I would be very grateful if anyone cou=
ld
>> > help me with some insights on how this is intended to be used. On the =
other
>> > hand, I was thinking maybe we could support an async notify store
>> > requests. When the Kernel moduels gets the requests, if it can not acq=
uire
>> > lock on the relevant pages, it could just store the user provided data=
 in
>> > dis-attached page structs, add them to a background requetss, and try
>> > later. If people are OK with such ideas, I would be more than happy to=
 try
>> > with an implementation.
>>=20
>> Hi,
>>=20
>> Simplest solution is to just skip locked pages in NOTIFY_STORE.  Can you=
 try the
>> attached patch (untested)?
>
> And another version (data needs to be skipped as well).

Resurrecting an old thread, as I believe I'm able to reproduce this issue.

I'm inlining below my attempt to forward port the original patch to the
folios world.  It seems to work as expected, but I'm not sure if it's
correct.  For example, if we fail to get a folio and need to skip it,
'this_num' would need to be updated; but it's not clear if using PAGE_SIZE
in that case is correct.  An alternative would be to simply return an
error to userpace immediately at that point.

Cheers,
--=20
Lu=C3=ADs

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 27ccae63495d..712388d8a3bd 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1630,6 +1630,7 @@ static int fuse_notify_store(struct fuse_conn *fc, un=
signed int size,
 	unsigned int num;
 	loff_t file_size;
 	loff_t end;
+	int fgp_flags =3D FGP_LOCK | FGP_ACCESSED | FGP_CREAT;
=20
 	err =3D -EINVAL;
 	if (size < sizeof(outarg))
@@ -1645,6 +1646,9 @@ static int fuse_notify_store(struct fuse_conn *fc, un=
signed int size,
=20
 	nodeid =3D outarg.nodeid;
=20
+	if (outarg.flags & FUSE_NOTIFY_STORE_NOWAIT)
+		fgp_flags |=3D FGP_NOWAIT;
+
 	down_read(&fc->killsb);
=20
 	err =3D -ENOENT;
@@ -1668,14 +1672,24 @@ static int fuse_notify_store(struct fuse_conn *fc, =
unsigned int size,
 		struct page *page;
 		unsigned int this_num;
=20
-		folio =3D filemap_grab_folio(mapping, index);
-		err =3D PTR_ERR(folio);
-		if (IS_ERR(folio))
-			goto out_iput;
+		folio =3D __filemap_get_folio(mapping, index, fgp_flags,
+					    mapping_gfp_mask(mapping));
+		err =3D PTR_ERR_OR_ZERO(folio);
+		if (err) {
+			if (!(outarg.flags & FUSE_NOTIFY_STORE_NOWAIT))
+				goto out_iput;
+			page =3D NULL;
+			this_num =3D min_t(unsigned, num, PAGE_SIZE - offset); /* XXX */
+		} else {
+			page =3D &folio->page;
+			this_num =3D min_t(unsigned, num, folio_size(folio) -
+					 offset);
+		}
=20
-		page =3D &folio->page;
-		this_num =3D min_t(unsigned, num, folio_size(folio) - offset);
 		err =3D fuse_copy_page(cs, &page, offset, this_num, 0);
+		if (!page)
+			goto skip;
+
 		if (!folio_test_uptodate(folio) && !err && offset =3D=3D 0 &&
 		    (this_num =3D=3D folio_size(folio) || file_size =3D=3D end)) {
 			folio_zero_segment(folio, this_num, folio_size(folio));
@@ -1683,7 +1697,7 @@ static int fuse_notify_store(struct fuse_conn *fc, un=
signed int size,
 		}
 		folio_unlock(folio);
 		folio_put(folio);
-
+skip:
 		if (err)
 			goto out_iput;
=20
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e9e78292d107..59725f89340e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -576,6 +576,12 @@ struct fuse_file_lock {
  */
 #define FUSE_EXPIRE_ONLY		(1 << 0)
=20
+/**
+ * notify_store flags
+ * FUSE_NOTIFY_STORE_NOWAIT: skip locked pages
+ */
+#define FUSE_NOTIFY_STORE_NOWAIT	(1 << 0)
+
 /**
  * extension type
  * FUSE_MAX_NR_SECCTX: maximum value of &fuse_secctx_header.nr_secctx
@@ -1075,7 +1081,7 @@ struct fuse_notify_store_out {
 	uint64_t	nodeid;
 	uint64_t	offset;
 	uint32_t	size;
-	uint32_t	padding;
+	uint32_t	flags;
 };
=20
 struct fuse_notify_retrieve_out {

