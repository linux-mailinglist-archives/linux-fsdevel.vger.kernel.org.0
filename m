Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B645C7B7E11
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 13:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbjJDLTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242245AbjJDLTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:19:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ED6E5;
        Wed,  4 Oct 2023 04:19:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40675f06f1fso4630435e9.1;
        Wed, 04 Oct 2023 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696418377; x=1697023177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdSMOqyI/Qm2nBy4+9Nq5mSXBIbAfD+yRNlJMg5NxcI=;
        b=nozvkPIcSknqpkVEgY2Rzlp2QcitOBor26uqinVrTN26tfxYvkkcFhcVwKBpM3sHp3
         disW0hQSFrJpUzsDnLS6iD7XGQn3xfVCQrZnhWY/pm+WzZi8phgP/sSHZa/nH5XWRK+z
         4qLS6OUQxt7ODKauSb6cLeLypryGm06dTgoeotMyFJlPaBSN67c07hf/whRwjOzrBaEa
         iOr+lHonaiVXeFlb4APqlAd1jvuStTgTfd3fatBcgFiKhHa+r9kuCJOmYe+QjGmSSi6x
         Svytw22uj9z4pAksIyHlvbTs09eAYEX/aDnTkRCJgL1fzB31W37HyRjQaMMqo00YlsOS
         NPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696418377; x=1697023177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdSMOqyI/Qm2nBy4+9Nq5mSXBIbAfD+yRNlJMg5NxcI=;
        b=PLhP3deebjIPjQQIE2hoKd9AJe+VdbgMN4Qbvt1wsd9y5jE4DFzTBLSTKavS9ZLQQf
         7tt2BgvvBRk5aRXEkRyh9CGYUu9QeZIv8un897C784pQYizsbHbfjcGuT3+aZrElwGZG
         L48rhtmlFdZXM1R06UolghPxktMwwUVxBQ/eFFt5fdY0BuVBcoSbIYTfSUm1jEh2MTHf
         jBTPEHZbmpbQbpqCRD+M2PDlt/8jp9Lh060UtBwtEJO2lgv7542a1/MejMpg39Y/7Jiq
         mGRGbUQGqItkCaVNSxZW2sIGlWfefLjShMb9Wj2HFX2MqoFtYyYpUVfhvZKjBnlvGQcs
         tMXQ==
X-Gm-Message-State: AOJu0YzAeODohOLO44wegOsf29YYoHsgdi7026hDK18xkaRziud3q2az
        lxwTvV9j/qrFK4PNdpCz7fkXax7OQSM=
X-Google-Smtp-Source: AGHT+IGfm/7SJFfAziYdhTOsE+/Het/A9KoBfNR0Xm8lxr9whAquAp73f8w7asbiyaeE/YD43LVORg==
X-Received: by 2002:a05:600c:4689:b0:405:29ba:9b5c with SMTP id p9-20020a05600c468900b0040529ba9b5cmr4403104wmo.16.1696418377246;
        Wed, 04 Oct 2023 04:19:37 -0700 (PDT)
Received: from f.. (cst-prg-67-191.cust.vodafone.cz. [46.135.67.191])
        by smtp.gmail.com with ESMTPSA id o16-20020adfead0000000b003266ece0fe2sm3761527wrn.98.2023.10.04.04.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:19:36 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     brauner@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] vfs: stop counting on gcc not messing with mnt_expiry_mark if not asked
Date:   Wed,  4 Oct 2023 13:19:16 +0200
Message-Id: <20231004111916.728135-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004111916.728135-1-mjguzik@gmail.com>
References: <20231004111916.728135-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So happens it already was not doing it, but there is no need to "hope"
as indicated in the comment.

No changes in generated assembly.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e157efc54023..d785bcb75111 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1344,9 +1344,9 @@ void mntput(struct vfsmount *mnt)
 {
 	if (mnt) {
 		struct mount *m = real_mount(mnt);
-		/* avoid cacheline pingpong, hope gcc doesn't get "smart" */
+		/* avoid cacheline pingpong */
 		if (unlikely(m->mnt_expiry_mark))
-			m->mnt_expiry_mark = 0;
+			WRITE_ONCE(m->mnt_expiry_mark, 0);
 		mntput_no_expire(m);
 	}
 }
-- 
2.39.2

