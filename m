Return-Path: <linux-fsdevel+bounces-178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C637C6F8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 15:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B458282993
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 13:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF71A30D03;
	Thu, 12 Oct 2023 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6GinkgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6833E2AB5E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 13:44:45 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B4ED7;
	Thu, 12 Oct 2023 06:44:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40537481094so10697345e9.0;
        Thu, 12 Oct 2023 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697118282; x=1697723082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQBIk69QFlbYTxAs2STa0KR4A9RGxwDTRGPJubc9nJ4=;
        b=E6GinkgZPzeczG07I+feQqQIQ7IwUWcfnd057I7Oxvc2//yBhcTgm4Qf8y9g/LpSZU
         HTHszTT6MuPevbVBR2R70eBYQjtlNgG2t2HQTw0j9s8sIyrgGCHYAddExFg8K3mlFjaO
         INEKu6igmU2yqyTq1UzQAo7qsufa3zbQP7EuB40IBS5syFRfrgs/N4ZpYWVyeJvXRXjV
         0TI3kgSQmBlw1ethQR9p9I5gy9nlg+3uS+TX/GKaALWCSZ0NKt0LMCsOZyh0wMeCWMhx
         d3UtXx7ZyC+TTLkvvGYczNuwvqcbgr6jpwstjFcJcq7WQ8rREYOpctc1r9i1cJiH9wdb
         qrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118282; x=1697723082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQBIk69QFlbYTxAs2STa0KR4A9RGxwDTRGPJubc9nJ4=;
        b=tkc1dwxNtClo4k2AmD26bEefcL7A80NyCZDC8M4ysKZjJlrU6lk3U4r8Bp+DrCIlhz
         2vLslrZgrlt8OUYdxBfo9srKaMQqRrxQ/LSt/j8x/ozklmZf5OjcUnmpKxfuynDPG+Jt
         YjIvIx/mmrTaAa9Lbi9dg3/fGnwriqRAKtjQ7plI4ervQB/U5dxxZI2sH0p/jIpG8b2j
         B1RFekcx0vfm6HlGIHI9ehpN0fLHJ/pegdmYw6QzGNK2UbFC9V1waUB/E2UpoKUegBmi
         UsKSB27qneFG9skWMeioXa1TUo8yzoOU7ZBn9iKa2fKJ3/9Vgcs3kfe2MPQuTCe74e1x
         7Mlw==
X-Gm-Message-State: AOJu0YzR0eCPCxwzTgMSmd2LGd0VnCdwOPXnkncN3nuQse6ld75YwwPy
	CMLpU1LJzIeyrRqY64Mo1CE=
X-Google-Smtp-Source: AGHT+IHI37fY8uctORu9YjDOzbiUG8s7M62XR4ULQtja972FEF7f0QIcY07k+0FnFqQqw4yXWMSSmQ==
X-Received: by 2002:a1c:7c0b:0:b0:402:8896:bb7b with SMTP id x11-20020a1c7c0b000000b004028896bb7bmr20213613wmc.6.1697118281986;
        Thu, 12 Oct 2023 06:44:41 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc450000000b0040536dcec17sm21825154wmi.27.2023.10.12.06.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:44:40 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Subject: [PATCH 2/2] ovl: fix regression in parsing of mount options with esacped comma
Date: Thu, 12 Oct 2023 16:44:28 +0300
Message-Id: <20231012134428.1874373-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012134428.1874373-1-amir73il@gmail.com>
References: <20231012134428.1874373-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ever since commit 91c77947133f ("ovl: allow filenames with comma"), the
following example was legit overlayfs mount options:

  mount -t overlay overlay -o 'lowerdir=/tmp/a\,b/lower' /mnt

The conversion to new mount api moved to using the common helper
generic_parse_monolithic() and discarded the specialized ovl_next_opt()
option separator.

Bring back ovl_next_opt() and use vfs_parse_monolithic_sep() to fix the
regression.

Reported-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Closes: https://lore.kernel.org/r/8da307fb-9318-cf78-8a27-ba5c5a0aef6d@alum.mit.edu/
Fixes: 1784fbc2ed9c ("ovl: port to new mount api")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/params.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 1429767a84bc..c2c3820b86f2 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -157,6 +157,34 @@ const struct fs_parameter_spec ovl_parameter_spec[] = {
 	{}
 };
 
+static char *ovl_next_opt(char **s)
+{
+	char *sbegin = *s;
+	char *p;
+
+	if (sbegin == NULL)
+		return NULL;
+
+	for (p = sbegin; *p; p++) {
+		if (*p == '\\') {
+			p++;
+			if (!*p)
+				break;
+		} else if (*p == ',') {
+			*p = '\0';
+			*s = p + 1;
+			return sbegin;
+		}
+	}
+	*s = NULL;
+	return sbegin;
+}
+
+static int ovl_parse_monolithic(struct fs_context *fc, void *data)
+{
+	return vfs_parse_monolithic_sep(fc, data, ovl_next_opt);
+}
+
 static ssize_t ovl_parse_param_split_lowerdirs(char *str)
 {
 	ssize_t nr_layers = 1, nr_colons = 0;
@@ -683,6 +711,7 @@ static int ovl_reconfigure(struct fs_context *fc)
 }
 
 static const struct fs_context_operations ovl_context_ops = {
+	.parse_monolithic = ovl_parse_monolithic,
 	.parse_param = ovl_parse_param,
 	.get_tree    = ovl_get_tree,
 	.reconfigure = ovl_reconfigure,
-- 
2.34.1


