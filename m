Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1195D64E523
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 01:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLPAYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 19:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLPAYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 19:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0959950D54
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 16:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671150226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VnaI0wTW9bargd+4gjX5OMF1abHB+qSIpPhlMGiP5og=;
        b=Gq20/LSWRXVd1ZHqmNtF6bl3rcp3FRj34tSAsRnScI05OhphLX7EwaS8APiSmFnmyNfD3C
        47KXgFQiKCDO4WP7rY2klmaAeEY0YKKnXR5gQC2WvOa64SYKA5tmcxPCaWe7vfIYQYFhw9
        CGsrbTFU+iERLAzp0XnM5p1IhsdHS4E=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-316-RyboUgtrNMafoqIWtXxKBA-1; Thu, 15 Dec 2022 19:23:45 -0500
X-MC-Unique: RyboUgtrNMafoqIWtXxKBA-1
Received: by mail-pj1-f72.google.com with SMTP id k2-20020a17090a514200b002198214abdcso387365pjm.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 16:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnaI0wTW9bargd+4gjX5OMF1abHB+qSIpPhlMGiP5og=;
        b=YHKehBi7OwgFIBbxpsiRmLdeZRr2xaCTlMy1lO4Q3EG3yBytQlXS+ISGmBjtsL6X7M
         bHpodyLeO4xrgssPy2GkFA8Tx8YDDZ6i22cY9Jnx8LCxxDkowUWDMWOEBQYnKooUsczF
         /fgTny/KDOYcZn796vFw0/UTR+phbsThWFK61/J2GhcNnc4jp3cKjJPBuyfRKMTr6m7+
         AZZ8wUfk4xsG1aDMP3GDoHjnhpyH6r892d35XhklzodrZ1grW4eICRl8vpS9UdVZDtbe
         D3UvtqS526S9ddMbIlJseBAKYelIEV8Jcs36yJL6dBtrAIWxGOOytGOP5Whc9rQ96/R5
         AhVw==
X-Gm-Message-State: ANoB5pmtqewCWduiV0XDosjIlE6baK0vlm5b/kbe1lbs7jgOJ/z5y20r
        BxOZRK4A935VEYbD/YTeYi/GtDsmkGTJ4yiEC7HxY/34wiEl8kSWgoSQdonxndJxdBAJyGWmVz4
        JqrapwKNwjEsGzV9AXd2sYMf59A==
X-Received: by 2002:a17:902:ee4c:b0:18e:e03b:f1bd with SMTP id 12-20020a170902ee4c00b0018ee03bf1bdmr27777570plo.53.1671150224301;
        Thu, 15 Dec 2022 16:23:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ztAjxpWMwQtbasXI8MJKS9eR4mQC0niiuAa1LWsFUgnhV4B7xqHvp+EH9bXKz03eXPYlxgQ==
X-Received: by 2002:a17:902:ee4c:b0:18e:e03b:f1bd with SMTP id 12-20020a170902ee4c00b0018ee03bf1bdmr27777549plo.53.1671150224058;
        Thu, 15 Dec 2022 16:23:44 -0800 (PST)
Received: from [10.72.12.85] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jf14-20020a170903268e00b00189a50d2a3esm203624plb.241.2022.12.15.16.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 16:23:43 -0800 (PST)
Subject: Re: [PATCH v5 1/2] ceph: switch to vfs_inode_has_locks() to fix file
 lock bug
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     jlayton@kernel.org, ceph-devel@vger.kernel.org,
        mchangir@redhat.com, lhenriques@suse.de, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org
References: <20221214033512.659913-1-xiubli@redhat.com>
 <20221214033512.659913-2-xiubli@redhat.com>
 <CAOi1vP9Je-DnqUdYcBi_zSDUgj30aYrTeGq1MSwS66E7ptaTSg@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <4e570f80-4e2e-c567-55a3-a17063278502@redhat.com>
Date:   Fri, 16 Dec 2022 08:23:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAOi1vP9Je-DnqUdYcBi_zSDUgj30aYrTeGq1MSwS66E7ptaTSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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


On 15/12/2022 21:20, Ilya Dryomov wrote:
> On Wed, Dec 14, 2022 at 4:35 AM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> For the POSIX locks they are using the same owner, which is the
>> thread id. And multiple POSIX locks could be merged into single one,
>> so when checking whether the 'file' has locks may fail.
>>
>> For a file where some openers use locking and others don't is a
>> really odd usage pattern though. Locks are like stoplights -- they
>> only work if everyone pays attention to them.
>>
>> Just switch ceph_get_caps() to check whether any locks are set on
>> the inode. If there are POSIX/OFD/FLOCK locks on the file at the
>> time, we should set CHECK_FILELOCK, regardless of what fd was used
>> to set the lock.
>>
>> Cc: stable@vger.kernel.org
>> Cc: Jeff Layton <jlayton@kernel.org>
>> Fixes: ff5d913dfc71 ("ceph: return -EIO if read/write against filp that lost file locks")
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/caps.c  | 2 +-
>>   fs/ceph/locks.c | 4 ----
>>   fs/ceph/super.h | 1 -
>>   3 files changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>> index 065e9311b607..948136f81fc8 100644
>> --- a/fs/ceph/caps.c
>> +++ b/fs/ceph/caps.c
>> @@ -2964,7 +2964,7 @@ int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got
>>
>>          while (true) {
>>                  flags &= CEPH_FILE_MODE_MASK;
>> -               if (atomic_read(&fi->num_locks))
>> +               if (vfs_inode_has_locks(inode))
>>                          flags |= CHECK_FILELOCK;
>>                  _got = 0;
>>                  ret = try_get_cap_refs(inode, need, want, endoff,
>> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
>> index 3e2843e86e27..b191426bf880 100644
>> --- a/fs/ceph/locks.c
>> +++ b/fs/ceph/locks.c
>> @@ -32,18 +32,14 @@ void __init ceph_flock_init(void)
>>
>>   static void ceph_fl_copy_lock(struct file_lock *dst, struct file_lock *src)
>>   {
>> -       struct ceph_file_info *fi = dst->fl_file->private_data;
>>          struct inode *inode = file_inode(dst->fl_file);
>>          atomic_inc(&ceph_inode(inode)->i_filelock_ref);
>> -       atomic_inc(&fi->num_locks);
>>   }
>>
>>   static void ceph_fl_release_lock(struct file_lock *fl)
>>   {
>> -       struct ceph_file_info *fi = fl->fl_file->private_data;
>>          struct inode *inode = file_inode(fl->fl_file);
>>          struct ceph_inode_info *ci = ceph_inode(inode);
>> -       atomic_dec(&fi->num_locks);
>>          if (atomic_dec_and_test(&ci->i_filelock_ref)) {
>>                  /* clear error when all locks are released */
>>                  spin_lock(&ci->i_ceph_lock);
>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>> index 14454f464029..e7662ff6f149 100644
>> --- a/fs/ceph/super.h
>> +++ b/fs/ceph/super.h
>> @@ -804,7 +804,6 @@ struct ceph_file_info {
>>          struct list_head rw_contexts;
>>
>>          u32 filp_gen;
>> -       atomic_t num_locks;
>>   };
>>
>>   struct ceph_dir_file_info {
>> --
>> 2.31.1
>>
> Hi Xiubo,
>
> You marked this for stable but there is an obvious dependency on
> vfs_inode_has_locks() that just got merged for 6.2-rc1.  Are you
> intending to take it into stable kernels as well?

Hi Ilya,

Yes. I can do the backport of these 3 patches myself later.

Thanks

- Xiubo

> Thanks,
>
>                  Ilya
>

