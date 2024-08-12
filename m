Return-Path: <linux-fsdevel+bounces-25622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA6294E506
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36190281EB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CE714D45E;
	Mon, 12 Aug 2024 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvCCspZ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AACA81727;
	Mon, 12 Aug 2024 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429887; cv=none; b=toeub9qyFMXffJez3BNn/IbnUJkDg43CEZoRB/yBkILlT8mkB1ddO4g2WZFCzCdZPmR9A3+uTY9hGpfAXIt2zEL09GMMg+R8BfKo4ca33BlbDrKIgOEy656Mn+bFKno+uz80Lrx2cWbOipbUoQY01eAsblMRe/lwdpntpR+i/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429887; c=relaxed/simple;
	bh=jQ7E8uYbAv5L24HExgIrPa8kYHHiE/gtmM47BqiJcJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYbJKMZv7a7dVUKNfJ9eX6PXtWnxy5e2KAwvZBfsFTRnc8zy2pqkiCb4WZvFMaqm6RncXUEVQzwm5FqsH4bI1VSX5wLG+zjtIgqbEhCui1mNLntJJoy5PdjIKtpBfv/GUVj+mUP143PUQ8NNyJeWlvSo1Otebn8uBp+sM9dGUbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvCCspZ1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fee6435a34so26516275ad.0;
        Sun, 11 Aug 2024 19:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723429885; x=1724034685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQq52x1okLoFlEdSdcWpS9opM5nCjcuUg5Jqdy6Utiw=;
        b=VvCCspZ1Hj47RgfERGu5k6icxdVFsBtlRou+dsDXmcv3elA5DFKZRpMP98jIvHCEPF
         6gobr+l8XcnaaqTpjp4TTrlNPY8d46NSoLv1926bTaEb1VdUIUaMtcHH0abT3G6pj3Qk
         noIPgEp6uyWZqvs0KIEWysl0Mr2pGj7wa9F3eiJScBCSJpfYUNay9DLXvxMU5MwatPa0
         ynwnJbgVlHuey2KE+8D+qQLRlKLqa+L5W4HEAzUUkm/TP/iHQkfP0NX3E/Gdxf+Psl56
         P//ixLir17p9rtx+/e93MNBhP1lMuI81pzWlbQzeyuGiC07reAK2UPOsX4fAOWx7n0U/
         A4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723429885; x=1724034685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQq52x1okLoFlEdSdcWpS9opM5nCjcuUg5Jqdy6Utiw=;
        b=S2Vuq+DILJ9g6BEc7D7cY1A3euvkCph0ejZGVp0oz9XaxjVhAEx1AgZeDO6t3h3WdV
         X5fkb1FlTbiOyKCr+BFrRFHlQIsbVe8rDnzcPVn3/ga379CNvzhSB4ALZIRUTbzN/BV8
         SYkG0C1TV1Q3BjaKEC4v94aQ4Obxr1VGEzK6Hdu14+ZxJ0VLMh0/TNN8pln99L/baYsF
         yam3qRvYjNGrrLd2ajF265xpP3KqYY941Eo2OA3qgOZ5493cN60V8hnIytiQEoQr9mUT
         /dFvrP2ufwPL5k5u3RjSOI3deZEld4E1yB0B4cauXd+NmYo1DC8XRKBdCwlB5YkeobST
         SK2w==
X-Forwarded-Encrypted: i=1; AJvYcCWweAbN7feCwTZBisjTy7Zc+5YfTlC3F6qnF8mY3RFw5wfx0zCsg2RbTGvz0R6skh4GgFfxsyQQsbuOKRVSc2tq3mCQeD/HYZEl5iLUFGOGU4dhBm9ESpSvymH79fyIiBlYDhbdd2IvPtU4DMo3zttsxH+2klsWBM31LOR8g7VPDax5ssPw0HGPwBsrNALqiTF61E4CqFfn/q1V+D9e/3tPU1fS8GSbFadldCgzzxrDPLIQ1NXvuFP1MulwIOS5vTGMn/56ZSmv+YumEDHuTv9VomS/MB+sC7xZI6MNgp+F04O3UBF0oizYnYxQ8a+ydvwdvA5hmQ==
X-Gm-Message-State: AOJu0YxMb7Xkg/aPfDWxnU+y6t2KzPE2NTCiW3d4ugi1pWcyo8KRAEWR
	NEPEBK5oqD4FCHocw9f43op8nZAv+ffepc9lc/l/GSwie1tY43O7
X-Google-Smtp-Source: AGHT+IHaetHTBTCym7N0t424xRy6qtmLiFL/7ctUucHwtwIF7cfl/lI/MF8VrMeOi3ytURGCyHANzQ==
X-Received: by 2002:a17:903:249:b0:1fd:7664:d891 with SMTP id d9443c01a7336-200ae5cfb6amr57289655ad.44.1723429884796;
        Sun, 11 Aug 2024 19:31:24 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fed69sm27884765ad.188.2024.08.11.19.31.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2024 19:31:24 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	penguin-kernel@i-love.sakura.ne.jp,
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
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v6 8/9] net: Replace strcpy() with strscpy()
Date: Mon, 12 Aug 2024 10:29:32 +0800
Message-Id: <20240812022933.69850-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240812022933.69850-1-laoar.shao@gmail.com>
References: <20240812022933.69850-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent errors from occurring when the src string is longer than the dst
string in strcpy(), we should use strscpy() instead. This approach
also facilitates future extensions to the task comm.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv6/ndisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 254b192c5705..bf969a4773c0 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1942,7 +1942,7 @@ static void ndisc_warn_deprecated_sysctl(const struct ctl_table *ctl,
 	static char warncomm[TASK_COMM_LEN];
 	static int warned;
 	if (strcmp(warncomm, current->comm) && warned < 5) {
-		strcpy(warncomm, current->comm);
+		strscpy(warncomm, current->comm, sizeof(warncomm));
 		pr_warn("process `%s' is using deprecated sysctl (%s) net.ipv6.neigh.%s.%s - use net.ipv6.neigh.%s.%s_ms instead\n",
 			warncomm, func,
 			dev_name, ctl->procname,
-- 
2.43.5


