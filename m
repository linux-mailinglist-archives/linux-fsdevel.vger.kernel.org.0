Return-Path: <linux-fsdevel+bounces-67525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D80BFC4275F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 06:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83C7234AC15
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 05:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925C22D5A07;
	Sat,  8 Nov 2025 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c9BGTl1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871B24886E
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Nov 2025 05:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762578036; cv=none; b=UezIAN0dcZGQvQXb89gJVxx4GNaSRuYMxPoGb6ngb3kCDCoy3VWViFvPnoSnzcyUeRZgd3/nd8nMa04FVkWsZoczNP2O1sMSwyLiAIs3kAfJ8Vu6MT/Obd3dPnKiA/c24JgL/QtQ+hpNMVUkLCIT8PyWBrqW9a8kZWmsOV1AFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762578036; c=relaxed/simple;
	bh=TTP/E6MDNVKqZfSdAt/Q7h6Myauh55qgKsdz2sOCuo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBVqkxkAQB2Svz+h8l7DBFcVcMYo1tEqb8GtLaZaEQhm4wbALRlte7kRpKMFxP5HvyklcB7y7jlV5BI+GOVL5WcPZwFQmPKXQ8HCfLlAM5FhQupWzDuZ32Ott2n2mwkPpeHOZAPOX5f8WCzqOJ/WgEfwDVS1Xn+6zEruFN1YRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c9BGTl1I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3Uicbi0GzrwSMJpZH2t7k0frWbxeMbuqQjQce1tcheY=; b=c9BGTl1IhpGMc9TG9YorRjI7Wa
	U+f+thBN5xTPat81KAWaLN3ryZjJvTB5eRqJfXQSinjl4FUTrIJ69r41RohLuxdiHYbiOm96L0t4c
	E2Aec+1dECFxXC6QWT1toOEr/cDVt/iAkzvZsrDdunN/b3D6c2qOl/wakEfOeYKmYfHW8h5xeOlPB
	dzbuzv7hYTAHA4sArHbeF7Om5WeJ/diVhKJACE6yydWpzfN8v/4Fg0pmaQrETTc4Fx33+DSE132X9
	Zqd6Jv2/0oxcjmBAbuC4JOYOMhGEH4Gs/n6QZ4RjLg7+HLl0hieST60DtGmxHg6vurTQQLpAYQVlm
	Cvfs80ow==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHb3s-00000009gXx-3I0G;
	Sat, 08 Nov 2025 05:00:28 +0000
Date: Sat, 8 Nov 2025 05:00:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 10/10] mm: Use folio_next_pos()
Message-ID: <aQ7ObHvd8FXb8Taz@casper.infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-11-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024170822.1427218-11-willy@infradead.org>

On Fri, Oct 24, 2025 at 06:08:18PM +0100, Matthew Wilcox (Oracle) wrote:
> +++ b/mm/truncate.c
> @@ -387,7 +387,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
>  	same_folio = (lstart >> PAGE_SHIFT) == (lend >> PAGE_SHIFT);
>  	folio = __filemap_get_folio(mapping, lstart >> PAGE_SHIFT, FGP_LOCK, 0);
>  	if (!IS_ERR(folio)) {
> -		same_folio = lend < folio_pos(folio) + folio_size(folio);
> +		same_folio = lend < folio_next_pos(folio);

This causes an intermittent failure with XFS.  Two reports here:
https://lore.kernel.org/linux-xfs/aQohjfEFmU8lef6M@casper.infradead.org/

This is a fun one.  The "fix" I'm running with right now is:

-               same_folio = lend < folio_next_pos(folio);
+               same_folio = lend < (u64)folio_next_pos(folio);

folio_pos() and folio_next_pos() return an loff_t.  folio_size() returns
a size_t.  So folio_pos() + folio_size() is unsigned (by the usual C
promotion rules).  Before this patch, this was an unsigned comparison
against lend, and with the patch it's now a signed comparison.  Since
lend can be -1 (to mean 'end of file'), same_folio will now be 'true'
when it used to be 'false'.

Funnily, on 32-bit systems, size_t is u32 and loff_t is s64, so their
addition is also s64.  That means this has been wrong on 32-bit systems
for ... a while.  And nobody noticed, so I guess nobody's testing 32-bit
all that hard.

Anyway, what's the *right* way to fix this?  Cast to (unsigned long
long)?  There's an ssize_t, but I really want the opposite, a uloff_t.

(now i'm going to go back through all the other patches in this series
and see if I've made the same mistake anywhere else)

