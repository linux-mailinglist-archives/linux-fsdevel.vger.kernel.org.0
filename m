Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6044769FC42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 20:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjBVTc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 14:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjBVTcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:32:22 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930E338660
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 11:31:47 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536e10ae021so93554647b3.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 11:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B+1HL3OiDOIFItbthJjOpQ8d4F6UY3ZwbvSKlsbX2Xs=;
        b=YnzhsbNQ+agpZNRBZ7e/Mn22FwwxQmhOMPyAmJEZCQBhrHkALhSAOxXTjocji8cdNc
         Mx7PKeLx6eP/LnT/z0wcFKeTo8ImRVLOchmG8+s8rphS6IYdZ6oaEoJG6EHDoFI8zwkq
         YiVXa1UyynhGVoF5G+yXmQUT3dLKPTQYA3eN6/tg1mcO9OeOo3ShBXB5qN6j0WUjWew8
         UTWl8wbW8baRl59c236t+dn8qS/YEzLuacDMzQgFwRHf4oP3+xxNYl+mP/X7BOjfW2TZ
         1Jtti/5kfEZJ3KcUmAdSfFAXBjQSW8JeZZ6Pi2Mus3eP0nxVAzBFPv1g1UvMN7rL5VsO
         p2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+1HL3OiDOIFItbthJjOpQ8d4F6UY3ZwbvSKlsbX2Xs=;
        b=fsai9uq/2xTnxznKlVxTtSiDWa92Z1Re8clZ967DVH23OPWhsrTZ5EpC3PdWcPXeUZ
         WrRwzmLWIwkfu9bsQR5DU622ztL0iWrY0qDphG9rED/ML4xBDm1usvQatyI98BX/eo6/
         lFXE7PjmiVnc1rllaBSnY4EMcgucus4DHmJTe0h88xAIlrOhG+iiYDpa7gAGbiuko9hO
         m0LxUhsfbSXFmGvzS/BveabZ3/g7E/TPLWwGGSB/c+9ihUWoWuCKLEi3qZ3kJmDO/Z89
         LETVFJI8EHY4rqUiGQwVIF7+C+MxT8Qg85+J96UHIYarWulOTAgoUxDLBEjypes5rrgs
         9urg==
X-Gm-Message-State: AO0yUKVkRvacmUGqW9A84YD3rHcaBqLQp6R/NYTB/RtGBezyr6/AvW9c
        ERoYNcUGsNn7xRD649qUmCflmNdp3lBkvwEve03R4YEftNj6BJZ58qQ=
X-Google-Smtp-Source: AK7set9oMfdCDLfHZI+pQI3iq24r0mAM2zr0xO6Sme4I9MITEx2zqz/0Rv37rVVs0xEpEQTYEhwtnWCDXUsbQwcM5/g=
X-Received: by 2002:a81:b71b:0:b0:533:8f19:4576 with SMTP id
 v27-20020a81b71b000000b005338f194576mr1092073ywh.0.1677094306146; Wed, 22 Feb
 2023 11:31:46 -0800 (PST)
MIME-Version: 1.0
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 22 Feb 2023 11:31:35 -0800
Message-ID: <CAJuCfpHJX8zeQY6t5rrKps6GxbadRZBE+Pzk21wHfqZC8PFVCA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Memory profiling using code tagging
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
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

We would like to continue the discussion about code tagging use for
memory allocation profiling. The code tagging framework [1] and its
applications were posted as an RFC [2] and discussed at LPC 2022. It
has many applications proposed in the RFC but we would like to focus
on its application for memory profiling. It can be used as a
low-overhead solution to track memory leaks, rank memory consumers by
the amount of memory they use, identify memory allocation hot paths
and possible other use cases.
Kent Overstreet and I worked on simplifying the solution, minimizing
the overhead and implementing features requested during RFC review.

Kent Overstreet, Michal Hocko, Johannes Weiner, Matthew Wilcox, Andrew
Morton, David Hildenbrand, Vlastimil Babka, Roman Gushchin would be
good participants.

[1] https://lwn.net/Articles/906660/
[2] https://lore.kernel.org/all/20220830214919.53220-1-surenb@google.com/
