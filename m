Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30B3602674
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 10:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJRIII (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 04:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiJRIID (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:08:03 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9849D8994C;
        Tue, 18 Oct 2022 01:07:58 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id h25so6136365vkc.6;
        Tue, 18 Oct 2022 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jO2G7Ub06VleMOWVq2AgQtn2K7LEPw6osPGq9smEC0g=;
        b=Qj72GX4oleH7IfAejvfReKtTGZCyGUCV04JVN3A1gMdNAwRAdjDIXb33Wc+r7UUyJW
         /xzmRAg0EG6wp2O4X5XeixZ9t+FLM7XxwWRYO3934wIMU70dKbcW3scLJUbyYiO+QLcX
         aWVkYslvSD6louW5wA5onLXwUIDE6qnuPBXXkfpbDTSS8dXNBHrB+ttBLb0oo3eqvl1Q
         M0yZkJF3VPiDitM9KeupcLJJTnBZ/jjmrUpYzSMSyzZz74cMN2myoygEeTPB5XidjG8R
         2BN6VxsEamVgoicbz0ppXK6mw2ip4HaAZINF29MzP8ER6BDI7mIt9x4il5kHSZ9g0tA3
         zQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jO2G7Ub06VleMOWVq2AgQtn2K7LEPw6osPGq9smEC0g=;
        b=WdC6eAJLeJuPdv0GiIGZ8X7Wp8xKyUTIo3FTjLQGeB9iw5JjRzwk+cU19XQq+sRI5h
         Q0Z5SCKJj3svaLIi6qk+wAsc8w7UC7gRemEvtS+F5DI3vtdlvd7iyB0vpgoStBBiETJI
         H0tL0wVHAYh0zlsu4XuQJ56a1SoWtWD7IRvZXhOG0Znyib4lR+lpghAS/xsrN7vsJsw/
         EqIVg6hkhgaaOS3hpPWZqVsG5TR4KrhKHddfekS/y6W40KVXsnzwnT/kvv637d/afFLl
         r3bxhFSfTo7QFeQ8DFMdKqUoTWJPGKTI24qhR3e0uNPJMfxfpoHnUsHrz71RLcynqaC8
         39GA==
X-Gm-Message-State: ACrzQf07PtZKOVzzIrO3nR0D4h8Ptf/1ZPNSO6lFJkSsSCIdapt90Mco
        T7OYr2kTXganRLeqMyxXE8PF2knZ3Fje16eNyHM=
X-Google-Smtp-Source: AMsMyM45sAA7Ks+old6HyLd/Ohtxymz76NomUNpfTflxkWNGSL6yBW63n+wfgjozU8w4pa3NgeAtGcVB16xev3yMa2w=
X-Received: by 2002:a1f:60cd:0:b0:3ae:da42:89d0 with SMTP id
 u196-20020a1f60cd000000b003aeda4289d0mr677921vkb.15.1666080476704; Tue, 18
 Oct 2022 01:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com> <20221018041233.376977-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Oct 2022 11:07:45 +0300
Message-ID: <CAOQ4uxgnW1An-3FJvUfYoixeycZ0w=XDfU0fh6RdV4KM9DzX_g@mail.gmail.com>
Subject: Re: [PATCH 0/2] fsnotify: fix softlockups iterating over d_subdirs
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 7:12 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Hi Jan, Amir, Al,
>
> Here's my first shot at implementing what we discussed. I tested it using the
> negative dentry creation tool I mentioned in my previous message, with a similar
> workflow. Rather than having a bunch of threads accessing the directory to
> create that "thundering herd" of CPUs in __fsnotify_update_child_dentry_flags, I
> just started a lot of inotifywait tasks:
>
> 1. Create 100 million negative dentries in a dir
> 2. Use trace-cmd to watch __fsnotify_update_child_dentry_flags:
>    trace-cmd start -p function_graph -l __fsnotify_update_child_dentry_flags
>    sudo cat /sys/kernel/debug/tracing/trace_pipe
> 3. Run a lot of inotifywait tasks: for i in {1..10} inotifywait $dir & done
>
> With step #3, I see only one execution of __fsnotify_update_child_dentry_flags.
> Once that completes, all the inotifywait tasks say "Watches established".
> Similarly, once an access occurs in the directory, a single
> __fsnotify_update_child_dentry_flags execution occurs, and all the tasks exit.
> In short: it works great!
>
> However, while testing this, I've observed a dentry still in use warning during
> unmount of rpc_pipefs on the "nfs" dentry during shutdown. NFS is of course in
> use, and I assume that fsnotify must have been used to trigger this. The error
> is not there on mainline without my patch so it's definitely caused by this
> code. I'll continue debugging it but I wanted to share my first take on this so
> you could take a look.
>
> [ 1595.197339] BUG: Dentry 000000005f5e7197{i=67,n=nfs}  still in use (2) [unmount of rpc_pipefs rpc_pipefs]
>

Hmm, the assumption we made about partial stability of d_subdirs
under dir inode lock looks incorrect for rpc_pipefs.
None of the functions that update the rpc_pipefs dcache take the parent
inode lock.

The assumption looks incorrect for other pseudo fs as well.

The other side of the coin is that we do not really need to worry
about walking a huge list of pseudo fs children.

The question is how to classify those pseudo fs and whether there
are other cases like this that we missed.

Perhaps having simple_dentry_operationsis a good enough
clue, but perhaps it is not enough. I am not sure.

It covers all the cases of pseudo fs that I know about, so you
can certainly use this clue to avoid going to sleep in the
update loop as a first approximation.

I can try to figure this out, but I prefer that Al will chime in to
provide reliable answers to those questions.

Thanks,
Amir.
