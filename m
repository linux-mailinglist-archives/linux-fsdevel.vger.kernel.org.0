Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C07364E759
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 07:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiLPGqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 01:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLPGqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:46:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2310B6E
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 22:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671173141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EyyTXVbRxW6RoYTlLvUhbIorlI9fdIsygWbvarVeWmI=;
        b=UJ+wWNTd2u2LXx4Qtcm2JSkk7dpuLaCYgLYDnnxh3yw4Be4qPZqeREhBzuGDRYogu1QrXg
        /ZgQlvZPU6eGGWbTb35TqOmS8GxPN1YyTW0KJes9QWmvUiMCrq0Y7HM2FbNcobZwWp25X9
        uvUzpHihxP9WAlBGevPdfenbUNmTYJw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-3Mk4qAMTONGwy5DChWz0Ow-1; Fri, 16 Dec 2022 01:45:39 -0500
X-MC-Unique: 3Mk4qAMTONGwy5DChWz0Ow-1
Received: by mail-pj1-f70.google.com with SMTP id 94-20020a17090a09e700b002191897f70aso838779pjo.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 22:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyyTXVbRxW6RoYTlLvUhbIorlI9fdIsygWbvarVeWmI=;
        b=1rHmXLM9hy4BrcrKaa0DoF92+OJZbR0MG3c03vWCvR4/iT/gnFeg2Oi5r8UZvUWw4J
         tUTyUvTwXaMC7C9kgunfey/hOaTLBJJWHxpTbLU85xxZCOwWNtoA0bcz7M8UFIxcKdK3
         GFS5N/JVxfM9Q4pxl315ApqsswZSfjge4nWCQ+LxPHJgh0o6cWULP5iuolllDb3+BMP/
         MwGSwZnTAArCmKYBOa8IpkO5bnF5l5bHaDqjjhNPJ37ijjNTmi0NK9RM+nUbocbtODbu
         PCTLaJ+STTZVb1TTICw6AxDW+q34cB0KlMnmKKXMjNNyZ7500jTY5/KC+V3CFj7viDDG
         QwGA==
X-Gm-Message-State: ANoB5pldzVNJh9lkGnxeVRtmwiCGyW3zfF4bGVk4+SOuPJqn0t5/MkLO
        1oMTuJmfF53mhxe144bvH3kr4OD20jJB/ZHSyGK+sJdthZu/h80sP103lsUYf76RKHsJs37qxfA
        fYQPDCl6nGaasu0WikEq5wGA57w==
X-Received: by 2002:a05:6a00:324b:b0:574:3cde:385a with SMTP id bn11-20020a056a00324b00b005743cde385amr28147991pfb.32.1671173138542;
        Thu, 15 Dec 2022 22:45:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6HfByRs7AYndW60H7cHGDSkY5CKgg+GZAUndAV7yc7i56Odny6jIgYb7nID+7Kd4ogaNjoQw==
X-Received: by 2002:a05:6a00:324b:b0:574:3cde:385a with SMTP id bn11-20020a056a00324b00b005743cde385amr28147984pfb.32.1671173138212;
        Thu, 15 Dec 2022 22:45:38 -0800 (PST)
Received: from [10.72.12.85] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b27-20020aa78edb000000b005772bf1b61bsm698482pfr.67.2022.12.15.22.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 22:45:37 -0800 (PST)
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
Message-ID: <d0035a08-b2db-7bd5-4a19-2427404e3cf4@redhat.com>
Date:   Fri, 16 Dec 2022 14:45:30 +0800
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

In the testing branch I just removed the stable list and will do the 
backport myself.

Thanks

- Xiubo


> Thanks,
>
>                  Ilya
>

