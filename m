Return-Path: <linux-fsdevel+bounces-18189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD598B637A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 22:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1079EB213C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2701420BC;
	Mon, 29 Apr 2024 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kZEHtgTt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F5283CB9;
	Mon, 29 Apr 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422410; cv=none; b=HSxkb5P64ilRcy+Scvm1afrOsemA5A3Or4P9sCiOaoh7vr/Wk6hlIoo/AhTMHSBUHxqbacsWA+dQrWjLxZor2kOmxtg9HCMHooY7Cyr+X5dLb6lmkEm0XP/iTQHvFbVq5+Ado7MEDjwELVbiGJjZlUZZeMUt1BfuYCnbPJkiIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422410; c=relaxed/simple;
	bh=mAgt/YGNnQ2kWH8WnqrHUEzvvNIHatYFh6dS/8cOIYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTFTS3jSil4jGNf6x1P12Pc6yhJefV9LiCGkmlfqP6uuozMkiUbq7aWWmBCWbsvyOlMV1O0OH43FjohW1ejOXUZW556mdmffzSOYgtWBQYN93L9g5W7ov8IMvy3VJ6MF58G4+/FhLbaC2AiTmAx+gon+KV72pBRc5lbcGFCzjXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kZEHtgTt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XElX0lvIknbzU1NDM+bexuVd/PeN5erbXNf5T0HVgR0=; b=kZEHtgTtATtVM7PAa6DPuem5Qs
	A1s2t7aJxmzFsYPCNADQLan2N8aOxgW6ra1ZK7K74lVVy0UUCQ5DqB/sIBFziUhBWjYmJ5XAm43e9
	zrqfI5C0ONWscynumaTB5MOl7/zquJgdbtSwoSN8Zm1pVeNTorZsN1q1AZdzJMwWwA/TSRrYxw6hW
	KwpfxYh76/u3y0U4EzpeJHi78OPrk2R22ZFe4gnnJupQEdwPu7Fn1u8MEEviDBJiGmvULVTEdQS0l
	bZyLP5pI4ro16wfeBB2cJqkWzCIEy4nqiKrhaw1P3kP0yc+zHsV2abJMSxp6TLhiM9WvhV+1nd9Vp
	IzMWksWw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1XZy-0000000DGF8-2VzG;
	Mon, 29 Apr 2024 20:26:26 +0000
Date: Mon, 29 Apr 2024 21:26:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Steven French <Steven.French@microsoft.com>
Cc: Kairui Song <kasong@tencent.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Shyam Prasad <Shyam.Prasad@microsoft.com>,
	Bharath S M <bharathsm@microsoft.com>
Subject: Re: [EXTERNAL] [PATCH v3 05/12] cifs: drop usage of page_file_offset
Message-ID: <ZjACcpyw1BDRT0dO@casper.infradead.org>
References: <20240429190500.30979-1-ryncsn@gmail.com>
 <20240429190500.30979-6-ryncsn@gmail.com>
 <SA0PR21MB1898817BA920C2A45660DE65E41B2@SA0PR21MB1898.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR21MB1898817BA920C2A45660DE65E41B2@SA0PR21MB1898.namprd21.prod.outlook.com>

On Mon, Apr 29, 2024 at 08:19:31PM +0000, Steven French wrote:
> Wouldn't this make it harder to fix the regression when swap file support was temporarily removed from cifs.ko (due to the folio migration)?   I was hoping to come back to fixing swapfile support for cifs.ko in 6.10-rc (which used to pass the various xfstests for this but code got removed with folios/netfs changes).

It was neither the folio conversion nor the netfs conversion which
removed the claim of swap support from cifs, but NeilBrown's
introduction of ->swap_rw.  In commit e1209d3a7a67 he claims that

    Only two filesystems set SWP_FS_OPS:
    - cifs sets the flag, but ->direct_IO always fails so swap cannot work.
    - nfs sets the flag, but ->direct_IO calls generic_write_checks()
      which has failed on swap files for several releases.

As I recall the xfstests only checked that swapon/swapoff works; they
don't actually test that writing to swap and reading back from it work.

