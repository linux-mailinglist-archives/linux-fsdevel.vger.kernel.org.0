Return-Path: <linux-fsdevel+bounces-21289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C89014BA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 08:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 614FDB2125B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 06:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670017753;
	Sun,  9 Jun 2024 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I9ueLAZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2FE33DF;
	Sun,  9 Jun 2024 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717914993; cv=none; b=uyRKVpv6hF/V7bcy7gdBZ3QibdMRs715CN0MH1SBCM9isHtGTKEg0OiHQAb7FjQfnVZKBGKQP1dksAPqyRp9eNTbc9GaAQqajzSWibn36ISGHuFxEmBDNJU/ogDJkIYLXzFdcfDuVCdMUrZWVmHOZdToJZNPNgxcJBiQ0cFwlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717914993; c=relaxed/simple;
	bh=7e1yKWqgL1IkgIai0KdZxRqFboXzW14N69sTXKFYQ1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbqqCJ3c1R5kszrIOnJYDCtkIezIJp2frw8k6xZGJMe+/TnRHPAeYJMsCs7ZCGTFdO09WBHp6CkmapcaJmsB5gpxxvtjEH+d6UFMpVbW23ZTr6yIbYdwXaH4OsSzfuXP+n06dl6KOG4T5vF9se32ckAvVoAKAMnbYrP5sDpLWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I9ueLAZj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qyul2gs29s1sQcX8rU+rTWeCqHIpXyYpZGZrXjUfM1E=; b=I9ueLAZjDjowWeljLjTonCqvH5
	1SKRiRaxAYn8kt4vKXd3CwSzpBqywvFL8ARS+XXwB6ba1OU0KA9Mr5tYPax9lj4154+h3HvofN0ia
	1hET4sDG9dab7y5ZgnlH/iuO3iNS0duWvmK4Pqve/4gOuShusnbL76S7euEvLWraUIh27M9SMu4KV
	+XB/Xj0Y7p90vrYTZqIoYU//6zrERW7NaodqEwPCSsU3Spv11k1VCfT2bHltzXURPFP2UnWO/B+dt
	eUGQykrltZwuGzsDOOoKQ9N23KG461pLfazeDeP4LJ1WAyJizVx/GgM7h5oHa1+XhLejlhRZdL5tT
	iFcKbJWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGCAI-000000020qx-36mp;
	Sun, 09 Jun 2024 06:36:30 +0000
Date: Sat, 8 Jun 2024 23:36:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to
 port
Message-ID: <ZmVNblggFRgR8bnJ@infradead.org>
References: <20240608001707.GD52973@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608001707.GD52973@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 07, 2024 at 05:17:07PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This is the fourth attempt at documenting the design of iomap and how to

The number of attempts should go out of the final commit version..

> port filesystems to use it.  Apologies for all the rst formatting, but
> it's necessary to distinguish code from regular text.

Maybe we should do this as a normal text file and not rst then?

> +.. SPDX-License-Identifier: GPL-2.0
> +.. _iomap:
> +
> +..
> +        Dumb style notes to maintain the author's sanity:
> +        Please try to start sentences on separate lines so that
> +        sentence changes don't bleed colors in diff.
> +        Heading decorations are documented in sphinx.rst.

Should this be in the document and not a README in the directory?

That being said starting every sentence on a new line makes the text
really hard to read.  To the point that I'll really need to go off
and reformat it before making it beyond the first few paragraphs.
I'll try to do that and will return to it later, sorry for just
dropping these procedural notes for now.


