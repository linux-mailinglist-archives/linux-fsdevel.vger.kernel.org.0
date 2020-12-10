Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4DE2D6BB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 00:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbgLJXOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 18:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392230AbgLJXNi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:13:38 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FC5C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 15:12:58 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so5654728pfu.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 15:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9be1EW16j48dFNmESe2euNf4bUd89KQ9yIyv1FlkZIs=;
        b=FVfcByTrfu0JldVTolms0LyhJMCZaOxulZwVFROfb9D12L8L3/a1aq2GTWiwPdLhsB
         GE5x1IczmWhkYdKgvGzNc+sXIZ452/hcRgx4x4WiDCrjApelugIJS0coqRfrh0dDrFuK
         +uNc6oWqFwUiTqadS+gFqFGhgsswH3MCrzKzMoMGjAfFc/f45oIY+Bu2uX5J0NayCyA3
         izkmECkg1oxxa5Fz5pRxVAuGFtb+bR4CArwJQZZ72LJll98v8CJzTlHPI2IuqcXPbE5r
         smmJzV2Kp0MSp1StizTS8IlcAZ3KK8v3Xn918U8b/IjbodsHXeNVlt/Tz39sQjI5IPkc
         2huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9be1EW16j48dFNmESe2euNf4bUd89KQ9yIyv1FlkZIs=;
        b=sgCD2u/g2EYJACGmS01ArZ5RzA6Xa7UKlQyVh2b1f/MHDXxF8H6EAtoVmVitY50y+S
         DmXPrSwyvwh6Yuxm9CVY7m7/t3qlZ4HW5Zvl5pKBQLnblBFUWxoDjKMDp0D3DKGE+D8j
         Wod/nkZEoVDcwrHTSpWp69mh4W4UBtbEv38rSuvWBfFRhFETEjQ1Q1jPy9H0xXONlBYc
         PO3EXtu0LFMJq8+E1ImIrR7e2/CU3wXr7PGlGRUDSZDTUuGbHvZS3lDIsbEQ0LzCR+vJ
         KFHvXZdjN3YboOOqEOdhXCXrm0i/8FGe2268i4gZ+4X3p7FeX3IltIwPCdAoG+q02Jy8
         9f2w==
X-Gm-Message-State: AOAM533826QLZtSd8bEpS+xNC+hwZ8LGbBMztYKAzQTWbT2+kcDJ9/ga
        4eMtF99Y7P1Rs3wQ7HYoawrCxFjLTgWYfg==
X-Google-Smtp-Source: ABdhPJzDRSCn0oqaMHihwaX0t4iKzxoPR4SELL2U1l6Zt2XlwnsjyZA2qGej4mNUNzcgbUaPA93vHA==
X-Received: by 2002:a63:c04b:: with SMTP id z11mr7984250pgi.74.1607641977781;
        Thu, 10 Dec 2020 15:12:57 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b17sm7183752pfi.61.2020.12.10.15.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 15:12:57 -0800 (PST)
Subject: Re: [PATCH 2/2] fs: expose LOOKUP_NONBLOCK through openat2()
 RESOLVE_NONBLOCK
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
References: <20201210200114.525026-1-axboe@kernel.dk>
 <20201210200114.525026-3-axboe@kernel.dk>
 <20201210222934.GI4170059@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1cfde287-bae0-f0da-1da1-cbc3faf33a84@kernel.dk>
Date:   Thu, 10 Dec 2020 16:12:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210222934.GI4170059@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/20 3:29 PM, Dave Chinner wrote:
> On Thu, Dec 10, 2020 at 01:01:14PM -0700, Jens Axboe wrote:
>> Now that we support non-blocking path resolution internally, expose it
>> via openat2() in the struct open_how ->resolve flags. This allows
>> applications using openat2() to limit path resolution to the extent that
>> it is already cached.
>>
>> If the lookup cannot be satisfied in a non-blocking manner, openat2(2)
>> will return -1/-EAGAIN.
>>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/open.c                    | 2 ++
>>  include/linux/fcntl.h        | 2 +-
>>  include/uapi/linux/openat2.h | 2 ++
>>  3 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/open.c b/fs/open.c
>> index 9af548fb841b..07dc9f3d1628 100644
>> --- a/fs/open.c
>> +++ b/fs/open.c
>> @@ -1087,6 +1087,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>>  		lookup_flags |= LOOKUP_BENEATH;
>>  	if (how->resolve & RESOLVE_IN_ROOT)
>>  		lookup_flags |= LOOKUP_IN_ROOT;
>> +	if (how->resolve & RESOLVE_NONBLOCK)
>> +		lookup_flags |= LOOKUP_NONBLOCK;
>>  
>>  	op->lookup_flags = lookup_flags;
>>  	return 0;
>> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
>> index 921e750843e6..919a13c9317c 100644
>> --- a/include/linux/fcntl.h
>> +++ b/include/linux/fcntl.h
>> @@ -19,7 +19,7 @@
>>  /* List of all valid flags for the how->resolve argument: */
>>  #define VALID_RESOLVE_FLAGS \
>>  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
>> -	 RESOLVE_BENEATH | RESOLVE_IN_ROOT)
>> +	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_NONBLOCK)
>>  
>>  /* List of all open_how "versions". */
>>  #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
>> diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
>> index 58b1eb711360..ddbf0796841a 100644
>> --- a/include/uapi/linux/openat2.h
>> +++ b/include/uapi/linux/openat2.h
>> @@ -35,5 +35,7 @@ struct open_how {
>>  #define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
>>  					be scoped inside the dirfd
>>  					(similar to chroot(2)). */
>> +#define RESOLVE_NONBLOCK	0x20 /* Only complete if resolution can be
>> +					done without IO */
> 
> I don't think this describes the implementation correctly - it has
> nothing to actually do with whether IO is needed, just whether the
> lookup can be done without taking blocking locks. The slow path can
> complete without doing IO - it might miss the dentry cache but hit
> the filesystem buffer cache on lookup and the inode cache when
> retrieving the inode. And it may not even block anywhere doing this.
> 
> So, really, this isn't avoiding IO at all - it's avoiding the
> possibility of running a lookup path that might blocking on
> something.

Right, it's about not blocking, as the commit message says. That could
be IO, either directly or indirectly, or it could be just locking. I'll
update this comment.

> This also needs a openat2(2) man page update explaining exactly what
> behaviour/semantics this flag provides and that userspace can rely
> on when this flag is set...

Agree, I'll add that.

> We've been failing to define the behaviour of our interfaces clearly,
> especially around non-blocking IO behaviour in recent times. We need
> to fix that, not make matters worse by adding new, poorly defined
> non-blocking behaviours...

Also agree on that! It doesn't help that different folks have different
criteria of what nowait/nonblock means...

> I'd also like to know how we actually test this is working- a
> reliable regression test for fstests would be very useful for
> ensuring that the behaviour as defined by the man page is not broken
> accidentally by future changes...

Definitely. On the io_uring side, I generally run with a debug patch
that triggers if anything blocks off the submission path. That won't
really work for this one, however.

FWIW, I'm quite fine deferring this patch, I obviously care more about
the io_uring side of things. It seems like a no-brainer to support for
openat2 though, as it would allow applications to decide when to punt
open to another thread. Since this one ties in very closely with
LOOKUP_RCU, I'm not _too_ worried about this one in particular. But it
would be great to have something that we could use with eg RWF_NOWAIT as
well, and similar constructs. I'll give it some thought.

-- 
Jens Axboe

