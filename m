Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA67BB2AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 09:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjJFHvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 03:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjJFHvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 03:51:44 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14A1F1;
        Fri,  6 Oct 2023 00:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iuK03HmNqgCaa8FhOu7IDj+wgutL2t54fgRlwMCc6iw=; b=kNuCrFaW39RlsEpKJf9vOpPzHH
        zG02syRAUaeEW3/ocBPYR5/3Azpku/r4b9FBl+74anGSuXuNQ6AoLh4GMMZ2fvw0yun0XQvMwNe7J
        abBUjM8Y8SqAsG+/wp5xZx3VomD6AWyfmfoiNHZNpUfUQdlaSpGcfiNvlK+K4GPR08q2XbxsgV88u
        xH6OLHi34c0g7LmuTmvQ1I5TAL9rvKbJzaQgQ5nJt7d/m7ePqokcqfk8y9L7WP4gHwh/S9hz2oTBP
        jYjqDD7KgSnBw7BftXI1jZcwGXIrPqG3xbCAU4RXwDi6x8LWigcrWPqO/Dt5MmW3Ui4OsfYMfCRas
        OXgWUSuA==;
Received: from cpe90-146-105-192.liwest.at ([90.146.105.192] helo=[192.168.178.99])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qofcU-00CTMq-7L; Fri, 06 Oct 2023 09:51:34 +0200
Message-ID: <31021a6a-4238-5fb0-45a9-2ea95d6b73e7@igalia.com>
Date:   Fri, 6 Oct 2023 09:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 0/2] Introduce a way to expose the interpreted file
 with binfmt_misc
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        keescook@chromium.org, ebiederm@xmission.com, oleg@redhat.com,
        yzaikin@google.com, mcgrof@kernel.org, akpm@linux-foundation.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk, willy@infradead.org,
        david@redhat.com, dave@stgolabs.net, sonicadvance1@gmail.com,
        joshua@froggi.es
References: <20230907204256.3700336-1-gpiccoli@igalia.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230907204256.3700336-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/09/2023 22:24, Guilherme G. Piccoli wrote:
> Currently the kernel provides a symlink to the executable binary, in the
> form of procfs file exe_file (/proc/self/exe_file for example). But what
> happens in interpreted scenarios (like binfmt_misc) is that such link
> always points to the *interpreter*. For cases of Linux binary emulators,
> like FEX [0] for example, it's then necessary to somehow mask that and
> emulate the true binary path.
> 
> We hereby propose a way to expose such interpreted binary as exe_file if
> the flag 'I' is selected on binfmt_misc. When that flag is set, the file
> /proc/self/exe_file points to the *interpreted* file, be it ELF or not.
> In order to allow users to distinguish if such flag is used or not without
> checking the binfmt_misc filesystem, we propose also the /proc/self/interpreter
> file, which always points to the *interpreter* in scenarios where
> interpretation is set, like binfmt_misc. This file is empty / points to
> nothing in the case of regular ELF execution, though we could consider
> implementing a way to point to the LD preloader if that makes sense...
> 
> This was sent as RFC because of course it's a very core change, affecting
> multiple areas and there are design choices (and questions) in each patch
> so we could discuss and check the best way to implement the solution as
> well as the corner cases handling. This is a very useful feature for
> emulators and such, like FEX and Wine, which usually need to circumvent
> this kernel limitation in order to expose the true emulated file name
> (more examples at [1][2][3]).
> 
> This patchset is based on the currently v6.6-rc1 candidate (Linus tree
> from yesterday) and was tested under QEMU as well as using FEX.
> Thanks in advance for comments, any feedback is greatly appreciated!
> Cheers,
> 
> Guilherme
> 
> 
> [0] https://github.com/FEX-Emu/FEX
> 
> [1] Using an environment variable trick to override exe_file:
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/util/u_process.c#L209 
> 
> [2] https://github.com/baldurk/renderdoc/pull/2694
> 
> [3] FEX handling of the exe_file parsing:
> https://github.com/FEX-Emu/FEX/blob/main/Source/Tools/FEXLoader/LinuxSyscalls/FileManagement.cpp#L499
> 
> 

Hi folks, gentle monthly ping.
Any opinions / suggestions on that?

Thanks in advance,


Guilherme
