Return-Path: <linux-fsdevel+bounces-78951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMMBHgbZpWmuHQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 19:37:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB1C1DE6E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 19:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9727D30512AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5618F352C3C;
	Mon,  2 Mar 2026 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2OFcsbg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9533F8BA
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476666; cv=none; b=F84nf05lGojpwhJ93vP1/MjRtM5ABUqObP2ua/O1TIjDrw3uQB/WXtV4ndjctdB6DvDbjedmws0T2cMZjWZvStbaQ4DaH1escOiuOikdbkOKowqsLUyb0Y1tWl2Mq6eJ7l9sydHNcJkOFCFEei4R9xdSGbzS78bE0HxXp+0XR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476666; c=relaxed/simple;
	bh=NdH6PGFv1SMAzPF2cmEQqn/xHptmIsz99bH9F3jAa3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIaHOXkSMrpPiLEFkMpz3YPEQwQtpe2ZVqeUeb/ZEScrMW2fWWL1S5EU/5wL204B1F2iDTbwsuJCR890GqqDBfuhs2wx6hD1qp/PU29Y+SL1tuaEy8seNfWqLGGzAw3a5rlPYL94fRC1gJBT3wInXFgKuSmnZNquopJncqk080E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2OFcsbg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65f94011dfaso8357658a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 10:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772476664; x=1773081464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6wxRMK3gKP7JTnkcBFfSrgUrs9VAzxTDGFiMc7uL/k=;
        b=d2OFcsbgtZ8GziHHWistvYMA+N/9nOgBtHmJGnIZvOpNy+U5fg22dKvxhtB4+aE6uG
         BhppM58OxlP8nV89c3Ch/A+MBsU+6Is3B5WWkTyvn4X0laesUgxR1uM3pY85IDkwhkt5
         jzFBIOXELq78OZy8ZkoDQs2i1oM4G2gK0er/pmj6KT2ztcRlAcds3nF3ZjFvSAUHY0DS
         6XohY48Hh81iA6uNCiF+F8XY+yxlFGqY3ZalU1VsTp2LXFVoGf09mFqtlAmugV52Dkvj
         7NvR9l+GsI56rax5aJYsAswFTZcMPmmUo13cyPFwHwylpL3fhCmR3WDg+frb0ywvYwdJ
         pnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772476664; x=1773081464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u6wxRMK3gKP7JTnkcBFfSrgUrs9VAzxTDGFiMc7uL/k=;
        b=Q90HmPR30DpkmRj2GTPLvhUGeNzwtviin9W6+RyOf7Z+sm+9FiaImH1O1nshDN7LjA
         P529RX9NWIhAPjsfwQnl09xv5BqwUyQu5qmDQPwv+9Qme96oNnuKInuLNM6fZ8toQ6nS
         6HYjIu8go8o9kT8PgXKc5Y3ZXkyaBmYNdMiBBFqXvJJ6DxlxYOaDXtkfNbYfn+eBMOlr
         YIkOVLbCxJDGM++JR10TYpx1SGiCHTpyEIk1WvlsMdCUGQSLLVPuNJ4IQcrJFdf5P5GO
         N1AKq1Vna2LeaWd6cPdvyIEGYZrxXHwRYQJ3SuaaOfsVJUsSyfh4BF0yb3RoJJfIsI27
         EN0g==
X-Forwarded-Encrypted: i=1; AJvYcCWfvux5HcmjAXeKfi6E4j5QW5PAs77avQV7pMF9gqi/jPfe15R/SV2eC64qNr7qwPCWsXhb5Zdu7AtXvPfI@vger.kernel.org
X-Gm-Message-State: AOJu0YwOok6Xg1al7cSLXE8lBcwP7x352a5SjeI/RvJR143x6ry8RJR+
	meQhhbefq+KOL5ys9sz+vgJuI6nJ8uliI+9szQmmpefxa2Xs4GBfRApZ
X-Gm-Gg: ATEYQzws3Fe6hK5qBqqLXn9Wsl19fZ+fDQdyxfdeTSaNSDJnWLmyd30vSZnDRuHfwFf
	tjkNytICQTH7ziGKXaKKUnBbXElHXTZkmuK44TW4kmWvxKHs0hT1CPiuiUnuEXEhQCxgmY02syw
	/HeTtulO/hFx1it6u+rBnp8sasWq+Uro2f63COi4UJqifQzhRYUAIF9P2pcZ2s0K7GzPu7gKe8W
	2iZeAnfFRqCIhAj3zOMck1epHYoptyNZ5k56DLBURx21OedQzeO5rkybpmCLTYvTavaz3vrYvnj
	My6IjYDEV8zI/dy+lAT4sxl/2+lzlc6+SR/l2vDGxr+VFFalGXPmIA1TjWS9P0ACj+4lME+v60M
	++NR3xRa5Glfli3y18W2+rgSkZTFBKa3hWQuZa4JeUGx79obN+hbiggX8zJz9Iqyer+aF39/1ry
	z/1pdsDWoEC56kgkFO8KKmaFYjsvci+5X/GeGZxnNPNYzRKAs0QHonACbt/Nk2kEooHijoEPDiO
	RLRwrDIInSxkmtKyFk+k4N3GXs=
X-Received: by 2002:a05:6402:2751:b0:658:1304:b699 with SMTP id 4fb4d7f45d1cf-65fde0e6105mr6230755a12.31.1772476663813;
        Mon, 02 Mar 2026 10:37:43 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-11a2-6710-0774-33c0.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:11a2:6710:774:33c0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6d068sm3664913a12.21.2026.03.02.10.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 10:37:43 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fsnotify: make fsnotify_create() agnostic to file/dir
Date: Mon,  2 Mar 2026 19:37:40 +0100
Message-ID: <20260302183741.1308767-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302183741.1308767-1-amir73il@gmail.com>
References: <20260302183741.1308767-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CCB1C1DE6E9
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
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-78951-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Like fsnotify_delete(), let fsnotify_create() handle creation of both
dir and non-dir objects, if d_inode is available at creation time.

Unlike fsnotify_rmdir(), we do not call fsnotify_create() from
fsnotify_mkdir(), because of the case where d_inode is instantiated
lazily (e.g. kernfs).

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 079c18bcdbde6..13156d165d845 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -318,9 +318,15 @@ static inline void fsnotify_inoderemove(struct inode *inode)
  */
 static inline void fsnotify_create(struct inode *dir, struct dentry *dentry)
 {
+	struct inode *inode = d_inode(dentry);
+	__u32 mask = FS_CREATE;
+
+	if (inode && S_ISDIR(inode->i_mode))
+		mask |= FS_ISDIR;
+
 	audit_inode_child(dir, dentry, AUDIT_TYPE_CHILD_CREATE);
 
-	fsnotify_dirent(dir, dentry, FS_CREATE);
+	fsnotify_dirent(dir, dentry, mask);
 }
 
 /*
-- 
2.53.0


