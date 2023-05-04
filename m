Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE31D6F6324
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 05:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjEDDJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 23:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjEDDJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 23:09:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BB5D7;
        Wed,  3 May 2023 20:09:46 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QBdyS22PGzLndm;
        Thu,  4 May 2023 11:06:56 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 11:09:43 +0800
Message-ID: <60a00a11-46e4-23ed-9c14-5b14dccf41e4@huawei.com>
Date:   Thu, 4 May 2023 11:09:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Ming Lei <ming.lei@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>,
        yangerkun <yangerkun@huawei.com>
References: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
 <ZEny7Izr8iOc/23B@casper.infradead.org>
 <ZEn/KB0fZj8S1NTK@ovpn-8-24.pek2.redhat.com>
 <dbb8d8a7-3a80-34cc-5033-18d25e545ed1@huawei.com>
 <ZEpH+GEj33aUGoAD@ovpn-8-26.pek2.redhat.com>
 <663b10eb-4b61-c445-c07c-90c99f629c74@huawei.com>
 <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com>
 <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
 <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com> <ZEtd6qZOgRxYnNq9@mit.edu>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <ZEtd6qZOgRxYnNq9@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/4/28 13:47, Theodore Ts'o wrote:
> On Fri, Apr 28, 2023 at 11:47:26AM +0800, Baokun Li wrote:
>> Ext4 just detects I/O Error and remounts it as read-only, it doesn't know
>> if the current disk is dead or not.
>>
>> I asked Yu Kuai and he said that disk_live() can be used to determine
>> whether
>> a disk has been removed based on the status of the inode corresponding to
>> the block device, but this is generally not done in file systems.
> What really needs to happen is that del_gendisk() needs to inform file
> systems that the disk is gone, so that the file system can shutdown
> the file system and tear everything down.

Yes, first of all, we need to be able to sense whether the current disk has
been removed. We're just sensing an I/O error now, so we're just making
the file system read-only.
>
> disk_live() is relatively new; it was added in August 2021.  Back in
> 2015, I had added the following in fs/ext4/super.c:
>
> /*
>   * The del_gendisk() function uninitializes the disk-specific data
>   * structures, including the bdi structure, without telling anyone
>   * else.  Once this happens, any attempt to call mark_buffer_dirty()
>   * (for example, by ext4_commit_super), will cause a kernel OOPS.
>   * This is a kludge to prevent these oops until we can put in a proper
>   * hook in del_gendisk() to inform the VFS and file system layers.
>   */
> static int block_device_ejected(struct super_block *sb)
> {
> 	struct inode *bd_inode = sb->s_bdev->bd_inode;
> 	struct backing_dev_info *bdi = inode_to_bdi(bd_inode);
>
> 	return bdi->dev == NULL;
> }
>
> As the comment states, it's rather awkward to have the file system
> check to see if the block device is dead in various places; the real
> problem is that the block device shouldn't just *vanish*, with the
> block device structures egetting partially de-initialized, without the
> block layer being polite enough to let the file system know.

I didn't notice the block_device_ejected() function, and it's really 
awkward

for the file system to detect whether the current disk has been removed.

>> Those dirty pages that are already there are piling up and can't be
>> written back, which I think is a real problem. Can the block layer
>> clear those dirty pages when it detects that the disk is deleted?
> Well, the dirty pages belong to the file system, and so it needs to be
> up to the file system to clear out the dirty pages.  But I'll also
> what the right thing to do when a disk gets removed is not necessarily
> obvious.
Yes, I know that! If the block layer can find and clear these dirty 
pages in a
unified manner, there is no need to do this for each file system.

The subsequent solution is to declare the interface at the VFS layer, 
which is
implemented by each file system. When the block layer detects that the disk
is deleted, the block layer invokes the common interface at the VFS layer.
This also sounds good.
>
> For example, suppose some process has a file mmap'ed into its address
> space, and that file is on the disk which the user has rudely yanked
> out from their laptop; what is the right thing to do?  Do we kill the
> process?  Do we let the process write to the mmap'ed region, and
> silently let the modified data go *poof* when the process exits?  What
> if there is an executable file on the removable disk, and there are
> one or more processes running that executable when the device
> disappears?  Do we kill the process?  Do we let the process run unti
> it tries to access a page which hasn't been paged in and then kill the
> process?
>
> We should design a proper solution for What Should Happen when a
> removable disk gets removed unceremoniously without unmounting the
> file system first.  It's not just a matter of making some tests go
> green....
>
> 						- Ted
> 						
>
Yes, we need to consider a variety of scenarios, which is not a simple 
matter.
Thank you very much for your detailed explanation.

-- 
With Best Regards,
Baokun Li
.
