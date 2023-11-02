Return-Path: <linux-fsdevel+bounces-1820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33B57DF26D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 13:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18791C20F0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 12:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DD918E34;
	Thu,  2 Nov 2023 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pTHDt05l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1F18E27;
	Thu,  2 Nov 2023 12:30:17 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F4137;
	Thu,  2 Nov 2023 05:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lLbEJjW9cmFlpV3shV0/lRN5bbIbbVeY+zCDD51WFMw=; b=pTHDt05lcN/Cquxk27BSdyCKgy
	hzNRR4QinKiGSXAT+IvNDIldJJss87ffYgIHYqGWe7fkQJzfVfWVAmqcKYjo5QW15CWq0u59MUihn
	h2bKPJMu4MRWcgPl8ZiIlyIEoGDnEougjsws6T/D40F/HB6pPn+HJTg62MGa5fiRnKOvCbXPhzsSh
	tRaYFDh46FTFcvpSzkTKCviXehU/1CUav+ATjAzMWf5BC/65dJTg5yFLVYZ1U4bHiTU7OoCJBejvv
	63covoTNDX8ZnRkSKNGOtl2gkFc4ePV5QLeaNOdmdnfFQK3GRq+bFLrxvs56WghPaAURYyAAsZZ12
	7Ch5wJxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qyWpn-004Qbg-9a; Thu, 02 Nov 2023 12:30:03 +0000
Date: Thu, 2 Nov 2023 12:30:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] vboxsf: Avoid an spurious warning if load_nls_xxx()
 fails
Message-ID: <ZUOWS6Vr0rg4VVIb@casper.infradead.org>
References: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>

On Wed, Nov 01, 2023 at 11:49:48AM +0100, Christophe JAILLET wrote:
> If an load_nls_xxx() function fails a few lines above, the 'sbi->bdi_id' is
> still 0.
> So, in the error handling path, we will call ida_simple_remove(..., 0)
> which is not allocated yet.
> 
> In order to prevent a spurious "ida_free called for id=0 which is not
> allocated." message, tweak the error handling path and add a new label.

That's not spurious!  You're freeing something that wasn't allocated.
A good quality malloc allocation will warn you if you free() a random
pointer.  I agree with everything abuot this patch (and the next) except
for the changelog.

> Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  fs/vboxsf/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> index 1fb8f4df60cb..9848af78215b 100644
> --- a/fs/vboxsf/super.c
> +++ b/fs/vboxsf/super.c
> @@ -151,7 +151,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  		if (!sbi->nls) {
>  			vbg_err("vboxsf: Count not load '%s' nls\n", nls_name);
>  			err = -EINVAL;
> -			goto fail_free;
> +			goto fail_destroy_idr;
>  		}
>  	}
>  
> @@ -224,6 +224,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
>  		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
>  	if (sbi->nls)
>  		unload_nls(sbi->nls);
> +fail_destroy_idr:
>  	idr_destroy(&sbi->ino_idr);
>  	kfree(sbi);
>  	return err;
> -- 
> 2.34.1
> 
> 

