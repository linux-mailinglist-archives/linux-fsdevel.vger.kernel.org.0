Return-Path: <linux-fsdevel+bounces-38080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B969FB75B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 23:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A391650A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 22:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02B91C6F70;
	Mon, 23 Dec 2024 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="DeMnOeGE";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="DeMnOeGE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0797462;
	Mon, 23 Dec 2024 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734994569; cv=none; b=oLi7Je/7PVd+jWYMoivbocDcRHS1FynWm4xYPO2rdNRndZ4YPWiASUlVuF8nwu+/3q3aONBAKFMkVDgp7ZchA8X0ZUxbol/bBhGMXHXzPEVJ4wTq49JoPstCEEa5bt7KzL/ouCx6/WDUjfCGQ2J+ZDB5CJUQKfNS74o8HEpSQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734994569; c=relaxed/simple;
	bh=2vPWEdMZFfP8pZKB0z2z3gGAyPgq1XmtiyK0UUQ8Zp0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=urUAgucG41edwbw7HqIfUuvhuWjdKDIU/nW8Qny5su4GOrUA8GMottlLDoYJXe7e0QXKXCEQcu4NgZR9Q57U7CsQIt66M0O+jQdEGyNxMZUJaQxpKBcAF7cJKa6AM7tfnN02qhpBc3buZHKbXLYcEc9Bm5QPTDBm/YKpgC8Jr2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=DeMnOeGE; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=DeMnOeGE; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734994566;
	bh=2vPWEdMZFfP8pZKB0z2z3gGAyPgq1XmtiyK0UUQ8Zp0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=DeMnOeGEYhX/tHm/FA/H1SUxXmHLL1IAkZvESAMPKpqynWY9sMGpWVkA+/4BumDWg
	 YqxCbWQyynBGqZColSn/wml5c/TeJ1Ik+B3H9vnOkOu2BuX/TfhB0DmAz01fGcRptW
	 KDDdRt47Dy0OuxYZM8EC0P8Icd+nzjbrOGb2FW8I=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id A413A1286A49;
	Mon, 23 Dec 2024 17:56:06 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id wOG9pKw0M4zq; Mon, 23 Dec 2024 17:56:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734994566;
	bh=2vPWEdMZFfP8pZKB0z2z3gGAyPgq1XmtiyK0UUQ8Zp0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=DeMnOeGEYhX/tHm/FA/H1SUxXmHLL1IAkZvESAMPKpqynWY9sMGpWVkA+/4BumDWg
	 YqxCbWQyynBGqZColSn/wml5c/TeJ1Ik+B3H9vnOkOu2BuX/TfhB0DmAz01fGcRptW
	 KDDdRt47Dy0OuxYZM8EC0P8Icd+nzjbrOGb2FW8I=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D87471286A3D;
	Mon, 23 Dec 2024 17:56:05 -0500 (EST)
Message-ID: <72a3f304b895084a1da0a8a326690a57fce541b7.camel@HansenPartnership.com>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable
 leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr
	 <jk@ozlabs.org>
Date: Mon, 23 Dec 2024 17:56:04 -0500
In-Reply-To: <20241223200513.GO1977892@ZenIV>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
	 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
	 <20241211-krabben-tresor-9f9c504e5bd7@brauner>
	 <049209daadc928ecbf3bdb17d80634fa55842263.camel@HansenPartnership.com>
	 <f9690563fe9d7ae4db31dd37650777e02580b332.camel@HansenPartnership.com>
	 <20241223200513.GO1977892@ZenIV>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-12-23 at 20:05 +0000, Al Viro wrote:
> On Mon, Dec 23, 2024 at 02:52:12PM -0500, James Bottomley wrote:
> >  
> > +static int efivarfs_file_release(struct inode *inode, struct file
> > *file)
> > +{
> > +       inode_lock(inode);
> > +       if (i_size_read(inode) == 0 && !d_unhashed(file-
> > >f_path.dentry)) {
> > +               drop_nlink(inode);
> > +               d_delete(file->f_path.dentry);
> > +               dput(file->f_path.dentry);
> > +       }
> > +       inode_unlock(inode);
> > +       return 0;
> > +}
> 
> This is wrong; so's existing logics for removal from write().  Think
> what happens if you open the sucker, have something bound on top of
> it and do that deleting write().
> 
> Let me look into that area...

I thought about this some more.  I could see a twisted container use
case where something like this might happen (expose some but not all
efi variables to the container).

So, help me understand the subtleties here.  If it's the target of a
bind mount, that's all OK, because you are allowed to delete the
target.  If something is bind mounted on to an efivarfs object, the
is_local_mountpoint() check in vfs_unlink would usually trip and
prevent deletion (so the subtree doesn't become unreachable).  If I
were to duplicate that, I think the best way would be simply to do a
d_put() in the file->release function and implement drop_nlink() in
d_prune (since last put will always call __dentry_kill)?

Regards,

James


