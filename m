Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20974563AC9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 22:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiGAUHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiGAUG7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:06:59 -0400
Received: from mail.yonan.net (mail.yonan.net [54.244.116.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72AB4D4C7
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 13:06:58 -0700 (PDT)
Received: from [10.10.0.40] (unknown [76.130.91.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.yonan.net (Postfix) with ESMTPSA id E6B543E947;
        Fri,  1 Jul 2022 20:06:57 +0000 (UTC)
Message-ID: <1b255113-85bf-f85f-848d-a990a4f17051@openvpn.net>
Date:   Fri, 1 Jul 2022 14:06:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] namei: implemented RENAME_NEWER_MTIME flag for
 renameat2() conditional replace
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <a4ea9789-6126-e058-8f55-6dfc8a3f30c3@openvpn.net>
 <20220701092326.1845210-1-james@openvpn.net>
 <CAOQ4uxhqVF8BTDdFMFaVZZ+yhz1gy4VJdtkmjpDM6-dqcexLxw@mail.gmail.com>
From:   James Yonan <james@openvpn.net>
In-Reply-To: <CAOQ4uxhqVF8BTDdFMFaVZZ+yhz1gy4VJdtkmjpDM6-dqcexLxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/1/22 04:34, Amir Goldstein wrote:
>> @@ -4685,11 +4686,22 @@ int vfs_rename(struct renamedata *rd)
>>
>>          take_dentry_name_snapshot(&old_name, old_dentry);
>>          dget(new_dentry);
>> -       if (!is_dir || (flags & RENAME_EXCHANGE))
>> +       if (!is_dir || (flags & (RENAME_EXCHANGE|RENAME_NEWER_MTIME)))
>>                  lock_two_nondirectories(source, target);
>>          else if (target)
>>                  inode_lock(target);
>>
>> +       if ((flags & RENAME_NEWER_MTIME) && target) {
>> +               /* deny write access to stabilize mtime comparison below */
>> +               error = inode_deny_write_access2(source, target);
> This is not needed for non regular file, but I guess it doesn't hurt...
> You could do a helper lock_two_inodes_deny_write() that takes
> care of both inode_lock() and inode_deny_write_access() and
> call it instead of lock_two_nondirectories() above.
>
> Then the lock and unlock routines would be more straightforward
> and less error prone, e.g.:
>
> -       if (!is_dir || (flags & RENAME_EXCHANGE))
> +       if (flags & RENAME_NEWER_MTIME)
> +               lock_two_inodes_deny_write(source, target);
> +       else if (!is_dir || (flags & (RENAME_EXCHANGE)))
>                  lock_two_nondirectories(source, target);
>
> ...
>
> out:
> -       if (!is_dir || (flags & RENAME_EXCHANGE))
> +       if (flags & RENAME_NEWER_MTIME)
> +               unlock_two_inodes_allow_write(source, target);
> +       else if (!is_dir || (flags & (RENAME_EXCHANGE)))
>                  unlock_two_nondirectories(source, target);

So keep in mind that RENAME_NEWER_MTIME can be used together with 
RENAME_EXCHANGE, and I'm a bit concerned about having RENAME_NEWER_MTIME 
usurp the locking logic of RENAME_EXCHANGE when both are used.  My 
thinking in the v2 patch was to keep the locking for each mostly 
separate and nested, to make it clear that they are independent options 
that can also be used together.  Also because 
lock_two_inodes_deny_write() can fail, it adds a new possible bailout 
point that would need to unwind take_dentry_name_snapshot() and dget().  
So it's hard to avoid having to add a new "out1" label.

> OTOH, for directory, inode_lock is needed to stabilize mtime and
> lock_two_nondirectories() doesn't do that for you and it is also
> non trivial to get the locking order and lockdep annotations correct.
>
> Since you don't have a use case for RENAME_NEWER_MTIME and
> directories (?), maybe the easier way around this would be to deny that
> earlier in do_renameat2() with -EISDIR.

Yes, that makes sense.  I will add that.

James


