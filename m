Return-Path: <linux-fsdevel+bounces-78373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECAsJjrynmnoXwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:59:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5281A197B9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 13:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92574305C339
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237E53B8BBA;
	Wed, 25 Feb 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlPNEieb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nlpnbb2B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDCA38E5FB
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024362; cv=none; b=gxRS1xDUBwSmvXGJuzYRQCQ0pvRLICla46EHkaalPD/Zs64/qt1+j1EAtNv3g6981+jixVPtVgTokMFdHLr2RgJ6vYSnYh5lHy7H/fcw7Gh6N1hZLEm9ZSNVLaz5ukqB45kLYYy/Hfv7dkDQxY61dnuFqCxD2FJ5SZCnUeMoqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024362; c=relaxed/simple;
	bh=bGwRVvd3ajNn4t+dSLjh1eK2i+/FzUMc5/O4uhriyQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uw82uOsgknPa/ctbLqGUR93bWH6HwF92cIL4bk3/O6ajEfe0pl4c+DILvCxn//ctSUp41uJ2Dh+1k3QVU9tEVYYLVwWGpidLCWRmTncuM5t8Xgf7S2ZCGrgILEkPHwTQssHkwK0S5Q9EFneM8TeEdJkwVzdOW0u1xgqOJN/khBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LlPNEieb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nlpnbb2B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772024360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0kOIIK0zwnK1vvhLt6PsS43bfbxLU6KWtPkGNCJ0ZHw=;
	b=LlPNEiebrvI+7UqZI244Vk+TYew8d3YYC8WTNUp+OFdCBK90GonoQU7w7OaASeOOObQjiH
	41W3rNMXvfFG68rmHtYOiiRvdFAsuESFUtzDS3HgdCd2zbnyLpE1UeOc+Y+E9jc3+zQOiW
	VLyant2gVH69hB/qMMw5FW7UnNRTI2s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-uYdsV5DENQC9G55KxahCig-1; Wed, 25 Feb 2026 07:59:19 -0500
X-MC-Unique: uYdsV5DENQC9G55KxahCig-1
X-Mimecast-MFC-AGG-ID: uYdsV5DENQC9G55KxahCig_1772024359
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c71655aa11so8207331285a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 04:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772024359; x=1772629159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kOIIK0zwnK1vvhLt6PsS43bfbxLU6KWtPkGNCJ0ZHw=;
        b=nlpnbb2B266JFeGs2HZmgqmBHMv45vCuu/+zGqQryZ52h3Dff42cXmOMJG355fneYt
         mLBts8T0LdEGzdaawVF6SEF/zfWMXY/tVsSiSETi8Evm1ct8zFrBtBbjl67ICfzni21I
         k4qdHljsiTf9JT+KwzWDfLvXFcUJoH69apLMCMVPpM5PnfNZdFYPaUTz3n9JMi5OiUjf
         H23bMyhV7uz52tCKrWKPeFYl1BTWFwATJWUWU2ACiMQ9WgwdaC2QvHo8bbRfQ4I8ErDh
         EKeLQ9ETt8xTWD+M2Lz0bUWw8bhkVNFdqGdFPItDfjX30uBFnjH4NZyzsbuyhz7BShQQ
         rhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024359; x=1772629159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0kOIIK0zwnK1vvhLt6PsS43bfbxLU6KWtPkGNCJ0ZHw=;
        b=rCvrgHZ0nsufOlxQQEeFyIPPfkAhwcPbWsY9atpzsJqQNG99rT+L8ZRONV5mHR+HwY
         T1G94SUgEdv9cJ7UdXofG842T5usFDW55Bw0xMbWCTGURqwqBfPr9thuWDNX380TtDuS
         d9Z6O0e9q4eunQAF3fMAxFpAt42h9ozCjHmywBfcCSpIWKH15LhehBeAMagYRL2OlLyz
         jcXnhuw6FJApMoDdF9hL02tnoTEd+ZvjViqkJp9gJDWu8Xxo4HBWA842tY9pvsOwFhZ1
         0lttCMP2A0V/6e5mcMoONPLZESj1y+pC/oWzBHVdwHsJHGoEc+ws51O5qc6vKxsGlrM0
         9XdA==
