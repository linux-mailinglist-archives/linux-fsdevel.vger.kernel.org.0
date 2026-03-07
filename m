Return-Path: <linux-fsdevel+bounces-79691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJLaEaIGrGkxjAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 12:06:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE0E22B59D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 12:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26D56301B783
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 11:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F323B33D50C;
	Sat,  7 Mar 2026 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLbPTrL6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578F30B521
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881560; cv=none; b=IQ/kqk7wHWUXbiAFSOGze8zbhBD/Fqo4suDPkWpQL3iMYmSJWhsGYM5Gi+Ilf5fcXgCI7h37Tuyr984wHE5H1Yz5TuNFinqGJ7LjG8XaawOww7dCDJWkQomvMBD9AeUEXpdtBQBB0tAry2yg5YMwcyEI1GAMIHUYGkeuhTlLhAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881560; c=relaxed/simple;
	bh=gGNWdeCfWPIhBlpSjtSqTI+DDId4UcxMX70RoZIcS/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQFwZnzurSO353C3HU++rHsDAqec3JlqTg2IWDu703RA7h/EVZ0MtHrPZhiJ2AFjV9HISbvUr+mfwMPTGburinJSS0Gu4YEf+RBgjwhBMs8ZhaDL6eFEBY+6K+5B47M9hno15OnBS938qywP6N6SkOj2diYh0Lb/hGakxU++XUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLbPTrL6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9358bc9c50so1119969966b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 03:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772881557; x=1773486357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSMJ9e9duhHkR2+w8TDNyk1wysmprrNCDHuBkwuAv64=;
        b=CLbPTrL6Idv1Rr7avFTKhzY7FNkyAbpr0U7dXzYRODpuSrVh+YhPC0JaE4mYXxC6ww
         63yoT9mc94Uik1dTTHykoYQ/7dpVNel88gBWC7W9+mtNkXC+9tgR9TQyCZda3EuI227A
         DH2DSRNcA3yfutfw65+PtV/03D0CBC0rHkPne5R44H7mfhE5LchOM5itZD7KoQ/XNWsJ
         fZQn5YIwGjW3yB1ovyTNujvCVwO/5He2gJYX8uC/hz7izdEkAzSr+1pc2xE7u/Hk+lsl
         LJwvXthbAVZl7T5IumYDuffYpSdLkhgteXQy8V8XdCNa6JfCI91W+RMLk4ggi/Gni7cg
         6r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772881557; x=1773486357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NSMJ9e9duhHkR2+w8TDNyk1wysmprrNCDHuBkwuAv64=;
        b=NjK6X2sJNATqQcqm7HAzKgfqL5Vs9EXD5N9Omk0YkgytCWOIFFMjLiUg2BzQ3UZAWD
         D2yC1WRz2ono3/bXLUYk2JnaZDPI94F2Z7yweTZMKdvrFBl654T1BbUuLP3tppxw+zsU
         yLy+Z2lFCx42Ftg0w6VGfbIgociB37zKCk6EpPrvkG8ZZ7DMUdG3rMdZWS71/YxpjmHK
         94CzaVRYEn/82dQR6TlLplOqEI0ZnzX+j2Wqjj7aeick43aoqFGzgo7ffUOWF3uI4GZF
         yLhVcktY+L8Ee4eMv1+mKGKNu6giDxhICjSTTUKe/CO7BeNXiBLLOZR74OlaQljhIX/5
         7/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF3N2QLgelobgw398KhMU68bRqt5pHiwWdo2BU5tu5BVcMnBwyIaIizWSrrm4YLXGx9xu6xL219JkXqX+P@vger.kernel.org
X-Gm-Message-State: AOJu0YxYcWMPFKnvyI1dZl+teN80KY18NmJW8yXTdfxXRiKhlPzhISpX
	UFJ3TD1kf7xG/oWVJF8taG14mS6Nv9s0Pjf5+mgB/eGffnQffcq8iJSM
X-Gm-Gg: ATEYQzwLQeOcmi1ZfpqUMDPVlRPr4NgKeWYr36CX/DqOShAltHxDx4Lx+7xXe/3D5dh
	SY/YUL233gninNYv9URLZ0PTa7kRVYllehzfMMPdo8H/fpnFpaVfK/JWden9bg+3v3QrgaJw/CB
	oRhMVgIWmUNHvX5XIGXfIaLe4CZeX8dZbe9hyyhngM4ESaJgeXpd4RSQsdQNCn0SFPKFdAd3MXz
	oe+m9ZjfW9oJ3cyX2kfVu5tKLC8BbV/NAyOAKLNkcRfnkGqJ9xxVNF+bDCixTzpFwXw8vI/Ncja
	RVbjuxUnpGpLvs/T8gaWORezpG5tV6dOtld8VrmkYWqxtnewEp+Zy1mA57zB8MFhCukTvmjBaOE
	T4bqwHMdhcuAirAnFl59yw309PMwWecAUVpQhkv+miOgNuTb8xHkHAX5SHdvvmYTRPHcgGBMrka
	K2Oxy/EGCNvaFmApFmB4VvQUawFeA9uFoeiVQG8wktAQvmpwvSjLpx0CwWlLyhgf5IFYYbdMOza
	sdmge0t+DVKp3L6eKlGt8c67NVq
X-Received: by 2002:a17:907:8dc3:b0:b94:2ca0:3bfc with SMTP id a640c23a62f3a-b942e0fb47fmr272727666b.47.1772881557227;
        Sat, 07 Mar 2026 03:05:57 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-7ad4-b88c-4d95-6756.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:7ad4:b88c:4d95:6756])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8cb2esm126252566b.26.2026.03.07.03.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 03:05:56 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Tejun Heo <tj@kernel.org>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 4/5] filesystems/statmount: update mount.h in tools include dir
Date: Sat,  7 Mar 2026 12:05:49 +0100
Message-ID: <20260307110550.373762-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307110550.373762-1-amir73il@gmail.com>
References: <20260307110550.373762-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DFE0E22B59D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-79691-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

To fix test build without installing kernel headers.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tools/include/uapi/linux/mount.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
index 7fa67c2031a5d..d9d86598d100c 100644
--- a/tools/include/uapi/linux/mount.h
+++ b/tools/include/uapi/linux/mount.h
@@ -61,7 +61,8 @@
 /*
  * open_tree() flags.
  */
-#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
+#define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */
+#define OPEN_TREE_NAMESPACE	(1 << 1)	/* Clone the target tree into a new mount namespace */
 #define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
 
 /*
@@ -197,7 +198,10 @@ struct statmount {
  */
 struct mnt_id_req {
 	__u32 size;
-	__u32 spare;
+	union {
+		__u32 mnt_ns_fd;
+		__u32 mnt_fd;
+	};
 	__u64 mnt_id;
 	__u64 param;
 	__u64 mnt_ns_id;
@@ -232,4 +236,9 @@ struct mnt_id_req {
 #define LSMT_ROOT		0xffffffffffffffff	/* root mount */
 #define LISTMOUNT_REVERSE	(1 << 0) /* List later mounts first */
 
+/*
+ * @flag bits for statmount(2)
+ */
+#define STATMOUNT_BY_FD		0x00000001U	/* want mountinfo for given fd */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.53.0


