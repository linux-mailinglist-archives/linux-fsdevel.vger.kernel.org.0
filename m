Return-Path: <linux-fsdevel+bounces-17809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2633B8B26A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 18:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AAF1C213DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5407E14A0BC;
	Thu, 25 Apr 2024 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t3N+kf1K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026692B9D9;
	Thu, 25 Apr 2024 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063140; cv=none; b=Qg+hfGyE/iG5OjR75hnq287uMemu40ZbnCGck99DTytLnIzk/Tibsd9Wzzpwy64KzGia/5hkboPPOhDSUgy6McH6v3zHjSkI+R+cTFWQV1vtCle7fOa3mlpkYmSFW/nAWJ84wgUpDYykBZjBRhALDq/tcQ3k3LBaVH+JTrnzHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063140; c=relaxed/simple;
	bh=YARPD46VDFMDCYG+K9KmoPUt++sEYCY1a6WhSp1ktbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+7m4wWiSzj8yV9OPh5DHk10Mn2XqWO+fRpuLdvormEwha09WGgQJL9jyB2FC7kuVURlWHU2OHUjWHRq3Et+oH+SO6SHAyh1pmmQd6PBjvSDYYYMUCeOhock1uZEdCnHrDw59So/klhDvYTI/eKB5on3r1QhjcRCCboPz+BUi1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t3N+kf1K; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=voPz10PqfUdZPyXDZ6OkfxWBZOsqfaFSqcPdnM4FhBM=; b=t3N+kf1K9mPdiKpeO2oIgL4FY4
	2QNERVMw7QThARXY3K+hAx6cEAsZKhqn8HBkknTDjm2K1WZu2O0NJK3VUy/2QgjwCpCg5Q0r7F2lt
	1KGP1q28OIBVGvN03PXOWg7F5x7rygIijXihmwTf/ErioPgwbmplJMCyqLr73iMWFlRCSc6OxsF5+
	fHOV3KAQ6lzUdHoIYb+9GHxVZ+EYfoLdh2crOESSl85ESHy1hhhaaRsL2m3LSIlkIXzfr563jZvWG
	WeQbsxUMcUOyDrgnd/KBMuUjlM/hgkT940OwwYQmZWjCcdZXRDDlo0KfzvqGyv+FS8XfVQkLYZaXw
	7uWAR80g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s027c-00000003OUu-1B2E;
	Thu, 25 Apr 2024 16:38:56 +0000
Date: Thu, 25 Apr 2024 17:38:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/30] btrfs: Use a folio in write_dev_supers()
Message-ID: <ZiqHIH3lIzcRXCkU@casper.infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-3-willy@infradead.org>
 <20240425144403.GQ3492@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425144403.GQ3492@twin.jikos.cz>

On Thu, Apr 25, 2024 at 04:44:03PM +0200, David Sterba wrote:
> On Sat, Apr 20, 2024 at 03:49:57AM +0100, Matthew Wilcox (Oracle) wrote:
> > @@ -3812,8 +3814,7 @@ static int write_dev_supers(struct btrfs_device *device,
> >  		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> >  		bio->bi_private = device;
> >  		bio->bi_end_io = btrfs_end_super_write;
> > -		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
> > -			       offset_in_page(bytenr));
> > +		bio_add_folio_nofail(bio, folio, BTRFS_SUPER_INFO_SIZE, offset);
> 
> Compilation fails when btrfs is built as a module, bio_add_folio_nofail()
> is not exported. I can keep __bio_add_page() and the conversion can be
> done later.

I'd rather you added the obvious patch I just sent ...

(please don't get me stuck in the infinite loop of "you can't export a
symbol without any users" "you can't add a user until this is exported")

