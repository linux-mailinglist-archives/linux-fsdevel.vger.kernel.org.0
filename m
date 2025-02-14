Return-Path: <linux-fsdevel+bounces-41732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E675A362AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02F07A3FD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909FF2673B0;
	Fri, 14 Feb 2025 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ho6KfJ+l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A1265CA1;
	Fri, 14 Feb 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549153; cv=none; b=rdm4JDnlL9SVDrmwL7w8zTzJCfsxbQJMH1tYmSOb8yrsLsnXhvBquIgyj2Lxb5Z0r83K1xk7AHkIlOK7I8A4xjxemLaatMvCgIFsNym558KSBMFx8qLKbv0CGdkJjgMFVcMRhVtg6XAWwSKioRdtt2F2kM4N89PQKjWRkOZQtgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549153; c=relaxed/simple;
	bh=OWtVFxWed1y/+c25INbIxFFkpoczUni/1VRykkO7eA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qb2myBzUCkmsDU8RBgltH6HJ7CFyqhYUTwxunaRJCyWnfjATCTT6dNnASXZjZ1zrPpn1ydG0kbp8nB+5q4T5O6wF+M3k0qoZbbbKdpILFBFC0wRvmNijAoUANXzl433P3sy/YIhLbWi1+sVnlBDcSPcY5lR7QDyAligQZWFbnqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ho6KfJ+l; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+AifcspyR2RnstEaZObXT/25pWWtjDWp+b441hJbOpM=; b=Ho6KfJ+laC1iRSmPqUeMMa373B
	Sv5vo89alyIw1I3lafOoXZeoH/aUg4adz0FAjKNXEvFyErFb3xf8KbTH30MRZ0sLRYCKOcEEAcndx
	FAlCPEc47sJI/m3HhdqFLqYA4N8mWT9UwNs+SRoFuAChS4DJ8ejadJQlZU2rBSjt5wRKJoAEU14tv
	natPe0WlZoynerPzkuwJxPBPn/nsrFofWri8smJ2ye0dec9Ax+gEh3VN8tQarTk22CGkTGj5YolQ9
	wdcH1XsgySSV5vjhUuSweLVkb48uWgQr0OchJNylgn2/bdk1W2/mX0qnLXy1tt20HbSruX3SH+4ej
	qI+zsqww==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tiyC9-001lBi-0P; Fri, 14 Feb 2025 17:05:42 +0100
From: Luis Henriques <luis@igalia.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,  ceph-devel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [RFC] odd check in ceph_encode_encrypted_dname()
In-Reply-To: <bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org> (Jeff
	Layton's message of "Fri, 14 Feb 2025 10:41:15 -0500")
References: <20250214024756.GY1977892@ZenIV> <20250214032820.GZ1977892@ZenIV>
	<bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
Date: Fri, 14 Feb 2025 16:05:42 +0000
Message-ID: <87frkg7bqh.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[ Dropping my previous email from the CC list ]

On Fri, Feb 14 2025, Jeff Layton wrote:

> On Fri, 2025-02-14 at 03:28 +0000, Al Viro wrote:
>> On Fri, Feb 14, 2025 at 02:47:56AM +0000, Al Viro wrote:
>>=20
>> [snip]
>>=20
>> > Am I missing something subtle here?  Can elen be non-positive at that =
point?
>>=20
>> Another fun question: for dentries with name of form _<something>_<inumb=
er>
>> we end up looking at fscrypt_has_encryption_key() not for the parent,
>> but for inode with inumber encoded in dentry name.  Fair enough, but...
>> what happens if we run into such dentry in ceph_mdsc_build_path()?
>>=20
>> There the call of ceph_encode_encrypted_fname() is under
>> 	if (fscrypt_has_encryption_key(d_inode(parent)))
>>=20
>> Do we need the keys for both?
>>=20
>
> That sounds like a bug, but I don't fully recall whether snapshots have
> a special case here for some reason. Let me rephrase Al's question:
>
> If I have a snapshot dir that is prefixed with '_', why does it use a
> different filename encryption key than other snapshot dirs that don't
> start with that character?
>
> My guess here is that this code ought not overwrite "dir" with the
> result of parse_longname(), but I don't recall the significance of a
> snapshot name that starts with '_'.

This bit I _think_ I remember.  Imagine this tree structure:

   /mnt/ceph
   |-- mydir1
   |-- mydir2

If you create a snapshot in /mnt/ceph:

  mkdir /mnt/ceph/.snap/my-snapshot

you'll see this:

   /mnt/ceph
   |-- .snap
   |     |-- my-snapshot
   |-- mydir1
   |     |-- _my-snapshot_1099511627782
   |-- mydir2
         |-- _my-snapshot_1099511627782

('1099511627782' is the inode number where the snapshot was created.)

So, IIRC, when encrypting the snapshot name (the "my-snapshot" string),
you'll use key from the original inode.  That's why we need to handle
snapshot names starting with '_' differently.  And why we have a
customized base64 encoding function.

Cheers,
--=20
Lu=C3=ADs


>         /* Handle the special case of snapshot names that start with '_' =
*/
>         if ((ceph_snap(dir) =3D=3D CEPH_SNAPDIR) && (name_len > 0) &&
>             (iname.name[0] =3D=3D '_')) {
>                 dir =3D parse_longname(parent, iname.name, &name_len);
>                 if (IS_ERR(dir))
>                         return PTR_ERR(dir);
>                 iname.name++; /* skip initial '_' */
>         }
>         iname.len =3D name_len;
>
>         if (!fscrypt_has_encryption_key(dir)) {
>                 memcpy(buf, d_name->name, d_name->len);
>                 elen =3D d_name->len;
>                 goto out;
>         }
>
>
> --=20
> Jeff Layton <jlayton@kernel.org>
>
=20

