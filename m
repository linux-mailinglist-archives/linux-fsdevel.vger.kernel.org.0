Return-Path: <linux-fsdevel+bounces-38014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 944479FA9F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 06:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1034C164E9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 05:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DA6154C00;
	Mon, 23 Dec 2024 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hwlFESes"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79D38C;
	Mon, 23 Dec 2024 05:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734930264; cv=none; b=h06NgNGo5n7+d8D8J1pBYnEhtBdArs7rNfNfkHBzhoG8L+jib0ISUkhN+tyPlmgwcuBu/xvdyaGyWWw98SmoGxsgFVNjUlSLTV656u5oZLiOm4Jbg+YjdpbHZNmhqeEhItdBmb1BZJ6satVNJu5+z6GAZQNTMDhpMpS0NYgaxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734930264; c=relaxed/simple;
	bh=mk1qt0GTt3QCI6rBzBo0IXVM5tWPlakEPtlC2KQlDwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frcoBHPQj78m4R8uDqFaUYL/eedgw2QifRR9/6JoV+9feYuPcXU65L+YchCZAzIqCMJaJKbPHGuAT43OswNLwkLRcgm4aKSFY9IWc+LZo8TzMCtUB0a7ljUJ1RU6VlyCKrKAb6LPHjPOvNOUrQWB7QmW6yaf5jpvCp/MUQmdPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hwlFESes; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=in2WpIwimc+UO47UWOoNeFVZHOjfscb27OEnYCbPRwY=; b=hwlFESesMYK1WjqYp8t2YZCvwQ
	QVFF1qSdyoihxQYfmSMtR1QU73dQ7MIAFmi8ZRfSv+PqjHUPMAB3OtHX4rpIm1O9cEu7cAkbfDccN
	+GP1yf+xQgyHdw+k1TsPnn5UPcsiWkF0CxMsq+33VhkyLNkSqYEXnXATsA9DNiIh7r/nyF5m5R/jF
	mL676tBsZIZJZwy7VzNEJ3D16K87hVf2k9y/w2zTxhGPWV/PkSp5x21GhQhUIQWE1T2u/1YmDhnV3
	jdumC1BgrU76l/kZibnj5YN2LH6yHbanCTy4hE3qC/pSqSY7844ZgVD2vt6wH876JDGJ1LhMdNMUW
	bPGonZsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPac6-0000000BCKK-3tgd;
	Mon, 23 Dec 2024 05:04:18 +0000
Date: Mon, 23 Dec 2024 05:04:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] VFS: introduce vfs_mkdir_return()
Message-ID: <20241223050418.GI1977892@ZenIV>
References: <20241220030830.272429-1-neilb@suse.de>
 <20241220030830.272429-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220030830.272429-2-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 20, 2024 at 01:54:19PM +1100, NeilBrown wrote:
> +	error = dir->i_op->mkdir(idmap, dir, dentry, mode);
> +	if (!error) {
> +		fsnotify_mkdir(dir, dentry);
> +		if (unlikely(d_unhashed(dentry))) {
> +			struct dentry *d;
> +			d = lookup_dcache((const struct qstr *)&dentry->d_name,
> +					  dentry->d_parent, 0);
> +			if (IS_ERR(d)) {
> +				error = PTR_ERR(d);
> +			} else if (unlikely(d_is_negative(d))) {


... which will instantly oops if there's no cached dentry with
such name and parent.  lookup_dcache() is pure dcache lookup;
it does *NOT* call ->lookup() on miss - just returns NULL.

