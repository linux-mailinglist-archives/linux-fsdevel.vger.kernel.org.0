Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06DD10DCB1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 06:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfK3Fbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 00:31:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34477 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfK3Fb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 00:31:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so15671278pff.1;
        Fri, 29 Nov 2019 21:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ct1pKB7FU+wUU8p27F21GOP7pXY7j1OGt/UKg2jU0Qk=;
        b=GjKAdtVXfq1SUOKKHV6uM+o7Ir/oL77R35zWiNxQ4vvzhYGSZldwpomQFCjxaJCrZA
         H8x2ElRY6ZXSAPFEKRdXKb2pkelIV3L8Z5BOhogmrneB6vQWmC6TNUqdQCYMwXxR9ptS
         XjrMjEl8aE2XqV+MsF8Ktm+i0t7zY1hPyP6vF+y5qG78LeOKHswOCVGbC7UfAdp4/ZBM
         KCid1BeXONTCBre4U9GtLf5Zw9ELQ4zYfal4R40xAODB3sYiCckGNyqSADbI7fvn0/lo
         8uMXuAsxJhZ0Bv8QaCDBMnOxnPBu28i1IugGVPB4Vw7vQ8GOhbQ+DsEtbyvWpEr2YzYN
         lnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ct1pKB7FU+wUU8p27F21GOP7pXY7j1OGt/UKg2jU0Qk=;
        b=rdqx2Ktu+15erawFL2B13IMbtP2336K4+wuag9Z7Ak/FlMwLwVaL+6bmey7HOUiGp5
         n+KrVhRfPbhJfTaTGysPuzgCHrM0/PNstjY1hRVXd3Ejgq7gcnx+yMGi5rAYe4Dto4ar
         GeolCQN0hyFQUlNCvv+UYbZHFeVwPWUnPzTcKj1T4slc8qCBKrQuTPLxcSJ+m8Un2B7I
         1VRPWIylqVEUT5bF+V7tj4wuK2fDP+KKHrgCEB4Sm0AhUtvla9GAsynuuyUZDEVT2mwg
         zo61ezYmg6x7qkMz9vkTJp+RtI5eGYzsQIFLUZRssTCG8UrJGomfQL7vUDuUgqiUOpmv
         B0Fw==
X-Gm-Message-State: APjAAAWvNeLqd9ktAVVfeJKi7QfocZwmSgHsbeXGUjGS012F825Xf0xL
        gs0S0QjIvyaUfBgMMmUkYPw=
X-Google-Smtp-Source: APXvYqywYNXT+HjYM3+qM1kZ50+JF+iAYvZO17IQsx1+SGD8J024RAly9Qidaj7yZTgkZleUYwvUAg==
X-Received: by 2002:a63:845:: with SMTP id 66mr20496575pgi.368.1575091886520;
        Fri, 29 Nov 2019 21:31:26 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id a13sm26131734pfi.187.2019.11.29.21.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 21:31:26 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de
Subject: [PATCH 7/7] fs: Do not overload update_time
Date:   Fri, 29 Nov 2019 21:30:30 -0800
Message-Id: <20191130053030.7868-8-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191130053030.7868-1-deepa.kernel@gmail.com>
References: <20191130053030.7868-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

update_time() also has an internal function pointer
update_time. Even though this works correctly, it is
confusing to the readers.

Use a different name for the local variable.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 12c9e38529c9..0be58a680457 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1675,12 +1675,12 @@ EXPORT_SYMBOL(generic_update_time);
  */
 static int update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
-	int (*update_time)(struct inode *, struct timespec64 *, int);
+	int (*cb)(struct inode *, struct timespec64 *, int);
 
-	update_time = inode->i_op->update_time ? inode->i_op->update_time :
+	cb = inode->i_op->update_time ? inode->i_op->update_time :
 		generic_update_time;
 
-	return update_time(inode, time, flags);
+	return cb(inode, time, flags);
 }
 
 /**
-- 
2.17.1

