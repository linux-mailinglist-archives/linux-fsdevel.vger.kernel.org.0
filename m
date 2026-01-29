Return-Path: <linux-fsdevel+bounces-75877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDdbHA+Ce2mvFAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:51:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BEB1A8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 16:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 677AD303DAE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4F6338585;
	Thu, 29 Jan 2026 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duu1niGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8331AAA7
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701838; cv=none; b=ic5W504ef6lQl0XdkFOKB5sIg7rQH1QvOmy1I+FQRBKkDi3UbNZs3c61CFSBeW8yOV1WPGM25zVAT09zIUlixVOQR12VWjP+WojFr9j9MQxN+r3tZDEe061nMw9Sh6A98BK8xCejhO/PUZWGkH9k3lkmhePX/Vp0syisQ95WhMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701838; c=relaxed/simple;
	bh=+obdHtwl/4dPnbMylYX5zs+oa5cL7tHvzZQP2nLX7u0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qzdnzn0lArdBNZwYtlER6CSiGXrglQ/rVX/CjFjzKvv7WfEFC/iSK5r/9s81LzcUHcL2GlDEBi7JMgTCKDjIZoxXacqltRb40g5EiKq/HHX4tAGAg8L6Vv2q76pVoGhhpwLw7XSOF0TQro5ZCUGqRDf1vt/J3FHAzzW/6wQdBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duu1niGh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769701835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+HFio3eufWe4kWp7D9KOmJycjCFWxb9enB26dubt3w=;
	b=duu1niGh7G0RN3pNhAJWHy9tAaQv3a4ShjGnhLEQY8ZCI9bsvDHSNxef/lmVh4bmjISTQC
	S0hiFW2KUOUTXjQv0oVYJ+no78+exO8d0oLavQ/fvIFS8R9hO/dIMPaeI2D66aCLSv6yvV
	DJaSJYROUa9fxqded6W2uRMcPKcY2yY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-bzdsQyLVNJeDXeqrDJoAkQ-1; Thu,
 29 Jan 2026 10:50:31 -0500
X-MC-Unique: bzdsQyLVNJeDXeqrDJoAkQ-1
X-Mimecast-MFC-AGG-ID: bzdsQyLVNJeDXeqrDJoAkQ_1769701830
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4D4A18002C2;
	Thu, 29 Jan 2026 15:50:30 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.81.70])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3563F1800109;
	Thu, 29 Jan 2026 15:50:30 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v2 2/5] xfs: flush eof folio before insert range size update
Date: Thu, 29 Jan 2026 10:50:25 -0500
Message-ID: <20260129155028.141110-3-bfoster@redhat.com>
In-Reply-To: <20260129155028.141110-1-bfoster@redhat.com>
References: <20260129155028.141110-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75877-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 288BEB1A8C
X-Rspamd-Action: no action

The flush in xfs_buffered_write_iomap_begin() for zero range over a
data fork hole fronted by COW fork prealloc is primarily designed to
provide correct zeroing behavior in particular pagecache conditions.
As it turns out, this also partially masks some odd behavior in
insert range (via zero range via setattr).

Insert range bumps i_size the length of the new range, flushes,
unmaps pagecache and cancels COW prealloc, and then right shifts
extents from the end of the file back to the target offset of the
insert. Since the i_size update occurs before the pagecache flush,
this creates a transient situation where writeback around EOF can
behave differently.

This appears to be corner case situation, but if happens to be
fronted by COW fork speculative preallocation and a large, dirty
folio that contains at least one full COW block beyond EOF, the
writeback after i_size is bumped may remap that COW fork block into
the data fork within EOF. The block is zeroed and then shifted back
out to post-eof, but this is unexpected in that it leads to a
written post-eof data fork block. This can cause a zero range
warning on a subsequent size extension, because we should never find
blocks that require physical zeroing beyond i_size.

To avoid this quirk, flush the EOF folio before the i_size update
during insert range. The entire range will be flushed, unmapped and
invalidated anyways, so this should be relatively unnoticeable.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/xfs/xfs_file.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7874cf745af3..1f2730558165 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1227,6 +1227,23 @@ xfs_falloc_insert_range(
 	if (offset >= isize)
 		return -EINVAL;
 
+	/*
+	 * Let writeback clean up EOF folio state before we bump i_size. The
+	 * insert flushes before it starts shifting and under certain
+	 * circumstances we can write back blocks that should technically be
+	 * considered post-eof (and thus should not be submitted for writeback).
+	 *
+	 * For example, a large, dirty folio that spans EOF and is backed by
+	 * post-eof COW fork preallocation can cause block remap into the data
+	 * fork. This shifts back out beyond EOF, but creates an expectedly
+	 * written post-eof block. The insert is going to flush, unmap and
+	 * cancel prealloc across this whole range, so flush EOF now before we
+	 * bump i_size to provide consistent behavior.
+	 */
+	error = filemap_write_and_wait_range(inode->i_mapping, isize, isize);
+	if (error)
+		return error;
+
 	error = xfs_falloc_setsize(file, isize + len);
 	if (error)
 		return error;
-- 
2.52.0


