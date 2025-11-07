Return-Path: <linux-fsdevel+bounces-67420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F524C3F263
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 10:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F3E3B06E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4561EE033;
	Fri,  7 Nov 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DiKODaXt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9129B8E0;
	Fri,  7 Nov 2025 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507539; cv=none; b=b2zINVFeHUWLG9T8DpG+hV6JvG3S55ZVCWWtu8xZGdPdBrmYf1WVwnokQparBxgu/F2QoVf7mvTme4+fkfojEwBp7udMPIYWbT01fQVcqs7CD6FqZtmRK6nym8Uz8Zn6v4AOvPV/N6JWXlaKP8yOgbRTfua93gXGYWTZPVJbkpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507539; c=relaxed/simple;
	bh=/AGNW71S4Yk/RK26qQSj8YrNbE16Egqb8P/usljzDio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HEswPhbRSpDHfbP47/jnzGsGScU4zJ36oa4IzLfRID1e7nellDh8HaxWZ0FwzexUiXCCi48yKFhv0T6zv2YqoUIk51ImKbuX/xtu8WYDkIyrOHIVFQ17NY5TV1IjLM+R++34HNP02kmNysGSd60roFqes8SnWQxkyn0JKqTQCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DiKODaXt; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/x4l+A0jDSFdktd3t5ashjObRl7Kwga0z+/ilUukgS0=; b=DiKODaXtdUn1nt9dQCN5rnvlsV
	br+tLYih0okDtPfimNQjBtdgRkMCPtyFH3TLYsJ4UV8n0Gyl3+nERXhfaZWK/DxsBBfI/YxHb/2u2
	lO7Lpf0zxsEnI+CczxCCaXGC2DhXUOFihlG/vDITn3NmZyo6U39qSmWPcqTXckyrQjGIxMiWTyQb8
	m5nxlpJD85gK7mjDR7bWZPctqsyvOazc4VqCcdEREUxDqWEvqlVfWG0f+l0wlG8gMSk4FvHR7IJC8
	8ODGrloxjm5/TEckul52a93TZuU2fhK/CpqQUOUCf7jrz30BmYHevIASvqQIJ0W1e55NyoF52mZoB
	vJoTL4Ig==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vHIig-003Nko-V7; Fri, 07 Nov 2025 10:25:23 +0100
From: Luis Henriques <luis@igalia.com>
To: Stef Bon <stefbon@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,  Amir Goldstein
 <amir73il@gmail.com>,  Bernd Schubert <bschubert@ddn.com>,  Bernd Schubert
 <bernd@bsbernd.com>,  "Theodore Ts'o" <tytso@mit.edu>,  Miklos Szeredi
 <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Kevin Chen <kchen@ddn.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
In-Reply-To: <CANXojcwP2jQUpXSZAv_3z5q+=Zrn7M8ffh2_KdcZpEad+XH6_A@mail.gmail.com>
	(Stef Bon's message of "Thu, 6 Nov 2025 17:08:00 +0100")
References: <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
	<CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
	<20250916025341.GO1587915@frogsfrogsfrogs>
	<CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
	<87ldkm6n5o.fsf@wotan.olymp>
	<CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
	<7ee1e308-c58c-45a0-8ded-6694feae097f@ddn.com>
	<20251105224245.GP196362@frogsfrogsfrogs>
	<d57bcfc5-fc3d-4635-ab46-0b9038fb7039@ddn.com>
	<CAOQ4uxgKZ3Hc+fMg_azN=DWLTj4fq0hsoU4n0M8GA+DsMgJW4g@mail.gmail.com>
	<20251106154940.GF196391@frogsfrogsfrogs>
	<CANXojcwP2jQUpXSZAv_3z5q+=Zrn7M8ffh2_KdcZpEad+XH6_A@mail.gmail.com>
Date: Fri, 07 Nov 2025 09:25:17 +0000
Message-ID: <87ecqary82.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Stef,

On Thu, Nov 06 2025, Stef Bon wrote:

> Hi,
>
> is implementing a lookup using a handle to be in the kernel?

What we're talking here is a new FUSE operation, FUSE_LOOKUP_HANDLE.  The
scope here is mostly related to servers restartability: being able to
restart a FUSE server without unmounting the file system.  But other
scopes are also relevant (e.g. NFS exports).

Just in case you missed it, here's a link to the full discussion:

https://lore.kernel.org/all/8734afp0ct.fsf@igalia.com/

and to an older discussion, also relevant:

https://lore.kernel.org/all/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKx=
EwOQ@mail.gmail.com/

Cheers,
--=20
Lu=C3=ADs

> I've written a FUSE fs for sftp using SSH as transport, where the
> lookup call normally has to create a path (relative to the root of the
> sftp) and send that to the remote server.
> It saves the creation of this path if there is a handle available.
> When doing an opendir, this is normally followed by a lookup for every
> dentry. (sftp does not support readdirplus) Now in this case there is
> a handle available (the one used by opendir, or one created with
> open), so the fuse daemon I wrote used that to proceed. (and so not
> create a path).
>
> So it can also go in userspace.
>
> Stef
>


