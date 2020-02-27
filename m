Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10224172C62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 00:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgB0Xjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 18:39:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729750AbgB0Xjh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:39:37 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5DC2469B;
        Thu, 27 Feb 2020 23:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582846776;
        bh=fQciLqB49DiuqFxaJ8U7Wyw+hn2oXk1NpstgqjpjGMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T8QyLuNvjo55oRiRkjaifrrjclB0W/W8631zfgLa0tUN364HYs4v9d6R7N1RU81jw
         zv4aZxGWI277yTQPRTnoGj3mxKuoXSslOPb3hm3JEzl0s/Y7Eq5BHLsGd0RxMlHbH8
         TK1tbDiMKzxiLaF5shcp4PyPlh+vw4x7r+wGxS4w=
Date:   Thu, 27 Feb 2020 15:39:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] exec: remove comparision of variable i_size of type
 loff_t against SIZE_MAX
Message-ID: <20200227233935.GA176371@gmail.com>
References: <20200227233133.10383-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227233133.10383-1-scott.branden@broadcom.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 03:31:33PM -0800, Scott Branden wrote:
> Remove comparision of (i_size > SIZE_MAX).
> i_size is of type loff_t and can not be great than SIZE_MAX (~(size_t)0).
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index db17be51b112..16c229752f74 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -919,7 +919,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>  		ret = -EINVAL;
>  		goto out;
>  	}
> -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> +	if (max_size > 0 && i_size > max_size) {
>  		ret = -EFBIG;
>  		goto out;
>  	}

Nope, loff_t is 64-bit while size_t can be 32-bit.  And this check is
intentional, see https://git.kernel.org/torvalds/c/691115c3513ec83e

- Eric
