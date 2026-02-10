Return-Path: <linux-fsdevel+bounces-76829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OtMKTf1imn2OwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 10:07:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D801188E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 10:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE19B3051D25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4B33EB1B;
	Tue, 10 Feb 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tf2j3bIK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJ7LSzwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41B633F374
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714398; cv=none; b=AKItvqe+41xcMYx0lCSA27sM9Zdg2BZomb1fXbMbwDvG5emuJVl7PERKokp7VTXw7Ys/5/K7YCSfowZz7giuDsbxcJc6ipSbPCL4rI+iVbbTbevvDIbC9A9jVL4QDtOh2ej5NF9wAV/aasTL2FDQKA2pnwQQnvlby8q+BCtZMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714398; c=relaxed/simple;
	bh=EnyeESgGKzUp4gDfnZECZTE05rUvCTep4deEFH+BrvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APvSSp8KFaVuYWpVbTkGoSU6To6/tgbnzY1/6Cuar699GTaf0vClZE1XS4FFqFStmDZTZNustfNKuXHNcdBwKRNVRiNVLoETNftjmYc0yzR9DA6/I+NSV538TFIIqA11VhYCF0Gp5eKMJpxhceH54Ogq0WbXnaQrYQpmrd3DEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tf2j3bIK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJ7LSzwE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770714396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxnNZqrGvDVMu909TWbsK9n1HURtx1c41aByLTqi3l0=;
	b=Tf2j3bIKiTFg/qVT+xVHNUQNODwNbAvqbJ6iP0g8tNNBw/YhPqT0xTySbh9DkFT5tgt7Nk
	JX4VLR01x01JFjrO4dxqTBd/IrqNrlqeygv6wwgZaiksQ89Nd3Qjst1OaQTvvfUgrs5lBi
	jsago70swzzTNveLTxha7yfoXL0fpWs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-mdho_8IROJSLUfjtbAI4-A-1; Tue, 10 Feb 2026 04:06:35 -0500
X-MC-Unique: mdho_8IROJSLUfjtbAI4-A-1
X-Mimecast-MFC-AGG-ID: mdho_8IROJSLUfjtbAI4-A_1770714394
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8bb9f029f31so276087085a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 01:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770714394; x=1771319194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxnNZqrGvDVMu909TWbsK9n1HURtx1c41aByLTqi3l0=;
        b=JJ7LSzwEf43zaLj01sGnayBFnjQw9k39yxThIHWjbokA4dZO+o8cMlUhzk6FsGsDmS
         xYwjkfYHl4FksV9LAS0vZJQATzLQj5sWyw9JVu4xgFRo0k+Rw4iECtMstTByTsQc3Q+q
         0Zn8VyfYhcIOA6HXOID3C664t7AuB7Q2izPap0dXSUANneGVD55ZG5n6K1rk/n9Qoj4q
         +iRpoXRcz3q/Vk6nNrCa2x0gze8/vvtjhaOdLm2ku8rjIwnZThfufov9i96cLOrn53wn
         Itc4ABHHsarOg51zmBE1jKZyA8J0Tf/KuQyo39LcUfqusOrReBiV92kWRCE8eEwjbEEw
         8TfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770714394; x=1771319194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nxnNZqrGvDVMu909TWbsK9n1HURtx1c41aByLTqi3l0=;
        b=rsIDK/kDMwVFItdIlnvCjtUuCFiZn31b9fq3l/dxKYKdbA/r/fifcT2wclmbFneH5b
         E7oea7AcFTw+FqtjgP7G9FmcT4WzPv7Es4hIqWSQlMiiDTvWD3st+0t8tAY5C9UDaixb
         ZVszAD8EgrHUhaceDg55kvj8jiyDv994hoLEFngPllYpLoIiA9s+i7xpUsiqwnG8C871
         YnFDRqzIVrBxObO44UQ4TpRSdQTup6sBPfxxyllXycT4tA6Rgci6+aJ+kcM3xtu6f+Cq
         COaRCazKWCVz6BkqFLEhY7NhQDukbk3LKXg/04sYMEc8H2g2raY0dpJk0nRuQ++xTvZ8
         DmcA==
