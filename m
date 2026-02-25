Return-Path: <linux-fsdevel+bounces-78374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAx9G3nynmnoXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 14:00:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 138C7197BC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 14:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D31B30D63B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507EE3B8BC5;
	Wed, 25 Feb 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUs1I40t";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tpD0nD3D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2F3AE71E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024362; cv=none; b=LX+oYDeV2/BKlVsGJjEXjhptk0jViAfAD60LBEZdcjCW9EzY90Jw8sWr5OhU2aMrx6LYa/jrkVziUhksyxpkrb7hi41Gu/G1qzROiFSOIgRNiv3PmEJiUZJiUtOICstUtiV+bTvjSD+b1EZhrlUhmSZsF2cKXyVA/Xt/tgA/G5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024362; c=relaxed/simple;
	bh=QOLcc0x0ajl2WtHbsX/Ds5HVjkfNjVfJeJxz9KGYP/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWr8FsO5zS5GThnKuJbDD8HIYWy0eaCv68Pon0Bw3L/PXg9gQaBsai2pvcZ25oRR9cVAqsP/D0cD9hsQiks1zFoc5A6cHMB5ZalfJUwpzWeqWcKkZzyRA0OevT13WrrGUGkx3zogFs6ovzfN5OGRNF1yu0WHGeRuFPj9I2tVq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUs1I40t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tpD0nD3D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772024359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwFbiRJjGmz8nZkh/CBCEiAU5t2Q90iowvriaa+PBnY=;
	b=YUs1I40t1luYNMmQGw2wJNXme4eKTi9DEZFX3zYVl+xPK6WnOqDIws71LyA9d3zRduQAs+
	oqTTu0OZS4SSOrDdWMa8WGV1yPXxr5ptM4XoRxJ2Fr4aAb0JMKTxMlviPvX6r4G38Z8hxp
	EMh86/zxIcHd+ieyUiFLQLZs3/vq7IE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-oumXzYlxNPqEExxtlS1o7Q-1; Wed, 25 Feb 2026 07:59:18 -0500
X-MC-Unique: oumXzYlxNPqEExxtlS1o7Q-1
X-Mimecast-MFC-AGG-ID: oumXzYlxNPqEExxtlS1o7Q_1772024358
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb3b0d938dso5845841085a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 04:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772024358; x=1772629158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwFbiRJjGmz8nZkh/CBCEiAU5t2Q90iowvriaa+PBnY=;
        b=tpD0nD3DKXE0jlfycmMDSkZ/9Myy7cVAGh0VyB8A3X0arEiOamVNcrXxBFKf2XVKSF
         Z8GUh/1v5VOWEbxaBqRnO3HO7SLqFLOW/9gAA9SIsTyCw/0PhiZKHRx0LLAxzSvN/OIj
         ncdmOtZfxUMIXNpCE9HIl0kcAzoYyRwYFq1OlWIfGSiAMUC+0tCcnMf9Rw9ijNfHqabu
         I0jnS3S/EabvD/8jG06kb9+3oBKq/WIyrOW6/sVsuVVoYbOvpAz5628/SQ7DmUp0sTYN
         v6q0zYpiHD3U+vTmizNE91m2t/X/81KH7DeRVFDSi/P2sbnz36g03CNJ1vUOshD9gzzX
         xNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024358; x=1772629158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IwFbiRJjGmz8nZkh/CBCEiAU5t2Q90iowvriaa+PBnY=;
        b=d8DbMh+DH9r8WG6FadF/D7l04zXEi1dQB54rT2VGFYMqwG1tNfw4P9YTpJdHXp1aLZ
         BLPh2FrkQrF9XnsA4GP53Rp+BXPBFttsk0n9k1Zd+fRlFmHCSKfyWXnlNjQIZZWKcXa+
         rEop2FuKW/22yQVR0myC/OZZlDa6TzHjYXqQMTf6ZX0AgmRFeh64wszFXQa9DqMB/f2a
         UNRPwQPeKPXwll5+7rkRI5L6pWIOqgaNsf8xkv7s6TuSd3ate6opQb9Kdb/ir6V87ZFn
         msJ6k8JbWpCzVCgY7kA24HgXPUA21F03ryDXmNF78iDzaKZLNIOvesatgZqAo3jZ2HY9
         XICQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoVS+QsbJwAhfZ9YfLQFBk4GlVVefOcUHz7D/cH4j+z6+eqUO3U3mbiheSR5J+JalAA/3/LnQezGf/Z5EU@vger.kernel.org
X-Gm-Message-State: AOJu0YwiqoJ/2wcbYt5w2OWKHKfUFc4+kWMdXwWknltkTkIXZC1DYmaD
	J2DoT+cPObanfzQCicZpbTX5uR0zJg9QHdDsRbANXSVBrxdXi8iGw0RQyU5eNpb5QfsL6/3rAFB
	9BqltQ0hxZB8RtzssbvDxVQ6Cqb89Udf48abm44KbcuZGj+kjuVjeBhLOGu/IpbXLA5tFGP/0Da
	vv0fDl
X-Gm-Gg: ATEYQzyt2lMaxMSM2Gt61mejOjs/nCSJdgLHQj3pgxiizvOpZM5yBG0gw3dmj0U2Zob
	NhqFvzE0huus84UvN0LJBmc13Tpdoz7YtP6UXTIUznwoBFHJtKxKFuFY7w5/4bqZREsmqKuXbd9
	GdMZ8qYTKNGs4bAdn6y96uSvAFsYpNIRqFZvliYicUiqsp4ZHsT4AHeVA5FwrTeEtRl620UxXfB
	5oAFxmICeBxKDv++OiNomjxCyRbKBZmOXRk4pj+AKRBXsVT+BR4M8k2dG3Cy5qThch/1QdUs58T
	MR02QQXUdW19p/90g9v/Hv9MwPWLWxTfUhUWfHSgh83i2oYnQDzFFMhKhScYPO7J/GjMexEgLza
	sBWegOZfL3+nb5vTwv40oqip6LR4mPDOxK5rN3oJQQCHoOib35mr8M7c=
