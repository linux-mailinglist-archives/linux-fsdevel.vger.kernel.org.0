Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02636734663
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jun 2023 15:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjFRN2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 09:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjFRN2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 09:28:16 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BB919C;
        Sun, 18 Jun 2023 06:28:13 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QkYZF70MSzLmjZ;
        Sun, 18 Jun 2023 21:26:13 +0800 (CST)
Received: from [10.67.109.150] (10.67.109.150) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 18 Jun 2023 21:28:08 +0800
Subject: Re: [PATCH v2] poll: Fix use-after-free in poll_freewait()
To:     Suren Baghdasaryan <surenb@google.com>,
        Eric Biggers <ebiggers@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20230614070733.113068-1-lujialin4@huawei.com>
 <20230614174004.GC1146@sol.localdomain>
 <CAJuCfpFROxDn-Yv48zKw5PuiLd_LQ5+b1Nt4+jEw8wHMWcRDWw@mail.gmail.com>
 <CAJuCfpGA4Zy-NAsoFrs7R6MJDO0rW1R2gXCzoVkkcsUzfeXbzA@mail.gmail.com>
From:   "lujialin (A)" <lujialin4@huawei.com>
Message-ID: <c83f2076-8dfa-7650-f3c6-bb6884a6729a@huawei.com>
Date:   Sun, 18 Jun 2023 21:28:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpGA4Zy-NAsoFrs7R6MJDO0rW1R2gXCzoVkkcsUzfeXbzA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.150]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Suren:

kernel config:
x86_64_defconfig
CONFIG_PSI=y
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_DEBUG_ON=y
CONFIG_KASAN=y
CONFIG_KASAN_INLINE=y

