Return-Path: <linux-fsdevel+bounces-17954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652498B42D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 01:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3E11C219D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 23:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CF33C06B;
	Fri, 26 Apr 2024 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xRE0wDIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DAF25774;
	Fri, 26 Apr 2024 23:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175177; cv=none; b=PqSsUJevJ/eo9X3CEeOKe2Wqi2gHMeTDnDqp1BMYBMsEfh74LW6OwGipu0+GdBBHqdhmmq3npgINqP8IP/xymGHq2cdIYnHQvlfMGnMoM3sbjD8bb4zS0ScXWthbttFVwDcF++ctUj1VdlinAYuPxm5amRuOWWSz3nUqmKsF8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175177; c=relaxed/simple;
	bh=shcFPaG02bDB4GVRHw+7yeBUIeLQfnWcPP4M6dkAQO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbXzjsBjvzT5KYAyJWpDZkCTg/rkMqqVycTH1k2zwuhRjFg+D2ry/uC2JucH6n6sTZDDYjaEYLIoUhuTUEVD2xPkRTl0mFTKZx+b4ZCaSftSk/3sxGmvUD3XL7xhS9jCg8Q3z721OqQIXLSW1G9mDQjuHcMSlBfa1COa8x1bfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xRE0wDIs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oEICw/YBQkHFydzURongpQCI84RNVUsQ3AXdXR1HsB8=; b=xRE0wDIs5SY5sV0mNmw7sdP037
	4tOO5LC8H0SVowqjZeSy9lYEmZJYVFvcjBVXyNnehBzVqXcRwDjohOENq26j/98PrZkhAQP8qNrJk
	yCEbmT7DXmmwydHutCZPtO8vBDheohXL91jYHolL5nYoy4K3FU6Yga6nYPJDS7xoxVmzZ+toNricm
	rbnAabsp0fEd8cxbBi5hivc2rBXSDUMrSCkjDWPqh995LL41quiI2FQlmVNsIN+/4sJ2MbjmxH/84
	5V3qxlcw9ou7VzvTUNMijxpdELciJt92Q3k7USXxzcUqmtDSBiRLbbpsTcdUxolacCAGcNUZzPxlj
	ZeWjDZyg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0VGd-0000000EOAk-0VYk;
	Fri, 26 Apr 2024 23:46:11 +0000
Date: Fri, 26 Apr 2024 16:46:11 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, djwong@kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandan.babu@oracle.com,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 05/11] mm: do not split a folio if it has minimum
 folio order requirement
Message-ID: <Ziw8w3P9vljrO9JV@bombadil.infradead.org>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-6-kernel@pankajraghav.com>
 <Ziq4qAJ_p7P9Smpn@casper.infradead.org>
 <Zir5n6JNiX14VoPm@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zir5n6JNiX14VoPm@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Apr 25, 2024 at 05:47:28PM -0700, Luis Chamberlain wrote:
> On Thu, Apr 25, 2024 at 09:10:16PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 25, 2024 at 01:37:40PM +0200, Pankaj Raghav (Samsung) wrote:
> > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > 
> > > using that API for LBS is resulting in an NULL ptr dereference
> > > error in the writeback path [1].
> > >
> > > [1] https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df
> > 
> >  How would I go about reproducing this?
> 
> Using kdevops this is easy:
> 
> make defconfig-lbs-xfs-small -j $(nproc)
> make -j $(nproc)

I forgot after the above:

make bringup

> make fstests
> make linux
> make fstests-baseline TESTS=generic/447 COUNT=10
> tail -f guestfs/*-xfs-reflink-16k-4ks/console.log

The above tail command needs sudo prefix for now too.

> or
> sudo virsh list
> sudo virsh console ${foo}-xfs-reflink-16k-4ks
> 
> Where $foo is the value of CONFIG_KDEVOPS_HOSTS_PREFIX in .config for
> your kdevops run.
>
> I didn't have time to verify if the above commands for kdevops worked

I did now, I forgot to git push commits to kdevops yesterday but I
confirm the above steps can be used to repdroduce this issue now.

  Luis