X-Received: by 2002:a05:620a:7118:b0:8ca:305b:749b with SMTP id af79cd13be357-8cb8ca77b59mr1694007185a.60.1772024357469;
        Wed, 25 Feb 2026 04:59:17 -0800 (PST)
X-Received: by 2002:a05:620a:7118:b0:8ca:305b:749b with SMTP id af79cd13be357-8cb8ca77b59mr1694003785a.60.1772024356815;
        Wed, 25 Feb 2026 04:59:16 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046055sm1514219685a.8.2026.02.25.04.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:59:16 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH v1 3/4] ceph: implement manual client session reset via debugfs
Date: Wed, 25 Feb 2026 12:59:06 +0000
Message-Id: <20260225125907.53851-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225125907.53851-1-amarkuze@redhat.com>
References: <20260225125907.53851-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78374-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[amarkuze@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 138C7197BC7
X-Rspamd-Action: no action

Add a mechanism for operators to trigger MDS session reconnection
without unmounting the filesystem. This is useful for recovering
from stuck or hung MDS sessions in production environments.

The reset lifecycle:
  1. Operator writes to /sys/kernel/debug/ceph/<fsid>/reset/trigger
  2. A work item collects all active sessions and calls
     send_mds_reconnect() on each with from_reset=true
  3. New metadata requests and lock acquisitions are blocked
     (with a 120s timeout) until the reset completes
  4. Session reconnect completions are tracked via a per-session
     generation counter (s_reset_gen) to avoid counting stale
     completions from timed-out prior resets
  5. The reset work waits up to 60s for all sessions to reconnect

Debugfs interface under reset/:
  - trigger (write-only): initiate a reset with optional reason
  - status (read-only): show counters and current state
  - inject_error (write-only): fault injection for testing

Lock handling during reset-initiated reconnects always attempts
optimistic lock reclamation (flock_len=1) regardless of the
CEPH_I_ERROR_FILELOCK state, since the reset is meant to recover
from exactly those error conditions.

Tracepoints are added for the reset lifecycle:
ceph_client_reset_schedule, ceph_client_reset_complete,
ceph_client_reset_blocked, ceph_client_reset_unblocked.

Note: Reset tracepoints added to include/trace/events/ceph.h
(merged with existing upstream tracepoint infrastructure) instead
of the separate ceph_client.h from the original patch.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/debugfs.c           | 171 +++++++++++++-
 fs/ceph/locks.c             |  16 ++
 fs/ceph/mds_client.c        | 444 +++++++++++++++++++++++++++++++++++-
 fs/ceph/mds_client.h        |  33 +++
 fs/ceph/super.h             |   4 +
 include/trace/events/ceph.h |  60 +++++
 6 files changed, 707 insertions(+), 21 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index f3fe786b4143..b6d957a90043 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -9,6 +9,8 @@
 #include <linux/seq_file.h>
 #include <linux/math64.h>
 #include <linux/ktime.h>
+#include <linux/uaccess.h>
+#include <linux/kstrtox.h>
 
 #include <linux/ceph/libceph.h>
 #include <linux/ceph/mon_client.h>
@@ -22,6 +24,10 @@
 #include "mds_client.h"
 #include "metric.h"
 
+#define CEPH_DEBUGFS_MODE_READONLY 0400
+#define CEPH_DEBUGFS_MODE_WRITEONLY 0200
+#define CEPH_DEBUGFS_MODE_READWRITE 0600
+
 static int mdsmap_show(struct seq_file *s, void *p)
 {
 	int i;
@@ -360,16 +366,140 @@ static int status_show(struct seq_file *s, void *p)
 	return 0;
 }
 
+static int reset_status_show(struct seq_file *s, void *p)
+{
+	struct ceph_fs_client *fsc = s->private;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
+	struct ceph_client_reset_state *st;
+	u64 trigger = 0, success = 0, failure = 0;
+	unsigned long last_start = 0, last_finish = 0;
+	int last_errno = 0;
+	bool in_progress = false;
+	bool inject_error = false;
+	int pending_reconnects = 0;
+	int blocked_requests = 0;
+	char reason[CEPH_CLIENT_RESET_REASON_LEN];
+
+	if (!mdsc)
+		return 0;
+
+	st = &mdsc->reset_state;
+
+	spin_lock(&st->lock);
+	trigger = st->trigger_count;
+	success = st->success_count;
+	failure = st->failure_count;
+	last_start = st->last_start;
+	last_finish = st->last_finish;
+	last_errno = st->last_errno;
+	in_progress = st->in_progress;
+	inject_error = st->inject_error;
+	strscpy(reason, st->last_reason, sizeof(reason));
+	spin_unlock(&st->lock);
+
+	pending_reconnects = atomic_read(&st->pending_reconnects);
+	blocked_requests = atomic_read(&st->blocked_requests);
+
+	seq_printf(s, "in_progress: %s\n", in_progress ? "yes" : "no");
+	seq_printf(s, "trigger_count: %llu\n", trigger);
+	seq_printf(s, "success_count: %llu\n", success);
+	seq_printf(s, "failure_count: %llu\n", failure);
+	if (last_start)
+		seq_printf(s, "last_start_ms_ago: %u\n",
+			   jiffies_to_msecs(jiffies - last_start));
+	else
+		seq_puts(s, "last_start_ms_ago: (never)\n");
+	if (last_finish)
+		seq_printf(s, "last_finish_ms_ago: %u\n",
+			   jiffies_to_msecs(jiffies - last_finish));
+	else
+		seq_puts(s, "last_finish_ms_ago: (never)\n");
+	seq_printf(s, "last_errno: %d\n", last_errno);
+	seq_printf(s, "last_reason: %s\n",
+		   reason[0] ? reason : "(none)");
+	seq_printf(s, "inject_error_pending: %s\n",
+		   inject_error ? "yes" : "no");
+	seq_printf(s, "pending_reconnects: %d\n", pending_reconnects);
+	seq_printf(s, "blocked_requests: %d\n", blocked_requests);
+
+	return 0;
+}
+
+static ssize_t reset_trigger_write(struct file *file, const char __user *buf,
+				   size_t len, loff_t *ppos)
+{
+	struct ceph_fs_client *fsc = file->private_data;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
+	char reason[CEPH_CLIENT_RESET_REASON_LEN];
+	size_t copy;
+	int ret;
+
+	if (!mdsc)
+		return -ENODEV;
+
+	copy = min_t(size_t, len, sizeof(reason) - 1);
+	if (copy && copy_from_user(reason, buf, copy))
+		return -EFAULT;
+	reason[copy] = '\0';
+	strim(reason);
+
+	ret = ceph_mdsc_schedule_reset(mdsc, reason);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t reset_inject_error_write(struct file *file,
+					const char __user *buf,
+					size_t len, loff_t *ppos)
+{
+	struct ceph_fs_client *fsc = file->private_data;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
+	struct ceph_client_reset_state *st;
+	bool enable;
+	int ret;
+
+	if (!mdsc)
+		return -ENODEV;
+
+	ret = kstrtobool_from_user(buf, len, &enable);
+	if (ret)
+		return ret;
+
+	st = &mdsc->reset_state;
+	spin_lock(&st->lock);
+	st->inject_error = enable;
+	spin_unlock(&st->lock);
+
+	return len;
+}
+
 DEFINE_SHOW_ATTRIBUTE(mdsmap);
 DEFINE_SHOW_ATTRIBUTE(mdsc);
 DEFINE_SHOW_ATTRIBUTE(caps);
 DEFINE_SHOW_ATTRIBUTE(mds_sessions);
 DEFINE_SHOW_ATTRIBUTE(status);
+DEFINE_SHOW_ATTRIBUTE(reset_status);
 DEFINE_SHOW_ATTRIBUTE(metrics_file);
 DEFINE_SHOW_ATTRIBUTE(metrics_latency);
 DEFINE_SHOW_ATTRIBUTE(metrics_size);
 DEFINE_SHOW_ATTRIBUTE(metrics_caps);
 
+static const struct file_operations ceph_reset_trigger_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = reset_trigger_write,
+	.llseek = noop_llseek,
+};
+
+static const struct file_operations ceph_reset_inject_error_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = reset_inject_error_write,
+	.llseek = noop_llseek,
+};
+
 
 /*
  * debugfs
@@ -404,6 +534,10 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
 	debugfs_remove(fsc->debugfs_caps);
 	debugfs_remove(fsc->debugfs_status);
 	debugfs_remove(fsc->debugfs_mdsc);
+	debugfs_remove(fsc->debugfs_reset_status);
+	debugfs_remove(fsc->debugfs_reset_force);
+	debugfs_remove(fsc->debugfs_reset_inject);
+	debugfs_remove_recursive(fsc->debugfs_reset_dir);
 	debugfs_remove_recursive(fsc->debugfs_metrics_dir);
 	doutc(fsc->client, "done\n");
 }
@@ -415,7 +549,7 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 	doutc(fsc->client, "begin\n");
 	fsc->debugfs_congestion_kb =
 		debugfs_create_file("writeback_congestion_kb",
-				    0600,
+				    CEPH_DEBUGFS_MODE_READWRITE,
 				    fsc->client->debugfs_dir,
 				    fsc,
 				    &congestion_kb_fops);
@@ -428,31 +562,48 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 				       name);
 
 	fsc->debugfs_mdsmap = debugfs_create_file("mdsmap",
-					0400,
+					CEPH_DEBUGFS_MODE_READONLY,
 					fsc->client->debugfs_dir,
 					fsc,
 					&mdsmap_fops);
 
 	fsc->debugfs_mds_sessions = debugfs_create_file("mds_sessions",
-					0400,
+					CEPH_DEBUGFS_MODE_READONLY,
 					fsc->client->debugfs_dir,
 					fsc,
 					&mds_sessions_fops);
 
 	fsc->debugfs_mdsc = debugfs_create_file("mdsc",
-						0400,
+						CEPH_DEBUGFS_MODE_READONLY,
 						fsc->client->debugfs_dir,
 						fsc,
 						&mdsc_fops);
 
 	fsc->debugfs_caps = debugfs_create_file("caps",
-						0400,
+						CEPH_DEBUGFS_MODE_READONLY,
 						fsc->client->debugfs_dir,
 						fsc,
 						&caps_fops);
 
+	fsc->debugfs_reset_dir = debugfs_create_dir("reset",
+						    fsc->client->debugfs_dir);
+	if (fsc->debugfs_reset_dir) {
+		fsc->debugfs_reset_force =
+			debugfs_create_file("trigger", CEPH_DEBUGFS_MODE_WRITEONLY,
+					    fsc->debugfs_reset_dir, fsc,
+					    &ceph_reset_trigger_fops);
+		fsc->debugfs_reset_status =
+			debugfs_create_file("status", CEPH_DEBUGFS_MODE_READONLY,
+					    fsc->debugfs_reset_dir, fsc,
+					    &reset_status_fops);
+		fsc->debugfs_reset_inject =
+			debugfs_create_file("inject_error", CEPH_DEBUGFS_MODE_WRITEONLY,
+					    fsc->debugfs_reset_dir, fsc,
+					    &ceph_reset_inject_error_fops);
+	}
+
 	fsc->debugfs_status = debugfs_create_file("status",
-						  0400,
+						  CEPH_DEBUGFS_MODE_READONLY,
 						  fsc->client->debugfs_dir,
 						  fsc,
 						  &status_fops);
@@ -460,13 +611,13 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
 	fsc->debugfs_metrics_dir = debugfs_create_dir("metrics",
 						      fsc->client->debugfs_dir);
 
-	debugfs_create_file("file", 0400, fsc->debugfs_metrics_dir, fsc,
+	debugfs_create_file("file", CEPH_DEBUGFS_MODE_READONLY, fsc->debugfs_metrics_dir, fsc,
 			    &metrics_file_fops);
-	debugfs_create_file("latency", 0400, fsc->debugfs_metrics_dir, fsc,
+	debugfs_create_file("latency", CEPH_DEBUGFS_MODE_READONLY, fsc->debugfs_metrics_dir, fsc,
 			    &metrics_latency_fops);
-	debugfs_create_file("size", 0400, fsc->debugfs_metrics_dir, fsc,
+	debugfs_create_file("size", CEPH_DEBUGFS_MODE_READONLY, fsc->debugfs_metrics_dir, fsc,
 			    &metrics_size_fops);
-	debugfs_create_file("caps", 0400, fsc->debugfs_metrics_dir, fsc,
+	debugfs_create_file("caps", CEPH_DEBUGFS_MODE_READONLY, fsc->debugfs_metrics_dir, fsc,
 			    &metrics_caps_fops);
 	doutc(fsc->client, "done\n");
 }
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 2f21574dfb99..079947a5e42a 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -251,6 +251,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int err = 0;
 	u16 op = CEPH_MDS_OP_SETFILELOCK;
@@ -281,6 +282,13 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 		return err;
 	}
 
+	/* Wait for reset to complete before acquiring new locks */
+	if (op == CEPH_MDS_OP_SETFILELOCK && !lock_is_unlock(fl)) {
+		err = ceph_mdsc_wait_for_reset(mdsc);
+		if (err)
+			return err;
+	}
+
 	if (lock_is_read(fl))
 		lock_cmd = CEPH_LOCK_SHARED;
 	else if (lock_is_write(fl))
