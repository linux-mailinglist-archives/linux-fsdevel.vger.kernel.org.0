Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E834391810
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfHRQ7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 12:59:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44701 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfHRQ7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id c81so5702980pfc.11;
        Sun, 18 Aug 2019 09:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PROzJfbp0ODOr1Wl6KKNqPCVH4+5GxUkJXbhUONEYSY=;
        b=dGXA0inWQvE8aXZCNgKD/FWPA8bj/UjFevVpEkp+Wi7hxNjRDW5wAxvF6I0Vm/MLXk
         aLZNJduj2iNk1UelnG7X+FYtMwNorfo7pbBQFH2g+dfyS1/5nNJw+xaqYilJfEm6tJEL
         7xC76qhYekklaBW6T07XvJVfiOxe3pZg9BXuW+fTEYTqn4TBONuhhsCfg1ByhQK60h/o
         2To5iImTup7ojxCd0KoFIhPFzUUUqj2wzpAbjYC8jpWkfYBY3aTaii7JhH2QtLi25Wul
         novYUUpGq1c+NpiVHS+GRCL1eY6WNo9NM7Q8d38SnCf0KPIvUo16BPh5dpSzCP928GcX
         X9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PROzJfbp0ODOr1Wl6KKNqPCVH4+5GxUkJXbhUONEYSY=;
        b=ajTdRGUJ3ok9VKWcQas7bJ7yrLjvOj5d10oDxDQddb+FNcgYlYKTMn+H3NHrEB+CyO
         hwcH2OsV6oF4i4rQz/8sc7SDHZ22dBrYAbBHN519ZivFSQ665NrMvxhuJORuAO1LrPMb
         NcNRvRj61ocXIAKB65zHTrfg6rpweoZresW5jYLxsdd3mGn7yDXZ+WLVERw9qCVtihFk
         JK9k1Czd7tOeGAlksMf5St+eyjUMM2dnZt8fQH84IaHkBVTXOil93KcJrwLTh0r+/J5H
         qOLdoZw6/ZD+pCpHgfTUIssD+/7egyXwwFEdhLQHwp4nCcSdZzyo1RzPlg3bDmG3yO3D
         Ne5g==
X-Gm-Message-State: APjAAAXTI3FhnGuWYeq/P1riqVLgblHMy+57ovzo5uWHBJdLPRAiYM5X
        rDYZDLqzgGMxrnrRBwmaYs6zdD9f
X-Google-Smtp-Source: APXvYqwvQPeHGvxt0OGk+f3slnmRpy1dCIPr5h4Er9+GDyrbygH6nVTj4ScO9Hd2dpIulMonyg43cg==
X-Received: by 2002:a63:2685:: with SMTP id m127mr16304426pgm.6.1566147581549;
        Sun, 18 Aug 2019 09:59:41 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:41 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de
Subject: [PATCH v8 05/20] utimes: Clamp the timestamps before update
Date:   Sun, 18 Aug 2019 09:58:02 -0700
Message-Id: <20190818165817.32634-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

POSIX is ambiguous on the behavior of timestamps for
futimens, utimensat and utimes. Whether to return an
error or silently clamp a timestamp beyond the range
supported by the underlying filesystems is not clear.

POSIX.1 section for futimens, utimensat and utimes says:
(http://pubs.opengroup.org/onlinepubs/9699919799/functions/futimens.html)

The file's relevant timestamp shall be set to the greatest
value supported by the file system that is not greater
than the specified time.

If the tv_nsec field of a timespec structure has the special
value UTIME_NOW, the file's relevant timestamp shall be set
to the greatest value supported by the file system that is
not greater than the current time.

[EINVAL]
    A new file timestamp would be a value whose tv_sec
    component is not a value supported by the file system.

The patch chooses to clamp the timestamps according to the
filesystem timestamp ranges and does not return an error.
This is in line with the behavior of utime syscall also
since the POSIX page(http://pubs.opengroup.org/onlinepubs/009695399/functions/utime.html)
for utime does not mention returning an error or clamping like above.

Same for utimes http://pubs.opengroup.org/onlinepubs/009695399/functions/utimes.html

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/utimes.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index 350c9c16ace1..1ba3f7883870 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -36,16 +36,14 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
 		if (times[0].tv_nsec == UTIME_OMIT)
 			newattrs.ia_valid &= ~ATTR_ATIME;
 		else if (times[0].tv_nsec != UTIME_NOW) {
-			newattrs.ia_atime.tv_sec = times[0].tv_sec;
-			newattrs.ia_atime.tv_nsec = times[0].tv_nsec;
+			newattrs.ia_atime = timestamp_truncate(times[0], inode);
 			newattrs.ia_valid |= ATTR_ATIME_SET;
 		}
 
 		if (times[1].tv_nsec == UTIME_OMIT)
 			newattrs.ia_valid &= ~ATTR_MTIME;
 		else if (times[1].tv_nsec != UTIME_NOW) {
-			newattrs.ia_mtime.tv_sec = times[1].tv_sec;
-			newattrs.ia_mtime.tv_nsec = times[1].tv_nsec;
+			newattrs.ia_mtime = timestamp_truncate(times[1], inode);
 			newattrs.ia_valid |= ATTR_MTIME_SET;
 		}
 		/*
-- 
2.17.1

