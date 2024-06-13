Return-Path: <linux-fsdevel+bounces-21656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C9C90775F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 17:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B131F24EE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4882D15AD9C;
	Thu, 13 Jun 2024 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ERvfPeDP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E21614198E;
	Thu, 13 Jun 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293244; cv=none; b=WPGW7YT4TVM3fRcih2Jn5yS7D9uECaOAyWIRNs2fMquz9fmgam9qAiOc6tj5mNsrvgcwKlP80wmmlNonsYhbk8/aYM6BU2mRSgJX5itCPhdmFYwupb9xcTL18BHfcSSelK3EdocqUpHtXzcN0Q55Me1157B34xavcSLT+n+jJlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293244; c=relaxed/simple;
	bh=N+sDX7ZbU5QCuJT6w9YMdnRaDrdkZf5y5viAAmIsDG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAPN0fhNG/U2WIQWOwP/SKv2yuhXuRC5KV/AeLzX+KKGDNWPxWHvcFY0QhQ8AvpftHbYV5ASR6HR0ExkFJg5TGZVM38t+laPyoaDh29MOxtFyluSYIMUteD4IgvzMOeGD/wRLC4JRZp0Uw0uqtJ05enr2qFFSAyeyVgtosVeecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ERvfPeDP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yzkTNbdD0a2c3NKP5uSb0sKP6o4WHMSdtJob2Y7Lf9Y=; b=ERvfPeDPd5l14AF4yJ+ldt9Nxz
	7bS1JZiLy38Xf8wDo1A0V82qM67Vcpl4Hd18YEIdOpUE2l68glcOxjLeR/M86injkZp45uVvSyGwB
	7Ag/sfbWYK4LDA+e6kncbnlWIOp5gMidKClL5x4raeJIt40QGuz0wb8qQx/slJbGswml3lq/zlmQX
	B13i8h5Xj460i6GnPDJUEGQ8RtYJVZP5fPBsBjxRS0nQ5SkIRy8Pi/WcHqAn9a5oXDNjfmapzJ/Lt
	C/i9zs92LoKtssDB0DvCPnBXCIbOZKLAHY2YqGxy9Gwk4NKmxB+PiaqN6Rqo1yofXq7sFl8G/2p0e
	+8LPn/RA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHmYu-0000000Furm-1Tae;
	Thu, 13 Jun 2024 15:40:28 +0000
Date: Thu, 13 Jun 2024 16:40:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
	yang@os.amperecomputing.com, linmiaohe@huawei.com,
	muchun.song@linux.dev, osalvador@suse.de,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	hare@suse.de, linux-kernel@vger.kernel.org,
	Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 06/11] filemap: cap PTE range to be created to allowed
 zero fill in folio_map_range()
Message-ID: <ZmsS7JipzuBxJm92@casper.infradead.org>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-7-kernel@pankajraghav.com>
 <ZmnyH_ozCxr_NN_Z@casper.infradead.org>
 <ZmqmWrzmL5Wx2DoF@bombadil.infradead.org>
 <818f69fa-9dc7-4ca0-b3ab-a667cd1fb16d@redhat.com>
 <ZmqqIrv4Fms-Vi6E@bombadil.infradead.org>
 <b3fef638-4f4a-4688-8a39-8dfa4ae88836@redhat.com>
 <ZmsP36zmg2-hgtak@bombadil.infradead.org>
 <ZmsRC8YF-JEc_dQ0@casper.infradead.org>
 <ZmsSZzIGCfOXPKjj@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmsSZzIGCfOXPKjj@bombadil.infradead.org>

On Thu, Jun 13, 2024 at 08:38:15AM -0700, Luis Chamberlain wrote:
> On Thu, Jun 13, 2024 at 04:32:27PM +0100, Matthew Wilcox wrote:
> > On Thu, Jun 13, 2024 at 08:27:27AM -0700, Luis Chamberlain wrote:
> > > The case I tested that failed the test was tmpfs with huge pages (not
> > > large folios). So should we then have this:
> > 
> > No.
> 
> OK so this does have a change for tmpfs with huge pages enabled, do we
> take the position then this is a fix for that?

You literally said it was a fix just a few messages up thread?

Besides, the behaviour changes (currently) depending on whether
you specify "within_size" or "always".  This patch makes it consistent.