@@ -317,6 +325,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int err = 0;
 	u8 wait = 0;
@@ -340,6 +349,13 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 		return err;
 	}
 
+	/* Wait for reset to complete before acquiring new locks */
+	if (!lock_is_unlock(fl)) {
+		err = ceph_mdsc_wait_for_reset(mdsc);
+		if (err)
+			return err;
+	}
+
 	if (IS_SETLKW(cmd))
 		wait = 1;
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index e27f2f148dea..d350bf502a15 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -12,6 +12,7 @@
 #include <linux/bits.h>
 #include <linux/ktime.h>
 #include <linux/bitmap.h>
+#include <linux/workqueue.h>
 #include <linux/mnt_idmapping.h>
 
 #include "super.h"
@@ -61,12 +62,16 @@ struct ceph_reconnect_state {
 	struct ceph_pagelist *pagelist;
 	unsigned msg_version;
 	bool allow_multi;
+	bool from_reset;
 };
 
 static void __wake_requests(struct ceph_mds_client *mdsc,
 			    struct list_head *head);
 static void ceph_cap_release_work(struct work_struct *work);
 static void ceph_cap_reclaim_work(struct work_struct *work);
+static void ceph_mdsc_reset_workfn(struct work_struct *work);
+static void ceph_mdsc_reconnect_session_done(struct ceph_mds_client *mdsc,
+					     struct ceph_mds_session *session);
 
 static const struct ceph_connection_operations mds_con_ops;
 
