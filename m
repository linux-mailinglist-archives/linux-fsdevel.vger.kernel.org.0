Return-Path: <linux-fsdevel+bounces-68174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D56FC55CD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 06:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64DD84E2589
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 05:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3B32D6407;
	Thu, 13 Nov 2025 05:23:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62630F923;
	Thu, 13 Nov 2025 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763011426; cv=none; b=higb0xEjPB4pLLoCWrL44/NerAZYHfAyruAl3uCXX/RvO+YC+lffH8Dw0zITf7Ss9Y2NrpsSDK3B9d3eg8ch9CCY5Y/FsTFm7aEE23gSskLH3A+A+eQcTUPuHwyHKamZt4eRiGCrsypZ8z3PRwYzCf9msCSxvNx5pOG6RNYol6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763011426; c=relaxed/simple;
	bh=lx71oAOAcYYpIlbWv0x5xTCVshQjEG5IZwAdCJb6eio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m08EHGRMLQxxRBWD8unO7cvuM9XRSUzeVKzqE2UT23sunBMUTmogBK6xVDH5B9MWzdgRYjZyys1spQOWokUiqoL+PJFKeeyXo5qKHTqfJ/3wizMr1o6NCInlINOq04J7haKCHALVN6usvJuZfE8rmMRbwH8/gDRhEm1GQQ5RacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 38EF96732A; Thu, 13 Nov 2025 06:23:37 +0100 (CET)
Date: Thu, 13 Nov 2025 06:23:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
	willy@infradead.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
	martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <20251113052337.GA28533@lst.de>
References: <cover.1762945505.git.ojaswin@linux.ibm.com> <aRUCqA_UpRftbgce@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRUCqA_UpRftbgce@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 13, 2025 at 08:56:56AM +1100, Dave Chinner wrote:
> On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
> > This patch adds support to perform single block RWF_ATOMIC writes for
> > iomap xfs buffered IO. This builds upon the inital RFC shared by John
> > Garry last year [1]. Most of the details are present in the respective 
> > commit messages but I'd mention some of the design points below:
> 
> What is the use case for this functionality? i.e. what is the
> reason for adding all this complexity?

Seconded.  The atomic code has a lot of complexity, and further mixing
it with buffered I/O makes this even worse.  We'd need a really important
use case to even consider it.

