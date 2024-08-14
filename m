Return-Path: <linux-fsdevel+bounces-25941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EE095215F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 19:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5722C28412F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7581BC065;
	Wed, 14 Aug 2024 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b7CW6MHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977A1B14F8
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656996; cv=none; b=dP2hd4NeH/WSqkR/mojwi6X6XQy/h+uqrIUAOEndYWHwRVg5mNpwoykCTy2Bn1O9ghEU4brbYT2t0mvJPyH+yAVZCmiT75Blbahw7FMdO9yED4o5R48Tscq3VUb2jhlW0MSYLKhsCOvH3CYlkCKZ3I8AKkPcrug8rB53ZGGAFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656996; c=relaxed/simple;
	bh=QjZMP9GTp7pdYfXkbQzqBtJHwTWAthXENP0/kVr10J8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LVf77q9Atl0idC2JMTlwS4v3B84MDMNVYVxZ+kscy7HzvOU/qOLQb6tvm05/KjG7JD3zRD5xvPEn+gD0fH8zw/CxyTPkkXP++rpDNZlQCHkY/ayP52A+gA06q8HETy/utd2ctM+h06+Aj0g1PSnlHLnk10IkOJbf6pZoCjghqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b7CW6MHr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=QjZMP9GTp7pdYfXkbQzqBtJHwTWAthXENP0/kVr10J8=; b=b7CW6MHrs5c9PYDKEL0LJpbZlr
	egKBlSmISsi1WyYN3PMw8YJgOvnKcgVHtlAna8OAQKCHzJrtP+DjVU4VM8o36kfDo8PlflI8ZuMUB
	l6havAQ8eNLya6Opq22N8EYSUiSd41N5EwtncDUs1dJUdE7yN32pWF7CLM7eEUU/A/0+4MWqyxjR4
	K9D1oFKOAmimGkGM1zmOMl8Tm/gknVn0qcG7JFBuuv2rSqyNAQOJA08ikSvxD1EI/3M0wkn/WzLTT
	YkKehNEvtkg45EI7g6CDH7u8fyYG7gyT16L/StH2QReNvSVM9TTSRO/vg/f0UINdkrT06mOj7wy6X
	htNPVeMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seHvE-00000000qYx-385V;
	Wed, 14 Aug 2024 17:36:32 +0000
Date: Wed, 14 Aug 2024 18:36:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC] Merge PG_private_2 and PG_mappedtodisk
Message-ID: <ZrzrIEDcJRFHOTNh@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I believe these two flags have entirely disjoint uses and there will
be no confusion in amalgamating them.

Anonymous memory (re)uses mappedtodisk for anon_exclusive.
Anonymous memory does not use PG_private_2.

$ git grep -El '(folio.*mappedtodisk)|PageMappedToDisk'
fs/buffer.c
fs/ext4/readpage.c
fs/f2fs/data.c
fs/f2fs/file.c
fs/fuse/dev.c
fs/mpage.c
fs/nilfs2/file.c
fs/nilfs2/page.c
include/trace/events/pagemap.h
mm/memory.c
mm/migrate.c
mm/truncate.c

$ git grep -El '(folio.*private_2)|PagePrivate2'
fs/btrfs/ctree.h
fs/ceph/addr.c
fs/netfs/buffered_read.c
fs/netfs/fscache_io.c
fs/netfs/io.c
fs/nfs/file.c
fs/nfs/fscache.h
fs/nfs/write.c
include/linux/netfs.h
include/linux/pagemap.h
mm/filemap.c
mm/migrate.c

The one thing that's going to stand in the way of this is that various
parts of the VFS treat private_2 as a "wait for this bit to be clear",
due to its use in fscache (which is going away).

So my approach here is going to be:

 - Rename mappedtodisk to be PG_owner_priv_2 (add appropriate aliases)
 - Switch btrfs to use owner_priv_2 instead of private_2
 - Wait for the fscache use of private2 to finish its deprecation cycle
 - Remove private_2 entirely

Sound good?

