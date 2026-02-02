Return-Path: <linux-fsdevel+bounces-76037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Lo1FuqTgGmk/gIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 13:09:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89937CC337
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 13:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3682E310BDC6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 12:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A92364E9D;
	Mon,  2 Feb 2026 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DE8yizzQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47EA3659E7
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033654; cv=none; b=qWXZTPfsYYVMMqRbzMRDa/8dJNzHquZZ23pcZw+UXdQpF0BgSWVs4d7Zyz9Cg3f4b+dqWn/9C81vgorIhyK0sAFGq7diZF1wHQ6EkikeTqUiq2IaDLrraxk+VgFss3Iu4vLWjGnJKnSb8s/BqYhl29EnnN6cMpMONwrMThMGqCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033654; c=relaxed/simple;
	bh=D33tW0SzBuge2SIkjwi/wnIKkVmfleN0k/LaT6eRgME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQGbBIyoH+vCJjdOLkyWmfDxIeYnLcH2iTEo9sIcDmjYnY7+inZP4xCpS2YtlIMr+aCgVShrDLM8eHgjeGUNdxRcGls1U7bVbbgDf++PW1woqAI9ZUS7dzfnro7KzhNXP9o7UMRh2WprlmTJtEyE5F1Dal2bqFzpohlDpuufCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DE8yizzQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8230d228372so2274245b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 04:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770033651; x=1770638451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/u1KuZkRF0JZ0bmB5KVbwnQF2ZWQfDMzkqR2SteYumU=;
        b=DE8yizzQRGanH/5/1qmoNl3QeJINgEMp/bETOqmkqKTUmGCcJi79KcTdDt6OFku8Ju
         4CIf/Ay9j6lnTJVg+zBvSqzilhBCQ8sI75c6OqG2kjxc6rf9nrGU0yr9fBtoOGIqjizL
         7OSWYVKYQIvgw+8Xvb8vuNBMOxUuQruezvsOEXfSffAEFiiK9BMcfnAu9/bFfRlAkIxC
         +sZL6/dRu4uePqaB9WpBZ6UWS9bE86jO/Sg//GhpY++SU/hLX1f1Bt2CFa4vnIGCWALt
         mL/4gr1i3p1/elnBVbf32qOeLxEUdlGHESYHS+AA3oHH1Q+/tMX4A1hqXDv8pz/rvXkS
         77vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770033651; x=1770638451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u1KuZkRF0JZ0bmB5KVbwnQF2ZWQfDMzkqR2SteYumU=;
        b=snmdY1+Vlw1bn1JYfVpa9f5JzoNbY7KOqcBJY06pC879zvhxBIRXgmmOakyD0ig/xs
         8YpTVKbeO36PcOkO30oBqIjJKMVLlXiEbQ2M5poExaYmI4ZokMF0e7RVC5G2+OrFQTgT
         k8PlLo9u7hKFnMMb9/q1cz6KVkMh8MiaVOoHZzuMdawfPH8GrnaEl8MVxaYYFtRevXxn
         M/HCyiKG1/gF7hgxIDk8w/LMEqoWl18K2ugslQc9hIpE/T9xHeof3eUlHg9PcP14pBFe
         CB/YmOfKKRJLdS+89LWQEf7o9TmwoYYATwhjTzFLxLb0g7Yk/zUQ2NoKGxGbOpPcWly3
         Bt7w==
X-Gm-Message-State: AOJu0YwqE+VAHAJyg3cP2YHJ3uDzyRmRw39orNecFGprLiQ45LQ5zU84
	/NsrayuQpUVThICgHrxL5IEV+Qt4jRNwvawBENxVC3Mf+uSz/bTKB04Jz6euTggeVzU=
X-Gm-Gg: AZuq6aI4DUiRUwB59pF7k7St52MnTIZyXgnMPTPmyQcG76r77Fqh5ctj495uLiR9VXw
	qHWOVys37X+P+dikgdTxe14WzNGA9hBqGCM2XHmHA5jyRFKGveerdkQwmaCnxQbtrXOp6tYlU6M
	cxiA9huTOp+0t2aOTH/ywN8ZiftKSHjQeZoy4Sko9fMuM7QImYsMUy76j7hVvTSZeUkrgZKNo+V
	sUOMVrKG+lFmbYPwDHnPshJa9+7tQ4Ovpw11Ecf1pX79/fcq6NY6T+4q3Srk4tiI2II0ym6/mow
	r6BK+CpoHkik8ysHxc0ylgcbs29624/PFvmIawPA0vf1f0czp7Wxxr90B0rA3Yo8mUcuqLCC/JD
	RhjSLxfemVO8dQdzzDqZyrybdNK9bFZ0RVtpKyAG9mKNg8fN1UyOfeS51ZOcPczfKOXJhn1/3y1
	Jr3MjCJRkWWH/bqSNFiN3FqPcuxDzuZgZnv2zPQ6zGWNO7Rab98Y+IWKNLt8t/nOAB08A=
X-Received: by 2002:a05:6a00:98a:b0:81e:c67a:1a79 with SMTP id d2e1a72fcca58-823ab6bac7dmr10278934b3a.25.1770033651071;
        Mon, 02 Feb 2026 04:00:51 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b48531sm15099345b3a.16.2026.02.02.04.00.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 04:00:50 -0800 (PST)
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH] fuse: send forget req when lookup outarg is invalid
Date: Mon,  2 Feb 2026 20:00:23 +0800
Message-ID: <20260202120023.74357-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
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
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76037-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangtianci.1997@bytedance.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:dkim,bytedance.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89937CC337
X-Rspamd-Action: no action

We shall send forget request if lookup/create/open success but returned
outarg.attr is invalid, because FUSEdaemon had increase the lookup count

Reported-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
---
 fs/fuse/dir.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff2..92a10fe2c4825 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -578,8 +578,10 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 		goto out_put_forget;
 
 	err = -EIO;
-	if (fuse_invalid_attr(&outarg->attr))
+	if (fuse_invalid_attr(&outarg->attr)) {
+		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
 		goto out_put_forget;
+	}
 	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
 		pr_warn_once("root generation should be zero\n");
 		outarg->generation = 0;
@@ -879,9 +881,13 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_free_ff;
 
 	err = -EIO;
-	if (!S_ISREG(outentry.attr.mode) || invalid_nodeid(outentry.nodeid) ||
-	    fuse_invalid_attr(&outentry.attr))
+	if (invalid_nodeid(outentry.nodeid))
+		goto out_free_ff;
+
+	if (!S_ISREG(outentry.attr.mode) || fuse_invalid_attr(&outentry.attr)) {
+		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
 		goto out_free_ff;
+	}
 
 	ff->fh = outopenp->fh;
 	ff->nodeid = outentry.nodeid;
@@ -1007,11 +1013,13 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
 		goto out_put_forget_req;
 
 	err = -EIO;
-	if (invalid_nodeid(outarg.nodeid) || fuse_invalid_attr(&outarg.attr))
+	if (invalid_nodeid(outarg.nodeid))
 		goto out_put_forget_req;
 
-	if ((outarg.attr.mode ^ mode) & S_IFMT)
+	if (fuse_invalid_attr(&outarg.attr) || ((outarg.attr.mode ^ mode) & S_IFMT)) {
+		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
 		goto out_put_forget_req;
+	}
 
 	inode = fuse_iget(dir->i_sb, outarg.nodeid, outarg.generation,
 			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
-- 
2.39.5


