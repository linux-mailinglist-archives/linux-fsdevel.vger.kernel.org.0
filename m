Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2462FB71F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 05:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbfISDgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 23:36:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728423AbfISDgp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 23:36:45 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 39758D7500C7014C7781;
        Thu, 19 Sep 2019 11:36:43 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Sep 2019
 11:36:37 +0800
Subject: Re: 266a9a8b41: WARNING:possible_recursive_locking_detected
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, <renxudong1@huawei.com>,
        Hou Tao <houtao1@huawei.com>, LKP <lkp@01.org>
References: <20190914161622.GS1131@ZenIV.linux.org.uk>
 <20190916020434.tutzwipgs4f6o3di@inn2.lkp.intel.com>
 <20190916025827.GY1131@ZenIV.linux.org.uk>
 <20190916030355.GZ1131@ZenIV.linux.org.uk>
 <CAHk-=wii2apAb9WHCaOt8vnQjk8yXAHnMEC6im0f0YiEF4PwOA@mail.gmail.com>
 <20190916171606.GA1131@ZenIV.linux.org.uk>
 <bd707e64-9650-e9ed-a820-e2cabd02eaf8@huawei.com>
 <20190917120117.GG1131@ZenIV.linux.org.uk>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <c79495de-9f51-4e9b-97e1-0f98a147cd8a@huawei.com>
Date:   Thu, 19 Sep 2019 11:36:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190917120117.GG1131@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2019/9/17 20:01, Al Viro wrote:
> On Tue, Sep 17, 2019 at 03:03:33PM +0800, zhengbin (A) wrote:
>> On 2019/9/17 1:16, Al Viro wrote:
>>> On Sun, Sep 15, 2019 at 08:44:05PM -0700, Linus Torvalds wrote:
>>>> On Sun, Sep 15, 2019 at 8:04 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>>> Perhaps lockref_get_nested(struct lockref *lockref, unsigned int subclass)?
>>>>> With s/spin_lock/spin_lock_nested/ in the body...
>>>> Sure. Under the usual CONFIG_DEBUG_LOCK_ALLOC, with the non-debug case
>>>> just turning into a regular lockref_get().
>>>>
>>>> Sounds fine to me.
>>> Done and force-pushed into vfs.git#fixes
>> + if (file->f_pos > 2) {
>> + p = scan_positives(cursor, &dentry->d_subdirs,
>> + file->f_pos - 2, &to);
>> + spin_lock(&dentry->d_lock);
>> + list_move(&cursor->d_child, p);
>> + spin_unlock(&dentry->d_lock);
>> + } else {
>> + spin_lock(&dentry->d_lock);
>> + list_del_init(&cursor->d_child);
>> + spin_unlock(&dentry->d_lock);
>> }
>> +
>> + dput(to);
>> dput(to) should be in if if (file->f_pos > 2)? cause we dget(to) in scan_positives
> dput(NULL) is a no-op

+    spin_unlock(&dentry->d_lock);
+    dput(*res);
+    *res = found;
+    return p;

dput(*res) should be removed?

>
> .
>

