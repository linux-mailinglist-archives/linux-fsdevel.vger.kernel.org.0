Return-Path: <linux-fsdevel+bounces-75848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEmUIDowe2n2CAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 11:02:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79AAE551
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 11:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4C7730074BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 10:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3A83803E3;
	Thu, 29 Jan 2026 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7y0MvoA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3C37D137
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680939; cv=none; b=HleNFrvuADwmz0lHYEeoCkhOtq+nbp9MIhHeRZy6SPxaRWtr133lAtqgtp5nZzM1Qo1yIQTX4KpXjMjRszmXmO8WwcD8Kl81CtN6HlC25CMUyQOMaBZFb57lahxLGlJTwT7cpJBeA4sJWlTXWmuBfNiUcsccVD/UZOIQJvivbkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680939; c=relaxed/simple;
	bh=A2DTHUHs1nLGjJLtnrAy7iBy8SHKPDkszdxkI6TM6PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzmUYjobEQQ2r0IHhlyd1njJVrT6WWn0dNdhaGRrFiAazvbtwXKLIp7jkC0as6qvObuiNXHjBUFIqC4jBdFOCG26pDBvC+e+yg/KmXqz9orABElDOwkVsuq412K+14S4jFKKaWqdmgmzSo51njGLGJR5lznszEoeh/PFIXvVwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7y0MvoA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so1474356a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 02:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769680936; x=1770285736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m5EDzasxMTMFr0ATlZ8fOFcmFkpPcXbIFJZjfWv3T4=;
        b=R7y0MvoAysRqClrgh9WCnt2zp9fXYQ4tMyYWdeOrDo8b4Jlgn40OHkd1j/kCOIZknb
         35vmZZkj+cC9Q4LlQf/dlTNddWfWevxcXypSNtU/NtyTod/OGOAam8Y6G4MGLeFRcPPP
         heHjzNV2NCNrU6uAxU39da2SxYnZ1BAQCEY2CzpE2JFRzKf1nHCUxs9GAA07whNJ+QjR
         MkruXDkwJ2MME/DXfKBtiwWhM44L7Kqu7xIHc8068ymI5kPrtfJA7OSAsVNtBljt26yP
         quUfYMoc04Cq3v944TnC2cYjry5UrOqY1ARc7S4if6xuOj9LQaNIUjZmilujfwebXezx
         aSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769680936; x=1770285736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8m5EDzasxMTMFr0ATlZ8fOFcmFkpPcXbIFJZjfWv3T4=;
        b=mvL5F5LjBbFPXLvrPIphJsk23BZKb0dkGyk2sZRXVIUbRIFnrG1hBFexGNN2XOxvBW
         ef9gnXDfQL8lXBViTtXAlKaiIdiKjOQfkimR6Pm6nnOV2A5Abqkq15XJBylB6cCwXev5
         Y/p2nLCvkq1iMLRJuawi6ibXut2rPHW8ZkFl9aV7RCDiKqVVm0dO+XsL0+3o7yQ6I0UO
         5Cj0rOmH1IGD4xXtSiWZy+XDPM1rTp9wrJtF0n8pGASJaXrWgxeNmEnsnrpRgNKySSQ5
         4SeE4dbVQYXu53bQh9ZTdcERvAF6VnbfOgD4fu35wq0nGPY/0wNCmGNmgY3CxRsRTW99
         1FzA==
X-Forwarded-Encrypted: i=1; AJvYcCUNqlnmBPt1GRGva12a7cRSH8xC+TG79mYMNxKr+5+xKyIO6pa5qyFIrqZa0ZZ0BCve3BmZO+NgzlpBriRd@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOv3utFG8uq7ttxqQsh1512moUusBixbPR3gpEcRuf+azwOEi
	VqEnp6Xs4Qga57hw/yfv8AVBA+ipC8L2XwxJwriwor1xxznNwM3cMdIhgu47kOTe
X-Gm-Gg: AZuq6aJmPBIe4XOx8KOU8nwkxghwzrrn+Mw9VwOrWDEKgU1LBkkLQ9aXOEXiJmloGWy
	iTQFWP+ysFqOCjICZCey/7m7dyo9J/TJpmqVj1kNX4SJkpGgzOWqz1BxBnrUE5IvOTKmqE+Dwbd
	0p7P/3P59GBv4dqqg5CFjuBN6rzusWo9GikPvioHNcQ7UulgrgwGqt5lGonimK7rUqA97VP3xqv
	F3F3p9zKIJ8lnM9b/N4KyaGKb1aUdL4twvj2REe+3GLa459x363aQxHGGAlWvEj7x09ITWWGk5v
	shUi6dhPJD8fBC0nJpKGhmN8R9y4k13t2yaGN+2bAP51UIIRxbPD+9eOcAuuzQsEznupdtzuMcv
	JsciJma7PbboAHrG0TfLI7VHKiUboYZdOekLG+ChBzljQhCb+4B6OSxk6naRWjvUcONjGk8RP37
	i0kbCfaKFOgRDjusRrdrOgSvDT3BjXnWr7HLJ0RF24UCn7RLX1n4zr6BrpKo+udVd3TWo/IZmYO
	r61ZuaQmwSXtB1l
X-Received: by 2002:a17:907:9627:b0:b87:756b:cfab with SMTP id a640c23a62f3a-b8dab32ef88mr531554966b.36.1769680936110;
        Thu, 29 Jan 2026 02:02:16 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-983a-6411-8910-8120.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:983a:6411:8910:8120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbefc6942sm243114666b.21.2026.01.29.02.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:02:15 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/2] nfsd: do not allow exporting of special kernel filesystems
Date: Thu, 29 Jan 2026 11:02:12 +0100
Message-ID: <20260129100212.49727-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129100212.49727-1-amir73il@gmail.com>
References: <20260129100212.49727-1-amir73il@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-75848-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE79AAE551
X-Rspamd-Action: no action

pidfs and nsfs recently gained support for encode/decode of file handles
via name_to_handle_at(2)/open_by_handle_at(2).

These special kernel filesystems have custom ->open() and ->permission()
export methods, which nfsd does not respect and it was never meant to be
used for exporting those filesystems by nfsd.

Therefore, do not allow nfsd to export filesystems with custom ->open()
or ->permission() methods.

Fixes: b3caba8f7a34a ("pidfs: implement file handle support")
Fixes: 5222470b2fbb3 ("nsfs: support file handles")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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
index 0660953c3fb76..8bcdba28b4060 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -338,6 +338,15 @@ static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
 	return nop && nop->fh_to_dentry;
 }
 
+static inline bool exportfs_may_export(const struct export_operations *nop)
+{
+	/*
+	 * Do not allow nfs export for filesystems with custom ->open() or
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


