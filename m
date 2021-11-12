Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7109044ED16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 20:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhKLTPF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 14:15:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhKLTPC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 14:15:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14A5C60E08;
        Fri, 12 Nov 2021 19:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636744331;
        bh=wOUilmJG0yEgl1+k5Dv+lHJaSa6UoZ46IqfGRu9V9XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7FNpIsZPHPlPoIgaaUHCqxHG7T4VxQwOupFwalBJqQi0gFy2oU2SbJ8935bY/cF+
         9kVFwQ2YDAbV1gk/1jTM0OVZpDzSFwNERoAH0rq4uT9rBQUy/QMnBmGRAhIYAuKgNm
         h8ybUFxujrye+TLVBFWUoqELZUnY+Q134eMTiCoEiBmAMBUSn3jBUB6nIk8JFRSH51
         PDB49vG+Ku47WfCQL3K0u/tYafjvvas67C1ko9aHEUAraiW/YyBHr/saBP6GUOH4iG
         uoPF9+5Hh3yyMMS0mwC9OxevB/gqj1wYaUZKSL/huR+sElTevY/BFtFv8uDEc1AoS8
         rMrSWUvuPVYmg==
Date:   Fri, 12 Nov 2021 11:12:09 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     tytso@mit.edu, corbet@lwn.net, viro@zeniv.linux.org.uk,
        hughd@google.com, akpm@linux-foundation.org,
        linux-fscrypt@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 5/5] shmem: Add fsverity support
Message-ID: <YY68iXKPWN8+rd+0@gmail.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
 <20211112124411.1948809-6-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112124411.1948809-6-roberto.sassu@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 12, 2021 at 01:44:11PM +0100, Roberto Sassu wrote:
> Make the necessary modifications to support fsverity in tmpfs.
> 
> First, implement the fsverity operations (in a similar way of f2fs). These
> operations make use of shmem_read_mapping_page() instead of
> read_mapping_page() to handle the case where the page has been swapped out.
> The fsverity descriptor is placed at the end of the file and its location
> is stored in an xattr.
> 
> Second, implement the ioctl operations to enable, measure and read fsverity
> metadata.
> 
> Lastly, add calls to fsverity functions, to ensure that fsverity-relevant
> operations are checked and handled by fsverity (file open, attr set, inode
> evict).
> 
> Fsverity support can be enabled through the kernel configuration and
> remains enabled by default for every tmpfs filesystem instantiated (there
> should be no overhead, unless fsverity is enabled for a file).
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

I don't see how this makes sense at all.  The point of fs-verity is to avoid
having to hash the whole file when verifying it.  However, obviously the whole
file still has to be hashed to build the Merkle tree in the first place.  That
makes sense for a persistent filesystem where a file can be written once and
verified many times.  I don't see how it makes sense for tmpfs, where files have
to be re-created on every boot.  You might as well just hash the whole file.

Also, you didn't implement actually verifying the data (by calling
fsverity_verify_page()), so this patch doesn't really do anything anyway.

- Eric
