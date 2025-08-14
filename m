Return-Path: <linux-fsdevel+bounces-57815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB454B258A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 02:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49C772710B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 00:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048015ECCC;
	Thu, 14 Aug 2025 00:57:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784B2FF66B;
	Thu, 14 Aug 2025 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755133051; cv=none; b=Lo79vIERZLY4OXBnNASC8tPJPCevC5ZBN0O6/gVOXbIfNun7ijIevObsKJghHTlfxTiRZL7ZfZb80nc+VoF7/00Rpm2ieDfZunuOSTUJfRgQzzI9778anLQs7pX578jtxuFvXjzoQ2iEoxTEZ8MreLEnwHVvo3NXTM7Dv6NJZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755133051; c=relaxed/simple;
	bh=FsILFVHrLouIwQUepaOtEF88P07nkFMv9H8p9pBzu1s=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QXX7dQRFmIaRm787+WpgyN84Z7kTE0q5TEdGzxzkQUhADZ2jN2BV9C3BiyuNPXO1iLsZBVPu2gr+ue2HkCyNszQiCxzbkaPCX2e7rHgFCne6weORsrvHFmcjnLmH1vTAVEzzl1OahuUzaRtOIO6yYlkozF5hDt1SienQhBnzUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1umMH3-005gzt-L3;
	Thu, 14 Aug 2025 00:56:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
Subject:
 Re: [PATCH 10/11] VFS: use d_alloc_parallel() in lookup_one_qstr_excl().
In-reply-to: <20250813051957.GE222315@ZenIV>
References: <>, <20250813051957.GE222315@ZenIV>
Date: Thu, 14 Aug 2025 10:56:58 +1000
Message-id: <175513301880.2234665.7949166216437739702@noble.neil.brown.name>

On Wed, 13 Aug 2025, Al Viro wrote:
> On Tue, Aug 12, 2025 at 12:25:13PM +1000, NeilBrown wrote:
>=20
> > + * If it is d_in_lookup() then these conditions can only be checked by t=
he
> > + * file system when carrying out the intent (create or rename).
>=20
> I do not understand.  In which cases would that happen and what would happen
> prior to that patch in the same cases?
>=20

NFS (and I think it is only NFS) returns NULL from ->lookup() without
instantiating the dentry and without clearing DENTRY_PAR_LOOKUP if
passed "LOOKUP_CREATE | LOOKUP_EXCL" or "LOOKUP_RENAME_TARGET".

So when e.g. filename_create() calls lookup_one_qstr_excl() the result could
be a d_in_lookup() dentry.  It could be that the name exists on the
server, but the client hasn't bothered to check.  So determining that
the result wasn't ERR_PTR(-EEXIST) does NOT assure us that the name
doesn't exist.

The intent needs to be attempted, such as when do_mknodat() goes on to
call e.g.  vfs_create().  Only once that returns an error can we know if
the name existed.

i.e. the API promise:

+ *   Will return -EEXIST if name is found and LOOKUP_EXCL was passed.

must be understood against the background that the name might not be
found due to the lookup being short-circuited and not attempted.
The other promise:

+ *   Will return -ENOENT if name isn't found and LOOKUP_CREATE wasn't passed.

is currently safe from confusion, but I can imagine that one day a
LOOKUP_UNLINK intent could allow a filesystem to short-circuit the
lookup in do_unlinkat() and simply send an UNLINK request to a server
and return the result.

So I thought it worth highlighting the fact that these errors are
best-effort, and that d_in_lookup() is a real possibility.

NeilBrown

