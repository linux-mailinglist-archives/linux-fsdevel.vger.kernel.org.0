Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93ED43B9BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 20:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbhJZSnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 14:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbhJZSnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:43:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949EDC061745;
        Tue, 26 Oct 2021 11:40:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq11so740436lfb.10;
        Tue, 26 Oct 2021 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2B7Nuk56PYtXZAcRZA0VYMCuyr74J58C1m8umyHIOaU=;
        b=ZNeeUJBEHOBELTBzEakgjoftW/Sv91UOnDWRS1R8U0bonwBGmn3exCfmJzAPs16VwJ
         H3XmoA2iNbwuXpgzss4J2YzVzXg+ZSH04wZ5Q6T2U6pPpMD+2ALMelSEccXDqIzKc1ee
         JE0nnu2YDRcI6b7Y3v6X/MFy6GUKl2VWwfMhKOQDkM5xh7BUTmbkah+W5aqZNrEKARtA
         d2sX045a1z/WaBbkGNPIrmNooX4xVtoDxkpHue+L+AiDs7bWqJYr1FnK1dB8o+wMXpld
         r0Aw4uZHLOw2+Aqq/K9FYEVpMrpz6HNhV4/BAvCevLpTN7g1GLShmt0uv0Rfv4gWtjj+
         r4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2B7Nuk56PYtXZAcRZA0VYMCuyr74J58C1m8umyHIOaU=;
        b=f+fQzWW8HykWfaDy9prChtlOG7jKli6951nPBBSBwHNIugH6Ufocl6qWmLFVSrp7eH
         vFZwueaIVjhsd61I7wTXyhvP5beqWsraOVseMufyWIZpDAPYH5zHt34kuFQKC9aJjJYJ
         8eJiev5FMgZHZRU30G13jgdtGNsjXVTuGz1QPGf9R3al0MeSwOvCmwCPH8xquR4bIym3
         EtbGhDQc4lOU5813EtHML5yi2tDWvCHGliAXXA28iHhiBlNNKl4SlhtjFuXGzm12kFZv
         JXAEk3Kc+V9dtJC7c5ytWbgQLMZYwPXdMFSTvt7d9nuEERO32ARTtPsAI+6/BnqRw0A2
         cf4w==
X-Gm-Message-State: AOAM531GaMzNssJn2g+Gzm5V045srr0Sfu+XsMAAqsP0gCFGMT2q7r0Y
        qWxyEj9xAjwxYvQ0Mno5DJg=
X-Google-Smtp-Source: ABdhPJwwtAabAKXq8k0TcRyNcUuYLOLsZi/bFhBN5H6Trb/Lr2poDcp2o599QFZ8mkBI4XbNhEJ9tg==
X-Received: by 2002:a05:6512:2386:: with SMTP id c6mr15352362lfv.55.1635273637533;
        Tue, 26 Oct 2021 11:40:37 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id s18sm2012983lfg.27.2021.10.26.11.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:40:37 -0700 (PDT)
Date:   Tue, 26 Oct 2021 21:40:35 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/4] fs/ntfs3: In function ntfs_set_acl_ex do not change
 inode->i_mode if called from function ntfs_init_acl
Message-ID: <20211026184035.jkopoeaqukeofmye@kari-VirtualBox>
References: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
 <67d0c9ca-2531-8a8a-ea0b-270dc921e271@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d0c9ca-2531-8a8a-ea0b-270dc921e271@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Maybe little too long subject line.

On Mon, Oct 25, 2021 at 07:58:26PM +0300, Konstantin Komarov wrote:
> ntfs_init_acl sets mode. ntfs_init_acl calls ntfs_set_acl_ex.
> ntfs_set_acl_ex must not change this mode.
> Fixes xfstest generic/444
> Fixes: 83e8f5032e2d ("fs/ntfs3: Add attrib operations")

Where does this commit id come from? Seems wrong to me.

> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/xattr.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index 2143099cffdf..97b5f8417d85 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -538,7 +538,7 @@ struct posix_acl *ntfs_get_acl(struct inode *inode, int type)
>  
>  static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>  				    struct inode *inode, struct posix_acl *acl,
> -				    int type)
> +				    int type, int init_acl)

Like Joe say. Bool here and use true/false

>  {
>  	const char *name;
>  	size_t size, name_len;
> @@ -551,8 +551,9 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>  
>  	switch (type) {
>  	case ACL_TYPE_ACCESS:
> -		if (acl) {
> -			umode_t mode = inode->i_mode;
> +		/* Do not change i_mode if we are in init_acl */
> +		if (acl && !init_acl) {
> +			umode_t mode;
>  
>  			err = posix_acl_update_mode(mnt_userns, inode, &mode,
>  						    &acl);
> @@ -613,7 +614,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
>  int ntfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  		 struct posix_acl *acl, int type)
>  {
> -	return ntfs_set_acl_ex(mnt_userns, inode, acl, type);
> +	return ntfs_set_acl_ex(mnt_userns, inode, acl, type, 0);
>  }
>  
>  /*
> @@ -633,7 +634,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  
>  	if (default_acl) {
>  		err = ntfs_set_acl_ex(mnt_userns, inode, default_acl,
> -				      ACL_TYPE_DEFAULT);
> +				      ACL_TYPE_DEFAULT, 1);
>  		posix_acl_release(default_acl);
>  	} else {
>  		inode->i_default_acl = NULL;
> @@ -644,7 +645,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
>  	else {
>  		if (!err)
>  			err = ntfs_set_acl_ex(mnt_userns, inode, acl,
> -					      ACL_TYPE_ACCESS);
> +					      ACL_TYPE_ACCESS, 1);
>  		posix_acl_release(acl);
>  	}
>  
> -- 
> 2.33.0
> 