X-Forwarded-Encrypted: i=1; AJvYcCWxDoM5xAabuF25xmDtG38Y10CvqBMdvYUXl3x9vJR0N8QqdezqF0tLBOvOFbm0/sx4Qj9snep7Oh8hLGDB@vger.kernel.org
X-Gm-Message-State: AOJu0YzvC+IglZoDW6zwZOjDnvNBCeYCtZ2/REo4wrd9+cS5V9Th56gp
	b3I3tCdRMnVXUebS65wpWU3ZnDkFwE7Nd03v+C9AyGhJF6+FoaEYzNA9ObUO8S20wWX4LNOrsRE
	xQ4xnjF8k49b/CePxjurAeSKluKO2faB0IFscDOYnykdzOExooBJ9efDE01F9K9ULZm6l3cmIUf
	BbqeTL
X-Gm-Gg: ATEYQzySo5BZvXpavpBXFe4ftJH3IV5c1Efb63cahUOBSxOhe+lXqe5G1Y5ZmRgSrdU
	QR9yO1OqAst8amS9xWxv33MJ4/Xa+kKxOVYsFh7/sDWPTDhIKeeKAkrq8DWS7BsJ/SQ+tHlyJmY
	SxhMU8vszCcqAmYK3ZkskI4akyV/CSKY+W2Fe23NGuLLnSa8KP5jMcVXsEnZP4EWmrr891N7Egv
	BjrDBWMmIQAi/yDdADJfy8btOYTAoVZcdrL3jhgLk4zBSmJZYsotkn11L5/VBOdn8I1Oo9mSP3T
	xJZdoOJ/74sg8yAMiPK1FUxPva59Zy6G9QQcdAypRHMVkX3uKp25GiW0ss3DFymMohUhCxbmimz
	EUtKHoYUNL21BOeojzWvnNo9pq47YP/lug6y7L9ukNm98s0Upyokzxe0=
X-Received: by 2002:a05:620a:45ab:b0:8c6:d2ca:1d0e with SMTP id af79cd13be357-8cb8c9e62a4mr1886938985a.11.1772024358733;
        Wed, 25 Feb 2026 04:59:18 -0800 (PST)
X-Received: by 2002:a05:620a:45ab:b0:8c6:d2ca:1d0e with SMTP id af79cd13be357-8cb8c9e62a4mr1886935885a.11.1772024358265;
        Wed, 25 Feb 2026 04:59:18 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046055sm1514219685a.8.2026.02.25.04.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:59:18 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH v1 4/4] ceph: rework mds_peer_reset() for robust session recovery
Date: Wed, 25 Feb 2026 12:59:07 +0000
Message-Id: <20260225125907.53851-5-amarkuze@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78373-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5281A197B9E
X-Rspamd-Action: no action

Rewrite mds_peer_reset() to properly handle all session states when
the MDS resets our connection. Previously it unconditionally called
send_mds_reconnect() for any state >= RECONNECT, which could leave
sessions in inconsistent states.

