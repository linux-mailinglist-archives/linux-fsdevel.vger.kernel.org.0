Return-Path: <linux-fsdevel+bounces-34011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42EB9C1D2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 13:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B772E285E8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBBF1E907A;
	Fri,  8 Nov 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd++ZGVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666AD1E882A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069677; cv=none; b=bS8LukjKwkeV7sz8Kv8eRL3YC7F4xteobCNDvvOiQLq7nI+bOpKHteG9BwuLg/ki56Vj6laaiTGUwXRA8F6+fj7NXOOEtltx1cWZVIvT7eLLNGEX6KMJ00QqjoNzzCpgHBbiYRiX9Ch2jiQxBSiwCUUiU8ugqP6UDloEpsAGRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069677; c=relaxed/simple;
	bh=bfeazyVLDNa7XL3pFDsgJlV7rtKQexstAgfTISQB6xQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y8PnAy558522o4XDKHa7WpHrd9PEQnWvGgqLt3zqSdvwdfGU5oxCI0rN+51KDxUaxSwKCmdDQATban2c4J7PwD6jBV0OWv+NdnvZOn8AU25Ezm9wFiUI4x0bpsEqDPYlR+0pPkaYlWwCr3/jarCX3fnraYC9dTt+UiHkG1/UbWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bd++ZGVP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731069674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vlsVuRCO/ADhSqY2u1t41WWX4esAYFhpxR2WkDUlYNc=;
	b=bd++ZGVPqEviMCCkFq1Ajwx2G/cfFtfkdVdiEwkFraqqLqOphtkJr/AAorf0e+hzpwyfAk
	4czBpRP44UWi9P39x6favE0gH8kCV9z84IALFJgWfEySxkSkp/yvETifGnxuHre2ZWdQ82
	rtcxG85lXiS927iX5LxT85v/3CM2NOM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-bCDGTtgoM8GVg4TfP1ju0g-1; Fri,
 08 Nov 2024 07:41:13 -0500
X-MC-Unique: bCDGTtgoM8GVg4TfP1ju0g-1
X-Mimecast-MFC-AGG-ID: bCDGTtgoM8GVg4TfP1ju0g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CE6D19560B1
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:12 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.111])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7E381955F3D
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 12:41:11 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/4] iomap: zero range flush fixes
Date: Fri,  8 Nov 2024 07:42:42 -0500
Message-ID: <20241108124246.198489-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi all,

Here's v3 of the change to improve zero range performance in the case of
frequent size extensions leading to excessive flushing. The main
differences from v2 are the addition of patch 1 to replace the need for
an iter reinit helper, some minor cleanups, and the addition of patch 4
to detect unexpected uses of zero range now that it no longer updates
i_size.

Thoughts, reviews, flames appreciated.

Brian

v3:
- Added new patch 1 to always reset per-iter state in iomap_iter.
- Dropped iomap_iter_init() helper.
- Misc. cleanups.
- Appended patch 4 to warn on zeroing beyond EOF.
v2: https://lore.kernel.org/linux-fsdevel/20241031140449.439576-1-bfoster@redhat.com/
- Added patch 1 to lift zeroed mapping handling code into caller.
- Split unaligned start range handling at the top level.
- Retain existing conditional flush behavior (vs. unconditional flush)
  for the remaining range.
v1: https://lore.kernel.org/linux-fsdevel/20241023143029.11275-1-bfoster@redhat.com/

Brian Foster (4):
  iomap: reset per-iter state on non-error iter advances
  iomap: lift zeroed mapping handling into iomap_zero_range()
  iomap: elide flush from partial eof zero range
  iomap: warn on zero range of a post-eof folio

 fs/iomap/buffered-io.c | 89 ++++++++++++++++++++++--------------------
 fs/iomap/iter.c        | 11 +++---
 2 files changed, 51 insertions(+), 49 deletions(-)

-- 
2.47.0


