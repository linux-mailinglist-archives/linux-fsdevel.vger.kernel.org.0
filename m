Return-Path: <linux-fsdevel+bounces-13514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4A28709DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED2D287976
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD178B68;
	Mon,  4 Mar 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lnAxA0LX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA87869E
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578178; cv=none; b=QXdeEKWmJF6M76f9zz/z6wdOoqmCVsVd9ZeGg/5ihhNLIvaK1VkZNP8rMqhcwhzXWYCctUF7vAsLnwkP16zRKPtTnTdjGDIrAdyNErsROTYZW98Jh/TmaX/G8dA/+jYou8D2SPJBHoo7VKwxJG8c46d/rGdYYSU6sfvgKnopY20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578178; c=relaxed/simple;
	bh=+zltM60WJIwhQhbYbj+QC0RcHFfEEaTaC5b3PkagfmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDPpCj130TfE8hz0NwDMj0VnxclcLiommVFjPKuWdlDiXcPvE/maOlKoeS5ydDmRPQCAg5cnxDYDE+RIvL439DnBfTdtIH0ROe73J+i533bBq92Q+NIFbscLZ7AI/wCrrRTKL7PZUyDPhzzW2ptdvO6sMyUZOHhoQdRxILAEV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lnAxA0LX; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dc949f998fso3766157a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 10:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709578176; x=1710182976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63pQSv4lgdcPPxgjmIdkeCTgPw+ykuMnj3qldPskCm4=;
        b=lnAxA0LX5r4TexID833cxBb9m6AYk1kuPjjHNW75Uz5yV5mnYRoxey8+d/FilyimRc
         z6bcJsRjZhuOgaGrcoPoZjEjOD7lTn6SCdPL9Egl121TaxJLgeYqQLiPxoUVz/ArfXce
         2ZxCUOR4cid/r/gD9cESFTgMJ2GsjxvVqVbzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578176; x=1710182976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63pQSv4lgdcPPxgjmIdkeCTgPw+ykuMnj3qldPskCm4=;
        b=M6+bLaeh9BlQ8VKULxyq2GaWTqcVgcbjayEhvVtH1iybF/pIEyQiqhNsWNQwCLN9mI
         7QZjety2+M9CqP/Op54Ty5Mql84wvz68qQimsnKa0c0ZBrnOM/m8mYNYvG2Zda40X8H4
         MKzTsUzj5iEH/z4wDuuL4pMe/iY/ynJeBYgQ6fHMpMQ/180h8ybYJsTw14ZDpPeJwG/s
         6zHFujOv/ZL8jw8SYx9QrYe6I+g/3Lym3M7IN1Ros2QWWDu0uEmxzyfofN+8l2rFUCXI
         z08TFsVdRyttrLohd8xwnSnPWUyZiZ8P0KqVhX6ynAuuk8F6Bt+PmLvQDOJjYs9+FGgd
         gmfA==
X-Forwarded-Encrypted: i=1; AJvYcCUwv0aeHES6BeJ1xiwzkDB63Ib7E2MMNk7hYMozOhp7+LD2kCiyIkDYucJVDBnTDvMa4ClvvwH2JE+l4JP/0DijRNQWW7KYh6UCq9T1eA==
X-Gm-Message-State: AOJu0YzskkWxMRfWKVN490P2TUGdPzk+uwlRJp7IDyJL9JEFZVC/1LaJ
	5vPLVTGIvY+r9osd2H8awkWj+GFVuinDicOcVRMfboGdZ8HViM7Cn/Zbu3qQcw==
X-Google-Smtp-Source: AGHT+IEqbrBUCeaoycN6eZ+VoJQJ/3ekxM3Ni9GrmrAmVAhx541ISPKoahwiO20Sd0vgoGv+eX/7cQ==
X-Received: by 2002:a05:6a21:9214:b0:1a1:4842:6760 with SMTP id tl20-20020a056a21921400b001a148426760mr1903106pzb.50.1709578176499;
        Mon, 04 Mar 2024 10:49:36 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j4-20020a654284000000b005d8be4c125csm6743414pgp.80.2024.03.04.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:49:34 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/4] ipc, msg: Use dedicated slab buckets for alloc_msg()
