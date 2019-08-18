Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC993913D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 02:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHRAy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Aug 2019 20:54:26 -0400
Received: from sonic314-47.consmr.mail.ir2.yahoo.com ([77.238.177.173]:45887
        "EHLO sonic314-47.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbfHRAyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Aug 2019 20:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566089662; bh=pBWBwyARZnrzm33VPsM+sotY6iI5K4m2Qacgfi12VPg=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=N8kGHyihl8flFPtk1lEDvNKD7qeQrwa2VZG22wFLvMjekeH9ihFDMrlwOGDNyGYNGcTXvqxha5azq0xQM8TB9UDM6EfNh13tE0Vw7PlA65CZelCReG/Ng9VcyUeBJDf3/vrpfx/WDf3OHAz/Ut9ruvSkW9jmQtzfYcJWHbkZd+Lg4V7FVwK93qGUZuvPVWNsk7pP0mWFsQ8dvNYY1lP5XQKXyO0Fv921yZrTUmYrD4KWvTYfATBcEKiPHBa0OMMoZHZ1HCkbu/o4L5vi95XgUOr/OWcW7iWDh9AvW1fg9u67DJWhwZSFkDeKClwv7WQ1WWhO7J2uB2fkLbAT3WcYew==
X-YMail-OSG: d7OXBJkVM1nW9fPWmebywH7Y56nwVgJNGgdGo3dOnKUoiafHfJGqeoMZ2Z1L63_
 1NCcUccshIblqErhprGtdqNBn5Id0FHAwByqLrJLy3D8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sun, 18 Aug 2019 00:54:22 +0000
Received: by smtp405.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 97deb381fe076b668cd11f47aa9377ca;
          Sun, 18 Aug 2019 00:52:21 +0000 (UTC)
Date:   Sun, 18 Aug 2019 08:52:11 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel <devel@driverdev.osuosl.org>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, tytso <tytso@mit.edu>,
        Pavel Machek <pavel@denx.de>, David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Darrick <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        torvalds <torvalds@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818005202.GA3088@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190817082313.21040-1-hsiangkao@aol.com>
 <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
 <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
 <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818000408.GA20778@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818000408.GA20778@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 18, 2019 at 08:04:11AM +0800, Gao Xiang wrote:
> On Sun, Aug 18, 2019 at 07:38:47AM +0800, Gao Xiang wrote:
> > Hi Richard,
> > 
> > On Sun, Aug 18, 2019 at 01:25:58AM +0200, Richard Weinberger wrote:
> 
> []
> 
> > > 
> > > While digging a little into the code I noticed that you have very few
> > > checks of the on-disk data.
> > > For example ->u.i_blkaddr. I gave it a try and created a
> > > malformed filesystem where u.i_blkaddr is 0xdeadbeef, it causes the kernel
> > > to loop forever around erofs_read_raw_page().
> > 
> > I don't fuzz all the on-disk fields for EROFS, I will do later..
> > You can see many in-kernel filesystems are still hardening the related
> > stuff. Anyway, I will dig into this field you mentioned recently, but
> > I think it can be fixed easily later.
> 
> ...I take a simple try with the following erofs-utils diff and
> a directory containing enwik9 only, with the latest kernel (5.3-rc)
> and command line is
> mkfs/mkfs.erofs -d9 enwik9.img testdir.
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 581f263..2540338 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -388,8 +388,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
>  			v1.i_u.compressed_blocks =
>  				cpu_to_le32(inode->u.i_blocks);
>  		else
> -			v1.i_u.raw_blkaddr =
> -				cpu_to_le32(inode->u.i_blkaddr);
> +			v1.i_u.raw_blkaddr = 0xdeadbeef;
>  		break;
>  	}
> 
> I tested the corrupted image with looped device and real blockdevice
> by dd, and it seems fine....
> [36283.012381] erofs: initializing erofs 1.0
> [36283.012510] erofs: successfully to initialize erofs
> [36283.012975] erofs: read_super, device -> /dev/loop17
> [36283.012976] erofs: options -> (null)
> [36283.012983] erofs: root inode @ nid 36
> [36283.012995] erofs: mounted on /dev/loop17 with opts: (null).
> [36297.354090] attempt to access beyond end of device
> [36297.354098] loop17: rw=0, want=29887428984, limit=1953128
> [36297.354107] attempt to access beyond end of device
> [36297.354109] loop17: rw=0, want=29887428480, limit=1953128
> [36301.827234] attempt to access beyond end of device
> [36301.827243] loop17: rw=0, want=29887428480, limit=1953128
> [36371.426889] erofs: unmounted for /dev/loop17
> [36518.156114] erofs: read_super, device -> /dev/nvme0n1p4
> [36518.156115] erofs: options -> (null)
> [36518.156260] erofs: root inode @ nid 36
> [36518.156384] erofs: mounted on /dev/nvme0n1p4 with opts: (null).
> [36522.818884] attempt to access beyond end of device
> [36522.818889] nvme0n1p4: rw=0, want=29887428984, limit=62781440
> [36522.818895] attempt to access beyond end of device
> [36522.818896] nvme0n1p4: rw=0, want=29887428480, limit=62781440
> [36524.072018] attempt to access beyond end of device
> [36524.072028] nvme0n1p4: rw=0, want=29887428480, limit=62781440
> 
> Could you give me more hints how to reproduce that? and I will
> dig into more maybe it needs more conditions...

I think I found what happened here... That is not a bug due to lack of
check of on-disk ->u.i_blkaddr (seems block layer will handle access
beyond end of device) but actually a bug of erofs_readdir:

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fda16ec8863e..5b5f35d47370 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -329,6 +329,8 @@ static int erofs_raw_access_readpage(struct file *file, struct page *page)
 
 	trace_erofs_readpage(page, true);
 
+	WARN_ON(1);
+
 	bio = erofs_read_raw_page(NULL, page->mapping,
 				  page, &last_block, 1, false);
 
@@ -379,6 +381,8 @@ static int erofs_raw_access_readpages(struct file *filp,
 	/* the rare case (end in gaps) */
 	if (unlikely(bio))
 		__submit_bio(bio, REQ_OP_READ, 0);
+
+	WARN_ON(1);
 	return 0;
 }
 
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 637d70108d59..ccca954438ed 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -80,8 +80,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		unsigned int nameoff, maxsize;
 
 		dentry_page = read_mapping_page(mapping, i, NULL);
-		if (IS_ERR(dentry_page))
-			continue;
+		if (IS_ERR(dentry_page)) {
+			err = PTR_ERR(dentry_page);
+			break;
+		}
 
 		de = (struct erofs_dirent *)kmap(dentry_page);
 

It's a forever loop due to error handling of the read_mapping_page above.
I will fix that in another patch and thanks for your report!

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thanks,
> > Gao Xiang 
> > 
> > > 
> > > Thanks,
> > > //richard
