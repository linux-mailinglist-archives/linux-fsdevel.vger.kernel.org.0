Return-Path: <linux-fsdevel+bounces-76833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPL7Anz/imnJPAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 10:50:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F431191DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 10:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8182303101B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C31342519;
	Tue, 10 Feb 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1Jrfkg4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF9342518
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717047; cv=none; b=qU1L9M0RQ3tnnM7ctC96d6OjSsHXN7b06qO32CqLX21Fw46Tjpc6HDTqfqtEeKasvS+6UpLDnFAFACdtgK4uZ1m+82xT5tHfG/Y5znHbnOljvTEK6QdpHrKjeeCdtxX9lHTMer4aR4UQsTZdZXVB0iVLZxqs/DmM9cuy1wXotmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717047; c=relaxed/simple;
	bh=FzUa2h0cznjZCgel5VHCjhSB3pMwOsaKbhc6w65ivdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbCXJnWLvS6ccl/60VQ8gzQGhyET43tz4VCAon7FZYehWZDgkLWbSJwwzo/o8vxiixTc4NyjBPS1OLPy/nBvd2xIzwyWvgkz3L32VFg5HY7HrTSdGw3iiJ68EHgfOaPuswF/PuQY6e2GIFu7Ziv4P4LVXlpn7H0ODXlYogQcT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1Jrfkg4; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65a1b17a99aso319059a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 01:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770717044; x=1771321844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0mZEeVQ0QwOznaKfyu8Y0DuL81Ja7HibPoeTh6Jnlyo=;
        b=i1Jrfkg4zn9F0b5KeocofCLUfX3V2Uiriu3V7iWXEEUuRMVsY2LyyOpeDrp5QPNOPd
         ulwSubrv4mw3rJOLy61uWuIDi5SDITZJPpfz2fxVUbsQTBTJAKZP+zy/IesjxPnKirU5
         dV7osavq2e86clkZ36F+P3x8kSYfUfb84A+Sy87nCM9l82qOG2JucpbVckKk+zg5ZFjz
         fc5C1G8mPvmlbVC7HJWNWhnbQQm3yvZ2HlP/83hOo3kTvipJO3TSzu6WuSFngxNlSiy2
         HAAHg6XjN/4/sIaJpptYl1ARw/D7Hz7s24AV+hNPsIaQARiV+ILcIWEt9y+GazuQ8ci/
         2pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770717044; x=1771321844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mZEeVQ0QwOznaKfyu8Y0DuL81Ja7HibPoeTh6Jnlyo=;
        b=FvJla+4O24BUkFHMA16eCIhNYQcEe4Tx7MliZXTxlfEerLBX8Tg3sVpr1hMVASzQuO
         Aktm4eDAGXwvsFrwGr6aefT/igYbDa3KKRRAa8k+Qy2GVY6M6cbtY9jA2pckdoZKfWp0
         nIhfILSwU4ZHhBnijl7C/V8f98tDij7CG/la3ViWpgr9iZt9sD2eGEDbsL2zNrDrMjOC
         1wbBOBhsXgSdbfnZEsSuMpLG4Sh26FaoMDLbGRFYAU/L+4HX62Yz/rlwVLFHU+SaQ86L
         dYK+fqUk+wOrIULkRDhs+gYMt/NZ/ZP1J2l4WsPWGKyj8EQ6xvgqtzICmMe/7JNctfya
         2LDA==
X-Forwarded-Encrypted: i=1; AJvYcCUji2CBlf9RAkIeNiae/+FHgivRyxvOa/cYaC3sx7TWqwtbXk0ZLmUHdWa3sZm5K83K3FIIVlExfDoGO+B1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nxHFff+8gndPlojp4qzw/v7CVHmUpeuRtsMP7ytnlPM5rFzS
	0QaWk4K1JQkqzFyWZ8LsEl3KYqIUbko4ZtgEtVyaJJvo+SdO0IdKS3DB
X-Gm-Gg: AZuq6aIWfddKmRBoREOIwcJvs+OeclBSdfbgkLRxdeZwYcfMebQe+sp0AEIq11VkOP+
	nfiukGft1i8QyfTkHRa7ScDJYD3MQMXcaOXMg99//KzUqacqgL2pPccHK6ivWkHdnZN6AKjuI66
	ktbJYujUReG9bKkbgWKnllwkyZ6ms7fVCFRq6eSVQvMn8sub80VxUEGgjGWVB3bvMtoaknuhUsE
	kU4EdJ6BYIi5PWdb0u9zHPfkrxP01QCuMRnX8uLNMDA2Urs4atZP9nmkqWWPwMyuhdyWzRj0LQ7
	nqbs8NpSu42z9xEwXchZmbPuz0nrCGF4qT4i567Z0aMhsV3lGeN/b6I96oU5g5DRhzqa5fmgYUt
	7n+8G4VSf6wE8wj1vu23kOTHnp/qaNGHOEUelurM/wflwa8TuI4ZGxx5p2juDinTleIpFX4/5xl
	ebv9pci+rb8ZcYYwfms4D/sKwB3gdgd6/9WpW6a8bQ3LU341av17ephUnQUp6FlQGLGkeP3m8OC
	jFzLJuE4SKayWZ8Y7te8mGhyg==
X-Received: by 2002:a05:6402:13c1:b0:659:3ff1:58fa with SMTP id 4fb4d7f45d1cf-659843bdc44mr6047224a12.29.1770717043948;
        Tue, 10 Feb 2026 01:50:43 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-0695-e133-2257-07cf.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:695:e133:2257:7cf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65983eaa593sm3602304a12.2.2026.02.10.01.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:50:43 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com,
	Andrey Albershteyn <aalbersh@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] fs: set fsx_valid hint in file_getattr() syscall
Date: Tue, 10 Feb 2026 10:50:42 +0100
Message-ID: <20260210095042.506707-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76833-lists,linux-fsdevel=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel,fa79520cb6cf363d660d];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61F431191DC
X-Rspamd-Action: no action

The vfs_fileattr_get() API is a unification of the two legacy ioctls
FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR.

The legacy ioctls set a hint flag, either flags_valid or fsx_valid,
which overlayfs and fuse may use to convert back to one of the two
legacy ioctls.

The new file_getattr() syscall is a modern version of the ioctl
FS_IOC_FSGETXATTR, but it does not set the fsx_valid hint leading to
uninit-value KMSAN warning in ovl_fileattr_get() as is also expected
to happen in fuse_fileattr_get().

Reported-by: syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/698ad8b7.050a0220.3b3015.008b.GAE@google.com/
Fixes: be7efb2d20d67 ("fs: introduce file_getattr and file_setattr syscalls")
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 53b356dd8c33a..910c346d81bcd 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -379,7 +379,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	struct filename *name __free(putname) = NULL;
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa;
+	struct file_kattr fa = { .fsx_valid = true }; /* hint only */
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
-- 
2.52.0


