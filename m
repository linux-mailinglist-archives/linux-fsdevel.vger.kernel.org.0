Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F4710F6EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfLCFUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:20:10 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:45560 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfLCFUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:20:10 -0500
Received: by mail-pj1-f65.google.com with SMTP id r11so1009306pjp.12;
        Mon, 02 Dec 2019 21:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lm28kIqQgsof6QYEq9ODpPVkMAPFDe+UtXuv02kmoQo=;
        b=bTGnRtqzuSSyN0ILyisTMm70f092tROs471IMDfXRZJSETR5NGutvOJIR21JwSskj3
         Vcscla9/oYopY1R3iCjxR7pxlH5NCTktVZEaZEvMFIYBGOHw+fr+aNU7aPYer6zMmiI8
         P8IyMwdeMRFOB6WVs3FlzD7GpdZ8W6yeENgA0UTlM5liBz3J9Gx7O8Igeaf75dNiSltM
         pMaFP+2scVZa+Gn1xImvyWntdY3Rj7NJ3hoNDAeywDr4JChhcT44XNHHTfGUcJCV4+ck
         WPNMfJz+q5oNEgQHsZqRdaW1LRvnDBuePmEIioQIXTAGhLEZxmvAyRP8wa78oPNUaQqt
         y8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lm28kIqQgsof6QYEq9ODpPVkMAPFDe+UtXuv02kmoQo=;
        b=ILJg++ER35TpyBEQcrRqcz616oZqmj3A7AuK61m336L1vMmYnAZ7aGHwVzCRlImGRr
         KDF039gVeI6VAWPF2sxR242VINIfqcixtE0FYN/7FjHbFJj1hXLmQYNlsiLqUoqjdGnu
         ZWM/mbaeP92ED50nUEaC5wlXQ1N4Osn+j+t83uIOliEsMAqftfWwQU/Oe/VWpXy7fuAb
         xrf5CjvSjsHILyJ5YJs87mxJPqmYIs9rUAJw++mtwW/csjzacSRwV6uHmnVk4JpH9F/I
         qU54gZ4tf6TUeGeGNf1O+eSqjpprw33zkiPB2VQ0zuVBpYA5bS6oJDewIa1UtPLI6Je8
         q/Yg==
X-Gm-Message-State: APjAAAXZ2AL2032svPOAhS9gYzcMWdirXXPUDT23Ut/5tFbln9mWLlMd
        k6JPpQ8WJP7PgAPGYzXw5JGXTUh+
X-Google-Smtp-Source: APXvYqxkiGhrOqHplGU/yi/toEvuCwb9wti9pi8U7pb6IT8DmC1ylbpwhzfqZMrP/lg4eUF/FB7pcA==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr3124474plz.177.1575350409312;
        Mon, 02 Dec 2019 21:20:09 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id h9sm1451915pgk.84.2019.12.02.21.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 21:20:08 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        hirofumi@mail.parknet.co.jp
Subject: [PATCH v2 1/6] fs: fat: Eliminate timespec64_trunc() usage
Date:   Mon,  2 Dec 2019 21:19:40 -0800
Message-Id: <20191203051945.9440-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203051945.9440-1-deepa.kernel@gmail.com>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

timespec64_trunc() is being deleted.

timestamp_truncate() is the replacement api for
timespec64_trunc. timestamp_truncate() additionally clamps
timestamps to make sure the timestamps lie within the
permitted range for the filesystem.

But, fat always truncates the times locally after it obtains
the timestamps from current_time().
Implement a local version here along the lines of existing
truncate functions.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: hirofumi@mail.parknet.co.jp
---
 fs/fat/misc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 1e08bd54c5fb..f1b2a1fc2a6a 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -271,6 +271,14 @@ static inline struct timespec64 fat_timespec64_trunc_2secs(struct timespec64 ts)
 {
 	return (struct timespec64){ ts.tv_sec & ~1ULL, 0 };
 }
+
+static inline struct timespec64 fat_timespec64_trunc_10ms(struct timespec64 ts)
+{
+	if (ts.tv_nsec)
+		ts.tv_nsec -= ts.tv_nsec % 10000000UL;
+	return ts;
+}
+
 /*
  * truncate the various times with appropriate granularity:
  *   root inode:
@@ -308,7 +316,7 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
 	}
 	if (flags & S_CTIME) {
 		if (sbi->options.isvfat)
-			inode->i_ctime = timespec64_trunc(*now, 10000000);
+			inode->i_ctime = fat_timespec64_trunc_10ms(*now);
 		else
 			inode->i_ctime = fat_timespec64_trunc_2secs(*now);
 	}
-- 
2.17.1

