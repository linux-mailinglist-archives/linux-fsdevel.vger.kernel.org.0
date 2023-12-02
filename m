Return-Path: <linux-fsdevel+bounces-4694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064B1801F0A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 23:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EDD1F20F60
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AE6224C0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HqKQgTMB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC3B125
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Dec 2023 13:22:25 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d08a924fcfso1112695ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Dec 2023 13:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552144; x=1702156944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr8v5ioi9yhGCNoI15AUxdx1ZJerS/H1pXIO2zt31RE=;
        b=HqKQgTMBVxs/PT2XUTy4QRahXlfSOpb+2P7T6oLQzKCBFsyL7sId4K0GghvgK21Uv5
         H5hmnBcZgSJAEkhxmg+UmVxXMrgpE0bVBwDomQhPXq2/gEX0wmzoCY5h0EdL4M5urKgz
         uNQvfiQYtnror4SJNB7CNjTQ9HpIyDwmvJ07A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552144; x=1702156944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kr8v5ioi9yhGCNoI15AUxdx1ZJerS/H1pXIO2zt31RE=;
        b=r1KCDJEEXZ8mEBkS0hO3e80T3rvop72g85cTDInnY5uNLHvFlB0yE5zp6N3e+RfEFM
         xJR9qOlIscMq/GeFqaHgyyUwFBw2Pu7llPDQ7Re34jJOlsz67k58A8eMB+hH5CFd99pk
         WSvKwyNjXQqtMcPKtWrsqz2btsBDo9WTGIHjJUrtQbfbtMFlk9lkz/8jhFmH7gJ0PaFO
         5SKDS6pJYfUyQfxHxZzdsscRkdEmK0PDr8lSWVff027On+AN/c1CcHaFl7iFPni/bhXm
         wirW3bMp5BRRPNAfB6QBwoj6q/7Ld9CbOouIJ0yzXMRX6YxuSPncnlpUF/IJya+/FL2r
         RNbQ==
X-Gm-Message-State: AOJu0Yy8Lgj86nZWLxphTefPzT0QFHVPJOmo9u9bBAxwbTBc5sksUmw6
	JLnCOuGs+NpG+F0Ykp4A22P/8eMFRDTnnAvcSBI=
X-Google-Smtp-Source: AGHT+IG017mNZBo0bndQaUaGGGrBkKnojaT6BI2kua61y2eLW7fMhSCLv7G5Ou/R8iC3O1oe/Lf23A==
X-Received: by 2002:a17:903:22c5:b0:1d0:6ffd:e2c7 with SMTP id y5-20020a17090322c500b001d06ffde2c7mr2044102plg.97.1701552144686;
        Sat, 02 Dec 2023 13:22:24 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001cfb971edf2sm5607037plx.13.2023.12.02.13.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:22:23 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-hardening@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] pstore: inode: Use cleanup.h for struct pstore_private
Date: Sat,  2 Dec 2023 13:22:15 -0800
Message-Id: <20231202212217.243710-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202211535.work.571-kees@kernel.org>
References: <20231202211535.work.571-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=keescook@chromium.org;
 h=from:subject; bh=2VOJhxKhawry4zB5INkZO9i8H3FTFJSHkB6X8kUlVPU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla6AGDW8hXonEKigawraWf7F2wiPHsStg+E08f
 Sxgn4os0kCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWugBgAKCRCJcvTf3G3A
 JhTDEACNiMPD3b67gn9zNW4/ju9hFrGMsJjSQ7KEHIZH8TvkblvRnwZFbrVAPlbHrhqyzPnosiv
 RrgJmNPJReV/CWU6tQkLFnyPFYc9GKeS0lBBFOcMLGu/XDM9G/Sjv+ZeYTyfyOW6IeluJIuMPBf
 EJyjm2w/tlZMPldQNw5gwettLVjEjThBz1y/LgIQwtWWgiUzfLyYeApXA1LCey9bZ2OkCUchwgW
 0BKcL2Puv1CtHOHwZ/FQ/MyqA2ADGyA4mrpGl7d4toQk4uECTTsv+qOtu/6wKASvbYy4QIJmLWE
 xkeWVRWohYcqWeUg9DoahE3IcWnA0ry6NNlMLpUtEmhx+U7CqpYXT5ejREJ3h1deBf8Gwivt1de
 UoDxTsF8u5rZwsrK6livq2nG+q45XPK+SCG6CzZ+bCU4FxSdppDD9d7KyQr1p2YWc8KqZvCSIdK
 UCZepXh6abHECZC7ZgiPujvwxB3UBFpStBlAeWso5EUm800a0CUyB6/poJiZyAUd6O7/Hh2GOds
 jnhPwrkBxp+1gXEEjY4QOy+zay5bdrkNrVQ6ZsF5UwBRGPUx0o+WG6TKpWWoILlQ4mJ1YeZMgj3
 6c0WQUcvUTwxxJtuLLMynSwKn6uBKeMJRkc+EY51mYXZ4kw+4CricAYkzOAVyvaeCuKucDZCiFH Ngx7gfISAw/fzgA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Simplify error path when "private" needs to be freed.

Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 20a88e34ea7c..7d49f0c70dff 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -61,6 +61,7 @@ static void free_pstore_private(struct pstore_private *private)
 	}
 	kfree(private);
 }
+DEFINE_FREE(pstore_private, struct pstore_private *, free_pstore_private(_T));
 
 static void *pstore_ftrace_seq_start(struct seq_file *s, loff_t *pos)
 {
@@ -338,9 +339,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 {
 	struct dentry		*dentry;
 	struct inode		*inode __free(iput) = NULL;
-	int			rc = 0;
 	char			name[PSTORE_NAMELEN];
-	struct pstore_private	*private, *pos;
+	struct pstore_private	*private __free(pstore_private) = NULL, *pos;
 	size_t			size = record->size + record->ecc_notice_size;
 
 	if (WARN_ON(!inode_is_locked(d_inode(root))))
@@ -356,7 +356,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 			return -EEXIST;
 	}
 
-	rc = -ENOMEM;
 	inode = pstore_get_inode(root->d_sb);
 	if (!inode)
 		return -ENOMEM;
@@ -373,7 +372,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 	dentry = d_alloc_name(root, name);
 	if (!dentry)
-		goto fail_private;
+		return -ENOMEM;
 
 	private->dentry = dentry;
 	private->record = record;
@@ -386,13 +385,9 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 
 	d_add(dentry, no_free_ptr(inode));
 
-	list_add(&private->list, &records_list);
+	list_add(&(no_free_ptr(private))->list, &records_list);
 
 	return 0;
-
-fail_private:
-	free_pstore_private(private);
-	return rc;
 }
 
 /*
-- 
2.34.1


