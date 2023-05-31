Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA8717C6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 11:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjEaJuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 05:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbjEaJuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 05:50:08 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F07E2;
        Wed, 31 May 2023 02:50:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QWPPD3w8fz9xqd6;
        Wed, 31 May 2023 17:39:44 +0800 (CST)
Received: from [10.206.134.65] (unknown [10.206.134.65])
        by APP1 (Coremail) with SMTP id LxC2BwCHA_8tGHdkKS_5Ag--.3134S2;
        Wed, 31 May 2023 10:49:44 +0100 (CET)
Message-ID: <1020d006-c698-aacc-bcc3-92e5b237ef91@huaweicloud.com>
Date:   Wed, 31 May 2023 11:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
To:     Paul Moore <paul@paul-moore.com>,
        syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        roberto.sassu@huawei.com, syzkaller-bugs@googlegroups.com,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org
References: <0000000000007bedb605f119ed9f@google.com>
 <00000000000000964605faf87416@google.com>
 <CAHC9VhTZ=Esk+JxgAjch2J44WuLixe-SZMXW2iGHpLdrdMKQ=g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHC9VhTZ=Esk+JxgAjch2J44WuLixe-SZMXW2iGHpLdrdMKQ=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHA_8tGHdkKS_5Ag--.3134S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyftry8Kw17XryDGry3urg_yoWrAr4UpF
        W8K3ZxKrnYyr1kKF4Iq3W5Ww10grZ3Cry7JryDKryq9anrZrnxtF4Iy34fCr4FkrZ7AFZx
        Jw1jy3yrAwnYqwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj43p9gABsp
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/5/2023 11:36 PM, Paul Moore wrote:
> On Fri, May 5, 2023 at 4:51 PM syzbot
> <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com> wrote:
>>
>> syzbot has bisected this issue to:
>>
>> commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
>> Author: Roberto Sassu <roberto.sassu@huawei.com>
>> Date:   Fri Mar 31 12:32:18 2023 +0000
>>
>>      reiserfs: Add security prefix to xattr name in reiserfs_security_write()
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14403182280000
>> start commit:   3c4aa4434377 Merge tag 'ceph-for-6.4-rc1' of https://githu..
>> git tree:       upstream
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16403182280000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12403182280000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
>> dashboard link: https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12442414280000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176a7318280000
>>
>> Reported-by: syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com
>> Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in reiserfs_security_write()")
>>
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> I don't think Roberto's patch identified above is the actual root
> cause of this problem as reiserfs_xattr_set_handle() is called in
> reiserfs_security_write() both before and after the patch.  However,
> due to some bad logic in reiserfs_security_write() which Roberto
> corrected, I'm thinking that it is possible this code is being
> exercised for the first time and syzbot is starting to trigger a
> locking issue in the reiserfs code ... ?

+ Jan, Jeff (which basically restructured the lock)

+ Petr, Ingo, Will

I involve the lockdep experts, to get a bit of help on this.

First of all, the lockdep warning is trivial to reproduce:

# dd if=/dev/zero of=reiserfs.img bs=1M count=100
# losetup -f --show reiserfs.img
/dev/loop0
# mkfs.reiserfs /dev/loop0
# mount /dev/loop0 /mnt/
# touch file0

In the testing system, Smack is the major LSM.

Ok, so the warning here is clear:

https://syzkaller.appspot.com/x/log.txt?x=12403182280000

However, I was looking if that can really happen. From this:

[   77.746561][ T5418] -> #1 (&sbi->lock){+.+.}-{3:3}:
[   77.753772][ T5418]        lock_acquire+0x23e/0x630
[   77.758792][ T5418]        __mutex_lock_common+0x1d8/0x2530
[   77.764504][ T5418]        mutex_lock_nested+0x1b/0x20
[   77.769868][ T5418]        reiserfs_write_lock+0x70/0xc0
[   77.775321][ T5418]        reiserfs_mkdir+0x321/0x870

I see that the lock is taken in reiserfs_write_lock(), while lockdep says:

[   77.710227][ T5418] but task is already holding lock:
[   77.717587][ T5418] ffff88807568d090 (&sbi->lock){+.+.}-{3:3}, at: 
reiserfs_write_lock_nested+0x4a/0xb0

which is in a different place, I believe here:

int reiserfs_paste_into_item(struct reiserfs_transaction_handle *th,
                              /* Path to the pasted item. */
[...]

         depth = reiserfs_write_unlock_nested(sb);
         dquot_free_space_nodirty(inode, pasted_size);
         reiserfs_write_lock_nested(sb, depth);
         return retval;
}

This is called by reiserfs_add_entry(), which is called by 
reiserfs_create() (it is in the lockdep trace). After returning to 
reiserfs_create(), d_instantiate_new() is called.

I don't know exactly, I take the part that the lock is held. But if it 
is held, how d_instantiate_new() can be executed in another task?

static int reiserfs_create(struct mnt_idmap *idmap, struct inode *dir,
                         struct dentry *dentry, umode_t mode, bool excl)
{

[...]

         reiserfs_write_lock(dir->i_sb);

         retval = journal_begin(&th, dir->i_sb, jbegin_count);

[...]

         d_instantiate_new(dentry, inode);
         retval = journal_end(&th);

out_failed:
         reiserfs_write_unlock(dir->i_sb);

If the lock is held, the scenario lockdep describes cannot happen. Any 
thoughts?

Thanks

Roberto

