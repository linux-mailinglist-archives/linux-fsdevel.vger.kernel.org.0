Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 205EF10CC5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 17:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfK1QAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 11:00:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53117 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726925AbfK1QAB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y39lZsVZHuhPyWXb740EF8gnxzvNlaCwgKDc+KonpnM=;
        b=WZIhnztmqUO3Cvo4/nkmzDvfk4d3Tj47HNeHhBpzjervLzqSa87lAUhNKUr9uohCStR6rh
        ZV/+yZzRd8RhUR8zjgjnM/cp2WaTjPWvF1oBW815MK+dtjLOTr/Yvj2akD5eevsjivd5nE
        JVDBJCB8F9KZ7KBBx74fHHyzTVm7ONU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-Dn14S4JbOn-KIXLPcylT0A-1; Thu, 28 Nov 2019 10:59:56 -0500
Received: by mail-wr1-f70.google.com with SMTP id e3so13998242wrs.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ik0ZUtk1c8r6nX2SEPD8HgOLKaGSa5p4WfaTbeuYH3g=;
        b=CDVDQhjUnF/dkRCjHK2c3MS1WQQ71WrKhXXZSbDzJm58/MyKgeICTSMIdn4l1sCfdE
         oYs88Sh3ucfOI49+G4WXLXsJhBYujS0P2IyyhUO5P1aPXzHemUbwbLgmuhH+ZYF5j4ll
         o8F8uGA/4dB4Vc0NqNg+Kn6UFFEIFRWGTuRM0EAwaXUtWYqe6JqwF+extUfVHh6pix18
         kVQi/0zKkO1N+wL8l7nU3K5VRymqvIMcUvSnaUnZ01Smzb8eBwzvVf+tL4zfk/Ce2m6s
         jLc4dcC/qK6EVL8Zrzqm2tmvyL7j2yCcOtOdBqWKBqwxtvpOMdCuU+lFnYhftEggRHxa
         gErA==
X-Gm-Message-State: APjAAAUElagIN0FlDzxa5h+2+fW/KcyurCp1lEcD8bQdLd3P0yYyUMM6
        5CT8BwocQ8/5KnJDvhkug2jHjdgBCYdLRb1c4OaTN0KOaK6SnrjFXuS3wo6zNs1yskWR9jhWXNh
        6EJ0uqPa3kLmucYsLtHBgLMOG9Q==
X-Received: by 2002:a7b:c34a:: with SMTP id l10mr10713127wmj.66.1574956795122;
        Thu, 28 Nov 2019 07:59:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHQIEsj+TNUvhi4cSh1njF1NPbOENAgBMjHq1jUjHHNMvW4ZlC9nmXZP9aFRlxsPn7O0VvHw==
X-Received: by 2002:a7b:c34a:: with SMTP id l10mr10713116wmj.66.1574956794963;
        Thu, 28 Nov 2019 07:59:54 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:54 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/12] vfs: don't parse forbidden flags
Date:   Thu, 28 Nov 2019 16:59:38 +0100
Message-Id: <20191128155940.17530-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
References: <20191128155940.17530-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: Dn14S4JbOn-KIXLPcylT0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes little sense to keep this blacklist synced with what mount(8) parses
and what it doesn't.  E.g. it has various forms of "*atime" options, but
not "atime"...

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 7c4216156950..394a05bc03d5 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -55,29 +55,6 @@ static const struct constant_table common_clear_sb_flag[=
] =3D {
 =09{ "silent",=09SB_SILENT },
 };
=20
-static const char *const forbidden_sb_flag[] =3D {
-=09"bind",
-=09"dev",
-=09"exec",
-=09"move",
-=09"noatime",
-=09"nodev",
-=09"nodiratime",
-=09"noexec",
-=09"norelatime",
-=09"nostrictatime",
-=09"nosuid",
-=09"private",
-=09"rec",
-=09"relatime",
-=09"remount",
-=09"shared",
-=09"slave",
-=09"strictatime",
-=09"suid",
-=09"unbindable",
-};
-
 /*
  * Check for a common mount option that manipulates s_flags.
  */
@@ -85,11 +62,6 @@ static int vfs_parse_sb_flag(struct fs_context *fc, stru=
ct fs_parameter *param)
 {
 =09const char *key =3D param->key;
 =09unsigned int set, clear;
-=09unsigned int i;
-
-=09for (i =3D 0; i < ARRAY_SIZE(forbidden_sb_flag); i++)
-=09=09if (strcmp(key, forbidden_sb_flag[i]) =3D=3D 0)
-=09=09=09return -EINVAL;
=20
 =09set =3D lookup_constant(common_set_sb_flag, key, 0);
 =09clear =3D lookup_constant(common_clear_sb_flag, key, 0);
--=20
2.21.0

