Return-Path: <linux-fsdevel+bounces-28513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C15296B830
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4481F21677
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBBB1CCB24;
	Wed,  4 Sep 2024 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwZWd2oK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11AA198825
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445311; cv=none; b=qxfL2TEggkhdKsOohgVLTO0O0QdnaxPnoy+9YY5ASjYYNLZvo+4w1Mb/HERemE2bjpnBKmDCYybdbwrX3SKOw9OREBDi4kpnhdbXwv2iwDY6WA/eFspAKvUxrUzYedW5aZzWgdqU5YSAMUR6aTSPwtv4OkgI5NNGNGmdL1fqdjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445311; c=relaxed/simple;
	bh=qpIaXZ9wpnw8HqkV16+tOm664xAQ9ILaft0Wsy1nwYA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rJfByD/rMSGWSzaNGriH4U7kQi8QhJTnlaIs3p2//FZp93WeHHOmbO1EyynvO/mK8KijdHe0lBkvgio6HtMuobuMqoWoFyfyddbJpuDG8oDrJ8F7wpmaSb4XOp/RJSqvnEXMXDELkZCDOEaTa2Gc3zaGIOcDsDhU1TYfCraVb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwZWd2oK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E095AC4CEC8;
	Wed,  4 Sep 2024 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725445311;
	bh=qpIaXZ9wpnw8HqkV16+tOm664xAQ9ILaft0Wsy1nwYA=;
	h=From:Subject:Date:To:Cc:From;
	b=iwZWd2oKEolnEt3tXTv1Dn5n2m5rHaf5jeju8Z8DJElivkZtOJPAQGkRGhZ8OY6Pv
	 SkHv3TaWERBrAO0uNAxUI2jrS6IJFzh6mlYTX0oCBEQp7cxmKFty2uM1eFZ2QZcWi4
	 SB6urPwuWsqRu5l3qOr8mXNsokVhuHg5RRdvqWcH/zGypWmFHB6OxgKgebbR9+c5pX
	 u+7cSQx5rK0HsDdIps/a411Q1/ngnNMn4wii7gmrnOT7+KD8tdnhPP0kG4kXqIjLFv
	 /SMf8r7ZytrIK77ldRiFjdIw7TtcDvobUdx2YcZdPKDAHuv9fh30wuzl4e1Q2F+whp
	 cmHoLeK4U3COg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 00/17] slab: add struct kmem_cache_args
Date: Wed, 04 Sep 2024 12:21:05 +0200
Message-Id: <20240904-work-kmem_cache_args-v3-0-05db2179a8c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJE02GYC/4XOyw7CIBAF0F9pWEtD6QNx5X8Y01A6tKQvMxjUN
 P13oStdGJc3mXvurMQBWnDklKwEwVtnlzmE/JAQ3au5A2rbkAlnvGCScfpYcKDDBFOtle6hVtg
 5ClJUTAquRVuQUL0hGPvc2cs15EY5oA2qWfcR88alxo4QT3vr7gu+9gd8Fgt/tnxGGeWiZWWjW
 Znx43kAnGFMF+xIHPP8U8l/KDwoojJSgFRFWbEvZdu2N8aVVMYaAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4620; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qpIaXZ9wpnw8HqkV16+tOm664xAQ9ILaft0Wsy1nwYA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTdMNnJ3HaRT2CXsmvP111VPlJ7X6VsVNB4c7rge/bnm
 4cvJVTLd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk0W6GvxJv/PTnZVuoCQRd
 L1i4e2/YhXk/tV32dB4+Xnzm172S7I2MDEuTznDemXEsOld9/5mJ86/KcTEyFTsd7HBlb97UUDZ
 fgh0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

No meaningful changes in v3. This is mostly to make it easy for
Vlastimil to pull.

---
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

To: Vlastimil Babka <vbabka@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
To: Jann Horn <jannh@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>

---
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
 include/linux/slab.h | 116 ++++++++++++++++++++++++------
 io_uring/io_uring.c  |  14 ++--
 mm/slab.h            |   6 +-
 mm/slab_common.c     | 197 +++++++++++----------------------------------------
 mm/slub.c            | 162 +++++++++++++++++++++---------------------
 6 files changed, 236 insertions(+), 270 deletions(-)
---
base-commit: 6e016babce7c845ed015da25c7a097fa3482d95a
change-id: 20240902-work-kmem_cache_args-e9760972c7d4