Date: Mon,  4 Mar 2024 10:49:30 -0800
Message-Id: <20240304184933.3672759-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304184252.work.496-kees@kernel.org>
References: <20240304184252.work.496-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289; i=keescook@chromium.org;
 h=from:subject; bh=+zltM60WJIwhQhbYbj+QC0RcHFfEEaTaC5b3PkagfmU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5he8qRUAcVCqu4hpjGv4CjmdHzSAnbUNg4er3
 NYamCewr9+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeYXvAAKCRCJcvTf3G3A
 JuDzEACBBwraGVldgENLbkSYf63dOOHOPJEiqhaSkAxMKXMPigi7yQdQbfcNSnwgtebo1L2uUYv
 8a5GjWZgg0pW2K8BJCfxaWqaOKGcKcaQl1JGzOhYIznQhTvy3eFL7liqoKr/iyqINgJllEJw5u1
 73nGpA9SrpjgMVQ1WWjUKo3CDRewIUR0dTk28fcGEgg2RubRBocB+ojMwSQvPfl2WwXNNJ6NnaM
 t1jPN5TOfmjkQwM+IKkwdXSau+eNTMhtba3hE02RRu1OPtszIgPzv9e6R7LQqcPA+z5Nnw9Mx4y
 ZbqEuw8j6jqARnWfEt9pH8SBkxg5A5JD8uhSVvD9eLQTvHQ47gbqoIV3OvqhNEVQB2mMxiFpJIK
 NlLkEb/nSKSv3ezcvBEPp9sNggeP6uknRz72aj7v0lLBeL9dnwoPjQS8Vx4tIco3WJcVgCiOxes
 11aqWUfxoQSK/Hm/2uAQSZRBPq9t11u4mLp4PCdwiyhfBdIqhHXQUXwKfqAd5M95kCOWSger5J9
 de8D2cgNhvOQlrVe+1Oj+J515SQVuJJH4p1jmyS5NEs9nXqR8qExyhvPhjm7ka/HrKG77o3MS0F
 7hijfdr4qYUQTGuK0lTaECipjA3875yLPsHC4EB0tB+xynBLCgMVx7JT6jFuddPDRtCkf8QdmaT L+aT5CFzJLRrfWA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
use-after-free type confusion flaws in the kernel for both read and
write primitives. Avoid having a user-controlled size cache share the
global kmalloc allocator by using a separate set of kmalloc buckets.

After a fresh boot under Ubuntu 23.10, we can see the caches are already
in use:

 # grep ^msg_msg /proc/slabinfo
 msg_msg-8k             0      0   8192    4    8 : ...
 msg_msg-4k            96    128   4096    8    8 : ...
 msg_msg-2k            64     64   2048   16    8 : ...
 msg_msg-1k            64     64   1024   16    4 : ...
 msg_msg-16          1024   1024     16  256    1 : ...
 msg_msg-8              0      0      8  512    1 : ...

Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
Link: https://zplin.me/papers/ELOISE.pdf [6]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
---
 ipc/msgutil.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index d0a0e877cadd..36f1aa9ea1cf 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -42,6 +42,15 @@ struct msg_msgseg {
 #define DATALEN_MSG	((size_t)PAGE_SIZE-sizeof(struct msg_msg))
 #define DATALEN_SEG	((size_t)PAGE_SIZE-sizeof(struct msg_msgseg))
 
+static struct kmem_buckets *msg_buckets __ro_after_init;
+
+static int __init init_msg_buckets(void)
+{
+	msg_buckets = kmem_buckets_create("msg_msg", 0, SLAB_ACCOUNT, 0, 0, NULL);
+
+	return 0;
+}
+subsys_initcall(init_msg_buckets);
 
 static struct msg_msg *alloc_msg(size_t len)
 {
@@ -50,7 +59,7 @@ static struct msg_msg *alloc_msg(size_t len)
 	size_t alen;
 
 	alen = min(len, DATALEN_MSG);
-	msg = kmalloc(sizeof(*msg) + alen, GFP_KERNEL_ACCOUNT);
+	msg = kmem_buckets_alloc(msg_buckets, sizeof(*msg) + alen, GFP_KERNEL);
 	if (msg == NULL)
 		return NULL;
 
-- 
2.34.1


