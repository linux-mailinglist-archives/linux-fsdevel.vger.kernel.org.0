Return-Path: <linux-fsdevel+bounces-73141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5918D0DE46
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 23:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A55930361F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 22:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652032BDC0B;
	Sat, 10 Jan 2026 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="udIZxSqN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134FB4A02;
	Sat, 10 Jan 2026 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768082823; cv=none; b=OZNYrPsLHRSKVxd5ziMEZ2Pvm8Hsyyk9Yj8FO2pWoEigAJjScApJYpgROWTd1MDpa7QjI5x5LKOyNwRsJsdOXVV0c+RyT3+Ih5FN1PLuFpmJvpTCdCvUnpqvnbBtLOm2w6SJU3ad/evuncNWGWw+Qyv5H3bBJP8T5dL6fph42xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768082823; c=relaxed/simple;
	bh=H7Mf0EQI9sNtYBiPhcBrI64XhBB7wNXP38iJxQVrciU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUgAHpWLalYRZs9Wq0DMPsS7bvf0d26HfUt9pxMbWJ6jC+MjF0LeIfsrL+3T9iA6HUAK+hu7OVnF38dlS4/igqPGPW39iPDVxL8CBOxjd92oI5GAkimC09jQGNB6yS91FCY7u2T0/MRpsyBLzpdkmZCwyiCzzU7ge2n8QSXCIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=udIZxSqN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OGTTRxJ6I47yzz4Saoz2/EEbsk+8EXVTjW7YlQobX5A=; b=udIZxSqNfUo8v7jRZTEQJCshDv
	CT9hGc09bDBsL4PRteP4lEZa5JmM+IeLMEz/opcm6vQUD0FY498xTL5Q62ZOcMucLisS47Nwp45FD
	YseUiPUogdu13HwZujzYQoiEl+n++uEOuQA37ZFB3MrI2MA2S6VivvpaFjUNXTiPiyw27w+awxgo+
	uJf8qLWoq34VqSy+QfXqBZgm/iEQfksu9h/eTBZbJPQaSpEjVRghKQkYsG+O3fdsqIhFbiuYNNODf
	I6K8/VZ5E0LQJO5qrS8GL2DzW5mZD7elutGHtiECmz8FRzQGfccjGjmCnHeBqFGCpy6k3p/FywvZf
	6iAXUKtg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veh84-0000000Gr8h-278T;
	Sat, 10 Jan 2026 22:08:16 +0000
Date: Sat, 10 Jan 2026 22:08:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 4/6] fs: invoke group_pin_kill() during mount teardown
Message-ID: <20260110220816.GE3634291@ZenIV>
References: <20260108004016.3907158-1-cel@kernel.org>
 <20260108004016.3907158-5-cel@kernel.org>
 <176794792304.16766.452897252089076592@noble.neil.brown.name>
 <50610e1c-7f09-4840-b2b2-f211dd6cdd5f@app.fastmail.com>
 <20260110164946.GD3634291@ZenIV>
 <0599548b-49c1-44e0-b0a8-a077cbdfbcce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0599548b-49c1-44e0-b0a8-a077cbdfbcce@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jan 10, 2026 at 03:07:38PM -0500, Chuck Lever wrote:

> 4. The result is that if a share is unexported while NFSv4 clients still
> have that share mounted, open/lock/delegation state remains in place,
> and the underlying files remain open on the NFS server. That prevents
> the shared file system from being unmounted (which is sometimes the very
> next step after unexport). As long as the NFS client maintains its lease
> (perhaps because it has other shares mounted on that server), those
> files remain open.
> 
> The workaround is that the server administrator has to use NFSD's
> "unlock file system" UI first to revoke the state IDs and close the
> files. Then the file system can be unmounted cleanly.
> 
> 
> Help me understand what you mean by write count? Currently, IIUC, any
> outstanding writes are flushed when each of the files that backs a
> stateid is closed.

File opened for write carries has write access granted at open time and
keeps it until the final fput().  Try this:

root@cannonball:/tmp# mkdir /tmp/blah
root@cannonball:/tmp# mount -t tmpfs none /tmp/blah/
root@cannonball:/tmp# exec 42>/tmp/blah/a
root@cannonball:/tmp# mount -o remount,ro /tmp/blah/
mount: /tmp/blah: mount point is busy.
       dmesg(1) may have more information after failed mount system call.
root@cannonball:/tmp# exec 42>&-
root@cannonball:/tmp# mount -o remount,ro /tmp/blah/
root@cannonball:/tmp# ls /tmp/blah/a 
/tmp/blah/a
root@cannonball:/tmp# umount /tmp/blah 
root@cannonball:/tmp#

You don't need to be in the middle of write(2); just having a file opened for
write prevents r/o remount.

Do you want to be able to
	* umount without an unexport?
	* remount read-only without an unexport?