@@ -3742,6 +3747,22 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
 	struct ceph_client *cl = mdsc->fsc->client;
 	int err = 0;
 
+	/*
+	 * If a reset is in progress, wait for it to complete.
+	 *
+	 * This is best-effort: a request can pass this check just
+	 * before in_progress is set and proceed concurrently with
+	 * reset.  That is acceptable because (a) such requests will
+	 * either complete normally or fail and be retried by the
+	 * caller, and (b) adding lock serialization here would
+	 * penalize every request for a rare manual operation.
+	 */
+	err = ceph_mdsc_wait_for_reset(mdsc);
+	if (err) {
+		doutc(cl, "wait_for_reset failed: %d\n", err);
+		return err;
+	}
+
 	/* take CAP_PIN refs for r_inode, r_parent, r_old_dentry */
 	if (req->r_inode)
 		ceph_get_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
@@ -4374,9 +4395,11 @@ static void handle_session(struct ceph_mds_session *session,
 
 	switch (op) {
 	case CEPH_SESSION_OPEN:
-		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING) {
 			pr_info_client(cl, "mds%d reconnect success\n",
 				       session->s_mds);
+			ceph_mdsc_reconnect_session_done(mdsc, session);
+		}
 
 		session->s_features = features;
 		if (session->s_state == CEPH_MDS_SESSION_OPEN) {
@@ -4409,9 +4432,11 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_CLOSE:
-		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING) {
 			pr_info_client(cl, "mds%d reconnect denied\n",
 				       session->s_mds);
+			ceph_mdsc_reconnect_session_done(mdsc, session);
+		}
 		session->s_state = CEPH_MDS_SESSION_CLOSED;
 		cleanup_session_requests(mdsc, session);
 		remove_session_caps(session);
@@ -4450,7 +4475,13 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_REJECT:
-		WARN_ON(session->s_state != CEPH_MDS_SESSION_OPENING);
+		WARN_ON(session->s_state != CEPH_MDS_SESSION_OPENING &&
+			session->s_state != CEPH_MDS_SESSION_RECONNECTING);
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING) {
+			pr_info_client(cl, "mds%d reconnect rejected\n",
+				       session->s_mds);
+			ceph_mdsc_reconnect_session_done(mdsc, session);
+		}
 		pr_info_client(cl, "mds%d rejected session\n",
 			       session->s_mds);
 		session->s_state = CEPH_MDS_SESSION_REJECTED;
