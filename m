Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAAF1C4C70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 05:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgEEDBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 23:01:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59518 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgEEDBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 23:01:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0452vZMO115309;
        Tue, 5 May 2020 03:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Nd6QK3QqZdcbPrB+KnVHSBmdzbXYhT8VnKTnY56xkFM=;
 b=mrEEXORAFinSNLL/pklEroDK2vwj0iGo/9XC8NG+nbwx4Aj+wKnSdnPH4IgcgmF6NtWZ
 JgRHZuQPRD7uVpQr2k35H21CWs9E8XxYSFFcM6+B6/fW77iqivww/zz9tEl8b31+21h9
 78ybc3HrOvgs2j8iPZ/AkZQ2U86xOdu8wdNShuxICHHuQh9Hgee/Yhm+xd/nCPrCzOZy
 8jlzx3u57LJhxHGYjS3YxEaCwITUCdldyrYvDM5725gBvY79ILm1WQntCVQ4Suk1K5/2
 IcXucYc+bQ1wv8yT5AJ9J6s/+0RyK6QKWbQ/fUok77iyT+KMckOc6fvw0YcMwXiNo62d 7w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09r29sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 May 2020 03:01:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0452wXoK086833;
        Tue, 5 May 2020 02:59:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30sjjxh7s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 May 2020 02:59:04 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0452x3Vi021967;
        Tue, 5 May 2020 02:59:03 GMT
Received: from localhost (/10.159.143.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 19:59:03 -0700
Date:   Mon, 4 May 2020 19:59:02 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] iomap: Submit the BIO at the end of each extent
Message-ID: <20200505025902.GD5716@magnolia>
References: <20200320144014.3276-1-willy@infradead.org>
 <20200320214654.GC6812@magnolia>
 <20200505003710.GO5703@magnolia>
 <20200505022415.GE16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505022415.GE16070@bombadil.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=1
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050021
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 04, 2020 at 07:24:15PM -0700, Matthew Wilcox wrote:
> On Mon, May 04, 2020 at 05:37:10PM -0700, Darrick J. Wong wrote:
> > run fstests generic/418 at 2020-05-04 17:27:51
> > rm (3338) used greatest stack depth: 11728 bytes left
> > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0 
> > Oops: 0000 [#1] PREEMPT SMP
> > CPU: 1 PID: 4900 Comm: dio-invalidate- Not tainted 5.7.0-rc4-djw #rc4
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1 04/01/2014
> > RIP: 0010:iomap_set_range_uptodate+0x5d/0x170
> > Code: 07 00 60 00 00 75 13 f0 80 0f 04 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 47 18 44 8d 74 16 ff 41 89 f1 4c 8b 6f 28 <4c> 8b 38 41 0f b6 af ca 00 00 00 89 e9 41 d3 e9 40 80 fd 1f 0f 87
> > RSP: 0018:ffffc90004b0b8e8 EFLAGS: 00010206
> > RAX: 0000000000000000 RBX: ffffea0000292440 RCX: 0000000000000000
> > RDX: 0000000000000400 RSI: 0000000000000c00 RDI: ffffea0000292440
> > RBP: 0000000000001000 R08: ffffc90004b0b958 R09: 0000000000000c00
> > R10: 0000000000000002 R11: ffff888017806720 R12: ffffc90004b0ba20
> > R13: ffff888017806720 R14: 0000000000000fff R15: ffff88801872c610
> > FS:  00007f2091593740(0000) GS:ffff88801e800000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 0000000017abb005 CR4: 00000000001606a0
> > Call Trace:
> >  ? __raw_spin_lock_init+0x39/0x60
> >  iomap_readpage_actor+0x113/0x3f0
> >  iomap_readpages_actor+0x1dc/0x240
> >  iomap_apply+0x12d/0x4e9
> >  ? iomap_readpage_actor+0x3f0/0x3f0
> >  ? mark_held_locks+0x45/0x70
> >  iomap_readpages+0xc2/0x290
> >  ? iomap_readpage_actor+0x3f0/0x3f0
> >  ? xa_clear_mark+0x30/0x30
> >  read_pages+0x75/0x1b0
> >  __do_page_cache_readahead+0x1bb/0x1d0
> >  ondemand_readahead+0x21a/0x540
> >  ? pagecache_get_page+0x26/0x320
> >  generic_file_read_iter+0x91a/0xd10
> >  ? xfs_file_buffered_aio_read+0x88/0x170 [xfs]
> >  xfs_file_buffered_aio_read+0x65/0x170 [xfs]
> >  xfs_file_read_iter+0xe9/0x2a0 [xfs]
> >  new_sync_read+0x12d/0x1d0
> >  vfs_read+0xc7/0x180
> >  ksys_pread64+0x64/0xa0
> >  do_syscall_64+0x50/0x1a0
> >  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> > RIP: 0033:0x7f209179cbca
> > 
> > Digging into this with gcc, the RIP value is:
> > 
> > 0xffffffff813047cd is in iomap_set_range_uptodate (/storage/home/djwong/cdev/work/linux-djw/fs/iomap/buffered-io.c:147).
> > 142
> > 143     static void
> > 144     iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
> > 145     {
> > 146             struct iomap_page *iop = to_iomap_page(page);
> > 147             struct inode *inode = page->mapping->host;
> > 148             unsigned first = off >> inode->i_blkbits;
> > 149             unsigned last = (off + len - 1) >> inode->i_blkbits;
> > 150             bool uptodate = true;
> > 151             unsigned long flags;
> > 
> > So now this makes me wonder, is it possible to be performing readahead
> > into a page that doesn't have page->mapping set yet?  I reran this a few
> > times, got crashes in different places, but the common factor is that
> > page->mapping is NULL, and we're doing readhead.
> > 
> > I also tried this with the patch *not* applied and had the same
> > problems, so it's not actually this patch.  But there's something going
> > wrong in the iomap code...
> 
> Thanks for tracking that down!  I don't see a way for that to happen.
> The page is originally allocated in __do_page_cache_readahead() and
> (in 5.7) does not have page->mapping set.  Instead, it gets put on
> the page_pool list head which gets passed into iomap_readpages().
> iomap_next_page() calls add_to_page_cache_lru() which either sets
> page->mapping or returns an error.  So I don't see how iomap_next_page()
> can give us a page which doesn't have ->mapping set.
> 
> Is it possible that it's the second dereference, not the first that's
> NULL?  ie mapping->host is NULL?

Hmm, that's possible too.  I haven't gotten around (it's 19:58 here) to
digging further into the disassembly to figure out which pointer
deference it really is.

--D
