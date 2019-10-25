Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258B2E49EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 13:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439236AbfJYL30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 07:29:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20887 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436520AbfJYL3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I33B+0F6drNe2DO1ImWZrj95FAKHCL4hyPcaly3kasA=;
        b=RjHJgVdeoZqBNgfJFU0FQcr/g3cNGFS3xEn95OYh1qd4ToizDJYfKTLE/B2DCqLzNutVKR
        74bVg0KLyYikFKblm18BumWhFHM1RBicaT/QGJrVDU0TAldDujIVWU0vW0Xc5YvzZwp4dA
        ZhIvaRi4yIrCARwH/8Ts0+hozfe3U7g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-ShbkPrLyO2y6cfVYf5uNbA-1; Fri, 25 Oct 2019 07:29:23 -0400
Received: by mail-wm1-f69.google.com with SMTP id f2so579390wmf.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 04:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8l72uHGzG6m6K3/bpmVJ/Qpjsjtmq+Lqod9QQYQlTc=;
        b=WC7ei+P6F7zx7Lppj5VmuKnSaRQL37aoDj+gCDFqcUlbioFG/lp0yghVA2sHwuST02
         rE7j8pH5lnxEWmmWIfhb/u/vr2jRbkEsK7+fAimBJGDavyVp63L1u7lD0gb0JRsfqSQD
         +tVObiflhXbDOlFrZPd3pKf/71QHPLGZXmiAPhl87+UdSx+Jg/xBCojk9gAXbmbE+9VD
         GCqIAZhhPG1CjKMd4aHVr72df6H99IVg8sFNF3JhthYv6H6R7W4CGySPkxzNGjWCS1Ih
         MNhD+EcZS/a/VROY6iG+8CUPDNIYBeMKZSMo4fyzu/JaJQy3taVNMIhnvz5xhLL3GSyQ
         jBMQ==
X-Gm-Message-State: APjAAAXTqRT+KqLFKIo1VlNb2p07UFJBPQthYadx5CnrO8ZXqT+jPqFb
        /2NeTE/dEjYIr4/vKJTPV+3w2gYl9JOw1WaFUJD5MlxdhAUrZo1tBNYiSYRZVSWTGPMAZiehYG7
        nlJUf69poktISHeI5v9az5QjREQ==
X-Received: by 2002:a5d:6b0e:: with SMTP id v14mr2525706wrw.280.1572002961876;
        Fri, 25 Oct 2019 04:29:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPpQGXTNJrxLkgVezHj1T1jGuquL8GQd5mEOwUp11MWfS05ZJe9b8tNYouTGJhnrGVK8HvrQ==
X-Received: by 2002:a5d:6b0e:: with SMTP id v14mr2525688wrw.280.1572002961667;
        Fri, 25 Oct 2019 04:29:21 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:20 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] ovl: document permission model
Date:   Fri, 25 Oct 2019 13:29:13 +0200
Message-Id: <20191025112917.22518-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
References: <20191025112917.22518-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: ShbkPrLyO2y6cfVYf5uNbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add missing piece of documentation regarding how permissions are checked in
overlayfs.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/overlayfs.txt | 44 +++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesy=
stems/overlayfs.txt
index 845d689e0fd7..674fc8b1e420 100644
--- a/Documentation/filesystems/overlayfs.txt
+++ b/Documentation/filesystems/overlayfs.txt
@@ -246,6 +246,50 @@ overlay filesystem (though an operation on the name of=
 the file such as
 rename or unlink will of course be noticed and handled).
=20
=20
+Permission model
+----------------
+
+Permission checking in the overlay filesystem follows these principles:
+
+ 1) permission check SHOULD return the same result before and after copy u=
p
+
+ 2) task creating the overlay mount MUST NOT gain additional privileges
+
+ 3) non-mounting task MAY gain additional privileges through the overlay,
+ compared to direct access on underlying lower or upper filesystems
+
+This is achieved by performing two permission checks on each access
+
+ a) check if current task is allowed access based on local DAC (owner,
+    group, mode and posix acl), as well as MAC checks
+
+ b) check if mounting task would be allowed real operation on lower or
+    upper layer based on underlying filesystem permissions, again includin=
g
+    MAC checks
+
+Check (a) ensures consistency (1) since owner, group, mode and posix acls
+are copied up.  On the other hand it can result in server enforced
+permissions (used by NFS, for example) being ignored (3).
+
+Check (b) ensures that no task gains permissions to underlying layers that
+the mounting task does not have (2).  This also means that it is possible
+to create setups where the consistency rule (1) does not hold; normally,
+however, the mounting task will have sufficient privileges to perform all
+operations.
+
+Another way to demonstrate this model is drawing parallels between
+
+  mount -t overlay overlay -olowerdir=3D/lower,upperdir=3D/upper,... /merg=
ed
+
+and
+
+  cp -a /lower /upper
+  mount --bind /upper /merged
+
+The resulting access permissions should be the same.  The difference is in
+the time of copy (on-demand vs. up-front).
+
+
 Multiple lower layers
 ---------------------
=20
--=20
2.21.0

