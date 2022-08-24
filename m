Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7275759F3E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 09:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiHXHGR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 03:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiHXHGQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:06:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F697DF59;
        Wed, 24 Aug 2022 00:06:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p18so14886535plr.8;
        Wed, 24 Aug 2022 00:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=XqGUICYz7Zw54SNfXIRQ78xuqfCvfxchv+yQyCaLiC0=;
        b=Ccs5gIJlALVkZMYQRBKffJLoMSIU6S1D4P/0MPQNXrM89qOXLrwcHL9WYO/fr1ZUum
         vhyRK0P6JnvfmdXrMl0ZfMeVAmqIi/IBtnP4VvdLg8L5kmfCbvMcJ9+vWeqo3/z2pO5M
         /HRtLPcoycQubkoiu8IF/N8fll8EAeHfhU5vcs+wOwv+R17SoG0SKRFF56Av94y/waFK
         r5cFpsTlyC0uwoPPLi3U8548BZSYs5NOTBpSjIn9Lg+mEFPfMSaUTkc3GkRfxAXDGyRn
         p3XeCBPiJ7tiCSFYMDQe7yRn7KPM3/8yhxeI8ewVzbCGWWf0i7jjxzhyKYsTO2+vMrr2
         YG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=XqGUICYz7Zw54SNfXIRQ78xuqfCvfxchv+yQyCaLiC0=;
        b=VAkO0s97YP//S3nyl+7t0JbUAsvigtBREiWAuevv+bHbQ4u7/kNVoIjEsdZOuhE+gW
         HEXEMYqEgMQUY7SkYVVIuThRzkIuWFiu8V61wsSlzp8y+qM5dNEktx520+lEg0IFPe82
         QD4PBiTKYpsdF4GPgOUcC34LKwlqpmYElEbq8exstFsJgKoRp8dsQbLTnM6wPbjwSbeG
         tHaNmegTgya5OFLbARXrv90A9grEa0mdMCYLG4i0DgeQbwceHrNQv7HBYWdzYIoBGeS5
         CXGfwWg8xc76Jz51sJUSLAfWyqDNlu0AG6ATNyovvY9YpxsEwZa8R2mYUG/NCtW+Tjhi
         uKLw==
X-Gm-Message-State: ACgBeo2cBEiB41XzJeLLMvef82JcvIwvQvuNJsZD9CSfJquUMnUxGzdO
        42SAyTe2MWGfLeXsnADFa/k=
X-Google-Smtp-Source: AA6agR4GfHBzh+i+b0rp8F5AiL44jnY65Qku9UKBluG9fvI984XvOigaasEIYwqOFly+ucyk+9AxHA==
X-Received: by 2002:a17:90a:1b69:b0:1fa:f9de:fbcf with SMTP id q96-20020a17090a1b6900b001faf9defbcfmr6781656pjq.201.1661324773218;
        Wed, 24 Aug 2022 00:06:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090a7e8100b001fae01779c8sm583776pjl.7.2022.08.24.00.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 00:06:12 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     bagasdotme@gmail.com, adobriyan@gmail.com, willy@infradead.org,
        hughd@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH v3 0/2] ksm: count allocated rmap_items and update documentation
Date:   Wed, 24 Aug 2022 07:05:59 +0000
Message-Id: <20220824070559.219977-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KSM can save memory by merging identical pages, but also can consume
additional memory, because it needs to generate rmap_items to save
each scanned page's brief rmap information.

To determine how beneficial the ksm-policy (like madvise), they are using
brings, so we add a new interface /proc/<pid>/ksm_alloced_items for each
process to indicate the total allocated ksm rmap_items of this process.

The detailed description can be seen in the following patches' commit message.

v2->v3:
remake the patches based on the latest linux-next branch.

v1->v2:
Add documentation for the new item.



*** BLURB HERE ***

xu xin (2):
  ksm: count allocated ksm rmap_items for each process
  ksm: add profit monitoring documentation

 Documentation/admin-guide/mm/ksm.rst | 36 ++++++++++++++++++++++++++++
 fs/proc/base.c                       | 15 ++++++++++++
 include/linux/mm_types.h             |  5 ++++
 mm/ksm.c                             |  2 ++
 4 files changed, 58 insertions(+)


base-commit: 68a00424bf69036970ced7930f9e4d709b4a6423
-- 
2.25.1

