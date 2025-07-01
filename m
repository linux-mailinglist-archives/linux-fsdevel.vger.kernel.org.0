Return-Path: <linux-fsdevel+bounces-53549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE84AF003F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9B94806A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B1F27F005;
	Tue,  1 Jul 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHmIUEV9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27726B77A
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387996; cv=none; b=R8rHeXnuOxIPm0TjdHGh4snpiTWcybT2t1JlLQzkDd4+15wGX2bXGTN9luZLb1LxNH2UmMTlzjzdviPO1AcGNzhtTtYLKXylRlzXHkzKy4iC98KMo7eJvIDdHli2UnZ77xgGni1MNdm80w3YEUHt1GDxb7F1DJYiifw4yhy1Otw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387996; c=relaxed/simple;
	bh=k9MauvzQIvqWp3SWrhpKagLstXio8ko2sPcSmNbEksA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HecckPrYmf1DgnQ7i8zzPnGJEgP8MDjsCDcsEuVg+xk2m1lkbLFv8+HVeM8PnczMLo0y/JSTHYdpvUhKO2bkxaSLJeiVE9GlR4AQtIYMJafKMYCJ5fZ3SkdewjHRZfTi3r1FSnl8dYi5Bl92O6HH6A6gMMC7cXjFX61bE9ObE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHmIUEV9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751387991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fv1m/REq542QHDUwFpe0EvRUIgovraC/sxaQrxdfiEc=;
	b=eHmIUEV9J3vWPBLZW058CzXMfuu7a2v3STNgK9er2Ou8CftHzS5Ui5MQ/tlHVyuezlgzzP
	IZjjUyRP/7cjNt8V/p21w8b/b6gvXd500jlexXR0ZbrqF0f8XXdmb8a7Z1wIyYjMHV0r5x
	LYiuBy5EhgYEv0pVq4IiKQwnh/HFDUI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-wrbuLkaMOQe8XXswe5BeAg-1; Tue,
 01 Jul 2025 12:39:48 -0400
X-MC-Unique: wrbuLkaMOQe8XXswe5BeAg-1
X-Mimecast-MFC-AGG-ID: wrbuLkaMOQe8XXswe5BeAg_1751387985
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A5EC180028C;
	Tue,  1 Jul 2025 16:39:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 06B1819560B2;
	Tue,  1 Jul 2025 16:39:41 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 09/13] smb: client: fix warning when reconnecting channel
Date: Tue,  1 Jul 2025 17:38:44 +0100
Message-ID: <20250701163852.2171681-10-dhowells@redhat.com>
In-Reply-To: <20250701163852.2171681-1-dhowells@redhat.com>
References: <20250701163852.2171681-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Paulo Alcantara <pc@manguebit.org>

When reconnecting a channel in smb2_reconnect_server(), a dummy tcon
is passed down to smb2_reconnect() with ->query_interface
uninitialized, so we can't call queue_delayed_work() on it.

Fix the following warning by ensuring that we're queueing the delayed
worker from correct tcon.

