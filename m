Return-Path: <linux-fsdevel+bounces-48100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E92AA9607
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F3F17A5D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C58B25A347;
	Mon,  5 May 2025 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="adRS+C3c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428E502BE;
	Mon,  5 May 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746456052; cv=none; b=Il48KsZbyb36gkWRF0ztDukbTQ8SG3S6gTM1cbuNfY7yEaON7HUCpVUiomtta25QKAetPBJsPasNpOxUiRjpc47dMfXSKNgk1FFX9K0BFHqjpCpcfxYcFMAR9be23M9Bu1XSiWUX0nQeebdCYr4IVB2CE4hEb3m1nLsf51aUEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746456052; c=relaxed/simple;
	bh=sQPK5j4xDlp+a+p/1ABDGOfzm3vYtUjDqYXiQ3WSBn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7P/nuQYr8/7aP6BtYVDatJlwI5eKpsKBr9c+qv6702ZZruRN0bkJlh8VnUHbhewBFt6NmrqanX87A66Buk1wA0cW0kRe0yHo8WfIrOqebr8NGA6qc1jq/P9ZBTpdPqlhWbDj+n6MMdQYnITFX0b3WWPZwWhUgxcDlEMrUC7Hd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=adRS+C3c; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YxF0AHIeTfpCSYwVnpBTidK7tkfBNMRp5DPdGTtY7b4=; b=adRS+C3cNQyXXDQRehjAQM6pXn
	fL/qWjKCEKsPiduMDUmWLgscYjXCT4tToOiIfI2l9Q4bwDrKpJxUksFuuH7K51POJjKu+0oDAPHKr
	UKTgOXEpE6evD+4+gP+GlHpSAeHtcl+vsn88sW5SJC1FGUWta7QpSsq8noKphb0IIplG+vOUTiDSv
	1IbkGUKYqTFt0d+Xk/ZNpyMZ+Na0EmcktmDetqW74LNz0zEkiDY/knmjLS+4Tc6lIEZXqlCKWnpMI
	jCVCMAijLp8kVOl37hKr5asUduzBrHi+wvBsq6V1d9U2MjDXozy7A7j5OXk0xZG4ThdChsrfRj5kf
	uZuLsm1w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBwzo-0000000Blxx-3hzM;
	Mon, 05 May 2025 14:40:40 +0000
Date: Mon, 5 May 2025 15:40:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH] swapfile: disable swapon for bs > ps devices
Message-ID: <aBjN6Bm3pwK_0WNO@casper.infradead.org>
References: <20250502231309.766016-1-mcgrof@kernel.org>
 <aBhZx_-qZCGoR7Ez@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBhZx_-qZCGoR7Ez@infradead.org>

On Sun, May 04, 2025 at 11:25:11PM -0700, Christoph Hellwig wrote:
> On Fri, May 02, 2025 at 04:13:09PM -0700, Luis Chamberlain wrote:
> > Devices which have a requirement for bs > ps cannot be supported for
> > swap as swap still needs work.
> 
> This should work just fine for swap through intelligent enough file
> systems not using the generic ->bmap based swap path, although
> performance would still be horrible.

"intelligent enough" is doing a lot of heavy lifting there.  Setting
aside that only netfs (nfs and cifs) implement ->swap_rw today, a
block fs which wanted to support sub-block-size swap accesses would
need to pad writes (not a huge problem), but on reads, it'd need to
either discard the extra data somewhere or (better) bring the other
pages into the swap cache.

Really, I think it needs a major rethink of the swap system, which is
happening anyway.

