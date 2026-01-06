Return-Path: <linux-fsdevel+bounces-72560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B43BCFB5AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 00:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5D8C3021063
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 23:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296392F39D1;
	Tue,  6 Jan 2026 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Hhs6cudN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D912525FA10
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742581; cv=none; b=WTyIUcYfvl8OggOGpz/rpZo5kVXrIR1zRPFTJl5hCRbrZt6fT9ecOEZklr60eOw+Q94TKFrMBYe6492OeQEgPPvNtTwiNmsdVMm9fnUPx/rMFQmiuUAwyukYDkd1GnsIot62zQ3+DYFJBgSyHxAujrEpYBnpUBstUv0UI1QTSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742581; c=relaxed/simple;
	bh=IOGXyKfRAtQgkCQsFi6glUXjNoElbj9x16QGZvKR9ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fSNZX4IxgK5yutYs86ZBRpnIwyoSbZRWqF+PSoua3UU6JHyXSo4uIH+q0yxXaaIv/GCCw3LWwJkl7dAgHncHh6Hvrz0eg61WDA42DDha2OLCjOGycKUoY+rxxBauBIbD/ck/NS+LuJyIcrlTlhHkIULQSfw3DNNFGhLJ1+VCAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Hhs6cudN; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7904a401d5cso17360197b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 15:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1767742579; x=1768347379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P903sGCFXcIuyiG+MFuiGvGYJlxu7DOENj1XsX+4lW4=;
        b=Hhs6cudNrVhmRvEXg6CAeebE0gmLs6qn4+Nj+c/eQkBWD7ANffZ1KpUmF8xdQXCJSn
         qkmeiM3NC6hYxHJlQWNCtzuO1njzqWm5Wm1OT8z0h124Acd5C+A9n+Z/H23ii1LTh7kf
         Z1Gi1QyDSLoC1OUKUZ683ALUqSNdmPBcAl0lyqBT0LlSUDcb0W/sRDrBvkdAaiZvgtn+
         Fn3RwWcxR8bGO7tBZvjbYWMaF6w8HhGm4hmkKEqkoH5kGpe6WKn1PNTtH2jC9n5MlKnR
         zNRiPWvFL3xb1xKZANsQe21tnyODPUhf4vxF+dBfPdcgJvzn2u4dPP93RMIDV/edZ5RU
         67+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767742579; x=1768347379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P903sGCFXcIuyiG+MFuiGvGYJlxu7DOENj1XsX+4lW4=;
        b=k0WMada72uJmjZeK96j1rzMzQUDcQPcKd8iGXw7Se+Ja8QH66Pks9voiN9/oEPSD6b
         JgCm7Q8AWOjcgxXlEvZZ2YSR0YHeNL1HsarRreBxxLC3izl/GDiivzUz6fG5fwJv/9oi
         oiNx/uFYMmf/5oqdIoRq3GuQahU/cirCBI/yK8vxSchxSkyw/j23Cl+tMxfqm9VLPIqU
         Gans3iAc8AYYv0GzsROLcIVCRQW4UIC9970fwi8QZSnDQbE7B6zLzlD7b8rnuRDKzWK7
         440i6qTqJpsg46N271WUsQvUuQehHM7IW8bxhWMhoHD8MeaM4NR6kCH5KCdt0YiawhMu
         O9nw==
X-Forwarded-Encrypted: i=1; AJvYcCWDTxNCcNZVUVJEDD5DI6XSG/j5Bw4HXAVl3+9aNnDt0l6CM0zL6CMKFeg/zUrKROopldch/SSjjvjaQzpe@vger.kernel.org
X-Gm-Message-State: AOJu0YzRlPxQgQtwMsLbKgkAgg0xY+SNJkVfIm26zNhg1eEgMGKCFSMV
	3oJnfxvcjhuvJqT9hIvUnnKeI3DPNnBJ3jVOoMADsfRFrIGUaBDdH7+7iPWvj4+qoWY=
X-Gm-Gg: AY/fxX6nqWyHm3s0xvCrjCiu1g4ToI4NrNOUOQc1YXIpEJ6XmgVmzVFOr49CP+uQqbR
	QNoykO/FqQ0Nwm5nONc1bIrDg4r4+3osfAM2LfqV7qY+oRnbklz0dgZktsrn+0dsUxDvYpG9DGg
	BgRQxSCrfLYvvpX/KlhTt76NDFns5zwmqh0guwz3MODLfBb+6/0+Ww4ZRYU6/pk/E+jU/m2VvDG
	pOu8AkbJQhP3mgAciLxaj0He99n4BpuiUKEOW+NGUuY/PF91/DIcELR/BYjd3BmQUtB0YQFWTky
	NQrtY3qCL7d5aBhHVlfJKS1rWOo/5TODpzzpm5PPmDcun9GZB3FlVbvegI2PellDQ4C9sTB6Mag
	9YOg5GNwLPGHlEWc1G0btaOBF/nevnQAG6XL8PwFJxX/vx+0kRaACOIoOk+R8hRcJMk9ugxOvFR
	bPAhnpLWfGoXm3ywddpeyzWVp8JPN4xXB2ng0PB6qkV7TzeFx5EQfeiqz8hgOYfbAtOqCWyM+HX
	dtczh2Hb61HxwcH+dCgXDw=
X-Google-Smtp-Source: AGHT+IGGrnRIngS8B91uiKhP8B+rtLRAgmEqeRLsRN/E00Rq6uOZNjkNxxJuDcm5aZr0O87LJ8pg/A==
X-Received: by 2002:a05:690c:6104:b0:78f:8666:4bb8 with SMTP id 00721157ae682-790b56d503amr9297877b3.55.1767742578835;
        Tue, 06 Jan 2026 15:36:18 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:e046:4528:3155:2351])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa42544csm12965327b3.0.2026.01.06.15.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 15:36:18 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	fstests@vger.kernel.org,
	zlang@kernel.org
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] xfstests: hfs/hfsplus don't support metadata journaling
Date: Tue,  6 Jan 2026 15:35:56 -0800
Message-Id: <20260106233555.2345163-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HFS file system doesn't support metadata journaling.
This patch marks HFS file system as not supporting
metadata journaling in _has_metadata_journaling()
of common/rc.

Technically speaking, HFS+ is journaling file system.
However, current Linux kernel implementation doesn't
support even journal replay. This patch marks HFS+ file
system as not supporting metadata journaling in
_has_metadata_journaling() of common/rc. If journaling
support functionality in HFS+ will be implemented,
then HFS+ could be deleted from _has_metadata_journaling()
in the future.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index c3cdc220..82491935 100644
--- a/common/rc
+++ b/common/rc
@@ -4267,7 +4267,7 @@ _has_metadata_journaling()
 	fi
 
 	case "$FSTYP" in
-	ext2|vfat|msdos|udf|exfat|tmpfs)
+	ext2|vfat|msdos|udf|exfat|tmpfs|hfs|hfsplus)
 		echo "$FSTYP does not support metadata journaling"
 		return 1
 		;;
-- 
2.43.0


