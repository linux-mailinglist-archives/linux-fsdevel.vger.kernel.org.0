Return-Path: <linux-fsdevel+bounces-55783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFA0B0EC4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 09:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093BE188FC8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFFC2777F7;
	Wed, 23 Jul 2025 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwj5ozgY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB52E3702;
	Wed, 23 Jul 2025 07:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256945; cv=none; b=cxiCTBTHgvKntoUe3MeIXlZ8eXJM/UOwtB/mKkuPPTpgEqUVOCU5lzB3HZrn/v0VeG7URj8MFgJVjeLAXTswuSMHoa3rbT0skHrnAcBAn4I1i8VulBvUph+uUSMtbPa+BOjXfXRqAugKjv8M1UJmMAdAAi8C95bvkNKF7Md7q0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256945; c=relaxed/simple;
	bh=G4WkaStE+bj6CNS9Ei4cGCUmXipi92IfiidiAfTcaYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3dfbka2ZwnuLrijgCPvm09nILuaZ/UjN4JyteaUqni2fNazqKfglXqe4vIckS9+9jD8L9NBMez+xueiVVUHD2K8A6hJ/TcNhHaM2okR5m8s2DuZL6nTcbFHViKCH7Vx3yg8MekDkDdoCkcRKel/XjT8ribjDmW7UoOYWgEDJEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwj5ozgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82812C4CEE7;
	Wed, 23 Jul 2025 07:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753256945;
	bh=G4WkaStE+bj6CNS9Ei4cGCUmXipi92IfiidiAfTcaYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwj5ozgYypNTL5LxFYg5ulcTze3iCYmX3pN8GXKPRMofz+Kcj+UO8fT5xpDCKb6YH
	 bCdtPh68Lqadskj2Gnyr6UlmU51SDKRed4FqjUP0Lr8TfX/hfAeLu0+sU1P+rrK2fE
	 Oq7/wJBQV5p7V823aJ1Qxvx+jl4SuhSrnJhIMBFc3CmqSXM2GPMCoZ1bC/UFvv+lyc
	 vStluLnqluE59iQLq2aKGrrcHGA+4FJlq3IYMZ12qfkv4gBrDZNKnWsxyPt60Pxmx4
	 K5lYuy3/PiRRMukIu/lfLGpdnuE5kHE5kbpgqIzz12n2DIvl9GXp8excw9IntRRRxB
	 yMplUBFXpzRPg==
Date: Wed, 23 Jul 2025 09:48:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v3 01/13] fs: add fscrypt offset
Message-ID: <20250723-unbewusst-nordmanntanne-a3236820354f@brauner>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
 <20250722-work-inode-fscrypt-v3-1-bdc1033420a0@kernel.org>
 <20250722200225.GA111676@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722200225.GA111676@quark>

On Tue, Jul 22, 2025 at 01:02:25PM -0700, Eric Biggers wrote:
> On Tue, Jul 22, 2025 at 09:27:19PM +0200, Christian Brauner wrote:
> > Store the offset of the fscrypt data pointer from struct inode in struct
> > super_operations. Both are embedded in the filesystem's private inode.
> > 
> > This will allow us to drop the fscrypt data pointer from struct inode
> > itself and move it into the filesystem's inode.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  include/linux/fs.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 96c7925a6551..991089969e71 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2332,6 +2332,7 @@ enum freeze_holder {
> >  };
> >  
> >  struct super_operations {
> > +	ptrdiff_t i_fscrypt;
> >     	struct inode *(*alloc_inode)(struct super_block *sb);
> >  	void (*destroy_inode)(struct inode *);
> >  	void (*free_inode)(struct inode *);
> 
> If using inode_operations was ruled out, so we have to go through the
> super_block to get to an operations struct anyway, wouldn't it make more
> sense to use fscrypt_operations and fsverity_operations?  They are

Good idea.

> accessible as inode->i_sb->s_cop and inode->i_sb->s_vop.  Same number of
> dereferences as getting to inode->i_sb->s_op.

I also like Al's idea to move the offset directly into struct
super_block.

Hm, but conceptually moving it into the respective operations would make
a lot more sense...

I'll just sketch both and see what feels cleaner.

