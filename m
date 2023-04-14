Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45A46E2A0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 20:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDNS3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDNS3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:29:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0C710F1;
        Fri, 14 Apr 2023 11:29:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id q5so10836588wmo.4;
        Fri, 14 Apr 2023 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681496956; x=1684088956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cX1u0ZEPT5XtSD35z6oKMXgZGWYVVdgbWzPUN8ao3YQ=;
        b=M+zTyq87LhHLQIAEPGCYLypxEs4IkQ+1rScm7foI3Mt1gBtznNjovndHDHBtw3DBwU
         L2ELXfJwxWJgyO7NtpL+U2vCGR1ilOODVWVG8L+BIPdNZOXFLDWTHczTqijm9LhCxXI+
         ZqVxzdIppQWU5Q1ge7SSkoeFO7ZUOY2S0D1sJ/lkaz367arv8yiNAqKpCBQ76vSYh3H9
         TZX4DFfaKYPstmzFbNSjN/dfuyCsR8AQPhW7Bc88wWEXL2T7Swlud81eYnamUJWJuiM9
         wdcGF22Yrn8MJ6D4ck8Enp/hUPHnJxTetCG0gHmbglUERWy00p3Jb962VayXFPW8c0i+
         gYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681496956; x=1684088956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cX1u0ZEPT5XtSD35z6oKMXgZGWYVVdgbWzPUN8ao3YQ=;
        b=J/AA7+yyDoGjguRIb6EK3fKFGE8h7lW+vKhtzsOAsU/Sa6Dff2NZEpIoQks9RuvCTs
         wsL+zssf2qgJD2ft/qjhTgf5ZRnwmvF93AbetBOUCGOX/9ctF5yxqLVDibYX5OhpnnUb
         VKhlgEGSZrJL4ya5Jh5l7YYIbwPzpYOqP5GaVTqs7VPe+pd2FjmT+t1rWRfIFBwOXAiG
         SBk9yvnA9ZnbLA3V7d1TmWyPBwiLNRtf+sTXdk20TC6NlIC6J6jC+t4EQjuhKX7WH3F7
         0C2COBb5MctNgHHtn1VOOidEHRW3sN62JHPAeiawCoc6A4X+OI5dFp36juxnGk09xXj/
         F2AA==
X-Gm-Message-State: AAQBX9cUNsFoEoIPAuVZ6tx5BQomAlW4FV1eQ8hhuSvcYev9v91BrhcH
        x1+Y5q7ohA5R64MPmEMwoek=
X-Google-Smtp-Source: AKy350ZpsqCt7GZ/0VOo0Byyvl7EdawQwlAPJWPmUswNMWKJb1qgJ5eFM7qnV+3JXrAz/lRERzP04A==
X-Received: by 2002:a1c:6a05:0:b0:3ee:42fd:7768 with SMTP id f5-20020a1c6a05000000b003ee42fd7768mr4918514wmc.1.1681496956274;
        Fri, 14 Apr 2023 11:29:16 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c160900b003f0b1c4f229sm1780487wmn.28.2023.04.14.11.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:29:15 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [RFC][PATCH 0/2] Monitoring unmounted fs with fanotify
Date:   Fri, 14 Apr 2023 21:29:01 +0300
Message-Id: <20230414182903.1852019-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Jan,

Followup on my quest to close the gap with inotify functionality,
here is a proposal for FAN_UNMOUNT event.

I have had many design questions about this:
1) Should we also report FAN_UNMOUNT for marked inodes and sb
   on sb shutdown (same as IN_UNMOUNT)?
2) Should we also report FAN_UNMOUNT on sb mark for any unmounts
   of that sb?
3) Should we report also the fid of the mount root? and if we do...
4) Should we report/consider FAN_ONDIR filter?

All of the questions above I answered "not unless somebody requests"
in this first RFC.

Specifically, I did get a request for an unmount event for containers
use case.

I have also had doubts regarding the info records.
I decided that reporting fsid and mntid is minimum, but couldn't
decide if they were better of in a single MNTID record or seprate
records.

I went with separate records, because:
a) FAN_FS_ERROR has set a precendent of separate fid record with
   fsid and empty fid, so I followed this precendent
b) MNTID record we may want to add later with FAN_REPORT_MNTID
   to all the path events, so better that it is independent

There is test for the proposed API extention [1].

Thoughts?

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/commits/fan_unmount

Amir Goldstein (2):
  fanotify: add support for FAN_UNMOUNT event
  fanotify: report mntid info record with FAN_UNMOUNT events

 fs/notify/fanotify/fanotify.c      | 45 +++++++++++++++++++-------
 fs/notify/fanotify/fanotify.h      | 26 +++++++++++++--
 fs/notify/fanotify/fanotify_user.c | 52 ++++++++++++++++++++++++++++--
 include/linux/fanotify.h           |  3 +-
 include/linux/fsnotify.h           | 16 +++++++++
 include/uapi/linux/fanotify.h      | 11 +++++++
 6 files changed, 135 insertions(+), 18 deletions(-)

-- 
2.34.1

