Return-Path: <linux-fsdevel+bounces-3339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B93107F39A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 23:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7394D282A8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 22:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BC054BF1;
	Tue, 21 Nov 2023 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo1eK27d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D892C19B5;
	Tue, 21 Nov 2023 14:57:21 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so3660540fac.0;
        Tue, 21 Nov 2023 14:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700607437; x=1701212237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8ZZgvmAXPhmKzJU9UhObSbddp4HrtBDtV0ojPM1K/w=;
        b=Jo1eK27dcXMPNedOfNH9AG8n7aBtJ3uKMq994iRaYs+FvIRWrRRl1+XUGSwhzbw5oD
         4MEt06OOhIL8COpC9IJJKOfpi9alktwEmupP8b1/JloPQ1JoMW6XvKd+0E9MFuVzK0rS
         t2eVfnzzMEX+Fa7ErV+C7hxbQg/6fws2D2LqHyMGrb0hJHs4liK6eMNuD4Ipk4WHR9L0
         gIch9saDt3eV+PGOPSIn9bUZcnei8GAcx8jtjnFI1SsIfT4v7g5n3s6MmJmNXd3DWM3k
         G4Ll4YLpArveEXdvj30UmLrhSiEZd6UC9wS27XVqxzw37LTfTtNMzYPyexQpQHQnoEp8
         FLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607437; x=1701212237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D8ZZgvmAXPhmKzJU9UhObSbddp4HrtBDtV0ojPM1K/w=;
        b=RDqDJixmnSchGJkfIkuY3bg+qt7DdbnEq+crhQAd2nPYd++AZt1Z/SL/ZOO/NG8nJp
         UWhKOcN/lVxRHsHSA+KjZwS/OdBGAQadklkSsvdThGLCQw6bY95zigbY8SGDjb/OV734
         8Abq9U93/o5rIMi/GaZ2hsYbrEh3KaK6M+fL/mfVrpKLq0kryDhYTDYDr0M8LFMyTBzP
         RB9Hw/QpaHwnbE6hdNhMGxpUoTcoaKP8zdpw9OAo7qXyo+G9na59lhYe8NDdyoq4vRAm
         PLPak8LMJ62E3kUa15/Fxkw30AZZQxCCWHHg0JmDMIGklzXbyhjwOl9CuOjOyqN4g53d
         rE/w==
X-Gm-Message-State: AOJu0YwDreePlrM3hwg1MeXFYeKcnlDJSJQ/t3d8uDKqaokH6pjHBS+l
	8Ux+lq2E7QYAQpu+ChZL1GZ2cJfuRRI=
X-Google-Smtp-Source: AGHT+IHGy7cYb+GxVBQPuDn9AEvXhzEI4tjhctSPPKP0HsuLd5XM6dwayXZ/6IYPEvsvmfe1c4ocNQ==
X-Received: by 2002:a17:902:cec8:b0:1cf:6969:581 with SMTP id d8-20020a170902cec800b001cf69690581mr689443plg.49.1700607416739;
        Tue, 21 Nov 2023 14:56:56 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7377:923f:1ff3:266d])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709026bcc00b001cc47c1c29csm8413189plt.84.2023.11.21.14.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:56:56 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/14] tools headers UAPI: Update tools's copy of mount.h header
Date: Tue, 21 Nov 2023 14:56:39 -0800
Message-ID: <20231121225650.390246-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121225650.390246-1-namhyung@kernel.org>
References: <20231121225650.390246-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/mount.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
index 8eb0d7b758d2..bb242fdcfe6b 100644
--- a/tools/include/uapi/linux/mount.h
+++ b/tools/include/uapi/linux/mount.h
@@ -100,8 +100,9 @@ enum fsconfig_command {
 	FSCONFIG_SET_PATH	= 3,	/* Set parameter, supplying an object by path */
 	FSCONFIG_SET_PATH_EMPTY	= 4,	/* Set parameter, supplying an object by (empty) path */
 	FSCONFIG_SET_FD		= 5,	/* Set parameter, supplying an object by fd */
-	FSCONFIG_CMD_CREATE	= 6,	/* Invoke superblock creation */
+	FSCONFIG_CMD_CREATE	= 6,	/* Create new or reuse existing superblock */
 	FSCONFIG_CMD_RECONFIGURE = 7,	/* Invoke superblock reconfiguration */
+	FSCONFIG_CMD_CREATE_EXCL = 8,	/* Create new superblock, fail if reusing existing superblock */
 };
 
 /*
-- 
2.43.0.rc1.413.gea7ed67945-goog


