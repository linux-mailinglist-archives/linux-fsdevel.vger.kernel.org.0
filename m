Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED843E9BCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 03:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhHLBJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 21:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhHLBJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:09:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5ADC061765;
        Wed, 11 Aug 2021 18:08:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z20so9973401lfd.2;
        Wed, 11 Aug 2021 18:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6MbjmzBnwM6gjnG7Cc/YOmrr7HwaCTb5NruG7e2TxrA=;
        b=PrVUN0df8cRryRb5/kqtkJINDrWtN1NPNMcAoKTLIrZKL77uTNxavXiQUBdjBxnWz3
         uXEYlfVZ0s1Mqa1RrOuucScEjH004NB3c66AfPgQMXmxizngv6kSEd1Lb/FZtEQgwRSN
         MOLwi3vPgtqQhiarGvyEiPwl9+UNp6uIkDU5/Y1BETL0B5j8V3vKim/LR13I2QdB+tHW
         OSTiCOYXzo4nSVHsRGYPAjLOYdEas58VlZI5N/33396iglmOZl+cF/eQszlJecSKTYWj
         PVo0VYWo2L6viWgTkQuyDbY4oxTQHWvZYwscVMlJULxOXt6fL/yEu4Z9u8N9iJIi/qZd
         sbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6MbjmzBnwM6gjnG7Cc/YOmrr7HwaCTb5NruG7e2TxrA=;
        b=EM/QBk2d698bbrToPDhgF1u0USaTwD3uRIL/3gSAwazFNrdWy+fcUsNWIctYw9A+VR
         fWA2fz/hRtQe2lixj8VhLUvn5nBythTc9VWGlMweddYrPZgt0B1AHCIH6p6kytErFvnb
         Rg4KvPTIYwn/K3tDjrxOB6+mGu4iiGm6xH3MSt3yo1VNbiILS3Vp3X6S2MsHT/e18O8d
         xhO+OK+GZPDu8aG/36Et6Q+SbX1z/vxIYAIWF/m94e0roslKEFs/Q6zXc+uABfLjqxXL
         dpQzZqVCW5Irz4BPs0DfnsgAddbSbSpNCflLIU0AXRXlrh+EGzcMGgvAfn6TGoKefuNC
         +YDg==
X-Gm-Message-State: AOAM530n0R5yxHt0qg+Gl7KfYmyW+fWhPHpW1EdGByNuEWB/RiB0vR5h
        HtBwQtI5vh6Mh1IGfdtJwFHeif3uYK1A+nQDkH1wsZT9lrIKzA==
X-Google-Smtp-Source: ABdhPJwU5pjiW19vxq1Fb7/Ubjv2aygoXSH5qEL0ldvB751wg0FPw+dTekqs8olQYHv56ya7p9oAFx/91l1avig4t0U=
X-Received: by 2002:ac2:4ed3:: with SMTP id p19mr645487lfr.307.1628730521167;
 Wed, 11 Aug 2021 18:08:41 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 11 Aug 2021 20:08:30 -0500
Message-ID: <CAH2r5mv_YRkGCs_qhmUje_qvUkPJpurdYw1W88VQ17CzKVhhGQ@mail.gmail.com>
Subject: signed integer overflow bug in truncate_pagecache
To:     linux-mm <linux-mm@kvack.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Running a debug build of the kernel while running regression tests for
cifs.ko on 5.11, I noticed this message logged which looks like it is
still a probably valid bug in truncate_pagecache in mm/truncate.c in
current kernel as well

     loff_t holebegin = round_up(newsize, PAGE_SIZE);

This was what was in dmesg:

[23907.325526] UBSAN: signed-integer-overflow in mm/truncate.c:833:9
[23907.325532] 9223372036854775807 + 1 cannot be represented in type
'long long int'
[23907.325536] CPU: 2 PID: 13007 Comm: xfs_io Not tainted 5.11.22 #1
[23907.325540] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[23907.325543] Call Trace:
[23907.325548]  dump_stack+0x8d/0xb5
[23907.325560]  ubsan_epilogue+0x5/0x50
[23907.325568]  handle_overflow+0xa3/0xb0
[23907.325581]  truncate_pagecache+0x8a/0x90
[23907.325587]  cifs_set_file_size+0xdb/0x2c0 [cifs]
[23907.325749]  cifs_setattr+0xc93/0x1260 [cifs]
[23907.325799]  notify_change+0x35b/0x4a0
[23907.325811]  ? do_truncate+0x5e/0x90
[23907.325817]  do_truncate+0x5e/0x90
[23907.325828]  do_sys_ftruncate+0x143/0x280
[23907.325837]  do_syscall_64+0x33/0x40
[23907.325842]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

-- 
Thanks,

Steve
