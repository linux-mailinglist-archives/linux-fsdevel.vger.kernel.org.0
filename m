Return-Path: <linux-fsdevel+bounces-70025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8C9C8E8EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF36934E444
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE09A2405E3;
	Thu, 27 Nov 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmaZM2OJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ui576J62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB9E1EB1A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251206; cv=none; b=oJbqKQpArQIVSe8BdCN3BOsMbf+AuQtXm8BXvrdSLzOD9EKdu+XXyA3EA8W1dsAOEfEd38zROldMmvWYArUS0pz4L9c4u572qgLZX17lteZXOZr9ix9YZR448zzSKqPJdgpKrxCXauRAf4VvJq1VR30BRy0rrXNPUqV1lHlBkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251206; c=relaxed/simple;
	bh=+Pt8YKjNHobik7IJ+2UzEXYahr20AHIVvarIQ797e6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NOTgDcfQS23/QYSm+76ZJaWqKX0O7OZtQICJS6qhy4b9V5yvVYpQC/lLHuaqBmdhCznubD93qy/EWAF41TboQfnd5ZIDkto3n2lFd/K912rnWJIPjEw5ICVBWXj1FaUP0visH5CdCduJghhn1O5U8TM3DHsYk5g2L/yTz7w/0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmaZM2OJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ui576J62; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764251203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYozc2QXCzpsGSOXkY8fPFQDc+gxi7zXP5QXCFhtgLc=;
	b=PmaZM2OJKjR8vLPDaWJAkQo8OYFU2Pk6ylpHqql20C+aU5pyvCDe9BCeqik3RdF/F0ussi
	+X5Q/+2+mxM3Q5+N5BXgpbak+G9ERjcrmXmMmyyhOeLowNZRAdjn2QSJxK2Lr1JVVZUch9
	E+lc/Bm2IC8uXaBaQUMye5dau1z2p/0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-P-8_6ys6PVq3J1UvMQW-Uw-1; Thu, 27 Nov 2025 08:46:42 -0500
X-MC-Unique: P-8_6ys6PVq3J1UvMQW-Uw-1
X-Mimecast-MFC-AGG-ID: P-8_6ys6PVq3J1UvMQW-Uw_1764251201
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88051c72070so15557116d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 05:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764251201; x=1764856001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYozc2QXCzpsGSOXkY8fPFQDc+gxi7zXP5QXCFhtgLc=;
        b=Ui576J62QmfvK+PTJvZkRmfoMuezP7MuRf9fZBvNGTLFlrzltR9lqQqhDCTR5Uz07V
         eA2omI9/3KuX74kvo0JQQVqGqY0tuExrGcbW45WCE5/3ZXZqMSGYpM473Iyq+bSEoerd
         vIRF8vABxTHMImYFPnpwz/Nnw7521JvhYyYJOxUt23SAh94cBIJi7ppGlDW2qNs5nAyH
         J2baA/gNz1/NvORNMwDdulA8lPgfvw/cGGDePW6p52nq3ckV+mVlMCQw+ZQpDEyu0ZbN
         URiyV+RKKUiDm8q1jbvE6YWozUj9t+sWxCjRu25bZBpaRu7S9wx5x8F79vRAuFKAq0k2
         NHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251201; x=1764856001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tYozc2QXCzpsGSOXkY8fPFQDc+gxi7zXP5QXCFhtgLc=;
        b=Xu+SSPoRlWEUW08NbCNtnpkLpw8He2Xwm/Wj1FuS1GcHcbFDgS9z2e5A3biM3AMM7B
         Bg7h/IqSUVEYrMQdWtjxSAWEFE/V/N3lK+NvWkBUC1OA6seOwOBsuQBG52uBZ9FZwhb7
         /Pn+ZMnkOVd8eoME7XVxcJKG+JyrAoM5DzZITSfTDQURhAWLw9exrBs7ZPMPmjpYJZBQ
         lPAtd8y1u6ZahtzU8VByJSxSKrz0aYU/eNvTPt5UKEGpQahJFuZmrRUEjdAPrz2xjG36
         gbGdASeC0+JJh5nk5PatP2okWy+OA2gZW6GQMOZazlWFm1B3+/6W0JlhZl/Fu16MgHbd
         y7QA==
