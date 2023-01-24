Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469AA678E92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjAXCv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAXCvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:51:23 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC2512875;
        Mon, 23 Jan 2023 18:51:21 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id n7so12565080wrx.5;
        Mon, 23 Jan 2023 18:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gAY8vTZyGk4M83RejMJDWSVQbhO5UIeP+/JnuniVPrg=;
        b=S2EsGrQuOEU3Y4RGr7uuVf6dI5nPSlI0GiuLVrqgLazzWYX90iOjMzZYyVgMddzVsX
         w25hR1vptvZlEFwB0eyVraN5Qvzn84zZ8lb9TG3E8lT8wKDXRpBUzLyopqBno9Be3kAu
         HsJ1gZ60PCggsTDTxlLQ/D8o5TDpJcmshYmhqLneSeHjAOSyU4GNB3nfsfYgPjbzcD9N
         PrNH+lW9zs8irTLqDMrkXcNHjI0a27JOWm9htzAag+2PFbTHoZSMmoxOstSbPBiLdZbr
         MStHGVmBFjOlqlj4cVKQmTCLeen9k0uw9biauAa4u0l8JJgxOtx8DQb8shfd9H5ZDECp
         MQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAY8vTZyGk4M83RejMJDWSVQbhO5UIeP+/JnuniVPrg=;
        b=F+CaRI50BwA2THGPdYkSdt0jm/VauLkQTqYNhoYzD1sQQEZzKkRPtdhZZq/RachUnW
         mndZbsdmYcdhl1D2Tg0zSSUucOT51cTqMbD3HZ5h+UyK9WyOR0lsqqRjfTHssXAFstHU
         B98P+jgEKVXFHRTdf9RqoKNpvPuYIxEc2X1HN56TSG4LrkPzlLVrGw+KC2D15G8SrHkc
         f2e00zUFQACJFCK6V8EQ7b+udj+VNAPV+zA41if4n+s7f34ZklQUz6SN7B+kqp/A2/Xf
         gDUc1HGhpdujbtgcPIPU/IKoo/53UfMD4J4DfyM4+2C8s8+oaYlAgsn/mXUtt0C/RQjr
         LXSw==
X-Gm-Message-State: AFqh2krIOW6KBbdVUz/Z96iIRDp6mwrMx48l389SK1zPWnNlJJQcb93L
        h2oaEwGFBpo7kL9YYlIsAlrbv69dZdIXWRiBe0M=
X-Google-Smtp-Source: AMrXdXtE2KHUJeDVXhPQUTYkHKp8SQa1hujduK30aDNEeyEHd80uFa/sA9H62IvvTm5YgT/eugKtTOl8LOGRi8K5uU8=
X-Received: by 2002:a5d:4851:0:b0:2be:575:2e07 with SMTP id
 n17-20020a5d4851000000b002be05752e07mr675943wrs.111.1674528680274; Mon, 23
 Jan 2023 18:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20230123032942.18263-1-gregory.price@memverge.com> <20230123032942.18263-4-gregory.price@memverge.com>
In-Reply-To: <20230123032942.18263-4-gregory.price@memverge.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Mon, 23 Jan 2023 18:51:07 -0800
Message-ID: <CANaxB-x86NUAYG1F2+-uOj676weVOdy9aKnmxjaHTuNxek28gg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter for
 sud configuration
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
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

On Sun, Jan 22, 2023 at 8:22 PM Gregory Price <gourry.memverge@gmail.com> wrote:
<snip>
>
> +#define PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG 0x4210
> +#define PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG 0x4211
> +struct syscall_user_dispatch_config {
> +       __u64 mode;
> +       __s8 *selector;
> +       __u64 offset;
> +       __u64 len;
> +       __u8 on_dispatch;

Sorry, I didn't notice this in the previous version. on_dispatch looks
like an internal
property and I don't see how we can stop a process with ptrace when on_dispatch
is set to a non-zero value. I am not sure that we need to expose it to
user-space.

Other than that, the patch looks good to me.

Thanks,
Andrei
