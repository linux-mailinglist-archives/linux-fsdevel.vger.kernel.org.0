Return-Path: <linux-fsdevel+bounces-21587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E8F9061E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 04:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5F3B212F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A412D748;
	Thu, 13 Jun 2024 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIVwInO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450C84A3C;
	Thu, 13 Jun 2024 02:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245896; cv=none; b=qaom8+J1mU9J55cHlegCIAh2kHzRuau+ShYTC0K5oIXNglVyq8EURFEsGdfDTqZE0FfP3p3dfCP3CkQVYb7DtTYp1O11Dp1D/dKWT9RvfXerkEa9XYTbnOK2BkdI0aaS12eI5G297uaixa/eNyCTPDRR1D8O8y3pQEcXY/l+vzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245896; c=relaxed/simple;
	bh=a+jRmBNObp02hqUJFQx9ZHvGN1Vdde7wossr4Oq8bKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IDbP1YTyk4DDCYPXmlTSSmtUQdwpPvnVbVxySjNJXHnNqyEtN60n/yHHeujaSoRmh/KkRGZ4UzhK5W9LB9KT72rtEljks+lo5jIUxxN3dcVg6hJnc/YSnaCCandpkWRjDY1IYYH6WSNPhfTteA2apR/rxx7kJksFFlkSAa7cTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIVwInO3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6fd08e0f2so4343145ad.3;
        Wed, 12 Jun 2024 19:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245895; x=1718850695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7QH8g7nY2INvVrL4NU75ftNhN6FL7HL04IiCAjwJmE=;
        b=RIVwInO3xhEVzXqjC/TRPFAPuEFWSPZSFsFvpRDvVWcbiYTUcMcf3O4UhuP/QvhOKo
         mB8gwhgpmgMB1ux0mNrslgdeknSjtnp4RLwrg6+DzHff7WtbiUif+vKIeggEIYET8ktT
         G2TbQm209GmZNJL7zwIOUOckvs0pZP9C59ptzYLxAmozct86AApYidLN0KiRFqCx5HeU
         8wjnCb6ewGtp0EgwgUuxozNHFwNhxvCXxXzo9PpyQyiTJkXd2pEVVNX8oaa7/DjVaCBr
         +t1BTTWV46Th7i5DNrTbTBn04Udb9CNydBKvbtR1LmgfSGAJjyc6R6jZfmFtZue8laHn
         PW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245895; x=1718850695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7QH8g7nY2INvVrL4NU75ftNhN6FL7HL04IiCAjwJmE=;
        b=t0s0Wnf5MRSsZaKhH5wu4K7E/jWfVtc2+toFi16IvSF8AOUtlyW/gz4gvIU2FrajuA
         ASKmFerVA/qPhT2kR3zIpoaBcKfxFbX9s6W6yNh2oov9KStYuS0WcOczU+6FTAGUXELF
         nE6AqmiI+WSCnLQwcNfsg2xxZuLVBF7COLgTkVE10oL6mmN6b8jquQ1H/EQOQN5WV2ew
         ziznG/GvNDm8a24Q7HU41cDstG0w7W7OwkP0PG5gamehAKMvFRgVEntoi4e30F10RLjl
         2dBQInzoru61/1O2XENI/WqfqTph4f0RpfAHoHpZOFLQzznoseAinSW5KmCBDFLAZetG
         wEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV73j41Ch3sbTmizNFJbiZITKvjca56Kmv3SjqaVVLIXneBAzVWYxOjGsRuacZOUU+kn+mcwUuapqY72LVNzDjPURXzFHI0PfAMPRzj7pP45AUX0ykJ1EfR54p0LVH4PWCejAk5wXT2spMacBh1DN55cQZLDEmoKAOGE04hizpZQvjdO8GF6mUgVX0iHDOI53SSowO9YcZpJCLLX2lKCtLy29iQ1jz37RHwef6Fl2CJXkMB6XvXuZ3GKYmqMEe4uA64IVQzgFTlssXXL3e5pNwKwKpJACEZv6mkYtzTIwLf0g0d7hkvzhiHo4mDRMSrALPtTWsb/w==
X-Gm-Message-State: AOJu0Yx3CMjRO3PzbxY/1sgJK/3tfIEbRX24VXvEWrIrxlAVQzXIiBgd
	s3ePcmur41FaVRR91R7KDPEXpNyNG2HxcjAfT+CUjDE+5Sb92sCb
X-Google-Smtp-Source: AGHT+IFO0RiQEuS+ZZx5NhUKFkro4pSWALq4fQpBCAuUBHe6UDJpEGOEOlucSptFPDnQxh/E7HkfRA==
X-Received: by 2002:a17:903:2283:b0:1f7:2051:18ba with SMTP id d9443c01a7336-1f83b565dbbmr48444305ad.14.1718245894762;
        Wed, 12 Jun 2024 19:31:34 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d159sm1755695ad.289.2024.06.12.19.31.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:31:34 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH v2 04/10] bpftool: Ensure task comm is always NUL-terminated
Date: Thu, 13 Jun 2024 10:30:38 +0800
Message-Id: <20240613023044.45873-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240613023044.45873-1-laoar.shao@gmail.com>
References: <20240613023044.45873-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's explicitly ensure the destination string is NUL-terminated. This way,
it won't be affected by changes to the source string.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/pids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 9b898571b49e..23f488cf1740 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -54,6 +54,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 		ref = &refs->refs[refs->ref_cnt];
 		ref->pid = e->pid;
 		memcpy(ref->comm, e->comm, sizeof(ref->comm));
+		ref->comm[sizeof(ref->comm) - 1] = '\0';
 		refs->ref_cnt++;
 
 		return;
@@ -77,6 +78,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	ref = &refs->refs[0];
 	ref->pid = e->pid;
 	memcpy(ref->comm, e->comm, sizeof(ref->comm));
+	ref->comm[sizeof(ref->comm) - 1] = '\0';
 	refs->ref_cnt = 1;
 	refs->has_bpf_cookie = e->has_bpf_cookie;
 	refs->bpf_cookie = e->bpf_cookie;
-- 
2.39.1


