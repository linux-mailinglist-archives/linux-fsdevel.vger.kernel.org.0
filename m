Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A35FD352
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 04:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKOD2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 22:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbfKOD2C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 22:28:02 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16981206EF;
        Fri, 15 Nov 2019 03:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573788481;
        bh=mzHXkEiondE/oUwYrxCVLRKS7ykKvBhskkP1l9EDy+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9h/JpQMEKVeOVB9MsSE1JGVtB6UhkbYvS0jS4N/TZjRxkg5AbDT5pwPG41RxsLIp
         Nw8NuNCh0t7yMzgb/Z8bZUjDMjSqvhsoS4DrWsg92KE33eiC2/DozDaUp+FI9H2bBB
         YrwzqK10hFcafJTqCDzo96wsvRKZbjJJQJmtPWoQ=
Date:   Fri, 15 Nov 2019 11:27:59 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     rafael@kernel.org, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        oleg@redhat.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        tytso@mit.edu, jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com, chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH 1/3] dcache: add a new enum type for 'dentry_d_lock_class'
Message-ID: <20191115032759.GA795729@kroah.com>
References: <1573788472-87426-1-git-send-email-yukuai3@huawei.com>
 <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573788472-87426-2-git-send-email-yukuai3@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:27:50AM +0800, yu kuai wrote:
> 'dentry_d_lock_class' can be used for spin_lock_nested in case lockdep
> confused about two different dentry take the 'd_lock'.
> 
> However, a single 'DENTRY_D_LOCK_NESTED' may not be enough if more than
> two dentry are involed. So, and in 'DENTRY_D_LOCK_NESTED_2'
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  include/linux/dcache.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 10090f1..8eb84ef 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -129,7 +129,8 @@ struct dentry {
>  enum dentry_d_lock_class
>  {
>  	DENTRY_D_LOCK_NORMAL, /* implicitly used by plain spin_lock() APIs. */
> -	DENTRY_D_LOCK_NESTED
> +	DENTRY_D_LOCK_NESTED,
> +	DENTRY_D_LOCK_NESTED_2

You should document this, as "_2" does not make much sense to anyone
only looking at the code :(

Or rename it better.

thanks,

greg k-h
