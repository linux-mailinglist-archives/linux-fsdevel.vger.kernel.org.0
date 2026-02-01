Return-Path: <linux-fsdevel+bounces-76002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PJJAZcBf2mQiAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 08:32:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85684C5240
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 08:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FF9630022F1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Feb 2026 07:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B5C2D061D;
	Sun,  1 Feb 2026 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlXY0zra"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769B2A1AA
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Feb 2026 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769931155; cv=none; b=YXKLwZH6FfsIvtXHoUgXxz7cVJkDQCsXmV8PJnx571JYF17WkRSK6n1eYAS2wFFo4YovnieG2QNxSZ7sOolVCK4KbJYXagw0jjsepzLDJd2i2qzp1a9TXqFndYLO02o/M56EG8hM2ZL1qrG34v5DneMpsZRm9GB8iVbwoIaAWu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769931155; c=relaxed/simple;
	bh=39BjO0NVc6MSs2r7OcmEWX0Ne91a2KELR0Mk7Bi96ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iOrnSyjVVR/uW9x9vEDt167rGxpOAPtlZX6AEo1Sh1RmW4PbNa1MvmVLOu0eZlQDjceEWkHcPwA5gkadi8iejAABB5a7L+oEPqDGZjWnVIpde62adyP86r0PfHqDcgDj7PeQqQ/1XlrkeF6hUeq1dKqqcoO2URmZ9NEFuo67pjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlXY0zra; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a79ded11a2so23558055ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 23:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769931153; x=1770535953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C76A9TzKBzMNSodY+ABhbw648AnFG9JcetNDNoIsqNI=;
        b=NlXY0zraNlre+fBUxRza7ud/2h14XEG7v9ik/jJ22wW2p20FtDszSB0PcDqMDun62W
         Qo/rQFjlC8MqkhcLwULcTe95LkerbnbZYugFOUN3hjCdiEXuohfffPRpTOLFIv+HpzKp
         jGaf8190X7DtpA3raOZeUxpe6fzcFtsT/7H4O8836iZAn8et7QQBf6aglqb+aBA2a4VM
         oPuExJw9FiZzyMxyYicJ5helF91RZTAL8u7Zx3uPSX7DLTMlrISd26Yf6iaABQYCsrZI
         Y84hmovsVYa35fJwC/fkj/QLWrv/vjue1nLx5DgKuTIv3TtH/cved5Qpgeff47V245H5
         flkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769931153; x=1770535953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C76A9TzKBzMNSodY+ABhbw648AnFG9JcetNDNoIsqNI=;
        b=P/h+H7BJ/5LLIUYmKoNQyC0QlYGiWRvbhx+xsS5eUsMvR4tYHe1ympQX0y3Dh5OhLQ
         Wtvv+1VPCfAo/vrRy9MkJNTvgxmqrNheoV3v5kbeaNUFRjWCBXUD4DVh5XBXWwk2dAtL
         Qk/wEk3jpnq5kAu+XSGnNJV25ybnu/bWyJlP78hOXPr7OObG86i6z6N+wmmMzZMiEmWc
         Mnu8GvISe5B6HIZw1W+JicSDgb5Eb8QKnSAvgw8EVIxDuwUDYS76Mlea1FH0C55zLe9H
         3V1dPPJUySLA91JM1QexwO9DShryjVkyvx1Yi1dhS/XQh7wB1fg5DHoc1Ob6h3dY1xFd
         mJLA==
X-Forwarded-Encrypted: i=1; AJvYcCUqX39YFgcmODIsOYebVV583eJvk446vW/d2/ffePJWHqkNT3HR1eHSdQ/q/yD3F9VNBUeS4W2EtPH5MTaz@vger.kernel.org
X-Gm-Message-State: AOJu0YxrprA+dX/HpYIYrmXf3DpUHW+FOFtLcdmpmzlM7oVQaUJlJMSa
	uAsgk5tCg2r9kJFoPmBnqMOT8r/5WpuZXn5L1QJadHZEa0xygOWaoFOo
X-Gm-Gg: AZuq6aLn7jeCiSY/3Nk4JuOrxLw+WEaZkdjwnzSsMm33o2kw+6LIDYo1WfuPzfR/V5j
	oVhVfWK27UswTxIGGvRgd7oz7D/s1V16u1BcXOg///uIs6z5AuVDZoGSXWu6Q09Hgee48aU0gcK
	8nIC85Cnj1IZShkpQ4fQ1oudgmI1FCyANGg7wPeXKw7TkmeCwpDSx+yfuZWcPbbjr8TQyE+E2jV
	YKfOXvvu9BydnOAbYhWKwWl4g5hQQ83oKGxQdfaDLoq9kNe09nMHINPFJmBq18SipQFiya7CMSK
	pDNq5I31CSN/xuZIS1xfGfSV0fGOEGbKWF5wbspyt9i5kIZKpXF9/hMeaO1xK9DQ7AxjfvoICYx
	iaovdAdDbxUMlYZGy9vnpw2V6mJrkk3hUpPB+OkbRJzdIffDrtu19NbYhLtCmjbuizoGjH8CvuX
	vgp+sEKmhZcn8VGUyqdnItLrVDirX9UtDxguPg8ItR+pyUznwwhA==
X-Received: by 2002:a17:903:2bcc:b0:2a7:ca82:c198 with SMTP id d9443c01a7336-2a8d9593256mr81213585ad.6.1769931153142;
        Sat, 31 Jan 2026 23:32:33 -0800 (PST)
Received: from Shardul.tailddf38c.ts.net ([223.185.36.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9a70sm118867425ad.77.2026.01.31.23.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 23:32:32 -0800 (PST)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com,
	shardulsb08@gmail.com,
	slava@dubeyko.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com
Subject: [PATCH] fs/super: fix s_fs_info leak when setup_bdev_super() fails
Date: Sun,  1 Feb 2026 13:02:26 +0530
Message-Id: <20260201073226.3445853-1-shardul.b@mpiricsoftware.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76002-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,gmail.com,dubeyko.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardulsb08@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 85684C5240
X-Rspamd-Action: no action

In get_tree_bdev_flags(), sget_dev() calls sget_fc(), which transfers
ownership of fc->s_fs_info to the new superblock (s->s_fs_info) and
clears fc->s_fs_info. If setup_bdev_super() then fails, the superblock
is torn down via deactivate_locked_super(). However,
generic_shutdown_super() only calls the filesystem's ->put_super()
when sb->s_root is non-NULL. Since setup_bdev_super() fails before
fill_super() runs, sb->s_root is never set, so ->put_super() is never
called and the allocated s_fs_info is leaked.

Return ownership of s_fs_info to fc when setup_bdev_super() fails so
put_fs_context() can free it via the filesystem's ->free() callback.
Clear s->s_fs_info to avoid a stale reference. Do this only when
setup_bdev_super() fails; when fill_super() fails, it already frees
s_fs_info in its own error path.

Reported-by: syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=99f6ed51479b86ac4c41
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 3d85265d1400..1aa8dbd19bb6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1687,6 +1687,11 @@ int get_tree_bdev_flags(struct fs_context *fc,
 		}
 	} else {
 		error = setup_bdev_super(s, fc->sb_flags, fc);
+		if (error) {
+			fc->s_fs_info = s->s_fs_info;
+			s->s_fs_info = NULL;
+		}
+
 		if (!error)
 			error = fill_super(s, fc);
 		if (error) {
-- 
2.34.1


