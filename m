Return-Path: <linux-fsdevel+bounces-55777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34E8B0E95C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 05:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AAA5479BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 03:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAE1205AB8;
	Wed, 23 Jul 2025 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KA2qFbVx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6DE2AE72;
	Wed, 23 Jul 2025 03:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753242790; cv=none; b=j9NMSX7yf4UaxalFybZ9upa6rSDfoVwJNPXuvi6yM69h7m6iNi/GzzrDtBIu6EVJdkMXAoMxahg0awrhSU302K8cBlawfIwGXPsyPpCdbRf2w1l4ZixpQPbxQCoY23QVvjEIESPDdaVVhM8OlY3KCrQPB2w5E9teIzIiUxDEXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753242790; c=relaxed/simple;
	bh=TErjSmjWuM9IloPy5ROTbOJjE2CJcrThv7WoNEuKTMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGEvmfgDyM4d5rCWohA3tQgzBOahuykQGe3Ls8KB2y7W4d6dHBQ/ymTrR1YWQMJgaem00WZbPgc9SAC82zg1om2kfnBoybapE/eM4HMpqHoVJhguBTsD7TAHVEenGmUlcef//QH5yvimdKh481XZx9oLz8OVbtRqX5skDoc6fxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KA2qFbVx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EfN7CuPj4EbXO8B6SO7XNvM3n8v4ZoyWfloAZiJ9u2I=; b=KA2qFbVxb93+UfFdpZwGKt4E70
	3CPT0mgotgh/oVrfXXiVrdAU1iU4mkKPb6BosvbypgmR4XKFIDh1GA39ZyRMJH/2Tt5Her4nmKBAl
	VlKLDPa2h9dU29KZd/ajBiEJW7n4rrok4sW+OSH6erAd85Ud8MrChuw+Tj7kpOWyj7BkuJvrvqInC
	+OzcT8zBA/lBZkJ0taccn/+cEN1WvuThhjyRq9CuYC9t7G5Dj+vyVnfb/7O1jxVvTew4TlkJeI5gE
	WOoYmBemcwisRvg46Ihwd1sRrka8kroktvCaykZjAEBtNTN9fIcfRAbkVhCycvxN++++nGQ3sOzJJ
	bMqfNyBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueQXR-00000005fEU-3C0v;
	Wed, 23 Jul 2025 03:53:05 +0000
Date: Wed, 23 Jul 2025 04:53:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v3 08/13] fs: add fsverity offset
Message-ID: <20250723035305.GO2580412@ZenIV>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
 <20250722-work-inode-fscrypt-v3-8-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-work-inode-fscrypt-v3-8-bdc1033420a0@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 22, 2025 at 09:27:26PM +0200, Christian Brauner wrote:
> Store the offset of the fsverity data pointer from struct inode in
> struct super_operations. Both are embedded in the filesystem's private
> inode.
> 
> This will allow us to drop the fsverity data pointer from struct inode
> itself and move it into the filesystem's inode.

Same point re store in super_block itself.

