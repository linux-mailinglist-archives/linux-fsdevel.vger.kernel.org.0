Return-Path: <linux-fsdevel+bounces-79776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I7eNdfPrmnEIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 14:49:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35375239FF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 14:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D4363081BF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6EC3AA1AE;
	Mon,  9 Mar 2026 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNLZZlNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB4E27A462
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063912; cv=none; b=PxIk7bYT8K6ims3hT7m1/h8M3fJxSCpmrjdtKzdOZhVHjGmVmNS9YZr+JAf1mdN1v+gUcb384LoGFz+Xp2FB0j51y9UXAW9EChrXfzDYfLRJD6euFenunw8zU4iRRGGhCGbfgFnwZW5nKchSPSNGiiyZC0RcJr4ppUP1BItxQ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063912; c=relaxed/simple;
	bh=JW1hWlBxe0cHIzUOPib4iFHW1u327Sc33VpsPuFjAiM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HFV9rZa5AGae+DcReF6XuvgMB+VIlkJtDZ/eF2rrrvnDCf986dyViVmO6vyJNvSrERB3ogAR3F1glW9g2/aebZURd8ZKrpP5STeWCjRW2UfDZ4Sk8cI3S2He9sWzeHugieWCQTDDxBBUaZSN0y33Ddz8D/aHAcUrZfaWBG25QKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNLZZlNo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773063910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PUrP3CspI6tpbi7cIMO9xFrb2RcdQqNNn0BdJmA2SwE=;
	b=MNLZZlNo8dWAWeYge4nUBpEkOc0y4UI/k39FNO6bG8klYb99Yz14mhp72xl+jpxL9LHKI7
	tDYWsNSxPBlLNKGsMa//VEashefgWDJ/+YzHTFI4Ef+mh8+A8pn6p3/el9cjInQy7RuU3K
	gTCtYofxxQ/iLacTBpx9EdVL/zKds4U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-uw2cmZLFPfSXCpYd3EaqwQ-1; Mon,
 09 Mar 2026 09:45:09 -0400
X-MC-Unique: uw2cmZLFPfSXCpYd3EaqwQ-1
X-Mimecast-MFC-AGG-ID: uw2cmZLFPfSXCpYd3EaqwQ_1773063908
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 274B819560AD;
	Mon,  9 Mar 2026 13:45:08 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.89.107])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9599E18002A6;
	Mon,  9 Mar 2026 13:45:07 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v3 0/8] iomap, xfs: improve zero range flushing and lookup
Date: Mon,  9 Mar 2026 09:44:58 -0400
Message-ID: <20260309134506.167663-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 35375239FF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79776-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi all,

Here's v3 of the patches to lift and replace the hole mapping pagecache
flush logic from iomap into XFS and clean it up. The major changes from
v2 are the addition of patches 1, 2 and 8.

Christoph discovered a regression with zero range in zoned mode on v2 of
the series. The problem is that the zoned mode iomap_begin() relied on
the hole mapping flush to handle the case where writes are pending but
blocks have not yet been mapped into the data fork for the first time.
Patches 1-2 lift the flush into the begin handler, document the purpose,
and clean up the logic a bit. They are inserted at the beginning of the
series to avoid regression from removing the flush from iomap in patch
3, but ordering is not critical as zoned support is experimental.

Patch 8 changes the normal buffered write iomap_begin() handler to no
longer report a hole in the situation where we have dirty pagecache
backed by COW fork blocks and a data fork hole. Since the main
differentiator between representing this case as a hole or data mapping
is pagecache, the folio lookup provides a straightforward way to
distinguish between the two.

Otherwise v3 includes some miscellaneous updates to logic, comments,
whitespace, etc. based on feedback to v2.

Brian

v3:
- Inserted new patches 1-2 to fix up zoned mode zeroing.
- Appended patch 8 to correctly report COW mappings backed by data fork
  holes.
- Various minor fixups to logic, whitespace, comments.
v2: https://lore.kernel.org/linux-fsdevel/20260129155028.141110-1-bfoster@redhat.com/
- Patch 1 from v1 merged separately.
- Fixed up iomap_fill_dirty_folios() call in patch 5.
v1: https://lore.kernel.org/linux-fsdevel/20251016190303.53881-1-bfoster@redhat.com/

Brian Foster (8):
  xfs: fix iomap hole map reporting for zoned zero range
  xfs: flush dirty pagecache over hole in zoned mode zero range
  iomap, xfs: lift zero range hole mapping flush into xfs
  xfs: flush eof folio before insert range size update
  xfs: look up cow fork extent earlier for buffered iomap_begin
  xfs: only flush when COW fork blocks overlap data fork holes
  xfs: replace zero range flush with folio batch
  xfs: report cow mappings with dirty pagecache for iomap zero range

 fs/iomap/buffered-io.c |   6 +-
 fs/xfs/xfs_file.c      |  17 +++++
 fs/xfs/xfs_iomap.c     | 145 +++++++++++++++++++++++++++++++----------
 3 files changed, 129 insertions(+), 39 deletions(-)

-- 
2.52.0


