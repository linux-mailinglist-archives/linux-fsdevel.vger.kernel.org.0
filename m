Return-Path: <linux-fsdevel+bounces-22548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750E3919982
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 22:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF7D1C22993
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 20:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8CA19306C;
	Wed, 26 Jun 2024 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ceuTxQ/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C318F47;
	Wed, 26 Jun 2024 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435513; cv=none; b=jbD5H0Yg4XMUZ0mMQfF2jyEZRII+Q4LSCN0Q4VhFcpU/Ers7W9Fvcfx/NhmOE/afw3Y5x1kGxvcTlTpzYP01tjlh04596BDYXcvuPqmVLDIxLP/bx4A69yHnk95DQ30szKbkHc++vcdptcGUg+icKOTeLM/e8H3FBmSJDkoisAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435513; c=relaxed/simple;
	bh=vxaWm6X+qLvNR4QlKOtgr7+v41S1s7pqPxwviRSyfOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmCg07j8a88OGLM28XbuSzLiXRCUvgpfTPIwZCiy35CmE7dQ6hJanPImznsxzeRerTzkSKXPK/d3wqs7p0Iy5NLZzhecwu1sTPqb4e0CsUoemRHJihS8cC20N8oH4tMPcccLn0FFxpV1OLOvEHMuGNppaofBi6HLono2KpvwrnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ceuTxQ/x; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uDRSce5rSm5u/am9DBIrk4Pvd4TX43Q7URwrbJgZ+e4=; b=ceuTxQ/xGyMOS9IH9ZnldBunnQ
	5DRI4a3ZJ0KIqq+LTMuSauC+j7Cbpq9O1hw2+ZfOOQ3ktB6nf3OPzCa4S0ZUEliK/EtFesIiV6MN4
	YPrwas+gEjwUVw4Hx94GpRC51J0o8Xt1Gzx0vdgBcM8KBoZtfIpHyBX+o9dN/8DypwN2BINjRS9Bf
	HDDomFBf+11s1RX0iErAdToTwHzpqcUvnZPp+kXQ4rF8dYmiCgWrryhSuugdbIw8z0SnMBfP3nWRJ
	Dy1n7uLlZc6fV45Tma1YTKNApWrA4RnGUYUADQhmPyZvht3qeKOmPhUyehRgSxnCnuMtCVwPqgm6Z
	CGUalX4A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMZY0-0000000ClIS-3XLN;
	Wed, 26 Jun 2024 20:47:20 +0000
Date: Wed, 26 Jun 2024 21:47:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lucas Karpinski <lkarpins@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexander Larsson <alexl@redhat.com>,
	Eric Chanudet <echanude@redhat.com>, Ian Kent <ikent@redhat.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Message-ID: <Znx-WGU5Wx6RaJyD@casper.infradead.org>
References: <20240626201129.272750-2-lkarpins@redhat.com>
 <20240626201129.272750-3-lkarpins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626201129.272750-3-lkarpins@redhat.com>

On Wed, Jun 26, 2024 at 04:07:49PM -0400, Lucas Karpinski wrote:
> +++ b/fs/namespace.c
> @@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
>  static DECLARE_RWSEM(namespace_sem);
>  static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> +static bool lazy_unlock = false; /* protected by namespace_sem */

That's a pretty ugly way of doing it.  How about this?

+++ b/fs/namespace.c
@@ -1553,7 +1553,7 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
-static void namespace_unlock(void)
+static void __namespace_unlock(bool lazy)
 {
        struct hlist_head head;
        struct hlist_node *p;
@@ -1570,7 +1570,8 @@ static void namespace_unlock(void)
        if (likely(hlist_empty(&head)))
                return;
 
-       synchronize_rcu_expedited();
+       if (!lazy)
+               synchronize_rcu_expedited();
 
        hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
                hlist_del(&m->mnt_umount);
@@ -1578,6 +1579,11 @@ static void namespace_unlock(void)
        }
 }
 
+static inline void namespace_unlock(void)
+{
+       __namespace_unlock(false);
+}
+
 static inline void namespace_lock(void)
 {
        down_write(&namespace_sem);
@@ -1798,7 +1804,7 @@ static int do_umount(struct mount *mnt, int flags)
        }
 out:
        unlock_mount_hash();
-       namespace_unlock();
+       __namespace_unlock(flags & MNT_DETACH);
        return retval;
 }
 

(other variants on this theme might be to pass the flags to
__namespace_unlock() and check MNT_DETACH there)

