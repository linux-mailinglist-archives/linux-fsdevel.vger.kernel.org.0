Return-Path: <linux-fsdevel+bounces-56560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C0CB1955D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 22:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F471893406
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA26205E2F;
	Sun,  3 Aug 2025 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/Z7EFiX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CBE12BF24;
	Sun,  3 Aug 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754254117; cv=none; b=gwyf9RZvfduXE6XVtoTc4FqMCPDAJYXlGkCc/t3Uh6cEnnJvBcgNnFet8AOD0YS854Jgw/WNt0S0FtFkeQs4PC2zqfORTVYGkDkZZgvr6hsY1kbMppFQF8uTHRGcry/20tulZLRTrO+UrccEOFcyHU7uibxycb8mnDk2qMIXByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754254117; c=relaxed/simple;
	bh=zzC0veX4U38w95i1qqvR/sj3J+MM6e8Lc6c6kYzUZV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MBqAgzPOZ5QK6f1WOrahdIaypH42bO0zuoENs0OPJoKJ8kugA1/hhaWHZSUWTvPMcJpp32VByPh36/f7ERV2jCEj/nYrbMWpsJzWfi6Rz+m6NZJHq3J7Vsm6BYRjwG0431CcsXGhkFaq9py2r/HhmAQgPviJHh0nn/XUgDwv/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/Z7EFiX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso119580966b.1;
        Sun, 03 Aug 2025 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754254114; x=1754858914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lwy9S+seQCh1gpHswr4BPXe5Cl0mTG2Hkawb//nlLoc=;
        b=c/Z7EFiXTcw+kEczsToH6kKe0+64ggW4YwH6ZzlP19ZQxZ7UqV5oG+dr3HQQ91mFtd
         Sgvz5WdmgnXezXHYY74NXWklJ6CWCTVFQngb+C3Lgs6fhedqooJsqNZuYdaBLrC/iRmZ
         ZnlLOd30NkDrBbCHb21X1Ob4TnVuCJJDkXUui5tAPaIIRKmOh08K2segC7wKrn3O67/b
         qMpDAw2laRtz6fUrHXBOcWbAzjL0NfNkEJzsvKpXwhPhWAzSgfU8qz6ZaMV7OINBo7+R
         YyOw5SkLAYXp5O2YtvBhuz0myWzuBG/BUPBgEWHldrwtMwU6h+RNZmsN5qQ6USEjSaR8
         YVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754254114; x=1754858914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lwy9S+seQCh1gpHswr4BPXe5Cl0mTG2Hkawb//nlLoc=;
        b=LTf3wly5vt2ZrT/skQsMXWXlvauIyXlhgMq3sVI5GtmHsiQMa11GSbUVICcJ7m7GV7
         fslAUzrOqNGFpiGuT0wiv0lGmO3YYJaB6i4XIZnvHV3DHlql9xv786drOD9e3Fn4H0Ah
         7apbLOp9chC2Rl7R9qeEWofCwwTGhhaOWHc3Ww+fIabsZrX22XZsi+MAM8FtKQOoOIhH
         3qV94ic4BeQKFy4/jQznRl8PARqUy9iU1JU7lgP5vfUIcyU3FU8vOLmlbbBb+iARmmfi
         JtDxibRqfiuDGiLEH44IK5CJKYxNLt3GYE97GoavV2dsOc2VxtGcgu80QFJsckN02AT8
         p2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWHu/CJkJl8PgSCoedka4iFdHk1+366xbj4hhMFB1Nfo/RNmAYW5eOreyzGkQK81c6j4f+UVwgWjvZy9Llg@vger.kernel.org, AJvYcCWm3ELwEvfvZsw1vVfPcFjo3NwNvLBzdly9+aE07gH0aX0jn45XGTLOOVX+sPhdNGMt4rVd6E2mtLY4UW5Kc8Pp@vger.kernel.org, AJvYcCXeXGzwEK/P4Jwr/FEVq9epOOQL9X1+NPvDo9FQZNMRopWiAbfPIO4xn7fzSkZkeHs3kv9lU+dbmiJox0AR@vger.kernel.org
