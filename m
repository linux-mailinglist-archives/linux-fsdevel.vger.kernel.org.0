Return-Path: <linux-fsdevel+bounces-8261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA78831BF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 16:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1DB7B22FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA911F95F;
	Thu, 18 Jan 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huube5Du"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316FB1E87A;
	Thu, 18 Jan 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590422; cv=none; b=C28SFRs3rNnAp3b8eetU+W+ZxX5W+kpYe/IFa4tEYLNZoyLCRhyQV9fxOWy3HnN5NQqXhohmrC0JEHe67cjnXUPoNNXeiDwxI0ZZZepuHV9884LT0jksFiiYl1g82gHDCKDw5plSFHMuKo4Gfrqh5S4SQKhzuMYZjn4Frh+UNNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590422; c=relaxed/simple;
	bh=/1CpZCOJH//FOtYoUXssXpmkISq3bC/FQ6oSEpU5tJA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=tWtYbQ3TG9CUPwC5lL/gAsCl2SAZJq9W2WXRw0zb3duwvSUN5tPlVTa86TTjcIejdYnP8vcXY4SxZ2RD/SDf323djLUfGao1cqkORz9xWpEI9gTOFifLZbRcDRbZ6sQGn9ThNXDyV/pI/PEw2lsQyKEyHt3R3qB53+YuyVjvees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huube5Du; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dbb26ec1deso277206b3a.0;
        Thu, 18 Jan 2024 07:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705590420; x=1706195220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgRCRgtT2LBOn4OGPEhJQpmUEWiVNpEx0m8L9kHq3Kg=;
        b=huube5DubkCrejJyhPcYKG7L5fa2dMtbaImGe9LtZhuHiejP8JwgxnoSmxR4fyRnG2
         wW/9FYj3JI4j/gD4v0jE3WMoZyL6XX34i9CEJFvem3jo0WVyPTCUDMuJnE992Cbh66KF
         ULMlua1PUrY+2ILu0F6eACnA3cMZS3Y6jOJF86F8Tzm30EtYVyDLjotjWCmzEbv3ZAzR
         rnjIdCdg5eiYyjJPIVPODKFpa8eCCUtSiAvrDGgFUhRlU0EaIzpxLd9AGUPNx35iJIop
         W4as8MGuAbrh7vS1Vv5PifhcMxO2rluOWyYbP02+DTFxln+bAj8sGB6MLLElpT851pRy
         KZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705590420; x=1706195220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgRCRgtT2LBOn4OGPEhJQpmUEWiVNpEx0m8L9kHq3Kg=;
        b=dtv6OtdzHH00UbDp/alrjpw2bd2qCDyuy2aNromAya+63SlM3sBsnM8dPLBZpe3SBb
         m2vZzJUgQ1EVFgsdR9kxyqrXEmuLMISvsxum0FRoEOfhpiet0SsnjXNvI9Viu6lUhGhN
         ocM9OPAwZMjpKiG8K3wtYPw1ogXlKjUO/+LkQgzGfQBf56AxYam09LM38or3AUtwHyRS
         rL1tNSvRQk27dbKSImdhLkqPbtEgO4PmO70SU39ooSg8T1rZsFgOGXelMF2QndCmJJky
         FYyX9WVVeaEuBen7ryyGmpI9Q+I1DibS8IHiY86fhp7psfW8EP7e+nj8qFQdfD9inRay
         T73A==
X-Gm-Message-State: AOJu0YxDe6KTjusf9sCkGL+uh8mGja/7QustfmOBeCGu+9+J9ggO8jOb
	7OMGpPILisK7QQ24Msr6Wm5kg6VKDgx2mvLRYROYMVAsoKqB5GtIE3SvOkT5
X-Google-Smtp-Source: AGHT+IEfZE0AN8dYVVy87hfIcMTIj3hFPqed1PcWPc5hh6Us7z9PBuDl2J1gfCUl94i+14NK3MXaoQ==
X-Received: by 2002:a05:6a00:240a:b0:6db:829c:12bf with SMTP id z10-20020a056a00240a00b006db829c12bfmr1328321pfh.28.1705590420346;
        Thu, 18 Jan 2024 07:07:00 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
        by smtp.gmail.com with ESMTPSA id p10-20020a63f44a000000b005c19c586cb7sm1668892pgk.33.2024.01.18.07.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:07:00 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Chris Zankel <chris@zankel.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] fs: binfmt_elf_efpic: don't use missing interpreter's properties
Date: Thu, 18 Jan 2024 07:06:37 -0800
Message-Id: <20240118150637.660461-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static FDPIC executable may get an executable stack even when it has
non-executable GNU_STACK segment. This happens when STACK segment has rw
permissions, but does not specify stack size. In that case FDPIC loader
uses permissions of the interpreter's stack, and for static executables
with no interpreter it results in choosing the arch-default permissions
for the stack.

Fix that by using the interpreter's properties only when the interpreter
is actually used.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 fs/binfmt_elf_fdpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index be4e7ac3efbc..f6d72fe3998c 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -322,7 +322,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	else
 		executable_stack = EXSTACK_DEFAULT;
 
-	if (stack_size == 0) {
+	if (stack_size == 0 && interp_params.flags & ELF_FDPIC_FLAG_PRESENT) {
 		stack_size = interp_params.stack_size;
 		if (interp_params.flags & ELF_FDPIC_FLAG_EXEC_STACK)
 			executable_stack = EXSTACK_ENABLE_X;
-- 
2.39.2


