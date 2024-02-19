Return-Path: <linux-fsdevel+bounces-12023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516C385A627
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 15:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8461DB21570
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FDE1DDF6;
	Mon, 19 Feb 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWPFwFJD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032A1E533
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353557; cv=none; b=hyGvf9I60rAa+9o9KFztwo3y5LyoLcvfmP3x1Sh/zFsLyrhOer9EiCePkoJhm5GphtzrEoXmYj3S93ukT//1YEA2GgbtFAbpWh2WxR9UALCeL1R5+1i7VPTv+dp/c/scwvOMyum4jgGTTEEz6mBHkXlWywy6QmaHK8mOk/cInJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353557; c=relaxed/simple;
	bh=iAYLQ/ry4Ws2zpmoqOww5l5/+sgF7NvkadRmo19kmW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mu8F9bBzXUtjUJ2GAXVQ/+LW2bOtdR7K3xei8s9c3omu9uMietWwcyOYa59l/TiaTq9deTczuVudhGhBpzESk0gm26Z6Qt8L4XrL3XNglcdu9j24x0bl79c6rc80th3+6k1j66i5yGNCELDpGS7JHi1wEFRQtNStXJfyxbyoEyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWPFwFJD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708353553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zRNUK86yxiv/OwmKYhoDvWlQYRo9iQoXDxOJPggkFCc=;
	b=KWPFwFJDMUefH9bX5Tiw8hbCNLyk1z16IL2TlBQO6S/ghd3xwIVMfeRWRJYMyd5UljA72K
	A92yU/KRk8ZY+dshHvEzjwf4ICNjuhRsaA4q9VlGpPk2/XPCV3uMRolQsVvs9vuVV49d6s
	GsOf7nsR8FndoHR+ve4kJiKQ95M8j8U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-0HMhFc7UODeaRflfNH66Xw-1; Mon, 19 Feb 2024 09:39:09 -0500
X-MC-Unique: 0HMhFc7UODeaRflfNH66Xw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65111185A780;
	Mon, 19 Feb 2024 14:39:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3AB65492BE2;
	Mon, 19 Feb 2024 14:39:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Daniil Dulov <d.dulov@aladdin.ru>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] afs: Miscellaneous fixes
Date: Mon, 19 Feb 2024 14:39:01 +0000
Message-ID: <20240219143906.138346-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Hi Christian,

Here are some fixes for afs, if you could take them?

 (1) Fix searching for the AFS fileserver record for an incoming callback
     in a mixed IPv4/IPv6 environment.

 (2) Fix the size of a buffer in afs_update_volume_status() to avoid
     overrunning it and use snprintf() as well.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-fixes

Thanks,
David

Daniil Dulov (1):
  afs: Increase buffer size in afs_update_volume_status()

Marc Dionne (1):
  afs: Fix ignored callbacks over ipv4

 fs/afs/internal.h |  6 ++----
 fs/afs/main.c     |  3 +--
 fs/afs/server.c   | 14 +++++---------
 fs/afs/volume.c   |  4 ++--
 4 files changed, 10 insertions(+), 17 deletions(-)


