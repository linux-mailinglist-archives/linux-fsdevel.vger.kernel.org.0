Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA29D9579
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393481AbfJPP0S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 11:26:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731357AbfJPP0S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:26:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7550D81DE0;
        Wed, 16 Oct 2019 15:26:17 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16CE11001B0B;
        Wed, 16 Oct 2019 15:26:17 +0000 (UTC)
Subject: Re: [PATCH V2] fs: avoid softlockups in s_inodes iterators
To:     Eric Sandeen <sandeen@sandeen.net>, Jan Kara <jack@suse.cz>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <a26fae1d-a741-6eb1-b460-968a3b97e238@redhat.com>
 <20191015073740.GA21550@quack2.suse.cz>
 <c3c6a9df-c4f5-7692-d8c0-3f6605a74ef4@sandeen.net>
 <20191016094237.GE30337@quack2.suse.cz>
 <3a175c93-d7b2-5afb-fc2c-69951eb17838@sandeen.net>
 <20191016134945.GD7198@quack2.suse.cz>
 <6ea5f881-7637-5b90-a0d4-499f6ffbfa90@sandeen.net>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <9a1fc48d-807d-ecd2-5f84-35887c3d74f7@redhat.com>
Date:   Wed, 16 Oct 2019 10:26:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <6ea5f881-7637-5b90-a0d4-499f6ffbfa90@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 16 Oct 2019 15:26:17 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/16/19 9:39 AM, Eric Sandeen wrote:
> On 10/16/19 8:49 AM, Jan Kara wrote:
>> On Wed 16-10-19 08:23:51, Eric Sandeen wrote:
>>> On 10/16/19 4:42 AM, Jan Kara wrote:
>>>> On Tue 15-10-19 21:36:08, Eric Sandeen wrote:
>>>>> On 10/15/19 2:37 AM, Jan Kara wrote:
>>>>>> On Mon 14-10-19 16:30:24, Eric Sandeen wrote:
>>>>>>> Anything that walks all inodes on sb->s_inodes list without rescheduling
>>>>>>> risks softlockups.
>>>>>>>
>>>>>>> Previous efforts were made in 2 functions, see:
>>>>>>>
>>>>>>> c27d82f fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
>>>>>>> ac05fbb inode: don't softlockup when evicting inodes
>>>>>>>
>>>>>>> but there hasn't been an audit of all walkers, so do that now.  This
>>>>>>> also consistently moves the cond_resched() calls to the bottom of each
>>>>>>> loop in cases where it already exists.
>>>>>>>
>>>>>>> One loop remains: remove_dquot_ref(), because I'm not quite sure how
>>>>>>> to deal with that one w/o taking the i_lock.
>>>>>>>
>>>>>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>>>>>
>>>>>> Thanks Eric. The patch looks good to me. You can add:
>>>>>>
>>>>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>>>>
>>>>> thanks
>>>>>
>>>>>> BTW, I suppose you need to add Al to pickup the patch?
>>>>>
>>>>> Yeah (cc'd now)
>>>>>
>>>>> But it was just pointed out to me that if/when the majority of inodes
>>>>> at umount time have i_count == 0, we'll never hit the resched in 
>>>>> fsnotify_unmount_inodes() and may still have an issue ...
>>>>
>>>> Yeah, that's a good point. So that loop will need some further tweaking
>>>> (like doing iget-iput dance in need_resched() case like in some other
>>>> places).
>>>
>>> Well, it's already got an iget/iput for anything with i_count > 0.  But
>>> as the comment says (and I think it's right...) doing an iget/iput
>>> on i_count == 0 inodes at this point would be without SB_ACTIVE and the final
>>> iput here would actually start evicting inodes in /this/ loop, right?
>>
>> Yes, it would but since this is just before calling evict_inodes(), I have
>> currently hard time remembering why evicting inodes like that would be an
>> issue.
> 
> Probably just weird to effectively evict all inodes prior to evict_inodes() ;)
> 
>>> I think we could (ab)use the lru list to construct a "dispose" list for
>>> fsnotify processing as was done in evict_inodes...
> 
> [narrator: Eric's idea here is dumb and it won't work]
> 
>>> or maybe the two should be merged, and fsnotify watches could be handled
>>> directly in evict_inodes.  But that doesn't feel quite right.
>>
>> Merging the two would be possible (and faster!) as well but I agree it
>> feels a bit dirty :)
> 
> It's starting to look like maybe the only option...
> 
> I'll see if Al is willing to merge this patch as is for the simple "schedule
> the big loops" and see about a 2nd patch on top to do more surgery for this
> case.

Sorry for thinking out loud in public but I'm not too familiar with fsnotify, so
I'm being timid.  However, since fsnotify_sb_delete() and evict_inodes() are working
on orthogonal sets of inodes (fsnotify_sb_delete only cares about nonzero refcount,
and evict_inodes only cares about zero refcount), I think we can just swap the order
of the calls.  The fsnotify call will then have a much smaller list to walk
(any refcounted inodes) as well.

I'll try to give this a test.

diff --git a/fs/super.c b/fs/super.c
index cfadab2cbf35..cd352530eca9 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -448,10 +448,12 @@ void generic_shutdown_super(struct super_block *sb)
 		sync_filesystem(sb);
 		sb->s_flags &= ~SB_ACTIVE;
 
-		fsnotify_sb_delete(sb);
 		cgroup_writeback_umount();
 
+		/* evict all inodes with zero refcount */
 		evict_inodes(sb);
+		/* only nonzero refcount inodes can have marks */
+		fsnotify_sb_delete(sb);
 
 		if (sb->s_dio_done_wq) {
 			destroy_workqueue(sb->s_dio_done_wq);


