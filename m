Return-Path: <linux-fsdevel+bounces-70465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD9AC9C0EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 16:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9AC3A92E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE16A325700;
	Tue,  2 Dec 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHfSJPwL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ntJPrTHX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC5324B31
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691083; cv=none; b=mR2nYCCklAKM2aIEpLfIe8lmzFE0zrII7VC4wO/DVzEKzIDydO4TamI1EiXdasXFFKLsxMBX1M3tKKYlpCoyh6O5DcbEeFOvUJlovMjBI9ApRcWXHswXMRXmO4oNYy5TLqMKg/JDmEKEmR8VFOjmoGzt+ohmxII0/9yaui6DZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691083; c=relaxed/simple;
	bh=B4xyzwDKGxq/vyrw5rw3MiyV1PFc/MXbtlIPEadsNuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BEguFDF+AyLGIuzLTLpK9u97Nn5i/D2u8dch2DqIf5EcOPH/hksv+NCCphpeAn+v0oCTfiL5a94dCJvCNkUY6J5+s/i40rasV0oZDXrnqu5HGKgXHGhGL+QqZWDEYlvpyimmHqxcyeSjRcICTHSdU69XNXepcYhIGwQJ0kRpQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHfSJPwL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ntJPrTHX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764691079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jcDCLLxng0aZwTmIpvTEU2QWfymaHSnvSLSvvAB+tII=;
	b=LHfSJPwLgsM0K6hisEWMuF8nI7SxJ3kKo0FsAcAwhzetLHXzC/IAuKrO8oA3oQilnLmteq
	aYDVAdUkIPr9eoRJYmcN+a1arrwPpdsTaaTOSx5p0CpMpMUgL8RT69MhEf9SOQdGgEYodZ
	mYj3oQi6GuzsTWdQ5Z0WIv8TraeuU5Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-14BzphCaNVOXhCCfuOvvlA-1; Tue, 02 Dec 2025 10:57:57 -0500
X-MC-Unique: 14BzphCaNVOXhCCfuOvvlA-1
X-Mimecast-MFC-AGG-ID: 14BzphCaNVOXhCCfuOvvlA_1764691077
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b739b3d8997so402400766b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 07:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764691076; x=1765295876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcDCLLxng0aZwTmIpvTEU2QWfymaHSnvSLSvvAB+tII=;
        b=ntJPrTHX/gUiVAVx4QWdb24IJ2iBM05XetdGLBWY8CC6EkG8trhLZRLlnHKgwusdjq
         eDrxBWxW3Hc9F5JOU6YuN+ayw945Rs9OC148ZGt8QFxgi9Hrkp8IreszHu0ERMHwRGbh
         Drwtyyu4t3CNPw7Cp+EoSB1GDY491aXU9IhM96iOmPzQYuXcP+DOmxV3mZlVcSftRGS4
         pYjjZy4bX6E12prFrm0OAHYMy/n3g3iC/qM8GtFdsoVLac6k5cWfndG17eqidOaYGjcP
         AJmPN0mChdSNt60rqUAjP5gNg578IrLXwGvw+Nt29CC6jn5F+s28cUm+nIrP2IlMOCEC
         dA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764691076; x=1765295876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jcDCLLxng0aZwTmIpvTEU2QWfymaHSnvSLSvvAB+tII=;
        b=NfVeSzrEjVoUen+18aZj2zxENgw9RVJBRaYgF5sfD5LasyFbOo3PGIap67gEG4lQAm
         a4Yyl36ECAt1TLSd5sG6AEGycN9ZNZRkCngCGMcSo61gBg+JlbCI4BVkXgcMEt7hNvPu
         lIU5xBouV2FDZSHrUNrLtDK9/oDI6yRzHf1W/tc19TlKn3wskEp6BVqhbDhp3Sa5dEag
         Ge69bHouL2qKAMMRcA0lDGza2m/Zx0zgKXb8fPCgMVad1B9kH2GJWRwer9sfYLl8cWiA
         PJH+PRdzHqxVRNO+EauJ8cMOfssUX9zyPe+w7Lqrc8m/bVEgJONjGvHvgX5qj9Wo5oSg
         mwMg==
