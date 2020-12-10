Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD98E2D67FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 21:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404535AbgLJUCI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 15:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404302AbgLJUCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:02:02 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC24DC0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 12:01:21 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n14so6855032iom.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 12:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sya1PQtNgFqGm2aTT6RKY27a2ojJW0x9lC7904ZSiEE=;
        b=YutlIAu/AqhNz+Bu/8aUeVIh1Wc5bHqGk6HIgREMorxFYmf5MrEWhU0MkW3PiefvV7
         PdVwCMd8nmOQzpWxTKqeHhn3gIWb19QmxbUoAqb+Tg7uTH0FACDVCUDZNI1AaRY0Dx0K
         fy3IYCzZobSZ6IIt0d2LBvs7Npd83LF8yXB6Zsp/4StujyDwmWMzXsVdE4lsncnhibmJ
         ZrxFVSoyR4yDZ9mx57r0pjRwxNlmTe4lWYWOcXNCiA9+gTRLjnu01AocqjVdQYNHwkiX
         8uXrY6AB2CQEH/xq09GwBh75dCrrUUy+q3pM/hEsqwDVOd8F3Dl9vjtoo7i5WqKCOVoZ
         D4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sya1PQtNgFqGm2aTT6RKY27a2ojJW0x9lC7904ZSiEE=;
        b=rds+yjrop7z0J4oAnxefgl346c4skzSCAlUodmXqRwe1fGnERjParIK4W2awJ+zWAx
         pRS8EhKVl1bHXAuazz9L/UA8uVMjzDrSnoeZN516v268F5N2Zava19ZB7YBEvDtjrZSr
         K7u8UakGUN60Kik71BLzVp372nOOywjdboDsfzRzW90i+lmCaq1jsspFhOfZ4g8n2bSU
         OJVDxgkUCD5UdsUr59rilXAoqaz4PSja7l5DPY8FJ7M4JJSmE8LbqU8Gy+BfV876AWrG
         VS2x6/j3mXCp5/BrpszXFgY7aVYDXaSSqYW+9OQSPSBbQlhA7CeknEnyWH1/1bp5eyPt
         tD/g==
X-Gm-Message-State: AOAM533jXEPeFTDUBFBu1PbvBZs0rZ59UsQrZiitlIC/ZEiTx9Sg3oyT
        JKBXWOjvRZm7Qjvt0ky89bumae+Vdz0xHg==
X-Google-Smtp-Source: ABdhPJzdzL3VIXkpHz7bQynuWQjxGeErRYapwHFROBwy7jSEFISUfgh21sMZOTrKlwdshtBSl9NmrA==
X-Received: by 2002:a5d:9a03:: with SMTP id s3mr10246605iol.20.1607630480653;
        Thu, 10 Dec 2020 12:01:20 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x5sm3850277ilm.22.2020.12.10.12.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 12:01:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Subject: [PATCHSET 0/2] fs: Support for LOOKUP_NONBLOCK / RESOLVE_NONBLOCK
Date:   Thu, 10 Dec 2020 13:01:12 -0700
Message-Id: <20201210200114.525026-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This adds support for just doing the RCU based (and non-blocking) part
of path resolution. The main motivation is for io_uring to be able to
do saner/faster open, so we don't always have to go async, particularly
for the fast path of the data already being cached.

Internally that is presented as LOOKUP_NONBLOCK, which depends on
LOOKUP_RCU for doing the right thing. If we terminate the RCU part of the
lookup, then we return -EAGAIN if LOOKUP_NONBLOCK is also set.

The second patch is enabling this through openat2() as well, by adding
a RESOLVE_NONBLOCK that can be passed in struct open_how ->resolve as
well. Basic test case:

[root@archlinux liburing]# echo 3 > /proc/sys/vm/drop_caches 
[root@archlinux liburing]# test/do-open2 /etc/nanorc
open: -1
openat2: Resource temporarily unavailable
[root@archlinux liburing]# touch /etc/nanorc
[root@archlinux liburing]# test/do-open2 /etc/nanorc
open: 3

-- 
Jens Axboe


