Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE0E4BA48F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 16:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242613AbiBQPjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 10:39:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242609AbiBQPjq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:39:46 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0732B2E28
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 07:39:29 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id v5so2858434uam.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 07:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yHxgvVsxpthEVmLiai5gF7vNFYIGmARiH/7C2ZcyhIo=;
        b=Ry5+yXHj5O9DMYA4MK8SiKG5WSKqJul/uFABmLOR70Rd3PuqCyAFnGwXSUDRNCWv9u
         N+Dtm9W44csPcTCeWRLHyJ1qkKySMPXNUrNhMobS33zIz0mFkh+343n1AcQ45q4aIX9N
         35MfohTX7WY+hZyVTR7Svi4DoJkgXoXVfGh6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yHxgvVsxpthEVmLiai5gF7vNFYIGmARiH/7C2ZcyhIo=;
        b=PS36xOkxrfxVSCIfCzRxq1W2DS8xLCK6MfTUCOYbccqQXJvRo8WOTsPsbtwVEjr76o
         LUDVjTHsbbKyQfAPqiMppJm3xYG69M9xSu5SuFfkUBihG1dAYk/dsD96uFPikx5ovEOl
         p9OtP6J5Jt9KPxOPrkyNKSnyZAMk4u4yhqF0CMH/iO8nmEWjJy4GAfMay1kP4fajTYf1
         /TjupcbZF1GTW1rRtxEzkM8JRb99EIn8tqMsevuF+fad4LB61GVYtHh7Gan59yq1YLWv
         ap/PksHBpzjIYgfrmBuftkS+aVNgYB1m4DPiFRTy4mmImZZFP/6M1n+P7haEDBjgXzoX
         kbJg==
X-Gm-Message-State: AOAM533FHW+GO2Z7ujIzyjRQJUo74OAe8KwbBDet6bkN5qhGxPmMH2fD
        jrEeR6StvgcMI4SueRAZ+9riTdGbFmEWc1uZupKRmMCWHMk5kQ==
X-Google-Smtp-Source: ABdhPJww6HTWn5f6qN0PY4Zep2x6qLC9j1ZjYRENKQS09yezP66HlU1jQIXqFVu5UJRlea206kncKuQ7VWPTgiBjFzI=
X-Received: by 2002:a9f:3f8c:0:b0:33d:c02:c938 with SMTP id
 k12-20020a9f3f8c000000b0033d0c02c938mr1487587uaj.13.1645112368005; Thu, 17
 Feb 2022 07:39:28 -0800 (PST)
