Return-Path: <linux-fsdevel+bounces-23265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E067E9299BE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2024 22:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFB01C2091B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jul 2024 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117526BFA3;
	Sun,  7 Jul 2024 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VWVD1vUf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EEC10A22;
	Sun,  7 Jul 2024 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720384977; cv=none; b=n08sVuH/WHKf/GI3+GS3JV5WGyIiXwBQC6O5x/th9KRe1wHkFgGBOJXB87pySJ2RN/pNwa9xJZr6rfy+l9KLfxAQzAAkhWU9O17h6yoxrggrWhE1qTelfW+x5q4O87hnJDz7zKFS91oPHN6xbeczcwKm0mMM5dQH/SfX7Ct4xBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720384977; c=relaxed/simple;
	bh=RBaEyB0hYUmHj0qwGXJOliUtK26+xZiPh5h59IHYLH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT4xaxym5O4F6Skn+QYROdlbq+bGFResT3xmu6BFLCEv2i7NmxiVbfx/n35B5VtTYbqQKKTup6g/AIHZyyf1E2ETcJAuEdjCRMsh4s48ydWVzeoq4zCgyU8Wzmvc4PS5ZGi0ct1QkorGouhrLXwEM6F71iIxkPTaA/BpfLt/NGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VWVD1vUf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E4t7K6jsKFUcklm23c0fYGzuO5K87mgRZHzbC1H4aDs=; b=VWVD1vUflbb2QNSZqN78Xmtdhd
	rzubkzQ4PjnfOPpWGXJSP5HvLhDeYVhdLQjth+JUo9wGLeWQ6c+Hw4hdi/UVMOQCHp4KuHCIENC16
	zj055gSoVhPRfYjeVopx3jwKutJgNFzSXdd17dyCKMe0zQl6Mi782AottuN26P91aslzb2x7DLsB5
	veRAZ1i0b4rox9Q5tQDtS6glrqOsuNaN11AfAZqZStD2Faya6yf02CzltttXxDEn5MGtYji+KrEqA
	9ZMmPN55PoY8Nz3xeh+sbDvDrq45ls7B6+AqIEMxZ0DuGf0hCi3T6Wmrhdp0s9I2kVdxEbDvMkSH/
	5kNrv0/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQYiY-00000006DXW-1QRx;
	Sun, 07 Jul 2024 20:42:42 +0000
Date: Sun, 7 Jul 2024 21:42:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: ed.tsai@mediatek.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	wsd_upstream@mediatek.com, chun-hung.wu@mediatek.com,
	casper.li@mediatek.com, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] backing-file: covert to using fops->splice_write
Message-ID: <Zor9wiPTXCsnTVdt@casper.infradead.org>
References: <20240705081642.12032-1-ed.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705081642.12032-1-ed.tsai@mediatek.com>

On Fri, Jul 05, 2024 at 04:16:39PM +0800, ed.tsai@mediatek.com wrote:
> +++ b/fs/backing-file.c
> @@ -280,13 +280,16 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
>  	if (WARN_ON_ONCE(!(out->f_mode & FMODE_BACKING)))
>  		return -EIO;
>  
> +	if (out->f_op->splice_write)
> +		return -EINVAL;

Umm ... shouldn't this have been !out->f_op->splice_write?

>  	ret = file_remove_privs(ctx->user_file);
>  	if (ret)
>  		return ret;
>  
>  	old_cred = override_creds(ctx->cred);
>  	file_start_write(out);
> -	ret = iter_file_splice_write(pipe, out, ppos, len, flags);
> +	ret = out->f_op->splice_write(pipe, out, ppos, len, flags);
>  	file_end_write(out);
>  	revert_creds(old_cred);
>  
> -- 
> 2.18.0
> 
> 

