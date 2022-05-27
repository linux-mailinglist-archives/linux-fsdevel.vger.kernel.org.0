Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D815A5363E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 16:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353021AbiE0OOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 10:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiE0OOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 10:14:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DB75AA4A;
        Fri, 27 May 2022 07:14:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id wh22so9067983ejb.7;
        Fri, 27 May 2022 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDpmMrX6ZAj99tYsLUoYw7iDnZGlJpEI/3VF/4/WHsM=;
        b=hmiV/2279z7xlKaFk+GxCbmDFupUyDQeF53CqctYwc3ylvA1+g67fm9AYwf3aJD52U
         2Y0VNqCIPfJbF0YC3jT9aXfuCTHrZQH0zxRrdU5jcN1U1Kr3Xyjgnel+Kg8sZAH6ee2U
         0dRC/R9cIcfp4pxd3fmznfBJMykLh8g3O16PpM3SZgOtK4GcYkW2MzmtU5DshhyBsBBf
         3dKOBekLlhYbIn1nXTFG8IGd4yeaLAs2b4LMzjf8mjbboq9RHjfL3e/PH9gzng8YZQoR
         wqBZqmfZxrzbCTzS+9/EGH3SBeLUcCO/TOjFgUVkrnmnGi4VHBCbnbAcC3eLlGOH/cDk
         d4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDpmMrX6ZAj99tYsLUoYw7iDnZGlJpEI/3VF/4/WHsM=;
        b=XWvs1OzpyEqn2rhMU2sOJAnRMC9Qb0KkWrQvEEpybCDANviWERnMzdKTzV8aiyBUGn
         HfqcPxGd+loh56t7alMhH3Q0ezryCE1SoGoUud6dfyt939qEQ4TrgjxJjr4BEoNWPvNZ
         nmKroZJUnPRTnYy980ah4Ud0Ta9/Ccdh3twtCIZrU/dqNDrlTKjQK/GZPi6iKeX3sY0f
         gWEXI5FzA9O12F2/E7cSft5VY1WiOxWEv4rVUMWSCqIdp44M+qyDKeZR/WAONDI2BG8v
         K2gQVHlJ3wEXPjZyQtzfG1xN+aWXYySc4QaQiaVBdXQ5mtkDd1o6ca2HmJVlmG6XPbT9
         ePnA==
X-Gm-Message-State: AOAM5320hwJ+ArNo4XFq8NN+JwUKClRz+yG1JczUhHhT/Y10LQMQqysQ
        wQRha3zL6V8EzSfVax4KAaQES3v6XH5Ksu67WVk=
X-Google-Smtp-Source: ABdhPJzu+h5wDUX4t7z5kJNxgp3+mHRNUPXxSn4d+Qux7XVdKfp9P59rjLYvyQHCXOcEAGyObqTC+BjeidAUXP/vTKc=
X-Received: by 2002:a17:907:7da5:b0:6fe:d818:ee49 with SMTP id
 oz37-20020a1709077da500b006fed818ee49mr24958685ejc.58.1653660847121; Fri, 27
 May 2022 07:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220527110959.54559-1-zhangyuchen.lcr@bytedance.com>
In-Reply-To: <20220527110959.54559-1-zhangyuchen.lcr@bytedance.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 27 May 2022 07:13:54 -0700
Message-ID: <CAADnVQL69J8MWhaNzNG=ANL_i8_QqABON+pWJDuqRTkFGPJYUQ@mail.gmail.com>
Subject: Re: [PATCH] procfs: add syscall statistics
To:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, fam.zheng@bytedance.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 4:10 AM Zhang Yuchen
<zhangyuchen.lcr@bytedance.com> wrote:
>
> Add /proc/syscalls to display percpu syscall count.

I second Peter's nack.
We don't add debug features to the production kernel.

> We need a less resource-intensive way to count syscall per cpu
> for system problem location.
>
> There is a similar utility syscount in the BCC project, but syscount
> has a high performance cost.

There are two syscount tools in BCC:
tools/syscount
libbpf-tools/syscount

Which one has this 42% overhead?

The former tool is obsolete though.
It was written in the days when bpf had 1/10 of
the features it has today.
Both tools can be optimized.
They attach to raw_syscalls tracepoint.
tracepoints are not cheap.
In terms of overhead:
tracepoint > raw_tracepoint > fentry.
bpf can attach to all three.

Please profile libbpf-tools/syscount tool
with perf and unixbench, understand where overhead
comes from and then optimize the tool.
