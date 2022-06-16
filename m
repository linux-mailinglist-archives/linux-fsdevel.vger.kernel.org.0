Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8D054E28D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377309AbiFPNzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 09:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiFPNy7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:54:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B73A39B99;
        Thu, 16 Jun 2022 06:54:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t2so1341736pld.4;
        Thu, 16 Jun 2022 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=cPFlSvliADEIal5C4DWr8yJhVynNr5MmS8oBFg1ewCs=;
        b=Q09o6LBE5QO7S/7bmTUNL3MxsvaLnF4ak7XRqDKRcqRtHJFjubxZOLv8WZsYrNWKZd
         5KxbkNY2l2e/xD+DbUDvT+4uJ+oDGqsu3B3BSQIlz3vT1epwMyVR6Cr0aeccXiK7AvUF
         ODJYwnUxgw/WwSh3YLj+e217a5PVJqhHbd5JYKg5A1mXvsVj5YmMmma602Dg/BE3uyHA
         S65/iUNxt507YUecKShi3sjo3BnpLD0hnHu3KWWh+DoTor770auEjs2EdhZ+t+EgGnEg
         gTzfkOl8Viw0halexeS/zTvtkveABSM5hkOsfIG0FvVOLbIp4DJV23QrNF8d6+DOZCHr
         /WQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cPFlSvliADEIal5C4DWr8yJhVynNr5MmS8oBFg1ewCs=;
        b=iO4nIETZbyN8ucCeYssWClUG5ZLw9g4u2ptHUQataUDyMxajtzkSSrgB9SXaaeV2dm
         szsE2jaalue0zvL0xW/0DIht66OwY5nuHxal+RgNJnnJYW6eNbJQOd/lvxA2XMsrghIe
         Oz8t0JgMA3pMDAAzdo4hvIgznfEF0ZiLjaDibWRhtBQL8SfWw4cFdcS4PfBYKzU5y2zL
         Rko5XodxfCAyLgN8ff9rNo881a+ARLFIxe0P3FPxyAYXO5AfZhmhoJdtCLlLuD7BiVO/
         PPeyoYH2H/2Cxia5Rl7joSEiNWJgY9VX+uEqjxR4r27TEkT3QYhL6KEC/CjYSchfzSBV
         8a6w==
X-Gm-Message-State: AJIora9oxcqfZLwDy0310cuj3dYsNcU3hjVAaYRne6xuUm1s+xgS4nLY
        9YM7aGjhzU8uGl/x084yWCN27e3TTA==
X-Google-Smtp-Source: AGRyM1v+ZGD9SzKmpsEuYBugVc0H6ImzbWa2dks+j2Ljxs0lyMg9mhisnjHi9XbWpp+uI30qMQ2kXQ==
X-Received: by 2002:a17:902:b949:b0:167:6548:2d93 with SMTP id h9-20020a170902b94900b0016765482d93mr4797205pls.131.1655387698531;
        Thu, 16 Jun 2022 06:54:58 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090a8b9500b001e8520b211bsm1565149pjn.53.2022.06.16.06.54.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:54:58 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     hch@infradead.org, djwong@kernel.org, dan.j.williams@intel.com,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2 0/2] fix the improper assignment for did_zero
Date:   Thu, 16 Jun 2022 21:54:38 +0800
Message-Id: <1655387680-28058-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Hi,

This patchset fix the improper assignment for did_zero in
iomap_zero_iter() and dax_zero_iter().

Changelog:
V1 -> V2:
 1. split it into two patches for dax and iomap.

Kaixu Xia (2):
  iomap: set did_zero to true when zeroing successfully
  dax: set did_zero to true when zeroing successfully

 fs/dax.c               | 4 ++--
 fs/iomap/buffered-io.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.27.0

