Return-Path: <linux-fsdevel+bounces-72395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05084CF457C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 16:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E6833061294
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 15:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8AC283FD4;
	Mon,  5 Jan 2026 15:10:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399E3A1E6D
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625858; cv=none; b=N+PdmQXztXDMob0AmJOnXwzTie+l/UHbNk7jCg4n3CzVXSAtOxXh3xt0HLv0nCWwpzAAn7zRriZ52TtD1vvgI6XDyVXs5Djg5B2AxiY+iWUA0DRLAHOx1uvMnuQ/fasvGotABW408ivcZNV7gszkgdnJTKw64QAqF5FJZGDLFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625858; c=relaxed/simple;
	bh=u36PWBh4yDI8ZT2iUBF75swI9f7/OKlVQSDrJTnmZos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DX/H1pJfEpYiODxEdfVamUos868CYFRNh0Yy+bTL0ZzRI8vpREJY076uoByP8Wci9o0tRWH1vd3v2F/sUDGKsJRgx9AcVT/lZPWzyt+tVSdtlRzJY0XUIyUpHG5iKs4a0aJ/XK5W3MhFQre5n34sDP18f9FMwfzw7gvUKIy8qJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3f5aaa0c8d7so3254fac.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 07:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767625856; x=1768230656;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMUqaZe1HlAwvxBsuw2KJZob+y3kwCNvb0wcDt4zAN0=;
        b=PUY8Dw4XSB8NjN55gemiptu64Me05RnB7Blfcd23PmSokQCW38Y8qyiIvuXS01V7Wd
         uYjLxFoyANTRaQPV/4VTHfVGoGud7W3lMJhXOR+X7joxnXNUgtnD8edoNaNEzWTZfmjB
         fjvyW+WFrIFL515ngjviv5lqaRhrIt7TvKdHfQoq8CdFcDxBesqviPn8WYI26NbTq6ba
         t0jg/pSl01jWFiCw5tBH5SVRLHmR20TCJznmb12wg9Qg7wCgaiDZg18WpyELSAl6Efmq
         nwJUzytTBlM78z30e9coXqa07P7i8gZoKaVl5LOD/UHTMsnryBbk0GB2hpEbtWU+/rRn
         U4MQ==
X-Gm-Message-State: AOJu0YyRnDYJlRbGDSYRmOfpuyGKfKxsvNhyliGxxhWhCd3CFFS5FA+l
	y2fPm0N1gjNjaS9voavg4YlOp+keweFFtaIWtfaSkoLhLdYA7ErXWyFR
X-Gm-Gg: AY/fxX6EOlgRK0Y+1lCQip9CDvB+z+keTFNTNQxIr2WW4L80/ROg67m0/zJx9bkLCjJ
	TG71s1PoMfS6Nq9tR9pcHSCycNXLl7TWSudrz9R6fvDnunly6WnGTG1jaG1SzA01KFfJuO2rtTw
	e64DHduhyWCEc6kDO1JYR+/xCT+s0Rvw6YNLSj/oCSqVMusGub3z/mC10cSlUqSl48ybCG9g4UV
	hHIcgkotpj0lfZM0dNiHOE3qakl87VCKPlqmNv8eI5mMlnUh6KeexYNpDkNRcikPvLXD9NoUwiQ
	l45Q6EZYha6s857MKdLRQNypVYpwL4dTISI4w5Onq7Z5HfjFMYzKmvf8OKMstXGq2H2JSuxsIDG
	RYgv8xbwYOEPPXlacUlvAGKCKXtOsNt9W8XRnKeNxaxfyI3t5IxCpMKN/fjR9cWkeQvniCJINSZ
	4Ye04sCOBtrFUo
X-Google-Smtp-Source: AGHT+IGLAqoKMdc62EywNVMPYR3pwG4yo40iBpF7FyJBMFZ17/YVq8489e554IGjBVnvmWX9oKE8yg==
X-Received: by 2002:a4a:ef0c:0:b0:65d:51c:7fee with SMTP id 006d021491bc7-65d0e9fe015mr16836603eaf.16.1767625856226;
        Mon, 05 Jan 2026 07:10:56 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f69ba9bsm29689785eaf.10.2026.01.05.07.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 07:10:55 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 05 Jan 2026 07:10:27 -0800
