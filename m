Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078213FC8E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Aug 2021 15:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbhHaNzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 09:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237960AbhHaNzu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:55:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6989E6056B;
        Tue, 31 Aug 2021 13:54:53 +0000 (UTC)
Date:   Tue, 31 Aug 2021 14:54:50 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
Message-ID: <YS40qqmXL7CMFLGq@arm.com>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
 <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 28, 2021 at 08:28:17PM +0100, Al Viro wrote:
> 	AFAICS, a48b73eca4ce "btrfs: fix potential deadlock in the search ioctl"
> has introduced a bug at least on arm64.
> 
> Relevant bits: in search_ioctl() we have
>         while (1) {
>                 ret = fault_in_pages_writeable(ubuf + sk_offset,
>                                                *buf_size - sk_offset);
>                 if (ret)
>                         break;
> 
>                 ret = btrfs_search_forward(root, &key, path, sk->min_transid);
>                 if (ret != 0) {
>                         if (ret > 0)
>                                 ret = 0;
>                         goto err;
>                 }
>                 ret = copy_to_sk(path, &key, sk, buf_size, ubuf,
>                                  &sk_offset, &num_found);
>                 btrfs_release_path(path);
>                 if (ret)
>                         break;
> 
>         }
> and in copy_to_sk() -
>                 sh.objectid = key->objectid;
>                 sh.offset = key->offset;
>                 sh.type = key->type;
>                 sh.len = item_len;
>                 sh.transid = found_transid;
> 
>                 /*
>                  * Copy search result header. If we fault then loop again so we
>                  * can fault in the pages and -EFAULT there if there's a
>                  * problem. Otherwise we'll fault and then copy the buffer in
>                  * properly this next time through
>                  */
>                 if (copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh))) {
>                         ret = 0;
>                         goto out;
>                 }
> with sk_offset left unchanged if the very first copy_to_user_nofault() fails.
> 
> Now, consider a situation on arm64 where ubuf points to the beginning of page,
> ubuf[0] can be accessed, but ubuf[16] can not (possible with MTE, AFAICS).  We do
> fault_in_pages_writeable(), which succeeds.  When we get to copy_to_user_nofault()
> we fail as soon as it gets past the first 16 bytes.  And we repeat everything from
> scratch, with no progress made, since short copies are treated as "discard and
> repeat" here.

So if copy_to_user_nofault() returns -EFAULT, copy_to_sk() returns 0
(following commit a48b73eca4ce). I think you are right, search_ioctl()
can get into an infinite loop attempting to write to user if the
architecture can trigger faults at smaller granularity than the page
boundary. fault_in_pages_writeable() won't fix it if ubuf[0] is
writable and doesn't trigger an MTE tag check fault.

An arm64-specific workaround would be for pagefault_disable() to disable
tag checking. It's a pretty big hammer, weakening the out of bounds
access detection of MTE. My preference would be a fix in the btrfs code.

A btrfs option would be for copy_to_sk() to return an indication of
where the fault occurred and get fault_in_pages_writeable() to check
that location, even if the copying would restart from an earlier offset
(this requires open-coding copy_to_user_nofault()). An attempt below,
untested and does not cover read_extent_buffer_to_user_nofault():

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0ba98e08a029..9e74ba1c955d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2079,6 +2079,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 			       size_t *buf_size,
 			       char __user *ubuf,
 			       unsigned long *sk_offset,
+			       unsigned long *fault_offset,
 			       int *num_found)
 {
 	u64 found_transid;
@@ -2143,7 +2144,11 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 		 * problem. Otherwise we'll fault and then copy the buffer in
 		 * properly this next time through
 		 */
-		if (copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh))) {
+		pagefault_disable();
+		ret = __copy_to_user_inatomic(ubuf + *sk_offset, &sh, sizeof(sh));
+		pagefault_enable();
+		*fault_offset = *sk_offset + sizeof(sh) - ret;
+		if (ret) {
 			ret = 0;
 			goto out;
 		}
@@ -2218,6 +2223,7 @@ static noinline int search_ioctl(struct inode *inode,
 	int ret;
 	int num_found = 0;
 	unsigned long sk_offset = 0;
+	unsigned long fault_offset = 0;

 	if (*buf_size < sizeof(struct btrfs_ioctl_search_header)) {
 		*buf_size = sizeof(struct btrfs_ioctl_search_header);
@@ -2244,8 +2250,8 @@ static noinline int search_ioctl(struct inode *inode,
 	key.offset = sk->min_offset;

 	while (1) {
-		ret = fault_in_pages_writeable(ubuf + sk_offset,
-					       *buf_size - sk_offset);
+		ret = fault_in_pages_writeable(ubuf + fault_offset,
+					       *buf_size - fault_offset);
 		if (ret)
 			break;

@@ -2256,7 +2262,7 @@ static noinline int search_ioctl(struct inode *inode,
 			goto err;
 		}
 		ret = copy_to_sk(path, &key, sk, buf_size, ubuf,
-				 &sk_offset, &num_found);
+				 &sk_offset, &fault_offset, &num_found);
 		btrfs_release_path(path);
 		if (ret)
 			break;

-- 
Catalin
