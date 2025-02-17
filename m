Return-Path: <linux-fsdevel+bounces-41879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD76EA38B7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD2D188C48D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 18:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B37236427;
	Mon, 17 Feb 2025 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lzpO2IMM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E2137C35;
	Mon, 17 Feb 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818140; cv=none; b=E9GeA5uR1+ErWg08CIYC+CGeNrcUAQoZIdkZyErvSpg+CGYbkeUQj0XsmP3iZG2U9XhFpexVb6zd7PU0xiPzPyodLbIGYuztRjoiMNY9+TM7kJAxz6Ez+a1JgImEuaQDBvqwsSDITna4gSiLyANy4DT6G4dZOyR1M3izg3hWkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818140; c=relaxed/simple;
	bh=Qs9Nil2R/XxJ5XjFccwRIWDUcU/WSJf2XzHumfIdwdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Igo9K1WqRUkBNCKGkJXeKg2KwURlxIOkXlAspbboc9p5uKnfqTJpL7zxmx4fzjblJFQPuFYbdzfeioFfMpparQGPoSm4g1mDLFfk/gloNbS4QKyw8UqFMfk72fOPADDrmhz2r75oRVSn9F7V0pXyqGKltMaRHXD0HDJnKXJeJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lzpO2IMM; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+3WSWnDNr9QaA4O1ueCYToheHUKAnyW6aGcOiPLcDkg=; b=lzpO2IMMyeJBBIHf4UpdIWcTnj
	BwJlFj+zEYtj0Cdb4Keiu50VO2uAzIjfBHv+cJQA3dEiH0qodeiVNdUIgu2+vomnR7J1sB+Pp6Jdf
	zE05ZLmvotUpxuKLz18so3WL8jTDo5muj4ZjbEsQl2VeXzlgTMAviKnIIRPvs9MHptaX6xR9MLU6L
	ASr37kcaz/01Jk6rOt8iYXc9rgx435VHz+ECwaL0ELIqWYpGpoAu8bT4+SYhnniYu9h1qjgeX9Hj+
	H7TfD/Ib0ul5j5C31HFUGgee3inH1YSHo5+jSQLFV3kI3w6kqppMR5AYG/Dov8IajJIGaIQgqjShp
	iRuJ1F5Q==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tk6AY-006wmZ-1O; Mon, 17 Feb 2025 19:48:43 +0100
From: Luis Henriques <luis@igalia.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
  "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
  "jlayton@kernel.org" <jlayton@kernel.org>,
  "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
  "idryomov@gmail.com" <idryomov@gmail.com>
Subject: Re: [RFC] odd check in ceph_encode_encrypted_dname()
In-Reply-To: <4ac938a32997798a0b76189b33d6e4d65c23a32f.camel@ibm.com>
	(Viacheslav Dubeyko's message of "Mon, 17 Feb 2025 17:56:56 +0000")
References: <20250214024756.GY1977892@ZenIV> <20250214032820.GZ1977892@ZenIV>
	<bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
	<87frkg7bqh.fsf@igalia.com> <20250215044616.GF1977892@ZenIV>
	<877c5rxlng.fsf@igalia.com>
	<4ac938a32997798a0b76189b33d6e4d65c23a32f.camel@ibm.com>
Date: Mon, 17 Feb 2025 18:48:43 +0000
Message-ID: <87cyfgwgok.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17 2025, Viacheslav Dubeyko wrote:

> On Sat, 2025-02-15 at 15:39 +0000, Luis Henriques wrote:
>> On Sat, Feb 15 2025, Al Viro wrote:
>>=20
>> > On Fri, Feb 14, 2025 at 04:05:42PM +0000, Luis Henriques wrote:
>> >=20
>> > > So, IIRC, when encrypting the snapshot name (the "my-snapshot" strin=
g),
>> > > you'll use key from the original inode.  That's why we need to handle
>> > > snapshot names starting with '_' differently.  And why we have a
>> > > customized base64 encoding function.
>> >=20
>> > OK...  The reason I went looking at that thing was the race with renam=
e()
>> > that can end up with UAF in ceph_mdsc_build_path().
>> >=20
>> > We copy the plaintext name under ->d_lock, but then we call
>> > ceph_encode_encrypted_fname() which passes dentry->d_name to
>> > ceph_encode_encrypted_dname() with no locking whatsoever.
>> >=20
>> > Have it race with rename and you've got a lot of unpleasantness.
>> >=20
>> > The thing is, we can have all ceph_encode_encrypted_dname() put the
>> > plaintext name into buf; that eliminates the need to have a separate
>> > qstr (or dentry, in case of ceph_encode_encrypted_fname()) argument and
>> > simplifies ceph_encode_encrypted_dname() while we are at it.
>> >=20
>> > Proposed fix in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs=
.git #d_name
>> >=20
>> > WARNING: it's completely untested and needs review.  It's split in two=
 commits
>> > (massage of ceph_encode_encrypted_dname(), then changing the calling c=
onventions);
>> > both patches in followups.
>> >=20
>> > Please, review.
>>=20
>> I've reviewed both patches and they seem to be OK, so feel free to add my
>>=20
>> Reviewed-by: Luis Henriques <luis@igalia.com>
>>=20
>> But as I said, I don't have a test environment at the moment.  I'm adding
>> Slava to CC with the hope that he may be able to run some fscrypt-specif=
ic
>> tests (including snapshots creation) against these patches.
>>=20
>>=20
>
> Let me apply the patches and test it. I'll share the testing results ASAP.

Awesome!  Thanks a lot.

Cheers,
--=20
Lu=C3=ADs

