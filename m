Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D6B7AF92F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 06:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjI0EUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 00:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjI0ETb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:19:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8421E3AB9
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 20:42:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so91487395ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 20:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695786147; x=1696390947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGJfI+lZ4iSfQ93mihAmCKetWCxWqPDzFkg6Q6FWgBc=;
        b=Bs7xjUEuS8NkFPZHJGDJ2TEI8MNHM5Tz6S/mOzXHCqJoYeG8s73+rqFxehM6W9d0Kt
         wgxsaFDT4RoUKAw+CU0VmHrZgfzI1vpBz7Y07O6WES0bdXkIyYu2DrOxTBJ5JixFquGM
         J/7Qe5i1yvKNnVZ0c/UHwkPScoP7L+UScfV04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695786147; x=1696390947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGJfI+lZ4iSfQ93mihAmCKetWCxWqPDzFkg6Q6FWgBc=;
        b=qjzYiRvP5wBqn+8pGVipLyr35FzdP+MplovwhSOA+EZdlUky6fyQnCuWW6kL5kkX6J
         h1giozp6FfM5vhuBlyQgfeWA3/3vujQCy8fHeRHa/YGOSqZsH2JjVqcg++J7Z0TmxGMF
         hQVKDPdmEi+Jit32lSMBKsvqFG3floP02LKSpiETjsEwLyReCEIWogh6BFki+27aqcmU
         AVDFvCeXI9jYX46yU/vusbvOH8cL4f7eRbUOgFJiK2nkU1TPMzcR/xa4plJAJsbkoAX1
         A2yM0BFhkvSj+Bhla2Q2bRw8xiMNn11o3U5rG4HPor2AOL90vwyV/7dM33V8mh6PE0g2
         WF6g==
X-Gm-Message-State: AOJu0YwP3/vWoPTDN4QXccoZgdmbowmb8Dfhx0TSpNB2cMSBb70h9ra2
        muhjS2o5u+HMop6wNtpp7f7SHQ==
X-Google-Smtp-Source: AGHT+IG3vmw0qL9sWfrthHzlDQju/5u8n9c1TNnVsBUEHwDjOoLhNFzP4dPTCN3Xs5EKe3Hg9ILQZw==
X-Received: by 2002:a17:902:c94f:b0:1bb:598a:14e5 with SMTP id i15-20020a170902c94f00b001bb598a14e5mr992121pla.43.1695786146709;
        Tue, 26 Sep 2023 20:42:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001bdc6ca748esm11918838plb.185.2023.09.26.20.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:42:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sebastian Ott <sebott@redhat.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/4] binfmt_elf: Support segments with 0 filesz and misaligned starts
Date:   Tue, 26 Sep 2023 20:42:17 -0700
Message-Id: <20230927033634.make.602-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=868; i=keescook@chromium.org;
 h=from:subject:message-id; bh=lOC6dIm6BOZ5YdJlYfTe2LeekCnJ++QGcs0vKnnP4ps=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlE6ScQrYRvW7/cLoTymNp+QzCK4E5+g2pQV1h7
 2TULnPSJZmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZROknAAKCRCJcvTf3G3A
 JoDCEACiqN/qgoJ0Ne6hePry6JkdekxC2ghpkyg+pmI99pumwTcgld+j67+ZMdlJ1uoiL+ZLTZW
 kpZQc19iF4kz/hS2BzF5fc3o9zbbnksf5M41zq8EHUWlTko2ebswjaLUUI/dADhqmcfsFOxdlYK
 a9Wn4Yo+Jsryxk8lZr8iC1UsqxoN2OD1JZ/IScy8PRDGyoj5SW/8KXm4YVbT+dUCx5rv/HJ+qzk
 n6mLTE09gnExRim0Wkug8xsfhXdnRLf3JEwhHm1uYDvLhIVG4jp9a/C/HyB52YRBBD0pM7HD93r
 eDzoVjwiGJLGETpwCEoKdJaiNrkBYYwZ4uS/OTgkBkxm/y/MykXwxzIH2FQRU6ex9YHjbc68Re4
 abj6Ut8m5K8OBP497GvZJeM6fR4y1bL3UtMBqHGNipTauOPZtp14wuE26++n4jCcIdnbdo9FmYz
 GXg3/jNe4JkK4sHhwUXSCm07Gn3QavzFisWXca4G/AqBjF5k4hwBnYd8jg6ObkJgzPZgIHuZ+CN
 AiMdCAMOGj2d0N/Jlti27JIkfB5ifjxiV+OXygf99lkJgwVe18U6L6cPvdtxbYOW3xWLKUwxgqL
 mpHIt8n/rKLRvretb5VXJySNBh2q2kAngczfkZzyHdbxaj6wAKLbZiiVdt+WDa7CcxMhvKi9oot
 B6BlPROL CGrPl5w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is the continuation of the work Eric started for handling
"p_memsz > p_filesz" in arbitrary segments (rather than just the last,
BSS, segment). I've added the suggested changes:

 - drop unused "elf_bss" variable
 - report padzero() errors when PROT_WRITE is present
 - refactor load_elf_interp() to use elf_load()

This passes my quick smoke tests, but I'm still trying to construct some
more complete tests...

-Kees

Eric W. Biederman (1):
  binfmt_elf: Support segments with 0 filesz and misaligned starts

Kees Cook (3):
  binfmt_elf: elf_bss no longer used by load_elf_binary()
  binfmt_elf: Provide prot bits as context for padzero() errors
  binfmt_elf: Use elf_load() for interpreter

 fs/binfmt_elf.c | 192 ++++++++++++++++++------------------------------
 1 file changed, 71 insertions(+), 121 deletions(-)

-- 
2.34.1

