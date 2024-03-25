Return-Path: <linux-fsdevel+bounces-15258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561A688B63C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 01:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57916B2DBE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 21:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05DB6CDD8;
	Mon, 25 Mar 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fTGbqxsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040754902;
	Mon, 25 Mar 2024 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401198; cv=none; b=JQNaNXJuPcDL6dixpKMUTLoSuDhF2gKizTsHruxY8jP82fRzm8bTix56DjH95MovGDePxxdGa+oK0VNrit0/HFl8QTzPvoWC+jXOAH6I+YxAhIYqQqJz5d89DU+o4DyrFP1qKUmyhvGeTsw4s8Xu0ijMeqOrY07C/Fhu1/7eCyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401198; c=relaxed/simple;
	bh=6OPKxj3PY7601FbVQRX2xZAyo/li/QEIqiZMW8rxpJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fvd66WpgZVxZkVjqbJ24OXEfRjiXuXs/5C1UAaweYP3ujbToOKpJGV7noSIp1WGdK7TwLyBYkseRTT8rjc0G5jAySQ9upR6OZDWlBDhZ3/KkYpIrXCi6OxgfP0rz9V4buc7LUMqj99X7I3Azb3LM3RL7Ox+SUgQmJHvcPOtok5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fTGbqxsR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g3Espu9XK22gwjeY8tde1FrtIb6+Pk135nxK84EbhVQ=; b=fTGbqxsRayMH8KFCjNl/wwpDfb
	9eca37NSbpiMm+/bhx7oopOa6crxJFVkxigNfSx3dXcazK2YtFgN2oFrubYhj9KMcLVxQRa+yqdm/
	pTyycmwT9haWcP+EulVR2er2L6zc3AelTM9y8MFQHpY8DMv+0oc2SvqfW2uJAT41KKZ291uFztaVW
	tv7y45Sbsd5qgrIEIx+vcQC5/MDA9anrIAvBY8te0qGMA+Xu/SYMNNSBL++TarHMhgM+59psvml9A
	NoY3Z29UyppcZYuXRGQH8kE18++Bx66WWsdFCyC8H7dRaGJX+SCe7H3g2tUvMUrlXCM77B6IRyMFB
	1tq/eBrg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rorcv-00GbYB-2E;
	Mon, 25 Mar 2024 21:13:05 +0000
Date: Mon, 25 Mar 2024 21:13:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Paulo Alcantara <pc@manguebit.com>
Cc: Steve French <smfrench@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	CIFS <linux-cifs@vger.kernel.org>,
	Christian Brauner <christian@brauner.io>,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Subject: Re: kernel crash in mknod
Message-ID: <20240325211305.GY538574@ZenIV>
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV>
 <3441a4a1140944f5b418b70f557bca72@huawei.com>
 <20240325-beugen-kraftvoll-1390fd52d59c@brauner>
 <CAH2r5muL4NEwLxq_qnPOCTHunLB_vmDA-1jJ152POwBv+aTcXg@mail.gmail.com>
 <20240325195413.GW538574@ZenIV>
 <a5d0ee8c54ec2f80cb71cd72e3b4aec3@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5d0ee8c54ec2f80cb71cd72e3b4aec3@manguebit.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 25, 2024 at 05:47:16PM -0300, Paulo Alcantara wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > On Mon, Mar 25, 2024 at 11:26:59AM -0500, Steve French wrote:
> >
> >> A loosely related question.  Do I need to change cifs.ko to return the
> >> pointer to inode on mknod now?  dentry->inode is NULL in the case of mknod
> >> from cifs.ko (and presumably some other fs as Al noted), unlike mkdir and
> >> create where it is filled in.   Is there a perf advantage in filling in the
> >> dentry->inode in the mknod path in the fs or better to leave it as is?  Is
> >> there a good example to borrow from on this?
> >
> > AFAICS, that case in in CIFS is the only instance of ->mknod() that does this
> > "skip lookups, just unhash and return 0" at the moment.
> >
> > What's more, it really had been broken all along for one important case -
> > AF_UNIX bind(2) with address (== socket pathname) being on the filesystem
> > in question.
> 
> Yes, except that we currently return -EPERM for such cases.  I don't
> even know if this SFU thing supports sockets.

	Sure, but we really want the rules to be reasonably simple and
"you may leave dentry unhashed negative and return 0, provided that you
hadn't been asked to create a socket" is anything but ;-)

> > Note that cifs_sfu_make_node() is the only case in CIFS where that happens -
> > other codepaths (both in cifs_make_node() and in smb2_make_node()) will
> > instantiate.  How painful would it be for cifs_sfu_make_node()?
> > AFAICS, you do open/sync_write/close there; would it be hard to do
> > an eqiuvalent of fstat and set the inode up?
> 
> This should be pretty straightforward as it would only require an extra
> query info call and then {smb311_posix,cifs}_get_inode_info() ->
> d_instantiate().  We could even make it a single compound request of
> open/write/getinfo/close for SMB2+ case.

	If that's the case, I believe that we should simply declare that
->mknod() must instantiate on success and have vfs_mknod() check and
warn if it hadn't.

	Rationale:

1) mknod(2) is usually followed by at least some access to created object.
Not setting the inode up won't save much anyway.
2) if some instance of ->mknod() skips setting the inode on success (i.e.
unhashes the still-negative dentry and returns 0), it can easily be
converted.  The minimal conversion would be along the lines of turning
	d_drop(dentry);
	return 0;
into
	d_drop(dentry);
	d = foofs_lookup(dir, dentry, 0);
	if (unlikely(d)) {
		if (!IS_ERR(d)) {
			dput(d);
			return -EINVAL;	// weird shit - directory got created somehow
		}
		return PTR_ERR(d);
	}
	return 0;
but there almost certainly are cheaper ways to get the inode metadata,
set the inode up and instantiate the dentry.
3) currently only on in-kernel instance is that way.
4) it makes life simpler for the users of vfs_mknod().

	Objections, anyone?

