Return-Path: <linux-fsdevel+bounces-33052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98639B2EBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 12:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070701C21A2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 11:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AA21DE3D3;
	Mon, 28 Oct 2024 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qenSMJHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC61DAC9F
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114253; cv=none; b=IYVkUDKuLM0jeMGCeb+vguul0rbXajXKbc8Hz8k2LOf29ulpqxU+yIVrK1BTK3NeT0SumMH6ujqOULJ+2d2S4J1EnzhTr0j71NQLq9VwnJTRu18ixxvavJG0dJsDhzNqx+hACw6z90wEDb3ms5Ka8YOG8c2jnyqteJerTio/dEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114253; c=relaxed/simple;
	bh=AhE0XU7YR1nPO3cOTAjS3DaJqlWoNSfy7ovg/oMuF8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC+p4CjdJAe8VtDjPXA9ZqArGzcMq7E8djMnF/NlcsEQxRfPGb2miyCfYF31ASKV4dGA9uktl3Ey/zF/0yY3zAfXUG4ErNxtjD1qhvQZS0NlFVK/34lGSXe74PjMlui+OV3b92FeRxp/W4WoQPZl9ojYd/7iWeDk5fcIb32rTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qenSMJHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E3AC4CEC3;
	Mon, 28 Oct 2024 11:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730114252;
	bh=AhE0XU7YR1nPO3cOTAjS3DaJqlWoNSfy7ovg/oMuF8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qenSMJHog+QqMvSpN5t+K+zmZLD4Ez/ecOe7YmP6L9K3J3iPqnRhP8Bsc+/l0xj9u
	 o22C1y4PFmwi5IpS9t0g8Q7/yktUceMWW0PzjTq08XnJyZjtC89QJBpObWS3h8zl0r
	 zfBbZR6hlIfLy/92CtMDARC+Aj0PBPNC7IFtrojht13NJFKDuzC/bW79lMAA2lEWss
	 4LtYvoziyaJnDt6uL5l3whCDarPew+DSt45modfAAbxp7S0AMOiGYo6kSJikeljPDc
	 WrK0QuWMfhqMTTgB9/UstO+Ini2WgUQ8UVv08UCkezfiGkZYk9kWmI8ZYOkDcyHgxy
	 xukX+LLtWYiMw==
Date: Mon, 28 Oct 2024 12:17:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/3] fs: port files to file_ref
Message-ID: <20241028-umschalten-anzweifeln-e6444dee7ce2@brauner>
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
 <20241007-brauner-file-rcuref-v2-3-387e24dc9163@kernel.org>
 <CAG48ez045n46OdL5hNn0232moYz4kUNDmScB-1duKMFwKafM3g@mail.gmail.com>
 <CAG48ez3nZfS4F=9dAAJzVabxWQZDqW=y3yLtc56psvA+auanxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez3nZfS4F=9dAAJzVabxWQZDqW=y3yLtc56psvA+auanxQ@mail.gmail.com>

> Actually, thinking about this again, I guess there's actually no
> reason why you'd need a constructor function; if you just avoid
> memset()ing the refcount field on allocation, that'd be good enough.

Thanks for catching this. So what I did is:

diff --git a/fs/file_table.c b/fs/file_table.c
index 5b8b18259eca..c81a47aea47f 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -148,10 +148,14 @@ static int __init init_fs_stat_sysctls(void)
 fs_initcall(init_fs_stat_sysctls);
 #endif

+static_assert(offsetof(struct file, f_ref) == 0);
+
 static int init_file(struct file *f, int flags, const struct cred *cred)
 {
        int error;

+       memset(f + sizeof(file_ref_t), 0, sizeof(*f) - sizeof(file_ref_t));
+
        f->f_cred = get_cred(cred);
        error = security_file_alloc(f);
        if (unlikely(error)) {
@@ -209,7 +213,7 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
                        goto over;
        }

-       f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
+       f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
        if (unlikely(!f))
                return ERR_PTR(-ENOMEM);

@@ -243,7 +247,7 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
        struct file *f;
        int error;

-       f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
+       f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
        if (unlikely(!f))
                return ERR_PTR(-ENOMEM);

@@ -270,7 +274,7 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
        struct backing_file *ff;
        int error;

-       ff = kmem_cache_zalloc(bfilp_cachep, GFP_KERNEL);
+       ff = kmem_cache_alloc(bfilp_cachep, GFP_KERNEL);
        if (unlikely(!ff))
                return ERR_PTR(-ENOMEM);


