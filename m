Return-Path: <linux-fsdevel+bounces-15495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9091188F4DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 02:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6F9299202
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 01:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F432110F;
	Thu, 28 Mar 2024 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lx/d2vmy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D1F1804A
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 01:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590374; cv=none; b=kAC6DIhPaAIegoAkxcuBA29YeXZM4FIcOUIRjaVg9yHv2k7YA7h8dLtbKRTlayqVHCjqgeWTEfepn0dmoIdl/WoWULsIJ8YkY3Cgv0yGWhMRL9IYtFm+0tDg1/et/z7DYuz7sn8W3tG+8eyRtSm+tS1ZJtcfKPn5mse+e76wJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590374; c=relaxed/simple;
	bh=8gVpEYf3/MqmqIMy67pUCkZ+6NWxbfiw0odjAgPZOMQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aM7UoqjKm04IH+OZZuEEV3WyZXvw/0mg0UnSKJ+t0/xK7AZhI2y95WZX8KAbInrGJWpLvoIcBiFDXSi7V1EiLk4Mt50eNa9yCG7JByS1gtIh+AJd7Dz3GxnLF/ssuIyEn6DF8AfE3ppua/M5OI8Obv4S2OwAH8q/s2Xs+VoG7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lx/d2vmy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=BrbF11gUH3tHllIge+gwrMR3gKWyWYIRrGwEa3L3Szw=; b=Lx/d2vmy09+wKa/MtYWq+gr41X
	or3PiOQQ0jtim9xxaXeCGNqV3JPhj1BiVzXWDs776IETXyZW5A8iEof306k9KRoiDvqYZ0hcSpHdc
	jDch+A87/siYqpVBBWHwDL+qD272JUlhaCxDFOEAuJfv5tC8Z+0Q6Jks0l1Mmdzwl++J8Aclpxgsa
	ZUS+gqIVS4Z/dH+7tCEpNYLLQek0qDrbnkYvnqjLs7SBiGA2Ztly5P+aMhzuNHPgOGU8ghloizwp5
	+djK/Rsy490Vgw+TYShXwZIiSm2oDbvkx5Gldc0VPK4ST1dMwxw4rQkDgRh87ROUAJg0FmmAWihBn
	XIPHhYDw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpeqI-00000005EZx-3gUi
	for linux-fsdevel@vger.kernel.org;
	Thu, 28 Mar 2024 01:46:10 +0000
Date: Thu, 28 Mar 2024 01:46:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: RFC: asserting an inode is locked
Message-ID: <ZgTL4jrUqIgCItx3@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I have this patch in my tree that I'm thinking about submitting:

+static inline void inode_assert_locked(const struct inode *inode)
+{
+       rwsem_assert_held(&inode->i_rwsem);
+}
+
+static inline void inode_assert_locked_excl(const struct inode *inode)
+{
+       rwsem_assert_held_write(&inode->i_rwsem);
+}

Then we can do a whole bunch of "replace crappy existing assertions with
the shiny new ones".

@@ -2746,7 +2746,7 @@ struct dentry *lookup_one_len(const char *name, struct den
try *base, int len)
        struct qstr this;
        int err;

-       WARN_ON_ONCE(!inode_is_locked(base->d_inode));
+       inode_assert_locked(base->d_inode);

for example.

But the naming is confusing and I can't think of good names.

inode_lock() takes the lock exclusively, whereas inode_assert_locked()
only checks that the lock is held.  ie 1-3 pass and 4 fails.

1.	inode_lock(inode);		inode_assert_locked(inode);
2.	inode_lock_shared(inode);	inode_assert_locked(inode);
3.	inode_lock(inode);		inode_assert_locked_excl(inode);
4.	inode_lock_shared(inode);	inode_assert_locked_excl(inode);

I worry that this abstraction will cause people to write
inode_assert_locked() when they really need to check
inode_assert_locked_excl().  We already had/have this problem:
https://lore.kernel.org/all/20230831101824.qdko4daizgh7phav@f/

So how do we make it that people write the right one?
Renaming inode_assert_locked() to inode_assert_locked_shared() isn't
the answer because it checks that the lock is _at least_ shared, it
might be held exclusively.

Rename inode_assert_locked() to inode_assert_held()?  That might be
enough of a disconnect that people would not make bad assumptions.
I don't have a good answer here, or I'd send a patch to do that.
Please suggest something ;-)

