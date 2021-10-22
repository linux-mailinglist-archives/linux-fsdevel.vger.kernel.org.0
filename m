Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF36436EC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 02:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhJVAZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 20:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231770AbhJVAZ4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:25:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD50E60EBB;
        Fri, 22 Oct 2021 00:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634862220;
        bh=OSajkPGWXV3rm9LiIZWq+VM94+j5+N3IhWdn05dUZZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jKvliVvnMbqrUrSce1ypIw/s3fWULNKwDK6NLsRszlOmtuzS1avPw5uNyjGqIg09v
         jphb1wQbvWSeq7BRWmHCof3Xqr1k5YkXGzcseIKWql9eZ/fh+Zgf525iVlWnX0UDib
         s1A0Yq2bIWuWC+CY+d30L74kyPqQDqEXJYjKpifRLKDG+NwXmBOUIZP+Ac2wU+u0Uw
         F284NyI3+HOlZpjPz+YJHcUvoGO6tg1y9Fg6ixyLxGrW6lvB6LGRBM8DOfntytk9Kl
         Km3KVvqGjBYha4rkQ+YOtJmMSE+cUs0Xi0VIru0sTS1IF2s4a+JTDPCDdE0cpNlxIb
         HdZ210xX8zUAQ==
Date:   Fri, 22 Oct 2021 08:22:14 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        linux-bcache@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: Readahead for compressed data
Message-ID: <20211022002135.GA19226@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        linux-bcache@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXHK5HrQpJu9oy8w@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 09:17:40PM +0100, Matthew Wilcox wrote:
> As far as I can tell, the following filesystems support compressed data:
> 
> bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
> 
> I'd like to make it easier and more efficient for filesystems to
> implement compressed data.  There are a lot of approaches in use today,
> but none of them seem quite right to me.  I'm going to lay out a few
> design considerations next and then propose a solution.  Feel free to
> tell me I've got the constraints wrong, or suggest alternative solutions.
> 
> When we call ->readahead from the VFS, the VFS has decided which pages
> are going to be the most useful to bring in, but it doesn't know how
> pages are bundled together into blocks.  As I've learned from talking to
> Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
> something we can teach the VFS.
> 
> We (David) added readahead_expand() recently to let the filesystem
> opportunistically add pages to the page cache "around" the area requested
> by the VFS.  That reduces the number of times the filesystem has to
> decompress the same block.  But it can fail (due to memory allocation
> failures or pages already being present in the cache).  So filesystems
> still have to implement some kind of fallback.
> 
> For many (all?) compression algorithms (all?) the data must be mapped at
> all times.  Calling kmap() and kunmap() would be an intolerable overhead.
> At the same time, we cannot write to a page in the page cache which is
> marked Uptodate.  It might be mapped into userspace, or a read() be in
> progress against it.  For writable filesystems, it might even be dirty!
> As far as I know, no compression algorithm supports "holes", implying
> that we must allocate memory which is then discarded.
> 
> To me, this calls for a vmap() based approach.  So I'm thinking
> something like ...
> 
> void *readahead_get_block(struct readahead_control *ractl, loff_t start,
> 			size_t len);
> void readahead_put_block(struct readahead_control *ractl, void *addr,
> 			bool success);
> 
> Once you've figured out which bytes this encrypted block expands to, you
> call readahead_get_block(), specifying the offset in the file and length
> and get back a pointer.  When you're done decompressing that block of
> the file, you get rid of it again.
> 
> It's the job of readahead_get_block() to allocate additional pages
> into the page cache or temporary pages.  readahead_put_block() will
> mark page cache pages as Uptodate if 'success' is true, and unlock
> them.  It'll free any temporary pages.
> 
> Thoughts?  Anyone want to be the guinea pig?  ;-)

Copied from IRC for reference as well..

As for vmap() strategy, No need to allocate some temporary pages in advance
before compressed I/O is done and async work is triggered, since I/Os /
works could cause noticable latencies. Logically, only inplace or cached
I/O strategy should be decided before I/O and compressed pages need to be
prepared. The benefits of fixed-sized output compression aside from the
relative higher compression ratios is that each compressed pcluster can
be completely decompressed independently, you can select inplace or cache
I/O for each pclusters. And when you decide inplace I/O for some pcluster,
no extra incompressible data is readed from disk or cached uselessly.

As I said, even overall read request (with many pclusters) is 1MiB or
2MiB or some else, also only need allocate 16 pages (64KiB) at most for lz4
for each read request (used for lz4 sliding window), no need such many
extra temporary pages.

Allocating too many pages in advance before I/O IMO is just increasing the
overall memory overhead. Low-ended devices cannot handle I/O quickly but
has limited memory. Temporary pages are only needed before decompression,
not exactly before I/O.

Thanks,
Gao Xiang
