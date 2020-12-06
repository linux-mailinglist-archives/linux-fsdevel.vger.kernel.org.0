Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F5D2D0239
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 10:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgLFJR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 04:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLFJR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 04:17:59 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01383C0613D1
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 01:17:18 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id C4465C009; Sun,  6 Dec 2020 10:16:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1607246193; bh=zugEn14CrYV0HZH2U2Zour1PG68Rh0TUCnI+4h4RKWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGFFE46Kvb23tMS2cazLmKn46t7AyzpRQZi0FOKTQH88faL/MzkJlHSi9pQ2wdWe9
         3x98a4S12AZC8AfDdgPbOkFAwgY2MfLtlkfxdCkJe+oslyZ0H6Z5aWVJFwTW41R1O1
         fCfktrbiGZjnKejXC/Ne15i41FmIqtV5AN1Y4M2MiIiE0HenOs4lPL0FD/lGvgF6XS
         U/Q2cr39Iscx0OeSAd3Pnlc6OgaI8Z6XPTKrTMXpTLXmZdOK7gvlqZBmokFMRsjHZM
         ZeMG1ReVpTwCC86bVf89aWAFPGF3Ih39xKBY1hsadaeR+qekH1I8MNEmbGG29zjdY1
         kk5ReJoSaJOPA==
Date:   Sun, 6 Dec 2020 10:16:18 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] 9p: create writeback fid on shared mmap
Message-ID: <20201206091618.GA22629@nautica>
References: <20201205130904.518104-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201205130904.518104-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Chengguang Xu wrote on Sat, Dec 05, 2020:
> If vma is shared and the file was opened for writing,
> we should also create writeback fid because vma may be
> mprotected writable even if now readonly.

Hm, I guess it makes sense.

> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
> Caveat: Only compile tested.

Will test later and add it to next then, might be a bit.


>  fs/9p/vfs_file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index b177fd3b1eb3..791839c2dd5c 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -516,8 +516,7 @@ v9fs_mmap_file_mmap(struct file *filp, struct vm_area_struct *vma)
>  	v9inode = V9FS_I(inode);
>  	mutex_lock(&v9inode->v_mutex);
>  	if (!v9inode->writeback_fid &&
> -	    (vma->vm_flags & VM_SHARED) &&
> -	    (vma->vm_flags & VM_WRITE)) {
> +	    mapping_writably_mapped(filp->f_mapping)) {
>  		/*
>  		 * clone a fid and add it to writeback_fid
>  		 * we do it during mmap instead of
-- 
Dominique
