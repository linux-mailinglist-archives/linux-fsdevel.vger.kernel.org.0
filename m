Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740D17A5B62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 09:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjISHlC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 03:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjISHlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:41:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320F7122
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 00:40:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso40684731fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695109252; x=1695714052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIZLmfcwEqQKatRYsYmTe5x1vkObbB5a/MorlWyMkXw=;
        b=EEa1kexzwJPZWMVHWnEwZf74yHGR0v9QBwYtSi5U865cQSU+6OgAL6BtnRf/bofOfL
         6EfdogIh6yE3XSL0QmqPKvmBo6M64Nd47TNr8vajvxlmOU7MTP3lmKqSzmE+B0vTjFTE
         sYx8uss4Rls6KTTFti9zCLwEXbynKgUAMI8kwyBdpnfhA+bU6uFQ7Q2/7NggQsxaHGWy
         hJ9g09gAxQ0CHWAUlYKVldwTAZj2UNACQnfnbDlBe6pmVl3f55x0fOLJfe3JHIpYRbDG
         iL3jcFcF/QrhY7iukXFZKvEWArmCYaP+c65gfxgkWWpWotpa54qsWOlODv6AHxxBCPOx
         FioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695109252; x=1695714052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIZLmfcwEqQKatRYsYmTe5x1vkObbB5a/MorlWyMkXw=;
        b=sQ/Z0oZdushwuVHTvvd31n8t50z1zB8riMAov1+bzNnKLVAoQoJhUt+wSxGnvTNMpm
         fAWMcQ9Ldu/FpJWGowrrIbAZ/rDlQk8PAF1aw3R+crtlmRe8+o5CWE1UauHmPj/bFOJu
         TP+2tebObiZx9PWlG/jv46PjJ2jDvABWwksyFJ5+FgfIcjtmVZ7jYSzoHQQgsxYw40Yk
         MkmJylZfvhA4q974/JzhkgvP56QLC/uO3naj2NpltA2KrRWXZ00Y+1BemPWbkHTX/nuf
         crVJ0Iw4ViMZOPVHBo557vV6x5Fu0x28508Ev9yy9vkEYhnutzwTF7mowRgUGzpkghPu
         SLtw==
X-Gm-Message-State: AOJu0Ywlno9jTDwqdSTmjACZKKwUYSu1EgmkjqBp26HLNe4oX6RSe45l
        h2SarpTExK02iGRp2sY9bgWWlg==
X-Google-Smtp-Source: AGHT+IFESMgia33Unj4qgPgTAu0YapNLJtmXQLw5hb/i0fdDpFD8z/N9ycFzJljSRyh/xRbHoJilbQ==
X-Received: by 2002:a2e:151a:0:b0:2c0:2e1b:5627 with SMTP id s26-20020a2e151a000000b002c02e1b5627mr458469ljd.35.1695109252437;
        Tue, 19 Sep 2023 00:40:52 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id fy20-20020a170906b7d400b009ada9f7217asm7441851ejb.88.2023.09.19.00.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 00:40:52 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/pipe: remove duplicate "offset" initializer
Date:   Tue, 19 Sep 2023 09:40:44 +0200
Message-Id: <20230919074045.1066796-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This code duplication was introduced by commit a194dfe6e6f6 ("pipe:
Rearrange sequence in pipe_write() to preallocate slot"), but since
the pipe's mutex is locked, nobody else can modify the value
meanwhile.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/pipe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 6c1a9b1db907..139190165a1c 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -537,7 +537,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				break;
 			}
 			ret += copied;
-			buf->offset = 0;
 			buf->len = copied;
 
 			if (!iov_iter_count(from))
-- 
2.39.2

