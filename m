Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BE82E0C17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgLVOyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 09:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbgLVOyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:54:25 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26DAC0611C5
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:53:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g3so7556929plp.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WpzztgDjuirSaoCm4Y9iwgLXbmOFGv5bSk1ou8troPs=;
        b=SqjN6hrfpyhBwT61OSi1kdMYlrZ3RN/kNoO0meZihnrymD1OEZhDiehSeRBO23nRd3
         0bePzkBUAfUa3AueEFxYHLVuAUzf/70fjyq1CMYK9znh3Dt3g5NRXaEH9h3Y+Ll5ngAw
         EqwY0xb471qaO+7coD9Rx3Xyzz2C8we1VZ9AUBLgNPufs73v+d3cQjmp9/zxvoiPMfxH
         hS/tFA6Hf6KCUPvoEjyuLlp0mHV549uAKmUN3uw6NhbkY1HD7luXcKfDEWpPUPRv4xXI
         WSufNIjIFu+kpf28itIRTLRtWwm2y2x+InNRzR+rcAM53ftC9V1P4fpGMavgLphPfdiQ
         of6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WpzztgDjuirSaoCm4Y9iwgLXbmOFGv5bSk1ou8troPs=;
        b=mbG3V3lrHeDB/PLaYDwxH72rJ4nLyzA+Uy47WlfmYdiVi7qBr6P8ClpzzXYN9toKB5
         Fj+rW2W2SkIrGcUEw0ff/s1TQ6Rj5Y3kH15ekb492K9zhi3SLyc9HTcv9xZvC0L4dCcD
         FQQ6iEU+9CpieH3xjLTVHAekYZTwKIxC3s12BXLj426XNtjpR11nuawinohTP12l5svj
         YOnLbTez7dt2d2lyoG0wWsl2brO+5h2QvGhmmMZXBkmWjnOLVEJ0pkAN1JplLaBzokpz
         q+PK3FUixeHhtsBLie3k2JHsZaZAWJVVKPlCz+cDxG8I2nfz62Sf3LLCpI3Zf0KcSxp+
         +A1g==
X-Gm-Message-State: AOAM531EHLunB06jLxd+zkXRMpmxi3ozJy07C4MVBqMtNuHyKYTqERD6
        EiuicvLgB+trA/Y5KiR7cZp4
X-Google-Smtp-Source: ABdhPJxtTfGgv72xCHxYQaMRyp49L/o4fVi3XSgB6dBOFr3oospxL5XhVJtc/Nm8dWEkqKFRd4gPaA==
X-Received: by 2002:a17:902:6b84:b029:dc:3419:b555 with SMTP id p4-20020a1709026b84b02900dc3419b555mr16883881plk.77.1608648804465;
        Tue, 22 Dec 2020 06:53:24 -0800 (PST)
Received: from localhost ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id h8sm23516011pjc.2.2020.12.22.06.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 06:53:23 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, akpm@linux-foundation.org,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC v2 03/13] eventfd: Increase the recursion depth of eventfd_signal()
Date:   Tue, 22 Dec 2020 22:52:11 +0800
Message-Id: <20201222145221.711-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222145221.711-1-xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Increase the recursion depth of eventfd_signal() to 1. This
will be used in VDUSE case later.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/eventfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 2df24f9bada3..478cdc175949 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -25,7 +25,7 @@
 #include <linux/idr.h>
 #include <linux/uio.h>
 
-#define EVENTFD_WAKE_DEPTH 0
+#define EVENTFD_WAKE_DEPTH 1
 
 DEFINE_PER_CPU(int, eventfd_wake_count);
 
-- 
2.11.0

