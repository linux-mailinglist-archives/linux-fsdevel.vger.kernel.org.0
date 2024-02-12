Return-Path: <linux-fsdevel+bounces-11194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00176851FF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B47B24820
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FCC4F1EB;
	Mon, 12 Feb 2024 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McIt7N6Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7204E1C5
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773982; cv=none; b=nlG0Aa5YwS30TAGyWxpdsT6E4kYoXuDM3G8r1a2KX2NNAWREOzM+vLKhl96601nqr9kttZmiChN1v8KwTfRBA5Fp1pHCqM1ggXhon44d5hAozGBh3VBennn84fwrioG+JPRxWQ9sFfyAGyKd8067XbjwyF87pUhK+VPyQdcL5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773982; c=relaxed/simple;
	bh=whDe+q0F2iw/LKcrylpqxuIepYX/P89tJ5PMvrLDnWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AS/w6dk1aElBa4+sYgEa8TniFQvjvpGY5Qd+9S3WzmNwQUz1aEZQeq9Xc7SCF2YBSs6nM0PgjV/QgLMCeSt8QwV/DqoQKaSiStkCdFp0FKf9h5b2xsj8F53znoNAa4PQGmczIE31+l/noOPutusToKhWydnlKsKajUnIQ74q2CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McIt7N6Y; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so4996018276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707773979; x=1708378779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DoSimaxvysC1tsWvSL78khESKiClPBlBlt51p8Cfztk=;
        b=McIt7N6Y1l6SM0zWWXAAPQXrEOzX0tCunh+LzgR9/THuZZ8itogP4ZQQMeJdNa48Rp
         Br3gQPIUmgat8qZgImWGS/CgXc3Sj+vJE3ILc39mgJU6r/AXtp8MmvyjDzEY8FEfKvYb
         Q3blquE22ysaO9MZi2aR72n74GkgEJhPPuHF4ocTj0aqd4zxLG9JX2U7IAjv2kBShlLJ
         3RJC/4OdNpIlCGxQjQE6opWQfvb+m/N2KJbxfTjlZ7U4ye2it/N7oA0eec/Na158xAGe
         nNi//WoXepqSR+oTAL9o8V6X+aie5WSmwa32rDeUfRwj9WK0YC+h8CJ8pUOcO9X/Reku
         f2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773979; x=1708378779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoSimaxvysC1tsWvSL78khESKiClPBlBlt51p8Cfztk=;
        b=CWS96zweHK4fqEVhwzHZsapaOY/xqbiximZnrh0/Qgx0YeYOIhfEcmIrqpcRecjQsJ
         MhoJNGE6Oy5U3G6kSo6SPqbeWt0Gw1r5+216CRJ02e+3qG2SVw+bzIVWvWRJYegFZ17s
         P5fPSZ87CALErGVuM17EdyY89WGo67ZnXphfYHuucE5IMhiMhSjrgFJ9yFgwzqyW8/LR
         wgYX9QUgImSiL08YUA/4Nvv1eCszuxR4L6IkUcPL+ZIL6P/RRzmnPjkXOkiq+53jf52H
         NwUUBtqnUT0ksMTIC0PUIBpKsekvy/Iko6ysIDLOJOzteEvIRsZMIUQNbLsczz6LxoEE
         082w==
X-Gm-Message-State: AOJu0Yxdk56wMJjb0WsA4FzGtnzmIuz3ReFRe+/HOzwlp7MZP+3wX64+
	YFTE3BUD+lTC1NWJSgStJPHdU0hYiGOdlfC9JDT6YLdB5abnDUs4SIJsYpamRPCOAzHIvIB3qOn
	AaQ==
X-Google-Smtp-Source: AGHT+IHrMi+yJjCe9l2fRgqlZ6eFfFd+JGnX1MN85wktYNynWGXKMQ9Jg1QyNSwk5gH8+cU1DTAXQiWqo+k=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b848:2b3f:be49:9cbc])
 (user=surenb job=sendgmr) by 2002:a05:6902:1005:b0:dcb:c2c0:b319 with SMTP id
 w5-20020a056902100500b00dcbc2c0b319mr80854ybt.9.1707773978951; Mon, 12 Feb
 2024 13:39:38 -0800 (PST)
Date: Mon, 12 Feb 2024 13:38:49 -0800
In-Reply-To: <20240212213922.783301-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212213922.783301-4-surenb@google.com>
Subject: [PATCH v3 03/35] fs: Convert alloc_inode_sb() to a macro
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

We're introducing alloc tagging, which tracks memory allocations by
callsite. Converting alloc_inode_sb() to a macro means allocations will
be tracked by its caller, which is a bit more useful.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 include/linux/fs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..7794b4182bac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3013,11 +3013,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
  * This must be used for allocating filesystems specific inodes to set
  * up the inode reclaim context correctly.
  */
-static inline void *
-alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
-{
-	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
-}
+#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
-- 
2.43.0.687.g38aa6559b0-goog


