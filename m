Return-Path: <linux-fsdevel+bounces-28676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC596D0F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E5CB220E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED906194149;
	Thu,  5 Sep 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUIzIhLb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8D019006E
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523024; cv=none; b=mzZKzs+IMi14F6lLXi3v9czlomZDvd9lK0kfZJES84E/uRmX/rL2Rwu4f8zEEOJhc0jmQ4TeFmvSeSGttPHCNGDdtP3g+vhrtxVnCdLVxltwbGgSEejFM+L8hrVA5ZyJ6+i9hbtqtrQxGg5RaCZs6RHv6mRwFlhv0fYLATcLQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523024; c=relaxed/simple;
	bh=BmsQjTGSfRDhmsoE1J1AfilYRU8gY8cnWKKMi7Hz+Xo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PLso30B0OKIj5OsJcNJ13GAQREEx4vxlxm83MHePOWnHetT2cQVf7ssSZqjcD7i0CuBVHHRwJlovM89pS19Gxt5TnAMtHpjtR4FchhlC4C/5/zL8H7Z7v0ee6Xnjyqe8jStobM8iKqw9eWa5adTzQH7E28i+3GBefBFjoRNPci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUIzIhLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFCCC4CEC3;
	Thu,  5 Sep 2024 07:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523023;
	bh=BmsQjTGSfRDhmsoE1J1AfilYRU8gY8cnWKKMi7Hz+Xo=;
	h=From:Subject:Date:To:Cc:From;
	b=RUIzIhLbUtgwRcSoD6rQn/ee5RVbJZNmn2VN+vTwV0PmAYVF7hMaDykpieG/V00Ua
	 wtbrjbGOtUF+JUR8Drd+7YFecOQlQP3AJzTuGOiXDKrls/252S/4GN6FWMnys5lrN5
	 Jr4Os/eAPrz4qJT4+SUtukqH9pRGvYm1v5uUlKLZmpQKUvWKkrlCWEklJn7v0z8itM
	 6ivzJ8uWKdJIf4fyotxowkcXco+KLuQGmbPc3ZZyoDxhFQMs40+7UEH8sxypO6SdzE
	 afW9M0m53q84SK41PhC1bq0tTBTjpnisC6RCuPdySNU8LNryOBbwi1BxTpwr38fxEE
	 cyPZsJohft4Sw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 00/17] slab: add struct kmem_cache_args
Date: Thu, 05 Sep 2024 09:56:43 +0200
Message-Id: <20240905-work-kmem_cache_args-v4-0-ed45d5380679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADtk2WYC/4XOQQrCMBAF0KtI1kam07QxrryHiKTptA3VViYSF
 endTV0pIi4/zH9/HiIQewpis3gIpuiDH4cU1HIhXGeHlqSvUxYIqMAAyuvIvexPdDo46zo6WG6
 DJKNLMBqdrpVI1TNT428vdrdPubKBZMV2cN2MxSasGn+k+bTz4TLy/fVAzObCn62YSZCoaygqB
 0WG621PPNBxNXIr5rGI70r+Q8Gk6LIxmoxVRQlfSv6uqB9KnhQo6gozbeza4YcyTdMTDuafCmA
 BAAA=
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Christoph Lameter <cl@linux.com>, 
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4355; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BmsQjTGSfRDhmsoE1J1AfilYRU8gY8cnWKKMi7Hz+Xo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdTPG6kH10lgWDahBb1mKbq5KK550O7P7xLGndO5810
 jsMdJnSO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay5A/D/9IZuyt5j8Wucdr7
 c23uhFWhSzYWMSrzeHybNrVp4zTlx/sZ/un2qfluX7x6cZLNS6sX2wySvsbG3zWa4X5x7ULtTRO
 /NjIAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

This is v4 which allows NULL to be passed in the struct kmem_cache_args
argument of kmem_cache_create() and substitutes default parameters in
this case.

