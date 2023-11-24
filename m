Return-Path: <linux-fsdevel+bounces-3683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF437F7853
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2E02815D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B745431759;
	Fri, 24 Nov 2023 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrS9oXPT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068A61BC8
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700841145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aI7yOeP+aTNuK7EBwRmxy6gF4Tua25jWVuFZl/CnCAo=;
	b=YrS9oXPThumt112TevJ57KO7qrGp62sSqsMchyd5L5kuBoFOloPPJCXXWVy+tBe7B7ODzZ
	7RxtHvC7GyeIwl5hPgcam4ch77OTCH8b1TOHZ5gc/t3lr/QFladU5PrWLy0I+0I5K+JBLF
	Do+KQLuU1t3OeQcxWbNLl+SJyt40F5o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-XhlQ56NtOwCRXr3h4qodEA-1; Fri,
 24 Nov 2023 10:52:22 -0500
X-MC-Unique: XhlQ56NtOwCRXr3h4qodEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B925A2818768;
	Fri, 24 Nov 2023 15:52:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E703CC15881;
	Fri, 24 Nov 2023 15:52:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Miscellaneous fixes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1205227.1700841139.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Nov 2023 15:52:20 +0000
Message-ID: <1205248.1700841140@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Linus,

Here are a set of miscellaneous small fixes to the afs filesystem
including:

 (1) Fix the afs_server_list struct to be cleaned up with RCU.

 (2) Fix afs to translate a no-data result from a DNS lookup into ENOENT,
     not EDESTADDRREQ for consistency with OpenAFS.

 (3) Fix afs to translate a negative DNS lookup result into ENOENT rather
     than EDESTADDRREQ.

 (4) Fix file locking on R/O volumes to operate in local mode as the serve=
r
     doesn't handle exclusive locks on such files.

 (5) Set SB_RDONLY on superblocks for RO and Backup volumes so that the VF=
S
     can see that they're read only.

Btw, I did want to ask about (5): Does a superblock being marked SB_RDONLY
imply immutability to the application?  A 'read only' AFS volume is a snap=
shot
of a writable volume and can be updated.  It's only read-only in the sense=
 you
can't perform normal filesystem modification ops on it.

Link: https://lore.kernel.org/r/20231116155312.156593-1-dhowells@redhat.co=
m/ # v1
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>

Thanks,
David

---
The following changes since commit 76df934c6d5f5c93ba7a0112b1818620ddc10b1=
9:

  MAINTAINERS: Add netdev subsystem profile link (2023-11-17 03:44:21 +000=
0)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/afs-fixes-20231124

for you to fetch changes up to 68516f60c1d8b0a71e516d630f66b99cb50e0150:

  afs: Mark a superblock for an R/O or Backup volume as SB_RDONLY (2023-11=
-24 14:52:24 +0000)

----------------------------------------------------------------
AFS Fixes

----------------------------------------------------------------
David Howells (5):
      afs: Fix afs_server_list to be cleaned up with RCU
      afs: Make error on cell lookup failure consistent with OpenAFS
      afs: Return ENOENT if no cell DNS record can be found
      afs: Fix file locking on R/O volumes to operate in local mode
      afs: Mark a superblock for an R/O or Backup volume as SB_RDONLY

 fs/afs/dynroot.c     |  4 ++--
 fs/afs/internal.h    |  1 +
 fs/afs/server_list.c |  2 +-
 fs/afs/super.c       |  4 ++++
 fs/afs/vl_rotate.c   | 10 ++++++++++
 5 files changed, 18 insertions(+), 3 deletions(-)


