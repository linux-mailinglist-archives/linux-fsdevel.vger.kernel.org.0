Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE85250AC6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 01:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442781AbiDUXvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 19:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442780AbiDUXvq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:51:46 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6F7434B5;
        Thu, 21 Apr 2022 16:48:52 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b68so4762558qkc.4;
        Thu, 21 Apr 2022 16:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNDSaAZDG6c0X/AAevWMv+Hj9gwc9S8Gx1Ep4WfFpAo=;
        b=VMU6PqlaX0QEhB+kkqlvjU1fkuHokcH7krOoWy5GOTHB8xoeliEuXGVXpsNB0Dz+Xd
         BbBATqDrqEH9zXyhcIYU8xg7bZ1JhBV8iGp3kkSWUqKMomusN/sgcMfT+gW3paOL0z3D
         xu+vNW1zW7yY6vvYvHo0CFYHAFF9dyoP3mhjAP98M6NsbPyd+evObJBdpFzWsd4+lEZR
         OH5d2DANgk2raeqFASbkpduWa1goBPgzND0tgfUA3jO11r4ld93k7+lDwMyGGi1W1Fuk
         Cs/ulF5PpUoDQGVoea0bxdhTSej86O9eKfFC9FOSsryEROrxk/2xDFa7k9hHEFctVbCg
         an4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNDSaAZDG6c0X/AAevWMv+Hj9gwc9S8Gx1Ep4WfFpAo=;
        b=zvZD2+KXFR7ErAUA09ghtb6T9XLMquCpY3Enj6uqWALyWyno5sOfmAFJRsSqX9X2Fv
         H/XsbxX1F8sdEfuv1Q2vV3+wHkfhPrZgFJA6Cgwe8swqBqU2SekhG7cYNiVF8TQxfE19
         ME/B3d0PVtdKecBWc4mLfh1k+ufCSZNsjKvgVRzOzl0MLXJe69Tpep81E97YoF8Xn5Ss
         x1fF3JusvyJsM2c9sx8G1jisT2j9q+eSueYGkW4nDX8ay6E/XHmRZZT1D1GAP7pdYYmM
         O9FNNr5hlm5o7Pa6LSZ3bpbNQOCzFl+yDV3/K5IWvvol57PicBC0Ur5dGSYQg40M3B9r
         jGRw==
X-Gm-Message-State: AOAM530+UxCYO45spay9BArpG2kleWCnssSXlX7fSEBW0qf8Rcirbcco
        WNTnNS7CvXpE1SuNsg9i6gsdpOQfVESu
X-Google-Smtp-Source: ABdhPJzQcjTL3dqTlGkITB2iTWhj3H7yjo6OI6wlcQC1KEOsTaT9FApw/Jt+AfmjLr6ymBNQvEZ7iQ==
X-Received: by 2002:a05:620a:24c6:b0:69e:9d81:1e15 with SMTP id m6-20020a05620a24c600b0069e9d811e15mr1188307qkn.270.1650584931201;
        Thu, 21 Apr 2022 16:48:51 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a1-20020a05622a02c100b002f342ccc1c5sm287372qtx.72.2022.04.21.16.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 16:48:50 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: [PATCH v2 0/8] Printbufs & improved shrinker debugging
Date:   Thu, 21 Apr 2022 19:48:29 -0400
Message-Id: <20220421234837.3629927-6-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220421234837.3629927-1-kent.overstreet@gmail.com>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v1 of this patch series here:
https://lore.kernel.org/linux-mm/20220419203202.2670193-1-kent.overstreet@gmail.com/T/

Changes since v1:

 - Converted some, not all, seq_buf code to printbufs (thanks Christoph for
   pointing out seq_buf).

   The seq_buf code I didn't convert is arch specific code where the memory
   allocation context is unclear, and they're using seq_buf to do everything on
   the stack. I'm considering adding a mode to printbufs where we point it at an
   external buffer instead - it wouldn't be much code, but OTOH seq_buf isn't
   much code either and it seems to be somewhat tied to tracing infrastructure.
   Deferring a decision on what to do for now.

 - pr_human_readable_u64() now uses string_get_size() (thanks Matthew for
   pointing this one out)

 - added new helpers printbuf_str() for getting a guaranteed-null-terminated
   string, and printbuf_atomic_inc() and printbuf_atomic_dec() for marking
   sections where allocations must be GFP_ATOMIC.

 - Broke out shrinker_to_text(): this new helper could be used by new sysfs or
   debugfs code, for displaying information about a single shrinker (as Roman is
   working on)

 - Added new tracking, per shrinker, for # of objects requested to be freed and
   # actually freed. Shrinkers won't necessarily free all objects requested for
   perfectly legitimate reasons, but if the two numbers are wildly off then
   that's going to lead to memory reclaim issues - these are both also included
   in shrinker_to_text().

Kent Overstreet (8):
  lib/printbuf: New data structure for heap-allocated strings
  Input/joystick/analog: Convert from seq_buf -> printbuf
  mm/memcontrol.c: Convert to printbuf
  clk: tegra: bpmp: Convert to printbuf
  mm: Add a .to_text() method for shrinkers
  mm: Count requests to free & nr freed per shrinker
  mm: Move lib/show_mem.c to mm/
  mm: Centralize & improve oom reporting in show_mem.c

 drivers/clk/tegra/clk-bpmp.c    |  21 ++-
 drivers/input/joystick/analog.c |  37 +++--
 include/linux/printbuf.h        | 164 +++++++++++++++++++
 include/linux/shrinker.h        |   8 +
 lib/Makefile                    |   4 +-
 lib/printbuf.c                  | 274 ++++++++++++++++++++++++++++++++
 mm/Makefile                     |   2 +-
 mm/memcontrol.c                 |  68 ++++----
 mm/oom_kill.c                   |  23 ---
 {lib => mm}/show_mem.c          |  14 ++
 mm/slab.h                       |   6 +-
 mm/slab_common.c                |  53 +++++-
 mm/vmscan.c                     |  88 ++++++++++
 13 files changed, 666 insertions(+), 96 deletions(-)
 create mode 100644 include/linux/printbuf.h
 create mode 100644 lib/printbuf.c
 rename {lib => mm}/show_mem.c (77%)

-- 
2.35.2

