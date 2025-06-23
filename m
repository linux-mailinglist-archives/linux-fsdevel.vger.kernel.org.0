Return-Path: <linux-fsdevel+bounces-52647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AADAE51D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 23:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02291B642A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 21:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46778221FDC;
	Mon, 23 Jun 2025 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WiYvD/2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF019CC11
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714672; cv=none; b=RxQnb1tds5O80gDEmsxzmeP52YGs33P5jM1CGfPkwCpFn8z35OfTbLXSNGZNRMfMoPDrf1O3PZZgnrdgZRgTEzYYfGCoWlOQZQGxKCUp+LYJMAZyU25AlrjOmRbgzz+0CxLXO7MVrnEegz3ruUgeHFafs+J2Eh2rqU/WK7nZMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714672; c=relaxed/simple;
	bh=czjkf6XgnZOrILD7WnbCWZ33fQtTCscGl4dV21eqOtA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tKQDnfd6MrcE7PuEsCxGbjFMzI3bwucl1TRpWyi3BaxRGbTgPtFuVfYN2/Qf66vidgBShXjwL8SeQ/J7GPZkEk8ejIpUoSgrqAqhQtyY/ehDwe8yVgDo+APvueMG650tMcahCBPubCUJrR7xOHyvWY3ZETIqWpVc9QOmmWHPThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WiYvD/2z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CE779GMvTk3cnpGQeADCeyl7t2WGCiOmFny1G02cAzo=; b=WiYvD/2zU/6NQvR3MrxbbWym8B
	j5Ndr+RSy63/1GATjEh2YcXIYUmh//Ii4xgw8cvvPo4spH16TELEdLwc2qSgyjdPsmgkuyvVDMdnQ
	rf/cyLH8490GzP/oHCjecZJDl4Pp/dy7zYCPTIP3YskDBSgmV8x1ejBexpCrr5lmsAoEjd/Zsh9zh
	KIYZV/BTpGG09AxmEnwqquDqfR/woV1o+S3HQR+hMfj7odPX1hbo2jGaMxNOGB5VBLDR3D3ffXsQt
	B82ChHxSeA8fSPzEcTmUW8PkvWE3sYL+5H/KTHJ5vSo/A9dJHOlGUFZHdGtCviDnzM6rC4pxCRm77
	yNEyURrw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTorL-00000000okT-0rdt;
	Mon, 23 Jun 2025 21:37:47 +0000
Date: Mon, 23 Jun 2025 22:37:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: John Johansen <john@apparmor.net>
Cc: linux-fsdevel@vger.kernel.org
Subject: [RFC][BUG] ns_mkdir_op() locking is FUBAR
Message-ID: <20250623213747.GJ1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	AFAICS, you are trying to put your locks outside of the
->i_rwsem *and* take them from inside your ->mkdir() instance.
This
        /* we have to unlock and then relock to get locking order right
         * for pin_fs
         */
        inode_unlock(dir);
        error = simple_pin_fs(&aafs_ops, &aafs_mnt, &aafs_count);
        mutex_lock_nested(&parent->lock, parent->level);
        inode_lock_nested(dir, I_MUTEX_PARENT);
        if (error)
                goto out;

        error = __aafs_setup_d_inode(dir, dentry, mode | S_IFDIR,  NULL,
                                     NULL, NULL, NULL);
        if (error)
                goto out_pin;

        ns = __aa_find_or_create_ns(parent, READ_ONCE(dentry->d_name.name),
                                    dentry);

is completely broken.

Think what happens if two threads call mkdir() on the same thing.
OK, the first one got through vfs_mkdir() to the point where it
calls ->mkdir().  Parent is locked (->i_rwsem, exclusive), dentry
happens to be a hashed negative (e.g. from a slightly overlapping
earlier stat(2), whatever).

Your ->mkdir() drops the lock on parent, which is the only thing
holding the second thread back.  Now, the second thread gets in
and it happens to grab parent->lock first.  It makes dentry hashed
positive, drops the lock and buggers off.  Your first thread gets
parent->lock... and calls d_instantiate() on an already positive
dentry.  At which point the data structures are FUBAR.

Better yet, have mkdir A/B race with rmdir A.  After dropping
the locks in ->mkdir() you get the second thread getting through
the entire rmdir(2).  You get to __aa_find_or_create_ns(), which
calls __aa_create_ns(), which gets to
        error = __aafs_ns_mkdir(ns, ns_subns_dir(parent), name, dir);
Unfortunately, ns_subns_dir(parent) is already NULL, so you hit
        AA_BUG(!parent);
in __aafd_ns_mkdir().

AFAICS, rmdir/rmdir races are also there and also rather unpleasant.

Could you explain what exclusion are you trying to get there?
The mechanism is currently broken, but what is it trying to achieve?

