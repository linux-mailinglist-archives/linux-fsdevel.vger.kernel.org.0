Return-Path: <linux-fsdevel+bounces-41718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E28A35FD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 15:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA217188F320
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22202263F48;
	Fri, 14 Feb 2025 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nPPES9Ry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34643AB7;
	Fri, 14 Feb 2025 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541938; cv=none; b=L/kO2HakKdC3TrqfbiTMs/tP4BqUnWgUA9ylu+jHi0CtJ4VKxxOuc6lzmojO1e62mKpW+k5pHAZxOB9wm/zpdVwl6v8ZPYDxm5TvkHONmsgENSrW0LGAMz4aR2ZQE0bsUfKuc85QmljqQiqVI2Wf0lJ01IN+U7vu3gg/BsEM6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541938; c=relaxed/simple;
	bh=qbTep7DWwVVPGr9yAbsTjbeGA2rp+k6QNTAJdohXydI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VF6dQWaw1zqNHX0201DV/mfoTQbzxBjkO4pPlobM9vt52E91qFr9ACNMoAtNusjbcIASe4jDzMhTesabGD3mjn0t/hP903O8MnLl3ndwjSwLurCelFf38aTIOfzygpkQUYyCqvs4hHBjzkDLcTbcM/qWJvf9Op4uXZ/ctiRuPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nPPES9Ry; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1J+F7+b3AxQOy6Rj57+X0K27oSk2Zb3KYBkytmzjEMA=; b=nPPES9RyY0a732LFDGlEWkixex
	8FPiAjCNw7iGYDOoxwjWjR8obQPmykZ1F97ALsoz+uoPyOvAw0cT3ADZcqMIsDveja1uFUdGBDtkW
	vq9CnC9j9rCuQa0N7SI9fOezZ5Kha7KvOBo6FtpIpyW/FwLXrERjXVA62krsifWkvmqkUmhxZwB1A
	97NWWAIMF4hAS8CkvaN0kvprvKpdMu1Osk+Goo56xlB4EpqDgFyvrTRTEI/zUhJw1TEs54X+ShnUP
	ubIOY6T4BxQQ+WmCIrMvdBhDI6iDjdu5ur5whMA7qdDQBj70ilubSmR/RaKClCJTk7Q3A5kVmLWSE
	ZLS+ssIQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tiwJc-001QBL-LZ; Fri, 14 Feb 2025 15:05:18 +0100
From: Luis Henriques <luis@igalia.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Layton <jlayton@kernel.org>, =?utf-8?Q?Lu=C3=ADs?= Henriques
 <lhenriques@suse.de>,
  ceph-devel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,  Ilya Dryomov
 <idryomov@gmail.com>
Subject: Re: [RFC] odd check in ceph_encode_encrypted_dname()
In-Reply-To: <20250214032820.GZ1977892@ZenIV> (Al Viro's message of "Fri, 14
	Feb 2025 03:28:20 +0000")
References: <20250214024756.GY1977892@ZenIV> <20250214032820.GZ1977892@ZenIV>
Date: Fri, 14 Feb 2025 14:05:18 +0000
Message-ID: <87jz9s7hb5.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14 2025, Al Viro wrote:

> On Fri, Feb 14, 2025 at 02:47:56AM +0000, Al Viro wrote:
>
> [snip]
>
>> Am I missing something subtle here?  Can elen be non-positive at that po=
int?

It has been a while since I last looked into this code, so the details are
quite foggy.  I don't think you're missing something and that '(elen > 0)'
test could be dropped.  Unfortunately, I can only tell that through code
analysis -- I don't have a test environment anymore where I could try
that.

> Another fun question: for dentries with name of form _<something>_<inumbe=
r>
> we end up looking at fscrypt_has_encryption_key() not for the parent,
> but for inode with inumber encoded in dentry name.  Fair enough, but...
> what happens if we run into such dentry in ceph_mdsc_build_path()?
>
> There the call of ceph_encode_encrypted_fname() is under
> 	if (fscrypt_has_encryption_key(d_inode(parent)))
>
> Do we need the keys for both?

I'm not sure I totally understand your question, but here are my thoughts:
if we have the key for the parent, then we *do* have the key for an inode
under that encrypted subtree.  This is because AFAIR we can not have
nested encryption.  Thus, the call to ceph_encode_encrypted_fname()
*should* be OK.

But I'm CC'ing Jeff as he wrote most of the cephfs fscrypt code and he
might correct me.  Or maybe he has a better memory than I do.

Cheers,
--=20
Lu=C3=ADs

