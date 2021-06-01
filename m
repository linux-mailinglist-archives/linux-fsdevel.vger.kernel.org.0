Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9B397787
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 18:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhFAQJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 12:09:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233873AbhFAQJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622563696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8PtbhlRVaERQHH9SclKyeNFSDCobKYu6Mp8EQivgh0=;
        b=A5Vmbhha3HamU2jb9Cn2kFZxhkga34san88C1kOzR2OgogtmnvcRYQcek+fr4EE+pIh8UN
        GCCpvvVnCJpfhdpjyR5BZN3ueEE1HrKySgwmR93FSUhd7+VKlBF7Oatoi4zFKFFpK0wOSP
        3A+wMzu5q+Ruy8JbvuiFMUCHLefffsA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-mXQP9xNwM_-FnT-Q01vdDg-1; Tue, 01 Jun 2021 12:08:15 -0400
X-MC-Unique: mXQP9xNwM_-FnT-Q01vdDg-1
Received: by mail-ed1-f69.google.com with SMTP id da10-20020a056402176ab029038f0fea1f51so8085811edb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 09:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+8PtbhlRVaERQHH9SclKyeNFSDCobKYu6Mp8EQivgh0=;
        b=s/TQlP8T81yXD9pxg6AhAjYzan11r3Qh7IkpCCUiz0jDUs6v2g/liQJKcl8k/fAUln
         rU09VEsoMlyi6Q+VuFr1nBqa9NhbuDhharasLMoBLBWlmnDPE85LKOaDlUgs44eZCCTO
         cY+fju9seZEBga6wsSPRHtPrSVnxX4PpPiMLogC0cBii6PKF5gZFL3z5wjfM9BWmn9N7
         z/6xmBFmRTZcTvcD4VcgcC1ykK7uA32wq3JjAu5YvBgY+Zg2uDQIPxhIlDeP1FNv/R4r
         B5+dnja9aomPGT5h+V6YsJjiU2RbgPi7RRmjsnIWW//WNS8KukWYfc3XzuqlQdNg7CfV
         RlpA==
X-Gm-Message-State: AOAM530WypFPst7RVJlVQabP5qEDfKVjQCm88W6QmYp6C/1FKAr/gLMb
        HN0OkngRLe9vHdkwGiMrow0+Qh7mmuLgrHHtwnjy5eFcbuP/G+AbvIzV0hnfBx3qjFvnKOGg5X2
        Bkk0NbyyvC2ZUa8VSkCRj/ehbU1K3hZiaa05WFnBM6oTPMGLeTmTWD9XCY10vAUsOEXcgwbv9MF
        g=
X-Received: by 2002:a05:6402:15:: with SMTP id d21mr33938398edu.66.1622563693950;
        Tue, 01 Jun 2021 09:08:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtb6U6QthK9rD46BdMIfcqK8NYygz1d7Z3uC8DlioSoygKlHHXqHaE5qYU6Txp4a73hw8BjA==
X-Received: by 2002:a05:6402:15:: with SMTP id d21mr33938360edu.66.1622563693638;
        Tue, 01 Jun 2021 09:08:13 -0700 (PDT)
Received: from dresden.str.redhat.com ([2a02:908:1e46:160:b272:8083:d5:bc7d])
        by smtp.gmail.com with ESMTPSA id f21sm6747305edr.45.2021.06.01.09.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:08:13 -0700 (PDT)
Subject: Re: virtiofs uuid and file handles
To:     Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com>
 <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com>
 <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxgKr75J1YcuYAqRGC_C5H_mpCt01p5T9fHSuao_JnxcJA@mail.gmail.com>
 <CAJfpegviT38gja+-pE+5DCG0y9n3GUv4wWG_r3XmSWW6me88Cw@mail.gmail.com>
 <CAOQ4uxjNcWCfKLvdq2=TM5fE5RaBf+XvnsP6v_Q6u3b1_mxazw@mail.gmail.com>
 <CAJfpeguOLLV94Bzs7_JNOdZZ+6p-tcP7b1PXrQY4qWPxXKosnA@mail.gmail.com>
 <CAOQ4uxiJRii2FQrX51ZDmw_kGWTNvL21J7=Ow_z6Th_O-aruDA@mail.gmail.com>
 <20210601144909.GC24846@redhat.com>
 <CAOQ4uxgDMGUpK35huwqFYGH_idBB8S6eLiz85o0DDKOyDH4Syg@mail.gmail.com>
