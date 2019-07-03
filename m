Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F545DABC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 03:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfGCBZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 21:25:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfGCBZc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:25:32 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D2E50B732F0DD8067CD1;
        Wed,  3 Jul 2019 09:25:28 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 09:25:24 +0800
Subject: Re: [f2fs-dev] [PATCH v6 17/17] f2fs: add fs-verity support
To:     Eric Biggers <ebiggers@kernel.org>, <linux-fscrypt@vger.kernel.org>
CC:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        <linux-api@vger.kernel.org>, Dave Chinner <david@fromorbit.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Victor Hsieh <victorhsieh@google.com>
References: <20190701153237.1777-1-ebiggers@kernel.org>
 <20190701153237.1777-18-ebiggers@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b9b6d387-b893-18cc-b574-7775607ec5b3@huawei.com>
Date:   Wed, 3 Jul 2019 09:25:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190701153237.1777-18-ebiggers@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/7/1 23:32, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add fs-verity support to f2fs.  fs-verity is a filesystem feature that
> enables transparent integrity protection and authentication of read-only
> files.  It uses a dm-verity like mechanism at the file level: a Merkle
> tree is used to verify any block in the file in log(filesize) time.  It
> is implemented mainly by helper functions in fs/verity/.  See
> Documentation/filesystems/fsverity.rst for the full documentation.
> 
> The f2fs support for fs-verity consists of:
> 
> - Adding a filesystem feature flag and an inode flag for fs-verity.
> 
> - Implementing the fsverity_operations to support enabling verity on an
>   inode and reading/writing the verity metadata.
> 
> - Updating ->readpages() to verify data as it's read from verity files
>   and to support reading verity metadata pages.
> 
> - Updating ->write_begin(), ->write_end(), and ->writepages() to support
>   writing verity metadata pages.
> 
> - Calling the fs-verity hooks for ->open(), ->setattr(), and ->ioctl().
> 
> Like ext4, f2fs stores the verity metadata (Merkle tree and
> fsverity_descriptor) past the end of the file, starting at the first 64K
> boundary beyond i_size.  This approach works because (a) verity files
> are readonly, and (b) pages fully beyond i_size aren't visible to
> userspace but can be read/written internally by f2fs with only some
> relatively small changes to f2fs.  Extended attributes cannot be used
> because (a) f2fs limits the total size of an inode's xattr entries to
> 4096 bytes, which wouldn't be enough for even a single Merkle tree
> block, and (b) f2fs encryption doesn't encrypt xattrs, yet the verity
> metadata *must* be encrypted when the file is because it contains hashes
> of the plaintext data.
> 
> Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,
