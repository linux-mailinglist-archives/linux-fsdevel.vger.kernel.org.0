Return-Path: <linux-fsdevel+bounces-25647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F23B94E73F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDEE282156
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E4515351A;
	Mon, 12 Aug 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Prn3nkMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15714A4E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445819; cv=none; b=qwOFfU//7s4eTvGcvGNr6b7MkaFM/DtjngBugSADs3RjDafAj1/0X+mE7CoFxIcgGHLxMpFC5uHnQpC8nGZRhnpcLjYUeVYl2jRu+TklahiWB7IhnEasBHIiupaddYXMv+qGjwBuZtaqs9y4nQd1p4oYP9LJww8NZD8FTgyZTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445819; c=relaxed/simple;
	bh=ErkK/L6nvneEgnu4IZVBvsnnX3P/80WwwwRTRhuVxcc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XTJubcLS21uyaVRuubIAcFFPOb5DBOkSpgy01SsPnrsy3AnVXvAx3+dcT9zA1jX5qScKS348Fw8j6GqLOdnV3WbZtbYvvn9pbEHQpcveOgwMPWF/QkX7TfYnKAgB923Gm6Myjjd5qqkAX0Wxj2ZsuYyd9UKTb5A2Ly4gP8RYyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Prn3nkMn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=idBXxM8dGSa96iv7+rsnoNHkcGWImDmOE5L/dsu42Mc=; b=Prn3nkMnCmNcJvqLeA8rzN+iqV
	/xCh8fUxCllblZcx93hhu0lAvNYRNA9TbG2aDEfYJzG+y8Jq0TtoWLyXU//VT5G6i+cVZUXWBJwdZ
	/PMhi1NJ9pV5Xz3tqJ+5AK9YyZsH/l54z2/IfRyt0J1cn7UkXo9R935A43H3v1mwFNqGmai6mcxr8
	1XmgzM1vlwfBAejZWcOec++qoSeZJRx6Mxw+xU9heosEEne1OefXsOAe5ctp/Ozsl/K04TkmWnnB1
	64Eut1YpoMBmp9eqVfFy6CN3TGrfYZZTCdUSVx4XLmA8ePrwmMOYJzhblBjXAREcQuUEffew9S6It
	RAcOZe9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdOzA-000000010k7-3Ama;
	Mon, 12 Aug 2024 06:56:56 +0000
Date: Mon, 12 Aug 2024 07:56:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCHES] [drm] file descriptor fixes
Message-ID: <20240812065656.GI13701@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Resurrecting the stuff from last cycle.
Context: several places in drm have racy uses of close_fd().
Not hard to fix, thankfully.

	Changed since the last posting: as requested, KFD
fix had been split in two commits - introduction of helper
(drm_gem_prime_handle_to_dmabuf()) and switching kfd_mem_export_dmabuf()
to that.

	Branch in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #for-drm,
individual patches in followups.

	Please, review; IMO that ought to go through drm and amd-gfx
trees.

Shortlog:

Al Viro (4):
      new helper: drm_gem_prime_handle_to_dmabuf()
      amdgpu: fix a race in kfd_mem_export_dmabuf()
      amdkfd CRIU fixes
      amdgpu: get rid of bogus includes of fdtable.h

Diffstat:
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 12 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c          |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           | 64 ++++++++++++-----
 drivers/gpu/drm/drm_prime.c                        | 84 +++++++++++-----------
 include/drm/drm_prime.h                            |  3 +
 6 files changed, 95 insertions(+), 70 deletions(-)


