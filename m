Return-Path: <linux-fsdevel+bounces-26880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD52E95C6FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 09:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF24283C62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 07:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAD913D24C;
	Fri, 23 Aug 2024 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uL+E+TcY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9D328DC3
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399616; cv=none; b=HgZ2xbianPIxPPlXqaG/KacuWSGWRDusKt3WomlUzMEam0dMIcsB56+FO3FQ1smOV5XO6MWEsPQwGyPJp6J8lCy7o/XE+FXpGjvFNg1nWb1Qi62+WNb1wMRC2Lgbl74J4+e1mu56FxeoZXL6OK0xiyujcy3cyWHqi4nEyfkqQUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399616; c=relaxed/simple;
	bh=BYsTguooSeCHVx8V7bbMXLDdLi2e4gYts3Np/ULiA/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeqDYgvZnBzvfQlDwQq3AwAtS5jwTWyDB8owJ+BAou3+UOS5Y2DoI08rfnXdjZ2vY0z5KmHaolio15kQM9agEqSYKzc/2fchT9fYVfmZi0W+IMzEnZeJS6kWloQeeGv3KXB6geSXBLkbNzZOZDKrab8OPNUAOI//jwl3TxJ72N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uL+E+TcY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rOoo4FQ0l9gDxiXKpG4Bqp0Jh6cejWRo351EVbPg1Fk=; b=uL+E+TcYWT7M2jqyy185yYkDza
	x1/AM0kmTyGOrUV3RrABsme3F9gIFSCccOXit27YwUU4vL2t2lodqoqD2i29lo6fIIJZLDrvOBW7I
	O1JbxG4Az9+xpypJLvK8wEqJmvi9cKUiMGyux2y6LfB6lZ/CPpC+gZlUACXcR0WXroftRDz5Wscsh
	15EwkyC7w5I5XLF9p966Wj3f/iM19yPHQldnfDCpIJ2AVB5apOarIEsdGHmeUR2uXRYL9DRcCwZc3
	migwg1cnRVm9P3eKL9mrYo6yY9J8RpRMwVSXkbLdITE/SKYWA93oTtHin/4X+aLcYwVHutR2Uh1ZF
	DpzGGoKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1shP6x-00000004RWX-46JG;
	Fri, 23 Aug 2024 07:53:32 +0000
Date: Fri, 23 Aug 2024 08:53:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/4] new helper: drm_gem_prime_handle_to_dmabuf()
Message-ID: <20240823075331.GE1049718@ZenIV>
References: <20240812065656.GI13701@ZenIV>
 <20240812065906.241398-1-viro@zeniv.linux.org.uk>
 <57520a28-fff2-41ae-850b-fa820d2b0cfa@suse.de>
 <20240822152022.GU504335@ZenIV>
 <20240823015719.GV504335@ZenIV>
 <50379388-302d-420a-8397-163433c31bdc@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50379388-302d-420a-8397-163433c31bdc@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 23, 2024 at 09:21:14AM +0200, Thomas Zimmermann wrote:

> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Thank you so much.

OK, Acked-by added, branch force-pushed to
git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git #for-drm

In case if anybody wants a signed pull request, see below; or just
cherry-pick, etc. - entirely up to drm and amd folks...

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-for-drm

for you to fetch changes up to 30581926c42d1886cce2a04dcf615f551d829814:

  amdgpu: get rid of bogus includes of fdtable.h (2024-08-23 03:46:46 -0400)

----------------------------------------------------------------
get rid of racy manipulations of descriptor table in amdgpu

----------------------------------------------------------------
Al Viro (4):
      new helper: drm_gem_prime_handle_to_dmabuf()
      amdgpu: fix a race in kfd_mem_export_dmabuf()
      amdkfd CRIU fixes
      amdgpu: get rid of bogus includes of fdtable.h

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 12 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           | 64 ++++++++++++-----
 drivers/gpu/drm/drm_prime.c                        | 84 ++++++++++++++--------
 include/drm/drm_prime.h                            |  3 +
 6 files changed, 106 insertions(+), 59 deletions(-)

