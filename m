Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D7437AD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 18:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhJVQZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 12:25:01 -0400
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:57290 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231651AbhJVQZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 12:25:01 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B5FA439F24;
        Fri, 22 Oct 2021 16:22:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id D40FF1D42F8;
        Fri, 22 Oct 2021 16:22:41 +0000 (UTC)
Message-ID: <d5e8af244174917e6dd1b29057b0f46f823a62e4.camel@perches.com>
Subject: Re: [PATCH 3/4] fs/ntfs3: Optimize locking in ntfs_save_wsl_perm
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 22 Oct 2021 09:22:40 -0700
In-Reply-To: <f8c4d63d-1296-ede2-50b9-242f52b856ed@paragon-software.com>
References: <09b42386-3e6d-df23-12c2-23c2718f766b@paragon-software.com>
         <f8c4d63d-1296-ede2-50b9-242f52b856ed@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: D40FF1D42F8
X-Spam-Status: No, score=-1.68
X-Stat-Signature: xjbgjke43susyq6wmjqmzzo73gupk3tm
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19pUH21oGkxLq/QnEwTrJOsBhBf+KCPFCY=
X-HE-Tag: 1634919761-37637
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-10-22 at 18:55 +0300, Konstantin Komarov wrote:
> Right now in ntfs_save_wsl_perm we lock/unlock 4 times.
> This commit fixes this situation.
> We add "locked" argument to ntfs_set_ea.
[]
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
[]
> @@ -259,7 +259,7 @@ static int ntfs_get_ea(struct inode *inode, const char *name, size_t name_len,
>  
>  static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>  				size_t name_len, const void *value,
> -				size_t val_size, int flags)
> +				size_t val_size, int flags, bool locked)
[]
> @@ -595,7 +597,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>  		flags = 0;
>  	}
>  
> -	err = ntfs_set_ea(inode, name, name_len, value, size, flags);
> +	err = ntfs_set_ea(inode, name, name_len, value, size, flags, 0);

generally is nicer to use true/false for bool rather than true/0

>  	err = ntfs_set_ea(inode, "$LXGID", sizeof("$LXGID") - 1, &value,
> -			  sizeof(value), 0);
> +			  sizeof(value), 0, true);


