Return-Path: <linux-fsdevel+bounces-33994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6989C14D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 04:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9714F1C21A5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 03:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0458019DF64;
	Fri,  8 Nov 2024 03:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kATa4A91"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD388F54;
	Fri,  8 Nov 2024 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731037611; cv=none; b=deMW+meZSURZkEop9rKVIGwejAi1DCG+M2RGaQ+7yfwIrnAnW7BD+elkO5WI2vQVshzkfhCXToEgcuCwF/R4kxLyLFQFfumiWnt2iXbF+2jWmFxbJBFGB796SBItMefQHnUwSSrQGxMNrhmNEQiYXIXY2wJgcbXEHbzqBBML+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731037611; c=relaxed/simple;
	bh=hQ1tNZ9NSB3X7PHVvGSf5uuryDBEbpwgPwLn6a4+CsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEGKOiP77otvNQTVpRbOB3Mm+OqHWOYkD29kYSMiXwP+sK0mqZLD9LQ4zBQnzXK4kUHZuadcCrrSOKs41MOnnxuiGAQOKl6lFYSQNXjzIjSqgOgE5qnPmdfSAQUIAkn/h7174F2gH62v40oVyns6063VASxpuNnBgOVR3nBkqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kATa4A91; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xLD1+IPnnDR18qsUyzu48ieOa/lzgJDmVUJY9mnwPm4=; b=kATa4A91a99uU3AmVjShv8rnEr
	1aTUThrFRa/iUZuglf0T6yDzjuUxz95J2w36icuAw0GULxblR3e2ALKNscTZ/nwzArWbwYXDN9OJB
	H7wCMlr9F4YRoU0zf/uBx3oLYS2AWJWCS+GjcWz5+fUu3f/6rleYwwVrO3gkW+YGp2oJ/gVATWU2c
	2Yje4crEyYk6gfszagRR7YWn1WUaM70ndoSpnCDLj4LiPZADtOnS9q9HAG4hBLo2GlJB22lJktwDl
	QGhA06sw1ruak/Z62b0GzM5RqMRlew+GrYLza6SXYo6ZUwwGnNZRkeFRENWreEJv4JcGXHWE/+DDT
	DZDctj9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t9FxO-0000000CUPP-1BbQ;
	Fri, 08 Nov 2024 03:46:46 +0000
Date: Fri, 8 Nov 2024 03:46:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Saru2003 <sarvesh20123@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed null-ptr-deref Read in drop_buffers
Message-ID: <20241108034646.GY1350452@ZenIV>
References: <20241108023717.8613-1-sarvesh20123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108023717.8613-1-sarvesh20123@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 08, 2024 at 08:07:17AM +0530, Saru2003 wrote:
> Signed-off-by: Saru2003 <sarvesh20123@gmail.com>
> ---
>  fs/buffer.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 1fc9a50def0b..e32420d8b9e3 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2888,14 +2888,23 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
>  	struct buffer_head *head = folio_buffers(folio);
>  	struct buffer_head *bh;
>  
> +	if (!head) {
> +		goto failed;
> +	}

Which caller can hit that?

>  	bh = head;
>  	do {
> +		if (!bh)
> +			goto failed;

Huh?  How the hell can _that_ happen?  "Somehow got called for a folio
without associated buffer_heads" is one thing, but this would require
an obvious memory corruption; a NULL forward pointer in the middle of
a cyclic list.

>  		if (buffer_busy(bh))
>  			goto failed;
>  		bh = bh->b_this_page;
>  	} while (bh != head);
>  
>  	do {
> +		if (!bh)
> +			goto failed;

NAK.  In the best case you are papering over unrelated memory corruption.

Please, explain what's going on.  Random checks for pointers being NULL
are not magical unicorn piss to be sprinkled all over the place...

And "fixed null-pointer-deref" does *not* work as an explanation - not
with otherwise empty commit message.

