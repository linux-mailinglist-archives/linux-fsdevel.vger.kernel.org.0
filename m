Return-Path: <linux-fsdevel+bounces-58110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52233B2971C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 04:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FA317A29A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 02:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2701E257824;
	Mon, 18 Aug 2025 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="irwfAP3q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAC1F582A;
	Mon, 18 Aug 2025 02:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755484887; cv=none; b=eOAvyEmeLKUn0Sx4cWz3Hd1l0bVjhVLlq6nSYynpvWEKyzF8da8MkBVXb9xubFf6fbJQRNGyucw0VoDpTc28R87q4V3K9tjs+sMFJsRkYX4p4UzPO0qxUCnNAyI7YHs3/GJKLvZR8BEqjEoyAzhxH6iYhB49NqcRJx0SMZPKG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755484887; c=relaxed/simple;
	bh=XwyAzBzkyYUsxtoUqwoehmkxeFNQI6xkaYZl2/saPrY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mw+yKJ52+fkY8AvIFDy2B5nBiJgNsp1LkKCvHrWeQhBAx4rmOQbOF/Gxp1RtKzfLe6894csznultOJu8sBAeRFFieyF09jYy5psn7kRAkzscoEHCcbBpWhpLHJJYzM73mUVyB2Hi+8cm96xHfubOZU4jUfHt1fNXFtxeXRuO43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=irwfAP3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF60C4CEEB;
	Mon, 18 Aug 2025 02:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755484886;
	bh=XwyAzBzkyYUsxtoUqwoehmkxeFNQI6xkaYZl2/saPrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=irwfAP3qz5AAci8Aq0upT9TgWRluvcVPAPaXRn0dO424y2LSvfTdlD7Ny590XBTCt
	 OVX0DbG4jariBuhxW4GWKWzNCfI8CnP+6HkbLWGJTSfTj2Ox91qSgIAfuMxi2ODrWi
	 rwGqhFGQq7TZAS3jYsx1x5Ku4obXi8PzrMBNik84=
Date: Sun, 17 Aug 2025 19:41:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew
 Wilcox <willy@infradead.org>, Namjae Jeon <linkinjeon@kernel.org>, Sungjong
 Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, Chi
 Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH 1/3] mpage: terminate read-ahead on read error
Message-Id: <20250817194125.921dd351332677e516cc3b53@linux-foundation.org>
In-Reply-To: <20250812072225.181798-1-chizhiling@163.com>
References: <20250812072225.181798-1-chizhiling@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 15:22:23 +0800 Chi Zhiling <chizhiling@163.com> wrote:

> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> For exFAT filesystems with 4MB read_ahead_size, removing the storage device
> during read operations can delay EIO error reporting by several minutes.
> This occurs because the read-ahead implementation in mpage doesn't handle
> errors.
> 
> Another reason for the delay is that the filesystem requires metadata to
> issue file read request. When the storage device is removed, the metadata
> buffers are invalidated, causing mpage to repeatedly attempt to fetch
> metadata during each get_block call.
> 
> The original purpose of this patch is terminate read ahead when we fail
> to get metadata, to make the patch more generic, implement it by checking
> folio status, instead of checking the return of get_block().
> 
> ...
>
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -369,6 +369,9 @@ void mpage_readahead(struct readahead_control *rac, get_block_t get_block)
>  		args.folio = folio;
>  		args.nr_pages = readahead_count(rac);
>  		args.bio = do_mpage_readpage(&args);
> +		if (!folio_test_locked(folio) &&
> +		    !folio_test_uptodate(folio))
> +			break;
>  	}
>  	if (args.bio)
>  		mpage_bio_submit_read(args.bio);

So...  this is what the fs does when the device is unplugged? 
Synchronously return an unlocked !uptodate folio?  Or is this specific
to FAT?

I think a comment here telling readers why we're doing this would be
helpful.  It isn't obvious that we're dealing with e removed device!

Also, boy this is old code.  Basically akpm code from pre-git times. 
It was quite innovative back then, but everybody who understood it has
since moved on,  got senile or probably died.  Oh well.

Also, that if statement didn't need a newline ;)



