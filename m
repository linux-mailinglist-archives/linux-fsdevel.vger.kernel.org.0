Return-Path: <linux-fsdevel+bounces-59998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B52B4086A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8176D5E3FE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0692D3148D5;
	Tue,  2 Sep 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBUe9YYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07D30EF83
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825441; cv=none; b=pmdguBCsTkEVkVjrwHsvIz61jPBAa6X7KBTvLYsQ4bPfAqtm9uTwcp3XM2TLMfdhS9jOvMID4I8oj1B3/gDZwKKmFrtxcladlu3Cj9aI7Gkq2zr1ojbRxrMcX9xpXj1Ovs20jfik2SrV936G69nM31zGIwxnJH2nI0NlgvYuM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825441; c=relaxed/simple;
	bh=6fzz+EMD5jC2k9j7dsEylnmr/TBIqeij4QKykPjO1GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YvJ/6eOmWb1+mTuP7EF9SPa9h/9o3gq/h3S2gWkun35aW/tCCQ0SR9jczKUjhyHkOCrt/w1OzvpZx+nnIoIwMomF62Lpn4vjEMPaLm0YjO7CgKIrZvgOa438a1GYoFnfBsXjsKrLF8ku9bNOYetqIg59Y9qlRM4Pm4svxEa/yKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBUe9YYV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756825438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aTlYYfrFkQDxEE7DYKQuABe9Jl/Ap/8BenILIZenok4=;
	b=CBUe9YYVO8pkLSROldqmdyFOl19+TQJfmhKCITnmTP5jHJgROnKK0YraTnb6hHfKnjh2Ge
	VWYHjmie26XJqOljofGlwgx6uRzzxi/a9Xgi7E5H1BZMi0H7ncyXOqvc/5TDUJMQI104os
	qbtyjRcdrwL5hSXYkHRlsQjgpOSCLQ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-GepClqbSNxGqBPvdTtmidQ-1; Tue,
 02 Sep 2025 11:03:55 -0400
X-MC-Unique: GepClqbSNxGqBPvdTtmidQ-1
X-Mimecast-MFC-AGG-ID: GepClqbSNxGqBPvdTtmidQ_1756825433
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B49918002A9;
	Tue,  2 Sep 2025 15:03:53 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.88.143])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAFF518002A0;
	Tue,  2 Sep 2025 15:03:51 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: jack@suse.cz,
	djwong@kernel.org
Subject: [PATCH RFC 0/2] iomap: ->iomap_end() error handling fixes
Date: Tue,  2 Sep 2025 11:07:53 -0400
Message-ID: <20250902150755.289469-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi all,

This is a couple small error handling fixes for ->iomap_end() errors
(via iomap_iter()). The immediate problem here was that the
->iomap_end() error return started overriding an iter.status error code,
which on ext4 happened to trigger dio fallback to buffered I/O in some
cases. Jan has actually fixed that separately in ext4 [1], but I wanted
to take an independent look at iomap to see if it is worth fixing as
well.

The more I poked around the more it seemed like it's more appropriate to
return the initial error code in iter.status if one is pending. I also
eventually noticed the DAX vs. reflink case documented in patch 2, which
further tweaks the error handling and supports the former reasoning.

These are separate patches because they are separate issues, but I'm
still doing some testing and wanted to see if there was any initial
feedback before dropping the RFC. Thoughts?

Brian

[1] https://lore.kernel.org/linux-ext4/20250901112739.32484-2-jack@suse.cz/

Brian Foster (2):
  iomap: prioritize iter.status error over ->iomap_end()
  iomap: revert the iomap_iter pos on ->iomap_end() error

 fs/iomap/iter.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.51.0


