Return-Path: <linux-fsdevel+bounces-67343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E105AC3C37F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 17:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 079034FE60C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59C934A76F;
	Thu,  6 Nov 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pnHNp4a7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FEA343D98;
	Thu,  6 Nov 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444728; cv=none; b=JFhdDTnDO9sOgVJZB9fxZQmI//RIY5Gxrih4G2U5Hh4InMjvhTLHzGj29SQVjKWpg+/04iaSyv4K9OsBB0YsDbJjHMQvkidBGsYxyzzu/cvwr1XUZFAum59MSG9FaprqggvjUwm6DGP5e8y8CmORUWXqF3kn9/AOLVbPz8154Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444728; c=relaxed/simple;
	bh=3kuQkXSOQM+wblCbfuc568D67T+5c6qCnYVhC9PzB10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=effeIoghFvBXKQ1mhm5ep+dEdhkiNkxqBQVihaJGwHU7PddavmPZE4c7TVMi27kJ6HgajTGAa9W97WyBdUS3EpGdFApr1KvmLwPrD+NAlL2xmOp+hYPeFM7fSoUP9APWVe1D7hyN8TjoYXuaaD7BPRto3s9PhC0N47uXZTLGPuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pnHNp4a7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1EO13qWLyLQKe+R/NAhnJnKcCSI1DnMuIB44Th05gng=; b=pnHNp4a71gdu7KTf4HMz0rA3pv
	8TS3K82WU/UGTtbYvjYSU2YmKKCniv3Jm6iL1xWtFdaIwGjgug9oSbaTQ/AUEkgmfeBUoR2SH5V8V
	4pbT9FR1E+zCkMwnA/CX60+LzXQCb5QblB4g2R+Kmw0HzKF73QzhRhr4Wb8/JYAiBT/EpGvnJg9xi
	RFEoJA3o7+hUx81f2qtPEQoZ+jE9LwA1XXR/KGPzm2c4y273aajytUeeay1kcWGMcSUiG2xPDus+g
	lAcEDNnoHZiwgsvZGR2taXMqWN6ASCjb2OQHv1r0mDtUf2JQC+8/hbtKjJ8AuH6ei/WzMgg9jCIxO
	Qd9TvdWA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vH2Nb-0034SO-W7; Thu, 06 Nov 2025 16:58:32 +0100
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>,  "Darrick J. Wong"
 <djwong@kernel.org>,  Bernd Schubert <bernd@bsbernd.com>,  "Theodore Ts'o"
 <tytso@mit.edu>,  Miklos Szeredi <miklos@szeredi.hu>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Kevin Chen
 <kchen@ddn.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
In-Reply-To: <874ir7qjov.fsf@wotan.olymp> (Luis Henriques's message of "Thu,
	06 Nov 2025 15:12:16 +0000")
References: <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com>
	<20250912145857.GQ8117@frogsfrogsfrogs>
	<CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com>
	<2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
	<CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
	<20250916025341.GO1587915@frogsfrogsfrogs>
	<CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
	<87ldkm6n5o.fsf@wotan.olymp>
	<CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
	<7ee1e308-c58c-45a0-8ded-6694feae097f@ddn.com>
	<20251105224245.GP196362@frogsfrogsfrogs>
	<d57bcfc5-fc3d-4635-ab46-0b9038fb7039@ddn.com>
	<CAOQ4uxgKZ3Hc+fMg_azN=DWLTj4fq0hsoU4n0M8GA+DsMgJW4g@mail.gmail.com>
	<874ir7qjov.fsf@wotan.olymp>
Date: Thu, 06 Nov 2025 15:58:31 +0000
Message-ID: <87zf8zp2zc.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06 2025, Luis Henriques wrote:

> On Thu, Nov 06 2025, Amir Goldstein wrote:
>
>> [...]
>>
>>> >>> fuse_entry_out was extended once and fuse_reply_entry()
>>> >>> sends the size of the struct.
>>> >>
>>> >> Sorry, I'm confused. Where does fuse_reply_entry() send the size?
>>
>> Sorry, I meant to say that the reply size is variable.
>> The size is obviously determined at init time.
>>
>>> >>
>>> >>> However fuse_reply_create() sends it with fuse_open_out
>>> >>> appended and fuse_add_direntry_plus() does not seem to write
>>> >>> record size at all, so server and client will need to agree on the
>>> >>> size of fuse_entry_out and this would need to be backward compat.
>>> >>> If both server and client declare support for FUSE_LOOKUP_HANDLE
>>> >>> it should be fine (?).
>>> >>
>>> >> If max_handle size becomes a value in fuse_init_out, server and
>>> >> client would use it? I think appended fuse_open_out could just
>>> >> follow the dynamic actual size of the handle - code that
>>> >> serializes/deserializes the response has to look up the actual
>>> >> handle size then. For example I wouldn't know what to put in
>>> >> for any of the example/passthrough* file systems as handle size -
>>> >> would need to be 128B, but the actual size will be typically
>>> >> much smaller.
>>> >
>>> > name_to_handle_at ?
>>> >
>>> > I guess the problem here is that technically speaking filesystems cou=
ld
>>> > have variable sized handles depending on the file.  Sometimes you enc=
ode
>>> > just the ino/gen of the child file, but other times you might know the
>>> > parent and put that in the handle too.
>>>
>>> Yeah, I don't think it would be reliable for *all* file systems to use
>>> name_to_handle_at on startup on some example file/directory. At least
>>> not without knowing all the details of the underlying passthrough file
>>> system.
>>>
>>
>> Maybe it's not a world-wide general solution, but it is a practical one.
>>
>> My fuse_passthrough library knows how to detect xfs and ext4 and
>> knows about the size of their file handles.
>> https://github.com/amir73il/libfuse/blob/fuse_passthrough/passthrough/fu=
se_passthrough.cpp#L645
>>
>> A server could optimize for max_handle_size if it knows it or use
>> MAX_HANDLE_SZ if it doesn't.
>>
>> Keep in mind that for the sake of restarting fuse servers (title of this=
 thread)
>> file handles do not need to be the actual filesystem file handles.
>> Server can use its own pid as generation and then all inodes get
>> auto invalidated on server restart.
>>
>> Not invalidating file handles on server restart, because the file handles
>> are persistent file handles is an optimization.
>>
>> LOOKUP_HANDLE still needs to provide the inode+gen of the parent
>> which LOOKUP currently does not.
>
> One additional complication I just realised is that FUSE_LOOKUP already
> uses up all the 3 in_args.

Ok, ignore me.  We can have 4 in_args, not 3.

Cheers
--=20
Lu=C3=ADs

> So, my initial plan of having FUSE_LOOKUP_HANDLE using a similar structure
> to FUSE_LOOKUP, with the additional parent handle passed to the server
> through the in_args needs a different solution.
>
> (Anyway, I'll need to read through the whole thread(s) again to better
> digest all the information.)
>
> Cheers,
> --=20
> Lu=C3=ADs
>
>
>>
>> I did not understand why Darrick's suggestion of a flag that ino+gen
>> suffice is any different then max_handle_size =3D 12 and using the
>> standard FILEID_INO64_GEN in that case?
>>
>> Thanks,
>> Amir.


