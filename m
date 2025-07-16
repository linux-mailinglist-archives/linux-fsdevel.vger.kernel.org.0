Return-Path: <linux-fsdevel+bounces-55144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD1AB07494
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821E31C25F6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB5A2F3C1A;
	Wed, 16 Jul 2025 11:22:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62EF28BA8D
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664924; cv=none; b=pac3+RgD/dAZFetyAGDtSY7MBHV2v/Ebl7N3zRGCyNMg9aly/WOAEALbIlSUWGtxTXrOAAUcdXxckqKqkMOOGf+1V+ZoSrDLKsQF6XNFBuzFF3UVCmHDrbTqPH+WD2lkeNZQZqCf8M0+pmFThiyWXQnO4eha6/FLyGrq5bsN2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664924; c=relaxed/simple;
	bh=Am3Bzbee8p751rtnoOwyQDhno+3ylCnd8u4OEBccBV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGMMhLcrh0N1bLY0fT8bGP7svd0UgHX1whk6KLH8Gzm+EIiIU+714IhgRTb/8b2B6IQleZms+UTMKPBZ+z1Mr0UShml0w40+hWNCLyoKCDc2soFpyGGrz5Fpx6Ya9FJjQl8FzzWFWNqk08yAvk5SB03yy/0riHrfch+CPGrWLgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4AF2268B05; Wed, 16 Jul 2025 13:21:50 +0200 (CEST)
Date: Wed, 16 Jul 2025 13:21:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250716112149.GA29673@lst.de>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 15, 2025 at 04:35:24PM +0200, Christian Brauner wrote:
> Unless there are severe performance penalties for the extra pointer
> dereferences getting our hands on 16 bytes is a good reason to at least
> consider doing this.
> 
> I've drafted one way of doing this using ext4 as my victim^wexample. I'd
> like to hear some early feedback whether this is something we would want
> to pursue.

I like getting rid of the fields.  But adding all these indirect calls
is a bit nasty.

Given that all these fields should be in the file system specific inode
that also embeddeds the vfs struct inode, what about just putting the
relative offset into struct inode_operations.

e.g. something like

	struct inode_operations {
		...
		ptrdiff_t		i_crypto_offset;
	}

struct inode_operations foofs_iops {
	...

	.i_crypto_offset = offsetoff(struct foofs_inode), vfs_inode) -
		offsetoff(struct foofs_inode, crypt_info);
}

static inline struct fscrypt_inode_info CRYPT_I(struct inode *inode)
{
	return ((void *)inode) - inode->i_op->i_cryto_offset;
}


