Return-Path: <linux-fsdevel+bounces-14268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74BB87A3F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 09:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D311F223B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3371CA94;
	Wed, 13 Mar 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJ8fiUZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B461B95C
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317716; cv=none; b=cqwfOfOm70/ZZKTGksVGe1jDjZkHAlPN0kX+ogz80Y6QNGDQH1XtzpZy0T418CdaNV4zVKxEDkzy3+HnFopYYBLdAJ3wjkutyGt/UQB7v+lgXNQwnpZ88IqksVP3GPS+i567NgeKoFnGji8edS16a+YJLRhPtodQtUwJqPlkb9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317716; c=relaxed/simple;
	bh=n7rXU4O0tgKGaggLBSJ+Myujm1amDRFVKcM7UuW3eok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RgiE089s8q86+ERStP7URqqOQKg4f0ydzCF9oUkzQ41c4FZtU5dUT7Im8bTZ3RE1Ptd4dPA9udlwvVW8g5zqqbxUBVmrsCL1rtaIRcKl07lHQ3lGS6iDRGQdMnnlGAHioKexCvELlxuwGWlo+6IsML4k+Aw5UlYncPX8ZTPXcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJ8fiUZi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710317713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XeoAjTK81zFe9kZVKVWoanFV5nZRRMbcdpKdKscy/GU=;
	b=RJ8fiUZiBgp6MPDh6oHpk/ms25lhjri5STmps2Om9nEjUZ+jrUtmm/SCfLR5QQP4PS4Tn9
	ek9hh3mkdWxKTKXYTf2EVfkZw/FwZ1VcE9P7YrLn1q3Vy4ZT4ntbkErUN44Gy8B84J5ZTW
	c4/ygqnA0bQ7wR7kD0S7x8R8A7xH2J0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-6NKIEnDhMdC1vA5m0qazIw-1; Wed, 13 Mar 2024 04:15:09 -0400
X-MC-Unique: 6NKIEnDhMdC1vA5m0qazIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93C4B84B167;
	Wed, 13 Mar 2024 08:15:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF188C4F9A0;
	Wed, 13 Mar 2024 08:15:07 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] afs: Miscellaneous fixes
Date: Wed, 13 Mar 2024 08:15:01 +0000
Message-ID: <20240313081505.3060173-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Marc,

Here are some fixes for afs, if you could look them over?

 (1) Fix the caching of preferred address of a fileserver.  By doing that, we
     stick with whatever address we get a response back from first rather then
     obeying any preferences set.

 (2) Fix an occasional FetchStatus-after-RemoveDir.  The FetchStatus then
     fails with VNOVNODE (equivalent to -ENOENT) that confuses parts of the
     driver that aren't expecting that.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

David Howells (2):
  afs: Don't cache preferred address
  afs: Fix occasional rmdir-then-VNOVNODE with generic/011

 fs/afs/rotate.c     | 21 ++++-----------------
 fs/afs/validation.c | 16 +++++++++-------
 2 files changed, 13 insertions(+), 24 deletions(-)


