Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD79F270969
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 02:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgISAUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 20:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISAUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 20:20:35 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A301C0613CE;
        Fri, 18 Sep 2020 17:20:35 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJQcD-001MaQ-Lp; Sat, 19 Sep 2020 00:20:33 +0000
Date:   Sat, 19 Sep 2020 01:20:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     mateusznosek0@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/open.c: micro-optimization by avoiding branch on
 common path
Message-ID: <20200919002033.GD3421308@ZenIV.linux.org.uk>
References: <20200919001021.21690-1-mateusznosek0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919001021.21690-1-mateusznosek0@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 19, 2020 at 02:10:21AM +0200, mateusznosek0@gmail.com wrote:
> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> If file is a directory it is surely not regular. Therefore, if 'S_ISREG'
> check returns false one can be sure that vfs_truncate must returns with
> error. Introduced patch refactors code to avoid one branch in 'likely'
> control flow path. Moreover, it marks the proper check with 'unlikely'
> macro to improve both branch prediction and readability. Changes were
> tested with gcc 8.3.0 on x86 architecture and it is confirmed that
> slightly better assembly is generated.

Does it measurably show in any profiles?

> Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
> ---
>  fs/open.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 9af548fb841b..69658ea27530 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -74,10 +74,12 @@ long vfs_truncate(const struct path *path, loff_t length)
>  	inode = path->dentry->d_inode;
>  
>  	/* For directories it's -EISDIR, for other non-regulars - -EINVAL */
> -	if (S_ISDIR(inode->i_mode))
> -		return -EISDIR;
> -	if (!S_ISREG(inode->i_mode))
> -		return -EINVAL;
> +	if (unlikely(!S_ISREG(inode->i_mode))) {
> +		if (S_ISDIR(inode->i_mode))
> +			return -EISDIR;
> +		else
> +			return -EINVAL;
> +	}

If anything, turn the second if into return S_ISDIR(...) ? -EISDIR : -EINVAL;
