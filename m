Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8C51C524C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgEEJ7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39184 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbgEEJ7Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyszvEdfhOqvydMHG0rBHFkiY38nX4lEEIw22aCBSnI=;
        b=RqPRL6RMw6SXPnNnvAJFbQ3DZfFAHh46tgV8pf3gdOHamDBp4x4d7pZpVQgO1fv2/5PQE8
        Km2uNdKYJJHv4xEShejk7hyR3e4ZaiAcqH8z5MZCQ68ifl86GPwfH6LFFNecIs0/F51lKy
        5AiJIbJPXan0wJxudUDhiuNt2VIezK8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-57jQg6vDO6muvhGUcfDxlg-1; Tue, 05 May 2020 05:59:21 -0400
X-MC-Unique: 57jQg6vDO6muvhGUcfDxlg-1
Received: by mail-wr1-f71.google.com with SMTP id f2so967771wrm.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OyszvEdfhOqvydMHG0rBHFkiY38nX4lEEIw22aCBSnI=;
        b=cy8Lx1Yp6MEU+/qzzlQ8cU+0VDp4IWNOqsSLBTLBx3Sg+6PP3di0v99ZjnXMQgUM++
         i30o67T2uX9uTTq6xkY8Z8ha/kkUclZDjewZrqPm7S9hGXvchNI+ZxBxLRsMctJ6H5fq
         QAGbH4eJ7x+lEqwfYvXVekZ47MLKIG0CG7FpH7nEHDUlz9tD8V58gUe6YIyBK6WTNdCP
         W7POD7Hg/6+H6qEPP0PtC5xAas4pjKirenMN2Z2bc6qurdeN7fhKaMek0e4bEVQVgxAW
         xLkhAsT90evAkS10lqC5EoziD5y+FnmmGefCO68NWJrt8yQrzIQayD5Xb9uQw9EKen8M
         ORuw==
X-Gm-Message-State: AGi0PubEfPwybKyowXblEsSUWqlD1ve66ZohUViIViDm4DJvYeyXqYJ0
        2ig14W/p3t2L/3IN9xNbkr/8VBKZZLaZosMaCfOAasTbXdYp0lfcw2Y1wmJGUxU4GI5fIX4w/Sw
        3AacJqfJ5lpqu83kkJhR6Sz0ZAA==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr2760084wrw.314.1588672760178;
        Tue, 05 May 2020 02:59:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypJvCZOQu0cs8h545uYlQatVCv4VfNKe6VY53mr88ncSgs6P0niA5ZZfVwJnwn/2Trdin8ScfQ==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr2760067wrw.314.1588672760001;
        Tue, 05 May 2020 02:59:20 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:19 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Avi Kivity <avi@scylladb.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 02/12] aio: fix async fsync creds
Date:   Tue,  5 May 2020 11:59:05 +0200
Message-Id: <20200505095915.11275-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 5f3d3d814928..6483f9274d5e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -176,6 +176,7 @@ struct fsync_iocb {
 	struct file		*file;
 	struct work_struct	work;
 	bool			datasync;
+	struct cred		*creds;
 };
 
 struct poll_iocb {
@@ -1589,8 +1590,11 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 static void aio_fsync_work(struct work_struct *work)
 {
 	struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
+	const struct cred *old_cred = override_creds(iocb->fsync.creds);
 
 	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
+	revert_creds(old_cred);
+	put_cred(iocb->fsync.creds);
 	iocb_put(iocb);
 }
 
@@ -1604,6 +1608,10 @@ static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
 	if (unlikely(!req->file->f_op->fsync))
 		return -EINVAL;
 
+	req->creds = prepare_creds();
+	if (!req->creds)
+		return -ENOMEM;
+
 	req->datasync = datasync;
 	INIT_WORK(&req->work, aio_fsync_work);
 	schedule_work(&req->work);
-- 
2.21.1

