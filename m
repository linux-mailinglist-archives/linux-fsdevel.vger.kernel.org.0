Return-Path: <linux-fsdevel+bounces-55408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6D9B09E06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 10:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D37D57AFA4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C8728C5CF;
	Fri, 18 Jul 2025 08:32:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4A2192EA
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827534; cv=none; b=iDCEokRZT3czAYrVs6GymKSA4+VRWQlyO4+B61mmyEjbRiGE/osIIhmj3WL+GsDRyFk4Zd7DANZhLUsbkEzQfhAbiGNr0J/3rqcWpIj090ZQwCgpNSkS+liKIh5zfBD8TSepub+yh9GoQ42U6F/VDowCRg7BS/KClttWKaoM2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827534; c=relaxed/simple;
	bh=QUIIHaryAr7rA+ZKdyyhjP6G8evFUCWrELyT2Fukh/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtdP4eGJPBh3rHU4tgQN+PyxMqBYlGV/ItVd9S39SmkCxnGrJGvfp8/xvRZxcNNjrPR1pgLBm+RYjRpS7nbv9Z4hs3CqnJlUpTb33wF3kqH8vYdVR4NghwCyjsj9lVbTjRUChEBn9HUU5fyIymqIHTPdktXdCpkOBFnjESnGXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 346A3227A87; Fri, 18 Jul 2025 10:32:07 +0200 (CEST)
Date: Fri, 18 Jul 2025 10:32:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.com>, Jeff Layton <jlayton@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, fsverity@lists.linux.dev
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250718083206.GA23501@lst.de>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org> <20250716112149.GA29673@lst.de> <20250716-unwahr-dumpf-835be7215e4c@brauner> <q4uhf6gprnmhbinn7z6bxpjmdgjod5o7utij7hmn6hcvagmyzj@v5nhnkgrwfm5> <20250718-funkkontakt-gehrock-c78ddcf4e009@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-funkkontakt-gehrock-c78ddcf4e009@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 18, 2025 at 10:24:47AM +0200, Christian Brauner wrote:
> We can't just keep accumulating more and more stuff in our core
> structures. The bpf people are breathing down our neck to put more
> things in struct inode and I'm sure the next thingamabob is already in
> the works and we need a way to push such stuff out of core struct inode.

Agreed.  And as mentioned I'like to think even further and avoid
having these optional bits in the fs inode unconditionally if there
isn't a good reason for that.  I mentioned quotas before, but an even
more extreme case is fsverity.  If I understand the fsverity use case
correctly it is usually used for a very small number of files in the
system only, and you'd usually do bulk reads from them.  So instead of
bloating the inode, be that the generic one or that of the file systems
that use it, why not have a global rhastable index by the inode address
to look it up?  Compared to the actual hash generation and verification
a lockless hashlookup is complete noise, but we'll save a lot of
memory.

