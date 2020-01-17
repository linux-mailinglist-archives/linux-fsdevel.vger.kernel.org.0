Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164F3140166
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 02:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgAQBVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 20:21:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729031AbgAQBVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 20:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jcajjxZ1xWQD9GN1eFNPK4/qoRHMGlsWkodtrglknLA=; b=sigesBb15/hF+QKL8jZxrBOUc
        nnZIcoGtGP8fXCdmd4UFK1FVFA+krbsrDCI4gNAiETqEt2BgzTsJnFlmQTdXBs7nEI3CTYD/QtLrS
        78nB82UNUZc1TBhOoFPbQpN9qHRQwX7PtqmWCBSaWshL2egA1wXxWW6BE9/MeCeNHEjWHSZfN8GqD
        WJpv4HOdgZ0o5mKmmGh6oaBW3h0JXeVs29rLeC6EYEgsGa8do4sj4jmol+hJHSyiU72+GTC7zm3RX
        gkBrhYTmlTylxlJu2JWgE2xK76y1QjV+BVBMf+xI6I04LxhRq42PJr5uDXpfNZ0Wd6/+OZu3ivK7+
        UEuNsYVfg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isGKB-0003RF-3D; Fri, 17 Jan 2020 01:21:23 +0000
Date:   Thu, 16 Jan 2020 17:21:23 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: optimise kiocb_set_rw_flags()
Message-ID: <20200117012123.GA9226@bombadil.infradead.org>
References: <7d493d4872b75fc59556a63ee62c43b30c661ff9.1579223790.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d493d4872b75fc59556a63ee62c43b30c661ff9.1579223790.git.asml.silence@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 04:16:41AM +0300, Pavel Begunkov wrote:
> kiocb_set_rw_flags() generates a poor code with several memory writes
> and a lot of jumps. Help compilers to optimise it.
> 
> Tested with gcc 9.2 on x64-86, and as a result, it its output now is a
> plain code without jumps accumulating in a register before a memory
> write.

Nice!

>  static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>  {
> +	int kiocb_flags = 0;
> +
>  	if (unlikely(flags & ~RWF_SUPPORTED))
>  		return -EOPNOTSUPP;
>  
>  	if (flags & RWF_NOWAIT) {
>  		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
>  			return -EOPNOTSUPP;
> -		ki->ki_flags |= IOCB_NOWAIT;
> +		kiocb_flags |= IOCB_NOWAIT;
>  	}
>  	if (flags & RWF_HIPRI)
> -		ki->ki_flags |= IOCB_HIPRI;
> +		kiocb_flags |= IOCB_HIPRI;
>  	if (flags & RWF_DSYNC)
> -		ki->ki_flags |= IOCB_DSYNC;
> +		kiocb_flags |= IOCB_DSYNC;
>  	if (flags & RWF_SYNC)
> -		ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
> +		kiocb_flags |= (IOCB_DSYNC | IOCB_SYNC);
>  	if (flags & RWF_APPEND)
> -		ki->ki_flags |= IOCB_APPEND;
> +		kiocb_flags |= IOCB_APPEND;
> +
> +	if (kiocb_flags)
> +		ki->ki_flags |= kiocb_flags;
>  	return 0;
>  }

Might it generate even better code to do ...

 	int kiocb_flags = 0;
 
+	if (!flags)
+		return 0;
 	if (unlikely(flags & ~RWF_SUPPORTED))
 		return -EOPNOTSUPP;
 
...

-	if (kiocb_flags)
-		ki->ki_flags |= kiocb_flags;
+	ki->ki_flags |= kiocb_flags;
