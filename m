Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D375862B380
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 07:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiKPGuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 01:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiKPGup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:50:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF938286E0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 22:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668581384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JGsz1ETxey2xaUk57Q8g1KrvM+7FuB8lKK1LrZngBc8=;
        b=UsytPE7iyDSTLAO9aRiEnY91znYxU8WkCJ3mXO+AgycYCLe/yU0M8WlZBju9rSDJvHVQop
        r0xCbL6fRPM18x2YiZhO65hbjiTcBISF36FbV8qbvt65iV7qx2O04jPwroh8A9zpyKLa/Q
        nr+cRRsTEyD+vpRrBibJhWHqm4094yU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-T9au-8ysMtO9UQx2nsEMDQ-1; Wed, 16 Nov 2022 01:49:43 -0500
X-MC-Unique: T9au-8ysMtO9UQx2nsEMDQ-1
Received: by mail-pg1-f197.google.com with SMTP id 138-20020a630290000000b004708e8a8dcfso8876295pgc.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 22:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGsz1ETxey2xaUk57Q8g1KrvM+7FuB8lKK1LrZngBc8=;
        b=dQ1fC6FtWIaNHMJC52w/L3GUG7bi5l4+mJP6yvdq0r4xfuE9qZbB8qi136bzXrOa7U
         MQFRBPdg1ON/dZIQbf7Iiz4dKg7WnanfhOsOo8vCCK2FqErf6NXo1SxBYZ8tVlQfZdBu
         sO8ELdTTJCGWGMsokogx+UHIxuZgxoI//JSB7y91lPoBlOLIe4usn38dtJXK8s0ztg7Z
         RgAiQG9SRCOyUt87xmbh549H9vPO1eN5p8bHsxQhbC5uNeab0yKwR9escGmnBExP9lpb
         upwbtbrqW14BcZUE7IDt/hnk+uXiAeMd9j0Sr/Rolr72oXnw02XCJr3R5V7PPug2Qh/Z
         iJ1Q==
X-Gm-Message-State: ANoB5pmLCt7TmIKGXDn6uzkNuCXBF8wK1gZBDCdDpcnXVyllmGWUCy3W
        ms66o0oaTpmNfk6IYP6CT+CuwLIm2gXZ6omnYEMThJ7WMc8z/+aSB6xIqrVHuU54P+we6h1sRZ7
        hBfnDfxupiEW4NgFXUOq6q6XF4A==
X-Received: by 2002:a05:6a00:2196:b0:56d:1fdc:9d37 with SMTP id h22-20020a056a00219600b0056d1fdc9d37mr21540413pfi.77.1668581382076;
        Tue, 15 Nov 2022 22:49:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6KILhTZlP1Cx0C/arSVKAMSgnMb+woLpp46JPUQRotyTKw7Knot91Ia34beuf5WNiwrtyV7A==
X-Received: by 2002:a05:6a00:2196:b0:56d:1fdc:9d37 with SMTP id h22-20020a056a00219600b0056d1fdc9d37mr21540385pfi.77.1668581381738;
        Tue, 15 Nov 2022 22:49:41 -0800 (PST)
Received: from [10.72.12.148] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p6-20020a63f446000000b0047079cb8875sm8909815pgk.42.2022.11.15.22.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 22:49:41 -0800 (PST)
Subject: Re: [RFC PATCH] filelock: new helper: vfs_file_has_locks
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <20221114140747.134928-1-jlayton@kernel.org>
 <30355bc8aa4998cb48b34df958837a8f818ceeb0.camel@kernel.org>
 <54b90281-c575-5aee-e886-e4d7b50236f0@redhat.com>
 <4a8720c8a24a9b06adc40fdada9c621fd5d849df.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <a8c94ba5-c01f-3bb6-0b35-2aee06b9d6e7@redhat.com>
