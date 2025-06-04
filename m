Return-Path: <linux-fsdevel+bounces-50666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B8ACE477
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 20:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A241E1799B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4642201013;
	Wed,  4 Jun 2025 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o2e9H9Fo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761517548;
	Wed,  4 Jun 2025 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749062545; cv=none; b=RS85vU7YASFBX0GqdLIIbdq/9MJhhtCLQRIOdKL8ueyKwCg57fTR871iQC1DQAdtWbj+GSEDEDOddRCTNB4hqDWnOPjOryHCqnO41BHV2zmTc+bVWhfzhikLo+j8aCsxmOmHwna/QgVu4VdtZzBPZgBTFGTKlejUmAPjozqVyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749062545; c=relaxed/simple;
	bh=+2X/bgyITqz/4nEEgb7clgtjFWt00lfOkFLk11U/WvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucGYoy/fy7TdN7qW5gv18jNqb2DZVUKX2QQoCTRAT0tXBopapJVjZHTs7dsIMYTETQZb1iG8e4MH+KRSGmINvaGMOFo6jhe/i5w5drzLJrj6aJdNPbBVs0yLBC8i1YAOY+3bj4fbnD/FEoojAQ1PqFwY9QdHW4uZsNvjFHJ/W+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o2e9H9Fo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UYCq4nc4AwozKNajBZ2RohKtwW3tkU8YAfBAV4718q4=; b=o2e9H9FoOO7MAp+0kndaY4zIQl
	bgJQgafG1lhYqm+qBZWFTg3cUIFtiMYD/6xZuAC3dsaxcIho6/lM/1U5rSQsoJryKbnGm45WVLdzM
	kDN6UHxNXF93v3NkqOB/UWSjZGyWqZg8T0g4NgJ3w7b4vc+S63gyRGAg2SdECXvlrgspXh4Jc+CyV
	8NlZRSKsC3Y3YphNJSq9No/ByeLDu/nqHbiPawtEEobdlXKFqFK23siTrYyFp8IUpBvHOr0S21+Tc
	TJv1OHWNB8ZSn44HaJ4E7sRhw+aHh6NhA12cnN2Aa0FggHFFFK6psOTcpjs9L+ESyB2TVzNnoNYsx
	/CFH8riQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMt3z-00000003OmV-2tly;
	Wed, 04 Jun 2025 18:42:11 +0000
Date: Wed, 4 Jun 2025 19:42:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yafang Shao <laoar.shao@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
	joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: kvmalloc: make kmalloc fast path real fast path
Message-ID: <aECTg4r_a-Rp8cqP@casper.infradead.org>
References: <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
 <Z-43Q__lSUta2IrM@tiehlicka>
 <Z-48K0OdNxZXcnkB@tiehlicka>
 <Z-7m0CjNWecCLDSq@tiehlicka>
 <Z_XI6vBE8v_cIhjZ@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_XI6vBE8v_cIhjZ@dread.disaster.area>

On Wed, Apr 09, 2025 at 11:10:02AM +1000, Dave Chinner wrote:
> On Thu, Apr 03, 2025 at 09:51:44PM +0200, Michal Hocko wrote:
> > Add Andrew
> > 
> > Also, Dave do you want me to redirect xlog_cil_kvmalloc to kvmalloc or
> > do you preffer to do that yourself?
> 
> I'll do it when the kvmalloc patches evntually land and I can do
> back to back testing to determine if the new kvmalloc code behaves
> as expected...
> 
> Please cc me on the new patches you send that modify the kvmalloc
> behaviour.

FWIW, this has now landed in Linus' tree as 46459154f997:

                if (!(flags & __GFP_RETRY_MAYFAIL))
-                       flags |= __GFP_NORETRY;
+                       flags &= ~__GFP_DIRECT_RECLAIM;


