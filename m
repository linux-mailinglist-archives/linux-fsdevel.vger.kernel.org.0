Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024A96E352D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 07:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDPF0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 01:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPF0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 01:26:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EB3268C;
        Sat, 15 Apr 2023 22:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pZvHs2kWaqVpao8c3qcH5kZt4S4kMZqAev2Gc/y6lzw=; b=VB9MCdYytedVxBmyIlxYt/xjiO
        wbDxhpyCC2DQw4U2kaQgh7OynzHbQnHlM0OzvWC1vzfzFS+e1df+iYw1E2vAfC25rgCdPJab/qiKI
        Qok3Ly6zawuo9kur5Mrjc0lg1nyNvOikuu2ANguS63760B0ZzbVZitUoVOtmwTDMcV808n46OJRRv
        ychdIW551Z6Z3cMd0KX1BPENyKmhdcgMjrFOrJKR1dN5nYqoe2z650M3Nu/dTAZPHIqn/wWGfb2Co
        cPeIWpQsYj7DnJyY8Zis8cOe8t0vVKU9NTqrl0Vpzg6CTfH/Eg2XfL+NqXkB9lM0qz6Cz+mhIOE8K
        P/GFviiA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnuuR-00DA9R-05;
        Sun, 16 Apr 2023 05:26:43 +0000
Date:   Sat, 15 Apr 2023 22:26:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "kbus >> Keith Busch" <kbusch@kernel.org>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gost.dev@samsung.com
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Message-ID: <ZDuHEolre/saj8iZ@bombadil.infradead.org>
References: <20230414110821.21548-1-p.raghav@samsung.com>
 <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
 <ZDn3XPMA024t+C1x@bombadil.infradead.org>
 <ZDoMmtcwNTINAu3N@casper.infradead.org>
 <ZDoZCJHQXhVE2KZu@bombadil.infradead.org>
 <ZDodlnm2nvYxbvR4@casper.infradead.org>
 <31765c8c-e895-4207-2b8c-39f6c7c83ece@suse.de>
 <ZDraOHQHqeabyCvN@casper.infradead.org>
 <ZDtPK5Qdts19bKY2@bombadil.infradead.org>
 <ZDtuFux7FGlCMkC3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDtuFux7FGlCMkC3@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 16, 2023 at 04:40:06AM +0100, Matthew Wilcox wrote:
> On Sat, Apr 15, 2023 at 06:28:11PM -0700, Luis Chamberlain wrote:
> > On Sat, Apr 15, 2023 at 06:09:12PM +0100, Matthew Wilcox wrote:
> > > On Sat, Apr 15, 2023 at 03:14:33PM +0200, Hannes Reinecke wrote:
> > > > On 4/15/23 05:44, Matthew Wilcox wrote:
> > > > We _could_ upgrade to always do full page I/O; there's a good
> > > > chance we'll be using the entire page anyway eventually.
> > 
> > *Iff* doing away with buffer head 512 granularity could help block sizes
> > greater than page size where physical and logical block size > PAGE_SIZE
> > we whould also be able to see it on 4kn drives (logical and physical
> > block size == 4k). A projection could be made after.
> > 
> > In so far as experimenting with this, if you already have some
> > effort on IOMAP for bdev aops one possibility for pure experimentation
> > for now would be to peg a new set of aops could be set in the path
> > of __alloc_disk_node() --> bdev_alloc() but that's a wee-bit too early
> > for us to know if the device is has (lbs = pbs) > 512. For NVMe for
> > instance this would be nvme_alloc_ns() --> blk_mq_alloc_disk(). We
> > put together and set the logical and phyiscal block size on NVMe on
> > nvme_update_ns_info() --> nvme_update_disk_info(), right before we
> > call device_add_disk(). The only way to override the aops then would
> > be right before device_add_disk(), or as part of a new device_add_disk_aops()
> > or whatever.
> 
> I think you're making this harder than you need to.
> For LBA size > PAGE_SIZE, there is always only going to be
> one BH per folio-that-is-LBA-size, so all the problems with
> more-than-8-BHs-per-4k-page don't actually exist.

Oh! Then yes, sorry!

> I don't think we
> should be overriding the aops, and if we narrow the scope of large folio
> support in blockdev t only supporting folio_size == LBA size, it becomes
> much more feasible.

I'm trying to think of the possible use cases where folio_size != LBA size
and I cannot immediately think of some. Yes there are cases where a
filesystem may use a different block for say meta data than data, but that
I believe is side issue, ie, read/writes for small metadata would have
to be accepted. At least for NVMe we have metadata size as part of the
LBA format, but from what I understand no Linux filesystem yet uses that.

> > > > And with storage bandwidth getting larger and larger we might even
> > > > get a performance boost there.
> > > 
> > > I think we need to look at this from the filesystem side.
> > 
> > Before that let's recap the bdev cache current issues.
> 
> Ooh, yes, this is good!  I was totally neglecting the partition
> scanning code.
> 
> > Today by just adding the disk we move on to partition scanning
> > immediately unless your block driver has a flag that says otherwise. The
> > current crash we're evaluating with brd and that we also hit with NVMe
> > is due to this part.
> > 
> > device_add_disk() -->
> >   disk_scan_partitions() -->
> >     blkdev_get_whole() -->
> >       bdev_disk_changed() -->
> >         filemap_read_folio() --> filler()
> > 
> > The filler is from aops.
> 
> Right, so you missed a step in that callchain, which is
> read_mapping_folio().  That ends up in do_read_cache_folio(), which
> contains the deadly:
> 
>                 folio = filemap_alloc_folio(gfp, 0);

Right and before this we have:

	if (!filler)                                                            
		filler = mapping->a_ops->read_folio;

