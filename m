Return-Path: <linux-fsdevel+bounces-48250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 260FCAAC69F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 15:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B3127B4290
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5BC275117;
	Tue,  6 May 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MM1ooxSZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B37279919
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538696; cv=none; b=tukDlvNupDtIYZ1UhIlS5REkOLnA+oVKP3u+nyUHKr7s73x2z97O9ZU7HvEgnFXvJ1VtTTky9JCHqeqKfw9pI5a6LVcK9a5TUiWEkVeS1ZUdSmmxVYuYxfT4k8LG2CLlznlzLsHRKBO9Amb433iBYs7BtTtXa3jXZb0ooAnm9XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538696; c=relaxed/simple;
	bh=YUwIk/MUgZVDImrx7CL0rOp1pojouNJ/5zWviwTHO3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rtMHgAAnNlAHmwESgtmfB3poJ+RuoMs6qXDSRKJqerAcVDnNF7y1K8TgiGFth5JIxtXPlf/r2WxhWWevKYvxO9QMp7vpsOz37krMyWl8FUqiojTdO3/TPQXfmjoCNCAWXOOia5Z9LP6tA7bIakuNwBYXqKIDJu71fgwwHGZ2Viw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MM1ooxSZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746538694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FRDlHq9OYFR2plyoy4p/CDyb6oeH08x28ypDYsNxI+g=;
	b=MM1ooxSZW/Qx1CZUvrrCFO/UIjLRECLdRI2zDw16oPet37yCbg8uWvUhlKg+USrMx6KggU
	F2G+zlw8ymzUVVQQhVZ+wUraN9PBxNzxB1lzxjCnssgeNx3SS4g0RUIC5XKWwooXNK5/6f
	4335g5u98TIjlwZvAawnIkQHpaBOsZM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-JKduOJfVOT-xafKeiTQrng-1; Tue,
 06 May 2025 09:38:08 -0400
X-MC-Unique: JKduOJfVOT-xafKeiTQrng-1
X-Mimecast-MFC-AGG-ID: JKduOJfVOT-xafKeiTQrng_1746538686
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BBF51955D52;
	Tue,  6 May 2025 13:38:06 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.112])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A8F419560A3;
	Tue,  6 May 2025 13:38:05 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org
Subject: [PATCH v2 0/6] iomap: misc buffered write path cleanups and prep
Date: Tue,  6 May 2025 09:41:12 -0400
Message-ID: <20250506134118.911396-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi all,

Here's a bit more fallout and prep. work associated with the folio batch
prototype posted a while back [1]. Work on that is still pending so it
isn't included here, but based on the iter advance cleanups most of
these seemed worthwhile as standalone cleanups. Mainly this just cleans
up some of the helpers and pushes some pos/len trimming further down in
the write begin path.

The fbatch thing is still in prototype stage, but for context the intent
here is that it can mostly now just bolt onto the folio lookup path
because we can advance the range that is skipped and return the next
folio along with the folio subrange for the caller to process.

Thoughts, reviews, flames appreciated.

Brian

[1] https://lore.kernel.org/linux-fsdevel/20241213150528.1003662-1-bfoster@redhat.com/

v2:
- Split up warning in trim folio range helper.
- Use min() and min_not_zero() instead of open coding.
- Drop pos param from __iomap_write_begin() (folded into patch 6).
v1: https://lore.kernel.org/linux-fsdevel/20250430190112.690800-1-bfoster@redhat.com/

Brian Foster (6):
  iomap: resample iter->pos after iomap_write_begin() calls
  iomap: drop unnecessary pos param from iomap_write_[begin|end]
  iomap: drop pos param from __iomap_[get|put]_folio()
  iomap: helper to trim pos/bytes to within folio
  iomap: push non-large folio check into get folio path
  iomap: rework iomap_write_begin() to return folio offset and length

 fs/iomap/buffered-io.c | 100 ++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 42 deletions(-)

-- 
2.49.0


