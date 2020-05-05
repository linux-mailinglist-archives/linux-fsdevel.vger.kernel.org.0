Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC81C5258
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgEEJ7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46772 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728716AbgEEJ7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ZmKs7uNMAuXYKcLxlhTHc9oEghlYM1iBCHo/bbRpaA=;
        b=PV4CP1SzCVQI53gdA9X4roIc4LhxmmansrVc96TWqdo9cieMOOlGwHKsi1iR8mo0YIN5nk
        gTd0nGZysv1SqT3eqYla5ZIgX+B8mAJVXlvF2wUlFW48M6jZhXwy+tYmiA/hA14DHtLxW/
        1NxLtMQiiUp+lGgc65mcANhDrBgVVug=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-yKVnTmykN_yy5meqM7JvdQ-1; Tue, 05 May 2020 05:59:30 -0400
X-MC-Unique: yKVnTmykN_yy5meqM7JvdQ-1
Received: by mail-wm1-f70.google.com with SMTP id f81so640700wmf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZmKs7uNMAuXYKcLxlhTHc9oEghlYM1iBCHo/bbRpaA=;
        b=dcJLqF7d+0pJ5ygvRLVffoCXNooh/ZMmJ/S7mxhqqdmx/lP+cxCw0si+01Kk5+2kyN
         kIT8Ns+3R1DM81G/fKIJ7lRaPabmup6sWn2jShhmr2eNUiOYb4B9wJS1CvwcDJ91jpBn
         YWR8RT707NPNCGgi50fL/HCOsxqBocfqU72VUAl0N0UfLp4v5nv7Fs7KoScQQfhjqT8O
         wrCrupJmvhNL8+BhZmOMt/kW/55yuUGllSkHss5fJwRix0YOSbe1Je8tIesvX6hmjpS5
         LsMUA+dyM9tc1bLLSJjnt1eVlLb9UnrtUtxZMNEcTU/Kkz1cjVVFgNoOYvg27Nh3zGk5
         tG2Q==
X-Gm-Message-State: AGi0Puau2FpJsfsHFmCwKLLwouf9W7FoKXHCkpyEaohtCBEOmRdAdftB
        sAZ8NsYf/B9VGajr3CjGB2CTvTlOevyU8YhMd4pItkD8wMlyabVBoEtKrtEt11i31WK2XYEd2bT
        l6T20TftVNDUhUjGX8fP8KqeUTA==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr2760797wrw.314.1588672769410;
        Tue, 05 May 2020 02:59:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypLPVZHNp9aWFnY2Sb5U8Q+FRbNPRZLMtPwftyVFubSyDhJrN7rZP0+gFK+QpsdvdVG4Y7nCmg==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr2760784wrw.314.1588672769276;
        Tue, 05 May 2020 02:59:29 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:28 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/12] vfs: don't parse forbidden flags
Date:   Tue,  5 May 2020 11:59:13 +0200
Message-Id: <20200505095915.11275-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index fc9f6ef93b55..07e09bcf256c 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -57,40 +57,12 @@ static const struct constant_table common_clear_sb_flag[] = {
 	{ },
 };
 
-static const char *const forbidden_sb_flag[] = {
-	"bind",
-	"dev",
-	"exec",
-	"move",
-	"noatime",
-	"nodev",
-	"nodiratime",
-	"noexec",
-	"norelatime",
-	"nostrictatime",
-	"nosuid",
-	"private",
-	"rec",
-	"relatime",
-	"remount",
-	"shared",
-	"slave",
-	"strictatime",
-	"suid",
-	"unbindable",
-};
-
 /*
  * Check for a common mount option that manipulates s_flags.
  */
 static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
 {
 	unsigned int token;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(forbidden_sb_flag); i++)
-		if (strcmp(key, forbidden_sb_flag[i]) == 0)
-			return -EINVAL;
 
 	token = lookup_constant(common_set_sb_flag, key, 0);
 	if (token) {
-- 
2.21.1