The new implementation:
  - Returns early for FENCE_IO or MDS not yet in reconnect state
  - For MDS in RECONNECT state, directly reconnects (no locks)
  - For active sessions (OPEN/OPENING/CLOSING), performs full
    cleanup: unregister session, wake waiting requests, clean up
    caps, and kick pending requests
  - For RECONNECTING sessions, restarts the reconnect
  - Snapshots session state under s_mutex, then re-acquires locks
    in the correct order (s_mutex -> mdsc->mutex) matching the
    convention used by check_new_map() and cleanup_session_requests()

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 89 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d350bf502a15..d9baa0073bbd 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6737,12 +6737,95 @@ static void mds_peer_reset(struct ceph_connection *con)
 {
 	struct ceph_mds_session *s = con->private;
 	struct ceph_mds_client *mdsc = s->s_mdsc;
+	int session_state;
 
 	pr_warn_client(mdsc->fsc->client, "mds%d closed our session\n",
 		       s->s_mds);
-	if (READ_ONCE(mdsc->fsc->mount_state) != CEPH_MOUNT_FENCE_IO &&
-	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) >= CEPH_MDS_STATE_RECONNECT)
-		send_mds_reconnect(mdsc, s);
+
+	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_FENCE_IO ||
+	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) < CEPH_MDS_STATE_RECONNECT)
+		return;
+
+	if (ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) == CEPH_MDS_STATE_RECONNECT) {
+		int rc = send_mds_reconnect(mdsc, s, false);
+		if (rc)
+			pr_err_client(mdsc->fsc->client,
+				      "mds%d reconnect failed: %d\n",
+				      s->s_mds, rc);
+		return;
+	}
+
+	/*
+	 * Snapshot session state under s->s_mutex, then release before
+	 * re-acquiring in the correct order: s->s_mutex -> mdsc->mutex
+	 * (matching check_new_map() and cleanup_session_requests()).
+	 */
+	mutex_lock(&s->s_mutex);
+	session_state = s->s_state;
+	mutex_unlock(&s->s_mutex);
+
+	switch (session_state) {
+	case CEPH_MDS_SESSION_RECONNECTING: {
+		int rc;
+
+		pr_info_client(mdsc->fsc->client,
+			       "mds%d reset during reconnect, restarting\n",
+			       s->s_mds);
+		rc = send_mds_reconnect(mdsc, s, false);
+		if (rc) {
+			pr_err_client(mdsc->fsc->client,
+				      "mds%d reconnect restart failed: %d\n",
+				      s->s_mds, rc);
+			mutex_lock(&s->s_mutex);
+			ceph_mdsc_reconnect_session_done(mdsc, s);
+			mutex_unlock(&s->s_mutex);
+		}
+		return;
+	}
+	case CEPH_MDS_SESSION_CLOSING:
+	case CEPH_MDS_SESSION_OPEN:
+	case CEPH_MDS_SESSION_HUNG:
+	case CEPH_MDS_SESSION_OPENING:
+		mutex_lock(&s->s_mutex);
+		mutex_lock(&mdsc->mutex);
+		if (s->s_state != session_state) {
+			pr_info_client(mdsc->fsc->client,
+				       "mds%d state changed to %s during peer reset\n",
+				       s->s_mds,
+				       ceph_session_state_name(s->s_state));
+			mutex_unlock(&mdsc->mutex);
+			mutex_unlock(&s->s_mutex);
+			return;
+		}
+
+		ceph_get_mds_session(s);
+		__unregister_session(mdsc, s);
+
+		s->s_state = CEPH_MDS_SESSION_CLOSED;
+		__wake_requests(mdsc, &s->s_waiting);
+		mutex_unlock(&mdsc->mutex);
+		mutex_unlock(&s->s_mutex);
+
+		mutex_lock(&s->s_mutex);
+		cleanup_session_requests(mdsc, s);
+		remove_session_caps(s);
+		mutex_unlock(&s->s_mutex);
+
+		wake_up_all(&mdsc->session_close_wq);
+
+		mutex_lock(&mdsc->mutex);
+		kick_requests(mdsc, s->s_mds);
+		mutex_unlock(&mdsc->mutex);
+
+		ceph_put_mds_session(s);
+		break;
+	default:
+		pr_warn_client(mdsc->fsc->client,
+			       "mds%d peer reset in unexpected state %s\n",
+			       s->s_mds,
+			       ceph_session_state_name(session_state));
+		break;
+	}
 }
 
 static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
-- 
2.34.1


