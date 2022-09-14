Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB935B7EB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 03:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiINBx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 21:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiINBx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:53:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66A6CF49
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 18:53:26 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f24so13652573plr.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 18:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TRgWwX2Tmd+EvHBnlkB6xTDwLdmxHLqUQDbVImjS7Xg=;
        b=gfs2RGp7aHKyljchnkF0/lk2biBR8aasmcxzX5nmzLNSu52Mrw+mzANHa4H1HRC41h
         Sxim/pIFi71+87PrjDIpILJf2NUu0G8qG6oKvdoX5cc0vrsntYzogY6kvzCmHpWd77jA
         wcvMAyRr9hOjYBk0wM/0TXtMiq1YXm86hFzDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TRgWwX2Tmd+EvHBnlkB6xTDwLdmxHLqUQDbVImjS7Xg=;
        b=1XYimlRj8fUtHoCseT8b1UXqWhOtIPQakxzhm56zrRvz03uhQs9mpqQcl9OtA79FBL
         d4yz2KLAoHPbwch04BnZTIHNqkSD5gCwdQpPkBfAyUfu5Vk2MY8c+iiR6Q064cXzix+x
         wyyl1PfR+Fks5f7LKzztsDaT/SNNFoTX438SoTBAd1cez0d9XCWorudH/HLjfC6/f9cE
         5UogJBBatvBpi/TKIdoaYJZcoYBYG/hSlxGQ3qPrlnCT3Msscov7u+08sq38N5gkO47M
         BOGnp2PM6YjSl9bn56KIvgQlj2sL8099lGb5G6XKX3HNA/k4aBFbixEGsM4rDb00RkMW
         qPTw==
X-Gm-Message-State: ACgBeo0jd67iWTQuwxuJpTQff1/94ZEelWI1D/HNWIRlKmCZZKVNTN1d
        Vi+gDF9sN/keSzIIaUjfD1nLsQ==
X-Google-Smtp-Source: AA6agR4YzfRQlzRi2ZGv7skLDcUk5/gN75q+7y3fCJx2B4yiHMtuwCtQ2hdGuAQQt58B04tkZWTxoA==
X-Received: by 2002:a17:903:230e:b0:178:3356:b82a with SMTP id d14-20020a170903230e00b001783356b82amr12249592plh.138.1663120406208;
        Tue, 13 Sep 2022 18:53:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-223-190-181.hsd1.ca.comcast.net. [73.223.190.181])
        by smtp.gmail.com with ESMTPSA id w189-20020a627bc6000000b0053e61633057sm8524481pfc.132.2022.09.13.18.53.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 18:53:25 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     x86@kernel.org, linux-mm@kvack.org,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Joe Damato <jdamato@fastly.com>
Subject: [RFC 0/1] mm: Track per-task tlb events
Date:   Tue, 13 Sep 2022 18:51:08 -0700
Message-Id: <1663120270-2673-1-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings:

TLB shootdown events can be measured on a per-CPU basis by examining
/proc/interrupts. Further information about TLB events can be harvested
from /proc/vmstat if CONFIG_DEBUG_TLBFLUSH is enabled, but this information
is system-wide.

This information is useful, but on a busy system with many tasks it can be
difficult to disambiguate the source of the TLB shootdown events.

Having this information tracked per-task can enable developers to fix or
tweak userland allocators to reduce the number of IPIs and improve
application performance.

This change adds two new fields to task_struct and signal_struct to help
track TLB events:

	- ngtlbflush: number of tlb flushes generated
	- nrtlbflush: number of tlb flushes received

These stats are exported in /proc/[pid]/stat alongside similar metrics
(e.g. min_flt and maj_flt) for analysis.

I've gotten code into kernel networking / drivers before, but I've never
hacked on mm and mm-adjacent code before. Please let me know if there's a
glaring issue and I'll be happy to tweak this code as necessary.

If this seems OK, I'll send an official v1.

Thanks!

Joe Damato (1):
  mm: Add per-task struct tlb counters

 arch/x86/mm/tlb.c            | 2 ++
 fs/proc/array.c              | 9 +++++++++
 include/linux/sched.h        | 6 ++++++
 include/linux/sched/signal.h | 1 +
 kernel/exit.c                | 6 ++++++
 kernel/fork.c                | 1 +
 6 files changed, 25 insertions(+)

-- 
2.7.4

