Return-Path: <linux-fsdevel+bounces-75481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJuANsmWd2n0iwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:31:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 431AD8AB01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588043043D33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A4F33D6FA;
	Mon, 26 Jan 2026 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3kb3h2C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F132AAA1
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444962; cv=none; b=Y/bxEYdq82/mtQ1hwzm2c6p+cxC5HF7nLpGyiksDYzy5h0S4xhHQ+6eJ5wsd5LCxrPRDlno/7sNPlRTx0n8ZwFm2Qa2z8va4wIlXCy1AF2jtcn9xe/ru5ZuLnL8VervBUi9RQaBTrG0G/y6Ofno5dKCf1DOrNBV3wGodCD66HpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444962; c=relaxed/simple;
	bh=/BzuY96VUuid9Wgkp8rOKhpU7ASQ53Fmo+LlNU8sXGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2vOo+i8pIKRdBfXtbMRLoaZWSgelqA1/UgQU4dE96T3wMMXgS+ymppkzoc9TA1luvgJCtIQYIB/5NWlF0mcQl8HQDQFrAfIv8e9bXTQdih6MHOZZAJVHODlihu9HKRLg6kr3w46ehbHBYbLlXdMa9JiWZ8Kwd9jZmp6XqIVyvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3kb3h2C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769444959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7O3BeL3ees7OgvGNiV0PAdVJiL4W2w8JfQBJFqz4bhc=;
	b=L3kb3h2Cge7gOjFKG/UNXvGbM8izmrNJyPMq+19FJho9iF2DVmUQn5Vqw54uCt+rPtQJEW
	jdyvRP19yi67vSZZIwObc7+VVGRdquLzdYg0H3O8l1ayYNeGVkntCQCSGcPDYru2A99J45
	95wjLkfLbHRtdkNwtlG5jClpFQlF6pU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-LnR-Bu9GO0axhv7i2t0jfw-1; Mon,
 26 Jan 2026 11:29:18 -0500
X-MC-Unique: LnR-Bu9GO0axhv7i2t0jfw-1
X-Mimecast-MFC-AGG-ID: LnR-Bu9GO0axhv7i2t0jfw_1769444957
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 066001955D84;
	Mon, 26 Jan 2026 16:29:17 +0000 (UTC)
Received: from f43vm.redhat.com (unknown [10.45.224.161])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 597821956095;
	Mon, 26 Jan 2026 16:29:14 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Sergio Lopez <slp@redhat.com>
Subject: [PATCH] fuse: mark DAX inode releases as blocking
Date: Mon, 19 Jan 2026 00:24:11 +0100
Message-ID: <20260118232411.536710-1-slp@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	DATE_IN_PAST(1.00)[185];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75481-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slp@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 431AD8AB01
X-Rspamd-Action: no action

Commit 26e5c67deb2e ("fuse: fix livelock in synchronous file put from
fuseblk workers") made fputs on closing files always asynchronous.

As cleaning up DAX inodes may require issuing a number of synchronous
request for releasing the mappings, completing the release request from
the worker thread may lead to it hanging like this:

[   21.386751] Workqueue: events virtio_fs_requests_done_work
[   21.386769] Call trace:
[   21.386770]  __switch_to+0xe4/0x140
[   21.386780]  __schedule+0x294/0x72c
[   21.386787]  schedule+0x24/0x90
[   21.386794]  request_wait_answer+0x184/0x298
[   21.386799]  __fuse_simple_request+0x1f4/0x320
[   21.386805]  fuse_send_removemapping+0x80/0xa0
[   21.386810]  dmap_removemapping_list+0xac/0xfc
[   21.386814]  inode_reclaim_dmap_range.constprop.0+0xd0/0x204
[   21.386820]  fuse_dax_inode_cleanup+0x28/0x5c
[   21.386825]  fuse_evict_inode+0x120/0x190
[   21.386834]  evict+0x188/0x320
[   21.386847]  iput_final+0xb0/0x20c
[   21.386854]  iput+0xa0/0xbc
[   21.386862]  fuse_release_end+0x18/0x2c
[   21.386868]  fuse_request_end+0x9c/0x2c0
[   21.386872]  virtio_fs_request_complete+0x150/0x384
[   21.386879]  virtio_fs_requests_done_work+0x18c/0x37c
[   21.386885]  process_one_work+0x15c/0x2e8
[   21.386891]  worker_thread+0x278/0x480
[   21.386898]  kthread+0xd0/0xdc
[   21.386902]  ret_from_fork+0x10/0x20

Here, the virtio-fs worker_thread is waiting on request_wait_answer()
for a reply from the virtio-fs server that is already in the virtqueue
but will never be processed since it's that same worker thread the one
in charge of consuming the elements from the virtqueue.

To address this issue, when relesing a DAX inode mark the operation as
potentially blocking. Doing this will ensure these release requests are
processed on a different worker thread.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 fs/fuse/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3b2a171e652f..a65c5d32a34b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -117,6 +117,12 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 			fuse_simple_request(ff->fm, args);
 			fuse_release_end(ff->fm, args, 0);
 		} else {
+			/*
+			 * DAX inodes may need to issue a number of synchronous
+			 * request for clearing the mappings.
+			 */
+			if (ra && ra->inode && FUSE_IS_DAX(ra->inode))
+				args->may_block = true;
 			args->end = fuse_release_end;
 			if (fuse_simple_background(ff->fm, args,
 						   GFP_KERNEL | __GFP_NOFAIL))
-- 
2.52.0


