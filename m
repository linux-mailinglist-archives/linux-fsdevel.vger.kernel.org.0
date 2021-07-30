Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887013DB062
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 02:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhG3AmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 20:42:22 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:42876 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhG3AmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:42:17 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9GbC-005366-IM; Fri, 30 Jul 2021 00:42:02 +0000
Date:   Fri, 30 Jul 2021 00:42:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/11] nfsd: Allow filehandle lookup to cross internal
 mount points.
Message-ID: <YQNK2rgZuqh/XmMt@zeniv-ca.linux.org.uk>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546556.32498.16708762469227881912.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162742546556.32498.16708762469227881912.stgit@noble.brown>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:

> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index baa12ac36ece..22523e1cd478 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -64,7 +64,7 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct path *path_parent,
>  			    .dentry = dget(path_parent->dentry)};
>  	int err = 0;
>  
> -	err = follow_down(&path, 0);
> +	err = follow_down(&path, LOOKUP_AUTOMOUNT);
>  	if (err < 0)
>  		goto out;
>  	if (path.mnt == path_parent->mnt && path.dentry == path_parent->dentry &&
> @@ -73,6 +73,13 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct path *path_parent,
>  		path_put(&path);
>  		goto out;
>  	}
> +	if (mount_is_internal(path.mnt)) {
> +		/* Use the new path, but don't look for a new export */
> +		/* FIXME should I check NOHIDE in this case?? */
> +		path_put(path_parent);
> +		*path_parent = path;
> +		goto out;
> +	}

... IOW, mount_is_internal() is called with no exclusion whatsoever.  What's there
to
	* keep its return value valid?
	* prevent fetching ->mnt_mountpoint, getting preempted away, having
the mount moved *and* what used to be ->mnt_mountpoint evicted from dcache,
now that it's no longer pinned, then mount_is_internal() regaining CPU and
dereferencing ->mnt_mountpoint, which now points to hell knows what?
