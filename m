Return-Path: <linux-fsdevel+bounces-43756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF05A5D57B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 06:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952B17A4DD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 05:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909221DE4E3;
	Wed, 12 Mar 2025 05:22:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA31A5BA9;
	Wed, 12 Mar 2025 05:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756923; cv=none; b=i5pm8lnV3W1/O3yY/ILf7YBM6snDtJoOYt4TQGzspKdLJp7T7fQ3XBVHC76VHfo0ly6SywjGgChbE/NeEmRa4TXG2JN8cXitdn3yXG6f1hVsHvl4lGM9UTIYAHRHaC34bnFAGzYuWniqBOcrHgvlz++nVoI4RP4sTs6gu0K5WDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756923; c=relaxed/simple;
	bh=+UarTk2Wmk4BKhE4e0mZGuUq+ZHoPat8GnsIvaErEiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJs7SSB/OMrbjStt//+MDI2mQel4Pr4UNAsMGGU6TwGfSwrS15gGyd6Si3HRN0BBHmWNcTo1xzBZ9sz/bTfyFUiPt3lTVinihI6TxUN3z3YCxLoQj+sx+/0OgHBNlBOBpLgV1ioJBeGEAwbEQ6E4Fz5ewNsvKE2TnbL1tpAtgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BFAD568AA6; Wed, 12 Mar 2025 06:21:55 +0100 (CET)
Date: Wed, 12 Mar 2025 06:21:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: liwang@redhat.com, brauner@kernel.org, hare@suse.de,
	willy@infradead.org, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, ltp@lists.linux.it, lkp@intel.com,
	oliver.sang@intel.com, oe-lkp@lists.linux.dev, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH] block: add BLK_FEAT_LBS to check for PAGE_SIZE limit
Message-ID: <20250312052155.GA11864@lst.de>
References: <20250312050028.1784117-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312050028.1784117-1-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 11, 2025 at 10:00:28PM -0700, Luis Chamberlain wrote:
> We should take time to validate each block driver before enabling
> support for larger logical block sizes, so that those that didn't
> have support stay that way and don't need modifications.
> 
> Li Wang reported this as a regression on LTP via:
> 
> testcases/kernel/syscalls/ioctl/ioctl_loop06
> 
> Which uses the loopback driver to enable larger logical block sizes
> first with LOOP_CONFIGURE and then LOOP_SET_BLOCK_SIZE. While
> I see no reason why the loopback block driver can't support
> larger logical block sizes than PAGE_SIZE, leave this validation
> step as a secondary effort for each block driver.

This doesn't really make sense.  We don't want a flag that caps driver
controlled values at a arbitrary value (and then not used it at all in
the patch).

If you need extra per-driver validatation, do it in the driver.

