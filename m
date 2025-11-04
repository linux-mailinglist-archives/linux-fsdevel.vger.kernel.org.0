Return-Path: <linux-fsdevel+bounces-66921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8142C30A55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 12:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357B818C1B5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE63F2E3373;
	Tue,  4 Nov 2025 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xG1M2bJ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E38D2D23A4;
	Tue,  4 Nov 2025 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254136; cv=none; b=FDz6i+k3CsMDK+dU9tAY+9bOybrDrHNUHqQ9c9uSzXf1DWVA1Gnjo1Ax1LL85wIdftWM10gCFgrglVOZux/WLVsFqrnwLbVyJ/OF/brTu3ylZXMptes6aBJkx23vP323/rBAd0k72hl6jjF1OOjHaGuCuogifov54zLh+O16Ba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254136; c=relaxed/simple;
	bh=Bu+eKPZx/dw5XpxmyXLYE5uGSmlZ6ktOX5fWynHSTHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwZhnqroNiY7weJKbplzf3FMzKoVEaid1WnlNB5+pe7r8/QXQ33yfvz+uUo4iWVn04/LgWmDPL8jmZpANV+3tkB1EULihHSh/ikKnFEosK430LWHm7paMn9HOFveZX1mTe/e2Qz3djHZ8WpAku8od4MYEkqjx4srScsmlri+sck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xG1M2bJ+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p0gKISrkmvQR4fbK8GO3Fkb54ut/Sj+KzqoO4yKrixY=; b=xG1M2bJ+og4CM4Z1yIYn7h/twZ
	3QI3biSnM4I1yJpzczQr5ixRZ9gTmogB1AKbbeExc5gthzdiVFmIIkuphtAYdzerSCkwoZrx+f7Jj
	tErM+kDrKMZV8K34EuYiE90lgRJIOVskJFhBCF8MOMiS0A9DpLMueXIZC/3nta6by9xOsRGyTakpM
	1BhsHTZKHi4A5NA7GqTbF7j0LeZRyHJPpsANc/y3zIgN8mkwZJyY302mYsFKbz/T8nk4zILfhrmch
	uW5TxOtuCe+CWSbaPFDXGE2A8gsIR15tpGYsA4pjjOcLQDliwQv9JAVYRNcrx2+vmreTR3pPOdD2z
	OsIhkGzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEnj-0000000BgHr-4781;
	Tue, 04 Nov 2025 11:02:11 +0000
Date: Tue, 4 Nov 2025 03:02:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [PATCH v5 3/5] isofs: check the return value of
 sb_min_blocksize() in isofs_fill_super
Message-ID: <aQndM_Bq1HPRNyds@infradead.org>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
 <20251103164722.151563-4-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103164722.151563-4-yangyongpeng.storage@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 04, 2025 at 12:47:21AM +0800, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> sb_min_blocksize() may return 0. Check its return value to avoid
> opt->blocksize and sb->s_blocksize is 0.
> 
> Cc: <stable@vger.kernel.org> # v6.15
> Fixes: 1b17a46c9243e9 ("isofs: convert isofs to use the new mount API")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
>  fs/isofs/inode.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 6f0e6b19383c..ad3143d4066b 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -610,6 +610,11 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
>  		goto out_freesbi;
>  	}
>  	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
> +	if (!opt->blocksize) {
> +		printk(KERN_ERR

This should probably use pr_err instead.


