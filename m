Return-Path: <linux-fsdevel+bounces-40295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8B9A21F44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 15:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FD11884A4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6931DB361;
	Wed, 29 Jan 2025 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nifl4B4C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5F1AE01B
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161247; cv=none; b=Ke9+PfgasJbPj+e4fzfj2Yl1MpHDqFIx4zf9DFcgLqREBujPr5HkYB/EgG1BHU/TO25bEoMWn0GxSsiUs365hzsXBcOd98kiH+uh7R7UXZLWvLhM8e/6cf9rEl/fN1vclooU1mhnLOYKsN8UEDu1Z2y96cgwloB/d7SBVJhGVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161247; c=relaxed/simple;
	bh=k+Ho/OI7DnR6TJjYuqEtnQ9RMDD+xyrRH7njDOgKFs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rePypq78eFJpkWMM2AGTfnvVU8nydcjqwlUO6qBHAIP0QCVRCLp0DoV1gJ9pCZqNUaP5C0iHOma39KeqDF9BQFnQh3Dd0MYlJMlawGLvKXqi9dMULbhYARudT0eGyfGBmRUJ2KmuRDMaTM1flaL+aMEqhSXKNWaPUCQF1xBFcEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nifl4B4C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738161244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I9NMykWnY0xaI3D34lFULHiLIAj4az0UE2WWBydgJhA=;
	b=Nifl4B4Cu7ponnI4X0HlpCCpU81Dv2FIBs7d3M72HaB4qqOp6LoWpqSch4VleEqqEe1J8S
	7RAAD0cVmOZhMbZ/x/DVZpZPeeImpnQV99yilYHRPghEors9qkQXfvxHBZ6V8eN5krNExl
	9moeU08NFlLAipi8qwDfGGtyjj6T6Os=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-Q9kGozAjPduBSjaQIvC1Mw-1; Wed,
 29 Jan 2025 09:33:59 -0500
X-MC-Unique: Q9kGozAjPduBSjaQIvC1Mw-1
X-Mimecast-MFC-AGG-ID: Q9kGozAjPduBSjaQIvC1Mw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 906531800361;
	Wed, 29 Jan 2025 14:33:57 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E46A1800951;
	Wed, 29 Jan 2025 14:33:54 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] further lockref cleanups
Date: Wed, 29 Jan 2025 15:33:49 +0100
Message-ID: <20250129143353.1892423-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

As discussed in Christoph's "lockref cleanups" thread [*], here are some
further cleanups in gfs2 that then allow lockref_init's count argument
to be dropped.  Please review.

Christian, can this go into the vfs tree as Christioph's previous
cleanups did?

Thanks,
Andreas

[*] https://lore.kernel.org/lkml/20250115094702.504610-1-hch@lst.de/

Andreas Gruenbacher (3):
  gfs2: use lockref_init for gl_lockref
  gfs2: switch to lockref_init(..., 1)
  lockref: remove count argument of lockref_init

 fs/dcache.c             | 2 +-
 fs/erofs/zdata.c        | 2 +-
 fs/gfs2/glock.c         | 2 +-
 fs/gfs2/main.c          | 1 -
 fs/gfs2/quota.c         | 4 ++--
 include/linux/lockref.h | 5 ++---
 6 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.48.1


