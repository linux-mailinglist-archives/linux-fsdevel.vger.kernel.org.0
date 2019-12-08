Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6475411639F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 20:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLHToU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 14:44:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39088 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfLHToU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 14:44:20 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ie2TZ-0007kp-U8; Sun, 08 Dec 2019 19:44:18 +0000
Date:   Sun, 8 Dec 2019 19:44:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] posix_acl: fix memleak when set posix acl.
Message-ID: <20191208194417.GV4203@ZenIV.linux.org.uk>
References: <20191126133809.2082-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126133809.2082-1-zhangxiaoxu5@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 26, 2019 at 09:38:09PM +0800, Zhang Xiaoxu wrote:
> When set posix acl, it maybe call posix_acl_update_mode in some
> filesystem, eg. ext4. It may set acl to NULL, so, we can't free
> the acl which allocated in posix_acl_xattr_set.
> 
> Use an temp value to store the acl address for posix_acl_release.

Huh?

>  {
> -	struct posix_acl *acl = NULL;
> +	struct posix_acl *acl = NULL, *p = NULL;
>  	int ret;
>  
>  	if (value) {
> @@ -890,8 +890,15 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
>  		if (IS_ERR(acl))
>  			return PTR_ERR(acl);
>  	}
> +
> +	/*
> +	 * when call set_posix_acl, posix_acl_update_mode may set acl
> +	 * to NULL,use temporary variables p for posix_acl_release.
> +	 */
> +	p = acl;
>  	ret = set_posix_acl(inode, handler->flags, acl);
> -	posix_acl_release(acl);
> +
> +	posix_acl_release(p);

	How could set_posix_acl() possibly set a local variable of
posix_acl_xattr_set() to NULL or to anything else, for that matter?
That makes no sense.  C passes arguments by value; formal parameters
behave as local variables in the called function, initialized by
the values passed by caller.  Modifying those inside the called
function is perfectly valid, same as for any local variable.  And
it does _not_ modify anything in the caller's scope.

	Do yourself a favour, grab a textbook on C (or the actual
standard, if you are up for that - e.g. at
http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf) and
read it through.  That'll save you a lot of frustration trying to
guess what some construct is doing.
