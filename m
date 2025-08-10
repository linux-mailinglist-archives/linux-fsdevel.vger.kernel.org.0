Return-Path: <linux-fsdevel+bounces-57241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0538BB1FB4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 19:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114D33B588B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2701271A7B;
	Sun, 10 Aug 2025 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hecelpqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A62033A;
	Sun, 10 Aug 2025 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754846057; cv=none; b=ukPS5KncS4cbOwpfg3XQ5G19RjEI8jfK4qldUotAtUzHrtMiulwL6oHk8kOcXA3R59ehBQBfFB6tYjL4PtX9yl1WAcG6K5PBeSQeKat3O8sc+JoE4DwOwQz91t1gJD36Mx1I2xTaifAm8GVOGi0VMhwnqLkjou/s1W4Z/5q0rCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754846057; c=relaxed/simple;
	bh=mwYy4MtpjsqSbTe4QK7YZXRgV5Dz84tgjKhMCz2m7co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEs2ZhKOJDl37fqc854g15E+SqdB1ofuctM6Jg/kGmwvTiizB5N7VUbdPUYrztOw2U1hcQlKfXTEc07N8FPk63zesNcGB5CUYlY0kuqUdF2UryKvXSfEHLCGKv5pPrGUK7SzaN7ecABHTexvVhxELt+yuLUvT54Fe8frlOO3yUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hecelpqm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eba9/UNtFbnbTotdmRwgRDpHHtnU1GYOs19ZmRBWF2o=; b=hecelpqmlnsZkhT+OLx5/HpbXr
	RG97h7KFiWryT3kIqWxgwPsicKfM4Is5hZpZ1sBdwXPFO6sMg6eGoaFrhbwgjFNGCXA4bt1BNJBC6
	7VyhJAmuCE7KxYT2WXqprZ6lSIsZvB2HNEkYjhhA6d4/UQM007+vndtSdvKOc8quT9Nk09djK0FpN
	H8EUGCKmjMDLYefs2C4QsrtbwJ5Pwti17S8zbYkI6BRQmcGm4g0cINVfr15VZ/uG243Oj2pzYK6hv
	jNrtUoRha9VcTMSM0HgujT2Ac3E8VQawRllgjnpbLcsAWUBVrNxj+i+ukV2F7xYKsLI0Xl/GwXloB
	wUzLZSJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul9cc-00000005pRq-0pCw;
	Sun, 10 Aug 2025 17:14:14 +0000
Date: Sun, 10 Aug 2025 10:14:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 00/13] Move fscrypt and fsverity info out of struct
 inode
Message-ID: <aJjTZg-VOaZ_2k2H@infradead.org>
References: <20250810075706.172910-1-ebiggers@kernel.org>
 <aJixkUfWPo5t8Ron@infradead.org>
 <20250810170311.GA16624@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810170311.GA16624@sol>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Aug 10, 2025 at 10:03:11AM -0700, Eric Biggers wrote:
> I assume you actually still mean fsverity, not fscrypt.

Yes, sorry.

> First, it would
> be helpful not to use one solution for fscrypt and a totally different
> solution for fsverity, as that would increase the maintenance cost well
> beyond that of either solution individually.

I agree that reducing the number of infrastructures is a goal.  But I
don't think we should limit us to a single "solution" for different
kinds of problems.

> 
> Second, the fsverity info can be loaded very frequently.  For example,
> curently it's loaded for each 4K data block processed.

Well, we can easily keep a once looked up data structure around for
any operation that does not leave file system control.  So for writing
that's a single ioctl context.  For read that is a single call into
->readahead, or maybe even ->read_iter.

> Also, there
> *are* use cases in which most files on the filesystem have fsverity
> enabled.  Not super common, but they exist.

Sure.  But the typical use case is a few files, and even that is just
a tiny minority of all ext4/f2fs/xfs file systems.

> It doesn't really seem like the kind of solution that's a good choice
> for a frequently-loaded field.  And that's only the load; it's not
> getting into the insertion (and resizing) part.

Assuming you actually get it down to once per high-level operation
above, it will still be absolute noise compared to the I/O generated.

> If we're going so far as to use a rhashtable, I have to wonder why we
> aren't first prioritizing other fields.  For example ext4_inode_info
> unconditionally has 40 bytes for fast_commit information, even though
> fast_commit is an experimental ext4 feature that isn't enabled on most
> filesystems.  That's 5 times as much as i_verity_info.  And quota has 24
> bytes under CONFIG_QUOTA.  And there are even holes in the
> ext4_inode_info struct; we could also just improve the field packing!

All that does sound like a good idea, independent of what we are
discussing here.


