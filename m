Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BEC437007
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 04:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhJVCdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 22:33:25 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44667 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232447AbhJVCdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:33:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UtCTdiN_1634869863;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UtCTdiN_1634869863)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Oct 2021 10:31:05 +0800
Date:   Fri, 22 Oct 2021 10:31:03 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     Phillip Susi <phill@thesusis.net>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        linux-bcache@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: Readahead for compressed data
Message-ID: <YXIiZ4CAfSP6FucF@B-P7TQMD6M-0146.local>
Mail-Followup-To: Phillip Lougher <phillip@squashfs.org.uk>,
        Phillip Susi <phill@thesusis.net>,
        Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-erofs@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, linux-bcache@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
 <87tuh9n9w2.fsf@vps.thesusis.net>
 <ea03d018-b9ef-9eed-c382-e1a3db7e4e5f@squashfs.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea03d018-b9ef-9eed-c382-e1a3db7e4e5f@squashfs.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 03:09:03AM +0100, Phillip Lougher wrote:
> On 22/10/2021 02:04, Phillip Susi wrote:
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
> > decompressing multiple times
> 
> There is a fairly obvious problem here.   A malicious attacker could
> "trick" the filesystem into endlessly decompressing the same blocks,
> which because the compressed data is cached, could cause it to use
> all CPU, and cause a DOS attack.  Caching the uncompressed data prevents
> these decompression attacks from occurring so easily.

Yes, that is another good point. But with artifact memory pressure,
there is no difference to cache compressed data or decompressed data,
otherwise these pages will be unreclaimable, reclaim any of cached
decompressed data will also need decompress the whole pcluster.

The same to zram or zswap or what else software compression solution,
what we can do is to limit the CPU utilization if any such requirement.
But that is quite hard for lz4 since in-memory lz4 decompression speed
is usually fast than the backend storage.

By the way, as far as I know there were some experimental hardware
accelerator integrated to storage devices. So they don't need to expand
decompress pages as well. And do inplace I/O only for such devices.

Thanks,
Gao Xiang

> 
> Phillip
> 
> 
