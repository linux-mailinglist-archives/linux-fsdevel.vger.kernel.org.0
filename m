Return-Path: <linux-fsdevel+bounces-43757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FB2A5D5A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 06:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FFE178560
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 05:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F521DF277;
	Wed, 12 Mar 2025 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2RgZZ4k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECFB1A7264;
	Wed, 12 Mar 2025 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741757850; cv=none; b=fXuDIuWi2AMVHq3pe8+NaZZ+U55Ug0FQK305dSzYIIJbKLu64OHCXpJO42/HyRaEIAhoYIRga2BtGc/rzem8YnfzDlPrD8H+1UrqVXNKRE3zCqsuRQAJXCmHsPHpn1nyQQexyk3ad4vGWRnNRM3+SBhwFpI29VgEUvACP36Q5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741757850; c=relaxed/simple;
	bh=+rIAL/oWsgOB2TGRmaZ8ZbLCHRWW5v1eoOMuTtDSZgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxAXjWuDAgomQOhQoIjyV3vJi988CNr1IHiOoFyZhNT2QFiqi1m6HaHPZclfa3qCAwZIpqVfIMJres65RkjSzN+TUFtcX1VyBlsSpBZULdNjYS4ONVsmQ5hmXRl1eYs2xNuhZ9ULIGns2fNSPC+AaYiOzYleB4bh0RZ4tObF4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2RgZZ4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8D2C4CEEB;
	Wed, 12 Mar 2025 05:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741757849;
	bh=+rIAL/oWsgOB2TGRmaZ8ZbLCHRWW5v1eoOMuTtDSZgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2RgZZ4kal9f5rieX5K/gzYBxCQRsBQ9x3wU9YyjAVsc372TlECvNMJan4jyb/0q8
	 W762u1PAYQZNHJ1zgALDq5cb8S3B3G8Etp5RCu375CuqJZRseuK3NT9/eFYttXiPw+
	 uA99K3zIIHGWGQyLIhm8mQDZzDuVk7h9LktEws4reqlosi/fohEkaXI0zqkH1U7Hxu
	 iR5c3cC7qM2KZ/pRMx/o/Ol1yUcoyB11qUK9l3e+l/H0eMHCOVaa4TXoHxzXXdx4k1
	 S9BTPZfY51iecFPax2AWY6EE5rr5/zFP0VqppVo0FIwd8d3l4jUpWSFDSVWx6nql4m
	 f7hbBaVZ7KO2g==
Date: Tue, 11 Mar 2025 22:37:27 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: liwang@redhat.com, brauner@kernel.org, hare@suse.de,
	willy@infradead.org, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	ltp@lists.linux.it, lkp@intel.com, oliver.sang@intel.com,
	oe-lkp@lists.linux.dev, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH] block: add BLK_FEAT_LBS to check for PAGE_SIZE limit
Message-ID: <Z9Edl05uSrNfgasu@bombadil.infradead.org>
References: <20250312050028.1784117-1-mcgrof@kernel.org>
 <20250312052155.GA11864@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312052155.GA11864@lst.de>

On Wed, Mar 12, 2025 at 06:21:55AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 11, 2025 at 10:00:28PM -0700, Luis Chamberlain wrote:
> > We should take time to validate each block driver before enabling
> > support for larger logical block sizes, so that those that didn't
> > have support stay that way and don't need modifications.
> > 
> > Li Wang reported this as a regression on LTP via:
> > 
> > testcases/kernel/syscalls/ioctl/ioctl_loop06
> > 
> > Which uses the loopback driver to enable larger logical block sizes
> > first with LOOP_CONFIGURE and then LOOP_SET_BLOCK_SIZE. While
> > I see no reason why the loopback block driver can't support
> > larger logical block sizes than PAGE_SIZE, leave this validation
> > step as a secondary effort for each block driver.
> 
> This doesn't really make sense.  We don't want a flag that caps driver
> controlled values at a arbitrary value (and then not used it at all in
> the patch).
> 
> If you need extra per-driver validatation, do it in the driver.

Are you suggesting we just move back the PAGE_SIZE check, or to keep
the checks for the block driver limits into each driver?

  Luis

