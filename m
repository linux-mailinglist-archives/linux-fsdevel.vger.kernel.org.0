Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65F368AC4D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 21:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjBDUpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 15:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjBDUpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 15:45:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4922A174
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Feb 2023 12:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675543475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8QKJhwga1LUfiiQV81vkkFNu406gHthME90UcHxWX+Q=;
        b=WIwY9lwlj6FSQh63oVe0/F8rCmPjUkprdsOPgfaNzDHIXkvR6fz2mZIaHBpbSj5BNEQGhX
        ZIGsftmGrzb+Sm85wZt96LTOMgaSeIRSPn5zDw6G72JxurP7gEUsg5KHrZ3d8yA+N5GBw7
        dgCOG3unSd1PkM8qOwBut/fCt4nyQEM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-tpgEyjV5OjCH4hZFdBJAvA-1; Sat, 04 Feb 2023 15:44:29 -0500
X-MC-Unique: tpgEyjV5OjCH4hZFdBJAvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 276A6185A78B;
        Sat,  4 Feb 2023 20:44:29 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65647112132C;
        Sat,  4 Feb 2023 20:44:27 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Hugh Dickins <hughd@google.com>,
        Charles Edward Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: git regression failures with v6.2-rc NFS client
Date:   Sat, 04 Feb 2023 15:44:26 -0500
Message-ID: <05BEEF62-46DF-4FAC-99D4-4589C294F93A@redhat.com>
In-Reply-To: <031C52C0-144A-4051-9B4C-0E1E3164951E@hammerspace.com>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
 <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
 <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
 <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
 <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com>
 <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com>
 <41813D21-95C8-44E3-BB97-1E9C03CE7FE5@redhat.com>
 <79261B77-35D0-4E36-AA29-C7BF9FB734CC@oracle.com>
 <104B6879-5223-485F-B099-767F741EB15B@redhat.com>
 <966AEC32-A7C9-4B97-A4F7-098AF6EF0067@oracle.com>
 <545B5AB7-93A6-496E-924E-AE882BF57B72@hammerspace.com>
 <FA8392E6-DAFC-4462-BDAE-893955F9E1A4@oracle.com>
 <4dd32d-9ea3-4330-454a-36f1189d599@google.com>
 <0D7A0393-EE80-4785-9A83-44CF8269758B@hammerspace.com>
 <ab632691-7e4c-ccbf-99a0-397f1f7d30ec@google.com>
 <8B4F6A20-D7A4-4A22-914C-59F5EA79D252@hammerspace.com>
 <c5259e81-631e-7877-d3b0-5a5a56d35b42@leemhuis.info>
 <15679CC0-6B56-4F6D-9857-21DCF1EFFF79@redhat.com>
 <031C52C0-144A-4051-9B4C-0E1E3164951E@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4 Feb 2023, at 11:52, Trond Myklebust wrote:
> On Feb 4, 2023, at 08:15, Benjamin Coddington <bcodding@redhat.com> wrote:
>> Ah, thanks for explaining that.
>>
>> I'd like to summarize and quantify this problem one last time for folks that
>> don't want to read everything.  If an application wants to remove all files
>> and the parent directory, and uses this pattern to do it:
>>
>> opendir
>> while (getdents)
>>    unlink dents
>> closedir
>> rmdir
>>
>> Before this commit, that would work with up to 126 dentries on NFS from
>> tmpfs export.  If the directory had 127 or more, the rmdir would fail with
>> ENOTEMPTY.
>
> For all sizes of filenames, or just the particular set that was chosen
> here? What about the choice of rsize? Both these values affect how many
> entries glibc can cache before it has to issue another getdents() call
> into the kernel. For the record, this is what glibc does in the opendir()
> code in order to choose a buffer size for the getdents syscalls:
>
>   /* The st_blksize value of the directory is used as a hint for the
>      size of the buffer which receives struct dirent values from the
>      kernel.  st_blksize is limited to max_buffer_size, in case the
>      file system provides a bogus value.  */
>   enum { max_buffer_size = 1048576 };
>
>   enum { allocation_size = 32768 };
>   _Static_assert (allocation_size >= sizeof (struct dirent64),
>                   "allocation_size < sizeof (struct dirent64)");
>
>   /* Increase allocation if requested, but not if the value appears to
>      be bogus.  It will be between 32Kb and 1Mb.  */
>   size_t allocation = MIN (MAX ((size_t) statp->st_blksize, (size_t)
>                                 allocation_size), (size_t) max_buffer_size);
>
>   DIR *dirp = (DIR *) malloc (sizeof (DIR) + allocation);

The behavioral complexity is even higher with glibc in the mix, but both the
test that Chuck's using and the reproducer I've been making claims about
use SYS_getdents directly.  I'm using a static 4k buffer size which is big
enough to fit enough entries to prime the heuristic for a single call to
getdents() whether or not we return early at 17 or 126.

>> After this commit, it only works with up to 17 dentries.
>>
>> The argument that this is making things worse takes the position that there
>> are more directories in the universe with >17 dentries that want to be
>> cleaned up by this "saw off the branch you're sitting on" pattern than
>> directories with >127.  And I guess that's true if Chuck runs that testing
>> setup enough.  :)
>>
>> We can change the optimization in the commit from
>> NFS_READDIR_CACHE_MISS_THRESHOLD + 1
>> to
>> nfs_readdir_array_maxentries + 1
>>
>> This would make the regression disappear, and would also keep most of the
>> optimization.
>>
>> Ben
>>
>
> So in other words the suggestion is to optimise the number of readdir
> records that we return from NFS to whatever value that papers over the
> known telldir()/seekdir() tmpfs bug that is re-revealed by this particular
> test when run under these particular conditions?

Yes.  It's a terrible suggestion.  Its only merit may be that it meets the
letter of the no regressions law.  I hate it, and I after I started popping
out patches that do it I've found they've all made the behavior far more
complex due to the way we dynamically optimize dtsize.

> Anyone who tries to use tmpfs with a different number of files, different
> file name lengths, or different mount options is still SOL because that’s
> not a “regression"?

Right. :P

Ben

