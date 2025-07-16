Return-Path: <linux-fsdevel+bounces-55173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB15B077A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 16:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66C458418D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCCC21CA00;
	Wed, 16 Jul 2025 14:10:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA2021C9F6
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675040; cv=none; b=qoi2zicZDIxFPrGozeXJAfazb1wpvEDNU6HAZDkXUU9IvRVQFJ1Xlz4yYyFwWhJRjMOzUYkAihPhBwVxA4++NtK+1G8yanwI9LUNSJSNvJaQtPKgKRmLZ95I1a43Kg3rS3NxlAz4LEdE4iluJgkQNb/IKy+KJIyj9mHBWOdh7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675040; c=relaxed/simple;
	bh=snGWjaImWXntwuTlZUt+TPtJKjCvEH/AO1TBlCpnSCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBvJ2u+uVpYsW5RYbH2i9Ol9UJkQo6/6GQ7ceCU5hyi1Dp3xjNdrr6f2V9x+rq5oN9HIvzmQYEvxaKlvkhAUgeY/GZz7GT/6Br8wiFNnQ5c36B/cQWH8um9JQdObokYFoHZBh624dhRsG0Sah+EzQqHR5MO9fsayhGIgQiLU78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB6C868BEB; Wed, 16 Jul 2025 16:10:30 +0200 (CEST)
Date: Wed, 16 Jul 2025 16:10:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250716141030.GA11490@lst.de>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org> <20250716112149.GA29673@lst.de> <20250716-unwahr-dumpf-835be7215e4c@brauner> <a24e87f111509bed526dd0a1650399edda9b75c0.camel@kernel.org> <aHeydTPax7kh5p28@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHeydTPax7kh5p28@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 16, 2025 at 03:08:53PM +0100, Matthew Wilcox wrote:
> struct filemap_inode {
> 	struct inode		inode;
> 	struct address_space	i_mapping;
> 	struct fscrypt_struct	i_fscrypt;
> 	struct fsverity_struct	i_fsverity;
> 	struct quota_struct	i_quota;
> };
> 
> struct ext4_inode {
> 	struct filemap_inode inode;
> 	...
> };
> 
> saves any messing with i_ops and offsets.

I still wastest a lot of space for XFS which only needs inode
and i_mapping of those.  As would most ext4 file systems..

