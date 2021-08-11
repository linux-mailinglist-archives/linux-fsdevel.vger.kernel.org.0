Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0943E99F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 22:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhHKUtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhHKUtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:49:15 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A54C0613D3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 13:48:51 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d2so3220392qto.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=K5DGD9kDx5XYbDocYVYTxr+SH9m1Ec10qsj0S44O4DU=;
        b=dfs4tqW1DH0lxUTGkwb0hlSRa2DwfFueGXq60cg29HNWmPDmJBHiuIa7WNBiFhiQH8
         WRbwj2v2HfE09MaC1t1VOfJhgGbGBsY9mA4CcGYY0pGGVlEPQSJ3f29IQ2ceeVpPm4GY
         acCJib2PHFebyn1Y++N6uScBHgLqF9arrCQbSuIU8IyV2OXXPSBmZLMYjWOsjzsSaQa8
         sY5i6dkehRWwDvsoljP0ljg4PxA5VRdgBsrdV5mYD39n3z+m7vWfiDJvdMRBzGjoyo8M
         Yxjt7RdXvTIzaOkcd20fCJaaey1roo6zeJpW79HdfcILFo29TczjlFl6Qpg5+IS2IYll
         66Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=K5DGD9kDx5XYbDocYVYTxr+SH9m1Ec10qsj0S44O4DU=;
        b=n+r1TMg6TK+PQyvfAgwejWrNWq8jzk3/02UoPobJ1z2MtvUGIee4Ul1ISWdFLozMQu
         BE6vPDt0UF0ObqED92Xfk1IqWrQb35Mw3DBH2tYZaTQ/oOu1B9ELbBam5J1Oq26YL5JE
         /9ZdG6TgYKzAIkCw5aWAXIB+uBWcdBBOvpO2LRtISk4F89CYVYgNcuyeGuGCNIFZyzF7
         sBmchZNNOgFKSgAWSZvtS3fNK2ESNrq7mUiDUj11qJBq9Up+CS+hs466+31I9vsHu0bJ
         UHSHsRZYFleGklxRzgbLWlLHJfz3w8DS3vyjuUWcY7TAuVKN9QqAaodGMMnO0m/EkUkr
         y6SA==
X-Gm-Message-State: AOAM532SrjdlY/o8O40majvPOAd439VQ80t09mJOKlkS7TaI67qf7i3T
        05Gc7c1OFg6S4aM0swgG7py/
X-Google-Smtp-Source: ABdhPJwyeccsfbwMzWyab694T/52i9x3Ei3ykPISARf+5l/2WrA/xbzH2q9DY4FxLg4PmfnLx9d/2A==
X-Received: by 2002:ac8:a0a:: with SMTP id b10mr596681qti.164.1628714930250;
        Wed, 11 Aug 2021 13:48:50 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id w9sm172320qtn.58.2021.08.11.13.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 13:48:49 -0700 (PDT)
Subject: [RFC PATCH v2 6/9] io_uring: convert io_uring to the secure anon
 inode interface
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Date:   Wed, 11 Aug 2021 16:48:49 -0400
Message-ID: <162871492905.63873.15953733001833062568.stgit@olly>
In-Reply-To: <162871480969.63873.9434591871437326374.stgit@olly>
References: <162871480969.63873.9434591871437326374.stgit@olly>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Converting io_uring's anonymous inode to the secure anon inode API
enables LSMs to enforce policy on the io_uring anonymous inodes if
they chose to do so.  This is an important first step towards
providing the necessary mechanisms so that LSMs can apply security
policy to io_uring operations.

Signed-off-by: Paul Moore <paul@paul-moore.com>

---
v2:
- no change
v1:
- initial draft
---
 fs/io_uring.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b407a6ea1779..ea396f5fe735 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -9662,8 +9662,8 @@ static struct file *io_uring_get_file(struct io_ring_ctx *ctx)
 		return ERR_PTR(ret);
 #endif
 
-	file = anon_inode_getfile("[io_uring]", &io_uring_fops, ctx,
-					O_RDWR | O_CLOEXEC);
+	file = anon_inode_getfile_secure("[io_uring]", &io_uring_fops, ctx,
+					 O_RDWR | O_CLOEXEC, NULL);
 #if defined(CONFIG_UNIX)
 	if (IS_ERR(file)) {
 		sock_release(ctx->ring_sock);

