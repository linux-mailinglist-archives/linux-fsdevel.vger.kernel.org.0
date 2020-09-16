Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB7326BC7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 08:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgIPGRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 02:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgIPGRl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:17:41 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81814208E4;
        Wed, 16 Sep 2020 06:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600237061;
        bh=kAkRcZ8M/UW3Dl9iN5zhPGSOU71JhfTvi7/ksXTCTy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JO7JrnUNreEqXiYcukH57/YA+z9hYDvRoMLGMo9P3ylTlShw+roBNWbKTjsuxvbHW
         neSfnus98EEC8jps5YQZ1G7AXCq3TxSc1leIbisRx2oepi/79N7Zrqbp4ep3dczm3v
         9cYxo6iWGbBfhmjTciE2qBi04mdXOXogWF8FYDyo=
Date:   Wed, 16 Sep 2020 08:18:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfs: block chmod of symlinks
Message-ID: <20200916061815.GB142621@kroah.com>
References: <20200916002157.GO3265@brightrain.aerifal.cx>
 <20200916002253.GP3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916002253.GP3265@brightrain.aerifal.cx>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 08:22:54PM -0400, Rich Felker wrote:
> It was discovered while implementing userspace emulation of fchmodat
> AT_SYMLINK_NOFOLLOW (using O_PATH and procfs magic symlinks; otherwise
> it's not possible to target symlinks with chmod operations) that some
> filesystems erroneously allow access mode of symlinks to be changed,
> but return failure with EOPNOTSUPP (see glibc issue #14578 and commit
> a492b1e5ef). This inconsistency is non-conforming and wrong, and the
> consensus seems to be that it was unintentional to allow link modes to
> be changed in the first place.
> 
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  fs/open.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 9af548fb841b..cdb7964aaa6e 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -570,6 +570,12 @@ int chmod_common(const struct path *path, umode_t mode)
>  	struct iattr newattrs;
>  	int error;
>  
> +	/* Block chmod from getting to fs layer. Ideally the fs would either
> +	 * allow it or fail with EOPNOTSUPP, but some are buggy and return
> +	 * an error but change the mode, which is non-conforming and wrong. */
> +	if (S_ISLNK(inode->i_mode))
> +		return -EOPNOTSUPP;

I still fail to understand why these "buggy" filesystems can not be
fixed.  Why are you papering over a filesystem-specific-bug with this
core kernel change that we will forever have to keep?

thanks,

greg k-h
