Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB95521AC70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 03:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGJBPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 21:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgGJBPP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:15:15 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A79B20708;
        Fri, 10 Jul 2020 01:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594343715;
        bh=C8cT75MIlGM04Tub/VRAl3jRDWJvMsg87Gf2nf6feWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5dVuYqU9lL7VJJavhFYRgeK1C7CXj9pDwiZxDeHvV6G5lJMyfNbRV7FNeAsTH8Vn
         yPWTht3cItkkWnhW3hh+gNE4zGFsfZRqBBLm1cgWtwCbA9xUnA8V/s735zsk1pZQ6e
         7DPyUEVeX1bPi8+BJ9PP9hJuiki1L5HrnlZcVVxU=
Date:   Thu, 9 Jul 2020 18:15:13 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Satya Tangirala <satyat@google.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/5] f2fs: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200710011513.GA4037751@gmail.com>
References: <20200709194751.2579207-1-satyat@google.com>
 <20200709194751.2579207-6-satyat@google.com>
 <560266ca-0164-c02e-18ea-55564683d13e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560266ca-0164-c02e-18ea-55564683d13e@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:05:23AM +0800, Chao Yu wrote:
> On 2020/7/10 3:47, Satya Tangirala wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Wire up f2fs with fscrypt direct I/O support.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> > ---
> >  fs/f2fs/f2fs.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index b35a50f4953c..6d662a37b445 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -4082,7 +4082,9 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
> >  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >  	int rw = iov_iter_rw(iter);
> >  
> > -	if (f2fs_post_read_required(inode))
> > +	if (!fscrypt_dio_supported(iocb, iter))
> > +		return true;
> > +	if (fsverity_active(inode))
> 
> static inline bool f2fs_post_read_required(struct inode *inode)
> {
> 	return f2fs_encrypted_file(inode) || fsverity_active(inode) ||
> 		f2fs_compressed_file(inode);
> }
> 
> That's not correct, missed to check compression condition.
> 

Thanks Chao, great catch.  This used to be correct, but we missed that the
second f2fs_compressed_file() check got removed by commit b5f4684b5f5f
("f2fs: remove redundant compress inode check").

- Eric
