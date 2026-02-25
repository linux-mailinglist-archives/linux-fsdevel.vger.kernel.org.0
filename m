Return-Path: <linux-fsdevel+bounces-78370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKhvBijynmnoXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:59:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4390197B76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A67DC30117FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C283AE71E;
	Wed, 25 Feb 2026 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cfw5ILS8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaVFhP8Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5694838E5FB
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024356; cv=none; b=FkaNXVdvAORNuZ3Alta3uNhKe/hYFZ/lYVtw9ByfzjdpCWtfvoXuo5Oy5ysJn+o/4fba48kLxUWSgmoTUV77MAdIcFTZIDKQnCtWh8QHsGnEBA9stAHxMZA/rC4tPbuNmuXHz3D4oPqoz/D7ImXm2cg9C3wqk13jB3aCI0f+MXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024356; c=relaxed/simple;
	bh=ezBckF0lKaSLAxOrpzSdbBHvUo+vPXQ5KvwM+WUDQsg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MLLFXyczNwsn3djVo/B9PXJLzEmKRPWcX5kptgHEpbs5Fk6HblYo4Y4iULRu9Ocb2e2QR8t8Nod8/nkwW4p+QiAX7VuLcXXPBllrV2NZ7hNR04bxquBPTlaZNOE/cUIPHdiV1OGqrYanJkqZEu4/uBD7+98FtCbNURkrpCsIuY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cfw5ILS8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaVFhP8Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772024354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aOw9INrgxnxy1CMgrkfGNK7kVX6hvwU+ErGcKC9BW4E=;
	b=Cfw5ILS8IospIft5rtymaeJV3kkjTSEs7wdva/KOucir3+2zrBItiOtdQBi4L7k3RKxpah
	9SkKP5cdVRbJ//ULppRCIfyGaFjEBurTTHVV2cJx5annwO7SQDgZowE7YKd6fcW4wnyZcR
	VVatXYK01AdrsvoRP1c5CgN05mOfaEw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-6ErU-On3Obyx6RoUjkJ_Dg-1; Wed, 25 Feb 2026 07:59:12 -0500
X-MC-Unique: 6ErU-On3Obyx6RoUjkJ_Dg-1
X-Mimecast-MFC-AGG-ID: 6ErU-On3Obyx6RoUjkJ_Dg_1772024352
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89502dfd7b4so591860196d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772024352; x=1772629152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOw9INrgxnxy1CMgrkfGNK7kVX6hvwU+ErGcKC9BW4E=;
        b=JaVFhP8QfU13GGFPMpEMJ9gLG9HpbGFLY9QO5uSssHoWYD5mfMt+0Ixv2n6Yij84TR
         TtVlIjM3DCQGbXBCUqUsuJEi0oEd2jFw7vnX0Pabv7ZYEUybrXb+e1BnPI+WVcSqhg1R
         2bwW0XF1z39ijwqER/vHefi1lHHnazCx1MzepC22W8a6LaN1KZa+sgn6N4xO/V3h3hwB
         EKPfzC9CMm4GC746DGXtRqyg+LFAwkF004iXdxpV5Vv8gSfIRjrSOdF5PGWROQ2JYnZk
         MRgCp/ZpC9poj7Du99teXgtO1yqwOJsMUlflOvVCBq3mQVkW7KhFJbymDa6Klk/MRbyD
         25Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024352; x=1772629152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOw9INrgxnxy1CMgrkfGNK7kVX6hvwU+ErGcKC9BW4E=;
        b=VAKJMLP6v7W/QXoU2co9c6ri+Dmof98kuI2JgdZVClliQZq7Mo7N2nqt93kHkOPFUW
         8bQ7q8MqPDuuQhqZBGCfV6AJ62UNgGds4btXl5goGDm7Zqcm7LyL2N1RjZVYuVhrAH+J
         ioEJxKV8LpOP1Ei/OurDDCVsT4zqIiM91sb5BXb5JIiVXeeTe/GE2Ht+IloqsTdEGMSa
         LLL+GqS9husspH0aE7g1duCQVtRHSIav765HwZaUz2Sif5sCtwtvXGd3F6JXXKjbNjeS
         qJ71zYA6Zmp8jQh8IUM9JpUvlwwqoZa8q3u7EjpmeMeYTFN1LJhRvSvZR1EEV9tnD87P
         2weA==
X-Forwarded-Encrypted: i=1; AJvYcCVdwpLsyFOxsIWbAMUyA3Ktpr2oZujcsOJFSihfQhzaMrDlKLraY4lgZ2txh3cd2FgGNLf539/zotWsCiaI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz68//aeZk0NQybioG/MWLxAG0dYoxa4ELDsN98N/7ybGdTps6I
	HlUcBwb7x+T5D07EFQEF7EscJHONp+i4/pvidX6QsVgYMe+1aQdmRhGl8hlh7eDGMMhUswHZQg1
	E3nzU0oC38/yknSEZPsnd29cLD3acMKiUJ7eWEPwRaQSaV4Ta77vVeZdAS0AO+W9mTNY=
