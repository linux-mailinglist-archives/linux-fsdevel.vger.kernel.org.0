Return-Path: <linux-fsdevel+bounces-47363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F19A9CA6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 15:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9AE77A5D84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8FE253959;
	Fri, 25 Apr 2025 13:33:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1824BC00;
	Fri, 25 Apr 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587988; cv=none; b=Ra597LQBOC1ycI/nOFfauO3oPMt3V0kWlQfxLZwAdxO8heSjFVjxWhp0Z9U+suJMsgCg4pqBE7tThxOiDKLqsU8z2/GfBFsSFELBIX323pmZPoRmpCXnF624aMgU7Rx2FLkuUTn9vTg5o1m+/Zs4GaWC/7nEIXmrJXRgC4YjzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587988; c=relaxed/simple;
	bh=BGZtpxWX6YZYaFUOiEUu3vqeLND56dGFiwlt2elbYFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbL8hltBm/DrVK9N1Cn+zvvXdHHgMYEJrqb6xEyvtQ1Bw+QswOjDTYbnl6zzE67mVV3cijs97lYi5Z8lSg2/BLNNfVQe5tMEd5ftAaIBd7FW9YupuuqGJTwCAf4LyPtsakqIDHzniiM6Spgyd/eVaF6XmwfLH8XwoLbhbeeVbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 567A068B05; Fri, 25 Apr 2025 15:33:00 +0200 (CEST)
Date: Fri, 25 Apr 2025 15:32:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Xiao Ni <xni@redhat.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
Message-ID: <20250425133259.GA6626@lst.de>
References: <20250423045941.1667425-1-hch@lst.de> <20250425100304.7180Ea5-hca@linux.ibm.com> <20250425-stehlen-koexistieren-c0f650dcccec@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425-stehlen-koexistieren-c0f650dcccec@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 25, 2025 at 12:12:36PM +0200, Christian Brauner wrote:
> > That is: if dev_mynode(dev, inode) is not true some random value will be returned.
> 
> Don't bother resending, Christoph.
> I've already fixed this with int err = 0 in the tree.

Thanks!  Let me use this as a platform to rant about our option
defaults and/or gcc error handling.  It seems like ever since we started
zeroing on-stack variables by default gcc stopped warnings about using
uninitialized on-stack variables, leading to tons of these case where
we don't catch uninitialized variables.  Now in this and in many cases
the code works fine because it assumed zero initialization, but there are
also cases where it didn't, leading to new bugs.

Can we fix this somehow?

