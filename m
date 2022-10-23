Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B27E6094D4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 18:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJWQnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 12:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJWQnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 12:43:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF036EF07;
        Sun, 23 Oct 2022 09:43:20 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 20so6820047pgc.5;
        Sun, 23 Oct 2022 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWdKBK100G137ePLJZr7SsyGe/cg6oRLKCkeoRrPIPo=;
        b=Puu4zOrlu1SOJ0TTr60mNTaYFimaMnCTlIQSpZ7MuZJNWOsz5B7Jnh5Q2iq5TZUvfU
         DmjvbVyZXk2MaWyEFn9L75XKoD+t90BrEe1aT6DD4lPZH9c9PSZug5sWCcK6bMdZGtBs
         yyqdqSUYiXHLG5UzRNNcJ6+A4MZR6jHm4fP6fWFT5/pqEqWHaaSuZPz3Fj7np9GUq/Wv
         S/uK20hEweG4pjIjqLLcF1WXZNwDnKI5Ll+EST/86aXTHs8c1PKa0SwJpu1IQiXeBCLt
         UaNcYKFldx8jp/z8zV6k8dIDlpDcZtd/2hej4RU2OtQDNK8xYpTqla8COuCs+mRzXN3p
         hgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWdKBK100G137ePLJZr7SsyGe/cg6oRLKCkeoRrPIPo=;
        b=SVm+NIAjzU5r5a788obpJ0NRIyMRCRocfIwEkhCyQ/8xqcctctnVh/UrC9XJjQ0MJU
         vg47NqEBwRRZYJnV0jiVc1yLBRjjP5pnQsKopLhwUZWsaotFceH17HswuMZaBpyGcgk4
         XNjSFftNWI/gE7CNZQSjuhPHFlrNQEs2lPxnNsnE/aBsoHFSsJxpfL72HlNlTM4tgmYa
         Nj8cq0GcCK4mui5njSHJd2Xh01VUzTUNaLLJa8UkT5ADHutmT4+6NPcM44PqYCqEhUuS
         rSL7n4ZBPKfpxQZ/PNZGHLMZkxpYxQaCSWmtZi8pURsa0Iwgqm6irYLTs18qjjLrTn1w
         lN/g==
X-Gm-Message-State: ACrzQf2P9bIQismigyuJDb6LIsNQ05+Ag+y5Y2Opdovw+qB5YAlZkPtN
        O+DOdK6Y6F4WcoDpwSBgRZ71gtZuzQTmLlNYPIE=
X-Google-Smtp-Source: AMsMyM65pgebUloJXLq+xVGbHYKl50ABueurFVNJn3ofh6qpAEZU/8PfAdDk6oBGDvkc7U64FrLhng==
X-Received: by 2002:a63:480e:0:b0:46e:b96c:4f89 with SMTP id v14-20020a63480e000000b0046eb96c4f89mr11199609pga.201.1666543399790;
        Sun, 23 Oct 2022 09:43:19 -0700 (PDT)
Received: from localhost ([223.104.41.250])
        by smtp.gmail.com with ESMTPSA id k76-20020a62844f000000b0056b91044485sm2688499pfd.133.2022.10.23.09.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 09:43:19 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     yin31149@gmail.com
Cc:     18801353760@163.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH -next 5/5] proc: fix possible null-ptr-deref when parsing param
Date:   Mon, 24 Oct 2022 00:39:51 +0800
Message-Id: <20221023163945.39920-6-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221023163945.39920-1-yin31149@gmail.com>
References: <20221023163945.39920-1-yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to commit "vfs: parse: deal with zero length string value",
kernel will set the param->string to null pointer in vfs_parse_fs_string()
if fs string has zero length.

Yet the problem is that, proc_parse_param() will dereferences the
param->string, without checking whether it is a null pointer, which may
trigger a null-ptr-deref bug.

This patch solves it by adding sanity check on param->string
in proc_parse_param().

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 fs/proc/root.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 3c2ee3eb1138..5346809dc3c3 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -130,6 +130,9 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 
 	case Opt_subset:
+		if (!param->string)
+			return invalfc(fc, "Bad value '%s' for mount option '%s'\n",
+				       param->string, param->key);
 		if (proc_parse_subset_param(fc, param->string) < 0)
 			return -EINVAL;
 		break;
-- 
2.25.1

