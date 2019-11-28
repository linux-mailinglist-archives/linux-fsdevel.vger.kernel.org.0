Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3491D10CC5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 17:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfK1P76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:59:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44297 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726712AbfK1P76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ck3CGcsbIlV1eLwTtb+TK98Otth3loJAT1/eFW2z+l8=;
        b=aq2omIAbxndSlqtOIS5pkY5VOPbCqvP0sUU5U0yxOjSA0nhv7/hcWwmz/KZRhUjPYNtGxL
        s2w5RuWD1ts17YA5f56edM9zoZk4/iKyK1mYog4NfCK0hKZMYmfBUX5wP4TDv6EiohHC9e
        wk3AFm97AgOBblG7fC/Hr3emIvq8idU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30--q56V2ORPsalrDzBMYv67w-1; Thu, 28 Nov 2019 10:59:55 -0500
Received: by mail-wr1-f72.google.com with SMTP id q12so14088426wrr.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2zb08hFIl2dEvNnYnKVL3DjSRjWIXjJoqltqFs5pNp4=;
        b=BcNrLzI0316BjVM+SFkVjtvp3ZD1YSjNQZEoK46kBA2C6n3brknZXVLnOkv0gqMIsj
         sFy8k0XEgIIeDWezI3O1Vbpm7p7lC+88R5xvL3IdIZL7Idj1YG5ZFi2PI1q7YG+0zXK0
         3a2mxuygYJgMazxl4ja4fnsyxpdR0VoNgKTS3RrglBVhEOuw5p1kfpjVtbaDo0e+A1/u
         V2SDj+1MS1rJUTsxeJZbj1ats1fixOE0wRK0ZkafXDSHBCvS7b6C4dDbIxp3z9srVev9
         M0f902eZ16xUcmWWvEEIIKrXn0yMsWjXjwN2fit6NgURzYJfVJWfjqPJqys3HfJBuvCt
         mywg==
X-Gm-Message-State: APjAAAU1QzseR6eSf/cdzC0dyT9ZRf5I0KKVKw/jcev1fTcdjwITmAzt
        sU0hvHhEhcOvw9gFWQp7WvjkUl+CW7qEDCRJjN6uhzEt2zGDJy2sDpHOGCGWVWJ3mb/GPT7cRUa
        ORhMw9RL3fLyTyl+aQNtEyuZBHw==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr9843875wmj.32.1574956793893;
        Thu, 28 Nov 2019 07:59:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfjPn0TXdy3nlaNUSJmNOOLqdDmN4Tipus585eAFxYi4o+vVXL14/kuCcAFuYAwwXrzmpZDg==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr9843857wmj.32.1574956793647;
        Thu, 28 Nov 2019 07:59:53 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:52 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/12] fs_parser: "string" with missing value is a "flag"
Date:   Thu, 28 Nov 2019 16:59:37 +0100
Message-Id: <20191128155940.17530-10-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
References: <20191128155940.17530-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: -q56V2ORPsalrDzBMYv67w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's no such thing as a NULL string value, the fsconfig(2) syscall
rejects that outright.

So get rid of that concept from the implementation.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c           | 2 +-
 fs/fs_parser.c            | 9 ++-------
 include/linux/fs_parser.h | 1 -
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 66fd7d753e91..7c4216156950 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -174,7 +174,7 @@ int vfs_parse_fs_string(struct fs_context *fc, const ch=
ar *key,
=20
 =09struct fs_parameter param =3D {
 =09=09.key=09=3D key,
-=09=09.type=09=3D fs_value_is_string,
+=09=09.type=09=3D v_size ? fs_value_is_string : fs_value_is_flag,
 =09=09.size=09=3D v_size,
 =09};
=20
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 5d8833d71b37..70f95a71f5aa 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -85,7 +85,6 @@ int fs_parse(struct fs_context *fc,
 =09const struct fs_parameter_enum *e;
 =09int ret =3D -ENOPARAM, b;
=20
-=09result->has_value =3D !!param->string;
 =09result->negated =3D false;
 =09result->uint_64 =3D 0;
=20
@@ -95,7 +94,7 @@ int fs_parse(struct fs_context *fc,
 =09=09 * "xxx" takes the "no"-form negative - but only if there
 =09=09 * wasn't an value.
 =09=09 */
-=09=09if (result->has_value)
+=09=09if (param->type !=3D fs_value_is_flag)
 =09=09=09goto unknown_parameter;
 =09=09if (param->key[0] !=3D 'n' || param->key[1] !=3D 'o' || !param->key[=
2])
 =09=09=09goto unknown_parameter;
@@ -146,8 +145,7 @@ int fs_parse(struct fs_context *fc,
 =09 */
 =09switch (p->type) {
 =09case fs_param_is_flag:
-=09=09if (param->type !=3D fs_value_is_flag &&
-=09=09    (param->type !=3D fs_value_is_string || result->has_value))
+=09=09if (param->type !=3D fs_value_is_flag)
 =09=09=09return invalf(fc, "%s: Unexpected value for '%s'",
 =09=09=09=09      desc->name, param->key);
 =09=09result->boolean =3D true;
@@ -208,9 +206,6 @@ int fs_parse(struct fs_context *fc,
 =09case fs_param_is_fd: {
 =09=09switch (param->type) {
 =09=09case fs_value_is_string:
-=09=09=09if (!result->has_value)
-=09=09=09=09goto bad_value;
-
 =09=09=09ret =3D kstrtouint(param->string, 0, &result->uint_32);
 =09=09=09break;
 =09=09case fs_value_is_file:
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index dee140db6240..45323203128b 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -72,7 +72,6 @@ struct fs_parameter_description {
  */
 struct fs_parse_result {
 =09bool=09=09=09negated;=09/* T if param was "noxxx" */
-=09bool=09=09=09has_value;=09/* T if value supplied to param */
 =09union {
 =09=09bool=09=09boolean;=09/* For spec_bool */
 =09=09int=09=09int_32;=09=09/* For spec_s32/spec_enum */
--=20
2.21.0

