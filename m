Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F96244D9EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 17:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhKKQLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 11:11:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234149AbhKKQLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 11:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636646934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lEiAuhtYpYmWwGYiEVTRT5DiiEXqyobrsCTGPeXR28s=;
        b=crR75qQNg3bbtR1BuJp8DmUWUbPPiZFIYKyNNCqgaaBGjhMB7mrAE3IjS35l3KuWI1Ek6+
        FTRzqZ/BNunuSm10qSafTg7+0wxzvaxiXTMMh7hMfX+YFmW69P/y/beHcktnAuGByExyb6
        Tr+daH0k0ZngYIh2mAhy02hKC9s9308=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-T09IPorQNn2NTIFT_0sHOQ-1; Thu, 11 Nov 2021 11:08:53 -0500
X-MC-Unique: T09IPorQNn2NTIFT_0sHOQ-1
Received: by mail-qv1-f71.google.com with SMTP id r13-20020a0562140c8d00b003bde7a2b8e2so5876601qvr.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 08:08:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lEiAuhtYpYmWwGYiEVTRT5DiiEXqyobrsCTGPeXR28s=;
        b=oZ9CFIfTX2DJEpDzeWNuDFhX9G3omCgjzV7Ss+d1MXBpv4yZM8BDn5bFCWMxK9gVVA
         CiUS2i6AaV+GjMYNLI9aQ5zbhYBZX+gqTjSPujQUbScYz7AoEKgN2lYEFuvopfwE3C57
         1sDEydzqhiinkwxXimq262H0EtIaw9cPI/Jue9NVuPPc0TbVtWD7jlhvawOog68U1CsE
         DDw5YgieMqEXgFtAOZbaYwExsqdl9GHXzv0MW6qAAxhY4pCKeAiLTE6aGBjtIB7cjZHM
         Rf4A28IpSvPyq72gM06EdUKp+o1PhCk8p4Xa31qyeDb0/FC9qcx/FGM48M+HNlv+urLA
         Uykg==
X-Gm-Message-State: AOAM5317bGbEF0awpGfOvSPTxzAdf383/mXcJS1ahXF7I+iTTsQAHUkC
        krRmgq7t/iMVugUiFW9wSFn2sARUDOojLjExnD7EiN7AodvW8j4WS7Vd5zx1KAKC7kcF9slXlcH
        iH4qeq1i7G1jVMoVCDq33+DFfSA==
X-Received: by 2002:ac8:58d1:: with SMTP id u17mr8918072qta.137.1636646933185;
        Thu, 11 Nov 2021 08:08:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwM45i/F5PcLsATLBWXHVAozkIpTgDT+XwicghpZg7RZGKQs5HPcUkNK0yi3P5LGjEhDw49eg==
X-Received: by 2002:ac8:58d1:: with SMTP id u17mr8918028qta.137.1636646932926;
        Thu, 11 Nov 2021 08:08:52 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id t11sm1493205qkm.96.2021.11.11.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 08:08:52 -0800 (PST)
Date:   Thu, 11 Nov 2021 11:08:49 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
Message-ID: <YY1AEaHRLe+P4IYr@bfoster>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
 <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 11, 2021 at 11:39:30AM +0800, Ian Kent wrote:
> When following a trailing symlink in rcu-walk mode it's possible to
> succeed in getting the ->get_link() method pointer but the link path
> string be deallocated while it's being used.
> 
> Utilize the rcu mechanism to mitigate this risk.
> 
> Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/xfs/kmem.h      |    4 ++++
>  fs/xfs/xfs_inode.c |    4 ++--
>  fs/xfs/xfs_iops.c  |   10 ++++++++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
...
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a607d6aca5c4..2977e19da7b7 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -524,11 +524,17 @@ xfs_vn_get_link_inline(
>  
>  	/*
>  	 * The VFS crashes on a NULL pointer, so return -EFSCORRUPTED if
> -	 * if_data is junk.
> +	 * if_data is junk. Also, if the path walk is in rcu-walk mode
> +	 * and the inode link path has gone away due inode re-use we have
> +	 * no choice but to tell the VFS to redo the lookup.
>  	 */
> -	link = ip->i_df.if_u1.if_data;
> +	link = rcu_dereference(ip->i_df.if_u1.if_data);
> +	if (!dentry && !link)
> +		return ERR_PTR(-ECHILD);
> +

One thing that concerns me slightly about this approach is that inode
reuse does not necessarily guarantee that if_data is NULL. It seems
technically just as possible (even if exceedingly unlikely) for link to
point at newly allocated memory since the previous sequence count
validation check. The inode could be reused as another inline symlink
for example, though it's not clear to me if that is really a problem for
the vfs (assuming a restart would just land on the new link anyways?).
But the inode could also be reallocated as something like a shortform
directory, which means passing directory header data or whatever that it
stores in if_data back to pick_link(), which is then further processed
as a string.

With that, I wonder why we wouldn't just return -ECHILD here like we do
for the non-inline case to address the immediate problem, and then
perhaps separately consider if we can rework bits of the reuse/reclaim
code to allow rcu lookup of inline symlinks under certain conditions.

FWIW, I'm also a little curious why we don't set i_link for inline
symlinks. I don't think that addresses this validation problem, but
perhaps might allow rcu lookups in the inline symlink common case where
things don't change during the lookup (and maybe even eliminate the need
for this custom inline callback)..?

Brian

>  	if (XFS_IS_CORRUPT(ip->i_mount, !link))
>  		return ERR_PTR(-EFSCORRUPTED);
> +
>  	return link;
>  }
>  
> 
> 

