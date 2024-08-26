Return-Path: <linux-fsdevel+bounces-27173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4D295F27A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40D81F224EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7F317C9AB;
	Mon, 26 Aug 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kcRs0Up6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7713C695;
	Mon, 26 Aug 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677921; cv=none; b=FY3D3ucbfs4TZNJujs/oPNK0aCes3vBImZdTEt0HqwaMp5rLzSuStmRWgW8VRLNw+MSoZjnIO8VtbQF21xLSE5Nea2FCZw7dFC6xyMFQLwUdZ7vMxquqCZlvPQVLzVI1NhsKyqEFJBZSgdMCt+PVQVBNO4qDrhboOTkSsUzgVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677921; c=relaxed/simple;
	bh=ivF/jbpHiVz5xnl0u7eRNCvvm7IVCf7GHqjOdoyEiJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYu5O0bMaTDpm3cnYDh1waqo05FxFKSXgiwr8Al9X6jdK0yV9SFDEuHYl4sEttcq+WxGeS+lpG/WMQoyO/vilwKNINcZE7Aacxw6s//I6JypqwkMY9lqHaJ7m/O2AucAxlw8Ap4+jUqAAxp18YwBLrUeIvZ8kpLmR2N4+2+ok8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kcRs0Up6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CnEqIrJf/5Uvl3Jm/q/BrEQtwg9oxHJd/L725YJbtSg=; b=kcRs0Up6Cpe13NcGd7CsxcTXEg
	wfUx33ph4ytvCOW5PBAgqcDvh4o1EGSJoK5TGxQCgPNeuG/v3D6JkU/rF2hdYZcbDhu6XmX0Y461C
	LZZ8BwGkStTknZyAzOa9dQgtUckbdxeGFNrcU3twnz5o7iteGmZ3xjv70tJkt3u7oT/lbuXQlLbzO
	oSF3vL64NTiTdj3Z70gPw8W2W86zGz3Rd9OF/5fwwtq68NRPdXcEq+NKFk1zhI15jjtzu+HtZn8pt
	H5KbjDahvkUiYuDiMfOr8HwTsFriXnImrEp4FssGplhuGTpXTswtIQPfYPK+il474iHx5lr1OO8mC
	ZMNhtxgw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siZVT-0000000FQMj-2njG;
	Mon, 26 Aug 2024 13:11:39 +0000
Date: Mon, 26 Aug 2024 14:11:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <Zsx_C0QuecO1C0dB@casper.infradead.org>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826085347.1152675-2-mhocko@kernel.org>

On Mon, Aug 26, 2024 at 10:47:12AM +0200, Michal Hocko wrote:
> @@ -258,12 +258,10 @@ static struct bch_inode_info *__bch2_new_inode(struct bch_fs *c)
>   */
>  static struct bch_inode_info *bch2_new_inode(struct btree_trans *trans)
>  {
> -	struct bch_inode_info *inode =
> -		memalloc_flags_do(PF_MEMALLOC_NORECLAIM|PF_MEMALLOC_NOWARN,
> -				  __bch2_new_inode(trans->c));
> +	struct bch_inode_info *inode = __bch2_new_inode(trans->c, GFP_NOWARN | GFP_NOWAIT);

GFP_NOWAIT include GFP_NOWARN these days (since 16f5dfbc851b)

> +++ b/fs/inode.c
> @@ -153,7 +153,7 @@ static int no_open(struct inode *inode, struct file *file)
>   * These are initializations that need to be done on every inode
>   * allocation as the fields are not initialised by slab allocation.
>   */
> -int inode_init_always(struct super_block *sb, struct inode *inode)
> +int inode_init_always(struct super_block *sb, struct inode *inode, gfp_t gfp)

Did you send the right version of this patch?  There should be a "_gfp"
appended to this function name.

> +++ b/include/linux/fs.h
> @@ -3027,7 +3027,12 @@ extern loff_t default_llseek(struct file *file, loff_t offset, int whence);
>  
>  extern loff_t vfs_llseek(struct file *file, loff_t offset, int whence);
>  
> -extern int inode_init_always(struct super_block *, struct inode *);
> +extern int inode_init_always_gfp(struct super_block *, struct inode *, gfp_t);

You can drop the "extern" while you're changing this line.

> +static inline int inode_init_always(struct super_block *sb, struct inode *inode)
> +{
> +	return inode_init_always_gfp(sb, inode, GFP_NOFS);
> +}

