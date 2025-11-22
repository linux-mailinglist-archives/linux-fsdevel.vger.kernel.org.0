Return-Path: <linux-fsdevel+bounces-69474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A13C7C941
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 08:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02F234E3055
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 07:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687552836BE;
	Sat, 22 Nov 2025 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imPLo215"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0B17BA1
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763795999; cv=none; b=UCBFG+MZXlW6/p5UfMCPCPPlS4pVgwIVQbKr9zUNJ6gwdplAVmvv9MvrDpManDpk9sf/wgeAQPx9STTOmaCWT/XyRGp6d6Q12ltrsD1IdbPifJ8MYeUd3h6XM9OZ0noicrDBubhZ2PvpO86LnJruQQC/VD6MqBBQIQ1PTWcToYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763795999; c=relaxed/simple;
	bh=FFdNK+3ZLxXxPnEZRkbPwb5NdvomInu1/DRGUUi4Nqk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d0bjjysqqibfJ31CMUqurDdt57fgtoHyO1jQ+LXmQ/pukpU7vq+KPsCNR8CtBnbH1q5X8KwkZS+/bUwFNYxqg4EemIVJDQIYsVnk9Z712tGcbAaf4Vxo1ZpuufNlFq+PCVhjLbL3qezWYY49wYSLCxuqVRNwhTv1Lu5z00OGiis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imPLo215; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-43335646758so25750225ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 23:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763795997; x=1764400797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PivCgLxrGX/2vRgbBHY2gdLcCSo4vHktstVYVlsvVDw=;
        b=imPLo215cpACdTninTtJSNRcjk0J91VkFWvk04kc2cxGdTmYI35W7bnMbcuaYZ4gkX
         poewnzhrqCfQCQUe7QLvSqBYyFcaTa7kNNRiuV7/EKO32zERg6lisrykWgZIAu/bYB97
         HuBLv22BEAmRF1y/NHAqZv1Ir40feUfTRsbNLEVrqvj7HkS/F0OEJMGzISLraWgWMkvL
         FJDkqGOxGYY6V7ust8i+ushs13tVsB04+Z+6Ltf9BCFTDcF89XMlsJztiu6389UuJSE5
         fyA+czOhGzZfADOLZI2tG7GNBTQeqkJ6J/sVrkBYrsEnYyOrYMPot+FoNgzL8kvGk+Ee
         gtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763795997; x=1764400797;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PivCgLxrGX/2vRgbBHY2gdLcCSo4vHktstVYVlsvVDw=;
        b=nEiex8zN8h9YIj3TE8ntbBuFQ7/C/bu60toWAOxUX2ZK5YqUuZY191+62sJxhU1XxQ
         w/GOHlJn/EGosNhWnI3jGSjvBh1WaaNiW5ukkr3tpCFAsAYeHbJw3N8DNZPV2yJnKWFL
         vfG0805LzT8CrJ3kNpsvnyCJpuZv7oguQFYMD92mLXe//LXDspeI9TtZS9Offu4JSOJ+
         hjS5pAvW91NPOkprJG6ysLDuaDZaCQEEk9hjSdMZNssRdmM6sxpHJCLwhZoZM7U0Dk4U
         1VEjO6c5YPD696G8NlJVst/i9R3bd5dUCzN5iI9c/1B7KASSTJ32dBTExxvFHPDe6X64
         xGhw==
X-Forwarded-Encrypted: i=1; AJvYcCUJqaV+AzljyRojLgaqS9jsGjJKujyjt0adI81xNkFPxfhfa/lc1Y85kEPYvotvjIJq0fdi2EIkGg+F3/rb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1e/E9R32NWGeG3iVN3AqudmFht+VcjMd94JKyA9jVw8yU7tII
	a5AJEU+itvXdBjKzbVOZiMXJcy1mchFCHHO0WXjL1t3VMvCs9BpKWwo16O+C8SXxsPKtqb8iQdR
	SSAZPfQ==
X-Google-Smtp-Source: AGHT+IGGLZtgC5FLgdkVJofZlQ6j3GuUfq8ybk+qGRvtumbpUvYwXNHZCjJQoxEkq1/TuOdrWfcXEloEIno=
X-Received: from ilbdd1.prod.google.com ([2002:a05:6e02:3d81:b0:433:4f9d:6ee3])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a92:b006:0:b0:434:96ea:ff48
 with SMTP id e9e14a558f8ab-435b8ec96ddmr34521605ab.33.1763795997690; Fri, 21
 Nov 2025 23:19:57 -0800 (PST)
Date: Sat, 22 Nov 2025 07:19:53 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251122071953.3053755-1-avagin@google.com>
Subject: [PATCH] fs/namespace: fix reference leak in grab_requested_mnt_ns
From: Andrei Vagin <avagin@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

lookup_mnt_ns() already takes a reference on mnt_ns.
grab_requested_mnt_ns() doesn't need to take an extra reference.

Fixes: 78f0e33cd6c93 ("fs/namespace: correctly handle errors returned by grab_requested_mnt_ns")
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/namespace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2bad25709b2c..4272349650b1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5746,6 +5746,8 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
 
 	if (kreq->mnt_ns_id) {
 		mnt_ns = lookup_mnt_ns(kreq->mnt_ns_id);
+		if (!mnt_ns)
+			return ERR_PTR(-ENOENT);
 	} else if (kreq->mnt_ns_fd) {
 		struct ns_common *ns;
 
@@ -5761,13 +5763,12 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
 			return ERR_PTR(-EINVAL);
 
 		mnt_ns = to_mnt_ns(ns);
+		refcount_inc(&mnt_ns->passive);
 	} else {
 		mnt_ns = current->nsproxy->mnt_ns;
+		refcount_inc(&mnt_ns->passive);
 	}
-	if (!mnt_ns)
-		return ERR_PTR(-ENOENT);
 
-	refcount_inc(&mnt_ns->passive);
 	return mnt_ns;
 }
 
-- 
2.52.0.487.g5c8c507ade-goog