MIME-Version: 1.0
References: <6da4c709.5385.17ee910a7fd.Coremail.clx428@163.com>
In-Reply-To: <6da4c709.5385.17ee910a7fd.Coremail.clx428@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 17 Feb 2022 16:39:17 +0100
Message-ID: <CAJfpeguvqro7SUmve_dyMiPHn4_dzQR4MMJRwZyfq61k17N-jg@mail.gmail.com>
Subject: Re: Report a fuse deadlock scenario issue
To:     =?UTF-8?B?6ZmI56uL5paw?= <clx428@163.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 11 Feb 2022 at 14:55, =E9=99=88=E7=AB=8B=E6=96=B0 <clx428@163.com> =
wrote:
>
> Hi Miklos:
> I meet a dealock scenario on fuse. here are the 4 backtraces:
> PID: 301852  TASK: ffff80db78226c80  CPU: 93  COMMAND: "Thread-854"
> #0 [ffff000c1d88b9e0] __switch_to at ffff000080088738
> #1 [ffff000c1d88ba00] __schedule at ffff000080a06f48
> #2 [ffff000c1d88ba90] schedule at ffff000080a07620
> #3 [ffff000c1d88baa0] fuse_wait_on_page_writeback at ffff000001047418 [fu=
se]
> #4 [ffff000c1d88bb00] fuse_page_mkwrite at ffff000001047538 [fuse]
> #5 [ffff000c1d88bb40] do_page_mkwrite at ffff0000802cb77c
> #6 [ffff000c1d88bb90] do_fault at ffff0000802d1840
> #7 [ffff000c1d88bbd0] __handle_mm_fault at ffff0000802d3574
> #8 [ffff000c1d88bc90] handle_mm_fault at ffff0000802d37c0
> #9 [ffff000c1d88bcc0] do_page_fault at ffff000080a0ef94
> #10 [ffff000c1d88bdc0] do_translation_fault at ffff000080a0f32c
> #11 [ffff000c1d88bdf0] do_mem_abort at ffff0000800812cc
> #12 [ffff000c1d88bff0] el0_da at ffff000080083b20
>
> PID: 400127  TASK: ffff80d1a1c51f00  CPU: 91  COMMAND: "Thread-677"
> #0 [ffff000beb5e3a00] __switch_to at ffff000080088738
> #1 [ffff000beb5e3a20] __schedule at ffff000080a06f48
> #2 [ffff000beb5e3ab0] schedule at ffff000080a07620
> #3 [ffff000beb5e3ac0] fuse_wait_on_page_writeback at ffff000001047418 [fu=
se]
> #4 [ffff000beb5e3b20] fuse_page_mkwrite at ffff000001047538 [fuse]
> #5 [ffff000beb5e3b60] do_page_mkwrite at ffff0000802cb77c
> #6 [ffff000beb5e3bb0] do_wp_page at ffff0000802d0264
> #7 [ffff000beb5e3c00] __handle_mm_fault at ffff0000802d363c
> #8 [ffff000beb5e3cc0] handle_mm_fault at ffff0000802d37c0
> #9 [ffff000beb5e3cf0] do_page_fault at ffff000080a0ef94
> #10 [ffff000beb5e3df0] do_mem_abort at ffff0000800812cc
> #11 [ffff000beb5e3ff0] el0_da at ffff000080083b20
>
> PID: 178830  TASK: ffff80dc1704cd80  CPU: 64  COMMAND: "kworker/u259:11"
> #0 [ffff0000aab6b6f0] __switch_to at ffff000080088738
> #1 [ffff0000aab6b710] __schedule at ffff000080a06f48
> #2 [ffff0000aab6b7a0] schedule at ffff000080a07620
> #3 [ffff0000aab6b7b0] io_schedule at ffff00008012dbc4
> #4 [ffff0000aab6b7d0] __lock_page at ffff0000802854e0
> #5 [ffff0000aab6b870] write_cache_pages at ffff0000802987e8
> #6 [ffff0000aab6b990] fuse_writepages at ffff00000104ab6c [fuse]
> #7 [ffff0000aab6b9f0] do_writepages at ffff00008029b2e0
> #8 [ffff0000aab6ba70] __writeback_single_inode at ffff00008037f8b4
> #9 [ffff0000aab6bac0] writeback_sb_inodes at ffff000080380150
> #10 [ffff0000aab6bbd0] __writeback_inodes_wb at ffff0000803804c0
> #11 [ffff0000aab6bc20] wb_writeback at ffff000080380880
> #12 [ffff0000aab6bcd0] wb_workfn at ffff000080381470
> #13 [ffff0000aab6bdb0] process_one_work at ffff000080113428
> #14 [ffff0000aab6be00] worker_thread at ffff0000801136c0
> #15 [ffff0000aab6be70] kthread at ffff00008011ab60
>
> PID: 47324  TASK: ffff80db5a038000  CPU: 88  COMMAND: "Thread-2064"
> #0 [ffff000c2114b820] __switch_to at ffff000080088738
> #1 [ffff000c2114b840] __schedule at ffff000080a06f48
> #2 [ffff000c2114b8d0] schedule at ffff000080a07620
> #3 [ffff000c2114b8e0] io_schedule at ffff00008012dbc4
> #4 [ffff000c2114b900] __lock_page at ffff0000802854e0
> #5 [ffff000c2114b9a0] write_cache_pages at ffff0000802987e8
> #6 [ffff000c2114bac0] fuse_writepages at ffff00000104ab6c [fuse]
> #7 [ffff000c2114bb20] do_writepages at ffff00008029b2e0
> #8 [ffff000c2114bba0] __filemap_fdatawrite_range at ffff0000802883f8
> #9 [ffff000c2114bc60] file_write_and_wait_range at ffff0000802886f0
> #10 [ffff000c2114bca0] fuse_fsync_common at ffff0000010491d8 [fuse]
> #11 [ffff000c2114bd90] fuse_fsync at ffff00000104938c [fuse]
> #12 [ffff000c2114bdc0] vfs_fsync_range at ffff000080385938
> #13 [ffff000c2114bdf0] __arm64_sys_msync at ffff0000802dcf8c
> #14 [ffff000c2114be60] el0_svc_common at ffff000080097cbc
> #15 [ffff000c2114bea0] el0_svc_handler at ffff000080097df0
> #16 [ffff000c2114bff0] el0_svc at ffff000080084144
>
> The 4 threads write the same file, and deadlocked:
>   Thread 301852 gets the page 5 lock, and waiting on page 5 writeback is =
completed;
>   Thread 400127 gets the page 0 lock, and waiting on page 0 writeback is =
completed;
>   Thread 47324 is waiting page 5 lock, and already set page 0 - 4 to writ=
eback;
>   Thread 178830 is waiting page 0 lock, and already set page 5 - 6 to wri=
teback;

This last is not possible, because write_cache_pages() will always
return when it reached the end of the range and only the next
invocation will wrap around to the zero index page.  See this at the
end of write_cache_pages():

    if (wbc->range_cyclic && !done)
        done_index =3D 0;

Otherwise index will be monotonic increasing throughout a single
write_cache_pages() call.

That doesn't mean that there's no deadlock, this is pretty complex,
but there must be some other explanation.

Thanks,
Miklos
