Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAC1A1A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 14:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfH2Mmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 08:42:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54922 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfH2Mmf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:42:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9F9C75D8F33C676BBDFA;
        Thu, 29 Aug 2019 20:42:33 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.203) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Thu, 29 Aug 2019
 20:42:30 +0800
To:     <keescook@chromium.org>, <kernel-hardening@lists.openwall.com>,
        <linux-fsdevel@vger.kernel.org>
From:   Jason Yan <yanaijie@huawei.com>
Subject: CONFIG_HARDENED_USERCOPY
Message-ID: <6e02a518-fea9-19fe-dca7-0323a576750d@huawei.com>
Date:   Thu, 29 Aug 2019 20:42:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.203]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees,

We found an issue of kernel bug related to HARDENED_USERCOPY.
When copying an IO buffer to userspace, HARDENED_USERCOPY thought it is
illegal to copy this buffer. Actually this is because this IO buffer was
merged from two bio vectors, and the two bio vectors buffer was 
allocated with kmalloc() in the filesystem layer.

The block layer __blk_segment_map_sg() do the merge if two bio vectors 
is continuous in physical.

/* Default implementation of BIOVEC_PHYS_MERGEABLE */
#define __BIOVEC_PHYS_MERGEABLE(vec1, vec2)	\
	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))

After the merge, driver do not know the buffer is consist of two slab 
objects. It copies this buffer at once with the total length.
Obviously this cannot through the check of HARDENED_USERCOPY.

So how can we do in this situation?
1.Shutdown HARDENED_USERCOPY ?
2.Tell filesystems not to use kmalloc to send IOs down?
3.Tell the driver to use _copy_to_user instead of copy_to_user ?

Thoughts? suggestions?

crash> bt
PID: 38986  TASK: ffff803dc0b9ae80  CPU: 12  COMMAND: "scsi_init_0"
  #0 [ffff00001cbfb470] machine_kexec at ffff0000080a2724
  #1 [ffff00001cbfb4d0] __crash_kexec at ffff0000081b7b74
  #2 [ffff00001cbfb660] panic at ffff0000080ee8cc
  #3 [ffff00001cbfb740] die at ffff00000808f6ac
  #4 [ffff00001cbfb790] bug_handler at ffff00000808f744
  #5 [ffff00001cbfb7c0] brk_handler at ffff000008085d1c
  #6 [ffff00001cbfb7e0] do_debug_exception at ffff000008081194
  #7 [ffff00001cbfb9f0] el1_dbg at ffff00000808332c
      PC: ffff0000083395d8  [usercopy_abort+136]
      LR: ffff0000083395d8  [usercopy_abort+136]
      SP: ffff00001cbfba00  PSTATE: 40000005
     X29: ffff00001cbfba10  X28: 0000000000000000  X27: ffff80244802e000
     X26: 0000000000000400  X25: 0000000000000000  X24: ffff80380625fa00
     X23: 0000000000000001  X22: 0000000000000400  X21: 0000000000000000
     X20: ffff000008c95698  X19: ffff000008c99970  X18: ffffffffffffffff
     X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000001
     X14: ffff000008aa7e48  X13: 0000000000000000  X12: 0000000000000000
     X11: 00000000ffffffff  X10: 0000000000000010   X9: ffff000008ef1018
      X8: 0000000000000854   X7: 0000000000000003   X6: ffff803ffbf8b3c8
      X5: ffff803ffbf8b3c8   X4: 0000000000000000   X3: ffff803ffbf93b08
      X2: 902990500743b200   X1: 0000000000000000   X0: 0000000000000067
  #8 [ffff00001cbfba10] usercopy_abort at ffff0000083395d4
  #9 [ffff00001cbfba50] __check_heap_object at ffff000008310910
#10 [ffff00001cbfba80] __check_object_size at ffff000008339770
#11 [ffff00001cbfbac0] vsc_xfer_data at ffff000000ca9bac [vsc]
#12 [ffff00001cbfbb60] vsc_scsi_cmd_data at ffff000000cab368 [vsc]
#13 [ffff00001cbfbc00] vsc_get_msg_unlock at ffff000000cad198 [vsc]
#14 [ffff00001cbfbc90] vsc_get_msg at ffff000000cad6f0 [vsc]
#15 [ffff00001cbfbcd0] vsc_dev_read at ffff000000ca2688 [vsc]
#16 [ffff00001cbfbd00] __vfs_read at ffff00000833f234
#17 [ffff00001cbfbdb0] vfs_read at ffff00000833f3f0
#18 [ffff00001cbfbdf0] ksys_read at ffff00000833fb50
#19 [ffff00001cbfbe40] __arm64_sys_read at ffff00000833fbe0
#20 [ffff00001cbfbe60] el0_svc_common at ffff000008097b54
#21 [ffff00001cbfbea0] el0_svc_handler at ffff000008097c44
#22 [ffff00001cbfbff0] el0_svc at ffff000008084144
      PC: 000040003a653548   LR: 000040003a653530   SP: 00004001f1087ad0
     X29: 00004001f1087ad0  X28: 000040002b1f7000  X27: 0000400034c5b958
     X26: 00004001042f7d58  X25: 0000000000000004  X24: 0000000000000000
     X23: 00004001f1087c38  X22: 00004001f1087c58  X21: 00004001f1087d38
     X20: 0000000000000400  X19: 000000000000001c  X18: 0000000000000000
     X17: 000040003a6534d8  X16: 000040002b1ecc48  X15: 0000000000001268
     X14: 000000000000003b  X13: 0000000000000400  X12: 00004000f4291000
     X11: 0000000000000400  X10: 0000000100000010   X9: 0000001000000002
      X8: 000000000000003f   X7: 004cf56500000000   X6: 0000000000000000
      X5: 00004001f1088ac0   X4: 00000000ffffffbb   X3: 0000000000000000
      X2: 0000000000000400   X1: 00004001f1087d38   X0: 000000000000001c
     ORIG_X0: 000000000000001c  SYSCALLNO: 3f  PSTATE: 80000000
crash>

   sc_data_direction = DMA_TO_DEVICE,
   cmnd = 0xffff802187d69d38 "*",
   sdb = {
     table = {
       sgl = 0xffff80380625fa00,
       nents = 1,
       orig_nents = 2
     },
     length = 1024,
     resid = 0
   },

crash> struct bio_vec 0xffff80217ce4a2b0
struct bio_vec {
   bv_page = 0xffff7e0091200b80,
   bv_len = 512,
   bv_offset = 0
}
crash> struct bio_vec 0xffff80217ce4a8b0
struct bio_vec {
   bv_page = 0xffff7e0091200b80,
   bv_len = 512,
   bv_offset = 512
}


