Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBE74506DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 15:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhKOObD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 09:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236294AbhKOO2f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636986339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0UHyekY33nyS4opU4pb9mDwiVLtFsBuv+1pBWFv92Xk=;
        b=cIbjIFtn7+78NIesON5ODywM64GFaVXXiiF2IfdHzIFBYQZ1J4H2F4e1v1dVuIAMgpX4i+
        YiALJks+2Xcl5NHCF9av/2mPrZFIhUuh0t8Sk8PumN0iv4jbG5l9i6JqiLVX3g01v0u+39
        XbVJmAce1zFLFJLnhNCXJPqSD9ujmuQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-3Hqwb4-8NaabntUwVc-ARA-1; Mon, 15 Nov 2021 09:25:38 -0500
X-MC-Unique: 3Hqwb4-8NaabntUwVc-ARA-1
Received: by mail-qk1-f197.google.com with SMTP id j6-20020a05620a288600b0045e5d85ca17so11059537qkp.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Nov 2021 06:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0UHyekY33nyS4opU4pb9mDwiVLtFsBuv+1pBWFv92Xk=;
        b=Ka1HeVC1tFMT3XIdLdN9wNt7HNVdncIfmgP5TRLiHqBjmJCwYuu62PxbNTNLq9zg1o
         rWE6R21gocofJwLi/FIAUGWKzL0pQ6bcl2x8JJyFzVlderVdfUK9vs2n2eqzNuhgDeNi
         2tIs6S5kqXHIEgc2gXGNRK3SxbEIXAq6332zJc9SGIAqizk6/PzGLMAkdOUNGurDIwhW
         kAa8wylxIgE7BuaSRITiBOxlnOBmP4Qjxwb3vhNjL//pau/GgOz6H99sDm7kb6tNwiwp
         IY+MX1hT7PxgsX1XxoZaH7Z9ydVKm7MQwz0j0jFSEbkupClXbKfgEe692pCNZBDOZw4i
         kPrA==
X-Gm-Message-State: AOAM533prcE0o6nDMshjUTBsYD631PeL9d/HdbEF9sPzKz/aKDIh/aMq
        5E+VMJDY1UE1PKWpgCcldjiXF2liBmHyNEbCT1tBE2A7kOsEz8WTHC6JGOY13LVHQSdaoSwIHhf
        ffm157e6UYNIosGBxbmBOx59oBA==
X-Received: by 2002:a37:bf81:: with SMTP id p123mr30809506qkf.29.1636986337655;
        Mon, 15 Nov 2021 06:25:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8CaJlCANdNsGwCvw1fxN4Ckg4kZNtXgH3P07Ulq6mAG0oYsKHCU/nEmq3Er9fppz4nqjb1g==
X-Received: by 2002:a37:bf81:: with SMTP id p123mr30809477qkf.29.1636986337425;
        Mon, 15 Nov 2021 06:25:37 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id a15sm1069130qtb.5.2021.11.15.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 06:25:37 -0800 (PST)
Date:   Mon, 15 Nov 2021 09:25:35 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2 2/2] xfs: make sure link path does not go away at access
Message-ID: <YZJt320bZuIct3g9@bfoster>
References: <163694289979.229789.1176392639284347792.stgit@mickey.themaw.net>
 <163694306800.229789.11812765289669370510.stgit@mickey.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163694306800.229789.11812765289669370510.stgit@mickey.themaw.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:24:28AM +0800, Ian Kent wrote:
> When following an inline symlink in rcu-walk mode it's possible to
> succeed in getting the ->get_link() method pointer but the link path
> string be deallocated while it's being used.
> 
> This is becuase of the xfs inode reclaim mechanism. While rcu freeing
> the link path can prevent it from being freed during use the inode
> reclaim could assign a new value to the field at any time outside of
> the path walk and result in an invalid link path pointer being
> returned. Admittedly a very small race window but possible.
> 
> The best way to mitigate this risk is to return -ECHILD to the VFS
> if the inline symlink method, ->get_link(), is called in rcu-walk mode
> so the VFS can switch to ref-walk mode or redo the walk if the inode
> has become invalid.
> 
> If it's discovered that staying in rcu-walk mode gives a worth while
> performance improvement (unlikely) then the link path could be freed
> under rcu once potential side effects of the xfs inode reclaim
> sub-system have been analysed and dealt with if needed.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_iops.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a607d6aca5c4..0a96183c5381 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -520,6 +520,9 @@ xfs_vn_get_link_inline(
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	char			*link;
>  
> +	if (!dentry)
> +		return ERR_PTR(-ECHILD);
> +
>  	ASSERT(ip->i_df.if_format == XFS_DINODE_FMT_LOCAL);
>  
>  	/*
> 
> 

