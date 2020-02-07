Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D754B1554FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 10:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgBGJqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 04:46:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34427 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgBGJqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:46:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id j7so794310plt.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 01:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EbwaprPrZGCOYIwfEnMtNO3dQPuMiwviJCmc3lmn8AY=;
        b=VmUx1h4FramdQlLYK67HMvyJUJSObeh6oazbewLNtsD9kcttMWe25wmUtVINq1Zpsq
         +v5sGHCfnMzpSKKins2sJ6fpzFHLv2BtJhYy0gCNHfulT0hLv6c/2+SyN9Ngy7iXiz0U
         ur1clhwD2xagfQmqEPzKMRLAa8T9v5tyur/Aak2EoeQFhIOnqJ/FN9FOrlIus/+cJ5e7
         6TNxbU5IhqQj8pyp+Eqto2rAXzAU/AddZppTzFrPD1xN4AWi5eL03LJ0sstwEF5+hRuh
         CvDDMrcBw2+3VGGQwMywb2gk4i+4HhRu1owMuIyN4iucRQCigWiYQLHxTf1selsSE/GU
         wRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EbwaprPrZGCOYIwfEnMtNO3dQPuMiwviJCmc3lmn8AY=;
        b=plXKHIWWyyAqBScF9WZKxlmaZYN6TS7fYgzcutTptejgDQSB5I39aKcEQpRFh0cu9D
         ZwWRnusUxb7uraLEsGyNd3GPOA5xuLKwZEeRfe21Zw+pUmMCdoS7IMMDfXTApikZiaYd
         tRwAUKHlQHpJpIkuYjH5jETXhDvRJQBK2IoxQuUaV4Pt4bCcMSTFjr7kzXNn/CHbINpp
         V7bnR7jJcWYUOh07mht8rRWnZMpXFIVDgsQFEXaseZIMNCcprpinA82EI+u5GBT+zIK6
         iQK4nvID8e3Kc9n2SZXjoYHY2Nmigs5tvN5S3tcf5aQDxEloOLfBFAw7WYXglRFpuKLQ
         1KHg==
X-Gm-Message-State: APjAAAXdEqDRaHKjdeTO14tjC0AHLr0th1QVTuAUyFhoDXqzlsxx5Y0X
        qPOX84UNojPHBpL1LHf5UiI=
X-Google-Smtp-Source: APXvYqwrvd8VCqNRAnGXHhaqOvmEP9aP1fIKWhTprEH2q71XrNHyxUvfuIyhkyTGXMYkOWtrRjGa5w==
X-Received: by 2002:a17:90a:c385:: with SMTP id h5mr2847082pjt.122.1581068807901;
        Fri, 07 Feb 2020 01:46:47 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id b5sm2265275pfb.179.2020.02.07.01.46.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Feb 2020 01:46:47 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Cc:     linux-fsdevel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH 1/2] pstore/platform: fix potential mem leak if pstore_init_fs failed
Date:   Fri,  7 Feb 2020 17:46:39 +0800
Message-Id: <1581068800-13817-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

There is a potential mem leak when pstore_init_fs failed,
since the pstore compression maybe unlikey to initialized
successfully. We must clean up the allocation once this
unlikey issue happens.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 fs/pstore/platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index d896457..114dbdf15 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -822,10 +822,10 @@ static int __init pstore_init(void)
 	allocate_buf_for_compression();
 
 	ret = pstore_init_fs();
-	if (ret)
-		return ret;
+	if (ret < 0)
+		free_buf_for_compression();
 
-	return 0;
+	return ret;
 }
 late_initcall(pstore_init);
 
-- 
1.9.1

