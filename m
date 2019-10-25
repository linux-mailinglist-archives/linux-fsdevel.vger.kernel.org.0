Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A361E49F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439598AbfJYL3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 07:29:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29505 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439519AbfJYL33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWR0FeiNl3309mlO6E0ZvUU8kwY1OBQz216A0AG4Xw4=;
        b=Q6u2zjlgy4VLV48H+12870yZplfNLD6uzROzUQZpqCDNFuBW89zmP4prKJDm/QVqH1LqEs
        7PeGUuY7iUiEgzKwtsAdv5pnCCbeEagNo0/KfePFfVNOIfD+xGnAgfp5u+SnKqtAxonMpm
        gsQCSn/t469CXjFuyjPTLPJsI+zN18E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-SkdqhMS4McmnaZP-9x9p_g-1; Fri, 25 Oct 2019 07:29:24 -0400
Received: by mail-wr1-f69.google.com with SMTP id e14so912659wrm.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 04:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECMzKToI8lUs7uXqHIyGRHyiocaJAiDHNlfvJlo41SA=;
        b=Po31U2fHdfvOeODlQsv+KZuPZQ3o/Pm5fblf+9cg2xX4lttyyCHhS9eP1HdPqffiNh
         Lo0eA0KXOFolHIKQmbBYfmIvWtlI/LXMRAnZWD/SwOaHi+yEQ3ZbFuJEEag8nw+JItMq
         JGEztuAWbMAEAGt3XUh2YuAxYienkvDJ6lg3BxbLET7p21joF0Re9ondeffbMtbIcko1
         nMklSG7dvvHdJFkZW2r83X2rClRDwgVjZ0wyWf9ALas6tMeHyNf+QbjPDDw0jkAGwBAk
         EFhkS9jQmRba+xC4j1fm/pWV55t2pFY3YUi1DMBXqgXq3PX/Bgch0TTVA5ntl4Zm5cTU
         psQw==
X-Gm-Message-State: APjAAAXUely/H+tbPIjp/ZaSS0QN7WROHqSRCSxGmOAaFQ6uCKtl4Zr8
        QKq9zo8qzuXdkuYQOcOQjHtSvf9j3cgBlHkodib2l41DKZgygFoxZczfgF2HfImN7w9sdiHuZBS
        2809CcNzkaPPa0aoppQp5PtQaWg==
X-Received: by 2002:a5d:4945:: with SMTP id r5mr2503168wrs.37.1572002962863;
        Fri, 25 Oct 2019 04:29:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxxZN9Mnc+StD4TaIv7j6jidJ6uc4Izr0imiWOZEmOA/aRp1o/R0zlvUyoK2S2AsyuHVsjk0Q==
X-Received: by 2002:a5d:4945:: with SMTP id r5mr2503154wrs.37.1572002962677;
        Fri, 25 Oct 2019 04:29:22 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:22 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/5] ovl: ignore failure to copy up unknown xattrs
Date:   Fri, 25 Oct 2019 13:29:14 +0200
Message-Id: <20191025112917.22518-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
References: <20191025112917.22518-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: SkdqhMS4McmnaZP-9x9p_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This issue came up with NFSv4 as the lower layer, which generates
"system.nfs4_acl" xattrs (even for plain old unix permissions).  Prior to
this patch this prevented copy-up from succeeding.

The overlayfs permission model mandates that permissions are checked
locally for the task and remotely for the mounter(*).  NFS4 ACLs are not
supported by the Linux kernel currently, hence they cannot be enforced
locally.  Which means it is indifferent whether this attribute is copied or
not.

Generalize this to any xattr that is not used in access checking (i.e. it's
not a POSIX ACL and not in the "security." namespace).

Incidentally, best effort copying of xattrs seems to also be the behavior
of "cp -a", which is what overlayfs tries to mimic.

(*) Documentation/filesystems/overlayfs.txt#Permission model

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b801c6353100..ed6e2d6cf7a1 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -36,6 +36,13 @@ static int ovl_ccup_get(char *buf, const struct kernel_p=
aram *param)
 module_param_call(check_copy_up, ovl_ccup_set, ovl_ccup_get, NULL, 0644);
 MODULE_PARM_DESC(check_copy_up, "Obsolete; does nothing");
=20
+static bool ovl_must_copy_xattr(const char *name)
+{
+=09return !strcmp(name, XATTR_POSIX_ACL_ACCESS) ||
+=09       !strcmp(name, XATTR_POSIX_ACL_DEFAULT) ||
+=09       !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN)=
;
+}
+
 int ovl_copy_xattr(struct dentry *old, struct dentry *new)
 {
 =09ssize_t list_size, size, value_size =3D 0;
@@ -107,8 +114,13 @@ int ovl_copy_xattr(struct dentry *old, struct dentry *=
new)
 =09=09=09continue; /* Discard */
 =09=09}
 =09=09error =3D vfs_setxattr(new, name, value, size, 0);
-=09=09if (error)
-=09=09=09break;
+=09=09if (error) {
+=09=09=09if (error !=3D -EOPNOTSUPP || ovl_must_copy_xattr(name))
+=09=09=09=09break;
+
+=09=09=09/* Ignore failure to copy unknown xattrs */
+=09=09=09error =3D 0;
+=09=09}
 =09}
 =09kfree(value);
 out:
--=20
2.21.0

