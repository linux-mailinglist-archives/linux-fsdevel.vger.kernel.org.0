Return-Path: <linux-fsdevel+bounces-48545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12760AB0D1F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6983AB973
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8F12741A5;
	Fri,  9 May 2025 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QnGU+K9D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC6270ECE
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746779193; cv=none; b=j7mR7QhHpdUnVSyio7jf3FbpaL4tQLtYx8SHkmgzqbYMyJnjwOpHqwwwSB+7SKs7o4/JtXoRDcPtyLrE/0tng7Sajh8SKMBeMiGxJkwld5Jj/9ui6317DouaWj3bbozb7De2BTQ5RJmVWsRrvrL9HaLhA21opdLg0Vz1CMcRkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746779193; c=relaxed/simple;
	bh=2U3qlt6xTtAkRktO3TPQ/Fu17LWnVfPYHYDAPD13F5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vDfdzap3pKsFtQzMdnxRNQb4bC5XZnC/+Ro6Ums/tbDh7SMtyFNzjxiPWNuKPi1vGM5DOeceNvQYIUrAujGzHqewgGvZvIvBBh4jXbRU+k19w53bjSpqFzHEEBbW104m/bwT7ZdCr5eCqk1hlQhZkmZyFwnstxfhPcnnEArugkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QnGU+K9D; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VkdKoExZlKmwVFzoYyD2EJ2qF5vE1bqLaXdkq+3X4PE=; b=QnGU+K9DRoCUrKWb9kE2Talcw6
	EcujUcjABkvfICiaocCHCVZzw2bxIe1ccaQWvWR/Kj42Y1daTnvILu0rt+NZR1aRih6TjQS0pwXle
	S9tdm8z9BuZcXCTpY1ZmVEbTwmAWw9YZWa93GbCOSxyDZKgFuyjrg5CklpP+1gPqP57q6SpuHmkjo
	h8Go0asSyX1uiiMNqbZJRIqA7CVJq4pCnlfMDVE0TA9IRZ0qlUZBm2SYDOfOP3mvWTJ/OX+RtHJRu
	gPKjtRBfHbeZmILwYOQ/aDpqqD3rSuAeGRQ/j9yByi9gR4lQZxLG7kD/CNmZLw9NmTrGeQZE7RuC1
	2BYU0SxA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDJ3t-0000000AxO3-017w;
	Fri, 09 May 2025 08:26:29 +0000
Date: Fri, 9 May 2025 09:26:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Christian Brauner <christian.brauner@kernel.org>
Subject: [BUG] propagation graph breakage by MOVE_MOUNT_SET_GROUP
 move_mount(2)
Message-ID: <20250509082628.GU2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

AFAICS, 9ffb14ef61ba "move_mount: allow to add a mount into an existing
group" breaks assertions on ->mnt_share/->mnt_slave.  For once, the data
structures in question are actually documented.

Documentation/filesystem/sharedsubtree.rst:
        All vfsmounts in a peer group have the same ->mnt_master.  If it is
	non-NULL, they form a contiguous (ordered) segment of slave list.

fs/pnode.c:
 * Note that peer groups form contiguous segments of slave lists.

fs/namespace.c:do_set_group():
        if (IS_MNT_SLAVE(from)) {
                struct mount *m = from->mnt_master;

                list_add(&to->mnt_slave, &m->mnt_slave_list);
                to->mnt_master = m;
        }

        if (IS_MNT_SHARED(from)) {
                to->mnt_group_id = from->mnt_group_id;
                list_add(&to->mnt_share, &from->mnt_share);
                lock_mount_hash();
                set_mnt_shared(to);
                unlock_mount_hash();
        }

Note that 'to' goes right after 'from' in ->mnt_share (i.e. peer group
list) and into the beginning of the slave list 'from' belongs to.  IOW,
contiguity gets broken if 'from' is both IS_MNT_SLAVE and IS_MNT_SHARED.
Which is what happens when the peer group 'from' is in gets propagation
from somewhere.

It's not hard to fix - something like

        if (IS_MNT_SHARED(from)) {
		to->mnt_group_id = from->mnt_group_id;
                list_add(&to->mnt_share, &from->mnt_share);
		if (IS_MNT_SLAVE(from))
			list_add(&to->mnt_slave, &from->mnt_slave);
		to->mnt_master = from->mnt_master;
                lock_mount_hash();
                set_mnt_shared(to);
                unlock_mount_hash();
        } else if (IS_MNT_SLAVE(from)) {
		to->mnt_master = from->mnt_master;
		list_add(&to->mnt_slave, &from->mnt_master->mnt_slave_list);
	}

ought to do it.  I'm nowhere near sufficiently awake right now to put
together a regression test, but unless I'm missing something subtle, it
should be possible to get a fairly obvious breakage of propagate_mnt()
out of that...

