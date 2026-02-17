Return-Path: <linux-fsdevel+bounces-77431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHP5OAv1lGlzJQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:08:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 973B4151B67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 00:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4345301D0C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A438830BB86;
	Tue, 17 Feb 2026 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="TGLMzBdX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65D2C326C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771369735; cv=none; b=c4h63rCedELwfbQ1vMNgrAr69cdbMA4ldeN3kiebqLfHOjWSdKVCdOL78FEUhzEE/jgDdMzGA8ricb1bwFiA2Mb8ESGP+8d3/TLl0mF9OJxqgQdiVsUTgzSw0tTMnbYQgbrKLOqo1XKYRN6f0rUhiL1fCZ3ufe0y1a58O4xRZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771369735; c=relaxed/simple;
	bh=eyYGIGbK90bu27gEPiQtwlBvLNviNZEZhitAIZTlBlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OsoZHcxGptwiefuWPFzV0V4+v+ZJZGCje/UbWcRjH+PRiHbek3M/YU+FzaLmu4pa62DzIy4eXDK/FJzpi/LKz5wCTwtAjaht0nn1smJZo+ZHPdYcuGQz6TBFIzpRBigsdIpBPCN+1Y+vEki/KLnZjiGqF42RlgqcNVZAufw3YlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=TGLMzBdX; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-896fa834290so4260706d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 15:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1771369733; x=1771974533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mUyheGNIn++IfCjbqs643YnVtLDbWUz6I0VNgAep3mQ=;
        b=TGLMzBdXr3/IPOq9h/3Kfdv/yJiKCgRBgBNOk607B0n08VmpMPeJ8LHzuko+kPxIfD
         bTKz6G01fjYsQUmDFWlYWECBFtxJUySlwFSwtYrGTKo5pVux08hSakZoUp88ky56tqfL
         YIO1WJMgpte2dVOTFYGmT6cZuPdJNjSXJ7HRG8P34dMBGqDV1n5CADAKK6I+8JYsF2xX
         9iXB/2VGd6VMT1O9NFMPYEgQEbqECGJiY40zxj1sWjmnoY97uh4jFm0KrStBRMw9Xe7I
         LHQgtuYmDyXJcQXbRrpGl8KldUYCOhoYcEErsbRfgYAjilm8HYtroJgBenGL67IX9AeQ
         Pfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771369733; x=1771974533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUyheGNIn++IfCjbqs643YnVtLDbWUz6I0VNgAep3mQ=;
        b=BA6wg/XN3XvkV72B0Yb6Qd46YW6ZtOYfmTWplUMvGYMdt7xRMJeMO/1NPCg3r0bqfu
         dqs9n4Y2Zii8MPRG0HFwIKMdZTM9nHE/KF46ERlUWxysAEMEmKgtzDwWkIHYsb2iyMYN
         EBm3CSD6kLYxwYDiLdbD96glkR0E0kikIM8aMt26Qe1c3yIzk2cLV8SEcurOhOUYW7ch
         TE6r5rUA+XsjJ+CW8Op/Fnb45zVSbj/9eX2fGyG8TTvILhyww/lnPksweCF4fohJjgxH
         1SKjPPVyVavg2Nf3bUML/zk/siWOzjJJoUOSwAugK049sVvYphPyaBtTtfZV1ELGOWJM
         tH2A==
X-Gm-Message-State: AOJu0Yx8rNVbD8vxAE7jTT8U+/Bp2kf7a57ackcHVTr17G0SEKyTy9AE
	HqbxSUrAQwiI+7JZFUJfzqYyXtODVUp7X/B5EHsusVwmveCtIy2RxslNzf4jEOGpq14=
X-Gm-Gg: AZuq6aLlIPrqrOyDJ/9PUJK0OStzp2GkP9cqfDry0mqO3PSRIuTiL4joY8QcYFgc5Bf
	Xdd4gLzqQFWXxsd51h/ABRR6mTDilFzb+qbCGIxK6M9yWEUmvCYrdFSgf737G4Iz6Zbp3BJUaDh
	cDxEXNub43Jg8VFXz/wO4dv0SYiPOqDYmmxBvF09LPUENsH6XdzBHPbhGNaGOxaOVKxnNIK8kGq
	2RRotv0eIEcj7T3AFLKTbLh/R9keIWMb2AGEqRYT+CQHC+05VFhb8kENqJ3Amc6sjbnoIFRDlTO
	odAJwmpQA+qMRzcTq8npgnyLkz0YzDOidJxjfzoUM7RKPeEOukDy7y9UJOSkOJwivJtxNVfz6mM
	aNBc8UlkvvXSEmXl4jszHP3XQdATuzJBC0Rhd5a5hxD/pXylTKbIau0Uw8rOUuVZ+NZd51QIk5t
	5ywUP8I7nmISsfyqqLIwnkXjBjQ+PmXAKyrp9w0JTm9i3S3RmVxviheQ42dScB+o4yCXQAHyRHZ
	tlv
X-Received: by 2002:a05:6214:acb:b0:894:713f:65a5 with SMTP id 6a1803df08f44-89957ea00e9mr675476d6.35.1771369732948;
        Tue, 17 Feb 2026 15:08:52 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7f82csm175513186d6.4.2026.02.17.15.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 15:08:52 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v2 0/2] fat: Add FS_IOC_GETFSLABEL / FS_IOC_SETFSLABEL ioctls
Date: Tue, 17 Feb 2026 18:06:26 -0500
Message-ID: <20260217230628.719475-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zetier.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[zetier.com:s=gm];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77431-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[zetier.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethan.ferguson@zetier.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 973B4151B67
X-Rspamd-Action: no action

Add support for reading / writing to the volume label of a FAT filesystem
via the FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.

Volume label changes are persisted in the volume label dentry in the root
directory as well as the bios parameter block.

v2:
* Create volume label dentry if not present
* Respect msdos shortname rules
* Add locking
* Fixed bugs (EFAULT from copy_to_user, uninitialized buffer_head)

Ethan Ferguson (2):
  fat: Add FS_IOC_GETFSLABEL ioctl
  fat: Add FS_IOC_SETFSLABEL ioctl

 fs/fat/dir.c         | 51 ++++++++++++++++++++++++++++
 fs/fat/fat.h         |  7 ++++
 fs/fat/file.c        | 79 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fat/inode.c       | 26 +++++++++++++--
 fs/fat/namei_msdos.c |  4 +--
 5 files changed, 163 insertions(+), 4 deletions(-)

base-commit: 9f2693489ef8558240d9e80bfad103650daed0af
-- 
2.43.0


