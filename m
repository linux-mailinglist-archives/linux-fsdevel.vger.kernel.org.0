Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B037B497A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Oct 2023 21:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbjJATwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 15:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjJATwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 15:52:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F91EC4;
        Sun,  1 Oct 2023 12:52:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B30C433C8;
        Sun,  1 Oct 2023 19:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696189970;
        bh=ZGQENGSahEoVx6fJGon6K+BHKe100DMoxRc4b9GoTCI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bfgNtGHVcUNLcRHC/fVp4HQ6w1RZv55FqcSjpnRdSfxh0B4BYrzD7aQms1eoxl+tx
         /mbFvokBAGso9Iof6HlThOsOca8o+OZt/gv56pBJPlFhf6eqhDr9BKy8FgaJjPBKuY
         n5VJNim+Ny1f95N4WSAqhInLl/wZ+kYOWRF91jJs=
Date:   Sun, 1 Oct 2023 12:52:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc:     shuah@kernel.org, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests:proc add missing field KSM in smaps_rollup[]
 array
Message-Id: <20231001125249.7c4fde44bf12ec7bd1ccf12a@linux-foundation.org>
In-Reply-To: <20230930122523.118173-1-swarupkotikalapudi@gmail.com>
References: <20230930122523.118173-1-swarupkotikalapudi@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 30 Sep 2023 17:55:23 +0530 Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com> wrote:

> Missing field KSM is added in g_smaps_rollup[] array as it
> fixes assert in function test_proc_pid_smaps_rollup()
> 
> Without this patchset test fails for "proc-empty-vm" as can be seen below:
> $make TARGETS="proc" kselftest
> ...
>   selftests: proc: proc-empty-vm
>   proc-empty-vm: proc-empty-vm.c:299: test_proc_pid_smaps_rollup:
>    Assertion `rv == sizeof(g_smaps_rollup) - 1' failed.
>   /usr/bin/timeout: the monitored command dumped core
>   Aborted
>   not ok 5 selftests: proc: proc-empty-vm # exit=134
> ...
> 
> With this patchset test passes for "proc-empty-vm" as can be seen below:
> $make TARGETS="proc" kselftest
> ....
> timeout set to 45
> selftests: proc: proc-empty-vm
> ok 5 selftests: proc: proc-empty-vm
> ....
> 

Thanks.  We fixed this in

commit 9d1be94df5acd486b157e85ffa53d344e5b17e22
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Thu Sep 7 14:10:12 2023 +0300

    selftests/proc: fixup proc-empty-vm test after KSM changes

