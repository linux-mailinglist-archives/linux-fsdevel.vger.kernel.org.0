Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5602B1B36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 13:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgKMMfv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 07:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMMfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:35:51 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C139C0613D1;
        Fri, 13 Nov 2020 04:35:51 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdYIm-0055Ez-9d; Fri, 13 Nov 2020 12:35:40 +0000
Date:   Fri, 13 Nov 2020 12:35:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        akinobu.mita@gmail.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@huawei.com
Subject: Re: [PATCH v2] libfs: fix error cast of negative value in
 simple_attr_write()
Message-ID: <20201113123540.GH3576660@ZenIV.linux.org.uk>
References: <1605261369-551-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605261369-551-1-git-send-email-yangyicong@hisilicon.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 05:56:09PM +0800, Yicong Yang wrote:
> The attr->set() receive a value of u64, but simple_strtoll() is used
> for doing the conversion. It will lead to the error cast if user inputs
> a negative value.
> 
> Use kstrtoull() instead of simple_strtoll() to convert a string got
> from the user to an unsigned value. The former will return '-EINVAL' if
> it gets a negetive value, but the latter can't handle the situation
> correctly.
> 
> Fixes: f7b88631a897 ("fs/libfs.c: fix simple_attr_write() on 32bit machines")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Change since v1:
> - address the compile warning for non-64 bit platform
> 
>  fs/libfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index fc34361..3a0d99c 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -977,7 +977,9 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
>  		goto out;
>  
>  	attr->set_buf[size] = '\0';
> -	val = simple_strtoll(attr->set_buf, NULL, 0);
> +	ret = kstrtoull(attr->set_buf, 0, (unsigned long long *)&val);
> +	if (ret)
> +		goto out;
>  	ret = attr->set(attr->data, val);
>  	if (ret == 0)
>  		ret = len; /* on success, claim we got the whole input */

Make val unsigned long long instead.
