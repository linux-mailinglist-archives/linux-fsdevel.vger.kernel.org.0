Return-Path: <linux-fsdevel+bounces-74309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87981D3953B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 14:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66543016DF3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 13:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFA0330B3C;
	Sun, 18 Jan 2026 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU429C2W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F35347C6
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768742118; cv=none; b=m+RWQ4nJAGE0JNjrzD4ISR3c0jtYol8byK3eOXv0H47iROA/xAUWjyEcmdEAYfkPRDVwH3v3SRZLPpAv6+bMFmPfvZlosxgmbOH+6HRLAy6Pd75RyIY3eL5BvJo3TKd21HWDY49Yfu67I3VCWDl8FkRO8u94FzqheYdXeM0lfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768742118; c=relaxed/simple;
	bh=4TEa7pHP2ikSWgVdHInrsbOyT2CYj/3mm8xIYJwHTR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOoOQ+4tV+ec4PdWmXjyICOW3o+Rf2+emxcmHqCP/9dr6uO51S8KkknJmL319nmi6cmmkpb0GL7RKa1PpBLBj+IeUGTvCXq3bP7gxLs5TUq+rX5VZZertvfc4WreyfsrHu9UF58lkAOM2+qb0ccQIqso/VElx7d5bMM9mHCJ3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WU429C2W; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so21661555e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768742116; x=1769346916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa8nTgcsWLvaf6pbTiRseNi/rif1T3zmlnbTbk9J3SM=;
        b=WU429C2WgWQU1zAb5ao4guj2XpVwfdabeawgKEIjs7FPG69nD0IEXP3C9O1unbDq6+
         qvvXxGRXRJcO2uow4nlFxESIUgDIwfhHdCjdtcKzbwLA3aQXPQWxNjkaVH+OjLzPzvr9
         RMssMy8PWMUY6slKsGQtW5caU1C/KmwOuT/4BE+6W67IODOo0WinDxwYIwcvKGbsFEPt
         QnNMJNDPdUHty+wsDez5bZZTrZX7rgZss+KYV3txdh370jzeyYBrM2gvqwyIfoqxx2gG
         wmuStUedfzo307lGqYzNJ62OxxSwIsyPO1fTfV4I72hH7eJF1iThAr1dD/nNyWOoIDFy
         ytMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768742116; x=1769346916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa8nTgcsWLvaf6pbTiRseNi/rif1T3zmlnbTbk9J3SM=;
        b=TCUuZalRbIiN5WdjyBknT6R7KOcXik/TM1swdfe/yufLnb8QAXBFPUJbj6oFXo7L7G
         RPj0XfZz//hHwUtTH30swyiTE7t4HWgmJKoMno3BeIm8zzlQENlp1WVjh6fTuivt56+y
         vIz5y8rG3XOErsU6dvaZirYJaTvGt+XY0zTRHHnRW+NqrVbjROkEVoqQjckmvqWqJxmJ
         mUpS+Dn/2gjGS2vF2jPFAY6YnNiAwViGzSBozZ+4H0qgi6v+wD1azVITiByXzgWMDCN4
         85lka9fDngnKrBzCBNAKc27aIpFykJbCuE1A4+i7vbB/MGl7pOaxXxb/fn/4m11hri1J
         NwOw==
X-Forwarded-Encrypted: i=1; AJvYcCU2p1nLgffCF14a7mAREsQp6b0vVxs8zJAlVrluUeJnPXMqhDn5Plp9l9OT8E4s7V+lCDQLA+3ZU+ql2QbW@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0RylaY8NobFbjqZT2lglxLNN5fSTWA1TutaZMWlDLz39Aoxg
	XFTebr27Ix5q0i0NZvP/iweRMvhRzQzj5k+Qw19cckAeCAVCAZ8vIK0Y
X-Gm-Gg: AY/fxX5T2Ru4Ql/lB2gaMEFuIi5TjQoqpwM4jH/kwvuNWZ6BHCumSamxnt0N6o4PVNg
	Ip6DCybqRREET+SBgrzVIIwtqSuFEgTKGZqH9wX7RidWY61MUHocgYJdqeU09pinhIzcgbW4zrb
	SMtTBsVEVutm64VOS5TbINCRQc1gNDgbpHN3qsAuarzf9qMU05CKPraAnQrREKBU6UtWkaG3S6W
	rRE/KyPH5nSAg3tIqRaxrBFe7jRWTWqyxg6tKkvRZdGugZP6SZ/WfN4LN0HQUXfLKY6cvzmuCYt
	G8lRc0wI0b87dCrh3PaVZ7cMcwi+KiSuu47vMctSXrHQD+xfQFec6b18C4SxFcLbeZyvKhGbNfp
	/71RdAqs6FpXUbvJ3YeMSFvgnRXFDSCge7t0T0O/WFk7bu7aM4M7oDeq4HhUVeeBUnvsghXC1G2
	GDwSipyek8RVAO6MHlveptFWDhjXc=
X-Received: by 2002:a05:600c:c16a:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-4801e33c332mr105274575e9.25.1768742115712;
        Sun, 18 Jan 2026 05:15:15 -0800 (PST)
Received: from practice.local ([147.235.192.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428bb0b5sm196377835e9.8.2026.01.18.05.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 05:15:15 -0800 (PST)
From: Jay Winston <jaybenjaminwinston@gmail.com>
To: corbet@lwn.net,
	brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jay Winston <jaybenjaminwinston@gmail.com>
Subject: [PATCH] docs: filesystems: escape errant underscore in porting.rst
Date: Sun, 18 Jan 2026 15:16:12 +0200
Message-ID: <20260118131612.21948-1-jaybenjaminwinston@gmail.com>
X-Mailer: git-send-email 2.46.4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

filename_...() seems to be literal text whereas Sphinx thinks filename_ is
a link. Wrap all with double backticks to quiet Sphinx warning and wrap
do_{...}() as well for consistency.

Signed-off-by: Jay Winston <jaybenjaminwinston@gmail.com>
---
 Documentation/filesystems/porting.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 8bf09b2ea912..86d722ddd40e 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1345,6 +1345,6 @@ implementation should set it to generic_setlease().
 
 **mandatory**
 
-do_{mkdir,mknod,link,symlink,renameat2,rmdir,unlink}() are gone; filename_...()
-counterparts replace those.  The difference is that the former used to consume
-filename references; the latter do not.
+``do_{mkdir,mknod,link,symlink,renameat2,rmdir,unlink}()`` are gone;
+``filename_...()`` counterparts replace those.  The difference is that the
+former used to consume filename references; the latter do not.
-- 
2.46.4


