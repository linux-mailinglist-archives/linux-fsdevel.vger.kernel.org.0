Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A4B8E1D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 02:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfHOAaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 20:30:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57456 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbfHOAaz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:30:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 98BA4DA33EF7C6F0B2D4;
        Thu, 15 Aug 2019 08:30:51 +0800 (CST)
Received: from [127.0.0.1] (10.133.208.128) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 15 Aug 2019
 08:30:43 +0800
To:     <linux-fsdevel@vger.kernel.org>
CC:     "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        piaojun <piaojun@huawei.com>
From:   wangyan <wangyan122@huawei.com>
Subject: [QUESTION] A performance problem for buffer write compared with 9p
Message-ID: <5abd7616-5351-761c-0c14-21d511251006@huawei.com>
Date:   Thu, 15 Aug 2019 08:30:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.208.128]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I met a performance problem when I tested buffer write compared with 9p.

Guest configuration:
     Kernel: https://github.com/rhvgoyal/linux/tree/virtio-fs-dev-5.1
     2vCPU
     8GB RAM
Host configuration:
     Intel(R) Xeon(R) CPU E5-2620 v2 @ 2.10GHz
     128GB RAM
     Linux 3.10.0
     Qemu: https://gitlab.com/virtio-fs/qemu/tree/virtio-fs-dev
     EXT4 + ramdisk for shared folder

------------------------------------------------------------------------

For virtiofs:
virtiofsd cmd:
     ./virtiofsd -o vhost_user_socket=/tmp/vhostqemu -o 
source=/mnt/share/ -o cache=always -o writeback
mount cmd:
     mount -t virtio_fs myfs /mnt/virtiofs -o 
rootmode=040000,user_id=0,group_id=0

For 9p:
mount cmd:
     mount -t 9p -o 
trans=virtio,version=9p2000.L,rw,dirsync,nodev,msize=1000000000,cache=fscache 
sharedir /mnt/virtiofs/

------------------------------------------------------------------------

Compared with 9p, the test result:
1. Latency
     Test model：
         fio -filename=/mnt/virtiofs/test -rw=write -bs=4K -size=1G 
-iodepth=1 \
             -ioengine=psync -numjobs=1 -group_reporting -name=4K 
-time_based -runtime=30

     virtiofs: avg-lat is 6.37 usec
         4K: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=psync, 
iodepth=1
         fio-2.13
         Starting 1 process
         Jobs: 1 (f=1): [W(1)] [100.0% done] [0KB/471.9MB/0KB /s] 
[0/121K/0 iops] [eta 00m:00s]
         4K: (groupid=0, jobs=1): err= 0: pid=5558: Fri Aug  9 09:21:13 2019
           write: io=13758MB, bw=469576KB/s, iops=117394, runt= 30001msec
             clat (usec): min=2, max=10316, avg= 5.75, stdev=81.80
              lat (usec): min=3, max=10317, avg= 6.37, stdev=81.80

     9p: avg-lat is 3.94 usec
         4K: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=psync, 
iodepth=1
         fio-2.13
         Starting 1 process
         Jobs: 1 (f=1): [W(1)] [100.0% done] [0KB/634.2MB/0KB /s] 
[0/162K/0 iops] [eta 00m:00s]
         4K: (groupid=0, jobs=1): err= 0: pid=5873: Fri Aug  9 09:53:46 2019
           write: io=19700MB, bw=672414KB/s, iops=168103, runt= 30001msec
             clat (usec): min=2, max=632, avg= 3.34, stdev= 3.77
              lat (usec): min=2, max=633, avg= 3.94, stdev= 3.82


2. Bandwidth
     Test model:
         fio -filename=/mnt/virtiofs/test -rw=write -bs=1M -size=1G 
-iodepth=1 \
             -ioengine=psync -numjobs=1 -group_reporting -name=1M 
-time_based -runtime=30

     virtiofs: bandwidth is 718961KB/s
         1M: (g=0): rw=write, bs=1M-1M/1M-1M/1M-1M, ioengine=psync, 
iodepth=1
         fio-2.13
         Starting 1 process
         Jobs: 1 (f=1): [W(1)] [100.0% done] [0KB/753.8MB/0KB /s] 
[0/753/0 iops] [eta 00m:00s]
         1M: (groupid=0, jobs=1): err= 0: pid=5648: Fri Aug  9 09:24:36 2019
             write: io=21064MB, bw=718961KB/s, iops=702, runt= 30001msec
              clat (usec): min=390, max=11127, avg=1361.41, stdev=1551.50
               lat (usec): min=432, max=11170, avg=1414.72, stdev=1553.28

     9p: bandwidth is 2305.5MB/s
         1M: (g=0): rw=write, bs=1M-1M/1M-1M/1M-1M, ioengine=psync, 
iodepth=1
         fio-2.13
         Starting 1 process
         Jobs: 1 (f=1): [W(1)] [100.0% done] [0KB/2406MB/0KB /s] 
[0/2406/0 iops] [eta 00m:00s]
         1M: (groupid=0, jobs=1): err= 0: pid=5907: Fri Aug  9 09:55:14 2019
           write: io=69166MB, bw=2305.5MB/s, iops=2305, runt= 30001msec
             clat (usec): min=287, max=17678, avg=352.00, stdev=503.43
              lat (usec): min=330, max=17721, avg=402.76, stdev=503.41

9p has a lower latency and higher bandwidth than virtiofs.

------------------------------------------------------------------------ 


I found that the judgement statement 'if (!TestSetPageDirty(page))' always
true in function '__set_page_dirty_nobuffers', it will waste much time
to mark inode dirty, no one page is dirty when write it the second time.
The buffer write stack:
     fuse_file_write_iter
       ->fuse_cache_write_iter
         ->generic_file_write_iter
           ->__generic_file_write_iter
             ->generic_perform_write
               ->fuse_write_end
                 ->set_page_dirty
                   ->__set_page_dirty_nobuffers

The reason for 'if (!TestSetPageDirty(page))' always true may be the pdflush
process will clean the page's dirty flags in clear_page_dirty_for_io(),
and call fuse_writepages_send() to flush all pages to the disk of the host.
So when the page is written the second time, it always not dirty.
The pdflush stack for fuse:
     pdflush
       ->...
         ->do_writepages
           ->fuse_writepages
             ->write_cache_pages         // will clear all page's dirty 
flags
               ->clear_page_dirty_for_io // clear page's dirty flags
             ->fuse_writepages_send      // write all pages to the host, 
but don't wait the result
Why not wait for getting the result of writing back pages to the host
before cleaning all page's dirty flags?

As for 9p, pdflush will call clear_page_dirty_for_io() to clean the page's
dirty flags. Then call p9_client_write() to write the page to the host,
waiting for the result, and then flush the next page. In this case, buffer
write of 9p will hit the dirty page many times before it is being write
back to the host by pdflush process.
The pdflush stack for 9p:
     pdflush
       ->...
         ->do_writepages
           ->generic_writepages
             ->write_cache_pages
               ->clear_page_dirty_for_io // clear page's dirty flags
               ->__writepage
                 ->v9fs_vfs_writepage
                   ->v9fs_vfs_writepage_locked
                     ->p9_client_write   // it will get the writing back 
page's result


According to the test result, is the handling method of 9p for page writing
back more reasonable than virtiofs?

Thanks,
Yan Wang

