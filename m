Return-Path: <linux-fsdevel+bounces-57438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4C2B217E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 00:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61790622C85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 22:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7442D1F4289;
	Mon, 11 Aug 2025 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="cKYStbuG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4BD311C13
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949703; cv=none; b=FmC63Mu/Dn/hwJUW7BFjfD6SWQwV79YZg8IcQ48i/T+Lkg7L3zRmV3HlrTjRvsIeWP6KrVcKoIa1b2ijS6SsNTTYO/ptAcMlbuK9HL+nQgyR11avzOw4b1ODcnVCw0Tnx/Rt1T1jf9cDE84PyI3KcU5Lxzt4q7jxLsnmYXC2j60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949703; c=relaxed/simple;
	bh=rD1oz+oWneUwDlPy8t5jpf+s4P4nPMQFdqEZjAHFxoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XKkMAqehWRYLrxszu7dtD4VdfRkh91aNW7mlLlizjIjPwVjwMPKNjrRSrh+VN6cHD3pUIs+f3d9Ah8IIJAokHDCZtq17kOQx9V8Zt5Gzr2iS+8NhLbCWPa/BDWIzuyZ30C/cMv2zq1Yq1kJiYnXQ5G9mprb7LVln+4j9PxbJ06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=cKYStbuG; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BLOPNh009126
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 17:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=pEFEFVE08AQwC9Il4xDKhb0NEA
	k5kZk2zpQmERpJ5cA=; b=cKYStbuGk9wa8cU3NnDlrkZ5oJTh+h34YCx8bK5jnO
	dl38XqvIDMWrDJBn1w3Kkv/6uJ6udg8Ee0ZRcluFIcThEDzAzeCK8RPgywYaWbVg
	mjfRyMXR1A8tEm6uYhYbp3kz5uV/bUWN2LbdcmIeQUt7TNu2CSaul2nIHoyDZOGp
	Vsc7amTYXXtu6oTqeNcdo4P/MQK+p11Gew73ihZhK89CwLHlp1tLwNDGITdP9Q+p
	1u528zLl/hMaNci4x6xrZUReq8tFTVW0p4dLBih7lNGF3eOe6JQFi85xixyELREX
	Nc9LPQeH0yED+bwnDXA/oydcAjtpBXKmA6b/+LrCCgcA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 48ekggtugk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 17:42:15 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b06a73b580so71164091cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 14:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754948535; x=1755553335;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEFEFVE08AQwC9Il4xDKhb0NEAk5kZk2zpQmERpJ5cA=;
        b=MR/147qpot/oW6jlZwbsEczo55unDCEQ40WAiRrfaDM0ahO7jsOYl3aWECsTE3F88i
         iAQ+sQQX8maxhPrmAaei5nfPOqGyg1HEr5DA3rZ3odKyYnQf6AAGVDrXx6TDUxmHYQ5D
         gWU12C0M2SNmacypi6wIJ1nXst95oVEj0hIQhO86Fo+cNpgpTS5+/fIgGozpW2SAUlwF
         rRLUF2udv5/x4FFIUY1TGKtAgy/36bX81WZh2z0ilUaqt8pgL53gbwaQlOgD6mtipjeV
         jEBW9vTy5zVrp3IyfvvSfXSVUDtUOA7TrRcoQ9rtgzHwi0+FqyUbi0gP5FidxfXNs7xU
         ZB7w==
X-Forwarded-Encrypted: i=1; AJvYcCV3xrSgKZfI2vK+sJhhZAf5Z8CMg4sp+YDpAyv+5GLboRQouaZVTSPs8yLgNkKvImHQt497vITkUJxmCbmw@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0T9E6IxXBTdnp/+hlBxn39qdOij11kXGVhQKPj7WsIY6b99D
	DNB1DWKnpn8S0qWB8dxpxbdllt+K9zXzklabOh1AGe6p9WiHoeVinnmkXVnAw3ggN7s8W46CFQ7
	Ot+CO3KU0Lv3r7GsRUXliK24Di3NdMKMbKgks2+O0bJyP1amT64Lcgm5L9m+QYLE=
