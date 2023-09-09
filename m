Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE07979979A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 13:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344877AbjIILSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 07:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjIILSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:18:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249F4CF2;
        Sat,  9 Sep 2023 04:18:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 54BCD6732D; Sat,  9 Sep 2023 13:18:35 +0200 (CEST)
Date:   Sat, 9 Sep 2023 13:18:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Lei Huang <lei.huang@linux.intel.com>, miklos@szeredi.hu,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Boris Pismenny <borisp@nvidia.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-mm@kvack.org, v9fs@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: getting rid of the last memory modifitions through
 gup(FOLL_GET)
Message-ID: <20230909111834.GA11859@lst.de>
References: <20230905141604.GA27370@lst.de> <0240468f-3cc5-157b-9b10-f0cd7979daf0@redhat.com> <20230908081544.GB8240@lst.de> <8698ba1f-fc5d-a82e-842b-100dc8957f2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8698ba1f-fc5d-a82e-842b-100dc8957f2f@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 08, 2023 at 06:48:05PM +0200, David Hildenbrand wrote:
> vmsplice_to_pipe() -> iter_to_pipe() -> iov_iter_get_pages2()
>
> So it ends up calling get_user_pages_fast()
>
> ... and not using FOLL_PIN|FOLL_LONGTERM
>
> Why FOLL_LONGTERM? Because it's a longterm pin, where unprivileged users 
> can grab a reference on a page for all eternity, breaking CMA and memory 
> hotunplug (well, and harming compaction).
>
> Why FOLL_PIN? Well FOLL_LONGTERM only applies to FOLL_PIN. But for 
> anonymous memory, this will also take care of the last remaining hugetlb 
> COW test (trigger COW unsharing) as commented back in:
>
> https://lore.kernel.org/all/02063032-61e7-e1e5-cd51-a50337405159@redhat.com/

Well, I'm not against it.  It just isn't required for deadling with
file system writeback vs GUP modification race this thread was started
for. 

>> Can KVM page tables use file backed shared mappings?
>
> Yes, usually shmem and hugetlb. But with things like emulated 
> NVDIMMs/virtio-pmem for VMs, easily also ordinary files.
>
> But it's really not ordinary write access through GUP. It's write access 
> via a secondary page table (secondary MMU), that's synchronized to the 
> process page table -- just like if the CPU would be writing to the page 
> using the process page tables (primary MMU).

Writing through the process page tables takes a write faul when first
writing, which calls into ->page_mkwrite in the file system.  Does the
synchronization take care of that?  If not we need to add or emulate it.

> ptrace will find the pagecache page writable in the page table (PTE write 
> bit set), if it intends to write to the page (FOLL_WRITE). If it is not 
> writable, it will trigger a page fault that informs the file system.

Yes, that case is (mostly) fine.

>
> With an FS that wants writenotify, we will not map a page writable (PTE 
> write bit not set) unless it is dirty (PTE dirty bit set) IIRC.
>
> So are we concerned about a race between the filesystem removing the PTE 
> write bit (to catch next write access before it gets dirtied again) and 
> ptrace marking the page dirty?

Yes.  This is the race that we've run into with various GUP users.

> Yes. However, secondary MMU users (like KVM) would need some way to keep 
> making use of that; ideally, using a proper separate interface instead of 
> (ab)using plain GUP and confusing people :)

I'mm all for that.

