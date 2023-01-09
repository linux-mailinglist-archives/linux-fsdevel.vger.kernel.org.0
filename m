Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA60B662C40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 18:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbjAIRIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 12:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237165AbjAIRHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:07:40 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB56E3FA04;
        Mon,  9 Jan 2023 09:06:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h16so8869133wrz.12;
        Mon, 09 Jan 2023 09:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0emETAKZCtSXYToEsre8JI2jJV7Qjui8pwwcazlWBI=;
        b=oSLMmH6XmQ9ZkPRBrkTmN3mhpQ9i49vEkq9PGLRKWayixc6EV2B/5q9uq02PNsPuhU
         r0Sw23lIFRliZoQuCKdjkxJzUGOhkpGhop/GjpmtrsQCJX0JBenX/RWzYF2X06Pj6scK
         WJKgmqfSHVvpiPbRFKzsRyOW27GKj3mRuQIj3iesOWw3/gYQOW0flL8TGj2TxJgZpKzh
         Ae4YoXwjM636c1f9N19q9kiGINgA83eoXp/4tvlJ2syFTMc1oEyBQNm4U+azRkSu5t4i
         jrfSIqCtWhAmQv97i64vK5A6qc4EURTXyuvGxPSM/T6v8ShxWSAKNJMWvc2B+X4Pc4V+
         kJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0emETAKZCtSXYToEsre8JI2jJV7Qjui8pwwcazlWBI=;
        b=jFmrmwbpbnc25iGuitPucFLOLmU021xbqWhH8guw9FNgXrYAF4oughG9eailE6Qq6E
         RiNTN0S0GK1S9GXGsBt0BjNRpD5Gd4APcVzrExjc9KinP6Qy6fFZobdMFgGxhj3kyTJO
         E0sxYP+pgjX6F8tovTkUjudgpi47PWDdzzc1ernhz1NVTcLJBUzerxeegxVpjYWEqPcA
         uFtrgNQ8s7SV+tjy53kEK8qXCUMuv11PY3lQNJaxniS07TI7AD7lvrpM/CIzXzmRRBvR
         RVoyWkysdoqaStBfe09GnG4Vt7VJ/ero45erqzEACsRpA8KER7CeC4QsiUnvNdz6Ti5Q
         vKfg==
X-Gm-Message-State: AFqh2kpyB0wvxhR9GSNdHNBvqUV2pDTzX7lGTEE9t0P6VCzrV7i4WShW
        q/505eiZM8iAz6DQ8YV08P7xuj6udd4=
X-Google-Smtp-Source: AMrXdXu81xZrk4YUEVKI+omLJ9IrHFcmXGj9TnN86K38SVAHt2dM3QruC1nRtibbE8MKLxnEKrB0Dw==
X-Received: by 2002:adf:fb08:0:b0:29a:375d:4c41 with SMTP id c8-20020adffb08000000b0029a375d4c41mr17774270wrr.14.1673284004972;
        Mon, 09 Jan 2023 09:06:44 -0800 (PST)
Received: from localhost.localdomain (host-79-13-98-249.retail.telecomitalia.it. [79.13.98.249])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d6b8a000000b002425787c5easm8954527wrx.96.2023.01.09.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:06:44 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 0/4] fs/sysv: Replace kmap() with kmap_local_page() 
Date:   Mon,  9 Jan 2023 18:06:35 +0100
Message-Id: <20230109170639.19757-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

kmap() is deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

kmap_local_page() in fs/sysv does not violate any of the strict rules of
its use, therefore it should be preferred.

Therefore, replace kmap() with kmap_local_page() in fs/sysv. kunmap_local()
requires the mapping address, so return that address from dir_get_page()
to be used in dir_put_page().

I had submitted a patch with the same purpose but it has been replaced
by this series.[1] This is based on a long series of very appreciated
comments and suggestions kindly provided by Al Viro (again thanks!).[2][3][4]

Changes from v1:[5]
	1/4 - No changes.
	2/4 - Delete an unnecessary assignment (thanks to Dan Carpenter).
	3/4 - No changes.
	4/4 - No changes.

[1] https://lore.kernel.org/lkml/20221016164636.8696-1-fmdefrancesco@gmail.com/
[2] https://lore.kernel.org/lkml/Y4E++JERgUMoqfjG@ZenIV/#t
[3] https://lore.kernel.org/lkml/Y4FG0O7VWTTng5yh@ZenIV/#t
[4] https://lore.kernel.org/lkml/Y4ONIFJatIGsVNpf@ZenIV/#t
[5] https://lore.kernel.org/lkml/20221231075717.10258-1-fmdefrancesco@gmail.com/

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Fabio M. De Francesco (4):
  fs/sysv: Use the offset_in_page() helper
  fs/sysv: Change the signature of dir_get_page()
  fs/sysv: Use dir_put_page() in sysv_rename()
  fs/sysv: Replace kmap() with kmap_local_page()

 fs/sysv/dir.c   | 118 +++++++++++++++++++++++++++---------------------
 fs/sysv/namei.c |   9 ++--
 fs/sysv/sysv.h  |   1 +
 3 files changed, 71 insertions(+), 57 deletions(-)

-- 
2.39.0