From:   Max Reitz <mreitz@redhat.com>
Message-ID: <4a85fc2f-8ee0-9772-0347-76221a13ef95@redhat.com>
Date:   Tue, 1 Jun 2021 18:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgDMGUpK35huwqFYGH_idBB8S6eLiz85o0DDKOyDH4Syg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01.06.21 17:42, Amir Goldstein wrote:
> On Tue, Jun 1, 2021 at 5:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>> On Mon, May 31, 2021 at 09:12:59PM +0300, Amir Goldstein wrote:
>>> On Mon, May 31, 2021 at 5:11 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>> On Sat, 29 May 2021 at 18:05, Amir Goldstein <amir73il@gmail.com> wrote:
>>>>> On Wed, Sep 23, 2020 at 2:12 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>>> On Wed, Sep 23, 2020 at 11:57 AM Amir Goldstein <amir73il@gmail.com> wrote:
>>>>>>> On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>>>>> On Wed, Sep 23, 2020 at 4:49 AM Amir Goldstein <amir73il@gmail.com> wrote:
>>>>>>>>
>>>>>>>>> I think that the proper was to implement reliable persistent file
>>>>>>>>> handles in fuse/virtiofs would be to add ENCODE/DECODE to
>>>>>>>>> FUSE protocol and allow the server to handle this.
>>>>>>>> Max Reitz (Cc-d) is currently looking into this.
>>>>>>>>
>>>>>>>> One proposal was to add  LOOKUP_HANDLE operation that is similar to
>>>>>>>> LOOKUP except it takes a {variable length handle, name} as input and
>>>>>>>> returns a variable length handle *and* a u64 node_id that can be used
>>>>>>>> normally for all other operations.
>>>>>>>>
>>>>> Miklos, Max,
>>>>>
>>>>> Any updates on LOOKUP_HANDLE work?

