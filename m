Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC63B37BD6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 14:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhELMz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 08:55:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56942 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhELMxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 08:53:53 -0400
Received: from mail-qv1-f71.google.com ([209.85.219.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcelo.cerri@canonical.com>)
        id 1lgoLz-0004WT-8z
        for linux-fsdevel@vger.kernel.org; Wed, 12 May 2021 12:52:43 +0000
Received: by mail-qv1-f71.google.com with SMTP id s15-20020a0cdc0f0000b02901e9373e40e2so7443354qvk.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 05:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JdJWPsLAfKdSrlcJXApgGOgu0SgFC1Lxu+sFe1F8Mh4=;
        b=WeydyXcG2OU0orhG7MijSV+JcLZPX9DU070av8xHwSJTtAIAbjLSCIKbK8HXAOkQ/+
         K7F9pQaRXDvOwUJWWB6EUD+kMToxZ7O/lyKcWkEclvMKT10r1URCOin4iE7zZNo05CKU
         bw4/3obCEFqJfnDmdaPyMbS9gBu5hAu6xlxqB3l/rBbPxVEXzCKFDeKsbdxxkHBiwlDQ
         jv2nmXZmQzx2PEVe5Op2Q8h/ARG3XnohYcoCK6Dc2SdKLrhgLws5tidXtgGu9YRPA0du
         CZX+9C3Iowc4+Ppadq2+cmB9ryymuyvqbiAaRVfnnlaE5PqN6rnK+d0eXsj+LsL1pKDH
         Ji6Q==
X-Gm-Message-State: AOAM533pdgjk8zGnwM5kPVOf8iEEX73Lx0x56iaw57ELzbfuNxQOvfVU
        H/xcK6qpmCbZaQDUZ7ESiEWQywazukp7UHagZaBT95iLiPDPaq189qio8eqbdz7JUIPd2ggAeCo
        1NYec9BThom37em3jMWBeHU4b3Bndze4o1f5vMHeiTg==
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr33319009qtx.98.1620823962013;
        Wed, 12 May 2021 05:52:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuqjEQEtmFz73vd/icEA1cwnnEhbXyEvzkiSraOE0deF0dDap5hbBWAE60w5hReydESlh81A==
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr33318983qtx.98.1620823961725;
        Wed, 12 May 2021 05:52:41 -0700 (PDT)
Received: from valinor.lan ([177.76.120.156])
        by smtp.gmail.com with ESMTPSA id f16sm2947074qtv.82.2021.05.12.05.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 05:52:41 -0700 (PDT)
From:   Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        David Disseldorp <ddiss@suse.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Helge Deller <deller@gmx.de>, Oleg Nesterov <oleg@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] proc: Avoid mixing integer types in mem_rw()
Date:   Wed, 12 May 2021 09:52:12 -0300
Message-Id: <20210512125215.3348316-1-marcelo.cerri@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use size_t when capping the count argument received by mem_rw(). Since
count is size_t, using min_t(int, ...) can lead to a negative value
that will later be passed to access_remote_vm(), which can cause
unexpected behavior.

Since we are capping the value to at maximum PAGE_SIZE, the conversion
from size_t to int when passing it to access_remote_vm() as "len"
shouldn't be a problem.

Reviewed-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
---
 fs/proc/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 3851bfcdba56..8dbc6a1aaadb 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -854,7 +854,7 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	flags = FOLL_FORCE | (write ? FOLL_WRITE : 0);
 
 	while (count > 0) {
-		int this_len = min_t(int, count, PAGE_SIZE);
+		size_t this_len = min_t(size_t, count, PAGE_SIZE);
 
 		if (write && copy_from_user(page, buf, this_len)) {
 			copied = -EFAULT;
-- 
2.25.1

