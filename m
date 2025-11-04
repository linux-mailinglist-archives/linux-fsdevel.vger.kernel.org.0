Return-Path: <linux-fsdevel+bounces-66965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 111AFC31F0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 16:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2987B189F9EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F348320311;
	Tue,  4 Nov 2025 15:52:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760111E9B37;
	Tue,  4 Nov 2025 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271540; cv=none; b=QDgzwcbE4J6v+nqclj/wrI4ISBx34LN7/B+SU20DLz0YtldU0VOI0fojLp6sNLIICwjWzWgh+Y0BSjAicuy1bYg5mW5As2OFT4Dbx3bZ74uZjZR+9Q5XCYLXA8eLlZSjdqd/GMuOqpUM8BSzBUuX12/mlpac8BGzWbaATI0mfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271540; c=relaxed/simple;
	bh=XsEhg04RWKTgiB4cYbeNQOOYIBfy6/5/afqsKR1Hpqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JajaPVIo7/SPkO+qpm3DUj0MGdsPR4RAi7XnxkJ2ivE+3mi3XGmM1hWSZHNxen3rPa/o2wPfsptY3HP5RSxaq1HtL6vNraWfjRKplDm1L5/vPWZXRXGqkRqQ8DtZiGX0Ij4VDY8z87tMycgygPxw52BxA/0kwfam8ED5P1BS1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 69E29227A87; Tue,  4 Nov 2025 16:52:13 +0100 (CET)
Date: Tue, 4 Nov 2025 16:52:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] xfs: use IOCB_DONTCACHE when falling back to
 buffered writes
Message-ID: <20251104155213.GA651@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <20251029071537.1127397-4-hch@lst.de> <a162ddcbd8c73adf43c7c64179db06ce60b087d6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a162ddcbd8c73adf43c7c64179db06ce60b087d6.camel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 04, 2025 at 06:03:35PM +0530, Nirjhar Roy (IBM) wrote:
> > Doing sub-block direct writes to COW inodes is not supported by XFS,
> > because new blocks need to be allocated as a whole.  Such writes
>
> Okay, since allocation of new blocks involves whole lot of metatdata
> updates/transactions etc and that would consume a lot of time and in
> this large window the user buffer(for direct I/O) can be re-used/freed
> which would cause corruptions?

I don't understand what you're trying to say here.

> Just thinking out loud: What if we supported sub-block direct IO in XFS
> and indeed allocated new blocks+ update the metadata structures and then
> directly write the user data to the newly allocated blocks instead of
> using the page cache?
>
> Assuming the application doesn't modify the user data buffer - can we
> (at least theoritically) do such kind of sub-block DIO?

Regular XFS does that.  Zoned XFS or the always COW debug mode can't do
that (except maybe for appends) as it it requires a read-modify-write
cycle that is not implemented in iomap.  Yes, we could implement that,
but it's not going to perform any better than the fallback, and would
also require full serialization.


