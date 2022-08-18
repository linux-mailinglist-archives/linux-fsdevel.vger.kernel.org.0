Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990BC598872
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbiHRQOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 12:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344262AbiHRQOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:14:21 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D804D4D7;
        Thu, 18 Aug 2022 09:14:20 -0700 (PDT)
Received: from [10.0.0.100] (cpe5896308f56e8-cm5896308f56e6.cpe.net.cable.rogers.com [99.255.30.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 104733F127;
        Thu, 18 Aug 2022 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660839256;
        bh=YZZSkhT+TTALwtfUjy6aWTR//Rq9MQ2cQ72rzDjTaGo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=eKZn0EnaLQ3LPA55KId1jrSyN9QJDFoGajfUjb4kCVLZw+GJfPoyEZk5YsBGY9MBs
         BD5uhH5otcM+iD4WwVifrNr5NL1BUfcSMeQnhx/CHDs9NWQTtQwx1gGwhuoQTCfKMQ
         uST4xRWXm8MKtsgcqv+2mfMMUaoVq3HafCDVAbqHwknm58OvYYcZd9zEcvuHOCriAW
         5f5enAoNjxCzorVuGXsIE8HVJabgP9KqXKSRwJtYh0VtfpPArngeXisaJpK+yDOAEe
         WaTsYv22CXUAmrDXOQbGO1R7EFcMRumQCCw3nOo7oiJ1DQDXooj3VDnRI/oZGvfm7y
         iW9MAUvGRwJEw==
Message-ID: <dc966283-d0b9-b411-0792-c8553b948c2e@canonical.com>
Date:   Thu, 18 Aug 2022 09:14:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [apparmor] Switching to iterate_shared
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        Hans de Goede <hdegoede@redhat.com>,
        devel@lists.orangefs.org, apparmor@lists.ubuntu.com,
        linux-unionfs@vger.kernel.org, codalist@coda.cs.cmu.edu,
        coda@cs.cmu.edu, linux-security-module@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <linkinjeon@kernel.org>, ocfs2-devel@oss.oracle.com
References: <YvvBs+7YUcrzwV1a@ZenIV>
 <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
 <Yvvr447B+mqbZAoe@casper.infradead.org>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <Yvvr447B+mqbZAoe@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/16/22 12:11, Matthew Wilcox wrote:
> On Tue, Aug 16, 2022 at 11:58:36AM -0700, Linus Torvalds wrote:
>> That said, our filldir code is still confusing as hell. And I would
>> really like to see that "shared vs non-shared" iterator thing go away,
>> with everybody using the shared one - and filesystems that can't deal
>> with it using their own lock.
>>
>> But that's a completely independent wart in our complicated filldir saga.
>>
>> But if somebody were to look at that iterate-vs-iterate_shared, that
>> would be lovely. A quick grep shows that we don't have *that* many of
>> the non-shared cases left:
>>
>>        git grep '\.iterate\>.*='
>>
>> seems to imply that converting them to a "use my own load" wouldn't be
>> _too_ bad.
>>
>> And some of them might actually be perfectly ok with the shared
>> semantics (ie inode->i_rwsem held just for reading) and they just were
>> never converted originally.
> 
> What's depressing is that some of these are newly added.  It'd be
> great if we could attach something _like_ __deprecated to things
> that checkpatch could pick up on.
> 
> fs/adfs/dir_f.c:        .iterate        = adfs_f_iterate,
> fs/adfs/dir_fplus.c:    .iterate        = adfs_fplus_iterate,
> 
> ADFS is read-only, so must be safe?
> 
> fs/ceph/dir.c:  .iterate = ceph_readdir,
> fs/ceph/dir.c:  .iterate = ceph_readdir,
> 
> At least CEPH has active maintainers, cc'd
> 
> fs/coda/dir.c:  .iterate        = coda_readdir,
> 
> Would anyone notice if we broke CODA?  Maintainers cc'd anyway.
> 
> fs/exfat/dir.c: .iterate        = exfat_iterate,
> 
> Exfat is a new addition, but has active maintainers.
> 
> fs/jfs/namei.c: .iterate        = jfs_readdir,
> 
> Maintainer cc'd
> 
> fs/ntfs/dir.c:  .iterate        = ntfs_readdir,         /* Read directory contents. */
> 
> Maybe we can get rid of ntfs soon.
> 
> fs/ocfs2/file.c:        .iterate        = ocfs2_readdir,
> fs/ocfs2/file.c:        .iterate        = ocfs2_readdir,
> 
> maintainers cc'd
> 
> fs/orangefs/dir.c:      .iterate = orangefs_dir_iterate,
> 
> New; maintainer cc'd
> 
> fs/overlayfs/readdir.c: .iterate        = ovl_iterate,
> 
> Active maintainer, cc'd
> 
> fs/proc/base.c: .iterate        = proc_##LSM##_attr_dir_iterate, \
> 
> Hmm.  We need both SMACK and Apparmor to agree to this ... cc's added.

This is fine for AppArmor


> 
> fs/vboxsf/dir.c:        .iterate = vboxsf_dir_iterate,
> 
> Also newly added.  Maintainer cc'd.
> 

