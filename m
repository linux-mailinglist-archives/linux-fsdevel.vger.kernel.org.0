Return-Path: <linux-fsdevel+bounces-38565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B0EA0426C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A75D1881FEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530ED1F190C;
	Tue,  7 Jan 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Li4/61K5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259241AD3E0
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259926; cv=none; b=oyVn5ijjE4ZFkMcPT8kDc+eW5ZZBA8/xy7N8eqY3PHxeTO4ARvoWf4gxQM6ORhW7vEuJSBuo2xNF/gggueXkWueLFSNLA7pjTuJh6GcSk74WrwVwpk97yp845GhoAXIzEjLJTTVvhF6USBPYrH58P70w5h3vcOgtAA53JVR9fWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259926; c=relaxed/simple;
	bh=d1LIxk0qATz7Bx4CSYXVDlVnUV+KY+MMY4q3GcikwAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1XyLxYD8Fv/bhl5BdSVXt7XsvjLtbARXs0YmRniMjCVUkwK259vHCJD72MJs9T8xKDHfTiwquYPu7ZPqYJy3fe02nvNODdk9tOmpJHesTHQTTb34jMN8tNvis84R5jFfiXox1fwZmb1I8K6mm315DOpSfCrnGIR0+1H3LAjQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Li4/61K5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736259924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fF/UPutmJQWTWBXfGNwys3gTtOLsUadSzknGE532siM=;
	b=Li4/61K5B/2CI3d009RvbpHquD86urcReTUfL9L0/SC1Tj5jCte9z4KHhfxPyN8WteJUTw
	qE+ql6Skt+MDxWKCR4ZaEgQNhjkXMswHfjv+Ap2VtANoK5nV+Jk6JYvFqaCwxPSb0nAx+P
	AQX77MQ2duayIDCbEtD/9vU+qetCHeY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-xRfsoEZbMnafl6X5nVz4bw-1; Tue,
 07 Jan 2025 09:25:20 -0500
X-MC-Unique: xRfsoEZbMnafl6X5nVz4bw-1
X-Mimecast-MFC-AGG-ID: xRfsoEZbMnafl6X5nVz4bw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A8FC1955F45;
	Tue,  7 Jan 2025 14:25:19 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 219C83000707;
	Tue,  7 Jan 2025 14:25:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] afs: Dynamic root improvements
Date: Tue,  7 Jan 2025 14:25:07 +0000
Message-ID: <20250107142513.527300-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Here's a pair of patches to make a number of improvements to the AFS
dynamic root:

 (1) Create an /afs/.<cell> mountpoint to match the /afs/<cell> mountpoint
     when a cell is created.

 (2) Change the handling of /afs/@cell from being a dentry name
     substitution at lookup time to making it a symlink to the current cell
     name and also provide a /afs/.@cell symlink to point to the dotted
     cell mountpoint.

The patches are here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-next

Thanks,
David

David Howells (2):
  afs: Make /afs/.<cell> as well /afs/<cell> mountpoints
  afs: Make /afs/@cell and /afs/.@cell symlinks

 fs/afs/cell.c              |  13 ++-
 fs/afs/dynroot.c           | 190 +++++++++++++++++++++++++++----------
 include/trace/events/afs.h |   2 +
 3 files changed, 152 insertions(+), 53 deletions(-)


