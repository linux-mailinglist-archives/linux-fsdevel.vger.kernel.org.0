Return-Path: <linux-fsdevel+bounces-57654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8015B24355
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E3218877E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AA02E62D8;
	Wed, 13 Aug 2025 07:53:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6202E36F2;
	Wed, 13 Aug 2025 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071627; cv=none; b=ZidULW4QfjjIy4s4jDHTW44D+lGsVp98jqjRGyIlPHyluaBq+uQ+uyfhJTdOuRCjRNzLLGWwepAHD2XGLopb3D/kUCn4gC43KpDQ5SwW3kWvUNsW7uQw+KjrF4DpzK4NBiUmHHLb0cvv5lJlweAQSC6MA4v9MHaRwn0EwTFNmcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071627; c=relaxed/simple;
	bh=ubt2jmRbkm0tjF5l/5fbSM6AnoNU3or1gH4/6Ow83zI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=HS18q5f3W7n2HiM2CcFKQxm5gio1XbJPBpKasI9xl3u8bm5JbNvpAJfSTSUhVrn0pX8BGSd4BWwq6s4n9/twO1ij0ruX0QQ+ogEZw5Xw/6AvcuznBvMDjh9ieXpuusxwNGCwkAvrqLvpWl1nhcPjCRyNOFofMbDdpbviS1CgAe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1um6Im-005awI-Qw;
	Wed, 13 Aug 2025 07:53:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Steve French" <sfrench@samba.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 netfs@lists.linux.dev, ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] VFS: introduce dentry_lookup_continue()
In-reply-to: <20250813042202.GA222315@ZenIV>
References: <>, <20250813042202.GA222315@ZenIV>
Date: Wed, 13 Aug 2025 17:53:42 +1000
Message-id: <175507162200.2234665.9318589188954309739@noble.neil.brown.name>

On Wed, 13 Aug 2025, Al Viro wrote:
> On Tue, Aug 12, 2025 at 12:25:07PM +1000, NeilBrown wrote:
> > A few callers operate on a dentry which they already have - unlike the
> > normal case where a lookup proceeds an operation.
> > 
> > For these callers dentry_lookup_continue() is provided where other
> > callers would use dentry_lookup().  The call will fail if, after the
> > lock was gained, the child is no longer a child of the given parent.
> > 
> > There are a couple of callers that want to lock a dentry in whatever
> > its current parent is.  For these a NULL parent can be passed, in which
> > case ->d_parent is used.  In this case the call cannot fail.
> > 
> > The idea behind the name is that the actual lookup occurred some time
> > ago, and now we are continuing with an operation on the dentry.
> > 
> > When the operation completes done_dentry_lookup() must be called.  An
> > extra reference is taken when the dentry_lookup_continue() call succeeds
> > and will be dropped by done_dentry_lookup().
> > 
> > This will be used in smb/server, ecryptfs, and overlayfs, each of which
> > have their own lock_parent() or parent_lock() or similar; and a few
> > other places which lock the parent but don't check if the parent is
> > still correct (often because rename isn't supported so parent cannot be
> > incorrect).
> 
> I would really like the see the conversion of these callers.  You are
> asking for a buy-in for a primitive with specific semantics; that's
> hard to review without seeing how it will be used.
> 

All, or just some?
I use dentry_lookup_continue() in:
  cachefiles: 4 times
  ecryptfs: once
  overlayfs: twice
  smb/server: once
  apparmor: once

Maybe I could include all in the one patch...

NeilBrown

