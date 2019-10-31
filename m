Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D40FEB7F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 20:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfJaT1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 15:27:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37471 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbfJaT1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 15:27:44 -0400
Received: by mail-io1-f65.google.com with SMTP id 1so8076552iou.4;
        Thu, 31 Oct 2019 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=B4jV3EnBBq5/1iaXnrQAt0NG52PBIas0sGtSMu6rBD8=;
        b=mtDewwg/TLCLm7Hsns9t2qp9MDlqvS//iyppO5d6nWi63hFv2VV6CNhIMMf/jEIUoE
         BooiTrj6VAdHlBSU/zrqShQRY5WDBHZdXfAkBMgFlipomCJb3n2ME5P8h2otxKr76mJa
         EcHByfjllmmJtLjX9A9+mc+9pRjPvWhPXR81fUy1PrhnQKg2mBBMO8bvuWkNsZSCAza/
         rYXDOU9MtKzpmKnCzD79IeCZxtB1KG3vpirsGX5EmeRBhJ5im8dHVxTNSjmiBvx3Ggk/
         lyMtCGHXzCyMLVcn1L1+bjFQdvmP+4652pMoRVw+9mhHrZJ6De1jIGNkLkO0/7xwsG1K
         XheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=B4jV3EnBBq5/1iaXnrQAt0NG52PBIas0sGtSMu6rBD8=;
        b=UfS/AxsrE+QBd4s7rWSIvnUnWVGOH7sdRwYgoALToJ6+GZhWwQ5kX6sCbzpbPlGvuH
         Fh/4pqoH5NBNUDDlzOazC1RLAN+AatvpbqD8o/99OG0EZ5kCc3l4zyks3OIqaE7EW49c
         yXMzy+QAqniO/0zvpEUob0S6+jyctpTFZ0R0vo5JyJFIqFjmue2gN19MZiJUbjchtT6e
         Fr2NdTEjhoE8JNhPQsm1tHP1g+BZKHSscjDHlx+FQrpVwFbbVSfHuyGuLcQJWqGkOkC+
         Qxxz2ZntjFrKRz6wQY5IzCy8iq4kU6ekqIFqxsFxtg52ocwmNB7mhKmscgZhLGGePnJM
         zemg==
X-Gm-Message-State: APjAAAUDyBrkYDxW9Lzlh5gIMfrLW++IaOX1IzGd8n5HreJUmiAgzrTl
        bqZmHLfPBrLgKC5RZUyUjngdInqsHrbahjpdEeLzdDD8
X-Google-Smtp-Source: APXvYqzpbGK9QDML4i9u/rZBSCaOHKfFsRoyUmn5YwTsiwj0GSCptKh6YEPsaOEgWkIsBSE/YGFsqAhJaM52OuTSOSo=
X-Received: by 2002:a5d:9f02:: with SMTP id q2mr6698394iot.3.1572550062331;
 Thu, 31 Oct 2019 12:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191031035514.20871-1-lsahlber@redhat.com>
In-Reply-To: <20191031035514.20871-1-lsahlber@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 31 Oct 2019 14:27:31 -0500
Message-ID: <CAH2r5mvLOs2dWVoCUzCubCbHgvEH4msAjeqCmnriCVxH-g2Phw@mail.gmail.com>
Subject: Fwd: [PATCH] cifs: don't use 'pre:' for MODULE_SOFTDEP
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I noticed that btrfs and ext4 have the same bug

modprobe btrfs
modprobe -r btrfs

returns
"modprobe: FATAL: Module crc32c_intel is in use."

(although the module is actually unloaded despite the 'FATAL' error)

Should fs modules not use MODULE_SOFTDEP as Ronnie's patch suggests?
---------- Forwarded message ---------
From: Ronnie Sahlberg <lsahlber@redhat.com>
Date: Wed, Oct 30, 2019 at 10:59 PM
Subject: [PATCH] cifs: don't use 'pre:' for MODULE_SOFTDEP
To: linux-cifs <linux-cifs@vger.kernel.org>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>


It can cause
to fail with
modprobe: FATAL: Module <module> is builtin.

RHBZ: 1767094

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/cifsfs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index f8e201c45ccb..a578699ce63c 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1677,17 +1677,17 @@ MODULE_DESCRIPTION
        ("VFS to access SMB3 servers e.g. Samba, Macs, Azure and Windows (and "
        "also older servers complying with the SNIA CIFS Specification)");
 MODULE_VERSION(CIFS_VERSION);
-MODULE_SOFTDEP("pre: ecb");
-MODULE_SOFTDEP("pre: hmac");
-MODULE_SOFTDEP("pre: md4");
-MODULE_SOFTDEP("pre: md5");
-MODULE_SOFTDEP("pre: nls");
-MODULE_SOFTDEP("pre: aes");
-MODULE_SOFTDEP("pre: cmac");
-MODULE_SOFTDEP("pre: sha256");
-MODULE_SOFTDEP("pre: sha512");
-MODULE_SOFTDEP("pre: aead2");
-MODULE_SOFTDEP("pre: ccm");
-MODULE_SOFTDEP("pre: gcm");
+MODULE_SOFTDEP("ecb");
+MODULE_SOFTDEP("hmac");
+MODULE_SOFTDEP("md4");
+MODULE_SOFTDEP("md5");
+MODULE_SOFTDEP("nls");
+MODULE_SOFTDEP("aes");
+MODULE_SOFTDEP("cmac");
+MODULE_SOFTDEP("sha256");
+MODULE_SOFTDEP("sha512");
+MODULE_SOFTDEP("aead2");
+MODULE_SOFTDEP("ccm");
+MODULE_SOFTDEP("gcm");
 module_init(init_cifs)
 module_exit(exit_cifs)
--
2.13.6



-- 
Thanks,

Steve
