Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B83F197C0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 14:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgC3MhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 08:37:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38307 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbgC3MhR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:37:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so21397802wrv.5;
        Mon, 30 Mar 2020 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GTBHkl7isrWXV+sHcC3EtBMm1ghUU8V36ZM9hA1KeIA=;
        b=ACDtkNhRFlh28WtvGv0vfHh3xRvklEc4mwUwoCo2eXP+XKX7m0oWe2gOrEeP0Mi5an
         zyCy7+41PuwBhI3QCxrrQLkQbQmWO4DkbPEq8Rq2NVK+efjGsTZseZcbAFdCYReR4WiF
         Wqf7xBrZOKZmSYflbg/1V8wdPzdAu5peTRQ02c1wuwCXzrHyBxPocDdN6jrTHzuUw2Kg
         9U0OKHCdl6AuRZ567RrIkhyCoaF2/HHHRVEaM1wyEYntrFPOOAMGNN94l2rinI5gulZT
         3L9aY4Lavy//uDFyVzM93fgKjJQz4M6MnI3AATdAMOPzREh/A4yUAu+dTtSCICo7phMR
         5yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GTBHkl7isrWXV+sHcC3EtBMm1ghUU8V36ZM9hA1KeIA=;
        b=CbFLtZ2+iY1jl5596hE759iYL7u80pJovkz6ioHcLDa+8zZcGa+nlW3RKD6I8pKrmp
         bbRYdQk8rDlG4njCAQHdEmfbN2gU+N0xdJCh2U4/kdvy52jdfmg7KwyLXQxEfb/M2mIW
         jlGmT4ZXffku7s5+aDRI4Q089YHsrD5nuPWXUNeIeBXUE9WdavRlwPx2VtVolTh5SMc3
         2/dIZ+/YcybNQnzcAsF0lhxiHK+Tu5ld+FdcBO2NN4WFwgn9JdTKuSIG02YzJlzQ+Mfs
         R99dTdXmEUI4ANOhZbw3Qpaf18ndBntrK0DQTcK+58DNHycYH2F1lthvCfKwJ73rfdy1
         oCnQ==
X-Gm-Message-State: ANhLgQ0l8RDNAVmK6ZqEqbzCT5rnQdG4RAYiw+efUJLs5nGTMQUN8NNv
        m+7DU0v7ZycHO2ZnCHup4hA=
X-Google-Smtp-Source: ADFU+vurjZeZsvZnahTVb/LQoY0qa+ZQITM10ujd3dEmEQZd5K1KGeuhwOct3nVLvtpyi0WBwVk9cw==
X-Received: by 2002:adf:fac7:: with SMTP id a7mr15150439wrs.191.1585571835746;
        Mon, 30 Mar 2020 05:37:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b26sm13735631wmj.21.2020.03.30.05.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:37:15 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 6/9] XArray: internal node is a xa_node when it is bigger than XA_ZERO_ENTRY
Date:   Mon, 30 Mar 2020 12:36:40 +0000
Message-Id: <20200330123643.17120-7-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200330123643.17120-1-richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As the comment mentioned, we reserved several ranges of internal node
for tree maintenance, 0-62, 256, 257. This means a node bigger than
XA_ZERO_ENTRY is a normal node.

The checked on XA_ZERO_ENTRY seems to be more meaningful.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/xarray.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index a491653d8882..e9d07483af64 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1221,7 +1221,7 @@ static inline struct xa_node *xa_to_node(const void *entry)
 /* Private */
 static inline bool xa_is_node(const void *entry)
 {
-	return xa_is_internal(entry) && (unsigned long)entry > 4096;
+	return xa_is_internal(entry) && entry > XA_ZERO_ENTRY;
 }
 
 /* Private */
-- 
2.23.0

