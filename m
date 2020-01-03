Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D512FB6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 18:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgACRN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 12:13:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbgACRN5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:13:57 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B6820866;
        Fri,  3 Jan 2020 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578071637;
        bh=AuRBl8v/uqnhyO59/fcEhO8X0GrJrjk9X+uGwmn6iPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WjHl5s11l6p/ZZ2cE+Gms9M+r5fbBdtpkBoPQvsf+w4vofN9SL7w3OrjCZjSExGbQ
         66F8Xf/g5Rclf9S95up/kOzsPeZebE/TH76wPezXQIz8J1OpiuGQBsB3E18iDq4+DL
         i8ZCOjYhQ9AANFSzuONApx4WfqiTKJlC+GGzTA2c=
Date:   Fri, 3 Jan 2020 09:13:55 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH v2] fs-verity: implement readahead for
 FS_IOC_ENABLE_VERITY
Message-ID: <20200103171355.GP19521@gmail.com>
References: <20191210183531.179836-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210183531.179836-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 10:35:31AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> When it builds the first level of the Merkle tree, FS_IOC_ENABLE_VERITY
> sequentially reads each page of the file using read_mapping_page().
> This works fine if the file's data is already in pagecache, which should
> normally be the case, since this ioctl is normally used immediately
> after writing out the file.
> 
> But in any other case this implementation performs very poorly, since
> only one page is read at a time.
> 
> Fix this by implementing readahead using the functions from
> mm/readahead.c.
> 
> This improves performance in the uncached case by about 20x, as seen in
> the following benchmarks done on a 250MB file (on x86_64 with SHA-NI):
> 
>     FS_IOC_ENABLE_VERITY uncached (before) 3.299s
>     FS_IOC_ENABLE_VERITY uncached (after)  0.160s
>     FS_IOC_ENABLE_VERITY cached            0.147s
>     sha256sum uncached                     0.191s
>     sha256sum cached                       0.145s
> 
> Note: we could instead switch to kernel_read().  But that would mean
> we'd no longer be hashing the data directly from the pagecache, which is
> a nice optimization of its own.  And using kernel_read() would require
> allocating another temporary buffer, hashing the data and tree pages
> separately, and explicitly zero-padding the last page -- so it wouldn't
> really be any simpler than direct pagecache access, at least for now.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> Changed v1 => v2:
> - Only do sync readahead when the page wasn't found in the pagecache at all.
> - Use ->f_mapping so that the inode doesn't have to be passed.
> 
> 
>  fs/verity/enable.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 

Applied to fscrypt.git#fsverity for 5.6.

- Eric
