Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027A510A37D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 18:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfKZRmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 12:42:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34140 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfKZRmi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:42:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so9541774pff.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2019 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P3f1iGJawumIgOuAIlWdlKRuhCd2zOAmhK9BRWEG2vA=;
        b=0c1SvPJ+FW7X3xXgsL2MBUgF/I59MkedF1p2fBBV1JqCEykhs2NW/W3DiUE4QVoOhh
         cYATCOaKBh+50eIyknjVHVSFadnAujO682RC7Mk5X5ZpVb9q6ZkrHbJiX84Njvw/rUL/
         qs1jYHYHwCkaL7lf0xGf12//xIdOk7H479iJX8AsfFv+s+W9l/W+/yhc8G6SJFftgzo/
         ztKSASyVmwctXD4Y0JNhNI8OYF71ykZTfrIiRGqDwJPphUZ6zWpm0UMnXTV8depvaRb8
         xIqyGIaaRZFQ5hM7IVOfRuSu53XjkIGicY7YXEA3N9Z1GkDFhzdM1712uRY0qVcupw7e
         clUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P3f1iGJawumIgOuAIlWdlKRuhCd2zOAmhK9BRWEG2vA=;
        b=YuGk/g7XHqtSk3+tYbeOAKeJc1D4Y/t2McQG2TV466hXjyc23f7D/fyXl4j6TlXXpe
         JA/I9jpywd88cDwhsF0YzyEjpS0tqx5YHSwuf7u92AFixjtL1RxlovO1me3Kf/jDFyHd
         pR8I95AQr+JSM601k/jeFI4m4j8t3QYIfWw5g88nK3B275yLKbCPVtI+YEFimn25NEVL
         1BP87lVwMSWXk7cge7QD6Xpc1WaatFeX5czzb/F7kvotJwdwe1WTHswftYF5a+HHWu7O
         p0KezG9UQgpPRQpDYtghvPpV9nDXVJ1nPcd+ToX00yb4MaD0tZxmFAJRjT7KAXcX5SF8
         UxvQ==
X-Gm-Message-State: APjAAAXsr+LYb6QQYaBZt1GKj/s6+S67PjQ3dE2OtJzayol1Hef1rBPA
        nyOYaUjvHjRdKtYDxjZAG8xPlQ==
X-Google-Smtp-Source: APXvYqy+fbYCW2X1VgSYUpk4GCR4V04B/KYVz+yrbSdfUfgDXQT0PI76LTCFS+noTYUlhjd4E/97oA==
X-Received: by 2002:a65:67d6:: with SMTP id b22mr39977813pgs.136.1574790155882;
        Tue, 26 Nov 2019 09:42:35 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id b13sm13527227pgj.28.2019.11.26.09.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 09:42:35 -0800 (PST)
Date:   Tue, 26 Nov 2019 09:42:31 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v3 04/12] btrfs: get rid of trivial
 __btrfs_lookup_bio_sums() wrappers
Message-ID: <20191126174131.GB657777@vader>
References: <cover.1574273658.git.osandov@fb.com>
 <bca47beb2f4eef766accebef683137e94313f7d3.1574273658.git.osandov@fb.com>
 <dc600214-0f19-b321-8573-6193b5f47e16@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc600214-0f19-b321-8573-6193b5f47e16@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 26, 2019 at 03:56:31PM +0200, Nikolay Borisov wrote:
> 
> 
> On 20.11.19 г. 20:24 ч., Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Currently, we have two wrappers for __btrfs_lookup_bio_sums():
> > btrfs_lookup_bio_sums_dio(), which is used for direct I/O, and
> > btrfs_lookup_bio_sums(), which is used everywhere else. The only
> > difference is that the _dio variant looks up csums starting at the given
> > offset instead of using the page index, which isn't actually direct
> > I/O-specific. Let's clean up the signature and return value of
> > __btrfs_lookup_bio_sums(), rename it to btrfs_lookup_bio_sums(), and get
> > rid of the trivial helpers.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Overall looks good but 2 nits, see below.
> 
> In any case:
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Thanks!

> > ---
> >  fs/btrfs/compression.c |  4 ++--
> >  fs/btrfs/ctree.h       |  4 +---
> >  fs/btrfs/file-item.c   | 35 +++++++++++++++++------------------
> >  fs/btrfs/inode.c       |  6 +++---
> >  4 files changed, 23 insertions(+), 26 deletions(-)
> > 
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index b05b361e2062..4df6f0c58dc9 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -660,7 +660,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
> >  
> >  			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
> >  				ret = btrfs_lookup_bio_sums(inode, comp_bio,
> > -							    sums);
> > +							    false, 0, sums);
> >  				BUG_ON(ret); /* -ENOMEM */
> >  			}
> >  
> > @@ -689,7 +689,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
> >  	BUG_ON(ret); /* -ENOMEM */
> >  
> >  	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
> > -		ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
> > +		ret = btrfs_lookup_bio_sums(inode, comp_bio, false, 0, sums);
> >  		BUG_ON(ret); /* -ENOMEM */
> >  	}
> >  
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index fe2b8765d9e6..4bc40bf49b0e 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -2787,9 +2787,7 @@ struct btrfs_dio_private;
> >  int btrfs_del_csums(struct btrfs_trans_handle *trans,
> >  		    struct btrfs_fs_info *fs_info, u64 bytenr, u64 len);
> >  blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
> > -				   u8 *dst);
> > -blk_status_t btrfs_lookup_bio_sums_dio(struct inode *inode, struct bio *bio,
> > -			      u64 logical_offset);
> > +				   bool at_offset, u64 offset, u8 *dst);
> >  int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
> >  			     struct btrfs_root *root,
> >  			     u64 objectid, u64 pos,
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index 1a599f50837b..a87c40502267 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -148,8 +148,21 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
> >  	return ret;
> >  }
> >  
> > -static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
> > -				   u64 logical_offset, u8 *dst, int dio)
> > +/**
> > + * btrfs_lookup_bio_sums - Look up checksums for a bio.
> > + * @inode: inode that the bio is for.
> > + * @bio: bio embedded in btrfs_io_bio.
> > + * @at_offset: If true, look up checksums for the extent at @c offset.
> 
> nit: that @c is an editing artifact?

Oops, I mixed up kernel-doc with Doxygen. Fixed, thanks.

> On the other hand rather than
> having an explicit bool signifying whether we want a specific offset
> can't we simply check if offset is != 0 ?

Zero is a perfectly valid offset to have an extent at, but we could do
(u64)-1 instead. I'm not sure what's cleaner.
