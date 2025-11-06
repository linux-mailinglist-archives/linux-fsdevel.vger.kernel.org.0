Return-Path: <linux-fsdevel+bounces-67350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4006CC3CBE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 18:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E950566D19
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F2A34DB4E;
	Thu,  6 Nov 2025 17:05:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF136281357;
	Thu,  6 Nov 2025 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448709; cv=none; b=OpSxDyWnZZgGXfw2aE+NTIAZU4otq3HMqgMz/wfgLspeZEf7kC2V2TsqUG+P8SUUl3m382w+jXl3KopE57PDbAluFVJ/AMM1uoa42ovsmBb2ZCs0P/Mrj4PIk3eTeWY1NxHbRNf9XZH229ULNN3cMQAXcfoehyvijHQL6FdXkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448709; c=relaxed/simple;
	bh=AJDmimB9BIj3xJ2WN3XZvLrcXtlKdcgLfwBmJ5jDjzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAWMmIiQU4MD9aECc3fanyjn786zwlmg2OE2aVlqj3WIPOQvohw/jUTOrdZUzXSvnSi9yJWqLZKHIKu6gOAbUd4ckZbUlZZ/8fFqlblVt0auPavm4LnthaUD/T6zjR1SI0ScIEepTsIxVCyq1AhGbMDKtj09t/ix2sx2YNTh9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53C546732A; Thu,  6 Nov 2025 18:05:01 +0100 (CET)
Date: Thu, 6 Nov 2025 18:05:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Florian Weimer <fweimer@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <20251106170501.GA25601@lst.de>
References: <20251106133530.12927-1-hans.holmberg@wdc.com> <lhuikfngtlv.fsf@oldenburg.str.redhat.com> <20251106135212.GA10477@lst.de> <aQyz1j7nqXPKTYPT@casper.infradead.org> <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 05:31:28PM +0100, Florian Weimer wrote:
> It's been a few years, I think, and maybe we should drop the allocation
> logic from posix_fallocate in glibc?  Assuming that it's implemented
> everywhere it makes sense?

I really think it should go away.  If it turns out we find cases where
it was useful we can try to implement a zeroing fallocate in the kernel
for the file system where people want it.  gfs2 for example currently
has such an implementation, and we could have somewhat generic library
version of it.

> There are more always-CoW, compressing file
> systems these days, so applications just have to come to terms with the
> fact that even after posix_fallocate, writes can still fail, and not
> just because of media errors.

Yes.


