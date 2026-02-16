Return-Path: <linux-fsdevel+bounces-77301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oApjAS01k2mV2gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:18:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD691455A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 566EB302E15F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17892318ED7;
	Mon, 16 Feb 2026 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuFzr/K3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rJo1z+9+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F93161A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254396; cv=none; b=JtFHx+LG4gONM2mEZGMiAkFBlN34bHxnUk3G9o6Wk/xxnKC01BunHG2YoPXjLcscpzURYtg1d/lPwXlhd5vz3uJlj4Bo4hLikaScr5IU6mAQ14ozzxhQIGB6imNKO6KYLXLwkqS1rfMjf9zvUHpybhgTzx2401LsdOoXOUkoonM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254396; c=relaxed/simple;
	bh=zx3WubZPys3qQZ9hjzoig3BrUfn76syHM4LUOku80x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7u0Q4Ka9A4EelABPxCr2XZVRmsd+SUSJrYdaWrlhuyrEWRojUv5zmKdA/qiEa3qYP7NsQF18/WDj1uC5auvF/VgWFyvGjmj1wXIkAt8JLKNDzplItmPXtMBofddqjpkAVYDiktHWpVSwAJ036BmxsVzmFOwrKNjCuXAe9TbbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cuFzr/K3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rJo1z+9+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771254394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIxEocxEapJW7yU9OtfyLhPCnRBq6fT8ce1CcmY6sug=;
	b=cuFzr/K3/lCCNtXG9TWhKNqpWtuEBrQD8jPV3o6pv52qBZxjwahEFo/uOAaIsAFQhaqjIo
	NjyFGCLpVymV/0325dM3aEhd3YLHHSW7S57yKdqlLkjAPJWkfjZ2kr8NOqyh+vktnKL016
	ihNfMfd7M+PkFRqeu/fgEDMPV1XYaKI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473--WueFJ55Opq-52ua-prEWg-1; Mon, 16 Feb 2026 10:06:33 -0500
X-MC-Unique: -WueFJ55Opq-52ua-prEWg-1
X-Mimecast-MFC-AGG-ID: -WueFJ55Opq-52ua-prEWg_1771254392
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4376e25bb4dso3780353f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 07:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771254392; x=1771859192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIxEocxEapJW7yU9OtfyLhPCnRBq6fT8ce1CcmY6sug=;
        b=rJo1z+9+eVKxNpXT8hTbok3DlMsug39L9ZmZyXs8HXxMd5/qwbco2B5rsHfcj0DZK9
         l4dTUsA+rf1eHjjv9PBumTPUlfehW2Iyx6NjDvxxUQub90GfycXtkcrdkuzzp0Zprglc
         eOl8DHs8/ZZiamLGufa7JU8q6lxi/Nyu1t5yitPT5QJFs9Yh8hHckRxTwVP2Z5b8DQY0
         LkDJM5sjXzbsNSO2RaYHLtetNaXYr3TrjL/vPnXKQZUjcPx0ezMq2ybtGQ3N/7PIMy8u
         hREpb4n9EBeXeeH7pZF9kIE88FhagCxpQzaJWrY+bITz8g9JrMs7ipDRF+e3pvgXfT0d
         HrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771254392; x=1771859192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIxEocxEapJW7yU9OtfyLhPCnRBq6fT8ce1CcmY6sug=;
        b=vgjM7yQxpHDWgXEfliFalYlSnOp37ikUMlHfXkWJtnbSxYsjTL3xP44E3VBXncmhLo
         2Gj7Id/sa3HjUadWWQuvglD/skXIQznf4Rnt302A8L4EYDxCsXLjA39qA1zWxi1InCTL
         9kJSEoLnm3uRJCFza2PvudDsL7jms3Pp0d0UqW2ieJOyl24Bn+E8DZwpAOdpxcL+8p1B
         yrK/sdnJrgymtfIoYluJY/oB4kHTamlDrjYa/uU2uKL+HPO+KuzuKeGVnDyE8nt+2b7j
         WR6c9yUj7OBZenL5vtzjoR/OUkHeDeAjTqIKsnVoh9r9s9S8XG5tGedESjtdd8ealD8d
         j6QQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+GXT2dVSG9zGj/3iS6QRm8AZ4LlUwKxMo7TLKajZjQTZIXnvzQgeZcxjUIM2jT0G4L9YKg56WWCvIs0bt@vger.kernel.org