X-Forwarded-Encrypted: i=1; AJvYcCUkIZQcpk4vKfkNOyopniHzXaQLZ+ssPSrEQX+bVEQKiQbDF5m08r/UvUtmtSmLoMk+j7CVL9ZLoFkYI7vk@vger.kernel.org
X-Gm-Message-State: AOJu0YxtW6pSlQ/yvDPyo+epOIqKlimbnUJGyHyK2nPPuDQP9aRQeZdc
	v4rmbfjST2EEf3OG/TXkOfv92OleMkhLtcf7pf1KNun83Imuv2l1yZlIQJcokSv2g4RrkVpol5Q
	dUR4ChD2joUpyK0DbCNWSsvtoaXLAS9nYAMC9OIb63vz5m7HdTCvpNOkZemTzqD/vPAs=
X-Gm-Gg: ASbGncvodFWxbZI0SJN125y0NmR6MuemdQEgU83WhRw9qR9SLMmh2Hhz1tXKSTaB8Rv
	J8aNVfXLSdrvdvSwioyksbJDF6Oxi/jF5zRj5qbMuG/XRJEt+6nSr7Mp+w235CuVZdRr58LQDRE
	BlEr+X+ZuFrT6NJW+vBpPWUE6DCWUhDxzX2cU/2THsLh2UsElXoCt3BzA3/MEDvw3V0armwEgYa
	OzrJMRSqiHEhK4SoUoagG11CFBQOus02Lynh86jCWU+1QlmhZjLzgX3MuHmWPBjleWibqeNfxzy
	y0gL0heA69x5y3XLUIVA4sWKfvET/dMbMMxIfoEJqK0hE+OQ45PCkx8JNsvtw7WZSwdwU/bsRbS
	UCczG1iXoLpLJ6+M+BKh4Ix2Hlal/QyGesk3NWZu0f/c=
X-Received: by 2002:a05:6214:ace:b0:7c6:2778:2f8 with SMTP id 6a1803df08f44-8847c521d40mr332714606d6.47.1764251201640;
        Thu, 27 Nov 2025 05:46:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa2DmAJl9qldD/UA/PQmeybzFtzeTjryoUMyCvO4Q7g2eNNSASL1fsMbZ7y0bByB1xtohMiQ==
X-Received: by 2002:a05:6214:ace:b0:7c6:2778:2f8 with SMTP id 6a1803df08f44-8847c521d40mr332714306d6.47.1764251201292;
        Thu, 27 Nov 2025 05:46:41 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-886524fd33fsm9932946d6.24.2025.11.27.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 05:46:41 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 1/3] ceph: handle InodeStat v8 versioned field in reply parsing
Date: Thu, 27 Nov 2025 13:46:18 +0000
Message-Id: <20251127134620.2035796-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251127134620.2035796-1-amarkuze@redhat.com>
References: <20251127134620.2035796-1-amarkuze@redhat.com>
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
 fs/ceph/mds_client.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 1740047aef0f..32561fc701e5 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -231,6 +231,18 @@ static int parse_reply_info_in(void **p, void *end,
 						      info->fscrypt_file_len, bad);
 			}
 		}
+
+		/* struct_v 8 added a versioned field - skip it */
+		if (struct_v >= 8) {
+			u8 v8_struct_v, v8_struct_compat;
+			u32 v8_struct_len;
+
+			ceph_decode_8_safe(p, end, v8_struct_v, bad);
+			ceph_decode_8_safe(p, end, v8_struct_compat, bad);
+			ceph_decode_32_safe(p, end, v8_struct_len, bad);
+			ceph_decode_skip_n(p, end, v8_struct_len, bad);
+		}
+
 		*p = end;
 	} else {
 		/* legacy (unversioned) struct */
-- 
2.34.1


