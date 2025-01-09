Return-Path: <linux-fsdevel+bounces-38716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11051A06F7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6FA1887971
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12C3214A71;
	Thu,  9 Jan 2025 07:54:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E14A43169;
	Thu,  9 Jan 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409260; cv=none; b=CssngnoLDPytjHJbDU4B+m7xf855DOmhx7lx17TRIhYGp/ljv8wdqIxybJxi5pLoS/D1VwnLeMgax0PxeIl3OFl10ZMyVx1OmVmeR0iqVzEmXXUH5u300tBmPJ9gtYVqQr7qXrImeEiFtHVeeENmk+fND596TpdstJGOwV2msY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409260; c=relaxed/simple;
	bh=rXSu+APBUArO7zhcrYoDKY6pjZhZp3DliO28WmxP7VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0aMDp14kOkiQTo6MHXrofkr2s4WWawdZB3cYw5vkp6XB7nzZCNS4HACGnyssdWLGoAb6EtAAUWO1VmL5DYT9S5mSbI4huHRX6qGFI8qTxoLKG35eyg4uQE8TKdKBNp55lB+Y+Kg+9ooAx2jPe6fbhmPd0OsOc+G7QPN9uSy+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 32F4A68BFE; Thu,  9 Jan 2025 08:54:13 +0100 (CET)
Date: Thu, 9 Jan 2025 08:54:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	brauner@kernel.org, cem@kernel.org, dchinner@redhat.com,
	ritesh.list@gmail.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.petersen@oracle.com
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
Message-ID: <20250109075412.GA19081@lst.de>
References: <20241210125737.786928-1-john.g.garry@oracle.com> <20241210125737.786928-3-john.g.garry@oracle.com> <20241211234748.GB6678@frogsfrogsfrogs> <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com> <20241212204007.GL6678@frogsfrogsfrogs> <20241213144740.GA17593@lst.de> <20241214005638.GJ6678@frogsfrogsfrogs> <20241217070845.GA19358@lst.de> <93eecf38-272b-426f-96ec-21939cd3fbc5@oracle.com> <20250108012636.GE1306365@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108012636.GE1306365@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 07, 2025 at 05:26:36PM -0800, Darrick J. Wong wrote:
> "I think we should wire it up as a new FALLOC_FL_WRITE_ZEROES mode,
> document very vigorously that it exists to facilitate pure overwrites
> (specifically that it returns EOPNOTSUPP for always-cow files), and not
> add more ioctls."
> 
> If we added this new fallocate mode to set up written mappings, would it
> be enough to write in the programming manuals that applications should
> use it to prepare a file for block-untorn writes?  Perhaps we should
> change the errno code to EMEDIUMTYPE for the mixed mappings case.
> 
> Alternately, maybe we /should/ let programs open a lease-fd on a file
> range, do their untorn writes through the lease fd, and if another
> thread does something to break the lease, then the lease fd returns EIO
> until you close it.

This still violates the "no unexpected errors" paradigm.  The whole
FALLOC_FL_WRITE_ZEROES (I hate that name btw) model would only work
if we had a software fallback that make the operations slower but
still work in case of an unexpected change to the extent mapping.


