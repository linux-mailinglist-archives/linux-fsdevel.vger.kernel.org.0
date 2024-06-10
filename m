Return-Path: <linux-fsdevel+bounces-21305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB3B901999
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 05:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3005C1C20E51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 03:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5938A953;
	Mon, 10 Jun 2024 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a2qTU3O1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74F524F;
	Mon, 10 Jun 2024 03:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717991392; cv=none; b=TWuOZ4pNp4aHvYB5+0v70IHNrJFWA63FRSwgpJOb/RCw7Quxz4WmPOnw/gortHsSU3PJdWtM/TslnoQqAiRq0lXI7jAFL84QrEdttDA1VS8IMm0IZTzNKDo9DOcBLyamWRa/o0IhYZxwDAtmD63hAQAD24k5V1QLHXCHYajKB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717991392; c=relaxed/simple;
	bh=GNFczgUrkO7ygrAlBbLlS7v6xYKhuU9FhDRVfEarIUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecmVhFLO9hBirYLi0LccMRJSlvhOqCQ/j+KcglnZ0IBK5VG2Y8orMJTeReeTv2MH+4GNZAzc0lwyu2j8Pq+ZOw3Lrre6XbNDo7o2gZYkPTj61lqKxVwXns/z3xt4JKnEo5FjR3eCc3KKrK9hSjpk01Ec1C23ziDdISXLdr7G8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a2qTU3O1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6zeyRcb+UnQLSBhCUqWO1SmkhhrRQveKMeLzcs+rE1w=; b=a2qTU3O1Pc23GUNyvyzjVCt1ec
	Y2tJDScltfNlQVffSWXcNGqM/WVDJBqakKRd+mP8yrt4lr78r5j4dCZD/lBJxb+LVxWFxNoNIRViC
	ma6ho/c9uRGiYpoMgYC2rDj3TCK07VZvcVGUwo+OgjWelGHA+IYDy3z4MHbKeux7qVzIQ5AmF3nfh
	NqM006pjbldpcKzGKNs8sh4DlrMYrACrqF2I92EAS4mceI1vfrIl5YunTvaQZIBZofp423QdzumLa
	thn+bjPGdtPa9tp0G6pVziIPI+Vg5LtWZfnnx6TenuAdI2bUoYboHup5wD1BqVry3NAfG9rkFJ51+
	jQCBYegA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGW2N-00000008ZAk-395W;
	Mon, 10 Jun 2024 03:49:39 +0000
Date: Mon, 10 Jun 2024 04:49:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: The proper handling of failed IO error?
Message-ID: <ZmZ3001_gcjAryte@casper.infradead.org>
References: <960aa841-8d7c-413f-9a1b-0364ae3b9493@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960aa841-8d7c-413f-9a1b-0364ae3b9493@gmx.com>

On Mon, Jun 10, 2024 at 06:50:11AM +0930, Qu Wenruo wrote:
> Hi,
> 
> There is a recent (well a year ago) change in btrfs to remove the usage
> of page/folio error, which gets me wondering what would happen if we got
> a lot of write errors and high memory pressure?
> 
> Yes, all file systems calls mapping_set_error() so that fsync call would
> return error, but I'm wondering what would happen to those folios that
> failed to be written?
> 
> Those folios has their DIRTY flag cleared before submission, and and
> their endio functions, the WRITEBACK flags is also cleared.
> 
> Meaning after such write failure, the page/folio has UPTODATE flag, and
> no DIRTY/ERROR/WRITEBACK flags (at least for btrfs and ext4, meanwhile
> iomap still set the ERROR flag).
> 
> Would any memory pressure just reclaim those pages/folios without them
> really reaching the disk?

Yes.

Core code doesn't (and hasn't in some time) checked the page/folio
error flag.  That's why it's being removed.

Also, btrfs was using it incorrectly to indicate a write error.
It was supposed to be used for read errors, not write errors.
Another good reason to remove it.

