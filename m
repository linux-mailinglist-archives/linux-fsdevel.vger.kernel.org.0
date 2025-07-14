Return-Path: <linux-fsdevel+bounces-54876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866EAB046D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 19:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCAE3AA5E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 17:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D93266B50;
	Mon, 14 Jul 2025 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIhfGF/W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6412586EF;
	Mon, 14 Jul 2025 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515194; cv=none; b=pUOUEvf+vK35yTdF7P6jWcoazrhTlyD+tCZWmeDkvsHd0K3f0rLXetCb0SQK14rOE6r9D8Cb9xyF6c/D92S/s9sj4pFKCOWsEfRpJd5rwW2KFVeLsKCC8SzOsh/um0vjgMcbe/J4fRNkMPF0k30fuT0ChcjVabX5gc0wjElXj2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515194; c=relaxed/simple;
	bh=5PE6/IBiSWRv1ULmZKm7V6xmwg8/qTq1E3BHbh9lJX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEXlFZ9Y8+w7PK/1tR9hTvtHLd5/xHmb9+8sNqBeRGUErpI9aAXu0mGqjO/3jIKw/x5ADW9rQuONv5f+eEkpqEqCR5gbzaPlkPYzWHwqJVNTXsgVxm7kJDUv1rQHvkctDcw3wzIXx/TFyK3fBhUSuM8bUu1Akdmw3yKTWMeDtmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIhfGF/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89375C4CEED;
	Mon, 14 Jul 2025 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752515193;
	bh=5PE6/IBiSWRv1ULmZKm7V6xmwg8/qTq1E3BHbh9lJX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIhfGF/WcV3IvhroaBY+lao5QWTelztEUk92CiJ4dfA/wJHxacVJU16Kmo7jgrAS+
	 Xd42ZyElE+lo/Zi6YcG1FCTQ++qrzuYyZ/DSV8zCmFWS+FAcIJpDXo4FcENO6X0+jH
	 2c/EK8ZpUAZJvo8d9n+9Jut3epql7gBgzA9L95HDxHyKIcDqQe+LdUEnjMskVQiYe6
	 JVJ9MZdG63hm0xa2my2l/+fNbuUN0wATZ6EJtFQZU78ta8R5QkMwtIpLmDHGGE7Pxe
	 zL+wR7jEySuSDs8xtB/fQ5imH4nP9DN9SFJlVw2qKrwF7h0bfiPFOFz50AOVJq+GwT
	 5W8J6DiH+ufpA==
Date: Mon, 14 Jul 2025 13:46:32 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 3/8] NFSD: filecache: add STATX_DIOALIGN and
 STATX_DIO_READ_ALIGN support
Message-ID: <aHVCeJ3_YbSheTr8@kernel.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-4-snitzer@kernel.org>
 <aG9vsPCSv0nQ5Bk8@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG9vsPCSv0nQ5Bk8@infradead.org>

On Thu, Jul 10, 2025 at 12:45:52AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 08, 2025 at 12:06:14PM -0400, Mike Snitzer wrote:
> > Use STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get and store DIO
> > alignment attributes from underlying filesystem in associated
> > nfsd_file.  This is done when the nfsd_file is first opened for
> > a regular file.
> 
> Just as a little warning: these are unfortunately only supported by
> very few file systems right now.  For someone with a little bit of
> time on their hand it would be nice to do a pass to set them for
> all remaining direct I/O supporting file systems, which is only about
> a dozen anyway.

That's a good point.  Meanwhile, I'll be sure to have the NFSD code
(and NFS LOCALIO code later) be more defensive about the possibility
of these attributes being 0 (due to lack of underlying filesystem
support).

Mike