As discussed last week the various kmem_cache_*() functions should be
replaced by a unified function that is based around a struct, with only
the basic parameters passed separately.

Vlastimil already said that he would like to keep core parameters out
of the struct: name, object size, and flags. I personally don't care
much and would not object to moving everything into the struct but
that's a matter of taste and I yield that decision power to the
maintainer.

In the first version I pointed out that the choice of name is somewhat
forced as kmem_cache_create() is taken and the only way to reuse it
would be to replace all users in one go. Or to do a global
sed/kmem_cache_create()/kmem_cache_create2()/g. And then introduce
kmem_cache_setup(). That doesn't strike me as a viable option.

If we really cared about the *_create() suffix then an alternative might
be to do a sed/kmem_cache_setup()/kmem_cache_create()/g after every user
in the kernel is ported. I honestly don't think that's worth it but I
wanted to at least mention it to highlight the fact that this might lead
to a naming compromise.

However, I came up with an alternative using _Generic() to create a
compatibility layer that will call the correct variant of
kmem_cache_create() depending on whether struct kmem_cache_args is
passed or not. That compatibility layer can stay in place until we
updated all calls to be based on struct kmem_cache_args.

From a cursory grep (and not excluding Documentation mentions) we will
have to replace 44 kmem_cache_create_usercopy() calls and about 463
kmem_cache_create() calls which makes for a bit above 500 calls to port
to kmem_cache_setup(). That'll probably be good work for people getting
into kernel development.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v4:
- Allow NULL to be passed in the struct kmem_cache_args argument of
  kmem_cache_create() and use default parameters in this case.
- Link to v3: https://lore.kernel.org/r/20240904-work-kmem_cache_args-v3-0-05db2179a8c2@kernel.org

Changes in v3:
- Reworded some commit messages.
- Picked up various RvBs.
- Added two patches to make two functions static inline.
- Link to v2: https://lore.kernel.org/r/20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org

Changes in v2:
- Remove kmem_cache_setup() and add a compatibility layer built around
  _Generic() so that we can keep the kmem_cache_create() name and type
  switch on the third argument to either call __kmem_cache_create() or
  __kmem_cache_create_args().
- Link to v1: https://lore.kernel.org/r/20240902-work-kmem_cache_args-v1-0-27d05bc05128@kernel.org

---
Christian Brauner (17):
      slab: s/__kmem_cache_create/do_kmem_cache_create/g
      slab: add struct kmem_cache_args
      slab: port kmem_cache_create() to struct kmem_cache_args
      slab: port kmem_cache_create_rcu() to struct kmem_cache_args
      slab: port kmem_cache_create_usercopy() to struct kmem_cache_args
      slab: pass struct kmem_cache_args to create_cache()
      slab: pull kmem_cache_open() into do_kmem_cache_create()
      slab: pass struct kmem_cache_args to do_kmem_cache_create()
      slab: remove rcu_freeptr_offset from struct kmem_cache
      slab: port KMEM_CACHE() to struct kmem_cache_args
      slab: port KMEM_CACHE_USERCOPY() to struct kmem_cache_args
      slab: create kmem_cache_create() compatibility layer
      file: port to struct kmem_cache_args
      slab: remove kmem_cache_create_rcu()
      slab: make kmem_cache_create_usercopy() static inline
      slab: make __kmem_cache_create() static inline
      io_uring: port to struct kmem_cache_args

 fs/file_table.c      |  11 ++-
 include/linux/slab.h | 130 +++++++++++++++++++++++++++------
 io_uring/io_uring.c  |  14 ++--
 mm/slab.h            |   6 +-
 mm/slab_common.c     | 197 +++++++++++----------------------------------------
 mm/slub.c            | 162 +++++++++++++++++++++---------------------
 6 files changed, 250 insertions(+), 270 deletions(-)
---
base-commit: 6e016babce7c845ed015da25c7a097fa3482d95a
change-id: 20240902-work-kmem_cache_args-e9760972c7d4


