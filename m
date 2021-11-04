Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5974459A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 19:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhKDSZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 14:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234135AbhKDSZ2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:25:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A5C161212;
        Thu,  4 Nov 2021 18:22:47 +0000 (UTC)
Date:   Thu, 4 Nov 2021 18:22:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs@vger.kernel.org, joey.gouly@arm.com
Subject: Re: [PATCH v9 04/17] iov_iter: Turn iov_iter_fault_in_readable into
 fault_in_iov_iter_readable
Message-ID: <YYQk9L0D57QHc0gE@arm.com>
References: <20211102122945.117744-1-agruenba@redhat.com>
 <20211102122945.117744-5-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102122945.117744-5-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 01:29:32PM +0100, Andreas Gruenbacher wrote:
> Turn iov_iter_fault_in_readable into a function that returns the number
> of bytes not faulted in, similar to copy_to_user, instead of returning a
> non-zero value when any of the requested pages couldn't be faulted in.
> This supports the existing users that require all pages to be faulted in
> as well as new users that are happy if any pages can be faulted in.
> 
> Rename iov_iter_fault_in_readable to fault_in_iov_iter_readable to make
> sure this change doesn't silently break things.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
[...]
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ff34f4087f87..4dd5edcd39fd 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3757,7 +3757,7 @@ ssize_t generic_perform_write(struct file *file,
>  		 * same page as we're writing to, without it being marked
>  		 * up-to-date.
>  		 */
> -		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
> +		if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
>  			status = -EFAULT;
>  			break;
>  		}

Now that fault_in_iov_iter_readable() returns the number of bytes, we
could change the above test to:

		if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {

Assuming we have a pointer 'a', accessible, and 'a + PAGE_SIZE' unmapped:

	write(fd, a + PAGE_SIZE - 1, 2);

can still copy one byte but it returns -EFAULT instead since the second
page is not accessible.

While writing some test-cases for MTE (sub-page faults, 16-byte
granularity), we noticed that reading 2 bytes from 'a + 15' with
'a + 16' tagged for faulting:

	write(fd, a + 15, 2);

succeeds as long as 'a + 16' is not at a page boundary. Checking against
'bytes' above makes this consistent.

The downside is that it's an ABI change though not sure anyone is
relying on it.

-- 
Catalin
