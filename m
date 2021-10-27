Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D6143C0E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 05:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbhJ0DpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 23:45:20 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53151 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236344AbhJ0DpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 23:45:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Utq-wl1_1635306172;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Utq-wl1_1635306172)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Oct 2021 11:42:53 +0800
Subject: Re: [PATCH v5 0/5] fuse,virtiofs: support per-file DAX
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
 <YUzOADZvjv7IczrJ@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <d2a54a62-d6dc-0e41-694d-7a5f574f0f32@linux.alibaba.com>
Date:   Wed, 27 Oct 2021 11:42:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUzOADZvjv7IczrJ@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Sorry for the late reply, as your previous reply was moved to junk box
by the algorithm...

On 9/24/21 2:57 AM, Vivek Goyal wrote:
> On Thu, Sep 23, 2021 at 05:25:21PM +0800, Jeffle Xu wrote:
>> This patchset adds support of per-file DAX for virtiofs, which is
>> inspired by Ira Weiny's work on ext4[1] and xfs[2].
>>
>> Any comment is welcome.
>>
>> [1] commit 9cb20f94afcd ("fs/ext4: Make DAX mount option a tri-state")
>> [2] commit 02beb2686ff9 ("fs/xfs: Make DAX mount option a tri-state")
>>
>>
>> [Purpose]
>> DAX may be limited in some specific situation. When the number of usable
>> DAX windows is under watermark, the recalim routine will be triggered to
>> reclaim some DAX windows. It may have a negative impact on the
>> performance, since some processes may need to wait for DAX windows to be
>> recalimed and reused then. To mitigate the performance degradation, the
>> overall DAX window need to be expanded larger.
>>
>> However, simply expanding the DAX window may not be a good deal in some
>> scenario. To maintain one DAX window chunk (i.e., 2MB in size), 32KB
>> (512 * 64 bytes) memory footprint will be consumed for page descriptors
>> inside guest, which is greater than the memory footprint if it uses
>> guest page cache when DAX disabled. Thus it'd better disable DAX for
>> those files smaller than 32KB, to reduce the demand for DAX window and
>> thus avoid the unworthy memory overhead.
>>
>> Per-file DAX feature is introduced to address this issue, by offering a
>> finer grained control for dax to users, trying to achieve a balance
>> between performance and memory overhead.
>>
>>
>> [Note]
>> When the per-file DAX hint changes while the file is still *opened*, it
>> is quite complicated and maybe fragile to dynamically change the DAX
>> state, since dynamic switching needs to switch a_ops atomiclly. Ira
>> Weiny had ever implemented a so called i_aops_sem lock [3] but
>> eventually gave up since the complexity of the implementation [4][5][6][7].
>>
>> Hence mark the inode and corresponding dentries as DONE_CACHE once the
>> per-file DAX hint changes, so that the inode instance will be evicted
>> and freed as soon as possible once the file is closed and the last
>> reference to the inode is put. And then when the file gets reopened next
>> time, the new instantiated inode will reflect the new DAX state.
> 
> If we don't cache inode (if no fd is open), will it not have negative
> performance impact. When we cache inodes, we also have all the dax
> mappings cached as well. So if a process opens the same file again,
> it gets all the mappings already in place and it does not have
> to call FUSE_SETUPMAPPING again.
> 

What does 'all the dax mappings cached' mean when 'we cache inodes'?

If the per-file DAX hint indeed changes for a large sized file, with
quite many page caches or DAX mapping already in the address space, then
marking it DONT_CACHE means evicting the inode as soon as possible,
which means flushing the page caches or removing all DAX mappings. When
the inode is reopened next time, page cache is re-instantiated or
FUSE_SETUPMAPPING is called again. Then the negative performance impact
indeed exist in this case.

But this performance impact only exist when the per-file DAX hint
changes halfway, that is, the hint suddenly changes after the virtiofs
has already mounted in the guest.



-- 
Thanks,
Jeffle
