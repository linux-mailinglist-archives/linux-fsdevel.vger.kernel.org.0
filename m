Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F47CC433
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2019 22:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfJDUa0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 16:30:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33410 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730947AbfJDUa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:30:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id x134so7052559qkb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2019 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cOBD1sA2P34UL4w4Lma3JYhrDm5zd76HSZlaAP9VmpQ=;
        b=PH8inHgg12/uPJ/GSIw2pZM6RJ1Kk/++NoPuqVZ3Shl2jSYiszqhhnuU1MSkv9dL5e
         LcdGv1pgoEn903AnEkKH27WCCVXebFdarYUeKKl4PQlDlhpAl2BemC4WDxkovs9AQCw9
         FRDi3AKShu/ZhVLG2iFI+C28kfU42TstbjU0cKxUSx6Z+gbsqfJGK2RTZQnmKN5dkKCy
         UjDQJ717crJ73n2i+xoASLm0s2s2EXqSTl8+qXjIm3rT7Fn65NDEmHoJIkdgFoEeBb+o
         dpEOi52Ts9rQwpXmLh4s6D7tvAH0oMCQYy6YhveYuYy3/T+bB8GGUAJIoGgVHMICAAJF
         baVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cOBD1sA2P34UL4w4Lma3JYhrDm5zd76HSZlaAP9VmpQ=;
        b=cY7RFL4zr9wGSE0RZQUaRmii4BVrtPNZTpcZRcdKD8lS19BUt8KhazEQB0pcxoXXkl
         A7qqYRvc87l1kT8TDK1WgF0/qGe4gzMs4xqc4UIWS7GN5vbtZLV1Nv5gsv1rmHvS0IbY
         oNgCl4nmKypwMuY6RyJLC0Y+/Xm9/RcRDApqB6AO3Kka/w7gIHKe32qBwDrwVCNG+PSq
         vi9ppmdu++Hnd6w+QO+quelQ5ClhJ6jfoBXdGhQyFjY/+WnL7UtSUYdWUrdFd5DZ7KqL
         ZwtTICzF5Bn01EjTn1GR9upCDkTK4B33Bbcm4W1hxgo0QHkzraSWEsxTnL2WjnEakMRJ
         6Uew==
X-Gm-Message-State: APjAAAWeGUQAX5cTdWl5F+Fb1rEisS/MlKVLP7i26t1AhbYkvrDs0P+M
        LET7y7zV/O9v8sUTA1SsaA==
X-Google-Smtp-Source: APXvYqyW4hvOtv91ntzicbohI8iZUgh/DVbpjF0vd0SIu3840ByBb3mg/i6Lg6Xrgpxwf+72fBRi8w==
X-Received: by 2002:a05:620a:140b:: with SMTP id d11mr12174746qkj.22.1570221024113;
        Fri, 04 Oct 2019 13:30:24 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x12sm4838503qtb.32.2019.10.04.13.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 13:30:22 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] virtio_fs: Fix file_system_type.name to virtio_fs
Date:   Fri,  4 Oct 2019 16:29:21 -0400
Message-Id: <20191004202921.21590-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

On 5.4.0-rc1 kernel, following warning happens when virtio_fs is tried
to mount as "virtio_fs".

  ------------[ cut here ]------------
  request_module fs-virtio_fs succeeded, but still no fs?
  WARNING: CPU: 1 PID: 1234 at fs/filesystems.c:274 get_fs_type+0x12c/0x138
  Modules linked in: ... virtio_fs fuse virtio_net net_failover ...
  CPU: 1 PID: 1234 Comm: mount Not tainted 5.4.0-rc1 #1

That's because the file_system_type.name is "virtiofs", but the
module name is "virtio_fs".

Set the file_system_type.name to "virtio_fs".

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 fs/fuse/virtio_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6af3f131e..f72803120 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1158,7 +1158,7 @@ static int virtio_fs_init_fs_context(struct fs_context *fsc)
 
 static struct file_system_type virtio_fs_type = {
 	.owner		= THIS_MODULE,
-	.name		= "virtiofs",
+	.name		= "virtio_fs",
 	.init_fs_context = virtio_fs_init_fs_context,
 	.kill_sb	= virtio_kill_sb,
 };
-- 
2.18.1