@@ -4712,6 +4743,17 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 	cap->mseq = 0;       /* and migrate_seq */
 	cap->cap_gen = atomic_read(&cap->session->s_cap_gen);
 
+	/*
+	 * Don't set CEPH_I_ERROR_FILELOCK here - instead, we attempt to
+	 * reclaim locks by sending them in the reconnect message.
+	 * The MDS will do best-effort reclaim. If locks can't be reclaimed
+	 * (e.g., another client grabbed a conflicting lock), future lock
+	 * operations will fail and the error flag will be set then.
+	 *
+	 * Note: i_filelock_ref > 0 means we have locks to reclaim.
+	 * The lock info will be encoded below if flock_len is non-zero.
+	 */
+
 	/* These are lost when the session goes away */
 	if (S_ISDIR(inode->i_mode)) {
 		if (cap->issued & CEPH_CAP_DIR_CREATE) {
@@ -4727,8 +4769,22 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		rec.v2.issued = cpu_to_le32(cap->issued);
 		rec.v2.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
 		rec.v2.pathbase = cpu_to_le64(path_info.vino.ino);
-		rec.v2.flock_len = (__force __le32)
-			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
+		if (recon_state->from_reset) {
+			/*
+			 * Reset-initiated reconnect: always try to reclaim
+			 * locks. The MDS does best-effort; failures are
+			 * handled on future lock operations.
+			 */
+			rec.v2.flock_len = cpu_to_le32(1);
+		} else {
+			/*
+			 * Normal reconnect: skip lock reclaim if locks
+			 * were already known to be in error state.
+			 */
+			rec.v2.flock_len = cpu_to_le32(
+				test_bit(CEPH_I_ERROR_FILELOCK_BIT,
+					 &ci->i_ceph_flags) ? 0 : 1);
+		}
 	} else {
 		struct timespec64 ts;
 
@@ -4925,8 +4981,9 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
  *
  * This is a relatively heavyweight operation, but it's rare.
  */
-static void send_mds_reconnect(struct ceph_mds_client *mdsc,
-			       struct ceph_mds_session *session)
+static int send_mds_reconnect(struct ceph_mds_client *mdsc,
+			      struct ceph_mds_session *session,
+			      bool from_reset)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *reply;
@@ -4934,6 +4991,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	int err = -ENOMEM;
 	struct ceph_reconnect_state recon_state = {
 		.session = session,
+		.from_reset = from_reset,
 	};
 	LIST_HEAD(dispose);
 
@@ -4950,6 +5008,30 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	xa_destroy(&session->s_delegated_inos);
 
 	mutex_lock(&session->s_mutex);
+	if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
+	    session->s_state == CEPH_MDS_SESSION_REJECTED) {
+		pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
+			       mds,
+			       ceph_session_state_name(session->s_state));
+		mutex_unlock(&session->s_mutex);
+		ceph_msg_put(reply);
+		err = -ESTALE;
+		goto fail_nomsg;
+	}
+
+	mutex_lock(&mdsc->mutex);
+	if (mds >= mdsc->max_sessions || mdsc->sessions[mds] != session) {
+		mutex_unlock(&mdsc->mutex);
+		pr_info_client(cl,
+			       "mds%d skipping reconnect, session unregistered\n",
+			       mds);
+		mutex_unlock(&session->s_mutex);
+		ceph_msg_put(reply);
+		err = -ENOENT;
+		goto fail_nomsg;
+	}
+	mutex_unlock(&mdsc->mutex);
+
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
@@ -5079,7 +5161,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 
 	up_read(&mdsc->snap_rwsem);
 	ceph_pagelist_release(recon_state.pagelist);
-	return;
+	return 0;
 
 fail:
 	ceph_msg_put(reply);
@@ -5090,7 +5172,302 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 fail_nopagelist:
 	pr_err_client(cl, "error %d preparing reconnect for mds%d\n",
 		      err, mds);
