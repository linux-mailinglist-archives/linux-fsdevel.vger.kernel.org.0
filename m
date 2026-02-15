Return-Path: <linux-fsdevel+bounces-77251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mfCjLwzAkWmklwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 13:46:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A5A13EAD0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 13:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA83D30028E6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644621D90DF;
	Sun, 15 Feb 2026 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHiN5ZE1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1F84A35
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771159559; cv=none; b=NI7hWsw/MaU9EpHd++kV7QvDBKStafaMrJRI6UE6h8nRTjteD6fJvRgZkS5bhV/t6dff7bBUocWTSuIJ1q8UONbVCfkZtGXLxNmt7Pt8Gb0odhGhXyXT5U24Ikz7F2goHFut2loYlyKdgvsABNMg5T1/ZusSSiozqiiaTGXOMqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771159559; c=relaxed/simple;
	bh=kj25TsuIf28GO+0UAaQNtP4hQ7nw5VBdZAExx6bXo+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hn+5BxqB7nFKHPnXz0y1Y69UfxngQOU/MLS8ypLu5YRvi9fGR6rg7skaUmPi7p07iWsGPzVL8I0rmK0H3K5bojGjLYk5sjUIhmpO5I5yw99eUZ9SUCpZSxEAgZRcliduIZv21xJ62ktuK5YIq+xiigG8l/EWI32919pONbWfh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHiN5ZE1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-436e8758b91so1863010f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Feb 2026 04:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771159556; x=1771764356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qiu8f1lgiP7GYNLsQsmv6jJbUZDMtlGtb1+PjIhSSzA=;
        b=YHiN5ZE1uUj1DehTePnbtPxEYyOfBm4LBMfESi5ePQDfzvmEqiuaY5p0kmij7YVU4z
         u2ezvEOIrW74W5YpBhGFrRiGaFnBX7GHImKn+DsjR9dWcCwNIyvXnsZpobHhRiY8ogn8
         LvwTq71Osb93TT4K07QzGIzSPx5GzEPDvWyHZBrE8Q86nGT6EH3C5ACyvSle9ouB2gGg
         bruXyYP8fm3uMAcoxdXjOqlcSHRouV6YEyllmPK/sm3FuGddMHCrObtA7SLz08eI3T/k
         ME1K3e5YBiOY7JiPTwQ1GjqaLxer5Cd+bnTzyTo+VxTzWkmRDGfbXNWNzjyRj/Obd8JF
         GmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771159556; x=1771764356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qiu8f1lgiP7GYNLsQsmv6jJbUZDMtlGtb1+PjIhSSzA=;
        b=M/faZwuEpPMbKn3PyI0qsQOh7TxRwz7r1MMquO+WuiJbpDT0zUfWRVqOFl+sOoPGDO
         AZaIXt62zJu5vVTUBGnxLAT+gLH6c65fvcSHukKLySh33Hr9N63GTXtIJ6GjK1JxPsC7
         HVRMe1UoZyjfddOKbBn2exQoZ6vjSuP7JesZFwezoJU6CXrUBi3Hp/pD2kyTS9vucgzi
         1k8mrhwZdT74idJ2fmnsZJkTMIRcpdOb80F1cnyigk6IV40JDuYPaXVGetGoXqpqjSVA
         yB2KoVlrXqQJ0LGlgrkJUHZ8KZ50NPRobQ6qHkrmro6awdn6R4Q2xguGzgNdL6pRAFvi
         TLPQ==
X-Gm-Message-State: AOJu0Yxsab4HQuRpm2SFhZ9y2MvrXHKDguW+DXDAwc3Q0n4/51fB6D+A
	kat/0Zu51p1B8xum2rTvEIJEHNDhhiSOySjN+2tVqbmSDOCsI1X+o+8C
X-Gm-Gg: AZuq6aIJECzTedmOqWWB9sMuztSXgrM1kQHQDhTUfwU8xUSzWA8OOv017/ncAJqZzEF
	zcjDc9EeqpF5Jn0f+/5KeSIqOU/IuX5O/rJOlBNtOj2X4pYozD7VOZQPLJDKf21ucL7QRCil6+f
	sbHUDeCNip4MuRIylucn3SO0543F1xAIdEet0uM32soEzQWpIUpHUkCjbqUkKMMDpchbYn1fncU
	tJW5fLjgFFc3LQBHOvc1AI3/Xo4x4ZpsScierbZgHy/far6f8WSjM3YyMam+E7VZY4QxcM1WbFj
	6DJX6jRoRKUp6dBTJPyVAPPDE4EDwCva6IGv3rerJOd7CjBsNBsN6IuAj4O2yZESGpbv1mw84tw
	+h7aU2wf4wqAUL83RV90Q49jsNN5N/9xsgTtYa48cIZanrqjpHU0roTe+EpNIIyqet7TiTPdJij
	kYXzQVIS1+rwSo1DHdcTB1kd8/+A==
X-Received: by 2002:a5d:5f94:0:b0:432:5bf9:cf15 with SMTP id ffacd0b85a97d-4379db263a3mr10253083f8f.5.1771159555837;
        Sun, 15 Feb 2026 04:45:55 -0800 (PST)
Received: from localhost ([37.228.227.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8209sm20827144f8f.30.2026.02.15.04.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 04:45:55 -0800 (PST)
From: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
To: oleg@redhat.com,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
Subject: [PATCH] proc: array: drop stale FIXME about RCU in task_sig()
Date: Sun, 15 Feb 2026 12:45:11 +0000
Message-Id: <20260215124511.14227-1-jaime.saguillo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77251-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaimesaguillo@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0A5A13EAD0
X-Rspamd-Action: no action

task_sig() already wraps the SigQ rlimit read in an explicit RCU
read-side critical section. Drop the stale FIXME comment and keep using
task_ucounts() for the ucounts access.

No functional change.

Signed-off-by: Jaime Saguillo Revilla <jaime.saguillo@gmail.com>
---
 fs/proc/array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index f447e734612a..90fb0c6b5f99 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -280,7 +280,7 @@ static inline void task_sig(struct seq_file *m, struct task_struct *p)
 		blocked = p->blocked;
 		collect_sigign_sigcatch(p, &ignored, &caught);
 		num_threads = get_nr_threads(p);
-		rcu_read_lock();  /* FIXME: is this correct? */
+		rcu_read_lock();
 		qsize = get_rlimit_value(task_ucounts(p), UCOUNT_RLIMIT_SIGPENDING);
 		rcu_read_unlock();
 		qlim = task_rlimit(p, RLIMIT_SIGPENDING);
-- 
2.34.1


