Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E2645F6E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 23:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbhKZWfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 17:35:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244725AbhKZWdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 17:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637965793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60GQppTRbM0Y6JEekxv0GQtYQ7RJBSFOw1vmFV9kc08=;
        b=ANhkKb/TsPbbsZFS6xHodG4fdCnug1d4K6PjczJJXldGMUEh0V1WQXh4/ghtO9BQMsQTF+
        7RQ4hcavZjKjd4uLHgskWif5MXw2PbRMeYtUUY5/H9iLMpz/Qmuymm2zZFzPaiLnzAKkdS
        HFVADQlhQSVC4utLDubdbspJWoQwiho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-G2VY6lUqOVax6YCkCg6tZA-1; Fri, 26 Nov 2021 17:29:52 -0500
X-MC-Unique: G2VY6lUqOVax6YCkCg6tZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BC921006AA0;
        Fri, 26 Nov 2021 22:29:50 +0000 (UTC)
Received: from max.com (unknown [10.40.193.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB5425C1CF;
        Fri, 26 Nov 2021 22:29:46 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware with sub-page faults
Date:   Fri, 26 Nov 2021 23:29:45 +0100
Message-Id: <20211126222945.549971-1-agruenba@redhat.com>
In-Reply-To: <YaAROdPCqNzSKCjh@arm.com>
References: <YaAROdPCqNzSKCjh@arm.com> <20211124192024.2408218-1-catalin.marinas@arm.com> <20211124192024.2408218-4-catalin.marinas@arm.com> <YZ6arlsi2L3LVbFO@casper.infradead.org> <YZ6idVy3zqQC4atv@arm.com> <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:42 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Nov 25, 2021 at 11:25:54PM +0100, Andreas Gruenbacher wrote:
> > On Wed, Nov 24, 2021 at 9:37 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Wed, Nov 24, 2021 at 08:03:58PM +0000, Matthew Wilcox wrote:
> > > > On Wed, Nov 24, 2021 at 07:20:24PM +0000, Catalin Marinas wrote:
> > > > > +++ b/fs/btrfs/ioctl.c
> > > > > @@ -2223,7 +2223,8 @@ static noinline int search_ioctl(struct inode *inode,
> > > > >
> > > > >     while (1) {
> > > > >             ret = -EFAULT;
> > > > > -           if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
> > > > > +           if (fault_in_exact_writeable(ubuf + sk_offset,
> > > > > +                                        *buf_size - sk_offset))
> > > > >                     break;
> > > > >
> > > > >             ret = btrfs_search_forward(root, &key, path, sk->min_transid);
> > > >
> > > > Couldn't we avoid all of this nastiness by doing ...
> > >
> > > I had a similar attempt initially but I concluded that it doesn't work:
> > >
> > > https://lore.kernel.org/r/YS40qqmXL7CMFLGq@arm.com
> > >
> > > > @@ -2121,10 +2121,9 @@ static noinline int copy_to_sk(struct btrfs_path *path,
> > > >                  * problem. Otherwise we'll fault and then copy the buffer in
> > > >                  * properly this next time through
> > > >                  */
> > > > -               if (copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh))) {
> > > > -                       ret = 0;
> > > > +               ret = __copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh));
> > > > +               if (ret)
> > >
> > > There is no requirement for the arch implementation to be exact and copy
> > > the maximum number of bytes possible. It can fail early while there are
> > > still some bytes left that would not fault. The only requirement is that
> > > if it is restarted from where it faulted, it makes some progress (on
> > > arm64 there is one extra byte).
> > >
> > > >                         goto out;
> > > > -               }
> > > >
> > > >                 *sk_offset += sizeof(sh);
> > > > @@ -2196,6 +2195,7 @@ static noinline int search_ioctl(struct inode *inode,
> > > >         int ret;
> > > >         int num_found = 0;
> > > >         unsigned long sk_offset = 0;
> > > > +       unsigned long next_offset = 0;
> > > >
> > > >         if (*buf_size < sizeof(struct btrfs_ioctl_search_header)) {
> > > >                 *buf_size = sizeof(struct btrfs_ioctl_search_header);
> > > > @@ -2223,7 +2223,8 @@ static noinline int search_ioctl(struct inode *inode,
> > > >
> > > >         while (1) {
> > > >                 ret = -EFAULT;
> > > > -               if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
> > > > +               if (fault_in_writeable(ubuf + sk_offset + next_offset,
> > > > +                                       *buf_size - sk_offset - next_offset))
> > > >                         break;
> > > >
> > > >                 ret = btrfs_search_forward(root, &key, path, sk->min_transid);
> > > > @@ -2235,11 +2236,12 @@ static noinline int search_ioctl(struct inode *inode,
> > > >                 ret = copy_to_sk(path, &key, sk, buf_size, ubuf,
> > > >                                  &sk_offset, &num_found);
> > > >                 btrfs_release_path(path);
> > > > -               if (ret)
> > > > +               if (ret > 0)
> > > > +                       next_offset = ret;
> > >
> > > So after this point, ubuf+sk_offset+next_offset is writeable by
> > > fault_in_writable(). If copy_to_user() was attempted on
> > > ubuf+sk_offset+next_offset, all would be fine, but copy_to_sk() restarts
> > > the copy from ubuf+sk_offset, so it returns exacting the same ret as in
> > > the previous iteration.
> >
> > So this means that after a short copy_to_user_nofault(), copy_to_sk()
> > needs to figure out the actual point of failure. We'll have the same
> > problem elsewhere, so this should probably be a generic helper. The
> > alignment hacks are arch specific, so maybe we can have a generic
> > version that assumes no alignment restrictions, with arch-specific
> > overrides.
> >
> > Once we know the exact point of failure, a
> > fault_in_writeable(point_of_failure, 1) in search_ioctl() will tell if
> > the failure is pertinent. Once we know that the failure isn't
> > pertinent, we're safe to retry the original fault_in_writeable().
>
> The "exact point of failure" is problematic since copy_to_user() may
> fail a few bytes before the actual fault point (e.g. by doing an
> unaligned store).

That's why after the initial failure, we must keep trying until we hit
the actual point of failure independent of alignment.  If there's even a
single writable byte left, fault_in_writable() won't fail and we'll be
stuck in a loop.

On the other hand, once we've reached the actual point of failure, the
existing version of fault_in_writeable() will work for sub-page faults
as well.

> As per Linus' reply, we can work around this by doing
> a sub-page fault_in_writable(point_of_failure, align) where 'align'
> should cover the copy_to_user() impreciseness.
>
> (of course, fault_in_writable() takes the full size argument but behind
> the scene it probes the 'align' prefix at sub-page fault granularity)

That doesn't make sense; we don't want fault_in_writable() to fail or
succeed depending on the alignment of the address range passed to it.

Have a look at the below code to see what I mean.  Function
copy_to_user_nofault_unaligned() should be further optimized, maybe as
mm/maccess.c:copy_from_kernel_nofault() and/or per architecture
depending on the actual alignment rules; I'm not sure.

Thanks,
Andreas

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4e03a6d3aa32..067408fd26f9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6764,7 +6764,8 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 
 int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 				       void __user *dstv,
-				       unsigned long start, unsigned long len)
+				       unsigned long start, unsigned long len,
+				       void __user **copy_failure)
 {
 	size_t cur;
 	size_t offset;
@@ -6773,6 +6774,7 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 	char __user *dst = (char __user *)dstv;
 	unsigned long i = get_eb_page_index(start);
 	int ret = 0;
+	size_t rest;
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
@@ -6784,7 +6786,9 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 
 		cur = min(len, (PAGE_SIZE - offset));
 		kaddr = page_address(page);
-		if (copy_to_user_nofault(dst, kaddr + offset, cur)) {
+		rest = copy_to_user_nofault_unaligned(dst, kaddr + offset, cur);
+		if (rest) {
+			*copy_failure = dst + cur - rest;
 			ret = -EFAULT;
 			break;
 		}
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 0399cf8e3c32..833ff597a27f 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -238,9 +238,11 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 void read_extent_buffer(const struct extent_buffer *eb, void *dst,
 			unsigned long start,
 			unsigned long len);
+size_t copy_to_user_nofault_unaligned(void __user *to, void *from, size_t size);
 int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 				       void __user *dst, unsigned long start,
-				       unsigned long len);
+				       unsigned long len,
+				       void __user **copy_failure);
 void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *src);
 void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
 		const void *src);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index fb8cc9642ac4..646f9c0251d9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2051,13 +2051,30 @@ static noinline int key_in_sk(struct btrfs_key *key,
 	return 1;
 }
 
+size_t copy_to_user_nofault_unaligned(void __user *to, void *from, size_t size)
+{
+	size_t rest = copy_to_user_nofault(to, from, size);
+
+	if (rest) {
+		size_t n;
+
+		for (n = size - rest; n < size; n++) {
+			if (copy_to_user_nofault(to + n, from + n, 1))
+				break;
+		}
+		rest = size - n;
+	}
+	return rest;
+}
+
 static noinline int copy_to_sk(struct btrfs_path *path,
 			       struct btrfs_key *key,
 			       struct btrfs_ioctl_search_key *sk,
 			       size_t *buf_size,
 			       char __user *ubuf,
 			       unsigned long *sk_offset,
-			       int *num_found)
+			       int *num_found,
+			       void __user **copy_failure)
 {
 	u64 found_transid;
 	struct extent_buffer *leaf;
@@ -2069,6 +2086,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 	int i;
 	int slot;
 	int ret = 0;
+	size_t rest;
 
 	leaf = path->nodes[0];
 	slot = path->slots[0];
@@ -2121,7 +2139,9 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 		 * problem. Otherwise we'll fault and then copy the buffer in
 		 * properly this next time through
 		 */
-		if (copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh))) {
+		rest = copy_to_user_nofault_unaligned(ubuf + *sk_offset, &sh, sizeof(sh));
+		if (rest) {
+			*copy_failure = ubuf + *sk_offset + sizeof(sh) - rest;
 			ret = 0;
 			goto out;
 		}
@@ -2135,7 +2155,8 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 			 * * sk_offset so we copy the full thing again.
 			 */
 			if (read_extent_buffer_to_user_nofault(leaf, up,
-						item_off, item_len)) {
+						item_off, item_len,
+						copy_failure)) {
 				ret = 0;
 				*sk_offset -= sizeof(sh);
 				goto out;
@@ -2222,6 +2243,8 @@ static noinline int search_ioctl(struct inode *inode,
 	key.offset = sk->min_offset;
 
 	while (1) {
+		void __user *copy_failure = NULL;
+
 		ret = -EFAULT;
 		if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
 			break;
@@ -2233,11 +2256,13 @@ static noinline int search_ioctl(struct inode *inode,
 			goto err;
 		}
 		ret = copy_to_sk(path, &key, sk, buf_size, ubuf,
-				 &sk_offset, &num_found);
+				 &sk_offset, &num_found, &copy_failure);
 		btrfs_release_path(path);
 		if (ret)
 			break;
-
+		ret = -EFAULT;
+		if (copy_failure && fault_in_writeable(copy_failure, 1))
+			break;
 	}
 	if (ret > 0)
 		ret = 0;

