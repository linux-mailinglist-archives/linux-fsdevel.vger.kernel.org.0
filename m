Return-Path: <linux-fsdevel+bounces-7162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6E9822918
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 08:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6AF1C2301D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 07:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4CE1805C;
	Wed,  3 Jan 2024 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rLv1TTAQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC81803D;
	Wed,  3 Jan 2024 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mfBmNNXCDgI/7UWz5uYsVwRwFwVSUpKpeSR1CFuUBeE=; b=rLv1TTAQA156NR6NMWeqQzjKE0
	/sK2JNeruOswotoIFPruqmoTu1yoF11hp6opHbX7KM6wmuuzPeFI3FdSyh4gPZGzxp/hPTIChehhf
	sSktoLdls2jHEUk5oereue4EWhsEzfLq9qcBNwg2tDdV+O8w3kM36gpA2cmoZf+ji3quMIQfigh7q
	dlm0lg+KB7yPYExfeWbUowO+dczFs36xubHRGsPSq9f60x6KnGJakWgA2RHR0PdR1pIvJHLU+ob+O
	k3Wg5la4H7PponKN3BFecDKXx2IhOY8iAfY6nJHw5IH4uJ49/OGCGLBMp3vVSAebQBg3DQnDz1LNJ
	78JxD6yw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rKvwI-00CNoh-RR; Wed, 03 Jan 2024 07:45:22 +0000
Date: Wed, 3 Jan 2024 07:45:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hfs: fix deadlock in hfs_extend_file
Message-ID: <ZZUQkr+oHEEF8njK@casper.infradead.org>
References: <0000000000004efa57060def87be@google.com>
 <tencent_8C1ACE487B4E6C302EE56D8C95C0E8E2EF0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_8C1ACE487B4E6C302EE56D8C95C0E8E2EF0A@qq.com>

On Tue, Jan 02, 2024 at 08:36:51PM +0800, Edward Adam Davis wrote:
> [syz report]
> syz-executor279/5059 is trying to acquire lock:
> ffff888079c100f8 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397
> 
> but task is already holding lock:
> ffff888079c10778 (&HFS_I(tree->inode)->extents_lock){+.+.}-{3:3}, at: hfs_extend_file+0xa2/0xb10 fs/hfs/extent.c:397
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&HFS_I(tree->inode)->extents_lock);
>   lock(&HFS_I(tree->inode)->extents_lock);
> 
>  *** DEADLOCK ***
> [Analysis] 
>  hfs_extend_file()->
>    hfs_ext_read_extent()->
>      __hfs_ext_cache_extent()->
>        __hfs_ext_write_extent()->
>          hfs_bmap_reserve()->
>            hfs_extend_file()->
> 
> When an inode has both the HFS_FLG_EXT_DIRTY and HFS_FLG_EXT_NEW flags, it will
> enter the above loop and trigger a deadlock.
> 
> [Fix]
> In hfs_ext_read_extent(), check if the above two flags exist simultaneously, 
> and exit the subsequent process when the conditions are met.

Why is this the correct fix?  Seems to me that returning -ENOENT here is
going to lead to an error being reported to the user when the user has
done nothing wrong?

> Reported-and-tested-by: syzbot+41a88b825a315aac2254@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/hfs/extent.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
> index 6d1878b99b30..1b02c7b6a10c 100644
> --- a/fs/hfs/extent.c
> +++ b/fs/hfs/extent.c
> @@ -197,6 +197,10 @@ static int hfs_ext_read_extent(struct inode *inode, u16 block)
>  	    block < HFS_I(inode)->cached_start + HFS_I(inode)->cached_blocks)
>  		return 0;
>  
> +	if (HFS_I(inode)->flags & HFS_FLG_EXT_DIRTY && 
> +	    HFS_I(inode)->flags & HFS_FLG_EXT_NEW) 
> +		return -ENOENT;
> +
>  	res = hfs_find_init(HFS_SB(inode->i_sb)->ext_tree, &fd);
>  	if (!res) {
>  		res = __hfs_ext_cache_extent(&fd, inode, block);
> -- 
> 2.43.0
> 
> 

