Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A315559C33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 16:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiFXOhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiFXOgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:36:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE47056777;
        Fri, 24 Jun 2022 07:35:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i67-20020a1c3b46000000b003a03567d5e9so1794481wma.1;
        Fri, 24 Jun 2022 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITIWR9lqvuBBf8Ibkw/AdDqQI2Kd/5nYAtfMe7J5L5E=;
        b=oGfN/sc/D2AEXPgVrhV0EVBvDXKbeoyBpA8Nla1hEJm4iHnYz/H0FJJ2QL8+K8wiA2
         PLktznj09jqm2k5Dio3PdgJ8RwXTIV1HlvQR7woNRw+YHI4uE08KlLXOu5S0FZtWXo6V
         +NAuK29KNfhgDsyG5OXOq8ZLFrz0T4Xn4n2pnZWwLeN0EuXUQtsfCSjFD6MVCGiOFSC8
         DvIMIUwuIo3b+dgznUMPnQ0MAdMaaoFunc24XpKTGh2INOSjhQSR9PbCa4NESWGFiDwU
         hy+hLwD9vnpgL3E3JzIHnrZbi/AeC7dqOXi/yQJ2hyfsRtTrT6F4U1TYL3MTbCr5Ll13
         U+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITIWR9lqvuBBf8Ibkw/AdDqQI2Kd/5nYAtfMe7J5L5E=;
        b=y04TNCUAgPxwmVmF18IryQyim9E8xCgP/AQcSEG3HB+PDcenjjo/2ZC3QggbGehMSh
         avpdBNRFKGyiKWTJTjtXJKLVo6paYFofnQJKpDyZ14A2NGwptyEf4AlI6+FVZtbSXtZ2
         IdBmt3GW8Xd1fN7LloeC5J86+wra7wlZ8nyKc0BxFh3r1ARKiHzgD2fRKsDUPvjgSuU0
         qsibX7j7Wke/QWpjK3290rJulVBrhEDSNqgmVNAIaG5z18cf8GcwHX3eqFIJnwPQVjYr
         CONOPpvGMPdaqXTPCZTp0fxDTtQo7YJgzYljSUoJ7W46/2RzbW3lRY+xvgTpZhz5qdKA
         5xgQ==
X-Gm-Message-State: AJIora8boZpGYDsDnjqKGSGhrlFfCU2lCOaKNvSUE5gSjCLw8c5EpZ2G
        qoGy8Rc6JdZgNozbI3+1wzY=
X-Google-Smtp-Source: AGRyM1s+hUlJNcxIKdElR5aVsOkcCv1j278STvOITesjK33LTulIDOqLwc/3Dr7l5h0QelSutllPXw==
X-Received: by 2002:a05:600c:4e53:b0:39e:e5c4:fe9b with SMTP id e19-20020a05600c4e5300b0039ee5c4fe9bmr4045199wmq.109.1656081343166;
        Fri, 24 Jun 2022 07:35:43 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.8.191])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003a02cbf862esm3116732wmr.13.2022.06.24.07.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 07:35:42 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 0/2] New fanotify API for ignoring events
Date:   Fri, 24 Jun 2022 17:35:36 +0300
Message-Id: <20220624143538.2500990-1-amir73il@gmail.com>
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

Hi Jan,

As we discussed [1], here is the implementation of the new
FAN_MARK_IGNORE API, to try and sort the historic mess of
FAN_MARK_IGNORED_MASK.

To address the bug you pointed out in v1 review, I added
helpers fsnotify_effective_ignore_mask() and
fsnotify_mask_applicable().

fsnotify_effective_ignore_mask() is used also in send_to_group(),
but not fsnotify_mask_applicable().

We could also use fsnotify_mask_applicable() for mark->mask
in send_to_group(), but then we will need to set FS_ISDIR in masks
on inotify/dnotify/... marks, so I don't think it is worth it(?).
We may need to change the helper names though to clarify this
subtle detail.

See LTP tests [2] and man page draft [3].

Thanks,
Amir.

Changes since v1:
- Replace "sticky" semantics with EEXITS error (Jan)
- Simplify EINVAL checks (Jan)
- Add missing ignore mask accessors
- Add fsnotify_effective_ignore_mask() helper

[1] https://lore.kernel.org/linux-fsdevel/20220428123824.ssq72ovqg2nao5f4@quack3.lan/
[2] https://github.com/amir73il/ltp/commits/fan_mark_ignore
[3] https://github.com/amir73il/man-pages/commits/fan_mark_ignore


Amir Goldstein (2):
  fanotify: prepare for setting event flags in ignore mask
  fanotify: introduce FAN_MARK_IGNORE

 fs/notify/fanotify/fanotify.c      | 19 ++++----
 fs/notify/fanotify/fanotify.h      |  2 +
 fs/notify/fanotify/fanotify_user.c | 61 +++++++++++++++++-------
 fs/notify/fdinfo.c                 |  6 +--
 fs/notify/fsnotify.c               | 21 +++++----
 include/linux/fanotify.h           |  5 +-
 include/linux/fsnotify_backend.h   | 74 +++++++++++++++++++++++++++---
 include/uapi/linux/fanotify.h      |  2 +
 8 files changed, 147 insertions(+), 43 deletions(-)

-- 
2.25.1

