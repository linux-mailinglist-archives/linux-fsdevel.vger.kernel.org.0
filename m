Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2A026BCF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 08:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIPG0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 02:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgIPGZ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:25:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164ABC06174A;
        Tue, 15 Sep 2020 23:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5DkGrdwtKboVv6oJ+L5ofbnVJYprbMvRcR1X/5Ks8Fk=; b=NwUKULRasoHoDh5Re+0oSBPoOy
        cVoFabxviFAt51K/mnHZ97XXOZDkQYezTtUKQ0Ug21qeRpaVtxtxlqn+eIJOMnGZoOeLK4h1mmPe1
        Yk4ICgexAbxXc56SRoycT/PX2Gm6yHY7lBVC6Sh9BEdV5Rv760gEXf7Kkkwn8Qioq0xRniiS/DEbc
        jSn+Ax4XAc07B3QMykBleghV6+CZPmccpDA1gI8N6d1WKCCTIZY37pK1boZ/RYKw/qD1xJX+xLGyC
        jEjasxT5xSri6kUplc0O7LATOQY7MvfSqKgERkQd1Re11IPDbem7jREFTAgnH5WTBSUIgqUO4x98u
        p114gKbQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIQt7-0007XL-BE; Wed, 16 Sep 2020 06:25:53 +0000
Date:   Wed, 16 Sep 2020 07:25:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfs: block chmod of symlinks
Message-ID: <20200916062553.GB27867@infradead.org>
References: <20200916002157.GO3265@brightrain.aerifal.cx>
 <20200916002253.GP3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916002253.GP3265@brightrain.aerifal.cx>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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

Our usualy place for this would be setattr_prepare.  Also the comment
style is off, and I don't think we should talk about buggy file systems
here, but a policy to not allow the chmod.  I also suspect the right
error value is EINVAL - EOPNOTSUPP isn't really used in normal posix
file system interfaces.
