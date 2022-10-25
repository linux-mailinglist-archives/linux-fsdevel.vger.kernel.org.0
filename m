Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C001760D707
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 00:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiJYW0Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 18:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiJYWZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:25:59 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE9DCE9B4
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 15:25:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 78so12918210pgb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfUwPkkWvWRH7D0jic4UzLRvzXiFnNnqQdHiOc474w4=;
        b=X81xPrHAJB8kKGIX9N34GO+pUJhjd0vTSsPqLbXZPbnwjhw78RSFkKX/ieyem911R5
         vn0YP9brTjXp2CKcqAxTTuhsFkGMkkbJSeJal6bAZHaMdMnU4oL5F7ZaV6+sbUjQOBsF
         e8mfAG7nfu7SJUEleArdeEKViZFX4gjE+8yY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfUwPkkWvWRH7D0jic4UzLRvzXiFnNnqQdHiOc474w4=;
        b=SY/D11e/VCXcUpm7U52pNJrVfQySbrdkuTrxZdZZE4ri3YWoeND3NJwJcse3sMtuGw
         MPewvFSvfgY6Gy/JX2PHOVoh6tbprQx1c0drxnUXIuvV1IYjJhRIj5YF7qmX2ELD3iq8
         Ra8QdjYVPw5/7tGBTKXEipn0yvZGq2pxf39iGsuIRhahL2GvIQgbPM+bJoN3kv6FMvQG
         b+S5CBhHAOyDk+CUwiY31I/blKb4T+I7FmfGEjSqrZyJ6FSjdAQCpAimBVdUBIP4+UMy
         nl/nqdum3TgtF4pHoa18vE3zRYy3VBCHMi+U71R2qGzmauZ0ZtrRjHNuNu/guqRhfE6v
         RULg==
X-Gm-Message-State: ACrzQf2u1zJ5vPqkyMQ/8IFAmbMODFk0Hc9F5ZoCsTujWZbx1RTpCctA
        +pHfwIz0j2eSnVivPNEtknPIOg==
X-Google-Smtp-Source: AMsMyM6BfIf8gI4+orMuLMLulOzofOtWVpprVt+MKJeR7Vf9gJoXQ8G6kX4U/nRDcdT0HEkPtm8YpQ==
X-Received: by 2002:a63:2c4c:0:b0:434:e001:89fd with SMTP id s73-20020a632c4c000000b00434e00189fdmr34519522pgs.444.1666736730605;
        Tue, 25 Oct 2022 15:25:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902dacf00b0018685257c0dsm1671942plx.58.2022.10.25.15.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:25:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, adobriyan@gmail.com,
        ebiederm@xmission.com, lizetao1@huawei.com
Cc:     Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        chengzhihao1@huawei.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, yi.zhang@huawei.com
Subject: Re: [PATCH] fs/binfmt_elf: Fix memory leak in load_elf_binary()
Date:   Tue, 25 Oct 2022 15:24:41 -0700
Message-Id: <166673667327.2128117.4844279671091670952.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221024154421.982230-1-lizetao1@huawei.com>
References: <20221024154421.982230-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 24 Oct 2022 23:44:21 +0800, Li Zetao wrote:
> There is a memory leak reported by kmemleak:
> 
>   unreferenced object 0xffff88817104ef80 (size 224):
>     comm "xfs_admin", pid 47165, jiffies 4298708825 (age 1333.476s)
>     hex dump (first 32 bytes):
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>       60 a8 b3 00 81 88 ff ff a8 10 5a 00 81 88 ff ff  `.........Z.....
>     backtrace:
>       [<ffffffff819171e1>] __alloc_file+0x21/0x250
>       [<ffffffff81918061>] alloc_empty_file+0x41/0xf0
>       [<ffffffff81948cda>] path_openat+0xea/0x3d30
>       [<ffffffff8194ec89>] do_filp_open+0x1b9/0x290
>       [<ffffffff8192660e>] do_open_execat+0xce/0x5b0
>       [<ffffffff81926b17>] open_exec+0x27/0x50
>       [<ffffffff81a69250>] load_elf_binary+0x510/0x3ed0
>       [<ffffffff81927759>] bprm_execve+0x599/0x1240
>       [<ffffffff8192a997>] do_execveat_common.isra.0+0x4c7/0x680
>       [<ffffffff8192b078>] __x64_sys_execve+0x88/0xb0
>       [<ffffffff83bbf0a5>] do_syscall_64+0x35/0x80
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] fs/binfmt_elf: Fix memory leak in load_elf_binary()
      https://git.kernel.org/kees/c/594d2a14f216

-- 
Kees Cook