-	return;
+	return err;
+}
+
+/*
+ * Called when a session completes reconnection (success or failure).
+ * Only counts toward reset completion if this session's reconnect was
+ * initiated by the currently active reset generation.  Late completions
+ * from a prior (timed-out) reset are silently ignored.
+ *
+ * Caller must hold session->s_mutex to serialize s_reset_gen updates.
+ */
+static void ceph_mdsc_reconnect_session_done(struct ceph_mds_client *mdsc,
+					     struct ceph_mds_session *session)
+{
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+	u64 active_gen;
+
+	lockdep_assert_held(&session->s_mutex);
+
+	if (!session->s_reset_gen)
+		return;
+
+	spin_lock(&st->lock);
+	active_gen = st->active_reset_gen;
+	spin_unlock(&st->lock);
+
+	if (session->s_reset_gen != active_gen) {
+		session->s_reset_gen = 0;
+		return;
+	}
+
+	session->s_reset_gen = 0;
+
+	if (atomic_dec_and_test(&st->pending_reconnects))
+		complete(&st->reconnect_done);
+}
+
+/*
+ * Wait for a reset to complete if one is in progress.
+ * Returns 0 if reset completed successfully or wasn't in progress.
+ * Returns -ETIMEDOUT if we timed out waiting.
+ * Returns -ERESTARTSYS if interrupted by signal.
+ */
+int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
+{
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+	struct ceph_client *cl = mdsc->fsc->client;
+	long timeout = CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC * HZ;
+	int blocked_count;
+	int ret;
+
+	if (!READ_ONCE(st->in_progress))
+		return 0;
+
+	blocked_count = atomic_inc_return(&st->blocked_requests);
+	doutc(cl, "request blocked during reset, %d total blocked\n",
+	      blocked_count);
+	trace_ceph_client_reset_blocked(mdsc, blocked_count);
+
+	ret = wait_event_interruptible_timeout(st->blocked_wq,
+					       !READ_ONCE(st->in_progress),
+					       timeout);
+
+	atomic_dec(&st->blocked_requests);
+
+	if (ret == 0) {
+		pr_warn_client(cl, "timed out waiting for reset to complete\n");
+		trace_ceph_client_reset_unblocked(mdsc, -ETIMEDOUT);
+		return -ETIMEDOUT;
+	}
+	if (ret < 0) {
+		trace_ceph_client_reset_unblocked(mdsc, ret);
+		return ret;  /* -ERESTARTSYS */
+	}
+
+	/* Reset completed, check if it was successful */
+	spin_lock(&st->lock);
+	ret = st->last_errno;
+	spin_unlock(&st->lock);
+
+	trace_ceph_client_reset_unblocked(mdsc, ret);
+	return ret;
+}
+
+static void ceph_mdsc_reset_complete(struct ceph_mds_client *mdsc, int ret)
+{
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+
+	spin_lock(&st->lock);
+	st->last_finish = jiffies;
+	st->last_errno = ret;
+	st->in_progress = false;
+	if (ret)
+		st->failure_count++;
+	else
+		st->success_count++;
+	spin_unlock(&st->lock);
+
+	/* Wake up all requests that were blocked waiting for reset */
+	wake_up_all(&st->blocked_wq);
+
+	trace_ceph_client_reset_complete(mdsc, ret);
+}
+
+static void ceph_mdsc_reset_workfn(struct work_struct *work)
+{
+	struct ceph_mds_client *mdsc =
+		container_of(work, struct ceph_mds_client, reset_work);
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_mds_session **sessions = NULL;
+	char reason[CEPH_CLIENT_RESET_REASON_LEN];
+	int max_sessions, i, n = 0;
+	bool inject_error;
+	u64 reset_gen;
+	int ret = 0;
+
+	spin_lock(&st->lock);
+	strscpy(reason, st->last_reason, sizeof(reason));
+	inject_error = st->inject_error;
+	if (inject_error)
+		st->inject_error = false;
+	reset_gen = st->active_reset_gen;
+	spin_unlock(&st->lock);
+
+	if (inject_error) {
+		ret = -EIO;
+		goto out_complete;
+	}
+
+	mutex_lock(&mdsc->mutex);
+	max_sessions = mdsc->max_sessions;
+	if (max_sessions <= 0) {
+		mutex_unlock(&mdsc->mutex);
+		goto out_complete;
+	}
+
+	sessions = kcalloc(max_sessions, sizeof(*sessions), GFP_NOFS);
+	if (!sessions) {
+		mutex_unlock(&mdsc->mutex);
+		ret = -ENOMEM;
+		pr_err_client(cl,
+			      "manual session reset failed to allocate session array\n");
+		ceph_mdsc_reset_complete(mdsc, ret);
+		return;
+	}
+
+	for (i = 0; i < max_sessions; i++) {
+		struct ceph_mds_session *session = mdsc->sessions[i];
+
+		if (!session)
+			continue;
+
+		/*
+		 * Read session state without s_mutex to avoid nesting
+		 * mdsc->mutex -> s_mutex, which would invert the
+		 * s_mutex -> mdsc->mutex order used by
+		 * cleanup_session_requests().  s_state is an int
+		 * so loads are atomic; send_mds_reconnect() will
+		 * reject sessions that transitioned to CLOSED or
+		 * REJECTED under s_mutex before proceeding.
+		 */
+		switch (READ_ONCE(session->s_state)) {
+		case CEPH_MDS_SESSION_OPEN:
+		case CEPH_MDS_SESSION_HUNG:
+		case CEPH_MDS_SESSION_OPENING:
+		case CEPH_MDS_SESSION_CLOSING:
+			sessions[n++] = ceph_get_mds_session(session);
+			break;
+		case CEPH_MDS_SESSION_RECONNECTING:
+			pr_info_client(cl,
+				       "mds%d already reconnecting, skipping\n",
+				       session->s_mds);
+			break;
+		default:
+			pr_info_client(cl,
+				       "mds%d in state %s, skipping reconnect\n",
+				       session->s_mds,
+				       ceph_session_state_name(session->s_state));
+			break;
+		}
+	}
+	mutex_unlock(&mdsc->mutex);
+
+	pr_info_client(cl,
+		       "manual session reset executing (sessions=%d, reason=\"%s\")\n",
+		       n, reason);
+
+	if (n == 0) {
+		kfree(sessions);
+		goto out_complete;
+	}
+
+	/* Initialize completion tracking */
+	reinit_completion(&st->reconnect_done);
+	atomic_set(&st->pending_reconnects, n);
+
+	for (i = 0; i < n; i++) {
+		int err;
+
+		if (!sessions[i]) {
+			if (atomic_dec_and_test(&st->pending_reconnects))
+				complete(&st->reconnect_done);
+			continue;
+		}
+
+		mutex_lock(&sessions[i]->s_mutex);
+		sessions[i]->s_reset_gen = reset_gen;
+		mutex_unlock(&sessions[i]->s_mutex);
+
+		err = send_mds_reconnect(mdsc, sessions[i], true);
+		if (err) {
+			bool skipped = (err == -ESTALE || err == -ENOENT);
+
+			mutex_lock(&sessions[i]->s_mutex);
+			sessions[i]->s_reset_gen = 0;
+			mutex_unlock(&sessions[i]->s_mutex);
+
+			if (skipped) {
+				pr_info_client(cl,
+					       "mds%d reconnect skipped during reset: %d\n",
+					       sessions[i]->s_mds, err);
+			} else {
+				pr_err_client(cl,
+					      "mds%d reconnect failed: %d\n",
+					      sessions[i]->s_mds, err);
+				if (!ret)
+					ret = err;
+			}
+			if (atomic_dec_and_test(&st->pending_reconnects))
+				complete(&st->reconnect_done);
+		}
+		ceph_put_mds_session(sessions[i]);
+	}
+
+	kfree(sessions);
+
+	/* Wait for all sessions to complete reconnection */
+	if (!wait_for_completion_timeout(&st->reconnect_done,
+					 CEPH_CLIENT_RESET_TIMEOUT_SEC * HZ)) {
+		pr_warn_client(cl,
+			       "reset timed out waiting for %d sessions\n",
+			       atomic_read(&st->pending_reconnects));
+		if (!ret)
+			ret = -ETIMEDOUT;
+	}
+
+out_complete:
+	ceph_mdsc_reset_complete(mdsc, ret);
+}
+
+int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
+			     const char *reason)
+{
+	struct ceph_client_reset_state *st = &mdsc->reset_state;
+	struct ceph_fs_client *fsc = mdsc->fsc;
+	const char *msg = (reason && reason[0]) ? reason : "manual";
+	int mount_state;
+
+	mount_state = READ_ONCE(fsc->mount_state);
+	if (mount_state != CEPH_MOUNT_MOUNTED) {
+		pr_warn_client(fsc->client,
+			       "reset rejected: mount_state=%d (not mounted)\n",
+			       mount_state);
+		return -EINVAL;
+	}
+
+	spin_lock(&st->lock);
+	if (st->in_progress) {
+		spin_unlock(&st->lock);
+		return -EBUSY;
+	}
+
+	st->in_progress = true;
+	st->active_reset_gen++;
+	st->last_start = jiffies;
+	st->last_errno = 0;
+	st->trigger_count++;
+	strscpy(st->last_reason, msg, sizeof(st->last_reason));
+	spin_unlock(&st->lock);
+
+	if (!queue_work(system_unbound_wq, &mdsc->reset_work)) {
+		spin_lock(&st->lock);
+		st->in_progress = false;
+		st->last_errno = -EALREADY;
+		st->failure_count++;
+		spin_unlock(&st->lock);
+		wake_up_all(&st->blocked_wq);
+		return -EALREADY;
+	}
+
+	pr_info_client(mdsc->fsc->client,
+		       "manual session reset scheduled (reason=\"%s\")\n",
+		       msg);
+	trace_ceph_client_reset_schedule(mdsc, msg);
+	return 0;
 }
 
 
