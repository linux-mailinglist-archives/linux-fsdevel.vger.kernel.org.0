Return-Path: <linux-fsdevel+bounces-14829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F018802FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 18:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E7F1C20A71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4C613AF9;
	Tue, 19 Mar 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iKD05oKr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC011CA1;
	Tue, 19 Mar 2024 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867810; cv=none; b=jVQ/INPmnJ4rUyONuvCn0QmecxwGxhAhgaKySVqz/spCF6Y8MGoyqaf3hgpJ7ZvBYON8TVB+mTlS/ZBWn1xewWPCNx1HHsfzPT3DZW5d27DFMqQ2rwXoqSCLfdgpJhDeYnK41fdIcVCqcwMchoSNU092PEZjMMJaqwdPBwQS8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867810; c=relaxed/simple;
	bh=Dj64sUjmnK2ntA02PnNgXDlY9wINyCmnIUACURIdRHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1vQLoJz9ngGmf4BHeIjIsJ4HekyNcRbu0rS6yePGzJ7fbnEcumijL1y94PEHkwu/tZQBCL8cOcifKh1JerzdvMY4hljWNoV6fDWEs7OZWLY8AHk8/6Gc7XQ2HzIf0uVWDWtqKwOD1zn+dEfXNNEt8d3t+jXEKVZAcVfmXLPQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iKD05oKr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=83Hn0ltGPuna9/xgLZVnQCsUyIUNXkFeoVYNAc+/w/U=; b=iKD05oKraRmmzaLdJxyUybVFD1
	+zhl/yayK65R929KlYHyWAfTO/ok0UZh7WF5TaSFnpJNGBLGAVevpUvfi/j8UUZ77eOpAankEh7G8
	XCS/D/rhYYzz77iVBL2ZgBE7NksfFEY4oTfJT0vFeChBJIKVQWqt+1KJ+CicQivy6UdHukRvBPNRS
	T4uJFsJqAs/MNQDCbv1adaEOEyvj9lb0BlD0amDWuSD4yPoTWFFYAu50/3ASway83RSoIcyckI6tL
	DFUvK7JxbgpVp51ZnmZvrBIECS2if/FSBMK7TKLTp/K7zFZbhKiTXTiqqLySt2yi2rn7CB5t4EoAn
	uKy+uFaA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmcrw-00000002MhU-3EXp;
	Tue, 19 Mar 2024 17:03:21 +0000
Date: Tue, 19 Mar 2024 17:03:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: remove holder ops
Message-ID: <ZfnFWJbgKCtJa8my@casper.infradead.org>
References: <20240314165814.tne3leyfmb4sqk2t@quack3>
 <20240315-freibad-annehmbar-ca68c375af91@brauner>
 <20240315142802.i3ja63b4b7l3akeb@quack3>
 <20240319-klippe-kurzweilig-ae6a31a9ff31@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319-klippe-kurzweilig-ae6a31a9ff31@brauner>

On Tue, Mar 19, 2024 at 05:24:44PM +0100, Christian Brauner wrote:
> @@ -631,8 +631,8 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>  		whole->bd_holder = NULL;
>  	mutex_unlock(&bdev_lock);
>  
> -	if (hops && hops->put_holder)
> -		hops->put_holder(holder);
> +	if (mounted)
> +		fs_bdev_super_put(holder);

I think you haven't gone quite far enough here.  Call super_put()
directly and make bd_end_claim() take a super_block pointer.


