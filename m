Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD67147FCF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Dec 2021 13:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbhL0Mzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Dec 2021 07:55:36 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:48501 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236926AbhL0MzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:55:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V.wXYVp_1640609703;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V.wXYVp_1640609703)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 20:55:04 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 16/23] erofs: add 'uuid' mount option
Date:   Mon, 27 Dec 2021 20:54:37 +0800
Message-Id: <20211227125444.21187-17-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce 'uuid' mount option to enable the nodev mode, in which erofs
could be mounted from blob files instead of blkdev. By then users could
specify the path of bootstrap blob file containing the complete erofs
image.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index ea56122f7a35..4f17aedc4acd 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -451,6 +451,7 @@ enum {
 	Opt_dax,
 	Opt_dax_enum,
 	Opt_device,
+	Opt_uuid,
 	Opt_err
 };
 
@@ -475,6 +476,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag("dax",             Opt_dax),
 	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
 	fsparam_string("device",	Opt_device),
+	fsparam_string("uuid",		Opt_uuid),
 	{}
 };
 
@@ -570,6 +572,12 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		}
 		++ctx->devs->extra_devices;
 		break;
+	case Opt_uuid:
+		kfree(ctx->opt.uuid);
+		ctx->opt.uuid = kstrdup(param->string, GFP_KERNEL);
+		if (!ctx->opt.uuid)
+			return -ENOMEM;
+		break;
 	default:
 		return -ENOPARAM;
 	}
@@ -784,6 +792,7 @@ static void erofs_fc_free(struct fs_context *fc)
 	struct erofs_fs_context *ctx = fc->fs_private;
 
 	erofs_free_dev_context(ctx->devs);
+	kfree(ctx->opt.uuid);
 	kfree(ctx);
 }
 
-- 
2.27.0

