Return-Path: <linux-fsdevel+bounces-55149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7C4B07574
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC7F7AE2C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5D32F431F;
	Wed, 16 Jul 2025 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLRKlqBZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C4D23ABB0
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668402; cv=none; b=uHT0fXCjabkXp+le8wDRbwiL5T4QHPNTnwTIxQ8F8vhhoaDUBu2aXhnunvMTRDxwOF3145J8m0rosHL0SQfEBufYZPV49qqATMnk3Y4YR1zqZB8Ap2jbCv1D0Fgyl5CZ3lVYogaqphIzXushBlHR0q5MyWXQm6Fxj8+EIQekxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668402; c=relaxed/simple;
	bh=KOLRkCkXPFUl6mqMV9E5w/MxNJ2WilYHtORxPJRr46w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HghQBCLsXPNeMaYBr1TYzd8ockNXxEWIV4c9YOj2eovcKtJe4whj2lyf115BsWc174YcDAhWcK4q8zkydbHmT4FdQZ53anpLiKYC/YrJiJKXhdxNcPJAyyOnaGZNliG4wvusuRBRYZZXcxTWhQ7MsVwx8xmv+dqhWWoUTz29Rjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLRKlqBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9523C4CEF0;
	Wed, 16 Jul 2025 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752668401;
	bh=KOLRkCkXPFUl6mqMV9E5w/MxNJ2WilYHtORxPJRr46w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLRKlqBZK9iPvkOGsKoH6Zp998KtdXV0KVsARp2gfOMhuz9UJE44NsAqr18tlJhwi
	 eG8b87Krcqw8Flw364QKdRFL2W1XOSvRTcDWTS2ljCpy3TmOPgUMGLocODeyXgSbju
	 3M2YRN2JL/D5NNG5a21ka6Vl1Nwhb/k9C2xC5f5xiHS939ehudjnpjkvMdIRa1d3kU
	 v/M++a69WhsyMw4zCl80XMElWMGSfBn1aXC33QXokwtUfhkc+8CcEe1p4tcWeTHly7
	 nstHcQJnoZgWFbNuUloHJ0wTIRhbUXr9iCMuu/37Fnk7p/wAoNTfXdHTv2PmRvVmL9
	 V6lStomD+M5Tg==
Date: Wed, 16 Jul 2025 14:19:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250716-unwahr-dumpf-835be7215e4c@brauner>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <20250716112149.GA29673@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716112149.GA29673@lst.de>

On Wed, Jul 16, 2025 at 01:21:49PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 15, 2025 at 04:35:24PM +0200, Christian Brauner wrote:
> > Unless there are severe performance penalties for the extra pointer
> > dereferences getting our hands on 16 bytes is a good reason to at least
> > consider doing this.
> > 
> > I've drafted one way of doing this using ext4 as my victim^wexample. I'd
> > like to hear some early feedback whether this is something we would want
> > to pursue.
> 
> I like getting rid of the fields.  But adding all these indirect calls
> is a bit nasty.
> 
> Given that all these fields should be in the file system specific inode
> that also embeddeds the vfs struct inode, what about just putting the
> relative offset into struct inode_operations.
> 
> e.g. something like
> 
> 	struct inode_operations {
> 		...
> 		ptrdiff_t		i_crypto_offset;
> 	}
> 
> struct inode_operations foofs_iops {
> 	...
> 
> 	.i_crypto_offset = offsetoff(struct foofs_inode), vfs_inode) -
> 		offsetoff(struct foofs_inode, crypt_info);
> }
> 
> static inline struct fscrypt_inode_info CRYPT_I(struct inode *inode)
> {
> 	return ((void *)inode) - inode->i_op->i_cryto_offset;
> }

Sheesh, ugly in a different way imho. I could live with it. I'll let
@Jan be the tie-breaker.

I've started working on this so best tell me soon... :)

