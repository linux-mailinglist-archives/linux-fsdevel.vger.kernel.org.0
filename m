Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DA810CC56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 17:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfK1P7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:59:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31235 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726835AbfK1P7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++SFQmyMsWq4exmbdoSpQ2cr72U0QKtKCLX6290nr5k=;
        b=SCOQkmKti1yqzW9VzRLqKLDzaHBYHQmui4g1ff3uAlD7+T+ZnCHFaOynTVcS8w7sLcMt7U
        nY+nlFt+lK8lMn75AilAN8kZd3GjH1afbizYHDZgUoULzR9BPF2k/L0A+UgS6CP5Qtrg3M
        n4t5aRyO/ButMbv7I+9FWnAloLqwjuA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-tZeNVJVOPcOQ4X-6stlOwA-1; Thu, 28 Nov 2019 10:59:51 -0500
Received: by mail-wr1-f72.google.com with SMTP id k15so13976866wrp.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WV43MHYixZY7eKNI8jC3xjsYFEcLSUPr+KYHrksoiEI=;
        b=FuzLXfFVlt5rX5YZuPnKw/ZqDEkPuYsaYCdcXWRcwqtqqAdpmsS/jyBWo6ycSXfy3R
         NiFd1IzCJjt7yZvpM9MbOxK/Vi+NeF1j8uyenzNxhsT6FVARFAwwnbtnZuKxKPjv74yR
         5fvR4AMSv45l6f3rfs2S/7gWMbALNVqO74su9O3HwJVyuoWasoFBQXdtQFaD+tC/N0ZT
         xpNtHHjrILzwov1a3n/LaRpXcCoOsRR9UAW/BENKPBAkq5gQY5N8I3Va+UsKXoQBoICc
         76RPcDo3MJ3nrsICT3rN3crulJHpva9bOwPygcsY3a0M41trg1JFdMkZknSh0LKVaTn8
         IGsg==
X-Gm-Message-State: APjAAAWmXMAjl/5t3majy+xTcMbWUgUE8ImzuEn4hgZheEuX0iSIUEmC
        yW7tBG/UCa35TxTki/8R/ei0qg29Y3MjZRVcp/g3ZQ2dt034gYVL6okefXQmf+LKdJp7DaAcjV+
        YxpCIAr3cmxmIvsPIBSg/wMHcTQ==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr12177102wrn.270.1574956790350;
        Thu, 28 Nov 2019 07:59:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqwp5bvhWAOaiRuMR96ArIY/Y981BLL4CkQKEnXAsc167f7gqMcg3rP2HUwxNCAGZc8eO4RAaA==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr12177091wrn.270.1574956790118;
        Thu, 28 Nov 2019 07:59:50 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:49 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/12] utimensat: AT_EMPTY_PATH support
Date:   Thu, 28 Nov 2019 16:59:34 +0100
Message-Id: <20191128155940.17530-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
References: <20191128155940.17530-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: tZeNVJVOPcOQ4X-6stlOwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This makes it possible to use utimensat on an O_PATH file (including
symlinks).

It supersedes the nonstandard utimensat(fd, NULL, ...) form.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/utimes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index 1ba3f7883870..c07cb0dddbb6 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -95,13 +95,13 @@ long do_utimes(int dfd, const char __user *filename, st=
ruct timespec64 *times,
 =09=09goto out;
 =09}
=20
-=09if (flags & ~AT_SYMLINK_NOFOLLOW)
+=09if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
 =09=09goto out;
=20
 =09if (filename =3D=3D NULL && dfd !=3D AT_FDCWD) {
 =09=09struct fd f;
=20
-=09=09if (flags & AT_SYMLINK_NOFOLLOW)
+=09=09if (flags)
 =09=09=09goto out;
=20
 =09=09f =3D fdget(dfd);
@@ -117,6 +117,8 @@ long do_utimes(int dfd, const char __user *filename, st=
ruct timespec64 *times,
=20
 =09=09if (!(flags & AT_SYMLINK_NOFOLLOW))
 =09=09=09lookup_flags |=3D LOOKUP_FOLLOW;
+=09=09if (flags & AT_EMPTY_PATH)
+=09=09=09lookup_flags |=3D LOOKUP_EMPTY;
 retry:
 =09=09error =3D user_path_at(dfd, filename, lookup_flags, &path);
 =09=09if (error)
--=20
2.21.0

