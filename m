Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88C031225B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 09:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhBGIC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 03:02:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBGIC2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:02:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BA2C64E02;
        Sun,  7 Feb 2021 08:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612684907;
        bh=JQzrq1MRRknUQVbsQI9IjA///ymlH5drgaU78MxNp4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGxAEFMHm4BZoeFf1tOFxeRr7r09QtjCoBTxFRDdxsUEvSYRG+itkNzvROaEzHlzq
         cAGv8CwZ+x5cIMwK0vR9H5kWd+IMJUXKT8K/wSNQu/lM/K7zLZnJWhTl3OKMiHPFd0
         dEJ6nsD0RbRS9DwGVcPXikGC45FoEfDIlSPAlVbRzGQowU8XZawCB/Sii2XAEkQJSs
         g2EgBCSVOL5aT/jTa48oVBOLuYj4kyEF+zfsQlVQiUp+h/qB3dSXYy1RALtMB/V305
         x/g5ovIJy3IaLvVsU0ZBaKW9LCdhPZMX7DzhVmX+Wbte7vomS6KRc4shYZp6bn3c/g
         gcGo6QU6Vhk7g==
Date:   Sun, 7 Feb 2021 00:01:45 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-fscrypt@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-ext4@vger.kernel.org, Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH 3/6] fs-verity: add FS_IOC_READ_VERITY_METADATA ioctl
Message-ID: <YB+ead3SvsQy5ULH@sol.localdomain>
References: <20210115181819.34732-1-ebiggers@kernel.org>
 <20210115181819.34732-4-ebiggers@kernel.org>
 <107cf2f2-a6fe-57c2-d17d-57679d7c612d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <107cf2f2-a6fe-57c2-d17d-57679d7c612d@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 07, 2021 at 03:46:43PM +0800, Chao Yu wrote:
> Hi Eric,
> 
> On 2021/1/16 2:18, Eric Biggers wrote:
> > +static int f2fs_ioc_read_verity_metadata(struct file *filp, unsigned long arg)
> > +{
> > +	if (!f2fs_sb_has_verity(F2FS_I_SB(file_inode(filp))))
> > +		return -EOPNOTSUPP;
> 
> One case is after we update kernel image, f2fs module may no longer support
> compress algorithm which current file was compressed with, to avoid triggering
> IO with empty compress engine (struct f2fs_compress_ops pointer):
> 
> It needs to add f2fs_is_compress_backend_ready() check condition here?
> 
> Thanks,
> 
> > +
> > +	return fsverity_ioctl_read_metadata(filp, (const void __user *)arg);
> > +}

In that case it wouldn't have been possible to open the file, because
f2fs_file_open() checks for it.  So it's not necessary to repeat the same check
in every operation on the file descriptor.

- Eric
