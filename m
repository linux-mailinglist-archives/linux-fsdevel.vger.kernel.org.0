Return-Path: <linux-fsdevel+bounces-50711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829B9ACEAF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 09:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C765177EFF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 07:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503C41FE44A;
	Thu,  5 Jun 2025 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BN8pz2Kb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142C1FDA8E
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108957; cv=none; b=hcjFlfldlDZqjsm0HB3z8vCx6ldwz0xPbeIHji6kHbTT5VcUbojCe1b9cpOCg9BhBIsxtaIBEiJxC46ST5w2wJ2UTP7YW8mRd4ovrLczy2/4kVI4uY+0OEjmXyhjF/tDE8s3l8Mfjvw5JWm/9qfJ8VGG3JJ0E2ZqXGiybeX9tEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108957; c=relaxed/simple;
	bh=XeRwyy6qO6ATeLDWBMcja9usj8Ge3s9dfa1F4RGOBsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CzQpVi+E7g3uktdgEukOeMmqnzrSX4ph9gfcHv+KbXx+CKY35id7EshpalRBUGdgEFGffxvDAwqDo6Z+ziUO2vizlqwLltcTqoVloym+Nh20EiWc/BZc76uoSypesRsaPVRgTv6ONVKdDB0HlZYnq+5c+lBRk3hj1J9eAM4cID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BN8pz2Kb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lGJxCJeq4vierofRl2MITkRAF3YQ1WnfQFfgEAOguvM=; b=BN8pz2Kb4L10TAMDdZsz50QXM1
	omsZltKa6mjHxgNUktBCe3ae6NT05FzNkUlEjSWGRXn0sHi7B/EAdi9gIYdfsIYfFSSHep0Yy+Uf4
	k1F58TCcrdKL5T+DsVwpsN47FHpNVo98cs+0Do1BtcX4VpDx+vo4bAaIRmrc5s2aG5ODEo8pf1/Pc
	WJr5RJbj1K8PDSQ4XeJMKuFofQaVQ9fqAJq8VabzeoxRjHLjtWBIPUIE5RQWB+RyQd3s9JotS7aHY
	MAHRzCLrkeno1i9aWLJB0idy3C4RWKY0xrayLR+qeoI/NwDgIe0GVJGZBc+0Py6o3B3VmZcdAaZJ/
	qysOJifg==;
Received: from 35.red-81-39-190.dynamicip.rima-tde.net ([81.39.190.35] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uN58d-00HPog-5W; Thu, 05 Jun 2025 09:35:47 +0200
From: Luis Henriques <luis@igalia.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,  linux-fsdevel@vger.kernel.org,
  Jeff Layton <jlayton@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Amir Goldstein <amir73il@gmail.com>,  Mateusz
 Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH] fs: don't needlessly acquire f_lock
In-Reply-To: <3cmucyvaapaiucekac2xdpdatyti7jatbt2kugcmpgnwjdhae3@ywg4ied3mq6a>
	(Jan Kara's message of "Wed, 4 Jun 2025 11:53:40 +0200")
References: <20250207-daten-mahlzeit-99d2079864fb@brauner>
	<87msaqcw4z.fsf@igalia.com> <87frgicf9l.fsf@igalia.com>
	<obfuqy5ed5vspgn3skli6aksymrkxdrn4dc2gtohhyql5bcqs2@f5xdzffhxghi>
	<20250604-kreieren-pfeffer-fe4ff785b4c8@brauner>
	<3cmucyvaapaiucekac2xdpdatyti7jatbt2kugcmpgnwjdhae3@ywg4ied3mq6a>
Date: Thu, 05 Jun 2025 08:35:42 +0100
Message-ID: <87tt4u4p4h.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04 2025, Jan Kara wrote:

> On Wed 04-06-25 10:33:13, Christian Brauner wrote:
>> On Tue, Jun 03, 2025 at 11:34:53AM +0200, Jan Kara wrote:
>> > On Mon 02-06-25 16:52:22, Luis Henriques wrote:
>> > > On Mon, Jun 02 2025, Luis Henriques wrote:
>> > > > Hi Christian,
>> > > >
>> > > > On Fri, Feb 07 2025, Christian Brauner wrote:
>> > > >
>> > > >> Before 2011 there was no meaningful synchronization between
>> > > >> read/readdir/write/seek. Only in commit
>> > > >> ef3d0fd27e90 ("vfs: do (nearly) lockless generic_file_llseek")
>> > > >> synchronization was added for SEEK_CUR by taking f_lock around
>> > > >> vfs_setpos().
>> > > >>
>> > > >> Then in 2014 full synchronization between read/readdir/write/seek=
 was
>> > > >> added in commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per =
POSIX")
>> > > >> by introducing f_pos_lock for regular files with FMODE_ATOMIC_POS=
 and
>> > > >> for directories. At that point taking f_lock became unnecessary f=
or such
>> > > >> files.
>> > > >>
>> > > >> So only acquire f_lock for SEEK_CUR if this isn't a file that wou=
ld have
>> > > >> acquired f_pos_lock if necessary.
>> > > >
>> > > > I'm seeing the splat below with current master.  It's unlikely to =
be
>> > > > related with this patch, but with recent overlayfs changes.  I'm j=
ust
>> > > > dropping it here before looking, as maybe it has already been repo=
rted.
>> > >=20
>> > > OK, just to confirm that it looks like this is indeed due to this pa=
tch.
>> > > I can reproduce it easily, and I'm not sure why I haven't seen it be=
fore.
>> >=20
>> > Thanks for report! Curious. This is:
>> >=20
>> >         VFS_WARN_ON_ONCE((file_count(file) > 1) &&
>> >                          !mutex_is_locked(&file->f_pos_lock));
>> >=20
>> > Based on the fact this is ld(1) I expect this is a regular file.
>> > Christian, cannot it happen that we race with dup2() so file_count is
>> > increased after we've checked it in fdget_pos() and before we get to t=
his
>> > assert?
>>=20
>> Yes I somehow thought the two of us had already discussed this and
>> either concluded to change it or drop the assert. Maybe I forgot that?
>> I'll remove the assert.
>
> I don't remember discussing this particular assert, I think it was a
> different one of a similar kind :). Nevertheless I agree removing the
> assert here is the right thing to do, it doesn't make too much sense in
> this context.

Awesome, thanks for looking into this Jan and Christian.=20

Cheers,
--=20
Lu=C3=ADs

