Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801766E969D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 16:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjDTOGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjDTOGU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:06:20 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C071BE3;
        Thu, 20 Apr 2023 07:06:10 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33KE5ofI057469;
        Thu, 20 Apr 2023 23:05:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Thu, 20 Apr 2023 23:05:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33KE5nNc057464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Apr 2023 23:05:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b6256ab2-35f8-e5e5-59f5-10ba95a396fb@I-love.SAKURA.ne.jp>
Date:   Thu, 20 Apr 2023 23:05:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Frank van der Linden <fvdl@google.com>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
 <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
 <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
 <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
 <c310695e-4279-b1a7-5c2a-2771cc19aa66@I-love.SAKURA.ne.jp>
 <7246a80ae33244a4553bbc0ca9e771ce8143d97b.camel@kernel.org>
 <20230416233758.GD447837@dread.disaster.area>
 <A23409BB-9BA1-44E5-96A8-C080B417CCB5@oracle.com>
 <20230419233243.GM447837@dread.disaster.area>
 <234CFC61-2246-4ECC-9653-E4A3544A1FEA@oracle.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <234CFC61-2246-4ECC-9653-E4A3544A1FEA@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/04/20 22:41, Chuck Lever III wrote:
>> That said, nfsd_listxattr() does:
>>
>>        dentry = fhp->fh_dentry;
>>        inode = d_inode(dentry);
>>        *lenp = 0;
>>
>>        inode_lock_shared(inode);
>>
>>        len = vfs_listxattr(dentry, NULL, 0);
>>
>> Given that a dentry pointing to an inode *must* hold an active
>> reference to that inode, I don't see how it is possible this code
>> path could be using an unreferenced inode.
>>
>> nfsd_getxattr() has a similar code fragment to obtain the inode as
>> well, so same goes for that...
> 
> Dave, thanks for handling the due diligence! I was not 100% sure
> about code that handles xattrs rather than the primary byte stream
> of a file.
> 
> Tetsuo, you can send a v2, or just let me know and I will make
> a patch to correct the GFP flags.

So, this inode_lock_shared() was there with an intention to make sure that
xattr of inode inside the exported filesystem does not change between
vfs_listxattr(dentry, NULL, 0) and vfs_listxattr(dentry, buf, len),
wasn't it?

Then, we can remove this inode_lock_shared() by adding a "goto retry;"
when vfs_listxattr(dentry, buf, len) failed with out of buffer size
due to a race condition, can't we?

I leave replacing inode lock with retry path and removing GFP_NOFS to you.

Thank you.

