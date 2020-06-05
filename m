Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C2E1EFB1F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 16:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgFEOXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 10:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgFEOXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:23:34 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B917C08C5C5
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 07:23:32 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y13so10330341eju.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgY4I2DT6NHuEBJVBWH5xaWHKtAb7Acjuq8xM3DNBZs=;
        b=QTElvvtJbPz7O4l0N2vXVv9mj1TLExtC0raNDMa24L8UfKR1yYUuYHL9CxjaruDrjh
         aefJM28+QoU0J+hH7LcJY9hLj2TeIZpO1d1afTdHbgITtKVt276YnRSIFQtqPC3dyyfI
         ovRyDY8g9W4NZLaLUUq/4fqdIhDWT8EwOvTWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XgY4I2DT6NHuEBJVBWH5xaWHKtAb7Acjuq8xM3DNBZs=;
        b=pPyJwMXKlsg5dkJoUzz1R1QmsCa1BdRI2BLP6Ow9pY8zDBGpQTaIkMiHLvKtxl30c8
         B5aOsrmjjCz2Y8kHS7JjusRD1hFNbgXiBrkLl7ZqWe732iG5qvLeFvlspwN6BQ0Z+kad
         /HWCd+uJcLPMu56hcY6Kv9RdRRFGQbGQZ5bjK9e4VPsLWGSYBfjqlSiPs6mctOdLYyrw
         syZ5IcbLtHhI/SClsdb6gKKPIrSa1OkUQiBjA2A0uMbsxaoFeTmIBnA2ZtzZrAJ5KMdS
         hNKMcJ/pV+d1uSIoMlS17hWWAgUqU+8GzoN4FFvnOubW/UbuLVTciYo5FRw+OmxXV4vG
         8zEQ==
X-Gm-Message-State: AOAM530XghhBNW6C6CkTG0Qm6WLGl9FNnfJN7pMflD0qWMCNJJg8yB6l
        ayvE0T6fPPnbMkCU2LdycqGKa6Vy64g=
X-Google-Smtp-Source: ABdhPJx6dbhFdXcLh9Fw1Irene3+drPlsNF3oWeBEhsMBqDdvPnhWWVIhBS0bvJAttcjyHDwhAkrGQ==
X-Received: by 2002:a17:906:cb97:: with SMTP id mf23mr4356134ejb.468.1591367011198;
        Fri, 05 Jun 2020 07:23:31 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-116-45.cgn.fibianet.dk. [5.186.116.45])
        by smtp.gmail.com with ESMTPSA id qp16sm4421833ejb.64.2020.06.05.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 07:23:30 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend] fs/namei.c: micro-optimize acl_permission_check
Date:   Fri,  5 Jun 2020 16:23:00 +0200
Message-Id: <20200605142300.14591-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just something like open(/usr/include/sys/stat.h) causes five calls of
generic_permission -> acl_permission_check -> in_group_p; if the
compiler first tried /usr/local/include/..., that would be a few
more.

Altogether, on a bog-standard Ubuntu 20.04 install, a workload
consisting of compiling lots of userspace programs (i.e., calling lots
of short-lived programs that all need to get their shared libs mapped
in, and the compilers poking around looking for system headers - lots
of /usr/lib, /usr/bin, /usr/include/ accesses) puts in_group_p around
0.1% according to perf top. With an artificial load such as

  while true ; do find /usr/ -print0 | xargs -0 stat > /dev/null ; done

that jumps to over 0.4%.

System-installed files are almost always 0755 (directories and
binaries) or 0644, so in most cases, we can avoid the binary search
and the cost of pulling the cred->groups array and in_group_p() .text
into the cpu cache.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index d81f73ff1a8b..c6f0c6643db5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -303,7 +303,12 @@ static int acl_permission_check(struct inode *inode, int mask)
 				return error;
 		}
 
-		if (in_group_p(inode->i_gid))
+		/*
+		 * If the "group" and "other" permissions are the same,
+		 * there's no point calling in_group_p() to decide which
+		 * set to use.
+		 */
+		if ((((mode >> 3) ^ mode) & 7) && in_group_p(inode->i_gid))
 			mode >>= 3;
 	}
 
-- 
2.23.0

