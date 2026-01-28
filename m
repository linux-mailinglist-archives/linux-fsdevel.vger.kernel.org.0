Return-Path: <linux-fsdevel+bounces-75712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCyEMn7weWnT1AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:18:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02889A0301
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E532E3017FD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 11:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA842BE632;
	Wed, 28 Jan 2026 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzU+ynPD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ACF274B51
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599013; cv=none; b=GgNMZMUcimi0EVpieLJZI+2m2W97K1J/0XmAynKaOaPhQbss/alH8L+3vikTQVUMD9+otZ3myY80NgJiLX0bDRzPjafC+Z/2YlH4QrMBAEZpGuiJrvgWgXdBrg/jV0KsgKGDyc9bwYsPir3RDkfWxepgZkpENzVF1mE9JOTkOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599013; c=relaxed/simple;
	bh=TZeFTs2VfQOracwm4fh3obHJ71O7vhmqc6LKf0cH3TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTmnJx+62AhelCmpzxSWeW8jfb1rSuHOni+GB8yvaPwupIQO8bYG/VUZHc6Zes17+lQJmgTu1LKJDoy/sn/kX2z7vKoynt3Lz9/HNj0pOiEcI3QsnifKSsEqvi+L9N4obx0Wfn4mtrcCC7Skcfc2pKnliASeu/5XhznZO6J9u9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzU+ynPD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8842e5a2a1so919741366b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 03:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769599010; x=1770203810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1xpuxvVRDxxVbhM+wdY6Xj3hRc+mpF5HHDMVBND8Zk=;
        b=RzU+ynPDXIvklMYNfhe7mm1l5zQd5njHUTR787fNmWVFC73cXIkcSXwMuNQt/UXmyf
         2vrFIUwjnEPtQTuK/FVrYELy3M+gtbz83tubYlQdYh0Yf0k2vVkPAiseIgjc5pSfsWhU
         6R8+KhSwU24asSgFyc3pSO0Pu6ZsOUMuajZReyZND4EWEoH1E81KWzmKD/cbA1A2S84q
         bB/KuE67hpKCobgHNKd6o/OOcgrke6mvSt8dqCht11uvRQgbNmy/HDAwf6yyjy2VGtc3
         6M/o5cctClKoiy/ptZYeJMVE95B3tYzaW7+WOIZSIMRhJs9uydyGCDNDMr0Dp+fldNNE
         3IMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599010; x=1770203810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P1xpuxvVRDxxVbhM+wdY6Xj3hRc+mpF5HHDMVBND8Zk=;
        b=IN0nXrgTcOnQ89qDwH37E/pw7UM6sIDHQ0ACpO/NkwGUkZv/R5NnaSD1WxF7pKNeVp
         rL5lOgL4Kk7dfRxnHus7YWtcbeVT0wR2hUXJqGV4fP4WsyFzxHQAEfQoQfUYT9rSSG3y
         vrRSesRcWvwagVyVZlLsezPOSqLYokydub0MXkCXyJFiepHOweQOrb1qTSev6uGKlaJ2
         rhhYbw093fr71TRlSwSvoLM3FgyPi6VmgGk97d5ofmR4pb8Zk6V9rnNikcTPdaNa/Z/Y
         TUhbq+utBU2xdMUy/x9bhyBN7LnXdpiREJ9BtCLAaZyyRdbfhD2JOai2jkJGYG4ud0Ey
         onCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwgzyoHcskCAQvsdQitmEqOQgtVDEGjlzJ1/z9NIMGQautlWPulg88BcZ6ljLO3j6aUi5iHCk/AXot11EV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2EWD7QUgEyKB2YRkTHT/C4fgpWQ0FObpovHGR/QFy3NghyLbK
	O6FKNbtuNel8sbUiabyxLh/TzwQ14muLLcf/upJAN6W5friV49hSw6b3