X-Forwarded-Encrypted: i=1; AJvYcCVBjAdQ12M7HNAVl8dv0jVajYhl5lw8zbtHwa3mBImyVlg96U/VFlLJog0EQE6+ZmPAaW64jE5tZ7YBpC+r@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0glaVJFvh9oOEdyu/Ra7YzfdY0DDoi6IuKR7Gm/IkuD/xOK4
	Eoer6WLrCqI1LuLX0VamFADCEXkWQR7QvfelszMQJxjFvG40RLmhoilKuU0e7y143AvATBJab6g
	cVRMzmPDssTvloi00N674ZHzxE9HzEfmiA9sytIYOjezhqPy+0mAqJQeHRFrTmmNSBq0=
X-Gm-Gg: ASbGncv16KerOSgNk4PR5efqxzBsGpHcM3Sh6IGtsi9svKq17u7BiSNk0mjS6NvmvKD
	pgHcKsPnkwxGfjAJjZt4DHBTTlCvvrTKYTlu3Jdixpd156kF0oLrKIplYkMUHPrOblMjZhJNTA2
	KKwZGVTp79JfFjErrqSfQO8P9x5Py4O3+O3dz5dCe4BCtddMcsD1tn4CUDChqmke1vlDgEG9KCi
	TfNv+og7rRbVILrLTeEN6rQpbDnidHtAwe4eoFqoi9p5/15X2kf3iLQnlynwPyA+T4FQR4K2Muy
	YYJun+PMBtHxNTYwp1ukJW8tmzjjQykQfZWXcLs+HP4sRWm5FP4f4FDloMgD000Z0EKQyvrVKTa
	GE5za3sms1VoOZPlWwM5vcA61jQughLL2DpaLNW9s9eM=
X-Received: by 2002:a17:906:6a0d:b0:b73:6838:802c with SMTP id a640c23a62f3a-b76c555af37mr3217148166b.42.1764691076538;
        Tue, 02 Dec 2025 07:57:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8DAKvgNQ4AiYWOBCevqR0FcuMTS7aYizAyEt6RtRcIesRf9HBpeD+CBkrEzjRs79N9bz4QQ==
X-Received: by 2002:a17:906:6a0d:b0:b73:6838:802c with SMTP id a640c23a62f3a-b76c555af37mr3217145266b.42.1764691076125;
        Tue, 02 Dec 2025 07:57:56 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59eb3f6sm1520702366b.55.2025.12.02.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:57:55 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v2 1/3] ceph: handle InodeStat v8 versioned field in reply parsing
Date: Tue,  2 Dec 2025 15:57:48 +0000
Message-Id: <20251202155750.2565696-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202155750.2565696-1-amarkuze@redhat.com>
References: <20251202155750.2565696-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add forward-compatible handling for the new versioned field introduced
in InodeStat v8. This patch only skips the field without using it,
preparing for future protocol extensions.

The v8 encoding adds a versioned sub-structure that needs to be properly
decoded and skipped to maintain compatibility with newer MDS versions.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 1740047aef0f..d7d8178e1f9a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -231,6 +231,26 @@ static int parse_reply_info_in(void **p, void *end,
 						      info->fscrypt_file_len, bad);
 			}
 		}
+
+		/*
+		 * InodeStat encoding versions:
+		 *   v1-v7: various fields added over time
+		 *   v8: added optmetadata (versioned sub-structure containing
+		 *       optional inode metadata like charmap for case-insensitive
+		 *       filesystems). The kernel client doesn't support
+		 *       case-insensitive lookups, so we skip this field.
+		 *   v9: added subvolume_id (parsed below)
+		 */
+		if (struct_v >= 8) {
+			u32 v8_struct_len;
+
+			/* skip optmetadata versioned sub-structure */
+			ceph_decode_skip_8(p, end, bad);  /* struct_v */
+			ceph_decode_skip_8(p, end, bad);  /* struct_compat */
+			ceph_decode_32_safe(p, end, v8_struct_len, bad);
+			ceph_decode_skip_n(p, end, v8_struct_len, bad);
+		}
+
 		*p = end;
 	} else {
 		/* legacy (unversioned) struct */
-- 
2.34.1


