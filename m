Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 247BF10CC4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 16:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfK1P7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:59:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51524 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726648AbfK1P7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p9Wylpk2ZhwaY6AHfisQs9UzMFrxtqG9nnsoA/OlXV8=;
        b=gp4fkfbH1dN8P1neLt2EM9feSvPOop2vspRP791DtjtI9Nx0IdbwgkjIVtilqY7WEkVVN9
        pKn2OcdUJnFwB/xH5O9Nv7zDZELIogTZYXx5B4M3uIziac2DBRzIGVXq6V3JlIDbUUQzRh
        miRkGOTHrpsRWkRK4ZsxhrOzfZRXMO4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-tehmmQLwMhWpaQ2wUs0XwA-1; Thu, 28 Nov 2019 10:59:45 -0500
Received: by mail-wr1-f72.google.com with SMTP id q12so14088192wrr.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUMGD7+UDhmSgUYjf0umsMgw2+YkPVZwq146yGXQ1AQ=;
        b=S7OK6twXoGcV3b0mQgPTcepLJMwWKimhL3bJvuU0r/TOwtF2/paVlO8RBGe8Ry3p6q
         U74UznKyUrI3y7kiSDjwcy0fsV7FrG/dqRu3rIjx92V4IsxCU4rsSlisSvkQBhpknIPA
         xb/a7xOclhmFv99RHXT0nMrnFj/ynFhXtDLIYWw/lxVGRnmQtsMLD3AMv8U+zvJsebwt
         kuvLeshpe7mkbRv3OPuKE8qS+SgFJMPNE0H6b8JJ9LplECtIvbGefo4RGBmAu2YBsQNi
         RjXLtop/50JU8rK29Oihuub2YpGnJkjcnMEnrDUup2yQdUkY4tO4qk0dORkLxwoaVYhM
         ZIvg==
X-Gm-Message-State: APjAAAXniSQEcIgNgS6ZH4Kf12+UCkbDhRevhL3k3AsiTSSK+pn7cJ4K
        111+VqiYh8OYeomSqxifs4F/WWWjaQMmMfrccAl4WE6VdlFYRItThin45ppej/ZHEjnBucFUfZa
        OSADv64ZaSNAyhol/3S8J64qI8A==
X-Received: by 2002:a05:6000:103:: with SMTP id o3mr17474173wrx.80.1574956784379;
        Thu, 28 Nov 2019 07:59:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJu7/0r2fDEvCZ7kcUxvde1QwqRokBI6zhEggF6ATPtanqmxQ9P7SyO0YaGm0IIgxMIXlqBg==
X-Received: by 2002:a05:6000:103:: with SMTP id o3mr17474151wrx.80.1574956784154;
        Thu, 28 Nov 2019 07:59:44 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:43 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Avi Kivity <avi@scylladb.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 01/12] aio: fix async fsync creds
Date:   Thu, 28 Nov 2019 16:59:29 +0100
Message-Id: <20191128155940.17530-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
References: <20191128155940.17530-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: tehmmQLwMhWpaQ2wUs0XwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avi Kivity reports that on fuse filesystems running in a user namespace
asyncronous fsync fails with EOVERFLOW.

The reason is that f_ops->fsync() is called with the creds of the kthread
performing aio work instead of the creds of the process originally
submitting IOCB_CMD_FSYNC.

Fuse sends the creds of the caller in the request header and it needs to
translate the uid and gid into the server's user namespace.  Since the
kthread is running in init_user_ns, the translation will fail and the
operation returns an error.

It can be argued that fsync doesn't actually need any creds, but just
zeroing out those fields in the header (as with requests that currently
don't take creds) is a backward compatibility risk.

Instead of working around this issue in fuse, solve the core of the problem
by calling the filesystem with the proper creds.

Reported-by: Avi Kivity <avi@scylladb.com>
Tested-by: Giuseppe Scrivano <gscrivan@redhat.com>
Fixes: c9582eb0ff7d ("fuse: Fail all requests with invalid uids or gids")
Cc: stable@vger.kernel.org  # 4.18+
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/aio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/aio.c b/fs/aio.c
index 0d9a559d488c..37828773e2fe 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -176,6 +176,7 @@ struct fsync_iocb {
 =09struct file=09=09*file;
 =09struct work_struct=09work;
 =09bool=09=09=09datasync;
+=09struct cred=09=09*creds;
 };
=20
 struct poll_iocb {
@@ -1589,8 +1590,11 @@ static int aio_write(struct kiocb *req, const struct=
 iocb *iocb,
 static void aio_fsync_work(struct work_struct *work)
 {
 =09struct aio_kiocb *iocb =3D container_of(work, struct aio_kiocb, fsync.w=
ork);
+=09const struct cred *old_cred =3D override_creds(iocb->fsync.creds);
=20
 =09iocb->ki_res.res =3D vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
+=09revert_creds(old_cred);
+=09put_cred(iocb->fsync.creds);
 =09iocb_put(iocb);
 }
=20
@@ -1604,6 +1608,10 @@ static int aio_fsync(struct fsync_iocb *req, const s=
truct iocb *iocb,
 =09if (unlikely(!req->file->f_op->fsync))
 =09=09return -EINVAL;
=20
+=09req->creds =3D prepare_creds();
+=09if (!req->creds)
+=09=09return -ENOMEM;
+
 =09req->datasync =3D datasync;
 =09INIT_WORK(&req->work, aio_fsync_work);
 =09schedule_work(&req->work);
--=20
2.21.0

