Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2015197C04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgC3MhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 08:37:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45382 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbgC3MhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:37:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id t7so21375829wrw.12;
        Mon, 30 Mar 2020 05:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V7VqASLGOtZLIWt8UAZ4fgDhlmQSddnrA9GoHgSljFM=;
        b=KiNfFTgiVGElhiviXMGbeEJF1Sj0reBqqRd1JAqY6dtQ+xrLfAqKiO+wvtWt0jqMwo
         kd2p9hrmXvHJ86B7sBTFSg/8gXLCJs5mcbv+rH/6eMWjUJ02Etk5bE15khDRMfiNP5Rr
         lca+ToA6p+bL0KTC8xcVhapKjtTTaZZJZerZP5kC3Uz7wALvFSQpPWxEXpTH6mg/Q84Z
         mWQcAMbjUw9Yxp0ApqNXa3e6ME1RQbcCbmFQEuwXTljcfZZt90ifi6KRW5Nw6tXLPThd
         dS8XWo6RM+yXUJ6W6ScyDAz8mxZjnGuYIPA34IxYHnKpSbzgetPpq3juE0dKmXRjXqxH
         7+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V7VqASLGOtZLIWt8UAZ4fgDhlmQSddnrA9GoHgSljFM=;
        b=YP/8WZU1JX6Qs1mfqg9yxEu/KlfDTZSqm236AgYtzadcf30I7CL7ASxMVFLdjBoLFM
         LJilYeH26UaXGQc5AklNM/ial0s+zIwaO3Dm0rL1dAyMl0y7mLuFYyNZ18U30LvfXEXK
         b6Kk9al3jOn5/ycl3ceJg/ReMGuFMggpHl8MvbeCXTRslkgA3ngOYk8xcw1rL4luKBh6
         c4YhRDrZi6+MI72OShyCzRPblWxxcCl9lhnY0jWllbCbWXPM2SglaJwqs13NIJL8iN1K
         tg5YD2AMFNUNN1gmOnZopaB0m1G6OIQQHpZ30MvI1FPvpKUr8WkWYZz0RqucQP3Wq6kS
         6bQw==
X-Gm-Message-State: ANhLgQ2s6ASmbnaFFxUhx44Dxw34rz3pHhQnCl9rYptqPyxkEzYTT2ZZ
        06z0WaQamfqqV/M34P32MimhbSSw
X-Google-Smtp-Source: ADFU+vtysQFnHsdSVtmI2LLxnOBTBlmq5/ae1ROcURUj7TPe4C+j2f5KtvUDpPqQarQr/twPtA0MCA==
X-Received: by 2002:adf:e611:: with SMTP id p17mr14545198wrm.212.1585571837686;
        Mon, 30 Mar 2020 05:37:17 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s8sm21367495wrv.97.2020.03.30.05.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:37:17 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 8/9] XArray: take xas_error() handling for clearer logic
Date:   Mon, 30 Mar 2020 12:36:42 +0000
Message-Id: <20200330123643.17120-9-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200330123643.17120-1-richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If xas is already in error state, return NULL directly.

Take this logic out instead of burying in the middle to make the logic
more straight forward.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/xarray.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 82570bbbf2a5..01f64a000e14 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -636,6 +636,9 @@ static void *xas_create(struct xa_state *xas, bool allow_root)
 	int shift;
 	unsigned int order = xas->xa_shift;
 
+	if (xas_error(xas))
+		return NULL;
+
 	if (xas_top(node)) {
 		entry = xa_head_locked(xa);
 		xas->xa_node = NULL;
@@ -648,8 +651,6 @@ static void *xas_create(struct xa_state *xas, bool allow_root)
 			shift = XA_CHUNK_SHIFT;
 		entry = xa_head_locked(xa);
 		slot = &xa->xa_head;
-	} else if (xas_error(xas)) {
-		return NULL;
 	} else {
 		unsigned int offset = xas->xa_offset;
 
-- 
2.23.0