Subject: [PATCH] fs/namei: Remove redundant DCACHE_MANAGED_DENTRY check in
 __follow_mount_rcu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-dcache-v1-1-f0d904b4a7c2@debian.org>
X-B4-Tracking: v=1; b=H4sIAGPUW2kC/yXMQQqDMBBG4asM/9pAErHQXKV0ESejjgtbEhVBv
 Luoy7f43o4iWaUg0I4sqxb9TQjkKgIPcerFaEIgeOtf1tnGJI48iLEuxiY5fre1R0X4Z+l0u0e
 f79NlaUfh+dI4jhPjwM1uagAAAA==
X-Change-ID: 20260105-dcache-01aa5d1c9b32
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jlayton@kernel.org, rostedt@goodmis.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; i=leitao@debian.org;
 h=from:subject:message-id; bh=u36PWBh4yDI8ZT2iUBF75swI9f7/OKlVQSDrJTnmZos=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpW9R/KC2HMUGNVhVBtyaw/Mx3J36QvTGMTN2Wk
 b9SP1g0X8iJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVvUfwAKCRA1o5Of/Hh3
 bdGZD/9aC/VOpoYXOQtb4qzpoLcHBMPATE96DyLEW3RWFRFVR8cbijyap9GV47cubaWQEjT9oor
 BkgmhOcntEvtEG4bvT66ZdDaN85S7AGyTTg33AAxNzxWXsrHCEWBluR+KPVZamcLM7kP+kBkuU9
 vM3N4Ma/qLGH58tiqA+sjrSyJLvTuJY6jvy3LJoF2OpXmIPIWLC5tl4Efg1Gpyy/+/cokbrBnXP
 yDTyTROSQjW/Yjm+qwtXOJTZ00mUoEvl3m6nLO2bkS0a4cOURlbM12JXIxJB4Jo60wxVjrD1hLm
 3yubvi6G0D7Wty2XI8mShy4oRjELlHyVICVcRXLKsHjwVvfV01PbVDCJX04B6YpPS644nvMXTJH
 WqsDUw45JEqswX0sKyGWywcb4DcxwRnhRKjPAh5UrJpr0BkqCciiZPn4d0IxMV2/m9fiJkJ5GTX
 rKUq1Zexu8cNV8cjOwjjUDc9/pY2OE4zmAOKRHlxtbgiQDHJZ0JNtuKfNIs/4geK+xxKEagLHp/
 ML9P2EfAiDeld3vKoDN8xqg8oZAiTzhYQpn9CLmdtyG44dZuowE0Ym9LG8UW/8qdxVfb2Y6A3P5
 9joASX5VYhxZFLMckA2NT6DDC9vIvzfo3t+49ee9pAS55atlJvVEzBfzhgYLJ4386H8AgLcbAYd
 SfCEwayilAR6tgA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The check for DCACHE_MANAGED_DENTRY at the start of __follow_mount_rcu()
is redundant because the only caller (handle_mounts) already verifies
d_managed(dentry) before calling this function, so, dentry in
__follow_mount_rcu() has always DCACHE_MANAGED_DENTRY set.

This early-out optimization never fires in practice - but it is marking
as likely().

This was detected with branch profiling, which shows 100% misprediction
in this likely.

Remove the whole if clause instead of removing the likely, given we
know for sure that dentry is not DCACHE_MANAGED_DENTRY.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/namei.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e9b9..774a2f5b0a10 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1623,9 +1623,6 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
 	struct dentry *dentry = path->dentry;
 	unsigned int flags = dentry->d_flags;
 
-	if (likely(!(flags & DCACHE_MANAGED_DENTRY)))
-		return true;
-
 	if (unlikely(nd->flags & LOOKUP_NO_XDEV))
 		return false;
 

---
base-commit: 3609fa95fb0f2c1b099e69e56634edb8fc03f87c
change-id: 20260105-dcache-01aa5d1c9b32

Best regards,
--  
Breno Leitao <leitao@debian.org>


