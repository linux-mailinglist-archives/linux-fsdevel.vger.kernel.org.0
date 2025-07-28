Return-Path: <linux-fsdevel+bounces-56149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F31B14141
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 19:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23885411FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E20627587C;
	Mon, 28 Jul 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lfmn6Cqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35071E5B60;
	Mon, 28 Jul 2025 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724072; cv=none; b=CE5B9d4146dc8Jh7nBKIs+uAOuuwxFgOhHlz92gGg1KeEDS7V1bbj1v2jQiMDVgs+L8qWJUiWxj/KdBybhtI+Epr7mvl6+0vLqVkUJDvmdkNPwpZEE4EN6frZ6DEhAI9g4aHyzJKouMCt+M3/VMIIicMTCf+hZme1QM+iRCv7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724072; c=relaxed/simple;
	bh=H+qJ3VsmLYnhXL8M1dlj3FhFxU65ltQR/R9/oXPPEPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sU9BA+DA8fUg9oxIrazKFXRWFjI9Zx8dRcXjOELCywnc6zxIhqjCkFbg/OAwld9bdhgLLjMtMYBZsqor02LHHdXagTB+gJxP8pSQVWAJzrCPeOkBGzYFx7d2zyTn/aQYCelUb1x9w4f/OyGiqifRisOb6yTVEoCfrpeXcYZX71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lfmn6Cqk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UqDXWAxgebVs6SjAbN0f5M+jCa7IiTLdF4RA9QqoSVg=; b=lfmn6CqkKhTXqOeyMQ1VarfYAP
	+btVaS1jPbtSnxWAdty5IIUiuM66govjO0Sho7Y5dOueCDjX+SJWeoUMPxnpt/2wNOBG5dB0ul1vZ
	k0spiHeceACX7KDWckEZiOpcS0Pkl0nNeQkYeiJ5uIIoc1YIY5j+RRMUll5+eO030vwbcfYsYlxS6
	UEyq5xgKSq+kG84qqFMi0Mi7+E44j42/OrE2WKnwF8iMnVH/yC+89p/iq40irvIkSHu3EZ92qipMX
	JU28Ggr9sfmYB0E1d5IHq1YV+65QDsyLmTOJH0as7gLtBGgQh9ES37Dc5aVTW+S4EQ27GhNFPBrzl
	XbO8XQNg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugRk2-0000000FyPy-11wc;
	Mon, 28 Jul 2025 17:34:26 +0000
Date: Mon, 28 Jul 2025 18:34:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	linux-xfs@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <liam.howlett@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250721 arm64 16K and 64K page size WARNING fs fuse file.c
 at fuse_iomap_writeback_range
Message-ID: <aIe0ouF9tsuIO58_@casper.infradead.org>
References: <CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com>
 <20250723144637.GW2672070@frogsfrogsfrogs>
 <CAJnrk1Z7wcB8uKWcrAuRAZ8B-f8SKnOuwtEr-=cHa+ApR_sgXQ@mail.gmail.com>
 <20250723212020.GY2672070@frogsfrogsfrogs>
 <CAJnrk1bFWRTGnpNhW_9MwSYZw3qPnPXZBeiwtPSrMhCvb9C3qg@mail.gmail.com>
 <CAJnrk1byTVJtuOyAyZSVYrusjhA-bW6pxBOQQopgHHbD3cDUHw@mail.gmail.com>
 <CAJnrk1ZYR=hM5k90H57tOv=fe6F-r8dO+f3wNuCT_w3j8YNYNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZYR=hM5k90H57tOv=fe6F-r8dO+f3wNuCT_w3j8YNYNQ@mail.gmail.com>

On Fri, Jul 25, 2025 at 06:16:15PM -0700, Joanne Koong wrote:
> > > > > Also, I just noticed that apparently the blocksize can change
> > > > > dynamically for an inode in fuse through getattr replies from the
> > > > > server (see fuse_change_attributes_common()). This is a problem since
> > > > > the iomap uses inode->i_blkbits for reading/writing to the bitmap. I
> > > > > think we will have to cache the inode blkbits in the iomap_folio_state
> > > > > struct unfortunately :( I'll think about this some more and send out a
> > > > > patch for this.

Does this actually happen in practice, once you've started _using_ the
block device?  Rather than all this complicated stuff to invalidate the
page cache based on the fuse server telling us something, maybe just
declare the server to be misbehaving and shut the whole filesystem down?


