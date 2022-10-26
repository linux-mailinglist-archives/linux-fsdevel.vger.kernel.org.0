Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE5D60E700
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 20:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiJZSJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 14:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiJZSJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:09:23 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EE497EFD
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Oct 2022 11:09:20 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id p9so7501701vkf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Oct 2022 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mojyIGWRIgJTNX8C5UMuUHcoan5R5wVfttH40XiofO8=;
        b=qOvclwxcs2pCPf3b7fyIiVIyTEfjD1jTs4ZGaLYpA5KI7frj16xL3ixl18REeohVMO
         RycGt88O7USFm3kVlZka907NIzYH6o5UESbznHPgzedZPsx6KddGIRjX2x5nOv8Ov7Pa
         hSfmK+MFeBi5Jt1YyBm2Pcr3lIAzqHrPb15lINQPlLCqhBYnHJgpJwoilQmR+8FBI4SC
         fgCgW34HDHMlXqA6YxjiAQbAE+suaCrla42Qa0usY+V5Doz33N5yB/wVEiBB/HikkTRn
         bt4nKDdmAScWH0VF9ZknHXkapHMjS5/FEOK45/F+aSfJacyhWC835uNHquESC/f4JA3K
         is2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mojyIGWRIgJTNX8C5UMuUHcoan5R5wVfttH40XiofO8=;
        b=yJr2G+cH2Et++7uFDxuTySmZzmi0sRfN/nclrmbH/xWB7dOSKuSKsAk4f/wKVWW+eY
         5n6f56Rk/veyDeqgnrYA0vjW10I2yPGXgjI8Ys/xwc5y2oHQIARmIvQuJvxeJApy/fDw
         siEFjUjvKryO28QTkQbM9bIBb3/Zivva4V/JgYsIhPucEYQftHjEdRAGIBrsKEAkwIP/
         dkySjjoJBS5nB+8c1LuWRud7zESLdmQXUTAwu4uXU38bqonjuvWNDTDnNLTW2XQYJZLp
         tGnLJndqUP402BF8kswHxzQ4g9yrqzMUH+KRmiFmLqbSi/gk/fkhf4mrWsPjhfLevLMa
         7oAw==
X-Gm-Message-State: ACrzQf23N6d9q5Ykw8v1g48ifohI5JTr2IyHoawKdXcdreO8lQYud1Fc
        d9J8XA0btYr+mZ2UT0kMpOlzy2LGU1OTUGoyjZ2gMzVLS4w=
X-Google-Smtp-Source: AMsMyM4pCaEAiXvP/ByR3WUnlBcWfEJLVa/ungHbHC9hE2BeZn2QP75gYsEHDzq6RE7w4GuU14Qx6tRy9a2VehLLiq8=
X-Received: by 2002:ac5:c969:0:b0:3b6:2a34:a26b with SMTP id
 t9-20020ac5c969000000b003b62a34a26bmr10091328vkm.30.1666807759152; Wed, 26
 Oct 2022 11:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221026134830.711887-1-bigeasy@linutronix.de>
In-Reply-To: <20221026134830.711887-1-bigeasy@linutronix.de>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 26 Oct 2022 12:08:42 -0600
Message-ID: <CAOUHufaW94QseZJqaDuyFTwvX7TyZwuFwYULgno25Vb5HduByQ@mail.gmail.com>
Subject: Re: [PATCH] mm: multi-gen LRU: Move lru_gen_add_mm() out of IRQ-off region.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 26, 2022 at 7:49 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> lru_gen_add_mm() has been added within an IRQ-off region in the commit
> mentioned below. The other invocations of lru_gen_add_mm() are not within
> an IRQ-off region.
> The invocation within IRQ-off region is problematic on PREEMPT_RT
> because the function is using a spin_lock_t which must not be used
> within IRQ-disabled regions.
>
> The other invocations of lru_gen_add_mm() occur while task_struct::alloc_lock
> is acquired.
> Move lru_gen_add_mm() after interrupts are enabled and before
> task_unlock().
>
> Fixes: bd74fdaea1460 ("mm: multi-gen LRU: support page table walks")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks.

Acked-by: Yu Zhao <yuzhao@google.com>