Unfortunately not :(

>>>>>>>> The advantage of such a scheme for virtio-fs (and possibly other fuse
>>>>>>>> based fs) would be that userspace need not keep a refcounted object
>>>>>>>> around until the kernel sends a FORGET, but can prune its node ID
>>>>>>>> based cache at any time.   If that happens and a request from the
>>>>>>>> client (kernel) comes in with a stale node ID, the server will return
>>>>>>>> -ESTALE and the client can ask for a new node ID with a special
>>>>>>>> lookup_handle(fh, NULL).
>>>>>>>>
>>>>>>>> Disadvantages being:
>>>>>>>>
>>>>>>>>   - cost of generating a file handle on all lookups
>>>>>>> I never ran into a local fs implementation where this was expensive.
>>>>>>>
>>>>>>>>   - cost of storing file handle in kernel icache
>>>>>>>>
>>>>>>>> I don't think either of those are problematic in the virtiofs case.
>>>>>>>> The cost of having to keep fds open while the client has them in its
>>>>>>>> cache is much higher.
>>>>>>>>
>>>>>>> Sounds good.
>>>>>>> I suppose flock() does need to keep the open fd on server.
>>>>>> Open files are a separate issue and do need an active object in the server.
>>>>>>
>>>>>> The issue this solves  is synchronizing "released" and "evicted"
>>>>>> states of objects between  server and client.  I.e. when a file is
>>>>>> closed (and no more open files exist referencing the same object) the
>>>>>> dentry refcount goes to zero but it remains in the cache.   In this
>>>>>> state the server could really evict it's own cached object, but can't
>>>>>> because the client can gain an active reference at any time  via
>>>>>> cached path lookup.
>>>>>>
>>>>>> One other solution would be for the server to send a notification
>>>>>> (NOTIFY_EVICT) that would try to clean out the object from the server
>>>>>> cache and respond with a FORGET if successful.   But I sort of like
>>>>>> the file handle one better, since it solves multiple problems.
>>>>>>
>>>>> Even with LOOKUP_HANDLE, I am struggling to understand how we
>>>>> intend to invalidate all fuse dentries referring to ino X in case the server
>>>>> replies with reused ino X with a different generation that the one stored
>>>>> in fuse inode cache.
>>>>>
>>>>> This is an issue that I encountered when running the passthrough_hp test,
>>>>> on my filesystem. In tst_readdir_big() for example, underlying files are being
>>>>> unlinked and new files created reusing the old inode numbers.
>>>>>
>>>>> This creates a situation where server gets a lookup request
>>>>> for file B that uses the reused inode number X, while old file A is
>>>>> still in fuse dentry cache using the older generation of real inode
>>>>> number X which is still in fuse inode cache.
>>>>>
>>>>> Now the server knows that the real inode has been rused, because
>>>>> the server caches the old generation value, but it cannot reply to
>>>>> the lookup request before the old fuse inode has been invalidated.
>>>>> IIUC, fuse_lowlevel_notify_inval_inode() is not enough(?).
>>>>> We would also need to change fuse_dentry_revalidate() to
>>>>> detect the case of reused/invalidated inode.
>>>>>
>>>>> The straightforward way I can think of is to store inode generation
>>>>> in fuse_dentry. It won't even grow the size of the struct.
>>>>>
>>>>> Am I over complicating this?
>>>> In this scheme the generation number is already embedded in the file
>>>> handle.  If LOOKUP_HANDLE returns a nodeid that can be found in the
>>>> icache, but which doesn't match the new file handle, then the old
>>>> inode will be marked bad and a new one allocated.
>>>>
>>>> Does that answer your worries?  Or am I missing something?
>>> It affirms my understanding of the future implementation, but
>>> does not help my implementation without protocol changes.
>>> I thought I could get away without LOOKUP_HANDLE for
>>> underlying fs that is able to resolve by ino, but seems that I still have an
>>> unhandled corner case, so will need to add some kernel patch.
>>> Unless there is already a way to signal from server to make the
>>> inode bad in a synchronous manner (I did not find any) before
>>> replying to LOOKUP with a new generation of the same ino.
>>>
>>> Any idea about the timeline for LOOKUP_HANDLE?
>>> I may be able to pick this up myself if there is no one actively
>>> working on it or plans for anyone to make this happen.
>> AFAIK, right now max is not actively looking into LOOKUP_HANDLE.
>>
>> To solve the issue of virtiofs server having too many fds open, he
>> is now planning to store corresonding file handle in server and use
>> that to open fd later.

Yes, that’s right. Initially, I had hoped these things could tie into 
each other, but it turns out they’re largely separate issue, so for now 
I’m only working on replacing our O_PATH fds by file handles.

>> But this does not help with persistent file handle issue for fuse
>> client.
>>
> I see. Yes that should work, but he'd still need to cope with reused
> inode numbers in case you allow unlinks from the host (do you?),
> because LOOKUP can find a host fs inode that does not match
> the file handle of a previously found inode of the same ino.

That’s indeed an issue.  My current approach is to use the file handle 
(if available) as the key for lookups, so that the generation ID is 
included.

Right now, we use st_ino+st_dev+mnt_id as the key.  st_dev is just a 
fallback for the mount ID, basically, so what we’d really need is inode 
ID + generation ID + mount ID, and that’s basically the file handle + 
mount ID.  So different generation IDs will lead to lookup 
finding/creating a different inode object (lo_inode in C virtiofsd, 
InodeData in virtiofsd-rs), and thus returning different fuse_ino IDs to 
the guest.

(See also: 
https://gitlab.com/mreitz/virtiofsd-rs/-/blob/handles-for-inodes-v4/src/passthrough/mod.rs#L594)

> Quoting Miklos' response above:
>>>> If LOOKUP_HANDLE returns a nodeid that can be found in the
>>>> icache, but which doesn't match the new file handle, then the old
>>>> inode will be marked bad and a new one allocated.
> This statement, with minor adjustments is also true for LOOKUP:
>
> "If LOOKUP returns a nodeid that can be found in the icache, but
>   whose i_generation doesn't match the generation returned in outarg,
>   then the old inode should be marked bad and a new one allocated."
>
>> BTW, one concern with file handles coming from guest kernel was that
>> how to trust those handles. Guest can create anything and use
>> file server to open the files on same filesystem (but not shared
>> with guest).
>>
>> I am assuming same concern should be there with non-virtiofs use
>> cases. Regular fuse client must be sending a file handle and
>> file server is running with CAP_DAC_READ_SEARCH. How will it make
>> sure that client is not able to access files not exported through
>> shared directory but are present on same filesystem.
>>
> That is a concern.
> It's the same concern for NFS clients that can guess file handles.
>
> The ways to address this concern with NFS is the export option
> subtree_check, but that uses non unique file handles to an inode
> which include a parent handle, so that's probably not a good fit for
> LOOKUP_HANDLE.

There was a mail thread on the topic of securing file handles in March:

https://listman.redhat.com/archives/virtio-fs/2021-March/msg00022.html

The problem I see with the subtree_check option is that file handles are 
invalidated when files are moved to a different parent.

So far the consensus was to append a MAC to file handles, generated with 
some secret key, so that only file handles that have been generated 
before can later be opened. Ideally, that MAC would be managed by the 
kernel, so that we could allow virtiofsd to use such MAC-ed file handles 
even when it doesn’t have CAP_DAC_READ_SEARCH.

Max

