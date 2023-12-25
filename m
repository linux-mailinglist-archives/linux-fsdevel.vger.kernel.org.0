Return-Path: <linux-fsdevel+bounces-6894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0682681DD8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 03:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9481C214FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 02:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5307420F7;
	Mon, 25 Dec 2023 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YTjyZL5U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0D1847;
	Mon, 25 Dec 2023 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BqXhKno8pYPsfyukWJPQeJvD6OExI6mZWih5zP3r+KE=; b=YTjyZL5UmR2ZtV36z+A75Dk767
	jNfDcShrKuWXloZnAfP/6Fha18NGA0+Vf5PjgeiZybLWCwi1sDP0q1DmnyPT7+gSo57jQ+OMxiTVA
	7VO9yCqF8+Ya4LuxUsU22ASRFhI8uFkY2Q3V04gJlheifhL1E7Xut/L4btL4plkdbYVK7algp7bCL
	RbT0dlQHSEp00z4NHt9aLBQStpulqtM//gs+Uz6S/droCG+s/E79b1F1Q0l27glCAfC54XMz2P9n1
	/bmfpA4bnC5H5beHEXT26TM0cwkkhOfnwDXb17tJwVySAZUfSG/kBTKCyiN4P5Y4ZV30LUA0AljkT
	nusHTFvg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rHaVM-006WTq-25;
	Mon, 25 Dec 2023 02:15:44 +0000
Date: Mon, 25 Dec 2023 02:15:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Baokun Li <libaokun1@huawei.com>, Edward Adam Davis <eadavis@qq.com>,
	syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, yangerkun <yangerkun@huawei.com>
Subject: Re: [PATCH] ext4: fix WARNING in lock_two_nondirectories
Message-ID: <20231225021544.GF1674809@ZenIV>
References: <000000000000e17185060c8caaad@google.com>
 <tencent_DABB2333139E8D1BCF4B5D1B2725FABA9108@qq.com>
 <fb653ebf-0225-00b3-df05-6b685a727b41@huawei.com>
 <20231225021136.GC491196@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225021136.GC491196@mit.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Dec 24, 2023 at 09:11:36PM -0500, Theodore Ts'o wrote:
> On Mon, Dec 25, 2023 at 09:38:51AM +0800, Baokun Li wrote:
> > Marking the boot loader inode as a bad inode here is useless,
> > EXT4_IGET_BAD allows us to get a bad boot loader inode.
> > In my opinion, it doesn't make sense to call lock_two_nondirectories()
> > here to determine if the inode is a regular file or not, since the logic
> > for dealing with non-regular files comes after the locking, so calling
> > lock_two_inodes() directly here will suffice.
> 
> This is all very silly, and why I consider this sort of thing pure
> syzkaller noise.  It really doesn't protect against any real threat,
> and it encourages people to put all sorts of random crud in kernel
> code, all in the name of trying to shut up syzbot.
> 
> If we *are* going to care about shutting up syzkaller, the right
> approach is to simply add a check in swap_inode_boot_loader() which
> causes it to call ext4_error() and declare the file system corrupted
> if the bootloader inode is not a regular file, and then return
> -EFSCORRUPTED.
> 
> We don't need to add random hacks to ext4_iget(), or in other places...

Just check the inode type before anything else and be done with that -
if an in-core inode of a regular file manages to become a directory
right under us, we have a much worse problem.

IOW, the bug is real, but suggested patch is just plain wrong.

