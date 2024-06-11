Return-Path: <linux-fsdevel+bounces-21392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D3C903718
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF236289EF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8BD176221;
	Tue, 11 Jun 2024 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nkumsAtJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138CF175570
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095964; cv=none; b=tA2WkyQGIEtxxOrTngQqYP4GBK1zo4nypaK0sFI2qVCm351VRopvMYLZG6tEhdl4CE5glCq8HILOYdRWpQ2NU9p6wZ/+G0DWeyG0izuoRg4bjA+uDFmmhl77gYlqcquv6uGE6n3UQkd8/CymIc7qqosZ/fVsOEF68hPFljtEaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095964; c=relaxed/simple;
	bh=e1jKfrVJvNRUjZ1G7GMXs/Auo65RBO7a6yZMmElGgzo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F+5cVBWpGed0kQQhtfiWW1+aYLbYdYNHC2o51yq1RA0Yt72A+kimpJJfhjSbZ22+Rqr0tn+AIXZQ5ooF+msGYFAHRXsmihrT7F8ZcxKltuzQ/iSl/hctag/iKtqAfAbH2X33r/VSMoEhxYRUt95V/O+PLyDvzXqbhIUHn4G1cf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nkumsAtJ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (unn-37-19-197-199.datapacket.com [37.19.197.199] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45B8qFri013014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 04:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718095944; bh=SeRNdQn2ssqgKAus6AWOugRGaJLxS3fn0v7E7U0Lyaw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=nkumsAtJuXUyjG1S4kNF4T71+CDE1Sg/+yCCOV7PWS+Z4p0BcabCql9o97LZtT7nw
	 yns/TZjLhbFNIwaR1wC7P6pkKC6AzJqJEsEjpOIlKMBX4vokEsqdSuNGuZBvCgi5Ll
	 15gRYpAICP/GYnW+07M6y9t79Jr0vmHhCi2nJV04+V+1e0IFqogn42h6LJI/LiiXkt
	 T9qH4fnJV1jTsJwVTrYmsU8q5ItIDDMvKRci09fq1IBlM3KGCNCAG3s8hf60qYphuT
	 FxDFxtsBnN73ColJVKZfIgiplQ6oQJuzZHqw3njI+1sHOcBTSD4mFRFaN1BTvgd3gk
	 fGLIm5pt1mmHA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 67DBA341669; Tue, 11 Jun 2024 10:52:10 +0200 (CEST)
Date: Tue, 11 Jun 2024 09:52:10 +0100
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, fstests@vger.kernel.org
Subject: Flaky test: generic/085
Message-ID: <20240611085210.GA1838544@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, I've recently found a flaky test, generic/085 on 6.10-rc2 and
fs-next.  It's failing on both ext4 and xfs, and it reproduces more
easiy with the dax config:

xfs/4k: 20 tests, 1 failures, 137 seconds
  Flaky: generic/085:  5% (1/20)
xfs/dax: 20 tests, 11 failures, 71 seconds
  Flaky: generic/085: 55% (11/20)
ext4/4k: 20 tests, 111 seconds
ext4/dax: 20 tests, 8 failures, 69 seconds
  Flaky: generic/085: 40% (8/20)
Totals: 80 tests, 0 skipped, 20 failures, 0 errors, 388s

The failure is caused by a WARN_ON in fs_bdev_thaw() in fs/super.c:

static int fs_bdev_thaw(struct block_device *bdev)
{
	...
	sb = get_bdev_super(bdev);
	if (WARN_ON_ONCE(!sb))
		return -EINVAL;


The generic/085 test which exercises races between the fs
freeze/unfeeze and mount/umount code paths, so this appears to be
either a VFS-level or block device layer bug.  Modulo the warning, it
looks relatively harmless, so I'll just exclude generic/085 from my
test appliance, at least for now.  Hopefully someone will have a
chance to take a look at it?

Thanks,

					- Ted

