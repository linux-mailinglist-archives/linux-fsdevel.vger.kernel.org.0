Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE2BFC5CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 13:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfKNMBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 07:01:43 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfKNMBn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:01:43 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 50BCC23F07ECCC0C5F4B;
        Thu, 14 Nov 2019 20:01:40 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.224) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 20:01:36 +0800
Subject: Re: [PATCH] jffs2: Fix mounting under new mount API
To:     Han Xu <xhnjupt@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Richard Weinberger <richard@nod.at>
CC:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>
References: <156950767876.30879.17024491763471689960.stgit@warthog.procyon.org.uk>
 <f34aaf61-955a-7867-ef93-f22d3d8732c3@cogentembedded.com>
 <CA+EcR22=7F7X-9qYXb94dAp6w0_3FoKJPMRhFht+VWgKonoing@mail.gmail.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <2758feea-8d6e-c690-5cac-d42213f2024b@huawei.com>
Date:   Thu, 14 Nov 2019 20:01:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+EcR22=7F7X-9qYXb94dAp6w0_3FoKJPMRhFht+VWgKonoing@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2019/11/14 4:38, Han Xu wrote:
> Tested the JFFS2 on 5.4 kernel as the instruction said, still got some
> errors, any ideas?
> 

> 
> With the patch,
> 
> root@imx8mmevk:~# cat /proc/mtd
> dev:    size   erasesize  name
> mtd0: 00400000 00020000 "mtdram test device"
> mtd1: 04000000 00020000 "5d120000.spi"
> root@imx8mmevk:~# mtd_debug info /dev/mtd0
> mtd.type = MTD_RAM
> mtd.flags = MTD_CAP_RAM
> mtd.size = 4194304 (4M)
> mtd.erasesize = 131072 (128K)
> mtd.writesize = 1
> mtd.oobsize = 0
> regions = 0
> 
> root@imx8mmevk:~# flash_erase /dev/mtd0 0 0
> Erasing 128 Kibyte @ 3e0000 -- 100 % complete
> root@imx8mmevk:~# mount -t jffs2 /dev/mtdblock0 test_dir/
> root@imx8mmevk:~# mount
> /dev/mtdblock0 on /home/root/test_dir type jffs2 (rw,relatime)
> 
> BUT, it's not writable.

You should revert the following commit to make it work:

commit f2538f999345405f7d2e1194c0c8efa4e11f7b3a
Author: Jia-Ju Bai <baijiaju1990@gmail.com>
Date:   Wed Jul 24 10:46:58 2019 +0800

    jffs2: Fix possible null-pointer dereferences in jffs2_add_frag_to_fragtree()

The revert needs to get into v5.4. Maybe Richard has forget about it ?

Regards,
Tao

> 
> root@imx8mmevk:~# cp test_file test_dir/
> cp: error writing 'test_dir/test_file': Invalid argument
> 
> root@imx8mmevk:~# dd if=/dev/urandom of=test_dir/test_file bs=1k count=1
> dd: error writing 'test_dir/test_file': Invalid argument
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0.000855156 s, 0.0 kB/s
> 
> 
> On Fri, Sep 27, 2019 at 3:38 AM Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
>>
>> Hello!
>>
>> On 26.09.2019 17:21, David Howells wrote:
>>
>>> The mounting of jffs2 is broken due to the changes from the new mount API
>>> because it specifies a "source" operation, but then doesn't actually
>>> process it.  But because it specified it, it doesn't return -ENOPARAM and
>>
>>     What specified what? Too many "it"'s to figure that out. :-)
>>
>>> the caller doesn't process it either and the source gets lost.
>>>
>>> Fix this by simply removing the source parameter from jffs2 and letting the
>>> VFS deal with it in the default manner.
>>>
>>> To test it, enable CONFIG_MTD_MTDRAM and allow the default size and erase
>>> block size parameters, then try and mount the /dev/mtdblock<N> file that
>>> that creates as jffs2.  No need to initialise it.
>>
>>     One "that" should be enough. :-)
>>
>>> Fixes: ec10a24f10c8 ("vfs: Convert jffs2 to use the new mount API")
>>> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>> cc: David Woodhouse <dwmw2@infradead.org>
>>> cc: Richard Weinberger <richard@nod.at>
>>> cc: linux-mtd@lists.infradead.org
>> [...]
>>
>> MBR, Sergei
>>
>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
> 
> 

