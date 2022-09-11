Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19C35B4F15
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Sep 2022 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIKNe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Sep 2022 09:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIKNe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Sep 2022 09:34:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB413F14;
        Sun, 11 Sep 2022 06:34:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bq9so11290256wrb.4;
        Sun, 11 Sep 2022 06:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=mYdrpgsP5JbcifLQdX/BpByfY1vuCnrABArJrcVNCaU=;
        b=my4rLlqne+w/nPQhB66J/DmJxBVy2bXTWUnpMBfHVTIzUx7eATOzR66p09UZTssvBZ
         2yZBjK0Pr34dG3TqfVAAH/0laROgs6a9aQWyCxjK8za/2QC4sevkQOh3mew+8BE5U/kj
         a1HdkZ5Mor/na5LSlZPLnX2TXc0mPdGZUHKhHzck/kwkRi9brBBpMICB7+udSoRtIF/3
         GALgXNVGoqC+T3Cwki61j0iHpawDhsAFDZ0kiuJKxGcuy3Bd7BuxZOvyPr8oy/gqGUu/
         LOEwwO3xDt0bf7k1SBJo6amu+pGG7PsVSzGoZOn8uuWXX9GWxJpIAH/+SjVYK/eeMaWv
         lgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mYdrpgsP5JbcifLQdX/BpByfY1vuCnrABArJrcVNCaU=;
        b=aUunJmdj4coVxtRxqZvUk9WQNKokKnQRIDrhJLR6vrIPFLYFc/phIhF9ADT6wCAFab
         X74SjRkaBHDT6p2bq9zg3rJyuScnthn3DwFINLWGv3ciFJhZBy2Vccpu/J9u36frGm1Y
         r3KgjXoNdJqtvyhgn7/ouvuEHkNuW61qBOU0DwqvZfpmPueM0Yg9Ni9JWBWGdslNJw0q
         4vLZFrEKkfS/eYzhJ/DJOkRvujWbVqbvo6sx1ieyTtrCIsaiG98pt6o3/31giZrq1m55
         WvZ7LVStMB2a31/Ob2KTXqQLs203fHauqCRsUH8SsZ3o046nQiGvkU5HhY7q7auKZJDQ
         LJhA==
X-Gm-Message-State: ACgBeo1unu+SqN9Px2c6w7Q+cnpz5Nqt+CiGjoiDd7nW0Bnz6FA2I4Hs
        NjsVyvhBwrrCHArfcD2NL2F6EWXngQ==
X-Google-Smtp-Source: AA6agR5R3v6STL0NBTILYTOYjujWV/d69PO5+/0km8qDjKTi4YkveRur7nw9zUJa1ZbByp2RIZ0unQ==
X-Received: by 2002:a05:6000:178b:b0:222:c6c4:b42e with SMTP id e11-20020a056000178b00b00222c6c4b42emr13612975wrg.275.1662903290889;
        Sun, 11 Sep 2022 06:34:50 -0700 (PDT)
Received: from playground (host-92-29-143-165.as13285.net. [92.29.143.165])
        by smtp.gmail.com with ESMTPSA id r16-20020a5d4990000000b00228a6ce17b4sm5032929wrq.37.2022.09.11.06.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 06:34:50 -0700 (PDT)
Date:   Sun, 11 Sep 2022 14:34:40 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: fix warning Using plain integer as NULL pointer
Message-ID: <Yx3j8I/jws7g9VOD@playground>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changed "0 to NULL" to avoid Sparse warning

fs/direct-io.c:1137:36: warning: Using plain integer as NULL

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index f669163d5860..87910761039e 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1134,7 +1134,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	loff_t offset = iocb->ki_pos;
 	const loff_t end = offset + count;
 	struct dio *dio;
-	struct dio_submit sdio = { 0, };
+	struct dio_submit sdio = { NULL, };
 	struct buffer_head map_bh = { 0, };
 	struct blk_plug plug;
 	unsigned long align = offset | iov_iter_alignment(iter);
-- 
2.35.1

