Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAE33398BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 21:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhCLU4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 15:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhCLU4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:56:10 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12B9C061762
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Mar 2021 12:56:09 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o10so16647683pgg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Mar 2021 12:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0MZ2+8nOsi7HJhoAfY0jiveT3TjLCB961VetY/jrPME=;
        b=hv4WP0ZL+I8JtgtyKJ7f7l9KqijZvL568YYhIiCgfdKI7r+UV7zLmMfPvTUHVRXyKx
         o4CradS9EPYHOAmodxix7Nhkt427K+WQjUbz/aEHGlWGJrr6FqqOZqGXnyS7niQgUt+J
         EvhCpgqbDwIhDRkgPuWskwZZtUa25kw7dfEzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0MZ2+8nOsi7HJhoAfY0jiveT3TjLCB961VetY/jrPME=;
        b=bvdxaiwSMkfhdNWTbE3Z3RFpiIueicoZmtK2VSxqcBVMYD4YaoTrAJyjaZjDKiNNUc
         ZdLhD0HmwY+mNXFuU3Hw3h+FU/gdA8+L6aCC4xRas9vwkWCDjFjIR42JdO6hyZmK6iru
         l6v8VdZIH6F2CcmIV+HyJFbKYkuD+3wYWQU23aCJSHvM3eyGqSgQyf/I08CwPnW4+kDd
         hH0Ac2fTJWVPjc9BdBasmXRcgoV2Zp73OXSJk8TDAacjaErzuCeIv+yC6c2qje+ixX/k
         56LUmUnUhvdzTXxJNwsRqChRE2R+B9kYRtN3Qo6s9t8BAc46uMquRv1lT6VqHn0xk9L/
         EF2w==
X-Gm-Message-State: AOAM5320Et8tC+DZjiwABfvwZGed3t4D0SxzIopN/itUPa8359AyeLkG
        JsueNjDCy9FPoxmW1+g9LW2B9Q==
X-Google-Smtp-Source: ABdhPJzafy8BkL0OjlmboQU08y3WvQDXVi4tBbIHv5S4LxUKUq0ByUCjHSgQQd7OLwhk4XwkCkPP+g==
X-Received: by 2002:a63:4f59:: with SMTP id p25mr13380520pgl.335.1615582569298;
        Fri, 12 Mar 2021 12:56:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c25sm5919465pfo.101.2021.03.12.12.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:56:08 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] seq_file: Unconditionally use vmalloc for buffer
Date:   Fri, 12 Mar 2021 12:55:58 -0800
Message-Id: <20210312205558.2947488-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=6e23cb09e9c77602ae36025771732e214a07d5d1; i=wnTs9CQ9b8oyAQUYWk1TWb6rr60OLTnvw/rrLAiBrmk=; m=mNgWWeM/mV0t2QLIflkURb7sIrkmH0bDqAx9/NsC4HI=; p=mfyYitSAa6+tmp4ZfMy/uMq8hKV0urLrdhp8kEobIBA=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBL1V0ACgkQiXL039xtwCa3LQ/6Amd tpDEYqTBiE/cyKH5oUqsQxoRBQ19QCQ9ALOD4dXuoBkkGN2Z8c4FJjnPlpgEDPXleFKrWyxGVvQYs gzJxQAsLJ5cG0YYTFGMHHDTrWCNNCqi9+PpSZP8vZ7+HtwsHJIVWrZEGrkYLRIVVrY8sFTWpcKghS YGBi7qPuHqBiz0axrxoqgaX8KKG6wCDpgJn2yPZkwPFvv0gAKRPNdBRbgCk29gs/nc8/1/cPcXZuN fmd1JOG+7QeCK2EZ/0c2WkcYi1/tGVtJuFOeSGqmaJ+te9giO8ttPFZKSf68zxMsffb71+beLFXbx L2mplD8GK/yZZ3rDf7fl36bcIVF1EfzishGjcJEk4qMz+7WfyHCb7cLl74fcsWiv5NVjdQD8UHgdE rvgvzwZ6vo7XEipizdLTILPj7pdW+51I2RvZOreYuQxN3PY0HW4uTVb7RX/FKm4iE/E5birDDza4m Q+HGdnqsqXnni58jFh9EUwGzVeMpksHjIkPrMsy50opl3TAp1149pFv5IbpJ98FKhHpmeD9MqPbG+ EQU+zzxfuD7Tdg0Rq/LeN7/OWQdrdFh4wtU7+O1sbW/LLVyCd0tJEVGhF0FUWKTDLr+PzMLWyA16z dggneBkRh7rz6SCkRsaIXJYYYesvxRwBGxbt1E4u4BGQkdQimA5Y8fQsXpK2tkjc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sysfs interface to seq_file continues to be rather fragile, as seen
with some recent exploits[1]. Move the seq_file buffer to the vmap area
(while retaining the accounting flag), since it has guard pages that
will catch and stop linear overflows. This seems justified given that
seq_file already uses kvmalloc(), that allocations are normally short
lived, and that they are not normally performance critical.

[1] https://blog.grimm-co.com/2021/03/new-old-bugs-in-linux-kernel.html

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/seq_file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index cb11a34fb871..ad78577d4c2c 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -32,7 +32,7 @@ static void seq_set_overflow(struct seq_file *m)
 
 static void *seq_buf_alloc(unsigned long size)
 {
-	return kvmalloc(size, GFP_KERNEL_ACCOUNT);
+	return __vmalloc(size, GFP_KERNEL_ACCOUNT);
 }
 
 /**
@@ -130,7 +130,7 @@ static int traverse(struct seq_file *m, loff_t offset)
 
 Eoverflow:
 	m->op->stop(m, p);
-	kvfree(m->buf);
+	vfree(m->buf);
 	m->count = 0;
 	m->buf = seq_buf_alloc(m->size <<= 1);
 	return !m->buf ? -ENOMEM : -EAGAIN;
@@ -237,7 +237,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			goto Fill;
 		// need a bigger buffer
 		m->op->stop(m, p);
-		kvfree(m->buf);
+		vfree(m->buf);
 		m->count = 0;
 		m->buf = seq_buf_alloc(m->size <<= 1);
 		if (!m->buf)
@@ -349,7 +349,7 @@ EXPORT_SYMBOL(seq_lseek);
 int seq_release(struct inode *inode, struct file *file)
 {
 	struct seq_file *m = file->private_data;
-	kvfree(m->buf);
+	vfree(m->buf);
 	kmem_cache_free(seq_file_cache, m);
 	return 0;
 }
@@ -585,7 +585,7 @@ int single_open_size(struct file *file, int (*show)(struct seq_file *, void *),
 		return -ENOMEM;
 	ret = single_open(file, show, data);
 	if (ret) {
-		kvfree(buf);
+		vfree(buf);
 		return ret;
 	}
 	((struct seq_file *)file->private_data)->buf = buf;
-- 
2.25.1

