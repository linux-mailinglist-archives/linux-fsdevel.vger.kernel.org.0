Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4C21BD8B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 11:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgD2Jrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 05:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgD2Jrs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:47:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E7C20775;
        Wed, 29 Apr 2020 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588153668;
        bh=9IqOx6w1fe2TV4zs9Fg3I7y+tZugWMUZbtzlPDAhSMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSoNmc4Ev+QnguasjvVTtyTRsWiFGZJ7uiC1fwGw/Njo4edcob8SzCDQvfksmJjtk
         8ZdA6nNEgVzqCsP23gKGiFrMtM1+sRGenzp4Sp+OHAjfSmVwcglxfdfL/e8miMTIBJ
         9r3C2tVKL/c/NGxkeBs03Icq6v4YU8+ecS0xr/PY=
Date:   Wed, 29 Apr 2020 11:47:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 4/6] blktrace: fix debugfs use after free
Message-ID: <20200429094746.GA2081185@kroah.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429074627.5955-5-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:46:25AM +0000, Luis Chamberlain wrote:
> --- a/block/blk-debugfs.c
> +++ b/block/blk-debugfs.c
> @@ -13,3 +13,32 @@ void blk_debugfs_register(void)
>  {
>  	blk_debugfs_root = debugfs_create_dir("block", NULL);
>  }
> +
> +static struct dentry *blk_debugfs_dir_register(const char *name)
> +{
> +	return debugfs_create_dir(name, blk_debugfs_root);
> +}

Nit, that function is not needed at all, just spell out the call to
debugfs_create_dir() in the 2 places below you call it.  That will
result in less lines of code overall :)

> -	dir = blk_trace_debugfs_dir(buts, bt);
> +	dir = blk_trace_debugfs_dir(bdev, q);
> +	if (WARN_ON(!dir))
> +		goto err;

With panic-on-warn you just rebooted the box, lovely :(

I said previously, that if you _REALLY_ wanted to warn about this, or do
something different based on the result of a debugfs call, then you can,
but you need to comment the heck out of it as to why you are doing so,
otherwise I'm just going to catch it in my tree-wide sweeps and end up
removing it.

Other than those two nits, this looks _much_ better, thanks for doing
this.

greg k-h
