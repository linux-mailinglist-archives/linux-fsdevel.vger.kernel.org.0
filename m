Return-Path: <linux-fsdevel+bounces-57653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4922AB24340
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434E5189F921
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE522E92AA;
	Wed, 13 Aug 2025 07:50:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824872D59E3;
	Wed, 13 Aug 2025 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071422; cv=none; b=Ky0nOm+5FhTSUIHaa7dH+yXbd4A3g+94i2qISqf5rC198+tYYO+I3WAFhkHAdeJWIFNCZ5J8czvRLy7PHaH2v8Rw97noK5a40rokaQ/3Uy6IFOAkE9btkQTAniq2dUe9qBngDrTsA/ehy4M4gtQ90e16ylPdHDWMwfiRDBDl7xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071422; c=relaxed/simple;
	bh=jlkW2DR8frGKjTWGtgJ6wMVaeLTO3MJZ9rkIDe5MetU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=U6Ou6VD1p0QTSkTw7Lr6EHcgAQxzsZhav8VYLxGeCC7yc2rXIXKIglR5+kBAVdtRH4sZ7Eq8g8AP9OdfOZ1VUS1IoISagRRkdSbjv7rDNtKNNJiG+KTgQahVPH//kYheqlFBL6eqQbFJ9Fk+ThNigIVIZ4/mv5HtQjAzWkOzQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1um6FT-005auZ-1H;
	Wed, 13 Aug 2025 07:50:16 +0000
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
Subject: Re: [PATCH 03/11] VFS: add dentry_lookup_killable()
In-reply-to: <20250813041506.GZ222315@ZenIV>
References: <>, <20250813041506.GZ222315@ZenIV>
Date: Wed, 13 Aug 2025 17:50:16 +1000
Message-id: <175507141618.2234665.4849620982329749562@noble.neil.brown.name>

On Wed, 13 Aug 2025, Al Viro wrote:
> On Tue, Aug 12, 2025 at 12:25:06PM +1000, NeilBrown wrote:
> > btrfs/ioctl.c uses a "killable" lock on the directory when creating an
> > destroying subvols.  overlayfs also does this.
> > 
> > This patch adds dentry_lookup_killable() for these users.
> > 
> > Possibly all dentry_lookup should be killable as there is no down-side,
> > but that can come in a later patch.
> 
> Same objections re lookup_flags and it would be better to do that
> at the same point where you convert the (btrfs and overlayfs?) callers.
> 

I had trouble deciding whether it would be better to merge the patches
for easy review, or keep them separate in case they needed to go through
different trees.. I guess I decided wrongly.

NeiBrown

