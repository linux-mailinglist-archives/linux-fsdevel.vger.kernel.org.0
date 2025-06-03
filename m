Return-Path: <linux-fsdevel+bounces-50535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF572ACD026
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8DF3A5DFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54D1B4240;
	Tue,  3 Jun 2025 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OQaUkQ2A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB320D4F2
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992505; cv=none; b=l9uDsDB84T6cI7F65B+t/nZ9sdRiFbMmyg84ZjBmQ/U7xO4Hm7snzJcC3PnB/JibOnB5oWVggd3MFzD1Jlo4461dyTQkHylxdXKHaKvvQyDzGA2RZir413D4B2ExVQoClsE+GuJCZo2FRLQoLaMKLckGigREf9sat3MQyU04tvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992505; c=relaxed/simple;
	bh=v/qxAjnqtGPa+MIz50PL2tEj0U2KV6LoJ6F7E7lPNm4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NN+ByrRNY46F3QfTbWEOsJKObMF43enmhTLtaGV2wEBINOGZ9sTYxWMNj897CJt0qetnBIC0MA24rjWnQ3LWZld1txLNp0YwRqAee6T3tsZyVUt3v3eJjADCTaqEtkODzuyyDReyk3PzTx6BWABcuUtCdQX2ROWYV+9Y0iaC1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OQaUkQ2A; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KJbx/tbRzqFFeMTr6myslDOICEwVnvLR7sGih+DU4jo=; b=OQaUkQ2AgLnE9NdPJtxHwnX7k8
	ssYQhVkx1T8dvwlmxsRe7rX/qIIzpciZUL2vBIErKIakjar5eA745Tp2VXp3nkTY2Ch2OquMoWTS6
	HcWezSnyNUHJwStiU+7ad/xkj4olk6yq3SROsefjrZCEbjwsCoaqSbaDn6ANt4oN7Ekf3cxYaa5a0
	9UuKJaHcwLBmTmhadNsfMZQOABn+FhoHzu5iK1D36+sc7lq35pWGBO4j8W8N3gEeEoAdXk4auABgK
	NtJ59SHGjCDUay6O9GDNrIfcHB07v1iPvmC+zTWIhUwA57GTsX7t5qcYlxsumoS1qh3KwnXgaXaW3
	+GkXE6LA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMaqS-00000000bmh-1NVn;
	Tue, 03 Jun 2025 23:15:00 +0000
Date: Wed, 4 Jun 2025 00:15:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCHES][CFR] vfs fixes
Message-ID: <20250603231500.GC299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Fixes for assorted bugs caught by struct mount audit.
This stuff sits in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #fixes

Please, review; I'm going to push those to Linus in a few days.

Individual patches in followups.

1) fs/fhandle.c: fix a race in call of has_locked_children()
	traversing the list of children without mount_lock; oopsable,
present since v6.11.
2) path_overmount(): avoid false negatives
	namespace_sem is not enough to prevent false negatives from
__lookup_mnt(); rcu_read_lock() makes it memory-safe, but mount_lock
seqretry is needed for valid result.  Present since _way_ back -
predates path_overmount(), actually.  Originally introduced in v5.7
3) finish_automount(): don't leak MNT_LOCKED from parent to child
	MNT_LOCKED is incompatible with MNT_SHRINKABLE and such
combinations had been prevented from the very beginning; unfortunately,
one case got missed - automount triggered within an MNT_LOCKED mount.
Goes all the way back to v3.12...
4) fix propagation graph breakage by MOVE_MOUNT_SET_GROUP move_mount(2)
	In case when old mount both receives and transmits mount events,
do_set_group() end up corrupting the data structures.  Introduced in
v5.15
5) fs: allow clone_private_mount() for a path on real rootfs
	v6.15 introduced a way to use locations in detached
trees as overlayfs layers; unfortunately, the way it had
been done ended up breaking something that used to be allowed -
using locations on initramfs as overlayfs layers.  Turns out
that people really used such setups...