Date:   Wed, 16 Nov 2022 14:49:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <4a8720c8a24a9b06adc40fdada9c621fd5d849df.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 15/11/2022 22:40, Jeff Layton wrote:
> On Tue, 2022-11-15 at 13:43 +0800, Xiubo Li wrote:
>> On 15/11/2022 03:46, Jeff Layton wrote:
>>> On Mon, 2022-11-14 at 09:07 -0500, Jeff Layton wrote:
>>>> Ceph has a need to know whether a particular file has any locks set on
>>>> it. It's currently tracking that by a num_locks field in its
>>>> filp->private_data, but that's problematic as it tries to decrement this
>>>> field when releasing locks and that can race with the file being torn
>>>> down.
>>>>
>>>> Add a new vfs_file_has_locks helper that will scan the flock and posix
>>>> lists, and return true if any of the locks have a fl_file that matches
>>>> the given one. Ceph can then call this instead of doing its own
>>>> tracking.
>>>>
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>>    fs/locks.c         | 36 ++++++++++++++++++++++++++++++++++++
>>>>    include/linux/fs.h |  1 +
>>>>    2 files changed, 37 insertions(+)
>>>>
>>>> Xiubo,
>>>>
>>>> Here's what I was thinking instead of trying to track this within ceph.
>>>> Most inodes never have locks set, so in most cases this will be a NULL
>>>> pointer check.
>>>>
>>>>
>>>>
>>> I went ahead and added a slightly updated version of this this to my
>>> locks-next branch for now, but...
>>>
>>> Thinking about this more...I'm not sure this whole concept of what the
>>> ceph code is trying to do makes sense. Locks only conflict if they have
>>> different owners, and POSIX locks are owned by the process. Consider
>>> this scenario (obviously, this is not a problem with OFD locks).
>>>
>>> A process has the same file open via two different fds. It sets lock A
>>> from offset 0..9 via fd 1. Now, same process sets lock B from 10..19 via
>>> fd 2. The two locks will be merged, because they don't conflict (because
>>> it's the same process).
>>>
>>> Against which fd should the merged lock record be counted?
>> Thanks Jeff.
>>
>> For the above example as you mentioned, from my reading of the lock code
>> after being merged it will always keep the old file_lock's fl_file.
>>
>> There is another case that if the Inode already has LockA and LockB:
>>
>> Lock A --> [0, 9] --> fileA
>>
>> Lock B --> [15, 20] --> fileB
>>
>> And then LockC comes:
>>
>> Lock C --> [8, 16] --> fileC
>>
>> Then the inode will only have the LockB:
>>
>> Lock B --> [0, 20] --> fileB.
>>
>> So the exiting ceph code seems buggy!
>>
> Yeah, there are a number of ways to end up with a different fl_file than
> you started with.
>   
>>> Would it be better to always check for CEPH_I_ERROR_FILELOCK, even when
>>> the fd hasn't had any locks explicitly set on it?
>> Maybe we should check whether any POSIX lock exist, if so we should
>> check CEPH_I_ERROR_FILELOCK always. Or we need to check it depending on
>> each fd ?
>>
>>
> It was originally added here:
>
> commit ff5d913dfc7142974eb1694d5fd6284658e46bc6
> Author: Yan, Zheng <zyan@redhat.com>
> Date:   Thu Jul 25 20:16:45 2019 +0800
>
>      ceph: return -EIO if read/write against filp that lost file locks
>      
>      After mds evicts session, file locks get lost sliently. It's not safe to
>      let programs continue to do read/write.
>      
>      Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>      Reviewed-by: Jeff Layton <jlayton@kernel.org>
>      Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>
> So I guess with the current code if you have the file open and set a
> lock on it, you'll get back EIO when you try to get caps for it, but if
> you never set a lock on the fd, then you wouldn't get an error. We don't
> reliably keep track of what fd was used to set a lock (as noted above),
> so we can't really do what Zheng was trying to do here.
>
> Having a file where some openers use locking and others don't is a
> really odd usage pattern though. Locks are like stoplights -- they only
> work if everyone pays attention to them.
>
> I think we should probably switch ceph_get_caps to just check whether
> any locks are set on the file. If there are POSIX/OFD/FLOCK locks on the
> file at the time, we should set CHECK_FILELOCK, regardless of what fd
> was used to set the lock.
>
> In practical terms, we probably want a vfs_inode_has_locks function,
> that just tests whether the flc_posix and flc_flock lists are empty.

Jeff,

Yeah, this sounds good to me.


> Maybe something like this instead? Then ceph could call this from
> ceph_get_caps and set CHECK_FILELOCK if it returns true.
>
> -------------8<---------------
>
> [PATCH] filelock: new helper: vfs_inode_has_locks
>
> Ceph has a need to know whether a particular inode has any locks set on
> it. It's currently tracking that by a num_locks field in its
> filp->private_data, but that's problematic as it tries to decrement this
> field when releasing locks and that can race with the file being torn
> down.
>
> Add a new vfs_inode_has_locks helper that just returns whether any locks
> are currently held on the inode.
>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/locks.c         | 23 +++++++++++++++++++++++
>   include/linux/fs.h |  1 +
>   2 files changed, 24 insertions(+)
>
> diff --git a/fs/locks.c b/fs/locks.c
> index 5876c8ff0edc..9ccf89b6c95d 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2672,6 +2672,29 @@ int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
>   }
>   EXPORT_SYMBOL_GPL(vfs_cancel_lock);
>   
> +/**
> + * vfs_inode_has_locks - are any file locks held on @inode?
> + * @inode: inode to check for locks
> + *
> + * Return true if there are any FL_POSIX or FL_FLOCK locks currently
> + * set on @inode.
> + */
> +bool vfs_inode_has_locks(struct inode *inode)
> +{
> +	struct file_lock_context *ctx;
> +	bool ret;
> +
> +	ctx = smp_load_acquire(&inode->i_flctx);
> +	if (!ctx)
> +		return false;
> +
> +	spin_lock(&ctx->flc_lock);
> +	ret = !list_empty(&ctx->flc_posix) || !list_empty(&ctx->flc_flock);
> +	spin_unlock(&ctx->flc_lock);

BTW, is the spin_lock/spin_unlock here really needed ?

> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vfs_inode_has_locks);
> +
>   #ifdef CONFIG_PROC_FS
>   #include <linux/proc_fs.h>
>   #include <linux/seq_file.h>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e654435f1651..d6cb42b7e91c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1170,6 +1170,7 @@ extern int locks_delete_block(struct file_lock *);
>   extern int vfs_test_lock(struct file *, struct file_lock *);
>   extern int vfs_lock_file(struct file *, unsigned int, struct file_lock *, struct file_lock *);
>   extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
> +bool vfs_inode_has_locks(struct inode *inode);
>   extern int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
>   extern int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
>   extern void lease_get_mtime(struct inode *, struct timespec64 *time);

All the others LGTM.

Thanks.

- Xiubo


