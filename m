Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C10DA10CC57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 17:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfK1P74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:59:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28446 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726712AbfK1P7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YgNx2QlaW/nPKw0a9jvrS7+oX5fUKLAjBptvibbWb3E=;
        b=WX8cGlyHIlBfdwtKHzbXFx6spabopGD4Y2RfG4+2t3flLD4KrzU7rpLK3CYytWlDoCwypE
        wx2YQ9HAXGfDlQRCr1vIoBloLJACTeB6XIRmVzxo4+ZsqqQd47fSCqr2YfnBLwP/h3SV/l
        +/xZa9MqvNj2LgGHICmF6Jy52S0AaPA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-Wz3W57ORNE-AMGqsMMMd_w-1; Thu, 28 Nov 2019 10:59:47 -0500
Received: by mail-wr1-f72.google.com with SMTP id l20so4220078wrc.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ksbYxCBjZpn48B7inJ6BGWvn4QhG0WnW3THy3fEooIE=;
        b=Nvevd+0rjtbUNnCPBoIkPo7I4SBzvkGzVXSJ9zkyRCgS/4jRiG91K1U7kBeHuYw4gq
         OKBEd/oiegRbVy8RILja+lvahEtfCVmmcppn+HBkMGrxhSXb1IvOa67tYbrCVmVFM8C4
         qhmqjqV+SXqLBeFydIO/OSdQcBn+Md6LnYcddK9YlwwL1lLStsBjfV4R41kIBe0SyS6E
         t43nsfpuSJqEFF4eA1Fpz8qmFNrjlmLT4jZITClHCQv9jVW7slTSprbza/PSGjQsr4GC
         LlQMsy/5iB+XCJ4HaFTOPsl5xUQbM7T0BBGevQNYU0K1HydOz3Kbx3v5aX2SNWQryMy0
         qqkg==
X-Gm-Message-State: APjAAAWVGwhWJJjM0cBrpBIwn6Yj2qsblTwV8UUXNzEkqw7sljzE1DYB
        PunhU/VXe7IkrVi4jkDpU93+lNlp/RtCRfc4U8ALCx606AdOqOn7oHpPBNMOuPralvKXwxIga/M
        v3lkeRGWCJ+fpr58dqIx8vEvAOA==
X-Received: by 2002:adf:8297:: with SMTP id 23mr3217893wrc.379.1574956786670;
        Thu, 28 Nov 2019 07:59:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbftcMeSmUBYfgr5BqYQGaoMoGlSEyP5kOfnqs1J0+gPrussxlInpDoGMQ0BxEQQI1OiedqA==
X-Received: by 2002:adf:8297:: with SMTP id 23mr3217876wrc.379.1574956786487;
        Thu, 28 Nov 2019 07:59:46 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:45 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/12] vfs: verify param type in vfs_parse_sb_flag()
Date:   Thu, 28 Nov 2019 16:59:31 +0100
Message-Id: <20191128155940.17530-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
References: <20191128155940.17530-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: Wz3W57ORNE-AMGqsMMMd_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vfs_parse_sb_flag() accepted any kind of param with a matching key, not
just a flag.  This is wrong, only allow flag type and return -EINVAL
otherwise.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 138b5b4d621d..66fd7d753e91 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -81,30 +81,29 @@ static const char *const forbidden_sb_flag[] =3D {
 /*
  * Check for a common mount option that manipulates s_flags.
  */
-static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
+static int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter *p=
aram)
 {
-=09unsigned int token;
+=09const char *key =3D param->key;
+=09unsigned int set, clear;
 =09unsigned int i;
=20
 =09for (i =3D 0; i < ARRAY_SIZE(forbidden_sb_flag); i++)
 =09=09if (strcmp(key, forbidden_sb_flag[i]) =3D=3D 0)
 =09=09=09return -EINVAL;
=20
-=09token =3D lookup_constant(common_set_sb_flag, key, 0);
-=09if (token) {
-=09=09fc->sb_flags |=3D token;
-=09=09fc->sb_flags_mask |=3D token;
-=09=09return 0;
-=09}
+=09set =3D lookup_constant(common_set_sb_flag, key, 0);
+=09clear =3D lookup_constant(common_clear_sb_flag, key, 0);
+=09if (!set && !clear)
+=09=09return -ENOPARAM;
=20
-=09token =3D lookup_constant(common_clear_sb_flag, key, 0);
-=09if (token) {
-=09=09fc->sb_flags &=3D ~token;
-=09=09fc->sb_flags_mask |=3D token;
-=09=09return 0;
-=09}
+=09if (param->type !=3D fs_value_is_flag)
+=09=09return invalf(fc, "%s: Unexpected value for '%s'",
+=09=09=09      fc->fs_type->name, param->key);
=20
-=09return -ENOPARAM;
+=09fc->sb_flags |=3D set;
+=09fc->sb_flags &=3D ~clear;
+=09fc->sb_flags_mask |=3D set | clear;
+=09return 0;
 }
=20
 /**
@@ -130,7 +129,7 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs=
_parameter *param)
 =09if (!param->key)
 =09=09return invalf(fc, "Unnamed parameter\n");
=20
-=09ret =3D vfs_parse_sb_flag(fc, param->key);
+=09ret =3D vfs_parse_sb_flag(fc, param);
 =09if (ret !=3D -ENOPARAM)
 =09=09return ret;
=20
--=20
2.21.0

