Return-Path: <linux-fsdevel+bounces-72073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B9BCDCEE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 18:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E51A33010E69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485AF2F4A14;
	Wed, 24 Dec 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hEbDHtur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A781DF736;
	Wed, 24 Dec 2025 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766597230; cv=none; b=VvnwrAAGeCLn2Wnh29gI5tdxOrrsOadvSI8lODxuwchPDpUQzY/8Ep2C9FPNC34phylprttMiEfQoypfmFFBUyxMIVDBPSf1joHvlu1NEfjrI5ED/XYgEwWh8JEzl3YuXMTWqa3z2MqXbJ11LaZuYMz+ka9QfvANqoUnlrBG1yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766597230; c=relaxed/simple;
	bh=BdDdqihR6xqBfpXM60AqeMWUAY/5T77gZXYrsV7bqm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0yyIIh+neVQ7xBi+5QpxfghEvMxRU4gXfEhJAUyTumG0hR2k+hGl6Ko9OEy5hXhIXJYyDwdRydyDR2sZDnpPF/+tgWLqTnvoQQGkw/v/2YDQ6C1u4ouej7zjKbu/aGq8DCXBrZLUKBYsCbnULesvvfT57iOwQyBSBJjSZgafj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hEbDHtur; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t4DBCX4IjIfbtOcEZ5tm+Y855ePEDhpBMI0gdq2wPgU=; b=hEbDHturTlAlcug9OEyvI5iyZR
	UeB/FQtxykwqwUdGwq5Kh3hK3PBOi4BC8zX9VW/KnA3Qz+LxsmCokNGdo32j+/+012Wa/Mzxv59mF
	vpJ+wJRrf3auISbOfz3fsYe6EahdtSagjHscHzkNsyLC9/RgQJLVVjumavsMpLVm9yreJyp6GOmQV
	Irb8K5ECZf/1hpZMrqE/zF968EOZHsU/Rpl189XRXCXHfilOmQ0jacwoml+sY0Srs6n4nfmhDKO0m
	KmumQ2vrC5IGNGhkvWgdDzz4iJOWllqrui4OE7VxX0cU5KDoRgxX383ILign6xf2GBDIX598d6TmX
	06u7AFOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYSdc-0000000EWEF-0fiN;
	Wed, 24 Dec 2025 17:27:04 +0000
Date: Wed, 24 Dec 2025 17:27:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
Message-ID: <aUwiZ0Rurc8_aUnW@casper.infradead.org>
References: <20250926002609.1302233-13-joannelkoong@gmail.com>
 <20251223223018.3295372-1-sashal@kernel.org>
 <20251223223018.3295372-2-sashal@kernel.org>
 <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
 <aUtLi37WQR07rJeS@casper.infradead.org>
 <aUwKPtahCaMipU83@laps>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUwKPtahCaMipU83@laps>

On Wed, Dec 24, 2025 at 10:43:58AM -0500, Sasha Levin wrote:
> On Wed, Dec 24, 2025 at 02:10:19AM +0000, Matthew Wilcox wrote:
> > So Sasha has produced a very convincingly worded writeup that's
> > hallucinated.
> 
> And spent a few hours trying to figure it out so I could unblock testing, but
> sure - thanks.

When you produce a convincingly worded writeup that's utterly wrong,
and have a reputation for using AI, that's the kind of reaction you're
going to get.

> Here's the full log:
> https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.18-rc7-13806-gb927546677c8/testrun/30618654/suite/log-parser-test/test/exception-warning-fsiomapbuffered-io-at-ifs_free/log
> , happy to test any patches you might have.

That's actually much more helpful because it removes your incorrect
assumptions about what's going on.

 WARNING: fs/iomap/buffered-io.c:254 at ifs_free+0x130/0x148, CPU#0: msync04/406

That's this one:

        WARN_ON_ONCE(ifs_is_fully_uptodate(folio, ifs) !=
                        folio_test_uptodate(folio));

which would be fully explained by fuse calling folio_clear_uptodate()
in fuse_send_write_pages().  I have come to believe that allowing
filesystems to call folio_clear_uptodate() is just dangerous.  It
causes assertions to fire all over the place (eg if the page is mapped
into memory, the MM contains assertions that it must be uptodate).

So I think the first step is simply to delete the folio_clear_uptodate()
calls in fuse:

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..b819ede407d5 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1194,7 +1194,6 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
 	unsigned int offset, i;
-	bool short_write;
 	int err;
 
 	for (i = 0; i < ap->num_folios; i++)
@@ -1209,22 +1208,16 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	if (!err && ia->write.out.size > count)
 		err = -EIO;
 
-	short_write = ia->write.out.size < count;
 	offset = ap->descs[0].offset;
 	count = ia->write.out.size;
 	for (i = 0; i < ap->num_folios; i++) {
 		struct folio *folio = ap->folios[i];
 
-		if (err) {
-			folio_clear_uptodate(folio);
-		} else {
+		if (!err) {
 			if (count >= folio_size(folio) - offset)
 				count -= folio_size(folio) - offset;
-			else {
-				if (short_write)
-					folio_clear_uptodate(folio);
+			else
 				count = 0;
-			}
 			offset = 0;
 		}
 		if (ia->write.folio_locked && (i == ap->num_folios - 1))

