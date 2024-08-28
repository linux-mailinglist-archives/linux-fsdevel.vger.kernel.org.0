Return-Path: <linux-fsdevel+bounces-27639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D735996335E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635821F2463A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1410E1AC89F;
	Wed, 28 Aug 2024 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HixHXkVq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F402158538
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878989; cv=none; b=Lft+eYYkHVcDyodcXe3wNImXlPJ/r0MEyaPLajhCL5444TXcSMjWZT1QxhE8a+IAyLCiE36Ww65kPRQckyT9Yl0pY2MMf2Cbs6sQdY49/FHRqRteuqGWPCMqyk2ON/Ulp9dG3km+hPsVvtdwXXBRfmLG/dCROxEVizD95d5Ncsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878989; c=relaxed/simple;
	bh=VV17+nS8C1q2KfvL5zDpbmlRmgEDHZV0Gqx+Dv4LhVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbSAqlOLLpIVp6Zw9Xih/r8zf/VdKVJRxOoIPVdnhqXj8nWiCgjneja4hi8fZCnsMXUIfi8zHgOxZvSBGLU/n88DVl+0hixr8lK4xw73x542/pxCbkjNBd0a6HX8PRC24h54uvRxZBi7R5QK/13NuE79OHarG5JvBW1eYBbCtGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HixHXkVq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724878986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XFobmMcyik8XghRtkh2gK9+MeaxVAEEC6pZ/c4IMu/w=;
	b=HixHXkVqXn6Dv8+fehBRxGX358/MginE6wuIXx+406atIgiRQWjAYYTaiJApRbeQcNFABm
	13v2Go3wIC8tq0VsBCQ/X+M0LBSNHfpBxa9UfQrQKKW5cz7k9v1Il1yXCeEJ8YXQddLDuu
	p4AAcUFmh9VH3jbu8jYiUJGTh7avdsU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-pWU2m7E2O3W_VVpN-j_iRQ-1; Wed,
 28 Aug 2024 17:03:04 -0400
X-MC-Unique: pWU2m7E2O3W_VVpN-j_iRQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 413511955D47;
	Wed, 28 Aug 2024 21:03:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C48D1955BED;
	Wed, 28 Aug 2024 21:02:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] mm, netfs, cifs: Miscellaneous fixes
Date: Wed, 28 Aug 2024 22:02:41 +0100
Message-ID: <20240828210249.1078637-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Christian, Steve,

Firstly, here are some fixes to DIO read handling and the retrying of
reads, particularly in relation to cifs:

 (1) Fix the missing credit renegotiation in cifs on the retrying of reads.
     The credits we had ended with the original read (or the last retry)
     and to perform a new read we need more credits otherwise the server
     can reject our read with EINVAL.

 (2) Fix the handling of short DIO reads to avoid ENODATA when the read
     retry tries to access a portion of the file after the EOF.

Secondly, some patches fixing cifs copy and zero offload:

 (3) Fix cifs_file_copychunk_range() to not try to partially invalidate
     folios that are only partly covered by the range, but rather flush
     them back and invalidate them.

 (4) Fix filemap_invalidate_inode() to use the correct invalidation
     function so that it doesn't leave partially invalidated folios hanging
     around (which may hide part of the result of an offloaded copy).

 (5) Fix smb3_zero_data() to correctly handle zeroing of data that's
     buffered locally but not yet written back and with the EOF position on
     the server short of the local EOF position.

     Note that this will also affect afs and 9p, particularly with regard
     to direct I/O writes.

And finally, here's an adjustment to debugging statements:

 (6) Adjust three debugging output statements.  Not strictly a fix, so
     could be dropped.  Including the subreq ID in some extra debug lines
     helps a bit, though.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (6):
  cifs: Fix lack of credit renegotiation on read retry
  netfs, cifs: Fix handling of short DIO read
  cifs: Fix copy offload to flush destination region
  mm: Fix filemap_invalidate_inode() to use
    invalidate_inode_pages2_range()
  cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target
    region
  netfs, cifs: Improve some debugging bits

 fs/netfs/io.c            | 21 +++++++++++++-------
 fs/smb/client/cifsfs.c   | 21 ++++----------------
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 37 ++++++++++++++++++++++++++++++++----
 fs/smb/client/smb2ops.c  | 26 +++++++++++++++++++------
 fs/smb/client/smb2pdu.c  | 41 +++++++++++++++++++++++++---------------
 fs/smb/client/trace.h    |  1 +
 include/linux/netfs.h    |  1 +
 mm/filemap.c             |  2 +-
 9 files changed, 101 insertions(+), 50 deletions(-)