X-Gm-Gg: ATEYQzw2gODl57GzoqVMUloJ4gzk/yS1GkoxXnaZ4P993pECAu/F/0/li3OOi0uMYiQ
	S75V053q9gRl2ygr98WmbppbpEMdN0w1FhhZFFga5DTzc1C1bo43K/6z02v171ZzfvCrPqYmuXJ
	DAG60CS03dw5fcvGqdU3yn+hBFHzzE4pwvFZM6T5Yql1oi6b74raVQGj1+DWRuWtGiwAuKKPKfZ
	UpCGa9ceYNca329mbvZvuFZx+08aSBQMq1QentBVMDpclIFDftvFFXrAd7f6VAfPgFiahpgf1Kk
	7PkoPsuDCaP2vMzF+xlglFkU5YLrRz0Os4LnK30VH8gRqGoaGQY00Odtaowi9rfaAqvfePtyhZa
	cKTTuh12pewj3qOgEp4FDmva75bYRZAgRsfDcJFt4j7AP13jTleEFa9Y=
X-Received: by 2002:a05:620a:28c8:b0:8b2:eae0:bbf4 with SMTP id af79cd13be357-8cb8c9f59f1mr1840182885a.19.1772024352360;
        Wed, 25 Feb 2026 04:59:12 -0800 (PST)
X-Received: by 2002:a05:620a:28c8:b0:8b2:eae0:bbf4 with SMTP id af79cd13be357-8cb8c9f59f1mr1840179485a.19.1772024351879;
        Wed, 25 Feb 2026 04:59:11 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046055sm1514219685a.8.2026.02.25.04.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:59:11 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH v1 0/4] ceph: manual client session reset via debugfs
Date: Wed, 25 Feb 2026 12:59:03 +0000
Message-Id: <20260225125907.53851-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78370-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4390197B76
X-Rspamd-Action: no action

In production CephFS deployments we regularly encounter situations
where MDS sessions become stuck or hung, requiring a full unmount/
remount cycle to recover.  This is disruptive for workloads that
cannot tolerate the downtime or the loss of cached state that comes
with unmounting.

This series adds a mechanism to manually trigger MDS session
reconnection from the client side without unmounting, exposed via
debugfs:

  echo "reason text" > /sys/kernel/debug/ceph/<fsid>/reset/trigger
  cat /sys/kernel/debug/ceph/<fsid>/reset/status

The reset lifecycle:
  1. Operator writes to the trigger file
  2. A work item collects all active sessions and initiates
     reconnection on each (via send_mds_reconnect with from_reset=true)
  3. New metadata requests and lock acquisitions are blocked until
     the reset completes (120s timeout)
  4. Session completions are tracked via a per-session generation
     counter to handle stale completions from timed-out prior resets
  5. Lock reclamation is always attempted during reset-initiated
     reconnects, regardless of prior CEPH_I_ERROR_FILELOCK state

Patch breakdown:
  1. Convert CEPH_I_* flags to named bit positions so test_bit/
     set_bit/clear_bit can be used in reconnect paths
  2. Make wait_caps_flush() bounded with periodic diagnostic dumps
     to aid debugging hung flush scenarios (independent improvement
     that surfaced during development)
  3. The core reset implementation: debugfs interface, reset work
     function, request/lock blocking, tracepoints, and session
     reconnect completion tracking
  4. Rework mds_peer_reset() to properly handle all session states
     and integrate with the reset completion tracking

Open questions / areas for review:
  - Is debugfs the right interface, or should this be a mount option
    / sysfs attribute / netlink command?
  - The request gating in ceph_mdsc_submit_request() is best-effort
    (no lock serialization) to avoid penalizing the normal path.
    Is this acceptable?
  - Should the 60s reconnect timeout and 120s blocked-request timeout
    be configurable (e.g. via mount options)?
  - mds_peer_reset() rework (patch 4) is substantial -- would
    reviewers prefer it split further?


Alex Markuze (4):
  ceph: convert inode flags to named bit positions
  ceph: add bounded timeout and diagnostics to wait_caps_flush()
  ceph: implement manual client session reset via debugfs
  ceph: rework mds_peer_reset() for robust session recovery

 fs/ceph/caps.c              |   7 +
 fs/ceph/debugfs.c           | 171 ++++++++++-
 fs/ceph/locks.c             |  24 +-
 fs/ceph/mds_client.c        | 577 ++++++++++++++++++++++++++++++++++--
 fs/ceph/mds_client.h        |  33 +++
 fs/ceph/super.h             |  60 ++--
 include/trace/events/ceph.h |  60 ++++
 7 files changed, 879 insertions(+), 53 deletions(-)

-- 
2.34.1


