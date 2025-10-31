Return-Path: <linux-fsdevel+bounces-66563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D2BC24277
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC895673C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B367330B0A;
	Fri, 31 Oct 2025 09:18:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C714330305;
	Fri, 31 Oct 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902307; cv=none; b=ZjdHfg86dlkBC3WMTCXFBWUHlwE0PMp7y7phSLeNActxITfHwnovyMWNbopR4zngdl3Xs97fJmXJMBGcdH3mXRQd9d7IJadWM6ezlq8y8r6caGUX40smweELac5HFfLYfzG5MmH08vp8FLOWHu/C/7r4C+KrZi/BIA2qiSojtMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902307; c=relaxed/simple;
	bh=QSgD+O92En9+Myk3lhAO0vJmvltIk/8SqFaNAmHxHH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrcmtZ6tTfbW//5NUWwk0ETvTesEFx20z3k5bRiLFCLK0nKuNCQbTD57xY3lH97Loyx8GmF0AyyiNZkDTllPXQqnly93SaO38vRz7yGaFd8PMzcwO6tBeSQX/ZVdjYWczoWUhWyZqLmn6NgtRekKs1LjINcgik/48RmK6iIyTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B3534227AAC; Fri, 31 Oct 2025 10:18:20 +0100 (CET)
Date: Fri, 31 Oct 2025 10:18:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Carlos Llamas <cmllamas@google.com>,
	Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	axboe@kernel.dk, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <20251031091820.GA9508@lst.de>
References: <20250827141258.63501-1-kbusch@meta.com> <20250827141258.63501-6-kbusch@meta.com> <aP-c5gPjrpsn0vJA@google.com> <aP-hByAKuQ7ycNwM@kbusch-mbp> <aQFIGaA5M4kDrTlw@google.com> <20251028225648.GA1639650@google.com> <20251028230350.GB1639650@google.com> <20251029070618.GA29697@lst.de> <20251030174015.GC1624@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030174015.GC1624@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 10:40:15AM -0700, Eric Biggers wrote:
> Allowing DIO segments to be aligned (in memory address and/or length) to
> less than crypto_data_unit_size on encrypted files has been attempted
> and discussed before.  Read the cover letter of
> https://lore.kernel.org/linux-fscrypt/20220128233940.79464-1-ebiggers@kernel.org/

Hmm, where does "First, it
necessarily causes it to be possible that crypto data units span bvecs.
Splits cannot occur at such locations; however the block layer currently
assumes that bios can be split at any bvec boundary.? come from?  The
block layer splits at arbitrary boundaries that don't need any kind of
bvec alignment.

> We eventually decided to proceed with DIO support without it, since it
> would have added a lot of complexity.  It would have made the bio
> splitting code in the block layer split bios at boundaries where the
> length isn't aligned to crypto_data_unit_size, it would have caused a
> lot of trouble for blk-crypto-fallback, and it even would have been
> incompatible with some of the hardware drivers (e.g. ufs-exynos.c).

Ok, if hardware drivers can't handle it that's a good argument.  I can
see why handling it in the software case is very annoying, but non-stupid
hardware should not be affected.  Stupid me assuming UFS might not be
dead stupid of course.

> It also didn't seem to be all that useful, and it would have introduced
> edge cases that don't get tested much.  All reachable to unprivileged
> userspace code too, of course.

xfstests just started exercising this and we're getting lots of interesting
reports (for the non-fscrypt case).


