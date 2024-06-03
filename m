Return-Path: <linux-fsdevel+bounces-20833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798C68D8482
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA1628A976
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5F212DDBC;
	Mon,  3 Jun 2024 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmZYpeJs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBFD1E892
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423161; cv=none; b=hLDtsUx2Bphs4rFr7dsAk80Dp1sZTVW7CUKS3zUin/rw94oZiDBJ1wz/vMYV2lHg5WOpFZVQ6iV5egwz7bQzjNw4AO78/7jrTJM8ShuINLMEwWeflUjA3yzvcQlyJGxf71OAHAWUmY5G9hyaHSQTjFH5bdlXNe/MC0kzwyjbOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423161; c=relaxed/simple;
	bh=8RPUnF7gk0b/CJBPN2pXQmZfxDLMLse/39kGeRh1jMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXzxwEyZ4lzMCQ8os3NmAvreV5AEOMTs0NdqkqVyaOnkfsE+7o40l/EoGB7NOcnkwqRpSYrhaMW9VN98MEk1FWPIkayFfhasu8cRAVQ3ijwqzTpz4bvOOQHTkjcsjJoddY+CDzEcVZtpb9/1CzGmcEGy3tgSsTsiN6aHOYJNaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmZYpeJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2387FC4AF0C;
	Mon,  3 Jun 2024 13:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717423161;
	bh=8RPUnF7gk0b/CJBPN2pXQmZfxDLMLse/39kGeRh1jMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZmZYpeJs61M1kIXvYdUOtHFQncIxV8FhMiBqdQNGBF6X+/aQZ+KweuzSFJm2WBQ9o
	 KRPfeAGmq2l1aokxSP0mcQ/B8O3VYDqwA5YLlxhYTBI7tnDwQ+EnZMHVaBFEfN7/3W
	 KZRNSWH1f72oBCOZFZ85zO4jBR7ftcPbp4oTKV8rdQFCyE512VDUT8sZTcsfmI6mKc
	 3aXIW6EUD6WWZc1JDDprt50JSEddsiSyvQejw2062IqhdjHHtcT/HkU+UJWGB3Ak6K
	 4wxH/Ies74xucOzjc58YCoitkNgbWo9f3j9TbIWYaXbZfdYleCiU2ivdi6YDs4bw+t
	 HhhGX+QdFw1nA==
Date: Mon, 3 Jun 2024 15:59:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] move close_range(2) into fs/file.c, fold
 __close_range() into it
Message-ID: <20240603-hinziehen-gejohle-42163319944c@brauner>
References: <20240602204238.GD1629371@ZenIV>
 <20240602215803.GE1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240602215803.GE1629371@ZenIV>

On Sun, Jun 02, 2024 at 10:58:03PM +0100, Al Viro wrote:
> On Sun, Jun 02, 2024 at 09:42:38PM +0100, Al Viro wrote:
> > 	We never had callers for __close_range() except for close_range(2)
> > itself.  Nothing of that sort has appeared in four years and if any users
> > do show up, we can always separate those suckers again.
> 
> BTW, looking through close_range()...  We have
> 
> static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
> {
> 	unsigned int count;
> 
> 	count = count_open_files(fdt);
> 	if (max_fds < NR_OPEN_DEFAULT)
> 		max_fds = NR_OPEN_DEFAULT;
> 	return ALIGN(min(count, max_fds), BITS_PER_LONG);
> }
> 
> which decides how large a table would be needed for descriptors below max_fds
> that are opened in fdt.  And we start with finding the last opened descriptor
> in fdt (well, rounded up to BITS_PER_LONG, if you look at count_open_files()).
> 
> Why do we bother to look at _anything_ past the max_fds?  Does anybody have
> objections to the following?

No, it's fine but folding count_open_files() into sane_fdtable_size() is
a bit less readable imho. In any case, could you please slap an
explanatory comment on top of 

while (words > min_words && !fdt->open_fds[words - 1])
	words--;

That code is unreadable enough as it is.

> 
> diff --git a/fs/file.c b/fs/file.c
> index f9fcebc7c838..4976ede108e0 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -276,20 +276,6 @@ static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
>  	return test_bit(fd, fdt->open_fds);
>  }
>  
> -static unsigned int count_open_files(struct fdtable *fdt)
> -{
> -	unsigned int size = fdt->max_fds;
> -	unsigned int i;
> -
> -	/* Find the last open fd */
> -	for (i = size / BITS_PER_LONG; i > 0; ) {
> -		if (fdt->open_fds[--i])
> -			break;
> -	}
> -	i = (i + 1) * BITS_PER_LONG;
> -	return i;
> -}
> -
>  /*
>   * Note that a sane fdtable size always has to be a multiple of
>   * BITS_PER_LONG, since we have bitmaps that are sized by this.
> @@ -305,12 +291,18 @@ static unsigned int count_open_files(struct fdtable *fdt)
>   */
>  static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
>  {
> -	unsigned int count;
> +	const unsigned int min_words = BITS_TO_LONGS(NR_OPEN_DEFAULT);  // 1
> +	unsigned int words;
> +
> +	if (max_fds <= NR_OPEN_DEFAULT)
> +		return NR_OPEN_DEFAULT;
> +
> +	words = BITS_TO_LONGS(min(max_fds, fdt->max_fds)); // >= min_words
> +
> +	while (words > min_words && !fdt->open_fds[words - 1])
> +		words--;
>  
> -	count = count_open_files(fdt);
> -	if (max_fds < NR_OPEN_DEFAULT)
> -		max_fds = NR_OPEN_DEFAULT;
> -	return ALIGN(min(count, max_fds), BITS_PER_LONG);
> +	return words * BITS_PER_LONG;
>  }
>  
>  /*

