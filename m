Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F8439D2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhJYRPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 13:15:30 -0400
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:58056 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234018AbhJYRP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:15:29 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1EFBB100E8940;
        Mon, 25 Oct 2021 17:13:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 531121124F7;
        Mon, 25 Oct 2021 17:13:04 +0000 (UTC)
Message-ID: <adcb168fc78f62583f8d925bcadbbcda9ba7da20.camel@perches.com>
Subject: Re: [PATCH 1/4] fs/ntfs3: In function ntfs_set_acl_ex do not change
 inode->i_mode if called from function ntfs_init_acl
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 25 Oct 2021 10:13:03 -0700
In-Reply-To: <67d0c9ca-2531-8a8a-ea0b-270dc921e271@paragon-software.com>
References: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
         <67d0c9ca-2531-8a8a-ea0b-270dc921e271@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 531121124F7
X-Spam-Status: No, score=0.10
X-Stat-Signature: 364jh3s7h6dtmh9kiaz4585thf8ipgad
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+xHwzyPg1NsBxY0J6qT6BDg9ijgjanve8=
X-HE-Tag: 1635181984-117484
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-10-25 at 19:58 +0300, Konstantin Komarov wrote:
> ntfs_init_acl sets mode. ntfs_init_acl calls ntfs_set_acl_ex.
> ntfs_set_acl_ex must not change this mode.
> Fixes xfstest generic/444
> Fixes: 83e8f5032e2d ("fs/ntfs3: Add attrib operations")

trivia:

> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
[]
> @@ -538,7 +538,7 @@ struct posix_acl *ntfs_get_acl(struct inode *inode, int type)
>  
>  static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>  				    struct inode *inode, struct posix_acl *acl,
> -				    int type)
> +				    int type, int init_acl)

bool init_acl?

> @@ -613,7 +614,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>  int ntfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  		 struct posix_acl *acl, int type)
>  {
> -	return ntfs_set_acl_ex(mnt_userns, inode, acl, type);
> +	return ntfs_set_acl_ex(mnt_userns, inode, acl, type, 0);

false

>  }
>  
>  /*
> @@ -633,7 +634,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  
>  	if (default_acl) {
>  		err = ntfs_set_acl_ex(mnt_userns, inode, default_acl,
> -				      ACL_TYPE_DEFAULT);
> +				      ACL_TYPE_DEFAULT, 1);

true, etc...