WARNING: CPU: 4 PID: 1126 at kernel/workqueue.c:2498 __queue_delayed_work+0x1d2/0x200
Modules linked in: cifs cifs_arc4 nls_ucs2_utils cifs_md4 [last unloaded: cifs]
CPU: 4 UID: 0 PID: 1126 Comm: kworker/4:0 Not tainted 6.16.0-rc3 #5 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-4.fc42 04/01/2014
Workqueue: cifsiod smb2_reconnect_server [cifs]
RIP: 0010:__queue_delayed_work+0x1d2/0x200
Code: 41 5e 41 5f e9 7f ee ff ff 90 0f 0b 90 e9 5d ff ff ff bf 02 00
00 00 e8 6c f3 07 00 89 c3 eb bd 90 0f 0b 90 e9 57 f> 0b 90 e9 65 fe
ff ff 90 0f 0b 90 e9 72 fe ff ff 90 0f 0b 90 e9
RSP: 0018:ffffc900014afad8 EFLAGS: 00010003
RAX: 0000000000000000 RBX: ffff888124d99988 RCX: ffffffff81399cc1
RDX: dffffc0000000000 RSI: ffff888114326e00 RDI: ffff888124d999f0
RBP: 000000000000ea60 R08: 0000000000000001 R09: ffffed10249b3331
R10: ffff888124d9998f R11: 0000000000000004 R12: 0000000000000040
R13: ffff888114326e00 R14: ffff888124d999d8 R15: ffff888114939020
FS:  0000000000000000(0000) GS:ffff88829f7fe000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe7a2b4038 CR3: 0000000120a6f000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 queue_delayed_work_on+0xb4/0xc0
 smb2_reconnect+0xb22/0xf50 [cifs]
 smb2_reconnect_server+0x413/0xd40 [cifs]
 ? __pfx_smb2_reconnect_server+0x10/0x10 [cifs]
 ? local_clock_noinstr+0xd/0xd0
 ? local_clock+0x15/0x30
 ? lock_release+0x29b/0x390
 process_one_work+0x4c5/0xa10
 ? __pfx_process_one_work+0x10/0x10
 ? __list_add_valid_or_report+0x37/0x120
 worker_thread+0x2f1/0x5a0
 ? __kthread_parkme+0xde/0x100
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x1fe/0x380
 ? kthread+0x10f/0x380
 ? __pfx_kthread+0x10/0x10
 ? local_clock_noinstr+0xd/0xd0
 ? ret_from_fork+0x1b/0x1f0
 ? local_clock+0x15/0x30
 ? lock_release+0x29b/0x390
 ? rcu_is_watching+0x20/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x15b/0x1f0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
irq event stamp: 1116206
hardirqs last  enabled at (1116205): [<ffffffff8143af42>] __up_console_sem+0x52/0x60
hardirqs last disabled at (1116206): [<ffffffff81399f0e>] queue_delayed_work_on+0x6e/0xc0
softirqs last  enabled at (1116138): [<ffffffffc04562fd>] __smb_send_rqst+0x42d/0x950 [cifs]
softirqs last disabled at (1116136): [<ffffffff823d35e1>] release_sock+0x21/0xf0

Cc: linux-cifs@vger.kernel.org
Reported-by: David Howells <dhowells@redhat.com>
Fixes: 42ca547b13a2 ("cifs: do not disable interface polling on failure")
Reviewed-by: David Howells <dhowells@redhat.com>
Tested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Steve French <sfrench@samba.org>
---
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/smb2pdu.c  | 10 ++++------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 318a8405d475..fdd95e5100cd 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1303,6 +1303,7 @@ struct cifs_tcon {
 	bool use_persistent:1; /* use persistent instead of durable handles */
 	bool no_lease:1;    /* Do not request leases on files or directories */
 	bool use_witness:1; /* use witness protocol */
+	bool dummy:1; /* dummy tcon used for reconnecting channels */
 	__le32 capabilities;
 	__u32 share_flags;
 	__u32 maximal_access;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 084ee66e73fd..572cfc42dda8 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -424,9 +424,9 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		free_xid(xid);
 		ses->flags &= ~CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES;
 
-		/* regardless of rc value, setup polling */
-		queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
-				   (SMB_INTERFACE_POLL_INTERVAL * HZ));
+		if (!tcon->ipc && !tcon->dummy)
+			queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
+					   (SMB_INTERFACE_POLL_INTERVAL * HZ));
 
 		mutex_unlock(&ses->session_mutex);
 
@@ -4229,10 +4229,8 @@ void smb2_reconnect_server(struct work_struct *work)
 		}
 		goto done;
 	}
-
 	tcon->status = TID_GOOD;
-	tcon->retry = false;
-	tcon->need_reconnect = false;
+	tcon->dummy = true;
 
 	/* now reconnect sessions for necessary channels */
 	list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {


