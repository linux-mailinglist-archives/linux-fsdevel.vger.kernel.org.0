Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE964C219
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 03:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiLNCEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 21:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiLNCEq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:04:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FC72AF5
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 18:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670983438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxWgAtzssiZUci/PlwUY7k+wYk7RgEHn1aQq5Ig7ASE=;
        b=EqjexTW5hBV3c3qvtShzFrHj84rEnHZfrXgIKlGZGARxZxwew+A9TLJBYYFjUA9cIPm00T
        3Zkvs+VLglPJLqHfR1SQ00q/RBrksZ2q1Uevr79gAXutDWJj4M+lGmUsf6XZ8qhM3zgk/0
        w0MXJcSMm5pDvIZkpvTzihskIHWY6F0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-IjRWjgNbODqpuvXoCSrBrA-1; Tue, 13 Dec 2022 21:03:57 -0500
X-MC-Unique: IjRWjgNbODqpuvXoCSrBrA-1
Received: by mail-pf1-f197.google.com with SMTP id n16-20020a056a000d5000b005764608bb24so3192209pfv.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 18:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxWgAtzssiZUci/PlwUY7k+wYk7RgEHn1aQq5Ig7ASE=;
        b=XaoZr/YYqbeqPpmbOIfZKZP7E8vzh0lsxMum7SHjCNDx4FaqvjVaBAy6LQQ2QoEHBA
         SxEKSS4B1jWdiDXvnV276CUpJmYYb/NxVC9QTT/P/5EKqE1J0qc4JkArmausb8fNnWXg
         /nfoM/3ZW6BXaKcedRysrbxmgQrjqE39k0ytyhgJEvxBPLGb9tlUCLaYCWdFgmL9+TeY
         guVWuH2jG53cKoRHbxodmUwV+7Xjj12bdpmDRcjvF4zIG7TGyX2Xlh5Okq20fjY6xmwX
         CPDnC7R0A/fILSj2czCRIll8ALcOFpVB8N300whMj88DuS0j9av7Uva3UqVGXIyWxPa5
         egYQ==
X-Gm-Message-State: ANoB5pnKCW9VWwHDiPHzXhAT/3NabAN8972fK746OC1WhismGPb30yzY
        t13xmbw44bZwZYj5BtrES4MnIxsUP+L1JQx/peG0/8BDP8RBamWKVG03z2WLswTVcs42GvS11Fw
        ZhtfZR/IZgH3wgYPPEZx0j5LkMw==
X-Received: by 2002:a17:902:6905:b0:189:340c:20d2 with SMTP id j5-20020a170902690500b00189340c20d2mr24488968plk.23.1670983436073;
        Tue, 13 Dec 2022 18:03:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf58GHtAnUtVx7eHJgWLx44Wxgv4SDCZhO6Z6Z6rNRrAmwxlPG98KL5qMp4Cs3IqOyWZ/lYpmg==
X-Received: by 2002:a17:902:6905:b0:189:340c:20d2 with SMTP id j5-20020a170902690500b00189340c20d2mr24488949plk.23.1670983435793;
        Tue, 13 Dec 2022 18:03:55 -0800 (PST)
Received: from [10.72.13.36] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902690700b0017ec1b1bf9fsm516185plk.217.2022.12.13.18.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 18:03:55 -0800 (PST)
Subject: Re: [PATCH v4 2/2] ceph: add ceph specific member support for
 file_lock
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     jlayton@kernel.org, ceph-devel@vger.kernel.org,
        mchangir@redhat.com, lhenriques@suse.de, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org
References: <20221213121103.213631-1-xiubli@redhat.com>
 <20221213121103.213631-3-xiubli@redhat.com>
 <CAOi1vP-jTA38riQ+E239vz2omTmX7fQvnzf9BcmkLVU_0PyngA@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <e970159b-ec60-434e-59ce-36128fe99bcf@redhat.com>
Date:   Wed, 14 Dec 2022 10:03:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAOi1vP-jTA38riQ+E239vz2omTmX7fQvnzf9BcmkLVU_0PyngA@mail.gmail.com>
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


On 14/12/2022 02:05, Ilya Dryomov wrote:
> On Tue, Dec 13, 2022 at 1:11 PM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> When ceph releasing the file_lock it will try to get the inode pointer
>> from the fl->fl_file, which the memory could already be released by
>> another thread in filp_close(). Because in VFS layer the fl->fl_file
>> doesn't increase the file's reference counter.
>>
>> Will switch to use ceph dedicate lock info to track the inode.
>>
>> And in ceph_fl_release_lock() we should skip all the operations if
>> the fl->fl_u.ceph_fl.fl_inode is not set, which should come from
>> the request file_lock. And we will set fl->fl_u.ceph_fl.fl_inode when
>> inserting it to the inode lock list, which is when copying the lock.
>>
>> Cc: stable@vger.kernel.org
>> Cc: Jeff Layton <jlayton@kernel.org>
>> URL: https://tracker.ceph.com/issues/57986
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/locks.c    | 20 ++++++++++++++++++--
>>   include/linux/fs.h |  3 +++
>>   2 files changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
>> index b191426bf880..cf78608a3f9a 100644
>> --- a/fs/ceph/locks.c
>> +++ b/fs/ceph/locks.c
>> @@ -34,18 +34,34 @@ static void ceph_fl_copy_lock(struct file_lock *dst, struct file_lock *src)
>>   {
>>          struct inode *inode = file_inode(dst->fl_file);
>>          atomic_inc(&ceph_inode(inode)->i_filelock_ref);
>> +       dst->fl_u.ceph.fl_inode = igrab(inode);
>>   }
>>
>> +/*
>> + * Do not use the 'fl->fl_file' in release function, which
>> + * is possibly already released by another thread.
>> + */
>>   static void ceph_fl_release_lock(struct file_lock *fl)
>>   {
>> -       struct inode *inode = file_inode(fl->fl_file);
>> -       struct ceph_inode_info *ci = ceph_inode(inode);
>> +       struct inode *inode = fl->fl_u.ceph.fl_inode;
>> +       struct ceph_inode_info *ci;
>> +
>> +       /*
>> +        * If inode is NULL it should be a request file_lock,
>> +        * nothing we can do.
>> +        */
>> +       if (!inode)
>> +               return;
>> +
>> +       ci = ceph_inode(inode);
>>          if (atomic_dec_and_test(&ci->i_filelock_ref)) {
>>                  /* clear error when all locks are released */
>>                  spin_lock(&ci->i_ceph_lock);
>>                  ci->i_ceph_flags &= ~CEPH_I_ERROR_FILELOCK;
>>                  spin_unlock(&ci->i_ceph_lock);
>>          }
>> +       fl->fl_u.ceph.fl_inode = NULL;
>> +       iput(inode);
>>   }
>>
>>   static const struct file_lock_operations ceph_fl_lock_ops = {
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 7b52fdfb6da0..6106374f5257 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1119,6 +1119,9 @@ struct file_lock {
>>                          int state;              /* state of grant or error if -ve */
>>                          unsigned int    debug_id;
>>                  } afs;
>> +               struct {
>> +                       struct inode *fl_inode;
> Hi Xiubo,
>
> Nit: I think it could be just "inode", without the prefix which is
> already present in the union field name.

Okay, I can fix this in the next version.

Thanks.

- Xiubo


> Thanks,
>
>                  Ilya
>

