Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00ED92A8CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 08:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfEZGLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 02:11:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54804 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfEZGL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 02:11:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so12982499wml.4;
        Sat, 25 May 2019 23:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xzMeQSjk/vpAnsoZTPGclf7QJxi3EL8e26LVdVAwCA0=;
        b=V6hO9Pn3tG6o05o4jaFAQ0zpkPrUpsu5TE+T4CZ/1IvBUrlSLbgxy1G+6GIWzXi/I6
         TgeodHxD/zbZxntaF3uDrUuZZeCAC4N1JfY+Urrr+Ntd8YCOu6H4akUUsSVCEVpPNsec
         yZ+lfn867N7qcRF/4t1jJB3ZxVs3ffYdcXguw/2sFh+abnajfNg6qQ3VkBIvLFlK7gQL
         v2/sfVkNGrfgKu8+eckFVUDmJ/Lut7xvl80PfUYNgtqJpBnWrq0UeUWNXJuPc5c2qilE
         B6avEzGPv5DEmCvApni5ctUXq59SqtRvKAN5CdDgQhqyHVjs9rU2LfuEdmg/6sywTnAm
         I+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xzMeQSjk/vpAnsoZTPGclf7QJxi3EL8e26LVdVAwCA0=;
        b=Gy2Q4HNUbxS98EAbCezluKAdAckJizNi78LV5B1ZWzRq0yK86fdkjyNERb4ISSsBoV
         8w35fTEwmIRd6idfCmjG/C5HvOFkOp3JOCz257ryMGdQ4RFYHkdjkdngtRyeU/kgMlM1
         7D+meenyvELl8X4r63JP15sa12JKQeQBg1nEeORERbAURkSv3J5+YjoEJD2Gg55WiZUc
         o6tiqHopsiYw7rjngsNzA0BJheIoDOpXjJRtoMgqD46KooBHvKxIKfq7AdW0NsXkbh1G
         GfaDi/NMgYEOPQe/pt4Rme1kosLuk7JzPdKaqpok5VMWQOnsbaCXFh7/9DjymRoUjSKE
         2DTw==
X-Gm-Message-State: APjAAAVbYCrqCm8zkZgZClN9CBfK3Tzbkhc+pYfhYLUyf3tYIEPX1dyW
        qQ0daHa6Hhn3Oh1MqEGsXsA=
X-Google-Smtp-Source: APXvYqy+J5jgXwkRr/gZ5c4Cs4Qrvo1uXdv6xXM+Eq0qAqd4SzWgaFxn1XfrZxdTSFpWvSgOMfW92A==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr21521254wmk.114.1558851087039;
        Sat, 25 May 2019 23:11:27 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id a124sm5302943wmh.3.2019.05.25.23.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 23:11:26 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 8/8] vfs: remove redundant checks from generic_remap_checks()
Date:   Sun, 26 May 2019 09:10:59 +0300
Message-Id: <20190526061100.21761-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526061100.21761-1-amir73il@gmail.com>
References: <20190526061100.21761-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The access limit checks on input file range in generic_remap_checks()
are redundant because the input file size is guarantied to be within
limits and pos+len are already checked to be within input file size.

Beyond the fact that the check cannot fail, if it would have failed,
it could return -EFBIG for input file range error. There is no precedent
for that. -EFBIG is returned in syscalls that would change file length.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 mm/filemap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1852fbf08eeb..7e1aa36d57a2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3000,10 +3000,6 @@ int generic_remap_checks(struct file *file_in, loff_t pos_in,
 		return -EINVAL;
 	count = min(count, size_in - (uint64_t)pos_in);
 
-	ret = generic_access_check_limits(file_in, pos_in, &count);
-	if (ret)
-		return ret;
-
 	ret = generic_write_check_limits(file_out, pos_out, &count);
 	if (ret)
 		return ret;
-- 
2.17.1

