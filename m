Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A27158F0C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiHJQxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 12:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiHJQxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:53:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7292F1758F;
        Wed, 10 Aug 2022 09:53:15 -0700 (PDT)
Received: from localhost (modemcable141.102-20-96.mc.videotron.ca [96.20.102.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4E2A966019C1;
        Wed, 10 Aug 2022 17:53:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660150394;
        bh=Dxlub/En694B1OVwDjJc8t0TX0eJ/thQHwv6ZgyAFss=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=T3LUdJuYm6pho9zz3V+Hu1Z+mBuq56NgJIlemP6tGh4klBENeaYswfS6PYiFv9Yv+
         LupLBkAsxaJBuY6G+ziP1qBdhiUC0YejOfT99UGZZas8pKf9alnvLGekY4mXkP+PH/
         6H3EyQ7pR/zqWSbrksq4JXrmQ2G3HL6vXbOpp8XjblylzhMdD2rJsBs+UbOEoYDUH9
         Q7P2oiY6Ic+dbTYxWxf3dFkwa143H2ke5lfFqYuH8GOmLDxdBOHzvnoz8CPezYwMYz
         coHlw2dK0qd118LITxpwIQRxH2tkJCSlF0FMS7NnjzLHJ5ExL9oJdpfaNfA2djr4Bk
         tTO5BA1GQZuPg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Peter.Enderborg@sony.com
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH 0/5] Add process_memwatch syscall
References: <20220726161854.276359-1-usama.anjum@collabora.com>
        <456a8052-dfd2-e00c-6da7-fb5aa0c35f2c@sony.com>
Date:   Wed, 10 Aug 2022 12:53:07 -0400
In-Reply-To: <456a8052-dfd2-e00c-6da7-fb5aa0c35f2c@sony.com> (Peter's message
        of "Wed, 10 Aug 2022 09:22:02 +0000")
Message-ID: <87tu6kghvw.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Peter.Enderborg@sony.com" <Peter.Enderborg@sony.com> writes:
>>
>> This syscall can be used by the CRIU project and other applications which
>> require soft-dirty PTE bit information. The following operations are
>> supported in this syscall:
>> - Get the pages that are soft-dirty.
>> - Clear the pages which are soft-dirty.
>> - The optional flag to ignore the VM_SOFTDIRTY and only track per page
>> soft-dirty PTE bit
>>

Hi Peter,

(For context, I wrote a previous version of this patch and have been
working with Usama on the current patch).

> Why can it not be done as a IOCTL?

Considering an ioctl is basically a namespaced syscall with extra-steps,
surely we can do it :) There are a few reasons we haven't, though:

1) ioctl auditing/controling is much harder than syscall

2) There is a concern for performance, since this might be executed
frequently by windows applications running over wine.  There is an extra
cost with unnecessary copy_[from/to]_user that we wanted to avoid, even
though we haven't measured.

3) I originally wrote this at the time process_memadvise was merged.  I
felt it fits the same kind of interface exposed by
process_memadvise/process_mrelease,  recently merged.

4) Not obvious whether the ioctl would be against pagemap/clear_refs.
Neither file name describes both input and output semantics.

Obviously, all of those reasons can be worked around, and we can turn
this into an ioctl.

Thanks,

-- 
Gabriel Krisman Bertazi
