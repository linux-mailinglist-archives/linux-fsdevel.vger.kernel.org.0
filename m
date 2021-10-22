Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956EE437468
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 11:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhJVJN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 05:13:58 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60028 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232161AbhJVJN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:13:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UtFDPVc_1634893894;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UtFDPVc_1634893894)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Oct 2021 17:11:36 +0800
Date:   Fri, 22 Oct 2021 17:11:34 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Phillip Susi <phill@thesusis.net>,
        linux-ntfs-dev@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        linux-bcache@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-fsdevel@vger.kernel.org,
        Phillip Lougher <phillip@squashfs.org.uk>,
        ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org
Subject: Re: Readahead for compressed data
Message-ID: <YXKARs0QpAZWl6Hi@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
        Phillip Susi <phill@thesusis.net>,
        linux-ntfs-dev@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-bcache@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, linux-fsdevel@vger.kernel.org,
        Phillip Lougher <phillip@squashfs.org.uk>, ntfs3@lists.linux.dev,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
 <87tuh9n9w2.fsf@vps.thesusis.net>
 <20211022084127.GA1026@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211022084127.GA1026@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:41:27AM +0200, Jan Kara wrote:
> On Thu 21-10-21 21:04:45, Phillip Susi wrote:
> > 
> > Matthew Wilcox <willy@infradead.org> writes:
> > 
> > > As far as I can tell, the following filesystems support compressed data:
> > >
> > > bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
> > >
> > > I'd like to make it easier and more efficient for filesystems to
> > > implement compressed data.  There are a lot of approaches in use today,
> > > but none of them seem quite right to me.  I'm going to lay out a few
> > > design considerations next and then propose a solution.  Feel free to
> > > tell me I've got the constraints wrong, or suggest alternative solutions.
> > >
> > > When we call ->readahead from the VFS, the VFS has decided which pages
> > > are going to be the most useful to bring in, but it doesn't know how
> > > pages are bundled together into blocks.  As I've learned from talking to
> > > Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
> > > something we can teach the VFS.
> > >
> > > We (David) added readahead_expand() recently to let the filesystem
> > > opportunistically add pages to the page cache "around" the area requested
> > > by the VFS.  That reduces the number of times the filesystem has to
> > > decompress the same block.  But it can fail (due to memory allocation
> > > failures or pages already being present in the cache).  So filesystems
> > > still have to implement some kind of fallback.
> > 
> > Wouldn't it be better to keep the *compressed* data in the cache and
> > decompress it multiple times if needed rather than decompress it once
> > and cache the decompressed data?  You would use more CPU time
> > decompressing multiple times, but be able to cache more data and avoid
> > more disk IO, which is generally far slower than the CPU can decompress
> > the data.
> 
> Well, one of the problems with keeping compressed data is that for mmap(2)
> you have to have pages decompressed so that CPU can access them. So keeping
> compressed data in the page cache would add a bunch of complexity. That
> being said keeping compressed data cached somewhere else than in the page
> cache may certainly me worth it and then just filling page cache on demand
> from this data...

It can be cached with a special internal inode, so no need to take
care of the memory reclaim or migration by yourself.

Otherwise, these all need to be take care of. For fixed-sized input
compression, since they are reclaimed in page unit, so it won't be
quite friendly since such data is all coupling. But for fixed-sized
output compression, it's quite natural.

Thanks,
Gao Xiang

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
