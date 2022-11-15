Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6985A6291A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 06:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiKOFpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 00:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKOFpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 00:45:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733E4AE5A
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 21:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668491044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lM4amJ7wdUjkdBjwTy4otXUHl1/SmPMoOQLnV0WJVvE=;
        b=VWXipyrRvqiyvJB/KI7A4cKmiVWQZc/BNC6iU2geW/qca8PtiBhhaFhW9PQeK2oMgyDcGh
        yw+3xp/S6uZ7BJuaVAw/sch5V2xW+4thr3pMTViWT0X29ifyv61caa/y0TpKP3hpnoHjD0
        IzZ5XpaBYCa0VwYvxnz3MIJo7J1z0vU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-376-XPRODBUaPeGO_B4hR8_jUA-1; Tue, 15 Nov 2022 00:44:02 -0500
X-MC-Unique: XPRODBUaPeGO_B4hR8_jUA-1
Received: by mail-pj1-f69.google.com with SMTP id pi2-20020a17090b1e4200b0021834843687so3689053pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 21:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lM4amJ7wdUjkdBjwTy4otXUHl1/SmPMoOQLnV0WJVvE=;
        b=vtYb2H9ywlNZ9o4cRINd/mteq2KkKH9T8x9QvhPY8vK8oCr5spjuxPVX2QF4x37LfH
         0gKIubzVL8cdlgoMjpC0s8lp5QuIDNsYsQRnPlO0+JRoEqjjopqpB2CMUCj1HD4M/3hc
         TRaKW5kX+qHhxrRevHoda1R+6GUrZqY6twB9H861cM9TswVayaVvX44AStett1fGIUNE
         biygXQTCFOK+3imNxlHhY+jT7x1GTvCF2Zw5vrQMF4bvfQoXJmtRQhsv3Ln/W0qOIA9o
         ahiYzT3ClRl6YII9zI/sohSx2Vw5pHjSWnibs4xRY/3RZObTCE3K6LpP9ZWTDphuH2T8
         z/Sg==
X-Gm-Message-State: ANoB5pnt3z/hgnNuCSNh6pADgf6qNG4kAVIWeT1Zw7lUE9bgtDMd1GLr
        JYTDQmcc7/6M6Fx1J3dTndCCMs6DUbtRkvoqK6N+5bbTE1Ycc7OZGIiDF9wQMcat6YxL/lYFBEB
        cmBUeKRtQ1PeAiHKBXPiR95gfFg==
X-Received: by 2002:a17:902:ab05:b0:186:f256:91d1 with SMTP id ik5-20020a170902ab0500b00186f25691d1mr2469813plb.151.1668491041539;
        Mon, 14 Nov 2022 21:44:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf44HPP+RVKK1ewK2z6VekWWB4d5E8Naox+ReRtLRdi8UobOBu+NsvTJTrWiihpRmC5MWUW0uQ==
X-Received: by 2002:a17:902:ab05:b0:186:f256:91d1 with SMTP id ik5-20020a170902ab0500b00186f25691d1mr2469798plb.151.1668491041202;
        Mon, 14 Nov 2022 21:44:01 -0800 (PST)
Received: from [10.72.12.148] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090a1f4e00b002135fdfa995sm10723164pjy.25.2022.11.14.21.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 21:44:00 -0800 (PST)
Subject: Re: [RFC PATCH] filelock: new helper: vfs_file_has_locks
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org
References: <20221114140747.134928-1-jlayton@kernel.org>
 <30355bc8aa4998cb48b34df958837a8f818ceeb0.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <54b90281-c575-5aee-e886-e4d7b50236f0@redhat.com>
Date:   Tue, 15 Nov 2022 13:43:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <30355bc8aa4998cb48b34df958837a8f818ceeb0.camel@kernel.org>
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


