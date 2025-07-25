Return-Path: <linux-fsdevel+bounces-56040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 430E5B12151
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72221CC6C89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 15:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847C42EF2AB;
	Fri, 25 Jul 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw5bHsr+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F32EF28E;
	Fri, 25 Jul 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458591; cv=none; b=bvV11Lzep7iwPcCPkMSqnvTHRgz27uaIqBwBzK/ditcblU+SRhKv8zjOCERzAwa8m3evi07vbcQgKmp1EG8iyAGIk36NAcHBCuejAatB3OJXU/zp3pTD+7kltNZkWt5hXhYNsWrgjWCzYmPPl6Eb9kapD3PLVBBjHrQlSZcc7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458591; c=relaxed/simple;
	bh=XvrB1WYHH0+M7h66bcidEyNPs3nE7Wz01aYAenZcfPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXoNwa+VnTr2Fuf4XBNM+ZwvhWZSxyW57ISbXyvCFPiXPRAG+t+yegCXfYCcAY8eXIL1N+pws2QGU7KiEAQkgf8OL7cu4OqBNq52L36pZNYQMWf3ajL7lHYj0rls2OK0oDL+KFKjSf9qr9O9nr2yOPW6XPKL2RIrUEFCF13wFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uw5bHsr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356F6C4CEE7;
	Fri, 25 Jul 2025 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753458591;
	bh=XvrB1WYHH0+M7h66bcidEyNPs3nE7Wz01aYAenZcfPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uw5bHsr+79zgO7EdCbNwnTuJiubmblw3E9ZK8D4oBbo6+LDw/d7RAoyX1igk3VZQ8
	 dEIEn9rp+1GRRdEi2Tt0hWOZu+tLJwhBvf8q/W2ABXb/HaZC7mjX7azWPZZ8E9nvpu
	 pztwyTSx6tGhC2+FH52e0GocmQAZjJh+JJOD2MBAJ1+DRboo9jY8PVOivKN7kTQk/6
	 DZQkS5hnrR2eMUQiuS1EZX8tLiXk+CgwFz72Y+bI0JBeDjeG9K1ovGsDlWztEWd/x8
	 lv6lfyzol0ubT1I7aPaihdom5s7sLckOBekiRuzwEnhHeW7MGCK33vB+/WqJEeAq7X
	 EDAhtHLw7J9ow==
Date: Fri, 25 Jul 2025 08:49:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, cem@kernel.org, dan.j.williams@intel.com,
	willy@infradead.org, jack@suse.cz, brauner@kernel.org,
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] xfs: reject max_atomic_write mount option for no
 reflink
Message-ID: <20250725154950.GQ2672029@frogsfrogsfrogs>
References: <20250724081215.3943871-1-john.g.garry@oracle.com>
 <20250724081215.3943871-4-john.g.garry@oracle.com>
 <20250724163206.GN2672029@frogsfrogsfrogs>
 <331e38eb-e8b3-4ae4-9c74-81c79d6ce3a7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <331e38eb-e8b3-4ae4-9c74-81c79d6ce3a7@oracle.com>

On Fri, Jul 25, 2025 at 09:39:42AM +0100, John Garry wrote:
> On 24/07/2025 17:32, Darrick J. Wong wrote:
> > On Thu, Jul 24, 2025 at 08:12:15AM +0000, John Garry wrote:
> > > If the FS has no reflink, then atomic writes greater than 1x block are not
> > > supported. As such, for no reflink it is pointless to accept setting
> > > max_atomic_write when it cannot be supported, so reject max_atomic_write
> > > mount option in this case.
> > > 
> > > It could be still possible to accept max_atomic_write option of size 1x
> > > block if HW atomics are supported, so check for this specifically.
> > > 
> > > Fixes: 4528b9052731 ("xfs: allow sysadmins to specify a maximum atomic write limit at mount time")
> > > Signed-off-by: John Garry<john.g.garry@oracle.com>
> > /me wonders if "mkfs: allow users to configure the desired maximum
> > atomic write size" needs a similar filter?
> > 
> 
> Yeah, probably. But I am wondering if we should always require reflink for
> setting that max atomic mkfs option, and not have a special case of HW
> atomics available for 1x blocksize atomic writes.

I think that's reasonable for mkfs since reflink=1 has been the default
for quite a long while now.

--D

> > Reviewed-by: "Darrick J. Wong"<djwong@kernel.org>
> 
> cheers
> 