@@ -5171,9 +5548,15 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		 */
 		if (s->s_state == CEPH_MDS_SESSION_RESTARTING &&
 		    newstate >= CEPH_MDS_STATE_RECONNECT) {
+			int rc;
+
 			mutex_unlock(&mdsc->mutex);
 			clear_bit(i, targets);
-			send_mds_reconnect(mdsc, s);
+			rc = send_mds_reconnect(mdsc, s, false);
+			if (rc)
+				pr_err_client(cl,
+					      "mds%d reconnect failed: %d\n",
+					      i, rc);
 			mutex_lock(&mdsc->mutex);
 		}
 
@@ -5237,7 +5620,11 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		}
 		doutc(cl, "send reconnect to export target mds.%d\n", i);
 		mutex_unlock(&mdsc->mutex);
-		send_mds_reconnect(mdsc, s);
+		err = send_mds_reconnect(mdsc, s, false);
+		if (err)
+			pr_err_client(cl,
+				      "mds%d export target reconnect failed: %d\n",
+				      i, err);
 		ceph_put_mds_session(s);
 		mutex_lock(&mdsc->mutex);
 	}
@@ -5622,6 +6009,23 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	INIT_LIST_HEAD(&mdsc->dentry_leases);
 	INIT_LIST_HEAD(&mdsc->dentry_dir_leases);
 
+	spin_lock_init(&mdsc->reset_state.lock);
+	mdsc->reset_state.trigger_count = 0;
+	mdsc->reset_state.success_count = 0;
+	mdsc->reset_state.failure_count = 0;
+	mdsc->reset_state.last_start = 0;
+	mdsc->reset_state.last_finish = 0;
+	mdsc->reset_state.last_errno = 0;
+	mdsc->reset_state.in_progress = false;
+	mdsc->reset_state.inject_error = false;
+	mdsc->reset_state.active_reset_gen = 0;
+	mdsc->reset_state.last_reason[0] = '\0';
+	atomic_set(&mdsc->reset_state.pending_reconnects, 0);
+	init_completion(&mdsc->reset_state.reconnect_done);
+	init_waitqueue_head(&mdsc->reset_state.blocked_wq);
+	atomic_set(&mdsc->reset_state.blocked_requests, 0);
+	INIT_WORK(&mdsc->reset_work, ceph_mdsc_reset_workfn);
+
 	ceph_caps_init(mdsc);
 	ceph_adjust_caps_max_min(mdsc, fsc->mount_options);
 
@@ -6147,6 +6551,22 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 	/* flush out any connection work with references to us */
 	ceph_msgr_flush();
 
+	/*
+	 * Mark reset as failed and wake any blocked waiters before
+	 * cancelling, so unmount doesn't stall on blocked_wq timeout
+	 * if cancel_work_sync() prevents the work from running.
+	 */
+	spin_lock(&mdsc->reset_state.lock);
+	if (mdsc->reset_state.in_progress) {
+		mdsc->reset_state.in_progress = false;
+		mdsc->reset_state.last_errno = -ESHUTDOWN;
+		mdsc->reset_state.failure_count++;
+	}
+	spin_unlock(&mdsc->reset_state.lock);
+	wake_up_all(&mdsc->reset_state.blocked_wq);
+
+	cancel_work_sync(&mdsc->reset_work);
+
 	ceph_mdsc_stop(mdsc);
 
 	ceph_metric_destroy(&mdsc->metric);
