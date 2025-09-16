Return-Path: <linux-fsdevel+bounces-61823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7BCB5A15A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 21:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B2D1C03E98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C503E2F5A24;
	Tue, 16 Sep 2025 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ioliamnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012532D0C97;
	Tue, 16 Sep 2025 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050569; cv=none; b=C+t6RU7XI3cFltnGo19lscEPWSh2DaVYo3tsPJBxmushFKuVlu0RTn6ZzCcyuEk3AKyOVAbiDiKH6heL6z185hbFssq5IGW+fD4GLcz6mhCem7bewub/cO87XEzT3SiN5iJcjZwknLWdEaG3qX700ozMEfIh5cq/Vff7KW8jnX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050569; c=relaxed/simple;
	bh=+hTjV0r+hFzxfXNHAoEzKy6M6SdKYDya7qj68EXmr08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gN/fHXrA+PiIPUfRihskXrineGmyxYKB5s+wuH65xU9h6bY5OLymvwgu8C/+G7muz9T7xOzCMnq8sus1XBOcOfMDQbT/fDZN2sBiHgWbld46nmoacnz3eytk/z+HcOJVeNOvTOOr04LAmgvqhkAr6MKzQx0zMtV+Dr8rrjctrkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=ioliamnH; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=RChXoodl/EOTezUxp9EQblLqV8H2a0VIHON/1w3OQi8=; b=ioliamnH0b4jrW6hNdJYloxRkO
	bbIV340awl9hMv1+DVR8IOhBYE+Ewc6jtzBUQegDDcCtUROBJT6deg0YarYAKqt+7RUCEMr4cPiwf
	S8ORZmnkqurIqQld6YR0fmooe1+gR+MLEkeT1csKcIdLTNsge9Z2JyOlO9wh9S605GAz28BgGYUoL
	4PCHNpbT/3ALNaIn2Yf+FtG05ESL1d7PngBo2VwZfAqp7aaprX5/LPUM1QcyZBheIdonqgNNYPzu+
	AVCD6rqsLV/sYDD7R9ajOZLGdvlEh6CQ1E7jHg83sMBTlRw13ypYbFCBW9c/34yrf893JLUSym1mx
	JCyfNsq68aQqX3KQVIq0i+bVvdC9szbM6jmif+xmOTKTiMJ4LULAUsc90dwW5BsVgPbIKY4VeC51r
	mi4z4yTIMCsAtiAq/SO8RLHFv/0n+S9LUKmtsWDM0csbAI9zej3Q2xWkokBP88UXKJ8raAXlnsfAe
	LN+VxqoeHUIy6XytXRElvXALAgtq8VXC+VhgfBokIgtHU8I/3ZtH3++kTczTz58yaoYf7LkjC5wZL
	N9HHlfZfIxmxTuxpYd1jJXsWB1g0947AxcwxEeE/OTNBTCtXehCW52kTfbuGzjHz0sBki2rwvHA/A
	2FN4lJkyL4WREaQ7LflcikN0WwccrBg5ybJkq2cNI=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>, Tingmao Wang <m@maowtm.org>
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 v9fs@lists.linux.dev, =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
 linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to qid)
Date: Tue, 16 Sep 2025 21:22:29 +0200
Message-ID: <3070012.VW4agfvzBM@silver>
In-Reply-To: <a98c14f5-4b28-4f7b-86a2-94e3d66bbf26@maowtm.org>
References:
 <aMih5XYYrpP559de@codewreck.org> <aMlnpz7TrbXuL0mc@codewreck.org>
 <a98c14f5-4b28-4f7b-86a2-94e3d66bbf26@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, September 16, 2025 4:01:40 PM CEST Tingmao Wang wrote:
> On 9/16/25 14:35, Dominique Martinet wrote:
> > Tingmao Wang wrote on Tue, Sep 16, 2025 at 01:44:27PM +0100:
> >> [...]
> >>=20
> >> Note that in discussion with Micka=EBl (maintainer of Landlock) he
> >> indicated
> >> that he would be comfortable for Landlock to track a qid, instead of
> >> holding a inode, specifically for 9pfs.
> >=20
> > Yes, I saw that, but what you pointed out about qid reuse make me
> > somewhat uncomfortable with that direction -- you could allow a
> > directory, delete it, create a new one somewhere else and if the
> > underlying fs reuse the same inode number the rule would allow an
> > intended directory instead so I'd rather not rely on qid for this
> > either.
> > But if you think that's not a problem in practice (because e.g. landlock
> > would somehow detect the dir got deleted or another good reason it's not
> > a problem) then I agree it's probably the simplest way forward
> > implementation-wise.
>=20
> Sorry, I forgot to add that this idea would also involve Landlock holding
> a reference to the fid (or dentry, but that's problematic due to breaking
> unmount unless we can have a new hook) to keep the file open on the host
> side so that the qid won't be reused (ignoring collisions caused by
> different filesystems mounted under one 9pfs export when multidev mapping
> is not enabled)

I see that you are proposing an option for your proposed qid based re-using=
 of=20
dentries. I don't think it should be on by default though, considering what=
 we=20
already discussed (e.g. inodes recycled by ext4, but also not all 9p server=
s=20
handling inode collisions).

> (There's the separate issue of QEMU not seemingly keeping a directory open
> on the host when the guest has a fid to it tho.  I checked that if the dir
> is renamed on the host side, any process in the guest that has a fd to it
> (checked via cd in a shell) will not be able to use that fd to read it
> anymore.  This also means that another directory might be created with the
> same qid.path)

=46or all open FIDs QEMU retains a descriptor to the file/directory.

Which 9p message do you see sent to server, Trename or Trenameat?

Does this always happen to you or just sometimes, i.e. under heavy load?=20
Because even though QEMU retains descriptors of open FIDs; when the QEMU=20
process approaches host system's max. allowed number of open file descripto=
rs=20
then v9fs_reclaim_fd() [hw/9pfs/9p.c] is called, which closes some descript=
ors=20
of older FIDs to (at least) keep the QEMU process alive.

BTW: to prevent these descriptor reclaims to happen too often, I plan to do=
=20
what many other files servers do: asking the host system on process start t=
o=20
increase the max. number of file descriptors.

/Christian



