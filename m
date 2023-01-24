Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED37678E7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjAXCoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjAXCoC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:44:02 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B1C1BF9;
        Mon, 23 Jan 2023 18:43:51 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 8F807C01F; Tue, 24 Jan 2023 03:44:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1674528248; bh=HTS1ZbZA1TUADjld+raUJqmd4pxeyrVKtWHVtO56iNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0RhzEZND/5LfsABCtWDR9xa5yhiK9tt1DKJQXleksWBvc6ywXFdBCTRbr2HrsH+b
         HKCY4DkKcoDz0FRh8mpcnsl1sHo+1jT5l/0vnc9KhF2Je0uL+dbmKBHaIdJCKryWrt
         1xL5ac8aLhmrMde6i/bPOZM1MA4Y0bWLfUP+guU5Bue5ZAUMIxUgf0jruFy3MNMEII
         eINNCfhSJzMdJ2U+fb2gVBaO7sMRGeQn9ueTAiuHHbyKO8SyuS01YBEZw2ofpeoid3
         KvjrduDcqbFSM3D27Y/rOvznSepcx3/RDjglWsD87pRtNhaTgG59x/Q4oJdl2FWyIx
         2KoOY3qjtJWnw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id C1AD8C009;
        Tue, 24 Jan 2023 03:44:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1674528247; bh=HTS1ZbZA1TUADjld+raUJqmd4pxeyrVKtWHVtO56iNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYX5LCOYgSENiFQRS/BnkaxgHeqU1ZlFISHHmmZavmJCJwIFNCTUy1l66kJaiBkhU
         SqcaPEdijGw98Dd9dmAUykYj/BeFZrz+O61dQbYZtMmoDLqFjH0uyzWyl6to4BlaCU
         pcp6ug6Wv8npzAANS/p/P4ZKmmlBUPzK+6MsYAQI8Zk1o6CJPGw7gpblEquCgr1Nsu
         n6lo8t1LDhJWNoi/YAMSvWVtUtkObpj4slGWFGXfdV+ZevBV0d87cxP6Yf3Ku5He0N
         0vus9nPMBAKZCdMPTsQPB31BodKxX7e1k3lF8TBQZx2z4WrIVvlg3XiLqrXyzsH2E/
         7Mh2T2UWwNiFg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id ed1f598f;
        Tue, 24 Jan 2023 02:43:43 +0000 (UTC)
Date:   Tue, 24 Jan 2023 11:43:28 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <evanhensbergen@icloud.com>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v2 03/10] Consolidate file operations and add readahead
 and writeback
Message-ID: <Y89F0KGdEBcwu39Y@codewreck.org>
References: <20221217183142.1425132-1-evanhensbergen@icloud.com>
 <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <20221218232217.1713283-4-evanhensbergen@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221218232217.1713283-4-evanhensbergen@icloud.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sun, Dec 18, 2022 at 11:22:13PM +0000:
> We had 3 different sets of file operations across 2 different protocol
> variants differentiated by cache which really only changed 3
> functions.  But the real problem is that certain file modes, mount
> options, and other factors weren't being considered when we
> decided whether or not to use caches.
> 
> This consolidates all the operations and switches
> to conditionals within a common set to decide whether or not
> to do different aspects of caching.
> 
> Signed-off-by: Eric Van Hensbergen <evanhensbergen@icloud.com>
> ---
>  fs/9p/v9fs.c           |  30 ++++------
>  fs/9p/v9fs.h           |   2 +
>  fs/9p/v9fs_vfs.h       |   4 --
>  fs/9p/vfs_dir.c        |   9 +++
>  fs/9p/vfs_file.c       | 123 +++++++----------------------------------
>  fs/9p/vfs_inode.c      |  31 ++++-------
>  fs/9p/vfs_inode_dotl.c |  19 ++++++-
>  7 files changed, 71 insertions(+), 147 deletions(-)
> 
> diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> index 1675a196c2ba..536769cdf7c8 100644
> --- a/fs/9p/vfs_dir.c
> +++ b/fs/9p/vfs_dir.c
> @@ -214,6 +214,15 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
>  	p9_debug(P9_DEBUG_VFS, "inode: %p filp: %p fid: %d\n",
>  		 inode, filp, fid ? fid->fid : -1);
>  	if (fid) {
> +		if ((fid->qid.type == P9_QTFILE) && (filp->f_mode & FMODE_WRITE)) {

dir release, but the fid is of type regular file ?

Either way this doesn't look directly related to cache level
consodilations, probably better in another commit.

> +			int retval = file_write_and_wait_range(filp, 0, -1);
> +
> +			if (retval != 0) {
> +				p9_debug(P9_DEBUG_ERROR,
> +					"trying to flush filp %p failed with error code %d\n",
> +					filp, retval);
> +			}
> +		}
>  		spin_lock(&inode->i_lock);
>  		hlist_del(&fid->ilist);
>  		spin_unlock(&inode->i_lock);
-- 
Dominique
