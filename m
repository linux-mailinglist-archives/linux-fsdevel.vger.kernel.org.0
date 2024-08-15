Return-Path: <linux-fsdevel+bounces-26057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179EB952E6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 14:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B501F22B5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850B917C9B7;
	Thu, 15 Aug 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FF/rQBsZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D717C9A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725745; cv=none; b=LJopY77HTMwkjEMPFEDk+SC3DY0YdHFPgVVfrZ+SsjU+7D3RY7+iXpX7o6P9yZkdgRsLrTmH2Z5j6AFaPn+s2gbwV76eAUZa4bVJ/0g7hM27S0HNur5NKbuesctzCMD+seqoZMHd5l+a3P2qfpg7blsDBJQi9/6nOTaKWDyCEr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725745; c=relaxed/simple;
	bh=164T3A2szaPrSEyDZToq7LQvywW4ML1mM1dmHlVJ744=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlHjEkziGfDQJ8MIzz2lypb9dCt2ZdhJHACO0kI/wBQeY2flXIKqndbJ7nOTFNWnPDb7BGHj51iMdr1opsbeaIw8upc0nIzmwNMYPy4gZtlim4KBzPvvpBcDy/VIedt743BuKIxaSkKXiGpiCVM7nIFNG9UYaWT72GU0kWquAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FF/rQBsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774A3C32786;
	Thu, 15 Aug 2024 12:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723725743;
	bh=164T3A2szaPrSEyDZToq7LQvywW4ML1mM1dmHlVJ744=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FF/rQBsZBW0FmHeCNuGP1AsMFVVENs6aIjXDHDRRxK7YXgoVaVghV/xAScqgbNN9r
	 6hMKLchNkpYHRj918bkPBHsFtOcHSk0B/VdLr18wn+5wNjNERr7e3RkkD/W6y8068k
	 KRFUyPAvn/WvuyApYq8UbJXycJlqx4B8YIuQzfNJcCBIHsbFPVaXUrE6ZTilRpvEgl
	 PFhJEqa6sFDzYa8aSJ2Z5AYW3unePX4X/cFOZ3n0SU57yN+lep0SUGH6QGQV0vyrDk
	 885zwuOZau722EBa79/MM12g4IO2OSut93bwX/GAhxRqJVv+lW3e9GkAWPhdYHW0MF
	 mwS0rGmgV59WA==
Date: Thu, 15 Aug 2024 14:42:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Greg Ungerer <gregungerer@westnet.com.au>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/16] romfs: Convert romfs_read_folio() to use a folio
Message-ID: <20240815-geldentwertung-riechen-0d25a2121756@brauner>
References: <20240530202110.2653630-1-willy@infradead.org>
 <20240530202110.2653630-13-willy@infradead.org>
 <597dd1bb-43ee-4531-8869-c46b38df56bd@westnet.com.au>
 <ZrmBvo6c1N7YnJ6y@casper.infradead.org>
 <bafe6129-209b-4172-996e-5d79389fc496@westnet.com.au>
 <Zr0GTnPHfeA0P8nb@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zr0GTnPHfeA0P8nb@casper.infradead.org>

On Wed, Aug 14, 2024 at 08:32:30PM GMT, Matthew Wilcox wrote:
> On Mon, Aug 12, 2024 at 02:36:57PM +1000, Greg Ungerer wrote:
> > Yep, that fixes it.
> 
> Christian, can you apply this fix, please?
> 
> diff --git a/fs/romfs/super.c b/fs/romfs/super.c
> index 68758b6fed94..0addcc849ff2 100644
> --- a/fs/romfs/super.c
> +++ b/fs/romfs/super.c
> @@ -126,7 +126,7 @@ static int romfs_read_folio(struct file *file, struct folio *folio)
>  		}
>  	}
>  
> -	buf = folio_zero_tail(folio, fillsize, buf);
> +	buf = folio_zero_tail(folio, fillsize, buf + fillsize);
>  	kunmap_local(buf);
>  	folio_end_read(folio, ret == 0);
>  	return ret;

Yep, please see #vfs.fixes. The whole series is already upstream.