I make some change in code, in order to increase the recurrence probability.
diff --git a/fs/select.c b/fs/select.c
index 5edffee1162c..5ee5b74a8386 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -139,6 +139,7 @@ void poll_freewait(struct poll_wqueues *pwq)
  {
         struct poll_table_page * p = pwq->table;
         int i;
+       mdelay(50);
         for (i = 0; i < pwq->inline_index; i++)
                 free_poll_entry(pwq->inline_entries + i);
         while (p) {

Here is the simple repo test.sh:
#!/bin/bash

RESOURCE_TYPES=("cpu" "memory" "io" "irq")
#RESOURCE_TYPES=("cpu")
cgroup_num=50
test_dir=/sys/fs/cgroup/test

function restart_cgroup() {
         num=$(expr $RANDOM % $cgroup_num + 1)
         rmdir $test_dir/test_$num
         mkdir $test_dir/test_$num
}

function create_triggers() {
         num=$(expr $RANDOM % $cgroup_num + 1)
         random=$(expr $RANDOM % "${#RESOURCE_TYPES[@]}")
         psi_type="${RESOURCE_TYPES[${random}]}"
         ./psi_monitor $test_dir/test_$num $psi_type &
}

mkdir $test_dir
for i in $(seq 1 $cgroup_num)
do
         mkdir $test_dir/test_$i
done
for j in $(seq 1 100)
do
         restart_cgroup &
         create_triggers &
done

psi_monitor.c:
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <poll.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
         const char trig[] = "full 1000000 1000000";
         struct pollfd fds;
         char filename[100];

         sprintf(filename, "%s/%s.pressure", argv[1], argv[2]);

         fds.fd = open(filename, O_RDWR | O_NONBLOCK);
         if (fds.fd < 0) {
                 printf("%s open error: %s\n", filename,strerror(errno));
                 return 1;
         }
         fds.events = POLLPRI;
         if (write(fds.fd, trig, strlen(trig) + 1) < 0) {
                 printf("%s write error: %s\n",filename,strerror(errno));
                 return 1;
         }
         while (1) {
                 poll(&fds, 1, -1);
         }
         close(fds.fd);
         return 0;
}
Thanks,
Lu
在 2023/6/16 7:13, Suren Baghdasaryan 写道:
> On Wed, Jun 14, 2023 at 11:19 AM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Wed, Jun 14, 2023 at 10:40 AM Eric Biggers <ebiggers@kernel.org> wrote:
>>>
>>> On Wed, Jun 14, 2023 at 03:07:33PM +0800, Lu Jialin wrote:
>>>> We found a UAF bug in remove_wait_queue as follows:
>>>>
>>>> ==================================================================
>>>> BUG: KASAN: use-after-free in _raw_spin_lock_irqsave+0x71/0xe0
>>>> Write of size 4 at addr ffff8881150d7b28 by task psi_trigger/15306
>>>> Call Trace:
>>>>   dump_stack+0x9c/0xd3
>>>>   print_address_description.constprop.0+0x19/0x170
>>>>   __kasan_report.cold+0x6c/0x84
>>>>   kasan_report+0x3a/0x50
>>>>   check_memory_region+0xfd/0x1f0
>>>>   _raw_spin_lock_irqsave+0x71/0xe0
>>>>   remove_wait_queue+0x26/0xc0
>>>>   poll_freewait+0x6b/0x120
>>>>   do_sys_poll+0x305/0x400
>>>>   do_syscall_64+0x33/0x40
>>>>   entry_SYSCALL_64_after_hwframe+0x61/0xc6
>>>>
>>>> Allocated by task 15306:
>>>>   kasan_save_stack+0x1b/0x40
>>>>   __kasan_kmalloc.constprop.0+0xb5/0xe0
>>>>   psi_trigger_create.part.0+0xfc/0x450
>>>>   cgroup_pressure_write+0xfc/0x3b0
>>>>   cgroup_file_write+0x1b3/0x390
>>>>   kernfs_fop_write_iter+0x224/0x2e0
>>>>   new_sync_write+0x2ac/0x3a0
>>>>   vfs_write+0x365/0x430
>>>>   ksys_write+0xd5/0x1b0
>>>>   do_syscall_64+0x33/0x40
>>>>   entry_SYSCALL_64_after_hwframe+0x61/0xc6
>>>>
>>>> Freed by task 15850:
>>>>   kasan_save_stack+0x1b/0x40
>>>>   kasan_set_track+0x1c/0x30
>>>>   kasan_set_free_info+0x20/0x40
>>>>   __kasan_slab_free+0x151/0x180
>>>>   kfree+0xba/0x680
>>>>   cgroup_file_release+0x5c/0xe0
>>>>   kernfs_drain_open_files+0x122/0x1e0
>>>>   kernfs_drain+0xff/0x1e0
>>>>   __kernfs_remove.part.0+0x1d1/0x3b0
>>>>   kernfs_remove_by_name_ns+0x89/0xf0
>>>>   cgroup_addrm_files+0x393/0x3d0
>>>>   css_clear_dir+0x8f/0x120
>>>>   kill_css+0x41/0xd0
>>>>   cgroup_destroy_locked+0x166/0x300
>>>>   cgroup_rmdir+0x37/0x140
>>>>   kernfs_iop_rmdir+0xbb/0xf0
>>>>   vfs_rmdir.part.0+0xa5/0x230
>>>>   do_rmdir+0x2e0/0x320
>>>>   __x64_sys_unlinkat+0x99/0xc0
>>>>   do_syscall_64+0x33/0x40
>>>>   entry_SYSCALL_64_after_hwframe+0x61/0xc6
>>>> ==================================================================
>>>>
>>>> If using epoll(), wake_up_pollfree will empty waitqueue and set
>>>> wait_queue_head is NULL before free waitqueue of psi trigger. But is
>>>> doesn't work when using poll(), which will lead a UAF problem in
>>>> poll_freewait coms as following:
>>>>
>>>> (cgroup_rmdir)                      |
>>>> psi_trigger_destroy                 |
>>>>    wake_up_pollfree(&t->event_wait)  |
>>>>     synchronize_rcu();               |
>>>>      kfree(t)                        |
>>>>                                    |   (poll_freewait)
>>>>                                    |     free_poll_entry(pwq->inline_entries + i)
>>>>                                    |       remove_wait_queue(entry->wait_address)
>>>>                                    |         spin_lock_irqsave(&wq_head->lock)
>>>>
>>>> entry->wait_address in poll_freewait() is t->event_wait in cgroup_rmdir().
>>>> t->event_wait is free in psi_trigger_destroy before call poll_freewait(),
>>>> therefore wq_head in poll_freewait() has been already freed, which would
>>>> lead to a UAF.
> 
> Hi Lu,
> Could you please share your reproducer along with the kernel config
> you used? I'm trying to reproduce this UAF but every time I delete the
> cgroup being polled, poll() simply returns POLLERR.
> Thanks,
> Suren.
> 
>>>>
>>>> similar problem for epoll() has been fixed commit c2dbe32d5db5
>>>> ("sched/psi: Fix use-after-free in ep_remove_wait_queue()").
>>>> epoll wakeup function ep_poll_callback() will empty waitqueue and set
>>>> wait_queue_head is NULL when pollflags is POLLFREE and judge pwq->whead
>>>> is NULL or not before remove_wait_queue in ep_remove_wait_queue(),
>>>> which will fix the UAF bug in ep_remove_wait_queue.
>>>>
>>>> But poll wakeup function pollwake() doesn't do that. To fix the
>>>> problem, we empty waitqueue and set wait_address is NULL in pollwake() when
>>>> key is POLLFREE. otherwise in remove_wait_queue, which is similar to
>>>> epoll().
>>>>
>>>> Fixes: 0e94682b73bf ("psi: introduce psi monitor")
>>>> Suggested-by: Suren Baghdasaryan <surenb@google.com>
>>>> Link: https://lore.kernel.org/all/CAJuCfpEoCRHkJF-=1Go9E94wchB4BzwQ1E3vHGWxNe+tEmSJoA@mail.gmail.com/#t
>>>> Signed-off-by: Lu Jialin <lujialin4@huawei.com>
>>>> ---
>>>> v2: correct commit msg and title suggested by Suren Baghdasaryan
>>>> ---
>>>>   fs/select.c | 20 +++++++++++++++++++-
>>>>   1 file changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/select.c b/fs/select.c
>>>> index 0ee55af1a55c..e64c7b4e9959 100644
>>>> --- a/fs/select.c
>>>> +++ b/fs/select.c
>>>> @@ -132,7 +132,17 @@ EXPORT_SYMBOL(poll_initwait);
>>>>
>>>>   static void free_poll_entry(struct poll_table_entry *entry)
>>>>   {
>>>> -     remove_wait_queue(entry->wait_address, &entry->wait);
>>>> +     wait_queue_head_t *whead;
>>>> +
>>>> +     rcu_read_lock();
>>>> +     /* If it is cleared by POLLFREE, it should be rcu-safe.
>>>> +      * If we read NULL we need a barrier paired with smp_store_release()
>>>> +      * in pollwake().
>>>> +      */
>>>> +     whead = smp_load_acquire(&entry->wait_address);
>>>> +     if (whead)
>>>> +             remove_wait_queue(whead, &entry->wait);
>>>> +     rcu_read_unlock();
>>>>        fput(entry->filp);
>>>>   }
>>>>
>>>> @@ -215,6 +225,14 @@ static int pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *key
>>>>        entry = container_of(wait, struct poll_table_entry, wait);
>>>>        if (key && !(key_to_poll(key) & entry->key))
>>>>                return 0;
>>>> +     if (key_to_poll(key) & POLLFREE) {
>>>> +             list_del_init(&wait->entry);
>>>> +             /* wait_address !=NULL protects us from the race with
>>>> +              * poll_freewait().
>>>> +              */
>>>> +             smp_store_release(&entry->wait_address, NULL);
>>>> +             return 0;
>>>> +     }
>>>>        return __pollwake(wait, mode, sync, key);
>>>
>>> I don't understand why this patch is needed.
>>>
>>> The last time I looked at POLLFREE, it is only needed because of asynchronous
>>> polls.  See my explanation in the commit message of commit 50252e4b5e989ce6.
>>
>> Ah, I missed that. Thanks for the correction.
>>
>>>
>>> In summary, POLLFREE solves the problem of polled waitqueues whose lifetime is
>>> tied to the current task rather than to the file being polled.  Also refer to
>>> the comment above wake_up_pollfree(), which mentions this.
>>>
>>> fs/select.c is synchronous polling, not asynchronous.  Therefore, it should not
>>> need to handle POLLFREE.
>>>
>>> If there's actually a bug here, most likely it's a bug in psi_trigger_poll()
>>> where it is using a waitqueue whose lifetime is tied to neither the current task
>>> nor the file being polled.  That needs to be fixed.
>>
>> Yeah. We discussed this issue in
>> https://lore.kernel.org/all/CAJuCfpFb0J5ZwO6kncjRG0_4jQLXUy-_dicpH5uGiWP8aKYEJQ@mail.gmail.com
>> and the root cause is that cgroup_file_release() where
>> psi_trigger_destroy() is called is not tied to the cgroup file's real
>> lifetime (see my analysis here:
>> https://lore.kernel.org/all/CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com/#t).
>> I guess it's time to do a deeper surgery and figure out a way to call
>> psi_trigger_destroy() when the polled cgroup file is actually being
>> destroyed. I'll take a closer look into this later today.
>> A fix will likely require some cgroup or kernfs code changes, so
>> CC'ing Tejun for visibility.
>> Thanks,
>> Suren.
>>
>>>
>>> - Eric
> .
> 
