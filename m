Return-Path: <linux-fsdevel+bounces-18451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D28B91AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 00:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC216B22A7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 22:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB11E481;
	Wed,  1 May 2024 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d77vQHUm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC991E4AF;
	Wed,  1 May 2024 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714603168; cv=none; b=i61P4jkSRCw88bJ8FoGJYrsRSaXkiXLrF8C5L+jgNgqqHaxPZG7+QPRGy0uY8CgH/MnbkiGIohfRAV9ZwaO+soyWrnMDDYCqfGt6ox7/91zwKy+gTlpdyrWWucSoSvXj2m9ux8ET/D/ttA5DeKt8O81NObcVPKXZnHArqY0VHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714603168; c=relaxed/simple;
	bh=dRHEbXxTnKCmyTY9o2l+aLqcumru5q4so507s2PL3Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKZOqGBvfXdvVV5/PLtdqHqwUcKBnuMYmePxHt2dAzQvCilScSVSgQoIoM0nBhVVBzz0FRjwQjjEtAioUl1imMEGGE5nvkLNDpyEJMF/hVCQXUawM2wIHX1pWX5+QljDs/i+BxBxbE3xqyHd5GSjxxdXbONrjNtBSX9m+9uyOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d77vQHUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D149C072AA;
	Wed,  1 May 2024 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714603168;
	bh=dRHEbXxTnKCmyTY9o2l+aLqcumru5q4so507s2PL3Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d77vQHUmY56BEMttaFhvDaGOzViYp4mfrXqWzwQlLVRyrjaXlGhUNatytPWyt1p6N
	 C21UA4f/ibBX4PmMrxmp1doZqJKLWdy55wRodQhWFPcjeSWvMwLPAPDL8xamxtSSH2
	 qwc5l6YXj40IEtf7I4zV+vovTqTSx8hV95vMbX6uDm4CJEWHoLWpeN95Wg262nPZuf
	 55F0+5umthRBLvsEKLSEyqRqCzhKyjZejyM+PlV9C5qCMLc9B9NsrOt1J1IsfI85Bg
	 bM9jw1C61wcO1iT3JZmVLtAFOeJk5JyQ4nJznfSOCBJ7VinzY8lvw6bH7NrtRYtJrQ
	 WuMdOGG8vTgvg==
Date: Wed, 1 May 2024 15:39:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Chandan Babu R <chandanbabu@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/26] xfs: use unsigned ints for non-negative quantities
 in xfs_attr_remote.c
Message-ID: <20240501223927.GI360919@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680378.957659.14973171617153243991.stgit@frogsfrogsfrogs>
 <ZjHnXmcsIeTh9lHI@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjHnXmcsIeTh9lHI@infradead.org>

On Tue, Apr 30, 2024 at 11:55:26PM -0700, Christoph Hellwig wrote:
> On Mon, Apr 29, 2024 at 08:24:22PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > In the next few patches we're going to refactor the attr remote code so
> > that we can support headerless remote xattr values for storing merkle
> > tree blocks.  For now, let's change the code to use unsigned int to
> > describe quantities of bytes and blocks that cannot be negative.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

> Can we please get this included ASAP instead of having it linger around?

Chandan, how many more patches are you willing to take for 6.10?  I
think Christoph has a bunch of fully-reviewed cleanups lurking on the
list, and then there's this one.

--D