X-Gm-Message-State: AOJu0YyCMHM/wluDBvEk2tCKl1okAGVhMj+chCSomCesXizZl1hO1E2D
	JqB4s768iyaZ0Gggzq/cC/PjhSaXWfmD8SqZa4uazNjrGDdkl3QeblNM
X-Gm-Gg: ASbGncupAmpnhZ5EZMZQ1TBsOEfeEdaVX2OKhar/vcgZT7UeGrvVo214RQCSZ0ftlPs
	Ld+/7p14PfsdNv9Eyut7bhmDXs2vyZ4H+U5rappL5AJBHQ4YuHW/8UHIyk/bDzbFr/TbeaLxsTP
	Lfs77/W3O14izgKFloUXRtx6+k5nt3eAaIF+7cNVCeZkL47+Ti62zIV+i4MKQ7aCt/rUfhb4b8x
	gtE9HmajUGXZBneHNhbKYo4nUTNRs1jGXNWOVsDprn/QBsKJYvkFqQCkjMgxbrqhDY3OizKOHoU
	hmIY7qyXwG+94POpoXRHSJ9DwDueZN07Io42E8UIgyHPdGEAeI00Vcn9fUF29sNvZQhT8Vorxx9
	LV/Mm1qS+Kh5wFeY=
X-Google-Smtp-Source: AGHT+IED2U86NMVTRqP/XDEpeRpB+DYiVCnbANSQwHQ90TIg/gegMf7X5EOI193KklAwzpnqqt/v+Q==
X-Received: by 2002:a17:906:f192:b0:af9:44fe:dea1 with SMTP id a640c23a62f3a-af944fee3b8mr478126866b.23.1754254113813;
        Sun, 03 Aug 2025 13:48:33 -0700 (PDT)
Received: from hsukr3.. ([141.70.88.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0761f2sm629695266b.11.2025.08.03.13.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 13:48:33 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	linux-kernel@vger.kernel.org (open list:PROC FILESYSTEM),
	linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: skhar@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH] selftests/proc: Fix string literal warning in proc-maps-race.c
Date: Sun,  3 Aug 2025 22:47:26 +0200
Message-ID: <20250803204746.1899942-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This change resolves non literal string format warning invoked
for proc-maps-race.c while compiling.

proc-maps-race.c:205:17: warning: format not a string literal and no format arguments [-Wformat-security]
  205 |                 printf(text);
      |                 ^~~~~~
proc-maps-race.c:209:17: warning: format not a string literal and no format arguments [-Wformat-security]
  209 |                 printf(text);
      |                 ^~~~~~
proc-maps-race.c: In function ‘print_last_lines’:
proc-maps-race.c:224:9: warning: format not a string literal and no format arguments [-Wformat-security]
  224 |         printf(start);
      |         ^~~~~~

Added string format specifier %s for the printf calls
in both print_first_lines() and print_last_lines() thus
resolving the warnings invoked.

The test executes fine after this change thus causing no
affect to the functional behavior of the test.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 tools/testing/selftests/proc/proc-maps-race.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-maps-race.c b/tools/testing/selftests/proc/proc-maps-race.c
index 66773685a047..94bba4553130 100644
--- a/tools/testing/selftests/proc/proc-maps-race.c
+++ b/tools/testing/selftests/proc/proc-maps-race.c
@@ -202,11 +202,11 @@ static void print_first_lines(char *text, int nr)
 		int offs = end - text;
 
 		text[offs] = '\0';
-		printf(text);
+		printf("%s", text);
 		text[offs] = '\n';
 		printf("\n");
 	} else {
-		printf(text);
+		printf("%s", text);
 	}
 }
 
@@ -221,7 +221,7 @@ static void print_last_lines(char *text, int nr)
 		nr--;
 		start--;
 	}
-	printf(start);
+	printf("%s", start);
 }
 
 static void print_boundaries(const char *title, FIXTURE_DATA(proc_maps_race) *self)
-- 
2.43.0


