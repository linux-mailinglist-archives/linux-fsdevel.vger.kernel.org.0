Return-Path: <linux-fsdevel+bounces-51697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 781A9ADA4D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 01:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDD5188DC86
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 23:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D0C27FB21;
	Sun, 15 Jun 2025 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QZjcwLlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F1A7E1;
	Sun, 15 Jun 2025 23:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750031841; cv=none; b=q6q/17TSSQP/9QSbqR8FiaMkXmLkE88K04G12ldKWFWSTQ7M1q2Z1PiNzfrZkfWdpDCwn6UKVZz0GpYab6tZuGGc8SO1/gCFe6tqvK8XNbDlLuB1LwI04gq08ZhGRzWh7vA8jAi5Mm1VkET1Py0AkFuucZt2kLsWbiR9h69KVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750031841; c=relaxed/simple;
	bh=byX1f1dZRbl29B8BdxYZupOapNpkLCC/0FnbdlTcNsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8ZjvjVpqc2EtJfBpiocTKdCEmq8w8EbMn5xVZaB9qt2PtGFD1VR9Edobm+7x6a2TxPGGO8t/lxmI5dLBZu/0FSrIT4ymeNfvyl6iNBwe7esi7UTBB3bQpCiOD7zWTWcWvN/gJYeGjgNhFDvCJXi9jgzSWdHFwJDK8Od3VrMssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QZjcwLlI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FhOAn+uY6L2AKbDaoJUOAfIvUBSz9ordgDTmYEGaNJE=; b=QZjcwLlI+ui6Vmjs2MoEYz0N5d
	uXI34zi9S5ZJEhbmg3HRtpnZYidcwSRziEKnrV0NZoZlZ7YLFvrUGmemP11F7FMD8iywd7zKuGojU
	+DL2bj5suZ6k3Wb86QBfnp8v8rMa0StuY/uGXOxnWUyozHYu5DA+vsR00LYzKGlq9dzA2TlEaNggo
	DR4mTqA5C8SOkyqpg/uPJpzSkMhgeFHkWSNN3BA225z1Z+4uSgWwHewyt0GN0BiRvuj236QQeWQq8
	L9XBx4fjzTiiBmcshN/nSh5xdKeH2y2ohHWt6XkXf2we3pZdr0Rq/KEcuPukxgKMtNq0UY9+ivn+L
	hGKUnuaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQxDu-00000008gXo-3si5;
	Sun, 15 Jun 2025 23:57:15 +0000
Date: Mon, 16 Jun 2025 00:57:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3?] proc_sysctl: remove rcu_dereference() for accessing
 ->sysctl
Message-ID: <20250615235714.GG1880847@ZenIV>
References: <175002843966.608730.14640390628578526912@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175002843966.608730.14640390628578526912@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 16, 2025 at 09:00:39AM +1000, NeilBrown wrote:
> 
> The rcu_dereference() call in proc_sys_compare() is problematic as
> ->d_compare is not guaranteed to be called with rcu_read_lock() held and
> rcu_dereference() can cause a warning when used without that lock.
> 
> Specifically d_alloc_parallel() will call ->d_compare() without
> rcu_read_lock(), but with ->d_lock to ensure stability.  In this case
> ->d_inode is usually NULL so the rcu_dereference() will normally not be
> reached, but it is possible that ->d_inode was set while waiting for
> ->d_lock which could lead to the warning.

Huh?

There are two call sites of d_same_name() in d_alloc_parallel() - one
in the loop (under rcu_read_lock()) and another after the thing we
are comparing has ceased to be in-lookup.  The latter is under ->d_lock,
stabilizing everything (and it really can't run into NULL ->d_inode
for /proc/sys/ stuff).

->d_compare() instances are guaranteed dentry->d_lock or rcu_read_lock();
in the latter case we'll either recheck or validate on previously sampled
->d_seq.  And the second call in d_alloc_parallel() is just that - recheck
under ->d_lock.

Just use rcu_dereference_check(...., spin_is_locked(&dentry->d_lock)) and
be done with that...

The part where we have a somewhat wrong behaviour is not the second call
in d_alloc_parallel() - it's the first one.  Something like this

static int proc_sys_compare(const struct dentry *dentry,
		unsigned int len, const char *str, const struct qstr *name)
{
	struct ctl_table_header *head;
	struct inode *inode;

	if (name->len != len)
		return 1;
	if (memcmp(name->name, str, len))
		return 1;

	// false positive is fine here - we'll recheck anyway
	if (d_in_lookup(dentry))
		return 0;

	inode = d_inode_rcu(dentry);
	// we just might have run into dentry in the middle of __dentry_kill()
	if (!inode)
		return 1;
	head = rcu_dereference_check(PROC_I(inode)->sysctl,
				     spin_is_locked(&dentry->d_lock));
	return !head || !sysctl_is_seen(head);
}