@@ -6334,6 +6754,8 @@ static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
 
 	mutex_lock(&mdsc->mutex);
 	if (__verify_registered_session(mdsc, s) < 0) {
+		pr_info_client(cl, "dropping tid %llu from unregistered session %d\n",
+			       msg->hdr.tid, s->s_mds);
 		mutex_unlock(&mdsc->mutex);
 		goto out;
 	}
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0428a5eaf28c..1e9b45fe29ee 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -75,6 +75,32 @@ struct ceph_cap;
 
 #define MDS_AUTH_UID_ANY -1
 
+#define CEPH_CLIENT_RESET_REASON_LEN	64
+#define CEPH_CLIENT_RESET_TIMEOUT_SEC	60
+#define CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC 120
+
+struct ceph_client_reset_state {
+	spinlock_t lock;
+	u64 trigger_count;
+	u64 success_count;
+	u64 failure_count;
+	unsigned long last_start;
+	unsigned long last_finish;
+	int last_errno;
+	bool in_progress;
+	bool inject_error;
+	char last_reason[CEPH_CLIENT_RESET_REASON_LEN];
+
+	/* Completion tracking for session reconnects */
+	u64 active_reset_gen;
+	atomic_t pending_reconnects;
+	struct completion reconnect_done;
+
+	/* Request blocking during reset */
+	wait_queue_head_t blocked_wq;
+	atomic_t blocked_requests;
+};
+
 struct ceph_mds_cap_match {
 	s64 uid;  /* default to MDS_AUTH_UID_ANY */
 	u32 num_gids;
@@ -251,6 +277,8 @@ struct ceph_mds_session {
 	struct list_head  s_waiting;  /* waiting requests */
 	struct list_head  s_unsafe;   /* unsafe requests */
 	struct xarray	  s_delegated_inos;
+
+	u64		  s_reset_gen; /* generation of reset that initiated reconnect */
 };
 
 /*
@@ -536,6 +564,8 @@ struct ceph_mds_client {
 	struct list_head  dentry_dir_leases; /* lru list */
 
 	struct ceph_client_metric metric;
+	struct work_struct	reset_work;
+	struct ceph_client_reset_state reset_state;
 
 	spinlock_t		snapid_map_lock;
 	struct rb_root		snapid_map_tree;
@@ -563,6 +593,9 @@ extern const char *ceph_session_state_name(int s);
 extern struct ceph_mds_session *
 ceph_get_mds_session(struct ceph_mds_session *s);
 extern void ceph_put_mds_session(struct ceph_mds_session *s);
+int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
+			     const char *reason);
+int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc);
 
 extern int ceph_mdsc_init(struct ceph_fs_client *fsc);
 extern void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 9e80c816aa7a..f1b3502b32e5 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -179,6 +179,10 @@ struct ceph_fs_client {
 	struct dentry *debugfs_status;
 	struct dentry *debugfs_mds_sessions;
 	struct dentry *debugfs_metrics_dir;
+	struct dentry *debugfs_reset_dir;
+	struct dentry *debugfs_reset_force;
+	struct dentry *debugfs_reset_status;
+	struct dentry *debugfs_reset_inject;
 #endif
 
 #ifdef CONFIG_CEPH_FSCACHE
diff --git a/include/trace/events/ceph.h b/include/trace/events/ceph.h
index 08cb0659fbfc..22b755f4c7c7 100644
--- a/include/trace/events/ceph.h
+++ b/include/trace/events/ceph.h
@@ -226,6 +226,66 @@ TRACE_EVENT(ceph_handle_caps,
 		  __entry->mseq)
 );
 
+/*
+ * Client reset tracepoints
+ */
+TRACE_EVENT(ceph_client_reset_schedule,
+	TP_PROTO(const struct ceph_mds_client *mdsc, const char *reason),
+	TP_ARGS(mdsc, reason),
+	TP_STRUCT__entry(
+		__field(const void *, mdsc)
+		__string(reason, reason ? reason : "")
+	),
+	TP_fast_assign(
+		__entry->mdsc = mdsc;
+		__assign_str(reason);
+	),
+	TP_printk("mdsc=%p reason=%s", __entry->mdsc, __get_str(reason))
+);
+
+TRACE_EVENT(ceph_client_reset_complete,
+	TP_PROTO(const struct ceph_mds_client *mdsc, int ret),
+	TP_ARGS(mdsc, ret),
+	TP_STRUCT__entry(
+		__field(const void *, mdsc)
+		__field(int, ret)
+	),
+	TP_fast_assign(
+		__entry->mdsc = mdsc;
+		__entry->ret = ret;
+	),
+	TP_printk("mdsc=%p ret=%d", __entry->mdsc, __entry->ret)
+);
+
+TRACE_EVENT(ceph_client_reset_blocked,
+	TP_PROTO(const struct ceph_mds_client *mdsc, int blocked_count),
+	TP_ARGS(mdsc, blocked_count),
+	TP_STRUCT__entry(
+		__field(const void *, mdsc)
+		__field(int, blocked_count)
+	),
+	TP_fast_assign(
+		__entry->mdsc = mdsc;
+		__entry->blocked_count = blocked_count;
+	),
+	TP_printk("mdsc=%p blocked_count=%d", __entry->mdsc,
+		  __entry->blocked_count)
+);
+
+TRACE_EVENT(ceph_client_reset_unblocked,
+	TP_PROTO(const struct ceph_mds_client *mdsc, int ret),
+	TP_ARGS(mdsc, ret),
+	TP_STRUCT__entry(
+		__field(const void *, mdsc)
+		__field(int, ret)
+	),
+	TP_fast_assign(
+		__entry->mdsc = mdsc;
+		__entry->ret = ret;
+	),
+	TP_printk("mdsc=%p ret=%d", __entry->mdsc, __entry->ret)
+);
+
 #undef EM
 #undef E_
 #endif /* _TRACE_CEPH_H */
-- 
2.34.1


