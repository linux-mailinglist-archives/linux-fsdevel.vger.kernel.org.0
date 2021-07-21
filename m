Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4572A3D0DBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 13:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbhGUKw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 06:52:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40812 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbhGUKMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:12:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 961F6224C0;
        Wed, 21 Jul 2021 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626864750;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbXyjAK9/zbaL9b+l3GlYTIFHULSzENd3xXwuJBkAjM=;
        b=DPyZnUuH89vHNp5STNHwDjy/7c7ZMcrIoQJCiUVJOJ9Xq6xCLnLgSuzSbAnofqaAH9CTdV
        C57BOX6qKPFrF/oevuSxqhOM0rS0NZFxqSDiQpJz+OkuTDwSFA5qxweGWmXfq2ayNL2uLg
        4XGa5CK2oa6jf/1nFlgWb136h/fuSsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626864750;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbXyjAK9/zbaL9b+l3GlYTIFHULSzENd3xXwuJBkAjM=;
        b=0rbzu4o+jXA43DYMwGjzHYuREPuOG2v0h99Xd/PfmtQTh7w2Yc3q9Z3xp/ycRous8PQf8X
        Pn0vVgZtP1UHrZBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6F7A0A3B81;
        Wed, 21 Jul 2021 10:52:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 601A6DA704; Wed, 21 Jul 2021 12:49:49 +0200 (CEST)
Date:   Wed, 21 Jul 2021 12:49:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v3 8/9] 9p: migrate from sync_inode to
 filemap_fdatawrite_wbc
Message-ID: <20210721104949.GB19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net
References: <cover.1626288241.git.josef@toxicpanda.com>
 <696f89db6b30858af65749cafb72a896552cfc44.1626288241.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <696f89db6b30858af65749cafb72a896552cfc44.1626288241.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I don't see any 9p people in CC, adding them. The cover letter is
https://lore.kernel.org/linux-btrfs/cover.1626288241.git.josef@toxicpanda.com/

On Wed, Jul 14, 2021 at 02:47:24PM -0400, Josef Bacik wrote:
> We're going to remove sync_inode, so migrate to filemap_fdatawrite_wbc
> instead.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/9p/vfs_file.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 59c32c9b799f..6b64e8391f30 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -625,12 +625,7 @@ static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
>  	p9_debug(P9_DEBUG_VFS, "9p VMA close, %p, flushing", vma);
>  
>  	inode = file_inode(vma->vm_file);
> -
> -	if (!mapping_can_writeback(inode->i_mapping))
> -		wbc.nr_to_write = 0;
> -
> -	might_sleep();
> -	sync_inode(inode, &wbc);
> +	filemap_fdatawrite_wbc(inode->i_mapping, &wbc);
>  }
>  
>  
> -- 
> 2.26.3
