Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C06106A6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 11:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfKVKeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 05:34:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36619 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfKVKen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:34:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so7996478wru.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2019 02:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xoopziCwRDwcOCcLX2bq3UzyChei3JKVQ4eG5CpYcIk=;
        b=I2EeAfwEF5KbI0aLSeEJOqguxae0ryThYzgdrCjIg6ghM8FHBg/+E3SPopp8RTt/Dg
         dkXF111JL+f8CvxYB0K1kOmJ3lKl193y/b8aKRjCAcPUniZYRVUcrT+zRqwB03eLiCSJ
         23es+tl6aRnee4r6wXymdPABOUS7+SOCaQSTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xoopziCwRDwcOCcLX2bq3UzyChei3JKVQ4eG5CpYcIk=;
        b=ckKd4BdjT9ArzNJYFfBJm7vnn1100yiJg/wbmgSY7B+75gYlNc92ebJzBo07I/tlVu
         z3RiDDx17hN5ZLBE+n/PNMRFP2kiHRJUiSAT4FhA++sQlRiJpZ4FlB5J3FPcZmDQMcqu
         U9J+GgBmiSPyjN5e4Dk8OK+ZmNgYjQnzmzA7M99Un4BR0hCdpJr38wdrSH48rkvmGaYc
         ZawcLKThQlH6etcnil+FukcpJ43BMKvS9dGQ0QEwJyICUsTbWZ4WyzFuFjTXI/Hs3h2R
         vAxR8VJ0KtGxdqNJr+ZXw1Xvo4svys+bMZkyjiaRi1x5pqMNZjnxElkGzwwwZrzpvOjM
         3CBg==
X-Gm-Message-State: APjAAAUPHrvvd55zOSsKwFg/4jVAmrqcgqmkRDyiM/udmxbPrOCHqJnV
        QDoyJYgLNkH58g7ZJ9qmv8IfGQ==
X-Google-Smtp-Source: APXvYqwBh2amwymgzNpGsi3OL5qfkrUr5We+4oP6RL12hGGFyroS7/98SyefMdOwg2SsHP50UUvSdg==
X-Received: by 2002:adf:ec42:: with SMTP id w2mr16066538wrn.32.1574418881685;
        Fri, 22 Nov 2019 02:34:41 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id y16sm7251039wro.25.2019.11.22.02.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 02:34:41 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:34:38 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Avi Kivity <avi@scylladb.com>
Subject: [PATCH] aio: fix async fsync creds
Message-ID: <20191122103438.GC5569@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

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
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/aio.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -176,6 +176,7 @@ struct fsync_iocb {
 	struct file		*file;
 	struct work_struct	work;
 	bool			datasync;
+	struct cred		*creds;
 };
 
 struct poll_iocb {
@@ -1589,8 +1590,11 @@ static int aio_write(struct kiocb *req,
 static void aio_fsync_work(struct work_struct *work)
 {
 	struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
+	const struct cred *old_cred = override_creds(iocb->fsync.creds);
 
 	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
+	revert_creds(old_cred);
+	put_cred(iocb->fsync.creds);
 	iocb_put(iocb);
 }
 
@@ -1604,6 +1608,10 @@ static int aio_fsync(struct fsync_iocb *
 	if (unlikely(!req->file->f_op->fsync))
 		return -EINVAL;
 
+	req->creds = prepare_creds();
+	if (!req->creds)
+		return -ENOMEM;
+
 	req->datasync = datasync;
 	INIT_WORK(&req->work, aio_fsync_work);
 	schedule_work(&req->work);
