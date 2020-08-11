Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E70D241445
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 02:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHKAsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 20:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgHKAsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:48:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DF1C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 17:48:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so6677809pfh.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 17:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=52A4xc+/jrmiozXKI+LLTyESLZ7QKwO1hVqCs6brWXc=;
        b=nCH6zHj4AOKIWgZb4Ahvrwv8CD8AaduZoy5T66g7tY5prKUIgU98KPz6SItfK3J67p
         Iq9PSjA8dMIDiZs2KGE2CUChb5bJjd13bnm363gXbJi/9O6Bxt4Hw63W9mpheCdz93/I
         TdGNxE4MKc5nwXlVpDENDiyuBv+xsi2srJgzqh5/1WXDCo41w1RBj1TT2ORdzEWUqrhY
         ed9Da81FAhmeY3FRJPKghFlsGJr4vjY27+Mm1QEFK7Tmdk1xgFb3aME/cziDItiGir+c
         cOfL2CIjcIvPSRN5mjtyS5Ih4ct4UXNNQRXBn0oMlkvnbWgyspgnYemFJiYFbfxbvp1l
         riGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=52A4xc+/jrmiozXKI+LLTyESLZ7QKwO1hVqCs6brWXc=;
        b=Q7gtl4F88sUQDdwXPqhaHOr8SiVU7ikuvjdx+6CEAqlMZI80NCUQmAOk9BHXxI0ZZP
         UBRNrUdVeg2Pxo6arKwuT45Zwe8hxLEMBTWpym/wyq7EUQbHbi3Z2kWhsmVWJNZCV8ax
         dGABOzdCoGEnjfF21+ogLHJFwzSZhEeXzAAfzMx1ZnNS7pYMl8dLEBSV5UnZx0ej+jRc
         GhQZ/x7MRyyj4m5AxsyeW5FAdXyWZu7a1bYDK7NG9S96GWTg16zWImgrcwLIAohpA5Z5
         AdMqJRWqbMAWeh/dIlj7uEqAVjbC3Y/C6U8/cU0/n6C8yNWoCz/9tH8muKLe2yvOS0vZ
         lgjQ==
X-Gm-Message-State: AOAM530EL6zMym/3c8eeA7sXNB4xPr4ttEyZiF6kpuqxpie324uyPHHv
        oLF1EleppXYhuar0GcNXvMDHOQ==
X-Google-Smtp-Source: ABdhPJyKg7M1xo0mE5OyggHZYj7FNw5Tnfh7CUnhnpzXIT5tIPdbzw8czS+ti2esIItqfhgkfJVtwg==
X-Received: by 2002:aa7:9390:: with SMTP id t16mr3552357pfe.311.1597106901827;
        Mon, 10 Aug 2020 17:48:21 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x18sm22935914pfc.93.2020.08.10.17.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 17:48:20 -0700 (PDT)
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fs: RWF_NOWAIT should imply IOCB_NOIO
Message-ID: <e8325bef-7e91-5fd4-fa25-74cfa169ffd2@kernel.dk>
Date:   Mon, 10 Aug 2020 18:48:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the change allowing read-ahead for IOCB_NOWAIT, we changed the
RWF_NOWAIT semantics of only doing cached reads. Since we know have
IOCB_NOIO to manage that specific side of it, just make RWF_NOWAIT
imply IOCB_NOIO as well to restore the previous behavior.

Fixes: 2e85abf053b9 ("mm: allow read-ahead with IOCB_NOWAIT set")
Reported-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

This was a known change with the buffered async read change, but we
didn't have IOCB_NOIO until late in 5.8. Now that bases are synced,
make the change to make RWF_NOWAIT behave like past kernels.

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bd7ec3eaeed0..f1cca4bfdd7b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3293,7 +3293,7 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 	if (flags & RWF_NOWAIT) {
 		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
 			return -EOPNOTSUPP;
-		kiocb_flags |= IOCB_NOWAIT;
+		kiocb_flags |= IOCB_NOWAIT | IOCB_NOIO;
 	}
 	if (flags & RWF_HIPRI)
 		kiocb_flags |= IOCB_HIPRI;

-- 
Jens Axboe

