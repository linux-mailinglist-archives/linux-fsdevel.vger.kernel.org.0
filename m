Return-Path: <linux-fsdevel+bounces-37143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB79EE4EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D11B2819FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 11:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2EE211707;
	Thu, 12 Dec 2024 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="WhGTaMzZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6295B1C5497;
	Thu, 12 Dec 2024 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002552; cv=none; b=i4qZmqRzj2EOOuDw/8zSLg//AAVbK9jzJu+blz3ABV669LBAa7lexFO2ow4qHVL2s+WidiNIMfElsCqchU2lN2/Si1pgh3zfskYJOZEY+Z0eaek6Wsk0ovUrAlg9Xjr41+7q+0rnhUOSZ+wcKbWS7XIeL0zbPWB0G/OrOiXmIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002552; c=relaxed/simple;
	bh=DojvQfVDDKCCCmhS0betbHxzY47+lyZQNhOH90MEtPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekqp4AIesWekcHdqSqA2uBIkVqyXE1Mp83gFqHMo1r8o+kQE63MP1yxqge4jitHZlU0lwissV9nneCo5lUbDiyxeN1utKV1w1WJnT8PxzwNKvpm1wwyHpc/3Y2GM1TmUBDu+nZ0nv7Q+VXdMCJNhU10hVYtCM+gs4eAq9DFilVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=WhGTaMzZ; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=nncaMgD9Zf1hOTs2IIZuBWXTffTYXbgQRYKcNJadq9E=; b=WhGTaMzZzo/3Rtf0KgkzYItp7t
	m5o8K+ds0J4GaguPKCF6eXNQpho568IKhcyN+PeJ4vUi89inx0QKO+rqz9yXyIyg3jI/GHWti3rJz
	crl3E58EmefyDRzT6QtCeGItYe1GuyzPN0k5l6B4debDjVTUc/CPmBhF1fiHi6EgZ6D1Qq2gyHQYW
	E/bE41t0o15oqT2r90XCpfwtQWnG8/xv1EvOwVILtqKgwOXGDbhyl1JDtK/6sOM/NJn2b9dE0q5ag
	ya845l834vRxfWsoh4nNtgrEutvdGyqcrPbhILy01FjNkFuGIZ89/bC0pGtg1m+raZgYEe3ntWDoS
	PMXsCw7A+vucPMW4dSOeU27yKjl1Y65QdCUuIFgMLO+gjOAWmK6IVuhGgk5m1cbIW04FYCjXZu3Rj
	wcg+fr8DnquZMzbRHd272FiiGgyHKQ/tuMaVcOoSwDePWz31HoJYvXQgyt4tErjJuHqFhoeRSazin
	KTkAscAsMaHH/knFsnJ5cPuZhgWqm1L53x6/W7svNbuA8x9QgR2agBTZzMB6bx5FLFdaoGHWwRaCS
	06Uz/+xDG0iJR3NTQZOfAA1GLQMF1F0GO5ce4nZvO1GqGNTBkHtjLBHLADh7YlAWr/bFDakdwkIxf
	demMSiNoX6aKnjLdvvm0WakguKvC0aTfDFZyul2fs=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: asmadeus@codewreck.org, Leo Stone <leocstone@gmail.com>,
 syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com, ericvh@gmail.com,
 ericvh@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, lucho@ionkov.net,
 syzkaller-bugs@googlegroups.com, v9fs-developer@lists.sourceforge.net,
 v9fs@lists.linux.dev, Fedor Pchelkin <pchelkin@ispras.ru>,
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
Subject:
 Re: Alloc cap limit for 9p xattrs (Was: WARNING in
 __alloc_frozen_pages_noprof)
Date: Thu, 12 Dec 2024 12:22:21 +0100
Message-ID: <6965367.ZqKit0hgWb@silver>
In-Reply-To: <2475109.TFnaqUCzQF@silver>
References:
 <675963eb.050a0220.17f54a.0038.GAE@google.com>
 <20241211225500.GH3387508@ZenIV> <2475109.TFnaqUCzQF@silver>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, December 12, 2024 11:17:06 AM CET Christian Schoenebeck wrote:
> On Wednesday, December 11, 2024 11:55:00 PM CET Al Viro wrote:
> > On Wed, Dec 11, 2024 at 01:32:26PM -0800, Linus Torvalds wrote:
> > > On Wed, 11 Dec 2024 at 13:04, <asmadeus@codewreck.org> wrote:
> > > >
> > > > Christian Schoenebeck's suggestion was something like this -- I guess
> > > > that's good enough for now and won't break anything (e.g. ACLs bigger
> > > > than XATTR_SIZE_MAX), so shall we go with that instead?
> > > 
> > > Please use XATTR_SIZE_MAX. The KMALLOC_MAX_SIZE limit seems to make no
> > > sense in this context.
> > > 
> > > Afaik the VFS layer doesn't allow getting an xattr bigger than
> > > XATTR_SIZE_MAX anyway, and would return E2BIG for them later
> > > regardless, so returning anything bigger wouldn't work anyway, even if
> > > p9 tried to return such a thing up to some bigger limit.
> > 
> > E2BIG on attempt to set, quiet cap to XATTR_SIZE_MAX on attempt to get
> > (i.e. never asking more than that from fs) and if filesystem complains
> > about XATTR_SIZE_MAX not being enough, E2BIG it is (instead of ERANGE
> > normally expected on "your buffer is too small for that").
> 
> So that cap is effective even if that xattr does not go out to user space?
> 
> I mean the concern I had was about ACLs on guest, which are often mapped with 
> 9p to xattr on host and can become pretty big. So these were xattr not 
> directly exposed to guest's user space.

AFAICS it is not capped in this particular case: v9fs_fid_get_acl() calls
v9fs_fid_xattr_get() for getting the xattr, which in turn calls p9 client
functions to retrieve the xattr directly from 9p server (host). So the regular
Linux VFS layers are not involved here.

I also see no limit applied in fs/posix_acl.c when encoding/decoding ACLs.

And 9p server is not necessarily a Linux host, hence Linux's limit for xattr
do not necessarily apply.

So to me KMALLOC_MAX_SIZE (or better: 9p client's msize - header) still looks
right here, no?

/Christian




