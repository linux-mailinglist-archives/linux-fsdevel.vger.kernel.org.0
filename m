Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D3D3A7E3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFOMd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 08:33:29 -0400
Received: from verein.lst.de ([213.95.11.211]:48725 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhFOMd0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:33:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B778867373; Tue, 15 Jun 2021 14:31:18 +0200 (CEST)
Date:   Tue, 15 Jun 2021 14:31:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>, axboe@kernel.dk,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pstore/blk: Use the normal block device I/O path
Message-ID: <20210615123118.GA14239@lst.de>
References: <20210614200421.2702002-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210614200421.2702002-1-keescook@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -	if (!dev || !dev->total_size || !dev->read || !dev->write)
> +	if (!dev || !dev->total_size || !dev->read || !dev->write) {
> +		if (!dev)
> +			pr_err("NULL device info\n");
> +		else {
> +			if (!dev->total_size)
> +				pr_err("zero sized device\n");
> +			if (!dev->read)
> +				pr_err("no read handler for device\n");
> +			if (!dev->write)
> +				pr_err("no write handler for device\n");
> +		}
>  		return -EINVAL;
> +	}

This is completely unrelated and should be a separate patch.  And it
also looks rather strange, I'd at very least split the dev check out
and return early without the weird compound statement, but would probably
handle each one separate.  All assuming that we really need all these
debug printks.

>  /*
>   * This takes its configuration only from the module parameters now.
>   */
>  static int __register_pstore_blk(void)

This needs a __init annotation now.

>
>
>  {
> +	struct pstore_device_info dev = {
> +		.read = psblk_generic_blk_read,
> +		.write = psblk_generic_blk_write,
> +	};

On-stack method tables are a little odd..

> +	if (!__is_defined(MODULE)) {

This looks a little weird.  Can we define a rapper for this in config.h
that is a little more self-explanatory, e.g. in_module()?

> +	if (!psblk_file->f_mapping)
> +		pr_err("missing f_mapping\n");

Can't ever be true.

> +	else if (!psblk_file->f_mapping->host)
> +		pr_err("missing host\n");

Can't ever be true either.

> +	else if (!I_BDEV(psblk_file->f_mapping->host))
> +		pr_err("missing I_BDEV\n");
> +	else if (!I_BDEV(psblk_file->f_mapping->host)->bd_inode)
> +		pr_err("missing bd_inode\n");

І_BDEV just does pointer arithmetics, so it can't ever return NULL.
And there are no block device inodes without bd_inode either.  And
all of this is per definition present for open S_ISBLK inodes.
