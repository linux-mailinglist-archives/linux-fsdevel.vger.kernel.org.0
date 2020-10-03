Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666EA282729
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 00:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgJCWip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 18:38:45 -0400
Received: from mail.etersoft.ru ([91.232.225.46]:52296 "EHLO mail.etersoft.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgJCWip (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 18:38:45 -0400
X-Greylist: delayed 611 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Oct 2020 18:38:44 EDT
Received: from roundcube.eterhost.ru (azbykar.etersoft.ru [91.232.225.23])
        by mail.etersoft.ru (Postfix) with ESMTPSA id 169AB216076;
        Sun,  4 Oct 2020 01:28:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.etersoft.ru 169AB216076
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etersoft.ru; s=dkim;
        t=1601764112; bh=mNoA4UuwG/c2faGso0VvAgRi3GbAluEVlDiGsHLXhlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jVcQBz9/Smu2lOVm3u03p/vWgzC5AYV+/WSWWbZqS3IS/9froDdURCl6cL/jyanhm
         HzDbX0UQawqdRYXKC2gz3JKXK8dxh3rMrQFoaR6rludkVEVYkKgy/h7wE85I2qxohp
         7zdLVUqJQ5x9bwY7SaQDYcqHxe59d7D9koIHyU/I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 04 Oct 2020 01:28:32 +0300
From:   Vitaly Lipatov <lav@etersoft.ru>
To:     almaz.alexandrovich@paragon-software.com
Cc:     aaptel@suse.com, dsterba@suse.cz, joe@perches.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark@harmstone.com, nborisov@suse.com, pali@kernel.org,
        rdunlap@infradead.org, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v6 02/10] fs/ntfs3: Add initialization of super block
In-Reply-To: <<20200918162204.3706029-3-almaz.alexandrovich@paragon-software.com>>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <1d947879f8191f06cc02fd7c47e41f48@etersoft.ru>
X-Sender: lav@etersoft.ru
Organization: Etersoft
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> This adds initialization of super block
> 
> Signed-off-by: Konstantin Komarov 
> <almaz.alexandrovich@paragon-software.com>
...

> +static int ntfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> +{
> +	struct super_block *sb = dentry->d_sb;
> +	struct ntfs_sb_info *sbi = sb->s_fs_info;
> +	struct wnd_bitmap *wnd = &sbi->used.bitmap;
> +
> +	buf->f_type = sb->s_magic;
> +	buf->f_bsize = sbi->cluster_size;
> +	buf->f_blocks = wnd->nbits;
> +
> +	buf->f_bfree = buf->f_bavail = wnd_zeroes(wnd);
> +	buf->f_fsid.val[0] = (u32)sbi->volume.ser_num;
> +	buf->f_fsid.val[1] = (u32)(sbi->volume.ser_num >> 32);
> +	buf->f_namelen = NTFS_NAME_LEN;
namelen field of kstatfs (also as statfs struct from statfs system call) 
contains
maximum length of filenames on your file system for user space. It is 
the number of bytes for filenames.
But NTFS_NAME_LEN (255) is a length of filenames in UCS2 chars, so it 
can be up to 3*255 bytes in UTF-8.

-- 
Vitaly Lipatov
Etersoft
