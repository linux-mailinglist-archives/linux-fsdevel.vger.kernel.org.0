Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C2826798F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 12:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgILKfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 06:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgILKfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 06:35:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43436C061573;
        Sat, 12 Sep 2020 03:35:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so6950429wme.3;
        Sat, 12 Sep 2020 03:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GqII6YFRmle5ooyyYumbT88Wz1v4a3gTrrvPa6xyuU=;
        b=PYIkjuP1wK92Fc1t2W7kDjFmenb5CaVDX6oaRIxPFdx95eyrQpYTBVq3v1I5ep1NMc
         B5U/DjA2IoQCRk48CSaXE6SEF+KM8VxBKXmDvxOGZFR9EjmhwyPjXCRChrpPD5xvXeKN
         ikEDT5wNVDQkN+2WFwp/2agcn5iB812qTCkmIIihVpDfMI03brf++XgluoQfId+Hf64t
         P5IZcI/nVLepy8pomPJnFHDmGN3ueG/vpJjZ3bBZYY5uR1pvicuNRf4GrO98zfa9U9+v
         1/BN9U0QXJFni9yNtpeY19rZrod8SUuOsNiXWlXcA4hxTGi0u2Y439BNwDEo8UDeXFks
         ZB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GqII6YFRmle5ooyyYumbT88Wz1v4a3gTrrvPa6xyuU=;
        b=D7iCacDqHiRr0kPhQkUzOxhXBx7qtFIs1USLAjx9D/dHcB2qi0pdwwfD/+EpelH0nE
         xf6uilDA8RuswRz/Gh5jg3vLcf/OYWCezY7yyjavK6l2KAR8l6LEBtuxiPHLKUVP7fe9
         6XCNMT5SPtMNXE3tJ2PjVEPBJzgytXR6kikV+7U/debVacZDjp14p6IvlgUwvxt+gKVk
         vJ7DP9cujM7PA2IryFWTkiinlObnUlJJJf16105Q6vDBw9q1PPkio0JDLVZKLnTukJjT
         odt0Trd/2hmttltw6V32DCpnXWLJqBAVGNpcIJoEuX74YR39LMaz4GFXdI6ySThGIvxC
         HS5w==
X-Gm-Message-State: AOAM530ymbsIf0gH5iHpnpliTp65+HEDq8Fnas9CfURcOKcJMUG2ew0J
        rWGG2l3td7Gle0ZwwOPpU1Wf4WpYQlbntfIN
X-Google-Smtp-Source: ABdhPJwSH85cILOwNHZ32AM+pMn7uODfhxDzNKv2VBsdgg8cvv2IbFSh7/vMoDsb/TT3rUPJYyRbvg==
X-Received: by 2002:a05:600c:2742:: with SMTP id 2mr2658231wmw.136.1599906948699;
        Sat, 12 Sep 2020 03:35:48 -0700 (PDT)
Received: from localhost.localdomain (188.147.111.252.nat.umts.dynamic.t-mobile.pl. [188.147.111.252])
        by smtp.gmail.com with ESMTPSA id d2sm9701109wro.34.2020.09.12.03.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 03:35:48 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, viro@zeniv.linux.org.uk
Subject: [PATCH] fs/pipe.c: clean code by removing unnecessary initialization
Date:   Sat, 12 Sep 2020 12:34:52 +0200
Message-Id: <20200912103452.23855-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Previously variable 'buf' was initialized, but was not read later before
reassigning.  So the initialization can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 fs/pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 60dbee457143..a18ee5f6383b 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -495,7 +495,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		head = pipe->head;
 		if (!pipe_full(head, pipe->tail, pipe->max_usage)) {
 			unsigned int mask = pipe->ring_size - 1;
-			struct pipe_buffer *buf = &pipe->bufs[head & mask];
+			struct pipe_buffer *buf;
 			struct page *page = pipe->tmp_page;
 			int copied;
 
-- 
2.20.1

