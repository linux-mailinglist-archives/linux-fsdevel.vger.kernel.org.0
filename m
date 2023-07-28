Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EEC766C0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbjG1Ltp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 07:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjG1Ltn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7B63C2F
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 04:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690544931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amggK1c1iFQcIsltx9iiMJ/J2TdCT43VOB9zNEC3MjI=;
        b=XaA2Ymu3O+5JsaHScx6dm4yid9YJkBftsU4KEZRPf20w43437oGkoYb6HAnjQXkChHW5OI
        k9Qlnc4nQiNb20II50tGcxEvDm4RwND206QcodaKJySHIZvWs0/X+Ndx2f5kjeE/MoWXgF
        w/g8xRhQ0je7NMcB5BEup3cohxLeG3w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-0w7W7exxNu2uZdYHX42iuw-1; Fri, 28 Jul 2023 07:48:49 -0400
X-MC-Unique: 0w7W7exxNu2uZdYHX42iuw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-63cf3d966e1so22730216d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 04:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690544929; x=1691149729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amggK1c1iFQcIsltx9iiMJ/J2TdCT43VOB9zNEC3MjI=;
        b=cKc6u1yIDpSEKMOjb1tOwh11Kc0yf1RNP/NFnHeqPaiip4TuBhI+oKdXcw+rDSWcoL
         WNdSyN5nDiNj6y9Rz1Hv8rGIinEKIDgpgE7wtKjoL1Y5IIjwMYwb4DiUwGZn6lIzX1+d
         smvzXNFID44oe+yuFgZc4zZuByFKYxNHlmuxmoDBHp+G2/dSfuTbDnIu5hyE5HqrsFGN
         S2HQK8jdC1OrZ/sdjfGMnp7M2y850iXdOsgRbxF/z4rfF9AAo2zHeB7IOYggqA5tmk1R
         k+zVymyMRzbTYZNryxD0dQqCsT4sLCCRnxA94kdp8WzKiPofQeDJc910LJ385NKVIOLW
         AbNA==
X-Gm-Message-State: ABy/qLZbiuLM8Fmt/6Cf06cLE4WhDUwVjTatvyNKe+zc3lsnDFJQoct/
        S/NMxE+ScWb+EHlNP+23jNjmsUenWVw+hRDYNuiVE92Km7qWJHFnTDqrXxRjSodSfCNOrNUZYmf
        DdToLR9NLDBmt0Q4OTKKi6DP8rA==
X-Received: by 2002:a05:622a:170c:b0:403:a263:5402 with SMTP id h12-20020a05622a170c00b00403a2635402mr2914428qtk.18.1690544929315;
        Fri, 28 Jul 2023 04:48:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF4HP9emyj8PfcdfRAEbYECoLJjWWPCTFXihnHLKkpiXAxEqfjwIUSpFIWY/4/sObMMv7h2zQ==
X-Received: by 2002:a05:622a:170c:b0:403:a263:5402 with SMTP id h12-20020a05622a170c00b00403a2635402mr2914415qtk.18.1690544929078;
        Fri, 28 Jul 2023 04:48:49 -0700 (PDT)
Received: from [172.16.0.7] ([209.73.90.46])
        by smtp.gmail.com with ESMTPSA id c26-20020ac81e9a000000b00403fcd4ea59sm1099677qtm.10.2023.07.28.04.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:48:48 -0700 (PDT)
Message-ID: <c4360163-3595-e152-765d-641f9c79e8fd@redhat.com>
Date:   Fri, 28 Jul 2023 06:48:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [gfs2?] kernel panic: hung_task: blocked tasks (2)
To:     David Howells <dhowells@redhat.com>,
        syzbot <syzbot+607aa822c60b2e75b269@syzkaller.appspotmail.com>
Cc:     agruenba@redhat.com, arnd@arndb.de, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <00000000000045a44b0601802056@google.com>
 <200478.1690532408@warthog.procyon.org.uk>
Content-Language: en-US
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <200478.1690532408@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/28/23 3:20 AM, David Howells wrote:
> syzbot <syzbot+607aa822c60b2e75b269@syzkaller.appspotmail.com> wrote:
> 
>> Fixes: 9c8ad7a2ff0b ("uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]")
> 
> This would seem unlikely to be the culprit.  It just changes the numbering on
> the fsconfig-related syscalls.
> 
> Running the test program on v6.5-rc3, however, I end up with the test process
> stuck in the D state:
> 
> INFO: task repro-17687f1aa:5551 blocked for more than 120 seconds.
>        Not tainted 6.5.0-rc3-build3+ #1448
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:repro-17687f1aa state:D stack:0     pid:5551  ppid:5516   flags:0x00004002
> Call Trace:
>   <TASK>
>   __schedule+0x4a7/0x4f1
>   schedule+0x66/0xa1
>   schedule_timeout+0x9d/0xd7
>   ? __next_timer_interrupt+0xf6/0xf6
>   gfs2_gl_hash_clear+0xa0/0xdc
>   ? sugov_irq_work+0x15/0x15
>   gfs2_put_super+0x19f/0x1d3
>   generic_shutdown_super+0x78/0x187
>   kill_block_super+0x1c/0x32
>   deactivate_locked_super+0x2f/0x61
>   cleanup_mnt+0xab/0xcc
>   task_work_run+0x6b/0x80
>   exit_to_user_mode_prepare+0x76/0xfd
>   syscall_exit_to_user_mode+0x14/0x31
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f89aac31dab
> RSP: 002b:00007fff43d9b878 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 00007fff43d9cad8 RCX: 00007f89aac31dab
> RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fff43d9b920
> RBP: 00007fff43d9c960 R08: 0000000000000000 R09: 0000000000000073
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 00007fff43d9cae8 R14: 0000000000417e18 R15: 00007f89aad51000
>   </TASK>
> 
> David
> 
Hi David,

This indicates gfs2 is having trouble resolving and freeing all its 
glocks, which usually means a reference counting problem or ail (active 
items list) problem during unmount.

If gfs2_gl_hash_clear gets stuck for a long period of time it is 
supposed to dump the remaining list of glocks that still have not been 
resolved. I think it takes 10 minutes or so. Can you post the console 
messages that follow? That will help us figure out what's happening. Thanks.

Regards,

Bob Peterson

