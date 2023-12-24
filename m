Return-Path: <linux-fsdevel+bounces-6871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D1C81DAD3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 15:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC26B1C212D7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A1B5692;
	Sun, 24 Dec 2023 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r2kQEqbC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05F5382;
	Sun, 24 Dec 2023 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bIfF3OvMXykDn8JSOeWrn+4ddSK06uddfz19eFh3Qqg=; b=r2kQEqbCcpXE6OvyY5LcgOcm6f
	qPku8BsPNmwV/5wJ2HfvMBMqWMsZJrLtL/+cc7cq8V39yTvGFf2zvB8Fd3fWxiQGLdjDwU7X9uQxi
	n/6C5RyD8isewCQOa40fUpgeWJhjJxPsXcENM9pZblZwNRrg/9r+Jutvse/I3OWHvoVfWL21Lm/Gk
	5DNQ94q+ia0Si5nNfdcCDDCtaqAaqIqDUChin6KHJzLr+SHBcabXgciCmkoa7FPrQp9QvbTZzimZX
	jGdvoyVV2DSoCsKYvkin0rnAY5+24NgqYWlgMhL/vPFAaUVBb3E2rMkRuoJ9fDdGi2hT7ALw7jaa6
	hmEqJm6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rHPEl-00Dpme-9v; Sun, 24 Dec 2023 14:13:51 +0000
Date: Sun, 24 Dec 2023 14:13:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [PATCH] ext4: fix WARNING in lock_two_nondirectories
Message-ID: <ZYg8n2x6wtxNN4JK@casper.infradead.org>
References: <000000000000e17185060c8caaad@google.com>
 <tencent_DABB2333139E8D1BCF4B5D1B2725FABA9108@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DABB2333139E8D1BCF4B5D1B2725FABA9108@qq.com>

On Sun, Dec 24, 2023 at 07:53:00PM +0800, Edward Adam Davis wrote:
> If inode is the ext4 boot loader inode, then when it is a directory, the inode
> should also be set to bad inode.

... what?  Are you saying that syzbot has randomly created a filesystem
where the boot loader inode is a directory?  If so, I'd suggest just
rejecting the filesystem with EFSCORRUPT.

> Reported-and-tested-by: syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/ext4/inode.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 61277f7f8722..b311f610f008 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4944,8 +4944,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  		inode->i_fop = &ext4_file_operations;
>  		ext4_set_aops(inode);
>  	} else if (S_ISDIR(inode->i_mode)) {
> -		inode->i_op = &ext4_dir_inode_operations;
> -		inode->i_fop = &ext4_dir_operations;
> +		if (ino == EXT4_BOOT_LOADER_INO)
> +			make_bad_inode(inode);
> +		else {
> +			inode->i_op = &ext4_dir_inode_operations;
> +			inode->i_fop = &ext4_dir_operations;
> +		}
>  	} else if (S_ISLNK(inode->i_mode)) {
>  		/* VFS does not allow setting these so must be corruption */
>  		if (IS_APPEND(inode) || IS_IMMUTABLE(inode)) {
> -- 
> 2.43.0
> 
> 

