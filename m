Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1A78F757
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 04:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348201AbjIACya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 22:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjIACya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 22:54:30 -0400
Received: from out-232.mta0.migadu.com (out-232.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E94E4C
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Aug 2023 19:54:26 -0700 (PDT)
Message-ID: <cfb26500-01a9-604d-53a9-c96b7dc08a69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693536864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SA1xYCvbedIq9OdG8VzoFXihTl7pKYABALF8KpZyKuw=;
        b=SIw2JtgJLbpiSRM4Tsm9bUTYV0EtJuy1FT6vEzeO5nxoGDVM/xxO3W6cdyIy7Xe5TIhR09
        Sguh2N8VB0q0XAfXvJQD8muxTa5ig2qvPPgx9uRwPuCVag5F4r8i4NusHKUBshXGr/m8y1
        Mv3WoJYx39VY+xsccqjFLVpgPBgl98A=
Date:   Fri, 1 Sep 2023 10:54:11 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 5/6] fuse: Remove fuse_direct_write_iter code path / use
 IOCB_DIRECT
Content-Language: en-US
To:     Bernd Schubert <bernd.schubert@fastmail.fm>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org
Cc:     miklos@szeredi.hu, dsingh@ddn.com
References: <20230829161116.2914040-1-bschubert@ddn.com>
 <20230829161116.2914040-6-bschubert@ddn.com>
 <5eaa9d17-b27c-1fbe-2575-1c4bc57f024e@linux.dev>
 <ba998811-636e-f2e4-8b59-173798d9b46f@fastmail.fm>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Hao Xu <hao.xu@linux.dev>
