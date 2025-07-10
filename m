Return-Path: <linux-fsdevel+bounces-54434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68755AFFAEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 09:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485717B3BEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F2288512;
	Thu, 10 Jul 2025 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM86voJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE2203710;
	Thu, 10 Jul 2025 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132725; cv=none; b=ZeuoCD2akzoHC9APYSJq6yg4WNAZV/bIC36+pcF2xL9BP2RRlsvF00STUdB+lGJLRGCc11JZsuYgm+AlPys4zDeMBkKDmUFv/TzdtJDiJxhXtXek2584gLX+aikUucjPptdk9fbyilTl5HZJqG7mzbHACbsM0o75y+S6IIb2L+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132725; c=relaxed/simple;
	bh=Kt8CDH06LTAvD+rZvv3I8+BRWAIdHXw5BhgEf1OfxjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STho2gKC3AlgOMrk/LJfSHBkDz9UD9Ph2Jom3gMjuv6Qk0eQTWJqvGRBQYNWGT4gcq1v0V1YWMQDEMEA55lLqhSH771DO5L3z4V4HYjN1sfYY7AyAD3UJuV8hlK+1pQxpeSAZYXadBKkPUczaJPkasu2usI/7RWoVurzl4mptPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM86voJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182F2C4CEE3;
	Thu, 10 Jul 2025 07:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132725;
	bh=Kt8CDH06LTAvD+rZvv3I8+BRWAIdHXw5BhgEf1OfxjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uM86voJZO0HZZdICeHvK3HTTyV39spEV2FWYVY9Lqh58GmOW70Inkzy7zM58U5d4K
	 zmCpsnQU0Mw0cdlChrtvP+5E/uTtXhFR4q72obbTDWrX7BGiJZ4Bk8r6EvXMy1YlCW
	 mEv6ixE3V5zygpA4TAS7980JtkFru52m1+GQQ+8JaYBPQdPxrYzXAsYz7H/2I4g73b
	 Ac+uOXpz/dkEIzcnnYyGwIxM79BQt68gWH6lh3iFJ3zjFxM38R6VGDtL0TNHP4ZPva
	 vhXpLag+J30CyEPSYvHDkyJoJWFSOS3svssNkN/Al2XBwQPKUfxKWR0SiAzbkQR+va
	 Ozp97paIdwGJA==
Date: Thu, 10 Jul 2025 03:32:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 4/8] lib/iov_iter: remove piecewise bvec length
 checking in iov_iter_aligned_bvec
Message-ID: <aG9scyDn-rxDnwn3@kernel.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-5-snitzer@kernel.org>
 <aG9qtlHCmSztOsFo@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG9qtlHCmSztOsFo@infradead.org>

On Thu, Jul 10, 2025 at 12:24:38AM -0700, Christoph Hellwig wrote:
> You'll really need to send this to the VFS mainers and especially
> Al.  Also the best way to make things stand out is to either send
> them separastely or the beginning of the series.
> 

Yeah, I had the linus-fsdevel typo which didn't help too.

The first time I posted this series I did a better job of sending this
patch to Andrew and Al iirc.  In any case, I can pull this fix out to
front of series.  But also iov_iter_aligned_iovec() appear to have the
same issue.


