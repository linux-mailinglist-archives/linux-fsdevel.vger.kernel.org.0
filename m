Return-Path: <linux-fsdevel+bounces-41779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C7FA36F28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 16:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933EC3B16B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430181DF75A;
	Sat, 15 Feb 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YSPcda9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187A84D02;
	Sat, 15 Feb 2025 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739633970; cv=none; b=Pt2QpJHeWOya+bZBkg0v5F9Cl9n8I3JzRVeadf8No61OzC6VvDcYNOD+YNYIh1XvRaKntAgNLPpsr+5nsVPRkoSHVTsyEZ/hxEQoBKWSLFke+AMI32npipRMRhl81pec8NwBawcV2Vp7TpPsbccuuSp5iERgZJx+kNQPZ5RmJgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739633970; c=relaxed/simple;
	bh=xtfHuXaWpnh1/sq1x5UK0zr87+KgD01WT+3TsvtsYeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iqEJ0vqJLMTPWfGU9Kasqivg8gwJGWBhy87V32DGSph3B+JSMJ9zK+A42hTnxXyIz+BoPc48uZhgy5dU8BmtFtbI5Y5rYVVuLeL5eQCA0EOavHJUS9o+BT7xPuqDkpZEBvcDwcHu5eLzneLPYo6MSDiIJsZkA/Mhda5PQ90wasE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YSPcda9g; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kE4yi5zTVZgY7FrbYROODhBOp5QIWUOq1BPaFkh4qV4=; b=YSPcda9giw9RPpY1GhYKr3c/4n
	lm5CfwC2lN+PqPAc8a5zzSVsB4TB6Un123pOsO1S5+eg7OZHSNPTXfkY1DRZVfoDJQs15rlgphgdF
	H7iD2GDatCt+ucgqc8hN1Z9W+Ok/FJINX96NVqcU+o8465ib7IO+vsvlJa6v4wV0DP59951tmsH8L
	5cLis6OsfTNTxoBchCx1DdZiM8v3IE5Uhd8o05nNWkzRTh3vwgUrGwkCQ+lMbCWGKa6k0XtgSgdu5
	3K2TRw/aYWe/TPbLsPOiZxu283lQmxwaDG8yFCLRldeR6Yn0Zsc1dKv22tie1TNZ5LJsrlmsK0By6
	0qOrOqsQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tjKG5-0042co-VN; Sat, 15 Feb 2025 16:39:15 +0100
From: Luis Henriques <luis@igalia.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Jeff Layton
 <jlayton@kernel.org>,  ceph-devel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [RFC] odd check in ceph_encode_encrypted_dname()
In-Reply-To: <20250215044616.GF1977892@ZenIV> (Al Viro's message of "Sat, 15
	Feb 2025 04:46:16 +0000")
References: <20250214024756.GY1977892@ZenIV> <20250214032820.GZ1977892@ZenIV>
	<bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
	<87frkg7bqh.fsf@igalia.com> <20250215044616.GF1977892@ZenIV>
Date: Sat, 15 Feb 2025 15:39:15 +0000
Message-ID: <877c5rxlng.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15 2025, Al Viro wrote:

> On Fri, Feb 14, 2025 at 04:05:42PM +0000, Luis Henriques wrote:
>
>> So, IIRC, when encrypting the snapshot name (the "my-snapshot" string),
>> you'll use key from the original inode.  That's why we need to handle
>> snapshot names starting with '_' differently.  And why we have a
>> customized base64 encoding function.
>
> OK...  The reason I went looking at that thing was the race with rename()
> that can end up with UAF in ceph_mdsc_build_path().
>
> We copy the plaintext name under ->d_lock, but then we call
> ceph_encode_encrypted_fname() which passes dentry->d_name to
> ceph_encode_encrypted_dname() with no locking whatsoever.
>
> Have it race with rename and you've got a lot of unpleasantness.
>
> The thing is, we can have all ceph_encode_encrypted_dname() put the
> plaintext name into buf; that eliminates the need to have a separate
> qstr (or dentry, in case of ceph_encode_encrypted_fname()) argument and
> simplifies ceph_encode_encrypted_dname() while we are at it.
>
> Proposed fix in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.gi=
t #d_name
>
> WARNING: it's completely untested and needs review.  It's split in two co=
mmits
> (massage of ceph_encode_encrypted_dname(), then changing the calling conv=
entions);
> both patches in followups.
>
> Please, review.

I've reviewed both patches and they seem to be OK, so feel free to add my

Reviewed-by: Luis Henriques <luis@igalia.com>

But as I said, I don't have a test environment at the moment.  I'm adding
Slava to CC with the hope that he may be able to run some fscrypt-specific
tests (including snapshots creation) against these patches.

Cheers,
--=20
Lu=C3=ADs

