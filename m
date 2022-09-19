Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A835BD399
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 19:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiISRZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiISRY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:24:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA5813DE9;
        Mon, 19 Sep 2022 10:24:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so6825663pjl.0;
        Mon, 19 Sep 2022 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bbpyEIxy2q5E0Mu0eFfeDQBjUZV6iZmC2F5w0SRo/n0=;
        b=Co/4gbdqV3wYszCUQb+RGNGJu20t0HKKIu5oDP6hA8o9BdkU2FmW7i7IcL+7qo2PaC
         gM4RjQzS/YttfgyX5aTlw6dn83JpW5nnVlJPkKOC2VdS3K56xvI+AGNZfBtbF/h1rFER
         ScpZLXretyLf+Rt5TNkDJFqMg/kQ2Ipeq1lo7ytmLUhfwl5T7t+p5MOqXuiRfV4iyrJp
         Q8j82WniFh2z9s041bYtoTiYgUNtESbIF5HpSuNW1z0aCwe1479MPo92D2QSvDuadXob
         nNC7P8bvFcBWcvO0WucpeKiFL4sbIyYia87lUj0/OSbuGM0B/3hp4Okx1oAQO7TWN6UM
         a+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bbpyEIxy2q5E0Mu0eFfeDQBjUZV6iZmC2F5w0SRo/n0=;
        b=ohNvj3FJkuYO3zIU23XcvXFOT1wHPKmREsZ8EaQZntGXa6PZEevTv8FplBLJ+B74Ar
         WSdRDQrtgwiQhniYGntaBePSv0C9ub14wyTwa5V5E2ZbjJAI6mjxNAeN8bP4a8Jku7T4
         HpEPBPDBXzr1f++SK+E/DMr5YVy+iYYn3M6ybwHZF4F1Lacf8tB25Z3mmGU2+xfpdASe
         AJbGmUHh1GO8xjSrj+LsEdXOKUA4Yr4z4jdF6uPBNTMRY3F0vA2kvx64wW0IVs9DSMAU
         jJJtrS0jX3Do2i02SrsOs2uRfhEOMmFtkDWTbzH4fOsi45batH0ADroRvoZZxl9an+35
         PWhA==
X-Gm-Message-State: ACrzQf35eYfvU5KfBDwJK5xcBpJFd6jdP6+VQS+QzSFVW55Dz+HPEHSU
        wI40lfIT7jrPTjpW15n/1ij4WSpbp3o=
X-Google-Smtp-Source: AMsMyM6Qrw6HZuNf6rIjays5IloSGiOAoofUELKN7KLJpWX1ntXV4kAENP3WaVkLwjI5RbzGYGwmPw==
X-Received: by 2002:a17:90a:ac10:b0:202:9880:4cae with SMTP id o16-20020a17090aac1000b0020298804caemr20626018pjq.173.1663608297969;
        Mon, 19 Sep 2022 10:24:57 -0700 (PDT)
Received: from localhost.localdomain (KD027092233113.ppp-bb.dion.ne.jp. [27.92.233.113])
        by smtp.gmail.com with ESMTPSA id h7-20020aa796c7000000b0053f2505318asm21226480pfq.142.2022.09.19.10.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:24:57 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net, david@redhat.com,
        osalvador@suse.de, shuah@kernel.org,
        Zhao Gongyi <zhaogongyi@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        akpm@linux-foundation.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 2/3] lib/notifier-error-inject: fix error when writing -errno to debugfs file
Date:   Tue, 20 Sep 2022 02:24:17 +0900
Message-Id: <20220919172418.45257-3-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919172418.45257-1-akinobu.mita@gmail.com>
References: <20220919172418.45257-1-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The simple attribute files do not accept a negative value since the
commit 488dac0c9237 ("libfs: fix error cast of negative value in
simple_attr_write()").

This restores the previous behaviour by using newly introduced
DEFINE_SIMPLE_ATTRIBUTE_SIGNED instead of DEFINE_SIMPLE_ATTRIBUTE.

Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")
Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 lib/notifier-error-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/notifier-error-inject.c b/lib/notifier-error-inject.c
index 21016b32d313..2b24ea6c9497 100644
--- a/lib/notifier-error-inject.c
+++ b/lib/notifier-error-inject.c
@@ -15,7 +15,7 @@ static int debugfs_errno_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_errno, debugfs_errno_get, debugfs_errno_set,
+DEFINE_SIMPLE_ATTRIBUTE_SIGNED(fops_errno, debugfs_errno_get, debugfs_errno_set,
 			"%lld\n");
 
 static struct dentry *debugfs_create_errno(const char *name, umode_t mode,
-- 
2.34.1

