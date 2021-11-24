Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0945CD9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 21:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbhKXUH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 15:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbhKXUHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:07:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F59C061574;
        Wed, 24 Nov 2021 12:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OAtizbSoXoPNAyMg215cuoX14RfVf7vO6HnqYrV3Dvk=; b=pxzUkXYfltPbHw3FE40BsyvVC7
        q4ztiAKAh9byHa+doug0X32e1mx36FUzfwLCiduYtt8QsQkbTSbkx8rBjcJuIEIoHDU20SEPslrtv
        aii6BxwmJAhz2jwsFlCGq9xm5OajI8ekPEy4Mqu0PWeXNpXx4DqN2dO+jhaBLFPxibEOqbbPap9kz
        8hJIYZoj+Zo4YwJWjUUXqgOiIkexnMHh1II250x7Gy2c6CToeqOJJvXycORVmnogatzbWhQ9v5WVB
        5Azf0IIf4TYYwihfL8WBzt1yNge3rFW3tQIm07tHkpz8QXVV3OMm2hQWnGTYXtG6Kw4Kd8+/dnFER
        KDp5jGhA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpyUo-003BgI-Pa; Wed, 24 Nov 2021 20:03:58 +0000
Date:   Wed, 24 Nov 2021 20:03:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
Message-ID: <YZ6arlsi2L3LVbFO@casper.infradead.org>
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124192024.2408218-4-catalin.marinas@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 07:20:24PM +0000, Catalin Marinas wrote:
> +++ b/fs/btrfs/ioctl.c
> @@ -2223,7 +2223,8 @@ static noinline int search_ioctl(struct inode *inode,
>  
>  	while (1) {
>  		ret = -EFAULT;
> -		if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
> +		if (fault_in_exact_writeable(ubuf + sk_offset,
> +					     *buf_size - sk_offset))
>  			break;
>  
>  		ret = btrfs_search_forward(root, &key, path, sk->min_transid);

Couldn't we avoid all of this nastiness by doing ...

@@ -2121,10 +2121,9 @@ static noinline int copy_to_sk(struct btrfs_path *path,
                 * problem. Otherwise we'll fault and then copy the buffer in
                 * properly this next time through
                 */
-               if (copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh))) {
-                       ret = 0;
+               ret = __copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh));
+               if (ret)
                        goto out;
-               }
 
                *sk_offset += sizeof(sh);
@@ -2196,6 +2195,7 @@ static noinline int search_ioctl(struct inode *inode,
        int ret;
        int num_found = 0;
        unsigned long sk_offset = 0;
+       unsigned long next_offset = 0;
 
        if (*buf_size < sizeof(struct btrfs_ioctl_search_header)) {
                *buf_size = sizeof(struct btrfs_ioctl_search_header);
@@ -2223,7 +2223,8 @@ static noinline int search_ioctl(struct inode *inode,
 
        while (1) {
                ret = -EFAULT;
-               if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
+               if (fault_in_writeable(ubuf + sk_offset + next_offset,
+                                       *buf_size - sk_offset - next_offset))
                        break;
 
                ret = btrfs_search_forward(root, &key, path, sk->min_transid);
@@ -2235,11 +2236,12 @@ static noinline int search_ioctl(struct inode *inode,
                ret = copy_to_sk(path, &key, sk, buf_size, ubuf,
                                 &sk_offset, &num_found);
                btrfs_release_path(path);
-               if (ret)
+               if (ret > 0)
+                       next_offset = ret;
+               else if (ret < 0)
                        break;
-
        }
-       if (ret > 0)
+       if (ret == -ENOSPC || ret > 0)
                ret = 0;
 err:
        sk->nr_items = num_found;

(not shown: the tedious bits where the existing 'ret = 1' are converted
to 'ret = -ENOSPC' in copy_to_sk())
 
(where __copy_to_user_nofault() is a new function that does exactly what
copy_to_user_nofault() does, but returns the number of bytes copied)

That way, the existing fault_in_writable() will get the fault, and we
don't need to probe every 16 bytes.
