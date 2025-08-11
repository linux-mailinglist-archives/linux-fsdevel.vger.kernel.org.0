Return-Path: <linux-fsdevel+bounces-57257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AE5B20062
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699CC3ACDA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 07:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021542D97B7;
	Mon, 11 Aug 2025 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4Aw279L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113C4299AA3
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897657; cv=none; b=ZV1RX1Ri4zPsZhgpf6mq3qLbJIY3d0tUHD0pi12XBMErfCM+hxCFXgJWtD6vg0rjdCPcoo5qsXF8C8+5oKNCN1AlUs6rlaRQLgMzKWFoBPP8poGare++lfuT/EfkSaQHL5PBX5KxCmpjFchiDU4gYiId7V0aQVKdNkthbVSnGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897657; c=relaxed/simple;
	bh=dK7SLDDhLK24LOoQxG4hZlXuF4fqefgKWahWen4Gd2I=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=ZPa3LlOw/nGKW53kYtkGuLX0p/+8oE8kJTihyxMnaCE6WyWk5Jv+QBmlpYfxR+z7A1UanVeGUZmDTUjkp9WNigGvHia06yOaTZjBe9azkraOPtjsSXF+Pn1BDkoOx8cunr4F/91DZ4lNt6MiMUzHNCsQuVMkGc5XrTJujBj7/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4Aw279L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754897653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q9vbhTv66yOj5MFJijPbRoZX2tGXwBihvDtRn9EhSDY=;
	b=G4Aw279LjgnzzQGXzOaGlxE6QybK7OthRbebQzQT2WV/wwG0MGaX4oL7nnr0VEKGJF1976
	zhanKrlLcmADrA6ScTmCTA7PvGCo8f+ip/rW/BGLnhPKlPVv1Hg3lOk4DmnuSvVKj0mqCX
	/VSV4cMbYhn5/PZuQ4m+JFxiVz7Tmb4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-KjcMOzISNPWa7lE9yECnSQ-1; Mon,
 11 Aug 2025 03:34:10 -0400
X-MC-Unique: KjcMOzISNPWa7lE9yECnSQ-1
X-Mimecast-MFC-AGG-ID: KjcMOzISNPWa7lE9yECnSQ_1754897649
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99F1D18002C1;
	Mon, 11 Aug 2025 07:34:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BDA3180047F;
	Mon, 11 Aug 2025 07:34:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>,
    Enzo Matsumiya <ematsumiya@suse.de>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix collect_sample() to handle any iterator type
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <324663.1754897644.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Aug 2025 08:34:04 +0100
Message-ID: <324664.1754897644@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

collect_sample() is used to gather samples of the data in a Write op for
analysis to try and determine if the compression algorithm is likely to
achieve anything more quickly than actually running the compression
algorithm.

However, collect_sample() assumes that the data it is going to be sampling
is stored in an ITER_XARRAY-type iterator (which it now should never be)
and doesn't actually check that it is before accessing the underlying
xarray directly.

Fix this by replacing the code with a loop that just uses the standard
iterator functions to sample every other 2KiB block, skipping the
intervening ones.  It's not quite the same as the previous algorithm as it
doesn't necessarily align to the pages within an ordinary write from the
pagecache.

Note that the btrfs code from which this was derived samples the inode's
pagecache directly rather than the iterator - but that doesn't necessarily
work for network filesystems if O_DIRECT is in operation.

Fixes: 94ae8c3fee94 ("smb: client: compress: LZ77 code improvements cleanu=
p")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/compress.c |   71 +++++++++++++----------------------------=
------
 1 file changed, 21 insertions(+), 50 deletions(-)

diff --git a/fs/smb/client/compress.c b/fs/smb/client/compress.c
index 766b4de13da7..db709f5cd2e1 100644
--- a/fs/smb/client/compress.c
+++ b/fs/smb/client/compress.c
@@ -155,58 +155,29 @@ static int cmp_bkt(const void *_a, const void *_b)
 }
 =

 /*
- * TODO:
- * Support other iter types, if required.
- * Only ITER_XARRAY is supported for now.
+ * Collect some 2K samples with 2K gaps between.
  */
-static int collect_sample(const struct iov_iter *iter, ssize_t max, u8 *s=
ample)
+static int collect_sample(const struct iov_iter *source, ssize_t max, u8 =
*sample)
 {
-	struct folio *folios[16], *folio;
-	unsigned int nr, i, j, npages;
-	loff_t start =3D iter->xarray_start + iter->iov_offset;
-	pgoff_t last, index =3D start / PAGE_SIZE;
-	size_t len, off, foff;
-	void *p;
-	int s =3D 0;
-
-	last =3D (start + max - 1) / PAGE_SIZE;
-	do {
-		nr =3D xa_extract(iter->xarray, (void **)folios, index, last, ARRAY_SIZ=
E(folios),
-				XA_PRESENT);
-		if (nr =3D=3D 0)
-			return -EIO;
-
-		for (i =3D 0; i < nr; i++) {
-			folio =3D folios[i];
-			npages =3D folio_nr_pages(folio);
-			foff =3D start - folio_pos(folio);
-			off =3D foff % PAGE_SIZE;
-
-			for (j =3D foff / PAGE_SIZE; j < npages; j++) {
-				size_t len2;
-
-				len =3D min_t(size_t, max, PAGE_SIZE - off);
-				len2 =3D min_t(size_t, len, SZ_2K);
-
-				p =3D kmap_local_page(folio_page(folio, j));
-				memcpy(&sample[s], p, len2);
-				kunmap_local(p);
-
-				s +=3D len2;
-
-				if (len2 < SZ_2K || s >=3D max - SZ_2K)
-					return s;
-
-				max -=3D len;
-				if (max <=3D 0)
-					return s;
-
-				start +=3D len;
-				off =3D 0;
-				index++;
-			}
-		}
-	} while (nr =3D=3D ARRAY_SIZE(folios));
+	struct iov_iter iter =3D *source;
+	size_t s =3D 0;
+
+	while (iov_iter_count(&iter) >=3D SZ_2K) {
+		size_t part =3D umin(umin(iov_iter_count(&iter), SZ_2K), max);
+		size_t n;
+
+		n =3D copy_from_iter(sample + s, part, &iter);
+		if (n !=3D part)
+			return -EFAULT;
+
+		s +=3D n;
+		max -=3D n;
+
+		if (iov_iter_count(&iter) < PAGE_SIZE - SZ_2K)
+			break;
+
+		iov_iter_advance(&iter, SZ_2K);
+	}
 =

 	return s;
 }


