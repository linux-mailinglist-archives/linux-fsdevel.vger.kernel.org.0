Return-Path: <linux-fsdevel+bounces-51059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F22AD2525
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 19:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E78188E5D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 17:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0EB21B9FD;
	Mon,  9 Jun 2025 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G6Ot2+ay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C5189513
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490904; cv=none; b=OtwF9i86ofArGzUD3NpTZ+I0P8k3/TsZjxBmAfrUUhOz4BCxLRXSpYpKTR0P2Uzdhp6pO+IEA97H5KSI9rpfTxy0KxbSCWX+yv/stshPtqovKuwLTS6D9HyVpLkgoNbbaY4zL4qiMFGIcowcIiOlClk4dGqcCd1RixwPaTlgLOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490904; c=relaxed/simple;
	bh=kmbieTj1ph2Dg/P5gQ80/KTsigf/OgQxTuURZFrS3wA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sxWezYwoTMJqG+wrzFAikLnXp9yA7p5Pgk5GCWFWGCvbOoxkaxNUheKO15XQG8CFQjTXpiLlow9zQ9sr2c55Ox4B46v6/ZQjUWLClPtBJRgbP7c1KnWq3UpV9iZuSCt0ToBPY7HD0WEHtPe3UkrA6JztcD5BSLDBx5vYBesABXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=G6Ot2+ay; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=N+Y5ER9LecxoDVAD4/kYKVGZAWgK4P0Dd+YgWKEnWbY=; b=G6Ot2+ayJBeeLIdVkcIL4zo6wD
	qCaPNZpi/FdLvv5ZkdAHTv/W++CnyVzE/byjrSHwrCdy+8agfeOwEHbCpr+0VHAYl7ZkOcPIfS9nU
	5nHwfJUI5glEAZrK09xRBngkvuObuqYkR8QJhagrT8P71u4EsQGqp+J1I31Kp8OygZCw+Wl8j2C6v
	es3vq7kYVN2giprjujH7M4dMK11PZvEPlStdNgPLJQ8o9BoZILZhM48wmMykDgKP6R7xyd+oKnBtD
	yfD5CG7EO3wCAusZ5ycTB4XjVsTkSNzB4ZsgF2FjiaUynrlgAQRHRCNOnMv/du1nnN1wjKF5NkUUP
	ZU3i6VuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOgV8-0000000EmKn-3v4s;
	Mon, 09 Jun 2025 17:41:39 +0000
Date: Mon, 9 Jun 2025 18:41:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [bug] propagate_mount_busy() giving false negatives
Message-ID: <20250609174138.GD299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

On mainline (both 6.16-rc1 and e.g. debian-testing 6.12.27 kernel):
; cat >a.sh <<'EOF'
P=/tmp/playground
mkdir $P
mount -t tmpfs none $P
mount --make-private $P
mkdir $P/A
mkdir $P/B
mount -t tmpfs none $P/A
mount --make-shared $P/A
mount --bind $P/A $P/B
mount --make-slave $P/B
mkdir $P/A/x
mount --bind $P/A $P/A/x
cd $P/B/x
mount --bind $P/A/x $P/B/x/x
umount $P/A/x
EOF
; . a.sh
; /bin/pwd
pwd: couldn't find directory entry in '..' with matching i-node
; pwd
/tmp/playground/B/x
; grep /tmp/playground /proc/self/mountinfo
36 30 0:28 / /tmp/playground rw,relatime - tmpfs none rw
37 36 0:30 / /tmp/playground/A rw,relatime shared:14 - tmpfs none rw
38 36 0:30 / /tmp/playground/B rw,relatime master:14 - tmpfs none rw
;

In other words, non-lazy umount of /tmp/playground/A/x has succeeded,
taking out /tmp/playground/B/x/x and /tmp/playground/B/x along with
it, with the latter being definitely in use.

What happens is that we have propagate_mount_busy() taking one look
at /tmp/playground/B/x and deciding that its use count doesn't matter,
since propagate_umount() won't take it out, since there's something
mounted on top of it.  And so there is - /tmp/playground/B/x/x, which
is taken out by the same propagate_umount(), so... the refcount on
/tmp/playground/B/x did matter, after all.

Goes back at least to 2014 (i.e. Eric's scalability work in that area),
but I wouldn't be surprised if it turns out to be as old as 2005...

Oh, well... at least with rewrite of propagate_umount it should be
reasonably easy to figure out the set of relevant mounts; in non-lazy case
we have only one mount in the original set, so all candidates will have
the same mountpoint dentry, which means that the subgraph consisting of
umount candidates will be a bunch of non-intersecting ancestry chains,
making the things much simpler than in generic case...

Still not fun.  And I very much doubt we can change the behaviour in
case where nothing is actually busy - without that cd(1) making the
sucker busy, we need umount(2) to take those 3 mounts out ;-/

