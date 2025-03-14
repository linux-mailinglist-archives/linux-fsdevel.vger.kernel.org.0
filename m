Return-Path: <linux-fsdevel+bounces-43990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3333A60821
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 05:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430EC17FC5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 04:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F05414D28C;
	Fri, 14 Mar 2025 04:57:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE19136327;
	Fri, 14 Mar 2025 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741928232; cv=none; b=WMQSeZPHlPxdw/Qz6scy53fPOtjv7r4iQchTNbTRnDyyNyDgMzcUs7QoyCSXH8SGXiTvMHniojS60YiKoGkxgP+Rn392KNLDLjs9K/W6rIrMTQr7281zXJvHZHGASxXkVNZ0Fx2R+w+h5OakigzsUaUgfR2JeFvFES/GqNZ+XyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741928232; c=relaxed/simple;
	bh=RA9d50To9BqK8KgFMnc48DtduuofQFFL5f0rMNSSX+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3Va/sSSKoExidqCqlyk+z2hoIgL6m5HR8PDlmwtQp1QUabNFguhFpZhdTnFj0+8VtZns/V9vsZSnnfDLSfEnBp2RaLfubaQOF98OQPNm3OOblE21pwhU73liaqJFBjpOMu5vopWOyq6VvihBqZ6Ogd/adXHrt16cKga4Zhmqz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1tsx6W-00E3vh-Db;
	Fri, 14 Mar 2025 04:57:04 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/8 RFC] tidy up various VFS lookup functions
Date: Fri, 14 Mar 2025 11:34:06 +1100
Message-ID: <20250314045655.603377-1-neil@brown.name>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VFS has some functions with names containing "lookup_one_len" and others
without the "_len".  This difference has nothing to do with "len".

The functions without "_len" take a "mnt_idmap" pointer.  This is found
in the "vfsmount" and that is an important question when choosing which
to use: do you have a vfsmount, or are you "inside" the filesystem.  A
related question is "is permission checking relevant here?".

nfsd and cachefiles *do* have a vfsmount but *don't* use the non-_len
functions.  They pass nop_mnt_idmap which is not correct if the vfsmount
is actually idmaped.  For cachefiles it probably (?) doesn't matter as
the accesses to the backing filesystem are always does with elevated privileged (?).

For nfsd it would matter if anyone exported an idmapped filesystem.  I
wonder if anyone has tried...

These patches change the "lookup_one" functions to take a vfsmount
instead of a mnt_idmap because I think that makes the intention clearer.

It also renames the "_one" functions to be "_noperm" and removes the
permission checking completely.  In all cases where they are (correctly)
used permission checking is irrelevant.

I haven't included changes to afs because there are patches in vfs.all
which make a lot of changes to lookup in afs.  I think (if they are seen
as a good idea) these patches should aim to land after the afs patches
and any further fixup in afs can happen then.

The nfsd and cachefiles patches probably should be separate.  Maybe I
should submit those to relevant maintainers first, and one afs,
cachefiles, and nfsd changes have landed I can submit this series with
appropriate modifications.

May main question for review is : have I understood mnt_idmap correctly?

These patches are based on vfs-6.15.async.dir as they touch mkdir
related code.  There is a small conflict with the recently posted patch
to remove locking from try_lookup_one_len() calls.

Thanks,
NeilBrown


 [PATCH 1/8] VFS: improve interface for lookup_one functions
 [PATCH 2/8] nfsd: Use lookup_one() rather than lookup_one_len()
 [PATCH 3/8] nfsd: use correct idmap for all accesses.
 [PATCH 4/8] cachefiles: Use lookup_one() rather than lookup_one_len()
 [PATCH 5/8] cachefiles: use correct mnt_idmap
 [PATCH 6/8] VFS: rename lookup_one_len() family to lookup_noperm()
 [PATCH 7/8] Use try_lookup_noperm() instead of d_hash_and_lookup()
 [PATCH 8/8] VFS: change lookup_one_common and lookup_noperm_common to

