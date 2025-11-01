Return-Path: <linux-fsdevel+bounces-66655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 370B6C27960
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 09:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC6774E06A2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761AA26F2B6;
	Sat,  1 Nov 2025 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/qeneAn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF826B74A
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761984568; cv=none; b=q8z758hZ8Wm787G/VNh5hv9e9Qs2uMu4WXSe5MZ4OTcX0nQvg+gRi1gLNtiJx+89XOgdKAYhCM8r8EJippwti1eT6uDkxBZ4TGjhYr1Yl6qWMiw9VdvpV/Uuxfcc0s8pHCvYzB2kCDUCGleGNJ4BKapR+2mztMBnDxFkFcMDFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761984568; c=relaxed/simple;
	bh=6weTYzqO11W7vUz/+Lxzf4Trg4vOwofFdRRglKtfE0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+cFJYF0I7QulURKwtZIIzurdlWUuZK3RKG1eAqCLFSY2731+r7J4Kp0fdM4Q2e59xfEfu/jL9eNqaXjZLgWweOqI8QwoRsPJotvwZvXS+WQLMcFrjPmTcEodQZrY69SX8aDxTcWUkujOacHgJ0rXmpD7B9gPGPQv9HHOaHj4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/qeneAn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761984565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9t6HRTvKO8eeiNCnIxk4LWupor3SqkoWYueS8/rqkUI=;
	b=L/qeneAnYfi4/o5lAeQ4HI/6h9f5GxxyDl+3mpp1GxpD3ULP+OOC0TrGg1iTsL0Lg8JAC2
	PKeeZjTEYzMwdbdRnXjGO32Xx+5W4JojLGDjYQbI68S3x8VSTQSSOo64aLXyHSVkTyxYkW
	3S2qmLm9cc+EZvWeiw7iPYxPOsOlmLU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-VNKFMFBZPIuSWH08Mr08pg-1; Sat,
 01 Nov 2025 04:09:24 -0400
X-MC-Unique: VNKFMFBZPIuSWH08Mr08pg-1
X-Mimecast-MFC-AGG-ID: VNKFMFBZPIuSWH08Mr08pg_1761984563
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D36AC180035A;
	Sat,  1 Nov 2025 08:09:22 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B51119560B7;
	Sat,  1 Nov 2025 08:09:20 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/5] gfs2 non-blocking lookup
Date: Sat,  1 Nov 2025 08:09:14 +0000
Message-ID: <20251101080919.1290117-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch queue implements non-blocking lookup in gfs2.

A previous attempt to implement this feature was made in December 2023
[1], but issues were found [2] and that attempt was aborted.  This new
implementation should be free of those problems.

Please review.

Thanks,
Andreas

[1] https://lore.kernel.org/gfs2/20231220202457.1581334-2-agruenba@redhat.com/
[2] https://lore.kernel.org/gfs2/20240119212056.805617-1-agruenba@redhat.com/


Andreas Gruenbacher (5):
  gfs2: No d_revalidate op for "lock_nolock" mounts
  gfs2: Get rid of had_lock in gfs2_drevalidate
  gfs2: Use unique tokens for gfs2_revalidate
  gfs2: Enable non-blocking lookup in gfs2_permission
  Revert "gfs2: Add GL_NOBLOCK flag"

 fs/gfs2/dentry.c     | 63 +++++++++++++++++++++++++++++---------------
 fs/gfs2/glock.c      | 39 +--------------------------
 fs/gfs2/glock.h      |  1 -
 fs/gfs2/glops.c      | 15 +++++++++--
 fs/gfs2/incore.h     |  1 +
 fs/gfs2/inode.c      | 20 +++++++++-----
 fs/gfs2/ops_fstype.c |  6 ++++-
 fs/gfs2/super.h      |  1 +
 8 files changed, 76 insertions(+), 70 deletions(-)

-- 
2.51.0