X-Gm-Gg: AZuq6aKxb+iPW8S+8UymNtyLutIKn5oK1gZTsj7zNmkSGQL+9nMrY1+md/Voam92w6C
	QPkZnM28YI9yGz9Oz/73y9+8FTjDp8p6Hesiq4CFa+ZCkuAY5Ctes26rK6/cqZ7FBLvCJgJza9u
	LCNOTF+X/3TDrK1wxu9zJXS+zWEgPYXS2PSF/U1w9wGcZLhfpgFiRY/ZVOHAvs7S6K1amOxX707
	u7WttBKNmsuPrD2hnFp/bvztzEBYP0vFtMGw+FSqCf5t2p4kSktPvST33EYqzFLfBV8mGG02rbM
	K9VCv5/8n7i882A2ckEv1Hy9eE3s5mYFd8VCZxIZdJgioNT6hRGWvhEY9pocCjniDYNrgLgXV0w
	GmFrbwFjCAdbsYaXZoqScXrWeKGBpymmYC6/ZOZ8MsCHKfpDZMwQVXElyBf9ARyawl5K+vTwdjw
	Zm6D5UCvCHod7lmGYv6n0f5kMw6fWqzmCBZEja6ICdTrqcCa0UtjNSz1SB8gH0/kdL631d4T964
	ZQuYjKssERJq4OX
X-Received: by 2002:a17:907:e104:b0:b8d:bf38:7025 with SMTP id a640c23a62f3a-b8dbf387f46mr116212366b.16.1769599009937;
        Wed, 28 Jan 2026 03:16:49 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-970d-2293-1f03-db81.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:970d:2293:1f03:db81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbef87254sm112306966b.12.2026.01.28.03.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:16:48 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/2] nfsd: do not allow exporting of special kernel filesystems
Date: Wed, 28 Jan 2026 12:16:45 +0100
Message-ID: <20260128111645.902932-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128111645.902932-1-amir73il@gmail.com>
References: <20260128111645.902932-1-amir73il@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-75712-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02889A0301
X-Rspamd-Action: no action

pidfs and nsfs recently gained support for encode/decode of file handles
via name_to_handle_at(2)/opan_by_handle_at(2).

These special kernel filesystems have custom ->open() and ->permission()
export methods, which nfsd does not respect and it was never meant to be
used for exporting those filesystems by nfsd.

Therefore, do not allow nfsd to export filesystems with custom ->open()
or ->permission() methods.

Fixes: b3caba8f7a34a ("pidfs: implement file handle support")
Fixes: 5222470b2fbb3 ("nsfs: support file handles")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/export.c         | 8 +++++---
 include/linux/exportfs.h | 9 +++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad196..09fe268fe2c76 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -427,7 +427,8 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 	 *       either a device number (so FS_REQUIRES_DEV needed)
 	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
 	 * 2:  We must be able to find an inode from a filehandle.
-	 *       This means that s_export_op must be set.
+	 *       This means that s_export_op must be set and comply with
+	 *       the requirements for remote filesystem export.
 	 * 3: We must not currently be on an idmapped mount.
 	 */
 	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
@@ -437,8 +438,9 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 		return -EINVAL;
 	}
 
-	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
-		dprintk("exp_export: export of invalid fs type.\n");
+	if (!exportfs_may_export(inode->i_sb->s_export_op)) {
+		dprintk("exp_export: export of invalid fs type (%s).\n",
+			inode->i_sb->s_type->name);
 		return -EINVAL;
 	}
 
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index fafd22ed4c648..bf3dee2ad5f97 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -340,6 +340,15 @@ static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
 	return nop && nop->fh_to_dentry;
 }
 
+static inline bool exportfs_may_export(const struct export_operations *nop)
+{
+	/*
+	 * Do not allow nfs export for filesystems with custom ->open() and
+	 * ->permission() ops, which nfsd does not respect (e.g. pidfs, nsfs).
+	 */
+	return exportfs_can_decode_fh(nop) && !nop->open && !nop->permission;
+}
+
 static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
 					  int fh_flags)
 {
-- 
2.52.0


