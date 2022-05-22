Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832805302E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 14:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbiEVMHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 08:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiEVMHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 08:07:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9715435870
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 05:07:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u23so21293768lfc.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=D03ydFw/WCBSetrgrLyLuEKUcsWGma78s11UxloWKTY=;
        b=B6BtDBw4rMQCE6wErr2x8tUIheNWfWC+otgK2fKJMhu+7J/JtRwRq6uN17lIPp6/dt
         siRQtTcRxrWw5u42XmfYpFUVEt2BhJH5CXgLQvoLxsbl6SX20uxc7hAKM4pNSnQET9y+
         qEwxVsCW86KHPKKaTSRY8ro2QD6TdgPtn3tdoYa0L+Fe5hV+06tTRHS/npS5C+RcjAvV
         vI3N3Vo+EnN8i+Ij3djYInWNJY91W8+6TfKmUwDhq7k/RNSLpQgsoGc6yEKCMZyY7Bf2
         aRGCxOqTGxRLv983tVqGVOpejZgryh1OB2NYTyoRBYq8AS2lTuXo1R2yFGTyqbCWLxMF
         Yijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=D03ydFw/WCBSetrgrLyLuEKUcsWGma78s11UxloWKTY=;
        b=CoO6xGwQ+Q/ZOyfuqtQtl1d1HXimIMMidH6F+lw2eWdv6Ltakuvfdl/IV1pKmWJ5CQ
         /Ua2fl6A+X7ArAEhzT6aMkckU+2crDEM/Wl0Dy4gW99QGUMobuIoAP3pqGcSaIvlJt47
         U1uhfdKWhC371KZptW/KJPL+0fpUaMMNJs7Y4yCDNPnIh1AxbEpqCEKp2coByyjNBeCJ
         1pZ7qUZwbbwExRtUk0V1r/XO01dykRWRKQ6v1ThcgBj1aCltgk6JsWFUhX5E+ZxY8C9H
         UVQLTt3anIotkhZ6PjXndAS9bfR2Jy1f3M2S1mFTRQp8yYyxGTRS42tXTWm+P7MqrlpZ
         JjNw==
X-Gm-Message-State: AOAM533tp0Vaj/MkJc8MJGvzhdpOelJD0KaxrM9THKTpnEZyZ3UAMbGf
        otTtgvha/n5G3kKsMk7kP1k8aS4KblMJZQ==
X-Google-Smtp-Source: ABdhPJzsW/9MUyuyCTGQqL6el5IWs8hGb67MrCOR4uNQI+ikOxNGdNoJHg4Lby2fDhqtUclO60SFMA==
X-Received: by 2002:a05:6512:3da0:b0:478:5b79:d76e with SMTP id k32-20020a0565123da000b004785b79d76emr6080851lfv.540.1653221246703;
        Sun, 22 May 2022 05:07:26 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24e97000000b0047255d211b0sm1429386lfr.223.2022.05.22.05.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 05:07:26 -0700 (PDT)
Message-ID: <eeaba25e-7c79-3c46-c39e-a2352dbfe007@openvz.org>
Date:   Sun, 22 May 2022 15:07:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v3] fs/open.c: fix incorrect fmode_t cast in build_open_how
To:     linux-fsdevel@vger.kernel.org
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes sparce warning:
fs/open.c:1024:21: sparse: warning: restricted fmode_t degrades to integer

FMODE_NONOTIFY have bitwise fmode_t type which requires __force for any
casts. Use __FMODE_NONTIFY instead.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
v3: split, according to Christoph Hellwig recommendation
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 1315253e0247..386c52e4c3b1 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1021,7 +1021,7 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 {
 	u64 flags = how->flags;
-	u64 strip = FMODE_NONOTIFY | O_CLOEXEC;
+	u64 strip = __FMODE_NONOTIFY | O_CLOEXEC;
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
-- 
2.36.1

