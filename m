Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2F7468652
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 17:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355288AbhLDQtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 11:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhLDQtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:49:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C3EC061751;
        Sat,  4 Dec 2021 08:45:56 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id m24so4221758pls.10;
        Sat, 04 Dec 2021 08:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ou8MCZUKr64qRr/skxLC3cSf8qAEbYCJImJhLBz+XPg=;
        b=aP4Srzc3BqseYAo4mv4qrVDjpirw2ZULF1TPTFiy3P5lcuxGU4/q2Ez/bzVvegPok9
         9K6/jag7mIxJxirlwSVjYfKzLqPKesXAdfkwopIiTKseWla39XCoskaNL/a8VRrOz+Km
         E5p8wsTq0Acbh3Ln7dtsvTBCwZlaRDnY5OQ2ukfXTi99efBIn9pMv2tGqs/n3xenMiaY
         G2hzPyQatvLRiedijOZ/gkoEVpyaZKB8ZqniwtfFCGylH0FakQatiK4AXyEl5YyszYih
         Rw3K8VsYcqXcWFFqwFiqi78csx4jXfxLLRl/LeGmqECMrqFAfWhPnduhSdvcSw5Ghlhv
         5Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ou8MCZUKr64qRr/skxLC3cSf8qAEbYCJImJhLBz+XPg=;
        b=kclVElIhRIwL5qXrRQgTLuqJKMhRujdewHP6Aj7Ui3XF3wfulizGk2sGvfnHL1eHS2
         YRRHM4VxcNqdQ5eQoO6yuu5yGNxdChRQKXNFBo5d445mIj+w1wT2JWPlWs1qce/gmaHU
         9x37QxK+jJsMKuW3Du5Ae0G4W4ro+ejvLzn6RcjnXan8e6M5tjop+tH4G4wDuvUt4hyl
         KI2DMYBwbiax+aEy4iVQ2pf01RQdJezMguCopo+aUo8aP70EP71uy8Grn7jXBVSXLCdq
         sOSTR/eeBF4dZUz+umWPuzMUT29uhSwHKdUDpMn6pF6NwGS4T5QvPg3rkeooDah3zuEN
         hefA==
X-Gm-Message-State: AOAM532UU7tDQEhp1rTl+hwD0f5nP8cKItrlkB2Tx4uGPHr9z0b8+hdJ
        Q1ZUGxg9pY1hk/gD1XwTz8oT4e68SmVBLz2EHc0=
X-Google-Smtp-Source: ABdhPJys2RkngGFtmTCazg47B4ViGpNE9hIzgYpzzqwZSUBXheVoeoJh9O21QqSQxzOnlPnE2IW9uVcPVl2w5VMXfIc=
X-Received: by 2002:a17:902:b588:b0:143:b732:834 with SMTP id
 a8-20020a170902b58800b00143b7320834mr31432185pls.22.1638636356196; Sat, 04
 Dec 2021 08:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20211204095256.78042-1-laoar.shao@gmail.com> <20211204095256.78042-4-laoar.shao@gmail.com>
In-Reply-To: <20211204095256.78042-4-laoar.shao@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 4 Dec 2021 08:45:45 -0800
Message-ID: <CAADnVQJnkTYXZhmEg50HOwN3FP2S6uK_TRJD+oUP7V=OzAn30Q@mail.gmail.com>
Subject: Re: [PATCH -mm 3/5] samples/bpf/tracex2: replace hard-coded 16 with TASK_COMM_LEN
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
> diff --git a/samples/bpf/tracex2_user.c b/samples/bpf/tracex2_user.c
> index 1626d51dfffd..b728a946d83d 100644
> --- a/samples/bpf/tracex2_user.c
> +++ b/samples/bpf/tracex2_user.c
> @@ -12,6 +12,7 @@
>
>  #define MAX_INDEX      64
>  #define MAX_STARS      38
> +#define TASK_COMM_LEN  16
>
>  /* my_map, my_hist_map */
>  static int map_fd[2];
> @@ -28,7 +29,7 @@ static void stars(char *str, long val, long max, int width)
>  }
>
>  struct task {
> -       char comm[16];
> +       char comm[TASK_COMM_LEN];

Also Nack.
