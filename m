Return-Path: <linux-fsdevel+bounces-75659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMNqONNBeWmAwAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:53:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1398C9B41E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E03A23047BDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8942287247;
	Tue, 27 Jan 2026 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/BIQipH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA492D9787
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769554343; cv=none; b=ZRZ2IOL0GIlRU5O8k8PPE5OWzkmOnEkzHQsZ0OmzLwPjEEV2fIEE7KcaCh+zUL+1XS7J6vAOHG4qpYdfMqj+uZUF169R/XiOsvmVKCdr0AmaavuHNHRIoii0ZSIk5llt3OTiumvTykNegSoBHVAov3B4CtwN4QwK8kef2uhJsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769554343; c=relaxed/simple;
	bh=TzaPQemtidNahvv9NoXXFrUd1zD+DnXnW2gBNSkHExU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHxKveehWhrIhyyO5y2PQCRFEpO4qglQ9pJIHqn6WRYpKGCX4WLhwpG5vD1qRC5QOTbqa04ZwZ3Gn9kJKT85pp5HWRVnCpPG65wj6ZlP5uhlFJC8siFnpOcgSRnt/tHSEPH8OB12323CIr4XwAo+KysUNqoERL78i8BKfqfu/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/BIQipH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so69915465e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 14:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769554334; x=1770159134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xdt6qu8vNgwVPoNYWH9CTkXv7a6EP5fK9hiGlLHPQg8=;
        b=f/BIQipHEfDfhdkrMe3aqMSLdggCjOiOqEAy1GbZFHL6D3quiw/z9jX8djSIzrEVzM
         Dl9r8SbNh3TceclojySx1hxRMx0I90J8pziJ3dlq9GC8+mgtdoj4jkkJ76augQP1pTAF
         GeBIfND9u6SNKXe/mBtvCDzSdiNnmYGHlGE7ps6X8GHLiMjz51rtOPrbhwaByL7U9G40
         GPCPVqoxtW16BL8xKMxVPJEH6ZUJ2GfYCkKeOIC/P85GRyG0BWRd56/p85kgxHy0zPvw
         6MomZiK/vj4JSUY/2+XpIkPnlP+lOxGHkHVpnKASvSM4rcHoJpko/Xkq2UcunvPyg6P0
         U+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769554334; x=1770159134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xdt6qu8vNgwVPoNYWH9CTkXv7a6EP5fK9hiGlLHPQg8=;
        b=B5kMqfjaXmhzBJ9gN2Rs9zkQzuIgEkj8WY8DYG8CpnwgysbBe5oGmBWgr17UV+95s1
         Zidbd8us931Sa2vuhlhuZh/oXUFmhX6SANcOH1dKM9cdaNs0wd8qztJjMwVZkSfHJadk
         JDV2xyoI/qvFiThy4/E+W/Jrkbsj2/zaSyRC20omZFCWU2V3xYGOuCtVshaEh/yWYAJn
         6aFPVsY5HqOieyHDbi9rXlLFASvx2rxNNSDHZNJ0hufdBUw5/ht6Y6hPx8FD4V2jIall
         bdse1QQ0o0q6hcBD1k3icY4beXVZ8zDTtUT+J0sEvnPLvl1i0zXdMXZcqPqEjDN1jYCz
         MxWw==
X-Gm-Message-State: AOJu0Yx2NP7W9noBd19cJvU8iVM/TwCfWw8qbFwYDK15kK0ZiGbcXV0u
	jw20PR+JW70Vs7gSpom5KytB6m//YgPF9hYGggj46lWQg4swDjvbEd7ZQjv30w==
X-Gm-Gg: AZuq6aKodahriXxiQqYYs5drH+GV2X2Q4ffaoC4qrhgzWRIiu7OfkhQ2gotMU/GP4rZ
	lE0eUbapjWwA1MQe+/ItvXeM4sQcRX8aCvtSFgrHLJA/rzqmZQPozt5OMkZgUg/YZZwJ/6kluRY
	InrZjDJWkP+yy1qFEz7uMx0XlfbCEW/Aaic4vW6dIX4Q89n6iILtdmBKbIABTRLW2QIkJIwp9Vv
	zNRjxpN+cI1QSNjUx+ZWQUKOlJ1KXc51LdNQa6IrEAwOMpxiuMu/a1xmq0xDqOn9JjLOPH64Yyz
	2FH6sSPT3JTUs7ljSZe7qY77UkF1i7qSiyK7Fw+KWjd6yALno5L1VXDtihILiqGEr1eTea9Rcbu
	WgBREl/Q7ubeiODHyF/TI7dxfD8Is91flnilfN8pbQ+3a/yF+QzzXD4UMQpXVzT2g/H0KhHu9IE
	+12thrF3vnI2dVSPrpQhBsPcI=
X-Received: by 2002:a05:600c:4746:b0:47e:e87b:af8 with SMTP id 5b1f17b1804b1-48069c5a226mr45196035e9.21.1769554333608;
        Tue, 27 Jan 2026 14:52:13 -0800 (PST)
Received: from localhost ([2a01:4b00:d036:ae00:24c5:d341:4:69cb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4806d98c8desm12567535e9.3.2026.01.27.14.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 14:52:12 -0800 (PST)
From: luca.boccassi@gmail.com
To: linux-fsdevel@vger.kernel.org
Cc: christian@brauner.io
Subject: [PATCH] pidfs: return -EREMOTE when PIDFD_GET_INFO is called on another ns
Date: Tue, 27 Jan 2026 22:51:37 +0000
Message-ID: <20260127225209.2293342-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75659-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucaboccassi@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sourceware.org:url]
X-Rspamd-Queue-Id: 1398C9B41E
X-Rspamd-Action: no action

From: Luca Boccassi <luca.boccassi@gmail.com>

Currently it is not possible to distinguish between the case where a
process has already exited and the case where a process is in a
different namespace, as both return -ESRCH.
glibc's pidfd_getpid() procfs-based implementation returns -EREMOTE
in the latter, so that distinguishing the two is possible, as the
fdinfo in procfs will list '0' as the PID in that case:

https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/pidfd_getpid.c;h=860829cf07da2267484299ccb02861822c0d07b4;hb=HEAD#l121

Change the error code so that the kernel also returns -EREMOTE in
that case.

Fixes: 7477d7dce48a ("pidfs: allow to retrieve exit information")

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
More context: https://sourceware.org/pipermail/libc-alpha/2026-January/174506.html

 fs/pidfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 1e20e36e0ed5..d18c51513f6c 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -329,7 +329,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	 * namespace hierarchy.
 	 */
 	if (!pid_in_current_pidns(pid))
-		return -ESRCH;
+		return -EREMOTE;
 
 	attr = READ_ONCE(pid->attr);
 	if (mask & PIDFD_INFO_EXIT) {
-- 
2.47.3


