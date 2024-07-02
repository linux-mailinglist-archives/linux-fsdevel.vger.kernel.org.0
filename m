Return-Path: <linux-fsdevel+bounces-22939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CDE923D67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 14:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2935AB25863
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 12:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799D16B753;
	Tue,  2 Jul 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BkRP4wh6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F81581EA;
	Tue,  2 Jul 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922513; cv=none; b=Ylg16Jb30ZY2v9tNC5R+zR+Wl2I7xU4XlGYRUsMY6AUsdxF6ZU7THLqXX35F0IpeDOYpT3U1SXALngbFOhibe3INIeztaHAWuc39LnOyS0r3p9nTTm7rJXkVblbjQnUTNETnN+HzTFV3ECAXTdgA91JcFpAAU5sVfvSBCJNyU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922513; c=relaxed/simple;
	bh=daknPN5+UD0AOsgseyyPKy+GhsmNuv/Kgat0Tz4/+yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNc0sTY9+NAk9iZXssr6v1hGg29i7drYjQSKWCN58L8Q2m5DjGTMk7M66cT6lBteJY8CZz3Nwn54B7Lhiha7g4yiR9Rpkgso8j3ZrbUMCaM/5vhV01C5MWq+06qGVKecnX9PMrm7d7ljkJE/TW3WcR2WhH8AM8+0pa73aAF1D9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BkRP4wh6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4H0kn1lNWzVJfOABE8UVhmMrapLkOqkflBiu0II1OzI=; b=BkRP4wh6h5/M14B1AqqGglvNcX
	iwivozmzpyoWh27g/3lRhEJLrmxdm1tf02XoZ26+xBicXfsIpJuturWphgXWW7rvN95zuXNqYgDQR
	9UIkUGf3C2jrueKsbdD1Ky1jo5iRPz/W11ehsVYkllZ35LOsCd48VblmSG/IgOmtaXrnsy2WZz8hp
	CESuZMR/SYEHEPla3jWILQ/PYhfoMfwKULLddVzXgcZkB8zT6nViFpsn1tESLNDxrXxODCZewyjYP
	2eoTrrBtZ7DYLNQL98MRR7e5zUdKhSmb7tnywmPhxl8XS2meRungD78uUInbOm3Rezf5D+IEVZC4/
	GDIK3Ihw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOcPX-00000006ddf-2NOb;
	Tue, 02 Jul 2024 12:15:03 +0000
Date: Tue, 2 Jul 2024 05:15:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 01/10] fs: turn inode ctime fields into a single ktime_t
Message-ID: <ZoPvR39vGeluD5T2@infradead.org>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
 <20240626-mgtime-v1-1-a189352d0f8f@kernel.org>
 <20240701224941.GE612460@frogsfrogsfrogs>
 <3042db2f803fbc711575ec4f1c4a273912a50904.camel@kernel.org>
 <ZoOuSxRlvEQ5rOqn@infradead.org>
 <d91a29f0e600793917b73ac23175e02dafd56beb.camel@kernel.org>
 <20240702101902.qcx73xgae2sqoso7@quack3>
 <958080f6de517cf9d0a1994e3ca500f23599ca33.camel@kernel.org>
 <ZoPs0TfTEktPaCHo@infradead.org>
 <09ad82419eb78a2f81dda5dca9caae10663a2a19.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ad82419eb78a2f81dda5dca9caae10663a2a19.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 02, 2024 at 08:09:46AM -0400, Jeff Layton wrote:
> > > corrupt timestamps like this?
> > 
> > inode_set_ctime_to_ts should return an error if things are out of range.
> 
> Currently it just returns the timespec64 we're setting it to (which
> makes it easy to do several assignments), so we'd need to change its
> prototype to handle this case, and fix up the callers to recognize the
> error.
> 
> Alternately it may be easier to just add in a test for when
> __i_ctime == KTIME_MAX in the appropriate callers and have them error
> out. I'll have a look and see what makes sense.

The seems like a more awkward interface vs one that explicitly checks.

> 
> > How do we currently catch this when it comes from userland?
> > 
> 
> Not sure I understand this question. ctime values should never come
> from userland. They should only ever come from the system clock.

Ah, yes, utimes only changes mtime.

