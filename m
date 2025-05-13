Return-Path: <linux-fsdevel+bounces-48901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE75AB57FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 17:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA87172BBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B42BE0F0;
	Tue, 13 May 2025 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="aoCmLwoF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6590528F514
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148619; cv=none; b=aMSXvJFA6IyBOwNRSSZU22O4tcOuQ84xsx3Wp541cvTl1oAmVuJNFdCWRfQSdRUip1exHJqZoQ8Hj11UdPz4nm2B0IYo6m1syyTnvCQ9mczRdVuOtR4/WyAybftnZ4b6fP4Th0oMmKPyCiVKWmUtRa2XABJwZvuY/5uU5HZ7Pgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148619; c=relaxed/simple;
	bh=3eb7PyfQipYAH2mOClQzUmK9oJ1sipNCNGsvmnU+0/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOOBVW/tcOE8DidJBKFncvxPHSfMWo4vf2NmSp2nxETHLXH/88NvM+vDwdM1NRsn0+kb/Y/XoAQlAEvy1PNrsfSdEALrBauerESaR5IY6O9KKHkLavoEl9yITW86oUNfA+l6M6EFRmUp6sx4sg/OrdIMBiFh8AHYiOccckdaejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=aoCmLwoF; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43cfe574976so41696455e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1747148616; x=1747753416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGJIs2TI0njjS/7dQefh5772Uvy+I7f3u0bLm0mKqKA=;
        b=aoCmLwoF/rssH1HZXPZp2yuHef2FLKWDU8tpuXri5oh5N1KTuTtvP0a8M800YW15hQ
         BcuES91ITfXeKFBKrABqPVpBPPOoSFTOZab9s1KYqPanJL2B/EleJSZvFoBPUmAUFCyS
         wLNKqmvnXpOdwWMRJ7CKcTHOdhYl12zKejsGMt/4Z9VYyYtXTenPAlW04NlpsWSVbqG0
         07VtulBq1UiuebDLsac23z03zq9fk3MgmTMFrnHwaPWOSfVkgwndfhnll7BH21jVHfo4
         3X8KW2T5yT0HyC5/4EEPzN7BVIpKfX7Dh7YroxefmVsO9TpM87SvWkL6q35OQcv97iQL
         XDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148616; x=1747753416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGJIs2TI0njjS/7dQefh5772Uvy+I7f3u0bLm0mKqKA=;
        b=kTno1GDM+n6xOKnxV6udNx1/RXUD01J39xmt9lGnu4RVzRUdWt6M9femIBVqEGiMhe
         M4YLW89d5LPZCKmCoqE6bYhlLz8gs2DgOvahpMZC13lKceFWJbmLl1dDJkz5qth+dqRO
         fL+GR9J9Ju1G/KknmrUqHDaXeTayYwPJu3r3OtiMUtxiaBN5/49P31f/L3fQD/fJw/Ue
         lEUbeIR6ZPONI/SRERIQIAE7eb/X86ifutysNLtuSaTlp5BltQ27oLwQ8Y7wGoyrCKpq
         DbnHzVK9VkJfypWZn+uxm5pzs7Wr01rbytUSrdA4WKttXPlvOj7P/2hZ9z48/eVhQOXn
         KKlg==
X-Forwarded-Encrypted: i=1; AJvYcCWvDgVfCwiTphK0clOSn1hg36gZ9DW+VDnlixxBfOd7b6NhTwNwOC4CPklIejuTSaMZR8nLyFMVLxheN2vo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxoj+MrcxWY0Zkg1ltZNIjNR6oKC+hX8U6yPeiukWpisfF5EH3
	E24OkrGA9hUAS+9/UG+cazuxMW3FnhTYV6o4JiDbwje1H3jbALG+/a12uLLogdhokMjmgcDQQFl
	XuqLZ/g==
X-Gm-Gg: ASbGncsBe2JZm9or+htRgpElt0uIBf8BHX2CEtL+k5LIlAGBQS4riIa5l3dAn3JYLin
	X4rQNu69oRnEtVGObMBJagPVDcYS0zi+njN+Gn/3NIdGQ/cvgLUCP/MlLrY0w/Zn3QWRP3fhHdm
	Oj4M9YmFDtgOCrjmRtP/Ch4ALrwhIDFnrm2QDXguOF0KTKYbTtHsxTx4D8jPeiR8HXe+Xg0DzrP
	IxBVUb0RaBwUZjSVPSU0Jo+CKPSCPOCk93FkxDfqqa+CGr3QOFgKqp9x/RxgC+GCFitmbNClDds
	mDdJ8v7Wdt5HWGyA53noNsRNfun56yB18vB6dfLgv1/4MN7uLP6gQ4qL3aeZtu7bqVU/FLab+bY
	BkncfZnkqOTG7PZ+ztJqAM72tZ5B02Z6LPE8o1BQPsLBrf0cJhd0=
X-Google-Smtp-Source: AGHT+IGbtsokICQNCqwJVgLywlMX6ZnMt2bLgm7dktJCKAmrvUn7dVbybhKncQSFP+L0Faqk1cEhFA==
X-Received: by 2002:a05:600c:8212:b0:442:d5dd:5b4b with SMTP id 5b1f17b1804b1-442d6de0e29mr181541005e9.31.1747148615543;
        Tue, 13 May 2025 08:03:35 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd34bc2fsm106800805e9.20.2025.05.13.08.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:03:34 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 2/4] fs/open: make chmod_common() and chown_common() killable
Date: Tue, 13 May 2025 17:03:25 +0200
Message-ID: <20250513150327.1373061-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513150327.1373061-1-max.kellermann@ionos.com>
References: <20250513150327.1373061-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows killing processes that are waiting for the inode lock.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v2: split into separate patches

This part was reviewed by Christian Brauner here:
 https://lore.kernel.org/linux-fsdevel/20250512-unrat-kapital-2122d3777c5d@brauner/

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/open.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index a9063cca9911..d2f2df52c458 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -635,7 +635,9 @@ int chmod_common(const struct path *path, umode_t mode)
 	if (error)
 		return error;
 retry_deleg:
-	inode_lock(inode);
+	error = inode_lock_killable(inode);
+	if (error)
+		goto out_mnt_unlock;
 	error = security_path_chmod(path, mode);
 	if (error)
 		goto out_unlock;
@@ -650,6 +652,7 @@ int chmod_common(const struct path *path, umode_t mode)
 		if (!error)
 			goto retry_deleg;
 	}
+out_mnt_unlock:
 	mnt_drop_write(path->mnt);
 	return error;
 }
@@ -769,7 +772,9 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 		return -EINVAL;
 	if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
 		return -EINVAL;
-	inode_lock(inode);
+	error = inode_lock_killable(inode);
+	if (error)
+		return error;
 	if (!S_ISDIR(inode->i_mode))
 		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
 				     setattr_should_drop_sgid(idmap, inode);
-- 
2.47.2


