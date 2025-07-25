Return-Path: <linux-fsdevel+bounces-55990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CD1B1153E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984CE3A5F10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 00:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB7B13CF9C;
	Fri, 25 Jul 2025 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcU6p5lE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12E339A8;
	Fri, 25 Jul 2025 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403443; cv=none; b=YPORSfSSfq3Gs0V+t2LwUiqfgyfP2d8XEKwVo4CbtkWPJS3EzLrBvhJpYazL0T+j42ghUxuBMEoI8Vu0kGCpQj4aAmDXrsDAhpAkIU/hC/cASrlE+0CYDUbKJuOR1Q/71Q3oEfVxH2cvtueL9mpyPNxlzbQ+2F+H+A8GwlUPCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403443; c=relaxed/simple;
	bh=Hm9DhouBSizd171vdM428+0HO+UeqkdHyndtvRvjbow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTazn43cT1Fpv2hN9XRoEk4Ip0YpmXkBzSuJQX6O19y5cbPzi5RWWQCPllpxFwUJM0FgxsuVUpBWybvk8bXlxEXscA6u5G2lthbf6XDfO7ERnNkPuHCMU9ae+M+TExLKSGbJnoE3wCFxPxHCwnyLQt3DN8UDwbs6Uo2qcoU+Vss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcU6p5lE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29637C4CEED;
	Fri, 25 Jul 2025 00:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753403441;
	bh=Hm9DhouBSizd171vdM428+0HO+UeqkdHyndtvRvjbow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QcU6p5lEvsHPmDYaSEtZxGInralH06D1gK3SOcQFUm1neURzgwgbvgOMv0xzdJiGU
	 joQ8HpCNkE9He8iWY6y4OCInP1wU2221IBfiVmuDnjr9nFovbhfoDS5MfnsoP/Wpy+
	 bskYbr4ENlIQlffbUs6NvlH7S8Yx33SUmgI7SKDoRIsl1XsTKh9EPkC2ENDC0IEapY
	 y6/7I3vaoRLCYWhWWBCTQKCskLolvL7pYs3RrlZovRIlAFYeUcmLq05GEJptWqhSQw
	 0tIGthPGKSZLTXBtq129PCTDFxaenrc4n1c4nfzskp2MZw/axMyHlA8jGExUecF5ZC
	 nLXNj0pz185tA==
Date: Thu, 24 Jul 2025 17:29:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v4 02/15] fs/crypto: use accessors
Message-ID: <20250725002951.GA25163@sol>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
 <20250723-work-inode-fscrypt-v4-2-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-work-inode-fscrypt-v4-2-c8e11488a0e6@kernel.org>

On Wed, Jul 23, 2025 at 12:57:40PM +0200, Christian Brauner wrote:
> fs/crypto: use accessors

fscrypt: use accessors to get/set inode info pointer

> Use accessor to get and set the fscrypt info from the filesystem.
> They can be removed once all filesystems have been converted to make
> room for fscrypt info in their own inodes.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

It would make more sense for this to be patch 1.

Patch 2 then would be "fscrypt: add support for inode_info_offs", adding
the field and the support for it in the accessors.

- Eric

