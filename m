Return-Path: <linux-fsdevel+bounces-76719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJDtHHATimlrGAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:03:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA15112D5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 18:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 765CF3008C90
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367D23815E4;
	Mon,  9 Feb 2026 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an1Ii48E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3D239E75
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656519; cv=none; b=ie9y74bc/q1MbxMzFPQBTUw3Z87bJq+MPadUpDHjaUI7Kr4wGOGLKF2M5qoh5WFytPDTTLZ8TjB2ppJlsw2sIoAlkOyg3nIpAwPqo9eAC8H2sijp4xlowCw87+RNEj79uMyAA84eMwPOArsu34+TcLDQXDgTnbOM202+Ezawos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656519; c=relaxed/simple;
	bh=kilC+CY0PbwU9Geq85da85AmbW/kV1eBYvXJ+6IbO54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UJBQJZM7BeMLnH0OEAL12n5GDG8k2TGPPA6EbB3bIuuqnUICqoFa2cGl7CmJkrNDA4dbCJ0nXq5tVv4iwgrwwQs8jOPxqcFwQRtBX+ZsFH7K2RGCsVaEE0JgpyVDqNWaFzDOGQIOL9ishV0C/KexU/2HoClzJW9NtHzzwzAJLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=an1Ii48E; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82311f4070cso3097827b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 09:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770656519; x=1771261319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1HNYwUlSCRlEFXpslq+538JuWxafl01gdryxPWoDLs=;
        b=an1Ii48EvPMQwChhu4RltLeY80PHByoCa5CKIG4PkBedu992YmKkQkQlCK5A9jxABC
         61jQCnsJg76rqY9ePZqfdAWq4p8/dnlWRv3vJPZsBLEnI/lLuXukC6HwpQHowNy9Hg3z
         hfs9WbM1F9Qfoh49KiJZgGfmPGwFO2sYHwjp1uJh92VMyU7wDr7enQRWqtePr1tg/hbm
         ySVPPQtqvgU1Hplkxh1qD1rx+ggryvDP0SIEpd86ukwia+YD7cqXu/c82pgvKl1/FtY2
         xN3Nrcc9Uqp+rvGHJTIwCPIDy8sEhwtstZIGABfpQCnINm8HrlSa408x1/UL8Rw6thEh
         fm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770656519; x=1771261319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1HNYwUlSCRlEFXpslq+538JuWxafl01gdryxPWoDLs=;
        b=j/e3IWoYd2+sxGc4NnIdO2ouYHQtpiU5reeP865cAIxuPRL1xDgW8iOE5fVBLP2pQf
         5FyG/a50AdciPXjCrK76YgrXd3fiagjPRsRFxBMyk8yUI7V+WoeOAVjQMNRueT5RBzyw
         HRwPWpTPo8v/CmVT+i4jD+hI5dpjZLobvRl9626hcKEjevk60JH+X772YJjmGlIc1h54
         2CFtT6Fzzwp0hUfk6dk3hMVVGQaPT6hPQMkQbAJWfcyiu2sR+J0BNL9Ho6IBBcVxmvKh
         RXqT4pJKx71M8rG6QpzkdeccSrxYR2sIX7Tecs/ANCz/Q44WBc/j5SOgSHI6sGqi1Uvd
         4A3w==
X-Gm-Message-State: AOJu0Yy14jma9GEVXy1opA+hEJBB2iu8ryDvDccjr0m/U743XUltXQNc
	wd5TcNVpxUQNV66nd6d4QXZSrg0g8M+o5ove/7UCze9rz5lvfNWf/wBw9TTarZvK19yCoITb
X-Gm-Gg: AZuq6aK5Ernrgd+is3HQ1WsqSIeq+eI0Kxu6iNOQZaBeIuJqLMVab8SpLZSwIqZvH91
	1c3E69jRC86e7r50271CWsMevX4UoRjLjUilt+xqxbtdjx0tkDQT9j6SQY2ecuA/xr0LT1NWcxt
	3gZ/+KdBqv5uGWHzvbYkG+Usu14pMLfYkZGbWdfKHCQwVDJ0rKj3TOULn3ZRCwu1xnUZ2eS+fT+
	KnJduW5PNnNm9mGHVrIlSeTm924jS1Jf1j/074FEov5d9WQDd02Q/Ed6lA3wU9y70xw/ycbK7d0
	n6a5mNDln5xSjvD2nZ12/ujDzFpYnwgX3rC9ZVMwsTlrexml0Kd20azVNVLJgQynTfItdc39Gh8
	LlKkxciUTHBgzA7gHoMk5Xw9bdAwzY/S17Jv7yJPqWe6JIlffvpKMUGNgSyYreqzpCUcZ1FzatU
	97STXq/SVrxeLOwHJfTzMzcKhva3AJz8B3TSeje4qkW8//JNz8+w==
X-Received: by 2002:a05:6a00:ac89:b0:81c:717b:9d31 with SMTP id d2e1a72fcca58-824847facc9mr79621b3a.2.1770656518677;
        Mon, 09 Feb 2026 09:01:58 -0800 (PST)
Received: from localhost.localdomain ([115.199.244.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418b7cc3sm10922549b3a.51.2026.02.09.09.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 09:01:58 -0800 (PST)
From: oaygnahzz <oaygnahzz@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	oaygnahzz <oaygnahzz@gmail.com>
Subject: [PATCH] [QUESTION] ext4: Why does fsconfig allow repeated mounting?
Date: Tue, 10 Feb 2026 01:01:48 +0800
Message-Id: <20260209170148.12688-1-oaygnahzz@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76719-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oaygnahzz@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AA15112D5C
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


