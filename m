Return-Path: <linux-fsdevel+bounces-67629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8388CC44B95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 02:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E48D345EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 01:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CCC21D3F6;
	Mon, 10 Nov 2025 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CwiFrC0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33B1E9905;
	Mon, 10 Nov 2025 01:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738029; cv=none; b=QywCywuBU9CmC44ziYZDczD4WRMGucxfEMI/w1H4UkNmk2n9URIuV+5UJ1UDgIH9+EJmAbI79cB1DoajUJpC6U9Hl8ha37UkDHZdciNK+9324KIID/Nyap3PIsBJpzE2tKgire7p8D0df0868ncAjtrgf8LsFrjVLzZ5zUplS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738029; c=relaxed/simple;
	bh=tzNHOK1d95q/1G8fyVpIDm80RxRcb2k1a3TLUSHEDxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psO6/sxo+tiL57QsX/vGfAdHw9BWLYrPl2MKId5X92WJ6rQCJbGNVqqtVMeFamdosawSqtaFTt23e8cuqu/DGAZEX4yFQ/AT6ZA888YjfVUoRpsCpT9nc+Jrdd/8Dxl5nEZiR52SfV856AFCps+AP0Bzcdnguv6mAdQy5AfXYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CwiFrC0I; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5oKuZgtaNQCtAJZcA95VPaPSHsVNko66++UTyGhLbWE=; b=CwiFrC0IiNO9S7Lp0rKvMOl5mr
	lDfz9diYj+q+9IccDXL+tKSE1jkBYnYf0W8UkcvD0e16vofsVnKFBwfNqmwRSJFMsvgSODKDdbGRm
	b1l+gRc2rR2GdmVYMaMhwiw7w/ZtuMtwnnr7tjDxuahfIau0/rbf+9ddsPPaH7VQkce/q+ls3RnEm
	rzLkrV630ykuW9v3JHU4Sdb6Osy2ZNH+gNh6Eesoj10E9Pt1KV5wrfk5fwQ+mxtDhSZgxV/gTqm3C
	Gs6m/0S4Jm2gQfA27q5cLCpkj4CMn3lkMeiBgeDTqIZ/vDZkyBGudpSZXPfGjd5Rmq0ZVVn0JCgk/
	TuNAFsGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIGgT-0000000CCy4-0QGq;
	Mon, 10 Nov 2025 01:27:05 +0000
Date: Mon, 10 Nov 2025 01:27:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: avoid calls to legitimize_links() if possible
Message-ID: <20251110012705.GI2441659@ZenIV>
References: <20251109185409.1330720-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109185409.1330720-1-mjguzik@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 09, 2025 at 07:54:09PM +0100, Mateusz Guzik wrote:

> @@ -882,8 +887,10 @@ static bool try_to_unlazy(struct nameidata *nd)
>  
>  	BUG_ON(!(nd->flags & LOOKUP_RCU));
>  
> -	if (unlikely(!legitimize_links(nd)))
> -		goto out1;
> +	if (unlikely(need_legitimize_links(nd))) {
> +		if (unlikely(!legitimize_links(nd)))
> +			goto out1;
> +	}
>  	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
>  		goto out;
>  	if (unlikely(!legitimize_root(nd)))
> @@ -917,8 +924,10 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
>  	int res;
>  	BUG_ON(!(nd->flags & LOOKUP_RCU));
>  
> -	if (unlikely(!legitimize_links(nd)))
> -		goto out2;
> +	if (unlikely(need_legitimize_links(nd))) {
> +		if (unlikely(!legitimize_links(nd)))
> +			goto out2;
> +	}
>  	res = __legitimize_mnt(nd->path.mnt, nd->m_seq);
>  	if (unlikely(res)) {
>  		if (res > 0)

Seeing that odds of extra callers showing up are pretty much nil,
I think your need_legitimize_links() is only obfuscating things.
Let's just make it
	if (unlikely(nd->depth) && !legitimize_links(nd))
		goto ...
and be done with that.

