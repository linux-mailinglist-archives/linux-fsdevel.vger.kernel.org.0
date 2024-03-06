Return-Path: <linux-fsdevel+bounces-13784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1B2873EB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 19:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E171F1F21FD0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8170C142649;
	Wed,  6 Mar 2024 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UH0oAG14"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74522142640
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749498; cv=none; b=MrT+KUwtA0fZc/ZvCm9Qila4OxzNj3vuTeO0op0JMUPHd/Uu0LS84E/n6/vsbBzoybtGqjQWifVsgPlHdJ+hwEJJ2L7l9u60Jdp9AmXWMvNWglBXIIhB9xdjMZG6mW0Nsd7jmPYSdaX1sAmud5Qajg6xKx2xlcFHnx6XWu4GmJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749498; c=relaxed/simple;
	bh=2MiQKMe/NDzl6pEiZDlCs74kTpNPCZmby0N1uiwKZQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VYYxSJ4Wg/jMYScyj9kdUNCrJ4BphnV168gScvxEfPQefYSqZmGB1KgV+pFuprIj47xPSvbVSNy14eer74KV2K81XyE2E+Yt/KxnumUrP9HEWanAgGkU6PkTq6glCjtnuiLZgIKycMnpjH/qMBWvkDBE+T4ZnLN15WivXMIUQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UH0oAG14; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so11876686276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 10:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749495; x=1710354295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+1MAxDJuAJQyho1HAnRuoUycvJ4xPriHfVlSiFl1RY=;
        b=UH0oAG14r/rZeYHiVopJJ/Cl4/MRZjxyKxUTWxDo0a7ZXyaCecnxk5wBDfOibOCsSE
         QMaAB1eG8pZ+D7SPsDq80kDqc5ISfZo1qarJ15pbXwlQPwWmsxk0FQa/GYQAYEniXqH1
         15UXVxrQT1XxlKQ4S3l94D76cSwKK6ouplaYn8IS8FE9b4U6sPf29QfrzkprcQCZFxZi
         zaQANi3+IiuIwH5nZzIh5UazEn1C5vXHQna2i4J7rv5YLD21A+Wxf4b8EkGQpj5UkXUi
         IeGbXZzE5d65GmPQIFyn47xjGm4zPtS9H7qozVJ+Jfp9BZvio54MR0mNVddjQLCgb5g0
         m6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749495; x=1710354295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+1MAxDJuAJQyho1HAnRuoUycvJ4xPriHfVlSiFl1RY=;
        b=GuAw1XTer1vWnQvXuTIPz/uOw0uIJCiNCQnU0mQ/J3b8EqCMujTQ0hLgUPsxCNCT4P
         X7ZTH3INLR4wfb2dsuUsc1F0YMc2a83vAZMNPtE5dD3sbADYJ3mFJHih4aPavccla683
         Bo9iQ/qBspAn+lqGZ4znvaeuVhbXUhSUP/2RGh0ZYOSb5W36hl2RJrNcF+XkTiGWogli
         toBBenJhWj3tJss1dmsTbhweMHuoGhUq5TkPqp6Nk2bhn3jKHKoustyB1RRF2cFqzXLS
         4n2UEAwsLaFMLZ/9FhbH3Zxs0Kp5E/o6zyoxoky7rBaxfVoQeOtO61hrRRwkLChiVPmS
         KjFw==
X-Forwarded-Encrypted: i=1; AJvYcCU4NFCVQI1H1JRtdkoqcFpfihoxeLIiCz2t2MJ/KtODyEh59hiARc8ku6ZsNqvRsoDIgg030qDYd82TdqTZecm4y/G1OMymDVXEcT8MHw==
X-Gm-Message-State: AOJu0Yy1tAiLQXXSbSV/PmvKUP4QXyGA3DllPdtKiED5rSkmZ5F6iXH6
	LFjldCSvbc5AD2KKdIQNJ3v4KNFjWHqW6fWoKxFeqxXOdrLLnao5CglBqvVVvhVxilSD30xIqmF
	jew==
X-Google-Smtp-Source: AGHT+IEkw8OywS5NVn7/NXWRII+MpOBoDjeHrVnBsvvZCv8Bi13QwsyESjkt49rN57nFyogg4BGvGtr41mQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:1744:b0:dcf:6b50:9bd7 with SMTP id
 bz4-20020a056902174400b00dcf6b509bd7mr3993490ybb.7.1709749495639; Wed, 06 Mar
 2024 10:24:55 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:03 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-6-surenb@google.com>
Subject: [PATCH v5 05/37] fs: Convert alloc_inode_sb() to a macro
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/fs.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 023f37c60709..08d8246399c3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3010,11 +3010,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
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
2.44.0.278.ge034bb2e1d-goog


