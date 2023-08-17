Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF8177F9A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352269AbjHQOt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352337AbjHQOtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6A53591
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692283672;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9oGZA/sseErZDodfZN5CQ2lHc0bZoWdbDZNY06uW8a8=;
        b=bFfgoJQic3ILauNMDs+YZl5UmvP/OZZXFLjWzRaOlXtDR2aq4LKLs+iHXEbXskMa3Tv+7z
        pVcAl5MwwH8/4ev+eO0xdP0VEw2zm4iufNisrQyC4xFeMz8kKkq0C3i6iYEnuWtYgLxfDt
        Jm+nHz9sPdYgs4vamqHDZPL6naihHAc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-kwUIKKNtOheT4SG0N-EgsA-1; Thu, 17 Aug 2023 10:47:51 -0400
X-MC-Unique: kwUIKKNtOheT4SG0N-EgsA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-34916ad5387so69136135ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 07:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283670; x=1692888470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9oGZA/sseErZDodfZN5CQ2lHc0bZoWdbDZNY06uW8a8=;
        b=Oa8huUt5TN3w+VLEo6q3OP6GmS3k+MM/1HXv3eWyXE2+cHbPIsbz16VL1bGOyrXhAP
         FeG2/G7B8KJTrmuGFdYiD+zYQWOqAp7RGAnNhSvQf59k1YqZe9gbS2sO0HJIoGdz5hVE
         qlGCufT/5fZLSsAHQvfugIvSg/f94m2fRjxAvcjS0OGaSzSDd/hHpZNeYeUQQZaNs2+y
         V/yQjm1ATEB9+AU+qrF6Yyv4No8TP79AKik074zL0Mi0CqPJADUhyMWx1DVB3e2iBIL3
         Auxph2+2lOfX0HjkCdRJY1EcJIAjKFJRk6jnrrhciDAW4Vt9lvRdld57AribE6Ow7kFJ
         X8Ig==
X-Gm-Message-State: AOJu0YwSYu38QpscEEQOyrtD6+BFEBK167k+uf/hCp9tprceohrVTX2a
        uMpEczRt8tOa9+6Z3wrdhLxxmorTGwlAPWrzSP+uVCADTvbfUJc0og+Bo6GXbYHhDOgtqP6Mn45
        1VxzqR61PEtUwtJZt/usrpAelBQ==
X-Received: by 2002:a05:6e02:1253:b0:34b:f3b:77b5 with SMTP id j19-20020a056e02125300b0034b0f3b77b5mr2475659ilq.30.1692283670610;
        Thu, 17 Aug 2023 07:47:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrQH+8rKQJl51yXYMvIpUQalzEERVfGo2BzoJLpqamdYa+T7EHfujOKoGDdR3fZK6apXThIA==
X-Received: by 2002:a05:6e02:1253:b0:34b:f3b:77b5 with SMTP id j19-20020a056e02125300b0034b0f3b77b5mr2475650ilq.30.1692283670364;
        Thu, 17 Aug 2023 07:47:50 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id l28-20020a02cd9c000000b0042acf389ac8sm4783835jap.130.2023.08.17.07.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 07:47:49 -0700 (PDT)
Message-ID: <81f96763-51fe-8ea1-bf81-cd67deed9087@redhat.com>
Date:   Thu, 17 Aug 2023 09:47:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Reply-To: sandeen@redhat.com
Subject: Re: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic
 forced after error (3)
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        syzbot <syzbot+27eece6916b914a49ce7@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
References: <000000000000530e0d060312199e@google.com>
 <20230817142103.GA2247938@mit.edu>
From:   Eric Sandeen <esandeen@redhat.com>
In-Reply-To: <20230817142103.GA2247938@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/17/23 9:21 AM, Theodore Ts'o wrote:
> On Wed, Aug 16, 2023 at 03:48:49PM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    ae545c3283dc Merge tag 'gpio-fixes-for-v6.5-rc6' of git://..
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e5d553a80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=171b698bc2e613cf
>> dashboard link: https://syzkaller.appspot.com/bug?extid=27eece6916b914a49ce7
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13433207a80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109cd837a80000
>>
>> EXT4-fs error (device loop0): ext4_validate_block_bitmap:430: comm syz-executor211: bg 0: block 46: invalid block bitmap
>> Kernel panic - not syncing: EXT4-fs (device loop0): panic forced after error
> 
> #syz invalid
> 
> This is fundamentally a syzbot bug.  The file system is horrifically
> corrupted, *and* the superblock has the "panic on error" (aka "panic
> onfile system corruption") bit set.
> 
> This can be desireable because in a failover situation, if the file
> system is found to be corrupted, you *want* the primary server to
> fail, and let the secondary server to take over.  This is a technique
> which is decades old.

Just to play devil's advocate here - (sorry) - I don't see this as any 
different from any other "malicious" filesystem image.

I've never been a fan of the idea that malicious images are real 
security threats, but whether the parking lot USB stick paniced the box 
in an unexpected way or "on purpose," the result is the same ...

I wonder if it might make sense to put EXT4_MOUNT_ERRORS_PANIC under a 
sysctl or something, so that admins can enable it only when needed.

Sorry for stealing another 5 minutes of your life.

-Eric

> So this is Working As Intended, and is a classic example of (a) if you
> are root, you can force the file system to crash, and (b) a classic
> example of syzbot noise.  (Five minutes of my life that I'm never
> getting back.  :-)
> 
> 						- Ted
> 
> 

