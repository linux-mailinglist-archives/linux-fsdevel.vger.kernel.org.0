Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6134B7A2B15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 01:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbjIOXte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 19:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbjIOXtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 19:49:11 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3F92102
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 16:49:06 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34f3264a283so9687585ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 16:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1694821745; x=1695426545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nvPDhUzgNQIXp3qVtGCyAzg8tM1jqsHZ+6dyT+APQ8=;
        b=JlfiQBAP0UnqR18KQt+9Lcr0yGdM+/cDsEAjjz7v8c94FaHouFHn3IgErj++ookU9l
         WS+fSHOOqAbsS7nBFfT9lER3CHR4hapApohm7O/TyqMqhciZ5M9zAlFUCl1rUmrZbFbz
         V3ayoQpIZ/KIGJTRY93z/2yrrE4TINB9fZafKOWbLOitXMXTh3jWLZJQ2CeusR/Jjbpc
         T/oYd4lg14gMcMs8laPXah3IVcKyJ08gz6yaZzQviPrOn+th830fKhT3NLC+CNYS3+2Q
         JHaRZF6TorUAjjrobsMRsoOoaB5TKwXoEbyJoRm4JBogr6rILukEfx0ZmyhDVR0kw7nZ
         GxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694821745; x=1695426545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nvPDhUzgNQIXp3qVtGCyAzg8tM1jqsHZ+6dyT+APQ8=;
        b=bhegumr4jsbva27AVmvlLD2sTrJf39HoRUUnecuu1KH64W33Fsfif4pGhTajfo4czh
         p/zU81PU+nsB5gNiCLSyWgGbpAe1D+fNzq8e3efpnLu8BWlN9FCP+amxcTC+wp2RsX5h
         0AKbsTA86AjRqkDcpnTDxOO6LZ+UdnrwZPDT+AK0cd//ffGSlvDbstiJdnCgr1OIHm0b
         dpiEO16RjT78+j90ok0jyakbE8F9P80hNeMSLM9lNwtNd3PPs7OMwU3DA5pb+rRNuo76
         LSordkVggPy5GTmu1rQD2dl36bZhq8Vxx9yMEZV9I+qM4/4DZaAM8incJNEzf2QvdTln
         3gLA==
X-Gm-Message-State: AOJu0YzN9E8opDYPyx9o5jj722FYkFXQdfUWwYOxe9HBNwwWgV71Nyvp
        a98qe9oE8nrEOImXAyDksab9fg==
X-Google-Smtp-Source: AGHT+IGmxvwBoLa2v6vI9aD542A1PQ/073VIBgdMD8PjMgrNzFohh+PPrf7t/AQb3Fh0QmKa7V7R/w==
X-Received: by 2002:a05:6e02:10c1:b0:346:4f37:9ee7 with SMTP id s1-20020a056e0210c100b003464f379ee7mr2873780ilj.13.1694821745675;
        Fri, 15 Sep 2023 16:49:05 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:9478:4be::79:1e])
        by smtp.gmail.com with ESMTPSA id q11-20020a056e02106b00b0034a921bc93asm779036ilj.1.2023.09.15.16.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 16:49:05 -0700 (PDT)
From:   Frederick Lawler <fred@cloudflare.com>
To:     amir73il@gmail.com, mcgrof@kernel.org
Cc:     kdevops@lists.linux.dev, kernel-team@cloudflare.com,
        linux-fsdevel@vger.kernel.org,
        Frederick Lawler <fred@cloudflare.com>
Subject: [RFC PATCH kdevops 2/2] xfs: merge common expunge lists for v6.1.53
Date:   Fri, 15 Sep 2023 18:48:57 -0500
Message-Id: <20230915234857.1613994-3-fred@cloudflare.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915234857.1613994-1-fred@cloudflare.com>
References: <20230915234857.1613994-1-fred@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 .../6.1.53/xfs/unassigned/xfs_crc.txt         |  6 +++
 .../6.1.53/xfs/unassigned/xfs_logdev.txt      | 16 +++++++
 .../6.1.53/xfs/unassigned/xfs_nocrc.txt       |  5 ++
 .../6.1.53/xfs/unassigned/xfs_nocrc_512.txt   |  5 ++
 .../6.1.53/xfs/unassigned/xfs_reflink.txt     |  5 ++
 .../xfs/unassigned/xfs_reflink_1024.txt       | 11 +++++
 .../xfs/unassigned/xfs_reflink_normapbt.txt   | 10 ++++
 .../6.1.53/xfs/unassigned/xfs_rtdev.txt       | 48 +++++++++++++++++++
 8 files changed, 106 insertions(+)
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink.txt
 create mode 100644 workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_normapbt.txt

diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_crc.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_crc.txt
index 51f9ff242061..05c42bab9f3d 100644
--- a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_crc.txt
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_crc.txt
@@ -1 +1,7 @@
 generic/299
+generic/471
+xfs/075
+xfs/270
+xfs/506
+xfs/513
+xfs/557
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_logdev.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_logdev.txt
index db5f60dcf5bf..32d81aa51620 100644
--- a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_logdev.txt
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_logdev.txt
@@ -1,10 +1,26 @@
 generic/042
+generic/054
+generic/055
+generic/081
+generic/108
+generic/204
+generic/223
+generic/361
+generic/459
+generic/471
 generic/704
 generic/730
 generic/731
+shared/298
+xfs/008
 xfs/017
 xfs/045
+xfs/075
+xfs/158
 xfs/160
 xfs/161
+xfs/199
+xfs/270
 xfs/273
+xfs/294
 xfs/438
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc.txt
index 5a4c1ed3368b..5359fe78a91c 100644
--- a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc.txt
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc.txt
@@ -1,2 +1,7 @@
+generic/471
 generic/589 # failure rate is 1/10
+xfs/075
 xfs/195
+xfs/506
+xfs/513
+xfs/557
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc_512.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc_512.txt
index eba91e9ba338..e58ba3291e43 100644
--- a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc_512.txt
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_nocrc_512.txt
@@ -1,7 +1,12 @@
 generic/388 # failure only appears on xunit file no *.bad file
+generic/471
 generic/618
 generic/681
 generic/682
 xfs/071
+xfs/075
 xfs/220
 xfs/295 # failure rate is about 1/30 xfs_logprint: unknown log operation type (0) Bad data in log
+xfs/506
+xfs/513
+xfs/557
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink.txt
new file mode 100644
index 000000000000..cb826775acee
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink.txt
@@ -0,0 +1,5 @@
+generic/175
+generic/297
+generic/298
+generic/471
+xfs/075
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_1024.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_1024.txt
index 4e222f35568a..67172755b9bd 100644
--- a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_1024.txt
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_1024.txt
@@ -1 +1,12 @@
+generic/175
+generic/297
+generic/298
+generic/471
 xfs/014 # failure rate is about 1/20
+xfs/075
+xfs/168
+xfs/179
+xfs/270
+xfs/506
+xfs/513
+xfs/557
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_normapbt.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_normapbt.txt
new file mode 100644
index 000000000000..97eb2ba03d40
--- /dev/null
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_reflink_normapbt.txt
@@ -0,0 +1,10 @@
+generic/175
+generic/297
+generic/298
+generic/471
+xfs/075
+xfs/179
+xfs/270
+xfs/506
+xfs/513
+xfs/557
diff --git a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_rtdev.txt b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_rtdev.txt
index a27042912692..783bf7adfce9 100644
--- a/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_rtdev.txt
+++ b/workflows/fstests/expunges/6.1.53/xfs/unassigned/xfs_rtdev.txt
@@ -1 +1,49 @@
+generic/012
+generic/013
+generic/015
+generic/016
+generic/021
+generic/022
+generic/027
+generic/058
+generic/060
+generic/061
+generic/063
+generic/074
+generic/075
+generic/077
+generic/096
+generic/102
+generic/112
+generic/113
+generic/171
+generic/172
+generic/173
+generic/174
+generic/175
+generic/204
+generic/224
+generic/226
+generic/251
+generic/256
+generic/269
+generic/270
+generic/273
+generic/274
+generic/275
+generic/297
+generic/298
+generic/300
+generic/312
+generic/361
+generic/371
+generic/416
+generic/427
+generic/449
+generic/471
+generic/488
+generic/511
+generic/515
+generic/520
+generic/558
 xfs/002 # xfs_growfs: log growth not supported yet
-- 
2.34.1

