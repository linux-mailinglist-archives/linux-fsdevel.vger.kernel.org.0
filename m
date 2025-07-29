Return-Path: <linux-fsdevel+bounces-56273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E797CB15359
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 21:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44456546966
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 19:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB7324DD17;
	Tue, 29 Jul 2025 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jd4skOkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF115CD74;
	Tue, 29 Jul 2025 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816632; cv=none; b=WS1AuYfLkX+gAKvYoiCFBX5BPm7Xx6VTI/yshs1NvBLq2zLTMBAdiIlckoBwcGrOWS6jjjZBxr6vZzk4M1r+4zwerFJab0I4uoDu08HGanAnzTLgZ9ZXhK2rktt2YtLa19+S5vqnIJj6mGbR3kIO/Fp98JTDAOLf4k6zhvLlMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816632; c=relaxed/simple;
	bh=cYaKAt190if9UVc4Oa7npmYbfNH06PnRgXbvdFPQLdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNthphSGDITlF+b0Fm7rDtQ8z07fuPwM/S5YAXM8f+4c2fVll71LoLc46I6f4u/QMTH95gCprZZTVchjI30ld+eybR/bSEL0jKxr1dat9aOrxpzFnT8Aw75LYOhMC8e4hQVH98FMEQFoV4YJ2cKNczVV+F7f0lGs37OLfDkkSxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jd4skOkO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=i0nglvYkrH7J2zvPavxYXzbyRKEzRzlp39eLc/rRiPk=; b=Jd4skOkO9Ah7K6Ybuj4rhsIkpy
	PuFDlYpJfzfv2otRhCZ45CMrWK/nbVk8EQjX6YQ0z7/C7PZoTJzgSeZpQcnEsJTEqCkdrbHjeN3ly
	Yfgj8WPkQxf1S5eM0amuS9gkaxiLqHoqh5EBhkm5oUb+JsHJNM6YKHSBWax0pKcNlQiZMjAPXea/U
	I4ur0t3XE7opJyMqTYzqhBcLCPZfa0p7Q9ZMtv2Bm8P7D+yWZuTP4sG6QS3umMpWTdjPwPqHVUZbZ
	Mflz17BVI8nU6udd/WYW5wMaEXJb6BudXYLD+ejlVVfUHwRYMiDlA0IYfIzZac6WypjybF43rPPX0
	Qoqaf6Kg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugpov-0000000Gsuo-3pDp;
	Tue, 29 Jul 2025 19:17:05 +0000
Date: Tue, 29 Jul 2025 20:17:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-raid@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: align writeback to RAID stripe boundaries
Message-ID: <aIkeMTMJbdvNxjqf@casper.infradead.org>
References: <55deda1d-967d-4d68-a9ba-4d5139374a37@cybernetics.com>
 <aIkVHBsC6M5ZHGzQ@casper.infradead.org>
 <17323677-08b1-46c3-90a8-5418d0bde9fe@cybernetics.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17323677-08b1-46c3-90a8-5418d0bde9fe@cybernetics.com>

On Tue, Jul 29, 2025 at 03:01:28PM -0400, Tony Battersby wrote:
> Yes, you understand correctly.  The test creates a number of sequential
> writes, and this patch cuts the stream of sequential bios on the stripe
> boundaries rather than letting the bios span stripes, so that MD doesn't
> have to do extra work for writes that cross the boundary.  I am actually
> working on an out-of-tree RAID driver that benefits hugely from this
> because it doesn't have the complexity of the MD caching layer.  But
> benchmarks showed that MD benefited from it  (slightly) also, so I
> figured it was worth submitting.
> 
> The problem with using iomap_can_add_to_ioend() is that it returns
> true/false, whereas sometimes it is necessary to add some of the folio
> to the current bio and the rest to a new bio.

Hm.  Maybe something like this would be more clear?

(contents and indeed name of iomap_should_split_ioend() very much TBD)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9f541c05103b..429890fb7763 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1684,6 +1684,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 	struct iomap_folio_state *ifs = folio->private;
 	size_t poff = offset_in_folio(folio, pos);
 	unsigned int ioend_flags = 0;
+	unsigned thislen;
 	int error;
 
 	if (wpc->iomap.type == IOMAP_UNWRITTEN)
@@ -1704,8 +1705,16 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 				ioend_flags);
 	}
 
-	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
+	thislen = iomap_should_split_ioend(wpc, pos, len);
+
+	if (!bio_add_folio(&wpc->ioend->io_bio, folio, thislen, poff))
+		goto new_ioend;
+	if (thislen < len) {
+		pos += thislen;
+		len -= thislen;
+		wbc_account_cgroup_owner(wbc, folio, thislen);
 		goto new_ioend;
+	}
 
 	if (ifs)
 		atomic_add(len, &ifs->write_bytes_pending);

