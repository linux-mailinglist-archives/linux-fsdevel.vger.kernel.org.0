Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3494310CC5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 17:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfK1QAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 11:00:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33366 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726858AbfK1QAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=urj6BsNEctMMzgxvFwi+FtsFZfU1h6uJQgdMA5TETx4=;
        b=AaNAmGYzs9qHLrmxEBMTArbhG3H2XDA1U1MChEfZEx7oXZK4ehI6U5nExZw/EFg4FRZu7Z
        Jl5SNdb0hXsdsTDx2JKLyBcYyYKNJTIgikaAn69dO9TA6klc8lwBq3EsyubjYfxEM4P/Zi
        L0Lf+NA75KLzRamWRIeKTUSMmsFpU5c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-5GGJ3FVMOU-dlin_1-9zfw-1; Thu, 28 Nov 2019 10:59:58 -0500
Received: by mail-wr1-f70.google.com with SMTP id q6so14030253wrv.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDRPGIuZArrnDQtF7Sm8M5stZsvFzV8+7+mvKWGeK6Y=;
        b=LTjNupy1QFHNBgUDzJrHadaVLpkLvEIIWxpucXZhebv6nHsQN4x9LEWF8p9U1/vXXo
         Q170nfKY//Q9OjJIRZW//iHlkhHVeE8QgDL77rbTCATNCX+dxaTQhAKSIGMJ9h5j0uP+
         tE+kfqOVEzZjoLE5mteuh2ECJ/P5yi79Y64pVH4V7w5scYfi9YahemAAsPE6LeXXxRf/
         5Q0b1rJ7Qq62Lvu76l8L2qlU+XAOl9kCjcqk3tyj2fqftipeQwpKCqlDi8VOX5hFS5yG
         eWps40uoAapUodIcSAInYc1C/rI/klmaRODW6JkBKx0PVXELZXF3SHyefcHn8MzWGzmj
         zqbw==
X-Gm-Message-State: APjAAAWz/0DZXJY+Mg3r5lGPriwdQaUVtjOEZI3iqtwD818Tvrp8yiuE
        C1GKVXNGbk5BcBETLSVFJZjtHdbdRZC4pB0d/C9x3wuwiHeQLY8BqQ9DJSaRtCkfa2Z5aacg0Tz
        83CtD7lutVo95GOpGVy0kcOZqVw==
X-Received: by 2002:a05:600c:2113:: with SMTP id u19mr1994985wml.88.1574956797418;
        Thu, 28 Nov 2019 07:59:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXZjkbtQIB36xZremjJphWCxmwWuFtydsrALi/pHuJ08RrgQCnqEz593F8+uAAXIZaMpBXBQ==
X-Received: by 2002:a05:600c:2113:: with SMTP id u19mr1994966wml.88.1574956797219;
        Thu, 28 Nov 2019 07:59:57 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:56 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/12] vfs: don't parse "silent" option
Date:   Thu, 28 Nov 2019 16:59:40 +0100
Message-Id: <20191128155940.17530-13-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
References: <20191128155940.17530-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 5GGJ3FVMOU-dlin_1-9zfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While this is a standard option as documented in mount(8), it is ignored by
most filesystems.  So reject, unless filesystem explicitly wants to handle
it.

The exception is unconverted filesystems, where it is unknown if the
filesystem handles this or not.

Any implementation, such as mount(8), that needs to parse this option
without failing can simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 738f59b6c06a..b37ce07ee230 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -51,7 +51,6 @@ static const struct constant_table common_clear_sb_flag[]=
 =3D {
 =09{ "nolazytime",=09SB_LAZYTIME },
 =09{ "nomand",=09SB_MANDLOCK },
 =09{ "rw",=09=09SB_RDONLY },
-=09{ "silent",=09SB_SILENT },
 };
=20
 /*
@@ -530,6 +529,15 @@ static int legacy_parse_param(struct fs_context *fc, s=
truct fs_parameter *param)
 =09unsigned int size =3D ctx->data_size;
 =09size_t len =3D 0;
=20
+=09if (strcmp(param->key, "silent") =3D=3D 0) {
+=09=09if (param->type !=3D fs_value_is_flag)
+=09=09=09return invalf(fc, "%s: Unexpected value for '%s'",
+=09=09=09=09      fc->fs_type->name, param->key);
+
+=09=09fc->sb_flags |=3D SB_SILENT;
+=09=09return 0;
+=09}
+
 =09if (strcmp(param->key, "source") =3D=3D 0) {
 =09=09if (param->type !=3D fs_value_is_string)
 =09=09=09return invalf(fc, "VFS: Legacy: Non-string source");
--=20
2.21.0