X-Gm-Message-State: AOJu0YwypxFoOiYpmBx5KdgDU7Q4C19QScfssGXHsPZY61bUSejZOeGZ
	5RpVmMiDKbev0kUs4sc/T55MV+RK7fRyYhEXFiIqBMh8sWSs62qSbsFdshhZuZRL4LR8LOk7/zd
	Q6GpSk1ksfMREgyL99z+epDfctjjkEVunXdt0f/4ZSzl+b/VGFyVXe9rKXaSdHJ/+JvM=
X-Gm-Gg: AZuq6aKd9xUoI2evGupm3C0wG/nXIjKqoXiZmVAiURCN7/ZGi+7uZUlCskVx3b6Y5Vp
	FL0NaLUs9dXzzScLtUeLO7kIyzs1AgW7tUCwpQptmZwr1ATeminoDbkxzB7sEOllFiy4st3P6Ha
	2iSnWaha6gpHQyTCPTYxs/evnVRi+mZeng7amiMH5KuiWtMdMFsxkQNIuHUWenz7wNALY8auqP+
	70m6fF1HltKJsTl5Rg71GrehXM67QGHxnSPa6M6+JdJkQA522dmi3haWBa4WPO/ES2Az26Qaniz
	b2S/X0g50a6j0A6EqO+qZmMP99Ytcex8S0tEyJY+vDhiJATD0nnyjMyS+q5ZA7wajvmI1jPMx+F
	KVMDiNiQqx0/TJyRQCpmX1Y25tKZ386z8RSij9jZ/mQB2aKbe
X-Received: by 2002:a05:6000:420a:b0:437:6758:ce75 with SMTP id ffacd0b85a97d-43796ac216amr22698931f8f.23.1771254392005;
        Mon, 16 Feb 2026 07:06:32 -0800 (PST)
X-Received: by 2002:a05:6000:420a:b0:437:6758:ce75 with SMTP id ffacd0b85a97d-43796ac216amr22698863f8f.23.1771254391533;
        Mon, 16 Feb 2026 07:06:31 -0800 (PST)
Received: from fedora.redhat.com (109-81-17-58.rct.o2.cz. [109.81.17.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc9b2sm25631899f8f.21.2026.02.16.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:06:30 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fanotify: call fanotify_events_supported() before path_permission() and security_path_notify()
Date: Mon, 16 Feb 2026 16:06:25 +0100
Message-ID: <20260216150625.793013-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216150625.793013-1-omosnace@redhat.com>
References: <20260216150625.793013-1-omosnace@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77301-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[omosnace@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CD691455A7
X-Rspamd-Action: no action

The latter trigger LSM (e.g. SELinux) checks, which will log a denial
when permission is denied, so it's better to do them after validity
checks to avoid logging a denial when the operation would fail anyway.

Fixes: 0b3b094ac9a7 ("fanotify: Disallow permission events for proc filesystem")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/notify/fanotify/fanotify_user.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9c9fca2976d2b..bfc4d09e6964a 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1210,6 +1210,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 
 		*path = fd_file(f)->f_path;
 		path_get(path);
+		ret = 0;
 	} else {
 		unsigned int lookup_flags = 0;
 
@@ -1219,22 +1220,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 			lookup_flags |= LOOKUP_DIRECTORY;
 
 		ret = user_path_at(dfd, filename, lookup_flags, path);
-		if (ret)
-			goto out;
 	}
-
-	/* you can only watch an inode if you have read permissions on it */
-	ret = path_permission(path, MAY_READ);
-	if (ret) {
-		path_put(path);
-		goto out;
-	}
-
-	ret = security_path_notify(path, mask, obj_type);
-	if (ret)
-		path_put(path);
-
-out:
 	return ret;
 }
 
@@ -2058,6 +2044,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			goto path_put_and_out;
 	}
 
+	/* you can only watch an inode if you have read permissions on it */
+	ret = path_permission(&path, MAY_READ);
+	if (ret)
+		goto path_put_and_out;
+
+	ret = security_path_notify(&path, mask, obj_type);
+	if (ret)
+		goto path_put_and_out;
+
 	if (fid_mode) {
 		ret = fanotify_test_fsid(path.dentry, flags, &__fsid);
 		if (ret)
-- 
2.53.0