In-Reply-To: <ba998811-636e-f2e4-8b59-173798d9b46f@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/31/23 17:34, Bernd Schubert wrote:
>
>
> On 8/31/23 11:19, Hao Xu wrote:
>> On 8/30/23 00:11, Bernd Schubert wrote:
>>> fuse_direct_write_iter is basically duplicating what is already
>>> in fuse_cache_write_iter/generic_file_direct_write. That can be
>>> avoided by setting IOCB_DIRECT in fuse_file_write_iter, after that
>>> fuse_cache_write_iter can be used for the FOPEN_DIRECT_IO code path
>>> and fuse_direct_write_iter can be removed.
>>>
>>> Before it was using for FOPEN_DIRECT_IO
>>>
>>> 1) async (!is_sync_kiocb(iocb)) && IOCB_DIRECT
>>>
>>> fuse_file_write_iter
>>>      fuse_direct_write_iter
>>>          fuse_direct_IO
>>>              fuse_send_dio
>>>
>>> 2) sync (is_sync_kiocb(iocb)) or IOCB_DIRECT not being set
>>>
>>> fuse_file_write_iter
>>>      fuse_direct_write_iter
>>>          fuse_send_dio
>>>
>>> 3) FOPEN_DIRECT_IO not set
>>>
>>> Same as the consolidates path below
>>>
>>> The new consolidated code path is always
>>>
>>> fuse_file_write_iter
>>>      fuse_cache_write_iter
>>>          generic_file_write_iter
>>>               __generic_file_write_iter
>>>                   generic_file_direct_write
>>>                       mapping->a_ops->direct_IO / fuse_direct_IO
>>>                           fuse_send_dio
>>>
>>> So in general for FOPEN_DIRECT_IO the code path gets longer. 
>>> Additionally
>>> fuse_direct_IO does an allocation of struct fuse_io_priv - might be 
>>> a bit
>>> slower in micro benchmarks.
>>> Also, the IOCB_DIRECT information gets lost (as we now set it 
>>> outselves).
>>> But then IOCB_DIRECT is directly related to O_DIRECT set in
>>> struct file::f_flags.
>>>
>>> An additional change is for condition 2 above, which might will now do
>>> async IO on the condition ff->fm->fc->async_dio. Given that async IO 
>>> for
>>> FOPEN_DIRECT_IO was especially introduced in commit
>>> 'commit 23c94e1cdcbf ("fuse: Switch to using async direct IO for
>>>   FOPEN_DIRECT_IO")'
>>> it should not matter. Especially as fuse_direct_IO is blocking for
>>> is_sync_kiocb(), at worst it has another slight overhead.
>>>
>>> Advantage is the removal of code paths and conditions and it is now 
>>> also
>>> possible to remove FOPEN_DIRECT_IO conditions in fuse_send_dio
>>> (in a later patch).
>>>
>>> Cc: Hao Xu <howeyxu@tencent.com>
>>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>>> Cc: Dharmendra Singh <dsingh@ddn.com>
>>> Cc: linux-fsdevel@vger.kernel.org
>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>> ---
>>>   fs/fuse/file.c | 54 
>>> ++++----------------------------------------------
>>>   1 file changed, 4 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>> index f9d21804d313..0b3363eec435 100644
>>> --- a/fs/fuse/file.c
>>> +++ b/fs/fuse/file.c
>>> @@ -1602,52 +1602,6 @@ static ssize_t fuse_direct_read_iter(struct 
>>> kiocb *iocb, struct iov_iter *to)
>>>       return res;
>>>   }
>>> -static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct 
>>> iov_iter *from)
>>> -{
>>> -    struct inode *inode = file_inode(iocb->ki_filp);
>>> -    struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
>>> -    ssize_t res;
>>> -    bool exclusive_lock = fuse_dio_wr_exclusive_lock(iocb, from);
>>> -
>>> -    /*
>>> -     * Take exclusive lock if
>>> -     * - Parallel direct writes are disabled - a user space decision
>>> -     * - Parallel direct writes are enabled and i_size is being 
>>> extended.
>>> -     *   This might not be needed at all, but needs further 
>>> investigation.
>>> -     */
>>> -    if (exclusive_lock)
>>> -        inode_lock(inode);
>>> -    else {
>>> -        inode_lock_shared(inode);
>>> -
>>> -        /* A race with truncate might have come up as the decision for
>>> -         * the lock type was done without holding the lock, check 
>>> again.
>>> -         */
>>> -        if (fuse_io_past_eof(iocb, from)) {
>>> -            inode_unlock_shared(inode);
>>> -            inode_lock(inode);
>>> -            exclusive_lock = true;
>>> -        }
>>> -    }
>>> -
>>> -    res = generic_write_checks(iocb, from);
>>> -    if (res > 0) {
>>> -        if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
>>> -            res = fuse_direct_IO(iocb, from);
>>> -        } else {
>>> -            res = fuse_send_dio(&io, from, &iocb->ki_pos,
>>> -                        FUSE_DIO_WRITE);
>>> -            fuse_write_update_attr(inode, iocb->ki_pos, res);
>>> -        }
>>> -    }
>>> -    if (exclusive_lock)
>>> -        inode_unlock(inode);
>>> -    else
>>> -        inode_unlock_shared(inode);
>>> -
>>> -    return res;
>>> -}
>>> -
>>>   static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct 
>>> iov_iter *to)
>>>   {
>>>       struct file *file = iocb->ki_filp;
>>> @@ -1678,10 +1632,10 @@ static ssize_t fuse_file_write_iter(struct 
>>> kiocb *iocb, struct iov_iter *from)
>>>       if (FUSE_IS_DAX(inode))
>>>           return fuse_dax_write_iter(iocb, from);
>>> -    if (!(ff->open_flags & FOPEN_DIRECT_IO))
>>> -        return fuse_cache_write_iter(iocb, from);
>>> -    else
>>> -        return fuse_direct_write_iter(iocb, from);
>>> +    if (ff->open_flags & FOPEN_DIRECT_IO)
>>> +        iocb->ki_flags |= IOCB_DIRECT;
>>
>> I think this affect the back-end behavior, changes a buffered IO to 
>> direct io. FOPEN_DIRECT_IO means no cache in front-end, but we should
>> respect the back-end semantics. We may need another way to indicate
>> "we need go the direct io code path while IOCB_DIRECT is not set 
>> though".
>
> I'm confused here, I guess with frontend you mean fuse kernel and with 
> backend fuse userspace (daemon/server). IOCB_DIRECT is not passed to 
> server/daemon, so there is no change? Although maybe I should document 
> in fuse_write_flags() to be careful with returned flags and that 
> IOCB_DIRECT cannot be trusted - if this should ever passed, one needs 
> to use struct file::flags & O_DIRECT.
>

I see, I misunderstood the code, `iocb->ki_filp->f_flags` not 
`iocb->ki_flags`...


Thanks,
Hao


>
> Thanks,
> Bernd
>
>
> Thanks,
> Bernd
