Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C916546EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 20:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbiLVTwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 14:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiLVTwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:52:47 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8B7186DD
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 11:52:44 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id z23so1371049vkb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 11:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1knc7b7bkvXdXPfMt9YKoMsAvgwNeZbmN9qBo7ZQ/FM=;
        b=USvUd87Mb0zOooOPpuhbGREHxvLaWuV51l8idqP7PcPFsyK6L2JyNx39ZSoQdXVfai
         OGGOq3OWAIO3INr9HPrnRnHrJ8Tk+s4KM/BacF90k3jhTzyl/tW+S+G5+kkhp85zLU5N
         t5nSd8Skr8AJtmuwa9K3nf1DTIyUyRNeuUMWOC9RRXwDQsq6t7TLbCiOuYPXKxqzInHG
         aOQndXAh78UAW3p4vB4jwy2GJE4uiSXlMavNgOh9OtHKqFcREA6UqJ6RlGHGv0Uw0ItD
         4r2Jvwv/MZqd4JT7itetc5LYmpHLDs8IZK/O7hVPu02tFJaWDIVIKr5LfSmdDtmgkuTj
         T9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1knc7b7bkvXdXPfMt9YKoMsAvgwNeZbmN9qBo7ZQ/FM=;
        b=fITbIjTcyiUyz9yzQ62IeI7jGtrt1YEiEUj0fQCbtYdTGJ/VF8hcUNQ7X9fYNNKx8+
         a7SRp2wEj4BfapUP5o8d/lUZr1bF6lZJXAjSt2V3t8yFVb7w/K0og7S8L9MYHdg3+DO9
         VWiUYaKBXxLQrucWrA20Bj31wAIaqPe3nQCLHhjjF1zrvlaMoQWL0o/DhxOdeCtH5lPi
         LcYGuypfjAwntjZ/2JAQOlcZ09WJGYYByqEeXqcr45+sVsXxQ8GeYteMTcCs4WTF/Z/C
         orQ5/ekwdasFMcslpwdVKEEaqMTjQSRz1J1rD59EesiBKOkhoMVB48t59brDI7b8I5hB
         rCPQ==
X-Gm-Message-State: AFqh2kqfZylqH/aDAG+vBBHB4ooZtB8XOj1VnJJN+mOlmKlygqzH8JRM
        gW0eCYJszzgH9O4bQU6aXt5SpuPvobyN1nwLwPL9hw==
X-Google-Smtp-Source: AMrXdXvE5I8dhv8FjwC9O4WzXUntlzKQ4NhndP0HGdMPybFzPPykl2av9rwFu5gmyM7Dl3pniiM9k17bBOP1+aEqb8g=
X-Received: by 2002:a1f:43d3:0:b0:3bc:65ea:864f with SMTP id
 q202-20020a1f43d3000000b003bc65ea864fmr797713vka.30.1671738763518; Thu, 22
 Dec 2022 11:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20221222061341.381903-1-yuanchu@google.com>
In-Reply-To: <20221222061341.381903-1-yuanchu@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 22 Dec 2022 12:52:07 -0700
Message-ID: <CAOUHufYN8UPHrsni5fohOUK4=Od8Ny312CJrKvHjou=Zxj=+DQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add vma_has_locality()
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Wed, Dec 21, 2022 at 11:13 PM Yuanchu Xie <yuanchu@google.com> wrote:
>
> From: Yu Zhao <yuzhao@google.com>
>
> Currently in vm_flags in vm_area_struct, both VM_SEQ_READ and
> VM_RAND_READ indicate a lack of locality in accesses to the vma. Some
> places that check for locality are missing one of them. We add
> vma_has_locality to replace the existing locality checks for clarity.

Need benchmark results. A simple fio test will do; doesn't need to be
the curl one.

> +       /*
> +        * If we are reclaiming on behalf of a cgroup, skip counting on behalf
> +        * of references from different cgroups

Nit: add a period at the end.

> @@ -906,6 +908,7 @@ int folio_referenced(struct folio *folio, int is_locked,
>                 .arg = (void *)&pra,
>                 .anon_lock = folio_lock_anon_vma_read,
>                 .try_lock = true,
> +               .invalid_vma = invalid_folio_referenced_vma,

Nice. (What I suggested isn't as clean:
https://lore.kernel.org/all/Y31s%2FK8T85jh05wH@google.com/)
