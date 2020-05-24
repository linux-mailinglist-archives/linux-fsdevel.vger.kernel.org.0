Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122CD1E0237
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 21:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbgEXTXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 15:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387826AbgEXTWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 15:22:16 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF460C08C5C3
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:22:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w20so2751216pga.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvoN8a3WZmoogVlnFEo2G3/jPQNtfJ5pQXb6VgaLeNI=;
        b=bDCsFlzea2K8l+p3JSI1FKOJJN/iUIQ6L4QBMlcQQkwdth5Qd6xp5WdxsO74qmE2uH
         gNIh1EyuSNq8TGu/O7ma6Wj3V0zQVtIidIFWIuCFLubWqKuzAP4PXDF1hJoA51/djpKI
         q0zvlwJNSsDn7/d8IsO90pLEvLJ4/fbpE/Esp7nnNDq8iVLb0/yXGjvGDO+gXoaiK0lQ
         8jTWUcQ5PJFDyZ1LXgDYg/fHHLW/+H+ST/d/eQGYBajLlCJ8srz2A+h4hzgkD6xjzjC+
         Z1Wx1Og3DGA+JcEdbltZrVLu3VUXQrBccs+OnB77TKzta8olRRUlXDRQ0OrpShyD+I8t
         TR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvoN8a3WZmoogVlnFEo2G3/jPQNtfJ5pQXb6VgaLeNI=;
        b=qxbNC7vHcyLPEXt7XVNTX82+jOEiNAJomPPYEm2MqxkbGVVkRugtUElkQqcFfGlBbF
         ruEZAxXdBC32MDwN1ScH4hqPXcuurxf1olM7Jl6pXlU+EuEsaMa0s0Ke1ucrwmSMbDtN
         k1NzJ71xsABE3BS8fp4HlRccib5WqwUtNS9uP6jV2dofjJYByBn8VU08qNwXl97Ia9DH
         X0vKEbDlLBv6XqVjxwoGs5+v80GGIXHAZnQWLI1Z4rN7k4/WliDlaaBgwZjqHar8xo6Q
         UQm8C2bSgEHe4zd6AF0XtQ3HxCV9B6xjL/7vUQRkvee95hhhy4hNwj2wZeQ/IdQV4DRS
         flWQ==
X-Gm-Message-State: AOAM531oHFuRde2Yl4Ah1AFi+cOE2zNUpRke8C0s1YziKqHAA07XjoIF
        v6V/u56sguOdNu+w3e4AopBy8g==
X-Google-Smtp-Source: ABdhPJx6z/j631C9MW2+QGijdBHUqXND2T9T9W5iLJ8e7Bn0BROk5FXSSQIO1YnaN48IleZiosazmw==
X-Received: by 2002:a63:e256:: with SMTP id y22mr23124889pgj.441.1590348135428;
        Sun, 24 May 2020 12:22:15 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c871:e701:52fa:2107])
        by smtp.gmail.com with ESMTPSA id t21sm10312426pgu.39.2020.05.24.12.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:22:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/12] mm: allow read-ahead with IOCB_NOWAIT set
Date:   Sun, 24 May 2020 13:21:56 -0600
Message-Id: <20200524192206.4093-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524192206.4093-1-axboe@kernel.dk>
References: <20200524192206.4093-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The read-ahead shouldn't block, so allow it to be done even if
IOCB_NOWAIT is set in the kiocb.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 23a051a7ef0f..80747f1377d5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2031,8 +2031,6 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		page = find_get_page(mapping, index);
 		if (!page) {
-			if (iocb->ki_flags & IOCB_NOWAIT)
-				goto would_block;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
 					index, last_index - index);
-- 
2.26.2