The folio is order 0 and after filemap_alloc_folio() its added to the
page cache, then filemap_read_folio(file, filler, folio)
uses the filler blkdev_read_folio()  --> fs/buffer.c block_read_full_folio()

Just for posterity:

fs/buffer.c
int block_read_full_folio(struct folio *folio, get_block_t *get_block)
{
	...
	struct buffer_head *bh, *head,...;
	...
	head = create_page_buffers(&folio->page, inode, 0);
	...
}

static struct buffer_head *create_page_buffers(struct page *page, struct inode *inode, unsigned int b_state)
{                                                                               
        BUG_ON(!PageLocked(page));                                              
                                                                                
        if (!page_has_buffers(page))                                            
                create_empty_buffers(page, 1 << READ_ONCE(inode->i_blkbits),    
                                     b_state);                                  
        return page_buffers(page);                                              
}

void create_empty_buffers(struct page *page,                                    
                        unsigned long blocksize, unsigned long b_state)         
{
        struct buffer_head *bh, *head, *tail;                                   
                                                                                
        head = alloc_page_buffers(page, blocksize, true);
        bh = head; 
        do {                                                                    
                bh->b_state |= b_state; -----> CRASH HERE head is NULL
                tail = bh;                                                      
                bh = bh->b_this_page;                                           
        } while (bh);                                                           
        tail->b_this_page = head;
}

Why is it NULL? The blocksize passed to alloc_page_buffers() is larger
than PAGE_SIZE and below offset is PAGE_SIZE. PAGE_SIZE - blocksize
gives a negative number and so the loop is not traversed.

struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,   
                bool retry)                                                     
{ 
        struct buffer_head *bh, *head;                                          
        gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;                                   
        long offset;                                                            
        struct mem_cgroup *memcg, *old_memcg;                                   
                                                                                
        if (retry)                                                              
                gfp |= __GFP_NOFAIL;                                            
                                                                                
        /* The page lock pins the memcg */ 
        memcg = page_memcg(page);                                               
        old_memcg = set_active_memcg(memcg);                                    
                                                                                
        head = NULL;  
        offset = PAGE_SIZE;                                                     
        while ((offset -= size) >= 0) {                                         
                bh = alloc_buffer_head(gfp);                                    
                if (!bh)                                                        
                        goto no_grow;                                           
                                                                                
                bh->b_this_page = head;                                         
                bh->b_blocknr = -1;                                             
                head = bh;                                                      
                                                                                
                bh->b_size = size;                                              
                                                                                
                /* Link the buffer to its page */                               
                set_bh_page(bh, page, offset);                                  
        }                                                                       
out:                                                                            
        set_active_memcg(old_memcg);                                            
        return head;
	...
}

I see now what you say about the buffer head being of the block size
bh->b_size = size above.

> so that needs to be changed to get the minimum folio order from the
> mapping, and then it should work.
> 
> > > What do filesystems actually want to do?
> > 
> > So you are suggesting that the early reads of the block device by the
> > block cache and its use of the page cache cache should be aligned /
> > perhaps redesigned to assist more clearly with what modern filesystems
> > might actually would want today?
> 
> Perhaps?  I'm just saying the needs of the block device are not the
> only consideration here.  I'd like an API that makes sense for the fs
> author.

Makes sense!

> > > The first thing is they want to read
> > > the superblock.  That's either going to be immediately freed ("Oh,
> > > this isn't a JFS filesystem after all") or it's going to hang around
> > > indefinitely.  There's no particular need to keep it in any kind of
> > > cache (buffer or page). 
> > 
> > And the bdev cache would not be able to know before hand that's the case.
> 
> Right, nobody knows until it's been read and examined.
> 
> > > Except ... we want to probe a dozen different
> > > filesystems, and half of them keep their superblock at the same offset
> > > from the start of the block device.  So we do want to keep it cached.
> > > That's arguing for using the page cache, at least to read it.
> > 
> > Do we currently share anything from the bdev cache with the fs for this?
> > Let's say that first block device blocksize in memory.
> 
> sb_bread() is used by most filesystems, and the buffer cache aliases
> into the page cache.

I see thanks. I checked what xfs does and its xfs_readsb() uses its own
xfs_buf_read_uncached(). It ends up calling xfs_buf_submit() and
xfs_buf_ioapply_map() does it's own submit_bio(). So I'm curious why
they did that.

> > > Now, do we want userspace to be able to dd a new superblock into place
> > > and have the mounted filesystem see it? 
> > 
> > Not sure I follow this. dd a new super block?
> 
> In userspace, if I run 'dd if=blah of=/dev/sda1 bs=512 count=1 seek=N',
> I can overwrite the superblock.  Do we want filesystems to see that
> kind of vandalism, or do we want the mounted filesystem to have its
> own copy of the data and overwrite what userspace wrote the next time it
> updates the superblock?

Oh, what happens today?

> (the trick is that this may not be vandalism, it might be the sysadmin
> updating the uuid or running some fsck-ish program or trying to update
> the superblock to support fabulous-new-feature on next mount.  does this
> change the answer?)
> 
> > > I suspect that confuses just
> > > about every filesystem out there.  So I think the right answer is to read
> > > the page into the bdev's page cache and then copy it into a kmalloc'ed
> > > buffer which the filesystem is then responsible for freeing.  It's also
> > > responsible for writing it back (so that's another API we need), and for
> > > a journalled filesystem, it needs to fit into the journalling scheme.
> > > Also, we may need to write back multiple copies of the superblock,
> > > possibly with slight modifications.
> > 
> > Are you considering these as extentions to the bdev cache?
> 
> I'm trying to suggest some of the considerations that need to go into
> a replacement for sb_bread().

I see! That would also help EOL buffer heads for that purpose.

  Luis
