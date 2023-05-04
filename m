Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36D26F7715
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 22:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjEDUdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 16:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjEDUdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 16:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C06281A7
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683231691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mQf2GpD0o5VSN3G7OZxMsYj2xisfXhx2cYogtpM0zBw=;
        b=EZTmdxTXSfrdKjm3HWAMiJMFjEOvSJpsetebsXbh3E0AKMq1T4D4sM8adfeOW4tHnwdsFM
        tDReSivJFq2dFIU8x4uT8egif1Fe70rXpMuFPykNb3Auhj8TFJFlK996myycEqPO613WqJ
        2TaCPkxf42vTbxaGBCuU5uqLoTMKtVM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-YDIZk8rXOBiFKE6MoUUWkg-1; Thu, 04 May 2023 16:21:27 -0400
X-MC-Unique: YDIZk8rXOBiFKE6MoUUWkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4ECAB1C05AE5;
        Thu,  4 May 2023 20:21:27 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F92540BC799;
        Thu,  4 May 2023 20:21:26 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chuck Lever <cel@kernel.org>, hughd@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] shmem: stable directory cookies
Date:   Thu, 04 May 2023 16:21:24 -0400
Message-ID: <45D9DEAF-DC18-4DDD-8AFC-4314B7771FC4@redhat.com>
In-Reply-To: <30E5A657-4005-4126-A962-A8E6D90240AB@oracle.com>
References: <168175931561.2843.16288612382874559384.stgit@manet.1015granger.net>
 <20230502171228.57a906a259172d39542e92fb@linux-foundation.org>
 <30E5A657-4005-4126-A962-A8E6D90240AB@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2 May 2023, at 20:43, Chuck Lever III wrote:

>> On May 2, 2023, at 8:12 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Mon, 17 Apr 2023 15:23:10 -0400 Chuck Lever <cel@kernel.org> wrote:
>>
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> The current cursor-based directory cookie mechanism doesn't work
>>> when a tmpfs filesystem is exported via NFS. This is because NFS
>>> clients do not open directories: each READDIR operation has to open
>>> the directory on the server, read it, then close it. The cursor
>>> state for that directory, being associated strictly with the opened
>>> struct file, is then discarded.
>>>
>>> Directory cookies are cached not only by NFS clients, but also by
>>> user space libraries on those clients. Essentially there is no way
>>> to invalidate those caches when directory offsets have changed on
>>> an NFS server after the offset-to-dentry mapping changes.
>>>
>>> The solution we've come up with is to make the directory cookie for
>>> each file in a tmpfs filesystem stable for the life of the directory
>>> entry it represents.
>>>
>>> Add a per-directory xarray. shmem_readdir() uses this to map each
>>> directory offset (an loff_t integer) to the memory address of a
>>> struct dentry.
>>>
>>
>> How have people survived for this long with this problem?

They survived this long by not considering their current directory offset to
be a stationary position in the stream after removing chunks of that stream,
as per some POSIX.  However, git does this:

opendir
while getdents
    unlink(dentries)
closedir
assert(directory empty)

This pattern isn't guaranteed to always produce an empty directory, and
filesystems aren't wrong when it doesn't, but they could probably do better.

Libfs, on the other hand, conservatively closes and re-opens the directory
after removing some entries in order to ensure none are skipped.

> It's less of a problem without NFS in the picture; local
> applications can hold the directory open, and that preserves
> the seek cursor. But you can still trigger it.
>
> Also, a plurality of applications are well-behaved in this
> regard. It's just the more complex and more useful ones
> (like git) that seem to trigger issues.
>
> It became less bearable for NFS because of a recent change
> on the Linux NFS client to optimize directory read behavior:
>
> 85aa8ddc3818 ("NFS: Trigger the "ls -l" readdir heuristic sooner")

My ears burn again.

> Trond argued that tmpfs directory cookie behavior has always
> been problematic (eg broken) therefore this commit does not
> count as a regression. However, it does make tmpfs exports
> less usable, breaking some tests that have always worked.

As luck would have it, since on NFS the breakage also depends on the length
of the filenames.

It's also possible to fix git's remove_dir_recurse(), but making tmpfs have
stable directory offsets would be an improvement for everyone, and especially
for NFS.

>> It's a lot of new code -
>
> I don't feel that this is a lot of new code:
>
> include/linux/shmem_fs.h |    2
> mm/shmem.c               |  213 +++++++++++++++++++++++++++++++++++++++++++---
> 2 files changed, 201 insertions(+), 14 deletions(-)
>
> But I agree it might look a little daunting on first review.
> I am happy to try to break this single patch up or consider
> other approaches.
>
> We could, for instance, tuck a little more of this into
> lib/fs. Copying the readdir and directory seeking
> implementation from simplefs to tmpfs is one reason
> the insertion count is worrisome.
>
>
>> can we get away with simply disallowing
>> exports of tmpfs?
>
> I think the bottom line is that you /can/ trigger this
> behavior without NFS, just not as quickly. The threshold
> is high enough that most use cases aren't bothered by
> this right now.

Yes, you can run into this problem directly on tmpfs.

> We'd rather not disallow exporting tmpfs. It's a very
> good testing platform for us, and disallowing it would
> be a noticeable regression for some folks.
>
>
>> How can we maintain this?  Is it possible to come up with a test
>> harness for inclusion in kernel selftests?
>
> There is very little directory cookie testing that I know of
> in the obvious place: fstests. That would be where this stuff
> should be unit tested, IMO.

Yes, we could write a test, but a test failure shouldn't mean the
filesystem is wrong or broken.

Ben