X-Gm-Gg: ASbGncs8WrHARb0zKKzt2vTNex9h+yOdkR+SEkmV1N09ByRSj4DQ74wlZxD5R03vo97
	f7dIddFCLH9xtxsrv0WNMgyFpLGwsXUxYQX+6M6p8FgkCBvkTOxmKNoeo8B0fVQ0iLLupWTl9d3
	/YdRXyPWhAwdJGyOlUVydkDjfGpps0Tedsr1i6Gbfygpmtm8perKLP1FijNpig9wHAvhO0qj9Dj
	b/oXGMOIZv2yupTw4zZK4u2z58IRRioqMoanxltF3A9SegofKRjsyruGxITOvWV/YGGjUP4fnfn
	lpANWruKJ9D5djULt30wCN/dCuwBe76k7Xpvl6DoaJzwPcGFEQTSq6aTpGxEywC13VGXZNVtiUD
	mJ30jXqnO0A==
X-Received: by 2002:a05:622a:1a25:b0:4af:1fd3:4eca with SMTP id d75a77b69052e-4b0eca8cb6dmr15270901cf.25.1754948534746;
        Mon, 11 Aug 2025 14:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU1AoXh09loZLwU+33OklQYn/p/cwiFAD8eoDZ99ilW/Vtx1hYeKfFQbsgYX7pcVmzGOMVJw==
X-Received: by 2002:a05:622a:1a25:b0:4af:1fd3:4eca with SMTP id d75a77b69052e-4b0eca8cb6dmr15270501cf.25.1754948534141;
        Mon, 11 Aug 2025 14:42:14 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-183-206-55.red.bezeqint.net. [79.183.206.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e583f9fcsm263940065e9.4.2025.08.11.14.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:42:13 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 11 Aug 2025 17:42:00 -0400
Subject: [PATCH] vboxsf: Convert vboxsf_write_end() to use
 kmap_local_folio()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-vboxsf_folio-v1-1-fe31a8b37115@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAKdjmmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0ND3bKk/IritPi0/JzMfF1jE+NE8+QUy1TLJCMloJaCotS0zAqwcdG
 xtbUA+D1tQl4AAAA=
X-Change-ID: 20250811-vboxsf_folio-343a7cd9e9b2
To: Hans de Goede <hansg@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754948532; l=1044;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=rD1oz+oWneUwDlPy8t5jpf+s4P4nPMQFdqEZjAHFxoA=;
 b=oKspY0LE9uo50vutKmomfJ26S118Lvnuhh/I7EdTPFy54kleOmD2HHfdmp8nruHQi2NnR3xIX
 UWtkoEx3wVABpvozIV8ou9q7W9u2PC56HyA2ZpIAQABJ1vK7YC+uFkj
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE1MiBTYWx0ZWRfXzsP7C37H6fyz
 5bTOA6+lGc40Sf4Srzlyxr4jnYSxIkn1X5Sd9omYeUNln1Pk+fJbb6C4BI13iLUJoI1gJxUGOdz
 QCl4OmFUSviVnXJ2YuEjH7GVlwhoFOlvUs3erXP7SpTaVBUTh7DyEIHTm/eug/79qJHEr07NrTL
 lD5qav1P5Y+SpdKHRJDXWBdQo7BOQDyxkPGRFejdcUPkFprXhMGWtBTJptNWLdpMh/fA/jSriSp
 FajtOL0H15z+/xkXm+tN5PYrFCs9v2xubM8z4X+q2JwmqbnqwrZR13deMZZ6jo0bJcKrSBCGj8v
 ppMsBv3wRlK1M96+IQcDs9MoleBBy/vL9XOTHVKtl2uvUTCStX6NXE+B+D/lnUtsKpbxBhnDtiU
 Q3pVlOxw
X-Proofpoint-GUID: AxdmQ0OX_rmXdxXvwk27E43ggqO4EVLE
X-Proofpoint-ORIG-GUID: AxdmQ0OX_rmXdxXvwk27E43ggqO4EVLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 malwarescore=0 lowpriorityscore=10 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=768 impostorscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110152

Now that vboxsf_write_end() takes a folio, convert the kmap() call to
kmap_local_folio(). This removes two instances of &folio->page as
well.

Compile-tested only.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/vboxsf/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 4bebd947314a..178fc74e399f 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -316,10 +316,10 @@ static int vboxsf_write_end(const struct kiocb *iocb,
 	if (!folio_test_uptodate(folio) && copied < len)
 		folio_zero_range(folio, from + copied, len - copied);
 
-	buf = kmap(&folio->page);
+	buf = kmap_local_folio(folio, 0);
 	err = vboxsf_write(sf_handle->root, sf_handle->handle,
 			   pos, &nwritten, buf + from);
-	kunmap(&folio->page);
+	kunmap_local(buf);
 
 	if (err) {
 		nwritten = 0;

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-vboxsf_folio-343a7cd9e9b2

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>


