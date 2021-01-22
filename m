Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43473009A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbhAVRYI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbhAVRSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:18:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2F8C061788
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 09:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e9tNa+DNAK/w7dHpnhE9CZv0XhYPTiZ1o5OgFm/xBsA=; b=HGrf2jV89DXp1qFlvf/Z0Zxq1W
        ywMouOAB70GaSgY+sA4xH55a6JvJmXF7I1ynCpLdj4kEhi69eEXkSq31X9Ap+eamSVGjTxE2QdwCv
        12hNDxJfSkz0mqtyfts/2VdvLRupP2l/bmIHKeRgUNy7p/iThlHlNTAudehFMwFMgRJH+ll6CzzAG
        VG2vpsnzXwC+AXh0xgmu3Hc/TPpIxl9L3qaRiF4wva225YhzJJqXdaPsKjxCvM8M1jKxZziqBlktN
        xNg4dTWlPTfpyu2mdr0PFIyOzsylQNh3kpA9sh4Vnoo5a8+05GDkPmL1k+w3hcZj6dXlqt2WWfGBo
        6X0Z+T6g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l303O-0010KD-C7; Fri, 22 Jan 2021 17:17:01 +0000
Date:   Fri, 22 Jan 2021 17:16:58 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Message-ID: <20210122171658.GA237653@infradead.org>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
 <20210122151536.7982-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122151536.7982-2-s.hauer@pengutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 04:15:29PM +0100, Sascha Hauer wrote:
> This patch introduces the Q_PATH flag to the quotactl cmd argument.
> When given, the path given in the special argument to quotactl will
> be the mount path where the filesystem is mounted, instead of a path
> to the block device.
> This is necessary for filesystems which do not have a block device as
> backing store. Particularly this is done for upcoming UBIFS support.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I hate overloading quotactl even more.  Why not add a new quotactl_path
syscall instead?

> +static struct super_block *quotactl_sb(dev_t dev, int cmd)
>  {
>  	struct super_block *sb;
>  	bool excl = false, thawed = false;
>  
>  	if (quotactl_cmd_onoff(cmd)) {
>  		excl = true;
> @@ -901,12 +887,50 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
>  		goto retry;
>  	}
>  	return sb;
> +}
> +
> +/*
> + * look up a superblock on which quota ops will be performed
> + * - use the name of a block device to find the superblock thereon
> + */
> +static struct super_block *quotactl_block(const char __user *special, int cmd)
> +{
> +#ifdef CONFIG_BLOCK
> +	struct filename *tmp = getname(special);
> +	int error;
> +	dev_t dev;
>  
> +	if (IS_ERR(tmp))
> +		return ERR_CAST(tmp);
> +	error = lookup_bdev(tmp->name, &dev);
> +	putname(tmp);
> +	if (error)
> +		return ERR_PTR(error);
> +
> +	return quotactl_sb(dev, cmd);
>  #else
>  	return ERR_PTR(-ENODEV);
>  #endif

Normal kernel style would be to keep the ifdef entirely outside the
function.

> +static struct super_block *quotactl_path(const char __user *special, int cmd)
> +{
> +	struct super_block *sb;
> +	struct path path;
> +	int error;
> +
> +	error = user_path_at(AT_FDCWD, special, LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT,
> +			   &path);

This adds an overly long line.

> +	if (error)
> +		return ERR_PTR(error);
> +
> +	sb = quotactl_sb(path.mnt->mnt_sb->s_dev, cmd);

I think quotactl_sb should take the superblock directly.  This will
need a little refactoring of user_get_super, but will lead to much
better logic.
