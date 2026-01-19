Return-Path: <linux-fsdevel+bounces-74377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E6CD39F4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4FD303C236
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0394D2D8760;
	Mon, 19 Jan 2026 07:05:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508B289811;
	Mon, 19 Jan 2026 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806339; cv=none; b=i10KbyE9gHOwPn8+H4lgKRFlCYcJe4pvoz7XE2VldXNJxBXXaIxshB04Mn5IhqcX3UtGPYj/5WzXEtO5GWwXLFMSRL2nYwnKps3PpfExxSKP6grfjUed8fPx3ejJmwkR+dv/nhxZKWIis3Jk6wB7XSpvbP8j1hCjofbedc1UoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806339; c=relaxed/simple;
	bh=El1Wk9ESbXAUdZuL9qJMmfTBcK2P7M+M/0jtg7mEUCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RczS/5tXy06xb578P37ZgTefZGZBlim1dEAuT1CRgoVpwlzcJQK3NB2y93I+w3BlKxSvU+HxzGNf1h0+n/gSNaMvKPJEINTynOEDpCYzPUf/dDwiJsW5vOxKhw6V39Zejp4YaXCDMLB5jTHsMCqVlG7juais2d05SqKuSk5wh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F0C1227AB0; Mon, 19 Jan 2026 08:05:29 +0100 (CET)
Date: Mon, 19 Jan 2026 08:05:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, tytso@mit.edu, willy@infradead.org,
	jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com,
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org,
	dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org,
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v5 02/14] ntfs: update in-memory, on-disk structures
 and headers
Message-ID: <20260119070527.GB1480@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-3-linkinjeon@kernel.org> <20260116082352.GB15119@lst.de> <CAKYAXd9SeJYhBOOK6rZ+0c4G42wvFZkjJ9vGnSrythsz55WLwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd9SeJYhBOOK6rZ+0c4G42wvFZkjJ9vGnSrythsz55WLwA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 18, 2026 at 01:54:06PM +0900, Namjae Jeon wrote:
> > It seem like big_ntfs_inode is literally only used in the conversion
> > helpers below.  Are there are a lot of these "extent inode" so that
> > not having the vfs inode for them is an actual saving?
> Right, In NTFS, a base MFT record (represented by the base ntfs_inode)
> requires a struct inode to interact with the VFS. However, a single
> file can have multiple extent MFT records to store additional
> attributes. These extent inodes are managed internally by the base
> inode and do not need to be visible to the VFS.

What are typical numbers of the extra extent inodes?  If they are rare,
you might be able to simplify the code a bit by just always allocating
the vfs_inode even if it's not really used.

Nothing important, though - just thinking along.


