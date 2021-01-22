Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBB3300B7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 19:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbhAVSiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 13:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbhAVScY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:32:24 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9CBC06178B
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 10:31:44 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id n127so1621371ooa.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 10:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Ab9R3Beg3K2SiC0qANgEYUJGr8eAMXRzKvwtlr3avY=;
        b=nasFTn+Wbf6+mLFLGP8W5Ujy6BYP5L2cegwclttCFnekEXAOkDDrvQu9YItuVGUqYZ
         KHew29S8kFItmdEKeX795fWRGhMVHexN8B+hmtTwKNd1mopSb58bSd3I9ZqxjBoNXSm/
         xYfxCLQpYYbd6kAnIKn9JBg4Pa3xpH/h5cjEW25nlNW62cfvCFaxWtz2X7fUkiKVL30c
         3aj3OmGZk1i/CBH0WT4fQlOsj13gCXgLRNy3s8yrXgm5XwcXd0PPn7ji/TlF8hfVpCYB
         k4bSiEC6DoNK0a0PtWTOCv5AgjGzFRHvM2E17zUau5K2Wem2O1Dw7Et+vzouOWJesWvT
         /OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Ab9R3Beg3K2SiC0qANgEYUJGr8eAMXRzKvwtlr3avY=;
        b=fevVRe2IE3zkp5tHFRJQv8dMNI76QPn2GckboAWxZTedMuqrozyIZHblBa1sMcaiHU
         qEHHxO9/hrdfH1BSL67HgHTbUEZUmC8KYmkiIKjuqVoO9V3cC/yQ1sLXrGYRHWmZ1FTA
         FsloHdj3KIiTyXNBKch8xmE41PQtli+H1XKHV9geoSFdpGURo5sBxo7WC4LFPd6jLteh
         O9WbyNW1H2L6xpBD6ML3dhys+3LIlRXf09sCTrJmcWVtRyzBw6s8tRIrJC2c/uUCQd9I
         BIIl/2GBYxIe9Bq3m86bSbc35o71CuAn0PtXIUbI/uMhFKjsgaHbKLIz4aMJSomH7TlU
         xSrg==
X-Gm-Message-State: AOAM530huwaeGyLjRUCFYyl42qyKMAYV0KHPMufQPk4R3nSJpc/nYKdn
        8mOfYhuAIeCi4tPagyHgr/Z7mg==
X-Google-Smtp-Source: ABdhPJz0jtCdpEjEMrPjsrQ4MNKqxVFzLEirJ6qP9Bb8ZCzO4bpHVBR4tHp1tIKbz9Klj8hQkCd1XA==
X-Received: by 2002:a4a:6c45:: with SMTP id u5mr4749495oof.61.1611340303740;
        Fri, 22 Jan 2021 10:31:43 -0800 (PST)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id x9sm1825985ota.23.2021.01.22.10.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 10:31:43 -0800 (PST)
Date:   Fri, 22 Jan 2021 12:31:41 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on
 security.capability
Message-ID: <20210122183141.GB81247@sequoia>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
 <20210119162204.2081137-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119162204.2081137-2-mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-01-19 17:22:03, Miklos Szeredi wrote:
> Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
> vfs_setxattr()") the translation of nscap->rootid did not take stacked
> filesystems (overlayfs and ecryptfs) into account.
> 
> That patch fixed the overlay case, but made the ecryptfs case worse.

Thanks for sending a fix!

I know that you don't have an eCryptfs setup to test with but I'm at a
loss about how to test this from the userns/fscaps side of things. Do
you have a sequence of unshare/setcap/getcap commands that I can run on
a file inside of an eCryptfs mount to verify that the bug exists after
7c03e2cda4a5 and then again to verify that this patch fixes the bug?

Tyler

> 
> Restore old the behavior for ecryptfs that existed before the overlayfs
> fix.  This does not fix ecryptfs's handling of complex user namespace
> setups, but it does make sure existing setups don't regress.
> 
> Reported-by: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Tyler Hicks <code@tyhicks.com>
> Fixes: 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into vfs_setxattr()")
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/ecryptfs/inode.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index e23752d9a79f..58d0f7187997 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -1016,15 +1016,19 @@ ecryptfs_setxattr(struct dentry *dentry, struct inode *inode,
>  {
>  	int rc;
>  	struct dentry *lower_dentry;
> +	struct inode *lower_inode;
>  
>  	lower_dentry = ecryptfs_dentry_to_lower(dentry);
> -	if (!(d_inode(lower_dentry)->i_opflags & IOP_XATTR)) {
> +	lower_inode = d_inode(lower_dentry);
> +	if (!(lower_inode->i_opflags & IOP_XATTR)) {
>  		rc = -EOPNOTSUPP;
>  		goto out;
>  	}
> -	rc = vfs_setxattr(lower_dentry, name, value, size, flags);
> +	inode_lock(lower_inode);
> +	rc = __vfs_setxattr_locked(lower_dentry, name, value, size, flags, NULL);
> +	inode_unlock(lower_inode);
>  	if (!rc && inode)
> -		fsstack_copy_attr_all(inode, d_inode(lower_dentry));
> +		fsstack_copy_attr_all(inode, lower_inode);
>  out:
>  	return rc;
>  }
> -- 
> 2.26.2
> 
