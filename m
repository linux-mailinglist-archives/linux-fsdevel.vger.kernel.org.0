Return-Path: <linux-fsdevel+bounces-28388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E40296A03E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0889C1F23ECD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200BA6F2E3;
	Tue,  3 Sep 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXg9pTFQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFCC4AEE5
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373343; cv=none; b=kZS8VU/mVH9iE0ZRVcaJoQt04lGzIyJNt0W0YtsUjGEDLjVaziclo8UWNeS6LpX/xvyqOqrvD3Zfu1wn2tEPv7Qok5iMALOqXr3za9CweOJXoM/wcMVY3gY3gEJJJ8pYWqgNjUppvueW/0XDx5tATGlEB56NWK8vzsYGfvo1E30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373343; c=relaxed/simple;
	bh=/5+W8BUQgxXjxU+Pa51Xbo+dm4yfnXGJFSuXL945Ubw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X9tz7tIP1IpZ+6MxDfCpgrqyiRg6ElLlvkbOk8Ea67FWYm/nP6FMfm3F5ay8EaiaShX866/1+BECHMJ1OTbmRh7CWJ8x5JEULap5XZsba7GECj1i6U7l/8vlysdD68sRPOtgRxVrPMBqW/rMc9NwUDLBFdRS7WbUuqcFUo5d5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXg9pTFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375FDC4CEC4;
	Tue,  3 Sep 2024 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373343;
	bh=/5+W8BUQgxXjxU+Pa51Xbo+dm4yfnXGJFSuXL945Ubw=;
	h=From:Subject:Date:To:Cc:From;
	b=aXg9pTFQ8zcmMViTrn/8DMUlrjtw5eatUvN7vHL7oRI8/qfVhhsukABvdadkxiD0A
	 KxfpHs9gdoY6ul9XWaRpdoiOCRMkUo1r72DnX3nmAi7UrvYOYTxVbzBJQhdoRXD8w+
	 4c7cwSWO0/i2Gsfw3lWni0ljKtF5MBqODkUj9btxutL/+vKcQshBlCgUMwCOF/e7Cq
	 RLNNBXk+BsmypR4OI7RPYbmL/0lc6TSlGfbfL053IXpw2RFUbmCdr1PQbdirQVbRJz
	 WcRVtWaphLC/5sISZbrA5k3yFj5ZChH732nwp3GEC5ao2SpxtYKeza8zWjna4EooJB
	 U1AII108MmE0g==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/15] slab: add struct kmem_cache_args
Date: Tue, 03 Sep 2024 16:20:41 +0200
Message-Id: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADob12YC/4WOQQqDMBREryJZNxKDNrUr71FEYvyaj5qUn5K2i
 Hdv9AJdPph5MxsLQAiB3bONEUQM6F0CecmYsdpNwHFIzKSQpaiF5G9PM59XWDujjYVO0xQ41Oo
 qaiWNGkqWqk+CET+n9tEm7nUA3pN2xh6yOIZ8xAWOqMXw8vQ9D8TiKPzZigUXXKpBVL0RVSFvz
 QzkYMk9Tazd9/0Ho6aZldQAAAA=
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Jann Horn <jannh@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3587; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/5+W8BUQgxXjxU+Pa51Xbo+dm4yfnXGJFSuXL945Ubw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdl54typIQP/+OXdzHTV/PyJ6ab3LPecXNTO6/Ck5Cg
 fM5Tomyd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEv4nhf+acR1+UFWTLLbQl
 5zMEzfWxa4iTW1o/cX/qum2zeX84BTP801BnXT7ncNOOyb2JK1+JfTStvTXtYfnNzUE3zzFWz7T
 NYwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

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
Changes in v2:
- Remove kmem_cache_setup() and add a compatibility layer built around
  _Generic() so that we can keep the kmem_cache_create() name and type
  switch on the third argument to either call __kmem_cache_create() or
  __kmem_cache_create_args().
- Link to v1: https://lore.kernel.org/r/20240902-work-kmem_cache_args-v1-0-27d05bc05128@kernel.org

---
Christian Brauner (15):
      sl*b: s/__kmem_cache_create/do_kmem_cache_create/g
      slab: add struct kmem_cache_args
      slab: port kmem_cache_create() to struct kmem_cache_args
      slab: port kmem_cache_create_rcu() to struct kmem_cache_args
      slab: port kmem_cache_create_usercopy() to struct kmem_cache_args
      slab: pass struct kmem_cache_args to create_cache()
      slub: pull kmem_cache_open() into do_kmem_cache_create()
      slab: pass struct kmem_cache_args to do_kmem_cache_create()
      sl*b: remove rcu_freeptr_offset from struct kmem_cache
      slab: port KMEM_CACHE() to struct kmem_cache_args
      slab: port KMEM_CACHE_USERCOPY() to struct kmem_cache_args
      slab: create kmem_cache_create() compatibility layer
      file: port to struct kmem_cache_args
      slab: remove kmem_cache_create_rcu()
      io_uring: port to struct kmem_cache_args

 fs/file_table.c      |  11 +++-
 include/linux/slab.h |  60 ++++++++++++++-----
 io_uring/io_uring.c  |  14 +++--
 mm/slab.h            |   6 +-
 mm/slab_common.c     | 150 +++++++++++++++++++----------------------------
 mm/slub.c            | 162 +++++++++++++++++++++++++--------------------------
 6 files changed, 203 insertions(+), 200 deletions(-)
---
base-commit: 6e016babce7c845ed015da25c7a097fa3482d95a
change-id: 20240902-work-kmem_cache_args-e9760972c7d4