X-Forwarded-Encrypted: i=1; AJvYcCWYlTGPZXTVKNZqrCmgbzGf/tliMsdMDHjNQuQqU/x8nRElJNs181JENoomsjHF2sJKB/vwD5TwsN+4LMEb@vger.kernel.org
X-Gm-Message-State: AOJu0YxknB1bhhnKoQsQAIa8WzIiZFp3wVfKm+nnLc+nrK9thPwvaBy8
	8FZHCA1kznEShKkcxvftZU6M3gid4hkX8JesE3wv5AUmzDZzHJ3V5czojN6rNN2g6fxT8v6AjGF
	UJTXtEyHAbhDghN3QD87rpwm6O6NgYUHbjdHFiHGuIrMCtmztSzSgATJcG5lObj4oLAZoq8iinD
	FDLoYL
X-Gm-Gg: AZuq6aKgjKrLLIHDMSmkAzuHpjjHX8L/JZ872wGvaokGhBxFIyDWlx4jC7Zqb/m9b86
	r0JGZc5fVOioLvBhoBv28spfhj1xHNcUAiGIWhRMszzzd56fRh6bXh3Yrm50hu4vivJdmYIgbRh
	EieWmm7dcS3s8EVT7hk72V/VMYNYnd9tI1/F+lT5P24XPXZ7QYZy++zFVbDbmzpqsuvuqTKtiqi
	s+EDppCoMCbAodUEJAWa4j39YBRfQBlpAy6LRdSKU/nn1KSEZ3L1EvzQ92LrFJTyb8f6EhJ9XSe
	tLlIck0i1120tiCcCbX171g8CryNvb8WME2en8bODNjtWB1yw+Y55IOihLCUIb8JxvtnrsnVyjx
	SucCm7ia1N4EleTOVmEqgnjKIaj3pkB3lEkxBl0mL8Xz+ym7Juh7I2nk=
X-Received: by 2002:a05:620a:172a:b0:8c7:f61:fd77 with SMTP id af79cd13be357-8caf0d3d0e7mr1789647985a.58.1770714394392;
        Tue, 10 Feb 2026 01:06:34 -0800 (PST)
X-Received: by 2002:a05:620a:172a:b0:8c7:f61:fd77 with SMTP id af79cd13be357-8caf0d3d0e7mr1789646085a.58.1770714394086;
        Tue, 10 Feb 2026 01:06:34 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c068292sm108053326d6.45.2026.02.10.01.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:06:33 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v6 1/3] ceph: handle InodeStat v8 versioned field in reply parsing
Date: Tue, 10 Feb 2026 09:06:24 +0000
Message-Id: <20260210090626.1835644-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210090626.1835644-1-amarkuze@redhat.com>
References: <20260210090626.1835644-1-amarkuze@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76829-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[amarkuze@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13D801188E3
X-Rspamd-Action: no action

Add forward-compatible handling for the new versioned field introduced
in InodeStat v8. This patch only skips the field without using it,
preparing for future protocol extensions.

The v8 encoding adds a versioned sub-structure that needs to be properly
decoded and skipped to maintain compatibility with newer MDS versions.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index c45bd19d4b1c..045e06a1647d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -232,6 +232,26 @@ static int parse_reply_info_in(void **p, void *end,
 						      info->fscrypt_file_len, bad);
 			}
 		}
+
+		/*
+		 * InodeStat encoding versions:
+		 *   v1-v7: various fields added over time
+		 *   v8: added optmetadata (versioned sub-structure containing
+		 *       optional inode metadata like charmap for case-insensitive
+		 *       filesystems). The kernel client doesn't support
+		 *       case-insensitive lookups, so we skip this field.
+		 *   v9: added subvolume_id (parsed below)
+		 */
+		if (struct_v >= 8) {
+			u32 v8_struct_len;
+
+			/* skip optmetadata versioned sub-structure */
+			ceph_decode_skip_8(p, end, bad);  /* struct_v */
+			ceph_decode_skip_8(p, end, bad);  /* struct_compat */
+			ceph_decode_32_safe(p, end, v8_struct_len, bad);
+			ceph_decode_skip_n(p, end, v8_struct_len, bad);
+		}
+
 		*p = end;
 	} else {
 		/* legacy (unversioned) struct */
-- 
2.34.1


