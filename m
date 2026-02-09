Return-Path: <linux-fsdevel+bounces-76717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN0sA5ESimlrGAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:00:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A608F112CC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C3EE3008C3E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 16:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B058B3859C9;
	Mon,  9 Feb 2026 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmjtp9rq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F66B3815D0
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656394; cv=none; b=Z3Rk+13u3BpCCOFagv0C5qQ6ZdicW6Koq8xRocqBmhgmOc4IAzW5f0tonpgrqeGMQM59+wXIrtVneIuYO7ZCIVi+bdKQcdUCVXGOgdTyVDOGOg6YVouxwhesbDbDoKfi+3iWJ+7rdTfYU8pz7Rk9HJkKcZ1f99d7yTmjYAGEMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656394; c=relaxed/simple;
	bh=kilC+CY0PbwU9Geq85da85AmbW/kV1eBYvXJ+6IbO54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vE+eW6C3qyvlkn+YJb3YFCytBa2h3PR3hOwKFhrQ8IANRY8fhBFnW249t06bvwBPy74TDRgf+mUAD2e+OG7TDeiP5y8zkhQsk5V+BrmCApjnr0G65dx44cpY2bYUbGHef1HCFLFO05F4pyOpYPNCL2hg5xJmzwPaTXTschS9OgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rmjtp9rq; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c65822dead7so1273748a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 08:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770656393; x=1771261193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1HNYwUlSCRlEFXpslq+538JuWxafl01gdryxPWoDLs=;
        b=Rmjtp9rqShOgOL+zAvupXkwCE9AxWqVvjIVSoiLZrjk0YSCQv6zOdXtLT/QyQvcp6A
         ZJPSqy+PyvaBNeRBYzUZXVgqjzvED2Pq176SFTAX3dL6VTAsF3+seGRc6rp7P84+eW8T
         SOQCdnVmsTqsoxeinRmXJztEXetAr+sNR0jVcjp8QJTO5OIRG6ifNo4hAVZ+AqVfVMgL
         8JfWZtMUlQV3/vxoFYpOXNmtL1Sh195KmmbhmIB4AcJeFsmaCx8W5Af/KDR9+cUz8wdw
         DFr7aRg+R8rR1A5msNoLQlSWXnEQR+sqINA5ahbPxyY5htc+pFp3rox8+vtjR4vnId6P
         R4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770656393; x=1771261193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1HNYwUlSCRlEFXpslq+538JuWxafl01gdryxPWoDLs=;
        b=a6zn8msUav0hsGrdQhkxArcnbSMN0J5kkw3n8FgJ3LJ6yEfjkYWsi6Tcv3w4bZJAQP
         2XUbmp9Ht15WJMd/25gx0YlDLsIPQr2pYqKhavWzQ/lwJCMBjdqsYBGFRzYnW7m5Gmto
         n6E/OB1jllyGvofQAJCxdk9YrAu9hyLoU9IiakkjdhGlrgHoZ1r48q8w3XvP01ySTi0D
         FRUu4oWgYvwtuJs2PzIg07B3wbmyqYOOF5HiDcteb7IGcqh9+aBBw7kuS92O7QjzAO3p
         5hawM361KWm7/nc5cfIuoIZq9i2wx1zITUf9lHH24LBuybwkB4PKEoLf05x86tic1nRf
         faSQ==
X-Gm-Message-State: AOJu0Yz3VUJ4FRpg8gSMBBvLs5AfW7RieJjjBtSxNFr7VVjjANx7C9ks
	kNrQ14HKpF2GxhUfJ0Y57X1jqxYQOrn79vxZcw71pd3RSa6x10hAwvtlvywJwkrW8Ts=
X-Gm-Gg: AZuq6aIcTcRy4lLEFcsj7/PQ1BLGNSiwscaUubG6+GwF1vNTV9yfoCdhzWeNczzKueT
	J42qsMSpvlAXLAyyC5tiskBABk4qTp5rgG+/NSo3YMiFg8EMez7gkjxCTdkYx0HUYzB/2MLC0aG
	RSTv1913Qfy9ICV417R3ZtSLY4hA3h9Tz9awdLloo0rQ+qhPoshoH0Ut8DXQNz86ZPKjtmL4FPi
	se8xfhVkVNTpqKUmztQIZPUa6lklPjk+Yit7HO5inbgiOgZEPX6dxI0j6lbGEYq1frcCppIiz89
	keJKR50hf0d6F7OjLqUztZjjea0Z7f0iXwsrwr1o+GVf3KQj+cjaWVrDRj3vj9/QAb/Yozy1xLc
	nDLQYMN9fORfwRz/lTsgUaXQ8r5EyGdbQwRLJRlFQ9CL7jQV9leHHfOCqytjiVr/ncAq4DVpyqL
	M51MXwSCq366oJdJYcu05U3SVxOAL+wS9ZRFFf7gE=
X-Received: by 2002:a17:902:d506:b0:2a0:8ca7:69de with SMTP id d9443c01a7336-2a95180d2d3mr115999505ad.41.1770656393100;
        Mon, 09 Feb 2026 08:59:53 -0800 (PST)
Received: from localhost.localdomain ([115.199.244.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a95eedbceesm87069465ad.84.2026.02.09.08.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 08:59:52 -0800 (PST)
From: oaygnahzz <oaygnahzz@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	oaygnahzz <oaygnahzz@gmail.com>
Subject: [PATCH] [QUESTION] ext4: Why does fsconfig allow repeated mounting?
Date: Tue, 10 Feb 2026 00:59:44 +0800
Message-Id: <20260209165944.12649-1-oaygnahzz@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76717-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oaygnahzz@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A608F112CC8
X-Rspamd-Action: no action

Hi all,
The mount interface will report an error for repeated mounting,
but fsconfig seems to allow this. Why is that?

Thanks.
---
 fs/fsopen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 1aaf4cb2afb2..06a8711dd627 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -300,6 +300,7 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
 
 /**
  * sys_fsconfig - Set parameters and trigger actions on a context
+ *
  * @fd: The filesystem context to act upon
  * @cmd: The action to take
  * @_key: Where appropriate, the parameter key to set
-- 
2.33.0


