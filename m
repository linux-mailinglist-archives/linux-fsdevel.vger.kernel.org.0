Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94258151CC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 15:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgBDO76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 09:59:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53688 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727319AbgBDO76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580828397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G4OL5c8ap2AVZmyYHDqCmQgp9/fB+rx7zQbFyZWDmWE=;
        b=TNUXRPtSRF9DTrEbxw7cK+PG1h9YIwM9bSuRb4eAdCSQ+WYioM4Nkh96V7mYX4R+0OMO/R
        My+Vu1jI1mMNqUPPrtwND3E8Cg1zRpDw3zTy7opayJhbelnQ/FgoYuOua2uo/714/O5IWS
        VEmS2ApG6gxa7vJjZ+4NOCAWfLG+3ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-hJoMHsq4PaSwH3BD7fuFgg-1; Tue, 04 Feb 2020 09:59:52 -0500
X-MC-Unique: hJoMHsq4PaSwH3BD7fuFgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5B7418B6392;
        Tue,  4 Feb 2020 14:59:51 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A0A85C1D4;
        Tue,  4 Feb 2020 14:59:51 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 1C66A2202E9; Tue,  4 Feb 2020 09:59:51 -0500 (EST)
Date:   Tue, 4 Feb 2020 09:59:51 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
Message-ID: <20200204145951.GC11631@redhat.com>
References: <20200131115004.17410-1-mszeredi@redhat.com>
 <20200131115004.17410-5-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131115004.17410-5-mszeredi@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 12:50:04PM +0100, Miklos Szeredi wrote:
> No reason to prevent upper layer being a remote filesystem.  Do the
> revalidation in that case, just as we already do for lower layers.
> 
> This lets virtiofs be used as upper layer, which appears to be a real use
> case.

Hi Miklos,

I have couple of very basic questions.

- So with this change, we will allow NFS to be upper layer also?

- What does revalidation on lower/upper mean? Does that mean that
  lower/upper can now change underneath overlayfs and overlayfs will
  cope with it. If we still expect underlying layers not to change, then
  what's the point of calling ->revalidate().

Thanks
Vivek

> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/namei.c | 3 +--
>  fs/overlayfs/super.c | 8 ++++++--
>  fs/overlayfs/util.c  | 2 ++
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 76e61cc27822..0db23baf98e7 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -845,8 +845,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
>  		if (err)
>  			goto out;
>  
> -		if (upperdentry && (upperdentry->d_flags & DCACHE_OP_REAL ||
> -				    unlikely(ovl_dentry_remote(upperdentry)))) {
> +		if (upperdentry && upperdentry->d_flags & DCACHE_OP_REAL) {
>  			dput(upperdentry);
>  			err = -EREMOTE;
>  			goto out;
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 26d4153240a8..ed3a11db9039 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -135,9 +135,14 @@ static int ovl_dentry_revalidate_common(struct dentry *dentry,
>  					unsigned int flags, bool weak)
>  {
>  	struct ovl_entry *oe = dentry->d_fsdata;
> +	struct dentry *upper;
>  	unsigned int i;
>  	int ret = 1;
>  
> +	upper = ovl_dentry_upper(dentry);
> +	if (upper)
> +		ret = ovl_revalidate_real(upper, flags, weak);
> +
>  	for (i = 0; ret > 0 && i < oe->numlower; i++) {
>  		ret = ovl_revalidate_real(oe->lowerstack[i].dentry, flags,
>  					  weak);
> @@ -747,8 +752,7 @@ static int ovl_mount_dir(const char *name, struct path *path)
>  		ovl_unescape(tmp);
>  		err = ovl_mount_dir_noesc(tmp, path);
>  
> -		if (!err && (ovl_dentry_remote(path->dentry) ||
> -			     path->dentry->d_flags & DCACHE_OP_REAL)) {
> +		if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
>  			pr_err("filesystem on '%s' not supported as upperdir\n",
>  			       tmp);
>  			path_put_init(path);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 3ad8fb291f7d..c793722739e1 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -96,6 +96,8 @@ void ovl_dentry_update_reval(struct dentry *dentry, struct dentry *upperdentry,
>  	struct ovl_entry *oe = OVL_E(dentry);
>  	unsigned int i, flags = 0;
>  
> +	if (upperdentry)
> +		flags |= upperdentry->d_flags;
>  	for (i = 0; i < oe->numlower; i++)
>  		flags |= oe->lowerstack[i].dentry->d_flags;
>  
> -- 
> 2.21.1
> 

