Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D3D940F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 16:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405021AbfJPOjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 10:39:15 -0400
Received: from sandeen.net ([63.231.237.45]:60322 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404529AbfJPOjP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:39:15 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 4E8D82B37;
        Wed, 16 Oct 2019 09:38:36 -0500 (CDT)
Subject: Re: [PATCH V2] fs: avoid softlockups in s_inodes iterators
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <a26fae1d-a741-6eb1-b460-968a3b97e238@redhat.com>
 <20191015073740.GA21550@quack2.suse.cz>
 <c3c6a9df-c4f5-7692-d8c0-3f6605a74ef4@sandeen.net>
 <20191016094237.GE30337@quack2.suse.cz>
 <3a175c93-d7b2-5afb-fc2c-69951eb17838@sandeen.net>
 <20191016134945.GD7198@quack2.suse.cz>
From:   Eric Sandeen <sandeen@sandeen.net>
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <6ea5f881-7637-5b90-a0d4-499f6ffbfa90@sandeen.net>
Date:   Wed, 16 Oct 2019 09:39:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191016134945.GD7198@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/16/19 8:49 AM, Jan Kara wrote:
> On Wed 16-10-19 08:23:51, Eric Sandeen wrote:
>> On 10/16/19 4:42 AM, Jan Kara wrote:
>>> On Tue 15-10-19 21:36:08, Eric Sandeen wrote:
>>>> On 10/15/19 2:37 AM, Jan Kara wrote:
>>>>> On Mon 14-10-19 16:30:24, Eric Sandeen wrote:
>>>>>> Anything that walks all inodes on sb->s_inodes list without rescheduling
>>>>>> risks softlockups.
>>>>>>
>>>>>> Previous efforts were made in 2 functions, see:
>>>>>>
>>>>>> c27d82f fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
>>>>>> ac05fbb inode: don't softlockup when evicting inodes
>>>>>>
>>>>>> but there hasn't been an audit of all walkers, so do that now.  This
>>>>>> also consistently moves the cond_resched() calls to the bottom of each
>>>>>> loop in cases where it already exists.
>>>>>>
>>>>>> One loop remains: remove_dquot_ref(), because I'm not quite sure how
>>>>>> to deal with that one w/o taking the i_lock.
>>>>>>
>>>>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>>>>
>>>>> Thanks Eric. The patch looks good to me. You can add:
>>>>>
>>>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>>>
>>>> thanks
>>>>
>>>>> BTW, I suppose you need to add Al to pickup the patch?
>>>>
>>>> Yeah (cc'd now)
>>>>
>>>> But it was just pointed out to me that if/when the majority of inodes
>>>> at umount time have i_count == 0, we'll never hit the resched in 
>>>> fsnotify_unmount_inodes() and may still have an issue ...
>>>
>>> Yeah, that's a good point. So that loop will need some further tweaking
>>> (like doing iget-iput dance in need_resched() case like in some other
>>> places).
>>
>> Well, it's already got an iget/iput for anything with i_count > 0.  But
>> as the comment says (and I think it's right...) doing an iget/iput
>> on i_count == 0 inodes at this point would be without SB_ACTIVE and the final
>> iput here would actually start evicting inodes in /this/ loop, right?
> 
> Yes, it would but since this is just before calling evict_inodes(), I have
> currently hard time remembering why evicting inodes like that would be an
> issue.

Probably just weird to effectively evict all inodes prior to evict_inodes() ;)

>> I think we could (ab)use the lru list to construct a "dispose" list for
>> fsnotify processing as was done in evict_inodes...

[narrator: Eric's idea here is dumb and it won't work]

>> or maybe the two should be merged, and fsnotify watches could be handled
>> directly in evict_inodes.  But that doesn't feel quite right.
> 
> Merging the two would be possible (and faster!) as well but I agree it
> feels a bit dirty :)

It's starting to look like maybe the only option...

I'll see if Al is willing to merge this patch as is for the simple "schedule
the big loops" and see about a 2nd patch on top to do more surgery for this
case.

Thanks,
-Eric

> 								Honza
> 
