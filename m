Return-Path: <linux-fsdevel+bounces-25575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E6794D7F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 22:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A024928365B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 20:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97D315534B;
	Fri,  9 Aug 2024 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BA+GMg++"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074B33D1
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234709; cv=none; b=Ys+0JokGfLSE3bin+5vTsDSahRZivCt+gDEriXyxj9BMA7uh/NlK9xgOwNtoqo96YmLeQ0bFlzCVNDRSamJq9yGmS79IYaabkzQF0VtTqAVW2LxaeD2hDXMIsM4i1I1VVHyhDI4AHf5fU/aZ4FFQ6iYyJid7sAwR7KAkvgf12H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234709; c=relaxed/simple;
	bh=1RUV0iN0dunNd6a7gH1geFCjceKfObJvWjJwTzGXc84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8uQKAKw7NXKNLfLtOY9OeQalhaGoL9afQy9UVBHukOYGPG5Z/bQwvtuu7vPC9zBgmcyixRsOl1t60TB5lzrCb/zD92BxeTlFA1QfA1axUOGBdQbyVoFUGFJiRkJ5e1jxoG3IOxMPy6qnf335DHNxOOoK0QyB/pzQraTNsnulw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BA+GMg++; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3CbQOtTZPRwvicRjCHXoYaALt35CBNfDmEDN51s8t8w=; b=BA+GMg++LhguaBb4oF7Ft6RJCp
	rR9LpoXCtp21M86Ien8va8jRgI0U2tpGlild4twl+y4h7JOMorSbwqBxcjXkG61K8oFbnwYDpCYOb
	Gu0P8iBi6l4KMZ4J10bBoaVydeEPvBLc92JSpQoZzKE9QGgX+JKaDD08YIWUuFgtpf9SCcrg5I/Gt
	bXY5MubyZNK9ffkC95hOxlkQtX3N+SzkjK++9qV2XmPy5UMf7+aPtlCqwnoZ7bRDstVImChMOa3Bj
	77kFYJfLDFnqNjSdcS3+vGa1/fiFI6XddY6oGGxINT5s7QTSgl0C4kFOt3pGwpqPXcKA8luMKUG9B
	cus0W4sQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scW48-0000000B7Hd-1BXH;
	Fri, 09 Aug 2024 20:18:24 +0000
Date: Fri, 9 Aug 2024 21:18:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [DRAFT RFC]: file: reclaim 24 bytes from f_owner
Message-ID: <ZrZ5kLowzf5ZVnhz@casper.infradead.org>
References: <20240809-koriander-biobauer-6237cbc106f3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-koriander-biobauer-6237cbc106f3@brauner>

On Fri, Aug 09, 2024 at 10:10:40PM +0200, Christian Brauner wrote:
> +++ b/drivers/net/tun.c
> @@ -3467,8 +3467,13 @@ static int tun_chr_fasync(int fd, struct file *file, int on)
>  static int tun_chr_open(struct inode *inode, struct file * file)
>  {
>  	struct net *net = current->nsproxy->net_ns;
> +	struct fown_struct *f_owner = __free(kfree) = NULL;

What does this syntax mean?

> +++ b/drivers/tty/tty_io.c
> @@ -2119,12 +2119,17 @@ static struct tty_struct *tty_open_by_driver(dev_t device,
>  static int tty_open(struct inode *inode, struct file *filp)
>  {
>  	struct tty_struct *tty;
> +	struct fown_struct *f_owner __free(kfree) = NULL;

This makes more sense.  Was the tun one just a typo?


