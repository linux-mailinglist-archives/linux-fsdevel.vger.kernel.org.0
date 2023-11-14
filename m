Return-Path: <linux-fsdevel+bounces-2842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32097EB443
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37B11C20A7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0365741A8C;
	Tue, 14 Nov 2023 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="umn8h7gl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990D341A84
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:57:07 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF70FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XQcDDRiPB4/U3WzhS/keMRc1+CiDCqiCYGWzXZFZ6Yg=; b=umn8h7glIKiD/gqAgbTCpzBKQf
	iht40jDhzBv98P98+YELlNjNjqDlbWgXK/y96jE1A2cghNWBEcJ7qtJUczpdbQwq8+471+NMmKbaJ
	EBoYEtQExXfmftHOp5AdlPJwLoURTn8oIoZ80gcLDn3LZ50H6hBawONRc1uIZsRMisa/sY9xrlyGd
	f+Z7nzBEXJXxtaUp9+NUGftNii0VPS5nhaW04Klqp8dXLZqrQ4syaqYMyBYRzYTi7CdtI9EZiYQLA
	H5qRTEJF6GzG6Ve+OltugprPEfvTfeRNPPIgIkv28K4ssoLQm46QL4VgRg4NvEVRiCXS4XV2Nt76t
	5z/IxQcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r2vmU-008qNx-HY; Tue, 14 Nov 2023 15:56:50 +0000
Date: Tue, 14 Nov 2023 15:56:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, hughd@google.com,
	jlayton@redhat.com, viro@zeniv.linux.org.uk,
	Tavian Barnes <tavianator@tavianator.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC] libfs: getdents() should return 0 after reaching EOD
Message-ID: <ZVOYwikYNWMBg1bC@casper.infradead.org>
References: <169997697704.4588.14555611205729567800.stgit@bazille.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169997697704.4588.14555611205729567800.stgit@bazille.1015granger.net>

On Tue, Nov 14, 2023 at 10:49:37AM -0500, Chuck Lever wrote:
> -static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> +static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  {
>  	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
>  	XA_STATE(xas, &so_ctx->xa, ctx->pos);
> @@ -437,7 +437,8 @@ static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>  	while (true) {
>  		dentry = offset_find_next(&xas);
>  		if (!dentry)
> -			break;
> +			/* readdir has reached the current EOD */
> +			return (void *)0x10;

Funny, you used the same bit pattern as ZERO_SIZE_PTR without using
the macro ...

> @@ -479,7 +481,12 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
>  	if (!dir_emit_dots(file, ctx))
>  		return 0;
>  
> -	offset_iterate_dir(d_inode(dir), ctx);
> +	if (ctx->pos == 2)
> +		file->private_data = NULL;
> +	else if (file->private_data == (void *)0x10)
> +		return 0;
> +
> +	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
>  	return 0;
>  }

It might make more sense to use ERR_PTR(-ENOENT) or ERANGE or something
that's a more understandable sentinel value?