On 15/11/2022 03:46, Jeff Layton wrote:
> On Mon, 2022-11-14 at 09:07 -0500, Jeff Layton wrote:
>> Ceph has a need to know whether a particular file has any locks set on
>> it. It's currently tracking that by a num_locks field in its
>> filp->private_data, but that's problematic as it tries to decrement this
>> field when releasing locks and that can race with the file being torn
>> down.
>>
>> Add a new vfs_file_has_locks helper that will scan the flock and posix
>> lists, and return true if any of the locks have a fl_file that matches
>> the given one. Ceph can then call this instead of doing its own
>> tracking.
>>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>   fs/locks.c         | 36 ++++++++++++++++++++++++++++++++++++
>>   include/linux/fs.h |  1 +
>>   2 files changed, 37 insertions(+)
>>
>> Xiubo,
>>
>> Here's what I was thinking instead of trying to track this within ceph.
>> Most inodes never have locks set, so in most cases this will be a NULL
>> pointer check.
>>
>>
>>
> I went ahead and added a slightly updated version of this this to my
> locks-next branch for now, but...
>
> Thinking about this more...I'm not sure this whole concept of what the
> ceph code is trying to do makes sense. Locks only conflict if they have
> different owners, and POSIX locks are owned by the process. Consider
> this scenario (obviously, this is not a problem with OFD locks).
>
> A process has the same file open via two different fds. It sets lock A
> from offset 0..9 via fd 1. Now, same process sets lock B from 10..19 via
> fd 2. The two locks will be merged, because they don't conflict (because
> it's the same process).
>
> Against which fd should the merged lock record be counted?

Thanks Jeff.

For the above example as you mentioned, from my reading of the lock code 
after being merged it will always keep the old file_lock's fl_file.

There is another case that if the Inode already has LockA and LockB:

Lock A --> [0, 9] --> fileA

Lock B --> [15, 20] --> fileB

And then LockC comes:

Lock C --> [8, 16] --> fileC

Then the inode will only have the LockB:

Lock B --> [0, 20] --> fileB.

So the exiting ceph code seems buggy!

>
> Would it be better to always check for CEPH_I_ERROR_FILELOCK, even when
> the fd hasn't had any locks explicitly set on it?

Maybe we should check whether any POSIX lock exist, if so we should 
check CEPH_I_ERROR_FILELOCK always. Or we need to check it depending on 
each fd ?

Thanks!

- Xiubo


>> diff --git a/fs/locks.c b/fs/locks.c
>> index 5876c8ff0edc..c7f903b63a53 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -2672,6 +2672,42 @@ int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
>>   }
>>   EXPORT_SYMBOL_GPL(vfs_cancel_lock);
>>   
>> +/**
>> + * vfs_file_has_locks - are any locks held that were set on @filp?
>> + * @filp: open file to check for locks
>> + *
>> + * Return true if are any FL_POSIX or FL_FLOCK locks currently held
>> + * on @filp.
>> + */
>> +bool vfs_file_has_locks(struct file *filp)
>> +{
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +	bool ret = false;
>> +
>> +	ctx = smp_load_acquire(&locks_inode(filp)->i_flctx);
>> +	if (!ctx)
>> +		return false;
>> +
>> +	spin_lock(&ctx->flc_lock);
>> +	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>> +		if (fl->fl_file == filp) {
>> +			ret = true;
>> +			goto out;
>> +		}
>> +	}
>> +	list_for_each_entry(fl, &ctx->flc_flock, fl_list) {
>> +		if (fl->fl_file == filp) {
>> +			ret = true;
>> +			break;
>> +		}
>> +	}
>> +out:
>> +	spin_unlock(&ctx->flc_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(vfs_file_has_locks);
>> +
>>   #ifdef CONFIG_PROC_FS
>>   #include <linux/proc_fs.h>
>>   #include <linux/seq_file.h>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index e654435f1651..e4d0f1fa7f9f 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1170,6 +1170,7 @@ extern int locks_delete_block(struct file_lock *);
>>   extern int vfs_test_lock(struct file *, struct file_lock *);
>>   extern int vfs_lock_file(struct file *, unsigned int, struct file_lock *, struct file_lock *);
>>   extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
>> +bool vfs_file_has_locks(struct file *file);
>>   extern int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
>>   extern int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
>>   extern void lease_get_mtime(struct inode *, struct timespec64 *time);

