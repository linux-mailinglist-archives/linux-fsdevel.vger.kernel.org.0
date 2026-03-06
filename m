Return-Path: <linux-fsdevel+bounces-79565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHFtB8woqmmQMQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 02:07:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7749B21A1C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 02:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBBEC308EB9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 01:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0E22FF170;
	Fri,  6 Mar 2026 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFIxpNMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0E2E1F02
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772759185; cv=none; b=t5rCW4Zs8ccZkXbsU9hjTTQiCh7w0uxz68uutc8a4Wsuosm/leJ9FifnvObsCEBT3Dy+6Pmmgimjc+ragAseMLVw0mTutuGpMSlL3dgWsvJ/vGvizgH5PzU9UGSXnTTo7MzGs7OmrTTRkgq3H46DScfStr8GcKwc76NuptETpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772759185; c=relaxed/simple;
	bh=mIlVHswrWJV9/UxjC6bOEz3Y/fw3vb00wrkyIVkQWwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwHaQktaTkvvQU5/6YMV3Pthz3ZhYYcIrsdX/z5IBsvCrPp1HTJUuLtmo08FjI1ExSvPMNLtCp57gh/+jFRFB1IeCb4alvF8PJ+iJt8JL/AoqYO3er64miGyX+oUQRP/4TZ3sRwaxO5vt6NnFsSYmjxYrpP4FvnxbIIHnlvdpqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFIxpNMu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-829928e512aso524516b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 17:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772759184; x=1773363984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOKYcQ4zC/emrpQ6dv72yxpLeegEaM2YeYhwBLDkr7A=;
        b=SFIxpNMuAVBV7mDGgTEKXYVX+Diebr/iCAz/mrzAvCgmw2lRsf+qLEZe82m4HiVkym
         iSbCA09BFpfQe2fCq+jtXeLZA2L7FdVLTKQXZv2ow/zETriaKpr8ObLb5FSzGzFOkmYg
         Tlf3+9cYmMj+hIiYCLFbogqFNCfQenMgvhmuYy3rzViTxBGbKjDckwkxV1sfOhLDPvLh
         c3NmSbQV8ksiC5PcUTJYZq9OLmbPB/pZ4b6Fi5WAtRMazXUcV3obUtYpy7UQWtpf+0Ba
         aDLl2yQbGwjWlfwkms/RDM0Av9uIkJ3XD+SQH7H9lV4voVbqUE+jgFxlZ8uB+pDQ5HMd
         H7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772759184; x=1773363984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOKYcQ4zC/emrpQ6dv72yxpLeegEaM2YeYhwBLDkr7A=;
        b=MkiEvCTchu7ERKFtoxgNSWfhq4zTQRgdU5Ur88xHp86tCCc5LvDwdwk4dERB+i0m2d
         GHMVR9tdvQbAHm9Ys+xdENlIyB6THndyxGkxXyKtgOp+my0S4CSe0JvZDg/q3RTGZJTe
         kS5mIHh3Idg1uyNZAyt2BnPx20XvPmDKf4CZw0Lx3t2TQBkF7UUFIDS7EvxZZrIsnebc
         bzbgTsU+OlzYBJKbozSQj3OKnWriZAu142jWM/4cL7l1EBzmSGoVYXIlDlBo+ebOERN4
         VoL9ouj0qYJWm40RZsD/gvepWHkhzfTJfK7NsCRVgwhRM7xBEH1sMjpNa1nbrvzyZTFc
         AyuA==
X-Gm-Message-State: AOJu0YxQLuf3ryq7CYpZ6nHYWiJ+dU3zr4LnLoB90e+StC6OIXwkLkdg
	LRqAu+cDPapMJ/hgWlyPpFZ4I+l2F48Wqqyd0rLKYB4O0lmd4Ho+3fmx
X-Gm-Gg: ATEYQzxxwoJVeI6AeKpmvm7uL2E0HDGP3ESh8tDE+WLWTHkXl/ezT84eQQ9X9QWgVTc
	PPyI+VasVDBV2g/SFOD65+CFbmlvR8pKoLsw6ziWGembwpZmsKEi/6BXW9kmu6U7vbh8ax4q7lJ
	iF02Sctj/vMHZhRcT3NaxhKyt98OK+SEFtqZJBKhsPtH1UMwdEFu6qQUMdGVfZMWjAOeNo51wKS
	LABOSLBpZDGJGTeATLWoLV+X/Tw5vT/dWMimchMPRaZmveQSUWyLjo/n92N3hMN5aBmlepH/eHJ
	w5sj/jQsHY+nzPzRwuUWUh5elFBwQM+7LwxYm0PtZe7c1R2GVXiT1FbF9kFoLa2+jpZzUSm266r
	vAMKxIlcrJZnp2+/uOP1xXkbzthQtR0W61Xyw01xL3EeRQwoGRx847wOAz5QNZwOGTVO2zgZmwQ
	/qAdl9RJgVK42pZwk37w==
X-Received: by 2002:a05:6a00:7081:b0:824:9451:c1f4 with SMTP id d2e1a72fcca58-829a2f9ea19mr200033b3a.55.1772759183853;
        Thu, 05 Mar 2026 17:06:23 -0800 (PST)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01a99esm28056956b3a.47.2026.03.05.17.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 17:06:23 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 2/4] fuse: get rid of err_unlock goto in fuse_dev_do_read()
Date: Thu,  5 Mar 2026 17:05:23 -0800
Message-ID: <20260306010525.4105958-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306010525.4105958-1-joannelkoong@gmail.com>
References: <20260306010525.4105958-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7749B21A1C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-79565-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

There is one user of the err_unlock goto. Get rid of it and make the
code simpler.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e57ede7351b9..8a0a541f3fba 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1438,8 +1438,8 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	}
 
 	if (!fiq->connected) {
-		err = fc->aborted ? -ECONNABORTED : -ENODEV;
-		goto err_unlock;
+		spin_unlock(&fiq->lock);
+		return fc->aborted ? -ECONNABORTED : -ENODEV;
 	}
 
 	if (!list_empty(&fiq->interrupts)) {
@@ -1524,10 +1524,6 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	spin_unlock(&fpq->lock);
 	fuse_request_end(req);
 	return err;
-
- err_unlock:
-	spin_unlock(&fiq->lock);
-	return err;
 }
 
 static int fuse_dev_open(struct inode *inode, struct file *file)
-- 
2.47.3


