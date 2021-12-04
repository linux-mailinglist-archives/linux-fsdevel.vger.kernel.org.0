Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C702746864F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 17:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344863AbhLDQsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 11:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhLDQsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:48:24 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9575BC061751;
        Sat,  4 Dec 2021 08:44:58 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id l190so6201847pge.7;
        Sat, 04 Dec 2021 08:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pJd316SntFE8CJG8ZCyQl9bn0yi8tTdr3ZLeWI3me0=;
        b=iqDgKWpZ8/yGsyIc1QVsUbdjKIcOGhY306eHV8Xue00e+0UNFR+PYukXpJr3aReD/D
         aXV99tRptOmdDvPczpKDaTFwg2CyOe76eGtRVp89T6LH5XE9mB6MTl6nH8td/chG6OH2
         YodeKvj7BB0cmf3O8iq2ZSfVymebaM9+2OidYFpxLUe0YJwBGQqsXGngzX96nLCjjpaL
         y04LXK/aFShnoDVTvy1DY6MHELbRkTu8Jh0J3dP4mzCUKxIxqX6xG9vbBznm2SLiH94W
         gzZY0jS4vBx5FiVzxCuSBV3G/3PYMjouuQtaIOzbesCQSWp5XPhefRiXs/aPKOJ+kVz5
         eH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pJd316SntFE8CJG8ZCyQl9bn0yi8tTdr3ZLeWI3me0=;
        b=mhONlYkW3Hfi3lf+Vjhq/ioIXzmSZBwYMmkvNd4wdxepjswTad353uHzYqCkN5yxPO
         VQbtpG++g1X4jcHf8JKZ13lR4MbHBTwKKXm74rekDOg+wRXIAjCCYXnkTx5jRCn9ycnZ
         wevb7efwCbBrIqZ+yMDKVwf7d5b57n+wc7V/W/D7brvn0K/ciVvtla1KaOmFUgDApZak
         L3mfghciCdZ7qy0mK6sNscYH9uJcBFWesPgAQKwWmYJ7ZhOItr6+29sjdbMknfk7GG4W
         bOnaZ0GcsG/OxRRDcOAk48ktjbqlCAEMp89eDBkYRjg1IEQqsHdIw6jBTC03/U5lv8+J
         zCMw==
X-Gm-Message-State: AOAM532FBLnb7WlBb8Gdg1GxqwuAfXNKP1kgVwllYDdrsd5Glb00c/0V
        qtHO1iaouhq7RxJLyfbXUX71d7SmyY5xE/m+BoM=
X-Google-Smtp-Source: ABdhPJxyPZhkNrj88wcz0m7CaY2bBbLI9Vc3tBg7UND42s+Qqzyjc3Vwwi+fAgQizw3zp7zWD23+pDsDAAmJ8AhZMCk=
X-Received: by 2002:a63:6881:: with SMTP id d123mr9847445pgc.497.1638636297919;
 Sat, 04 Dec 2021 08:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20211204095256.78042-1-laoar.shao@gmail.com> <20211204095256.78042-6-laoar.shao@gmail.com>
In-Reply-To: <20211204095256.78042-6-laoar.shao@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 4 Dec 2021 08:44:46 -0800
Message-ID: <CAADnVQLS4Ev7xChqCMbbJiFZ_kYSB+rbiVT6AJotheFJb1f5=w@mail.gmail.com>
Subject: Re: [PATCH -mm 5/5] bpf/progs: replace hard-coded 16 with TASK_COMM_LEN
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>, david@redhat.com,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 4, 2021 at 1:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
>  static int process_sample(void *ctx, void *data, size_t len)
>  {
> -       struct sample *s = data;
> +       struct sample_ringbuf *s = data;

This is becoming pointless churn.
Nack.

> index 145028b52ad8..7b1bb73c3501 100644
> --- a/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
> +++ b/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
> @@ -1,8 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2019 Facebook
>
> -#include <linux/bpf.h>
> -#include <stdint.h>
> +#include <vmlinux.h>
>  #include <stdbool.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_core_read.h>
> @@ -23,11 +22,11 @@ struct core_reloc_kernel_output {
>         int comm_len;
>  };
>
> -struct task_struct {
> +struct task_struct_reloc {

Churn that is not even compile tested.
