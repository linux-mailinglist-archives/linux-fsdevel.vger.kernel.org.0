Return-Path: <linux-fsdevel+bounces-51441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC94AD6ED3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C461895140
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 11:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050A423A566;
	Thu, 12 Jun 2025 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XN5HvSpm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4B205AA3
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727158; cv=none; b=pZCLomXebb50q8CGrsTdHVSAfxpPcJECxR3VHIqG5W83EQqcqu2UlfPenR3RVsNhtTVUyfOYWNGZK6CZompgoKkjCL0ufz4u2Wx6x+eZaDhEi/7crGDTZOvX6Me0FQuI39Si5ldVomMlzUBB2+9AvqWUT0PH6Cje+ISpba/TiEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727158; c=relaxed/simple;
	bh=5OvjGcFLItOVKsQwZytquBz7aSti7eoEZY1l1KOMTgw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sa56ryBNoPC6CmUGm/cTBk1oxmMX2BCOKbSvA1jB2ZZth3xSLoYwYy57mvxI5IX1BuFFLSvLNhZ3JPSkzm8VacJKDBIIwppwitTF6eUIishSVxff9sbdvT6p6Q07uCAXc79+nQIoqJOv+QLBQxts13ElslY6yatnNtEAwprqT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XN5HvSpm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749727155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cfwqJxgz/BiPbh1Lz8eY9iJzvSVOhlSC1afDF4nBHn0=;
	b=XN5HvSpmIXnLOYfk9W+SdSy0f9RAALonSHMyEn64QMnZ5QgHqy0SQ/HM5rd4FLZ7Jhd3Pz
	mo0SoTmKF/Xo04dQhjoBjxf40cJfIz+7oxS+o2jtjyK9CDiBhsRYsGPqWKivUkf2xn5dM0
	ZNFn2v4QfL5kND02swBcQgL6AKxZtxY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-t_wWnpQ_OxmT8rPX2SCtHQ-1; Thu,
 12 Jun 2025 07:19:12 -0400
X-MC-Unique: t_wWnpQ_OxmT8rPX2SCtHQ-1
X-Mimecast-MFC-AGG-ID: t_wWnpQ_OxmT8rPX2SCtHQ_1749727151
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF4891956088;
	Thu, 12 Jun 2025 11:19:11 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.100])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC9D619560AF;
	Thu, 12 Jun 2025 11:19:10 +0000 (UTC)
Date: Thu, 12 Jun 2025 07:22:45 -0400
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [BUG] fuse/virtiofs: kernel module build fail
Message-ID: <aEq4haEQScwHIWK6@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi folks,

I run kernel compiles quite a bit over virtiofs in some of my local test
setups and recently ran into an issue building xfs.ko once I had a
v6.16-rc kernel installed in my guest. The test case is a simple:

  make -j N M=fs/xfs clean; make -j N M=fs/xfs

... and ends up spitting out link time errors like this as of commit
63c69ad3d18a ("fuse: refactor fuse_fill_write_pages()"):

...
  CC [M]  xfs.mod.o
  CC [M]  .module-common.o
  LD [M]  xfs.ko  
  BTF [M] xfs.ko  
die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got subprogram (0x2e) @ ed957!
error decoding cu i_mmap_rwsem
error decoding cu 
...
error decoding cu 
pahole: xfs.ko: Invalid argument
make[3]: *** [/root/repos/linux/scripts/Makefile.modfinal:57: xfs.ko] Error 1
make[3]: *** Deleting file 'xfs.ko'
make[2]: *** [/root/repos/linux/Makefile:1937: modules] Error 2
make[1]: *** [/root/repos/linux/Makefile:248: __sub-make] Error 2
make[1]: Leaving directory '/root/repos/linux/fs/xfs'
make: *** [Makefile:248: __sub-make] Error 2

... or this on latest master:

...
  LD [M]  fs/xfs/xfs.o
fs/xfs/xfs.o: error: objtool: can't find reloc entry symbol 2145964924 for .rela.text
make[4]: *** [scripts/Makefile.build:501: fs/xfs/xfs.o] Error 1
make[4]: *** Deleting file 'fs/xfs/xfs.o'
make[3]: *** [scripts/Makefile.build:554: fs/xfs] Error 2
make[2]: *** [scripts/Makefile.build:554: fs] Error 2
make[1]: *** [/root/repos/linux/Makefile:2006: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

The latter failure is what I saw through most of a bisect so I suspect
one of the related followon commits alters the failure characteristic
from the former, but I've not confirmed that. Also note out of
convenience my test was to just recompile xfs.ko out of the same tree I
was bisecting from because the failures were consistent and seemed to be
a runtime kernel issue and not a source tree issue.

I haven't had a chance to dig any further than this (and JFYI I'm
probably not going to be responsive through the rest of today). I just
completed the bisect and wanted to get it on list sooner rather than
later..

Brian


