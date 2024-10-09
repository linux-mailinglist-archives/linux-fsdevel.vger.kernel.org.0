Return-Path: <linux-fsdevel+bounces-31420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154C49960ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 09:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6EC1C23ED1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC06936D;
	Wed,  9 Oct 2024 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fe/tI5M+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237917B50E;
	Wed,  9 Oct 2024 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459097; cv=none; b=Wr4cqHhrZmrRg+6+XvWzolNikLD7xe2aKpwuVByzgj/Rbp1QC9t+I8wTIBS1jfSCXWaQodm2ixI5Iu/BYbIW2Kb2KIFaWnE8SzXQSwgOUN2Nmma25+QzhbKnxHzh7FFYegKts1GtWSqyMRe5X5eYkZpXFkVb5RGFQann20/l+oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459097; c=relaxed/simple;
	bh=59AowXhijYdkLiOAySj4hnJnX4zejugdv+M/XDYMIiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkApt3ILxzARrLcoBUrVip5dAox/qL3CFUfXH/rH/f6cgjKSMEi2LNpvxpSAduOqKX8rO6eEWRbIJDrtac7sxd+y33E5Pz3pl44fkQiSnvXyn70LgSvCCQz1rl10OEhA5JxTASmW4tV5tG7gK5RRMVvPBtzJMJGoNBof7KFQQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fe/tI5M+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jZqLAC3MRdTsqXfdRTrZ8YpQt2c+tTA1yWYUJqu0P5c=; b=fe/tI5M+hy7HITYN8Vcm9vzsSn
	zSl69WsztIZ7NWUzZk/7J48NDLNXZnH16V3ol7noRDmSxfFz6Bs06085H02Z9Yp+8+T1yBJBKEi01
	Hiz4IM2bHULEUHQCzlL//1l6w/PDuxBjmppkcaikA2+Yh2EqnBSamZOrxsz9zliPZvyCUa+VIocKd
	NuxNLQLPs1N3GMmNU5kiJEnrOwXVItruDzxXospaupEfR5wosuG87xyB/G6FbRsaNp0I+fmgZzh8r
	0QLmmE7jenjDl2THrkCbZ3e2uf9YZaHxHdeldtQJE1/CiU5/0dHgq0QV0IZjYGq/Kv43tAEqHA71X
	Tvzgsf2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syRAT-00000008FFP-2t3k;
	Wed, 09 Oct 2024 07:31:33 +0000
Date: Wed, 9 Oct 2024 00:31:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>,
	Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] erofs: use get_tree_bdev_flags() to avoid
 misleading messages
Message-ID: <ZwYxVcvyjJR_FM0U@infradead.org>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
 <20241009033151.2334888-2-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009033151.2334888-2-hsiangkao@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 09, 2024 at 11:31:51AM +0800, Gao Xiang wrote:
> Users can pass in an arbitrary source path for the proper type of
> a mount then without "Can't lookup blockdev" error message.
> 
> Reported-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>
> Closes: https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> changes since v1:
>  - use new get_tree_bdev_flags().
> 
>  fs/erofs/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 666873f745da..b89836a8760d 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -705,7 +705,9 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>  	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>  		return get_tree_nodev(fc, erofs_fc_fill_super);
>  
> -	ret = get_tree_bdev(fc, erofs_fc_fill_super);
> +	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
> +		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
> +			GET_TREE_BDEV_QUIET_LOOKUP : 0);

Why not pass it unconditionally and provide your own more useful
error message at the end of the function if you could not find any
source?


