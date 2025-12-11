Return-Path: <linux-fsdevel+bounces-71116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4588CB5FB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 14:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF4E03019B67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D173128C3;
	Thu, 11 Dec 2025 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xv4vQRIs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3tuZEpm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DB1304BA8
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765458777; cv=none; b=ZWx7OpcYPh/k6FQNAG7qjQON1AER5349YB+t0KZc1PbeXYnS4upqb2ajsdnScvcYYlMNLc2bgyaTRVE4Zfqq69r4kKX7vXEXbmESqTOOTX5NrmDp+gHkyVEZ1TF28u3/3ZWRpIlbvN+UtroQOgNMPJW4dLJSj0fDPdFok3Ao0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765458777; c=relaxed/simple;
	bh=iQ9M488CihDtrJvUvwfieWujSKkq29mho/gA+joxi9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QM7iIASf5pH7YsyYeMT3wtSzQNPaYB4n6nKyUCl1dA+ODhvv4XOg04proNGNB7ghd7WF6EH30R8w/76R4ZIliPS4QwQTvzjS0u08MlbsSz9wiygiRXB17lEUfwe5kwLzhapM9tOxafWgcW5TfDbhT+IbeMgWwc631b4iKp+hTxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xv4vQRIs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3tuZEpm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765458775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDFEc4fN1lJI19el6jFqqGDNA26jFoyWc0WKoX0DUKA=;
	b=Xv4vQRIsxxmhQtNzVAoIF8b6PljeUuRGYbDD0HZZlXcT+tLlnJMS1wSYAX9TeXgbtMEgjZ
	VoEixBH9hyz24hSn+gzFnn8ipXOa1uM0tpwjNYSuI+LTrfkiAb6ifvMqiOFqI8PEOAm1Wt
	uKdaLdX21z/jxJwXgkPwdwOI6ZkkT+M=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-BraO_R_dNi6IxZfEIHszPQ-1; Thu, 11 Dec 2025 08:12:53 -0500
X-MC-Unique: BraO_R_dNi6IxZfEIHszPQ-1
X-Mimecast-MFC-AGG-ID: BraO_R_dNi6IxZfEIHszPQ_1765458773
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b6b194cf71so54574b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 05:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765458772; x=1766063572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDFEc4fN1lJI19el6jFqqGDNA26jFoyWc0WKoX0DUKA=;
        b=b3tuZEpmKS+PgqW5qwlSDcgthr0ngHEYop5/z0ype9bgQV5SU+hCB8XBt0lObpckww
         OtLs0+rTOHQPw3lZUhho40IedQUIDybUybaCkO/GqzXTSLk3uyB9adPTMTSyFJxV43bV
         XfL311lPf41wrID8uwIhDCGNpl5TBOZcO1bogkHJhE40G4Cmris9yXEUCz9CvaSVvVmn
         pAdUKBxl4DadIpDxps5ttD1/NtdJ5Xaz2mtVTqk7g9YGZOQhiWBPnKhKolzEja0fYSaR
         GZ7bx8917mD7GRV4jKfGaLwd0xW2wxz42nQ3uTjzGsdVJs4NoPI+uLX41a6wJXIeluof
         Vq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765458772; x=1766063572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDFEc4fN1lJI19el6jFqqGDNA26jFoyWc0WKoX0DUKA=;
        b=mqvD1gQsxy2/V6CTP2BkPSHqq3LZG67dwQx4C0HMVp0c30xDDVg5KqHoyW51LIQHaq
         mhSLYKa6no3Ci11tE73v3855gZ2Ax/6ZCLacRKK8lslfFWUlhpdyP3DzyKYx22TEzg2M
         TobbEpTHG4L+NhK3tDXaFiD0fe8lxt+L7O4YWbjWb8oOBTINPX7mcFLewLKRFRDMWh+Y
         dcI8uOGf+srCfJ+rgsL33AhtLw/O80tBGKOMmX6NkE5bPKQ0I4TEAK2pavDD4P9imyMm
         8/wmrEgLe2EVq4P4MUV0FFX4ozm3Jcj/k7kTJJIlsEwRH8bMbuefh18xWQ712CVtunAe
         wX8w==
X-Forwarded-Encrypted: i=1; AJvYcCWd7cfUJ999d6qdUmK7RpDhwZXyoWrK+sdQGlH7hSOJX/HbvisOcDROzaVaOoY/kx2vgJv/+e31YmbuHFZ7@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+4RjMUOXu+dmZeLk649kKCSTfjbJ/XzW9GXssbRYERaWEM27
	kuhikzvJOB1RBpeLWK2WG++i9ZZYvhKSjL0IeUY2sA7M0NN+K7+oKMPvtCHOyfs6l0SZeoDziP4
	pRRKChTzmn5cmINULTidxiu2MjwajOiFsQ44CFW+3teEXI1/FY7eMlRPnNcItgFeXPtnZ4S63GY
	As
X-Gm-Gg: AY/fxX7zBQh1Eg+a+AxSTHORfBb4CCQMDAxT4UbpGLFcq23o/fLhXtGboJtRxz0mzuT
	oyMxsF0oAXWixyVHTug1so2LYbPreq1427XvWWlH5P/qCsdJUE9s4xsgrsUkSHhdGP5v8S7c5GZ
	UyJ2EEIVQtCUMFWyfRIgXw50a5LbNoftwdi+OHeH7a2eeHwreBZ1sz3LxcJV4UwBQeMJvpUUn0L
	gqe7GMZMBpc8dK5XnaDbdYL2i3PyUkyhhW70x6Ta9VqL5KDxhBuHPXctm8/qKF7Nk+BFGjGeBsL
	smR4I3BiUic/nYuIf8CMdKGUyGnembpxLBApB7GeyuZOvO9GZZzQFieLPewjYYlZ6wvxGCz+LAU
	RT8D6U33ym/EqPd0xPkStCSDT2i7tjxGzB6ZI7Q==
X-Received: by 2002:aa7:8893:0:b0:77f:2f7c:b709 with SMTP id d2e1a72fcca58-7f22c93a493mr5989982b3a.5.1765458772268;
        Thu, 11 Dec 2025 05:12:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrO3U5PID+k1jzbVzuSa+Ezk+JgNL8rux/aTorTtqute2usQKxqDshXflJAKXqIgH0ZySa3w==
X-Received: by 2002:aa7:8893:0:b0:77f:2f7c:b709 with SMTP id d2e1a72fcca58-7f22c93a493mr5989963b3a.5.1765458771940;
        Thu, 11 Dec 2025 05:12:51 -0800 (PST)
Received: from dkarn-thinkpadp16vgen1.punetw6.csb ([2402:e280:3e0d:a45:3861:8b7f:6ae1:6229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c5093d5csm2514732b3a.49.2025.12.11.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 05:12:51 -0800 (PST)
From: Deepakkumar Karn <dkarn@redhat.com>
To: jack@suse.cz
Cc: brauner@kernel.org,
	dkarn@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v2] fs/buffer: add alert in try_to_free_buffers() for folios without buffers
Date: Thu, 11 Dec 2025 18:42:11 +0530
Message-ID: <20251211131211.308021-1-dkarn@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <pt6xr3w5ne22gqvgxzbdhwfm45wiiwqmycajofgnnzlrzowmeh@iek3vsmkvs5j>
References: <pt6xr3w5ne22gqvgxzbdhwfm45wiiwqmycajofgnnzlrzowmeh@iek3vsmkvs5j>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

try_to_free_buffers() can be called on folios with no buffers attached
when filemap_release_folio() is invoked on a folio belonging to a mapping
with AS_RELEASE_ALWAYS set but no release_folio operation defined.

In such cases, folio_needs_release() returns true because of the
AS_RELEASE_ALWAYS flag, but the folio has no private buffer data. This
causes try_to_free_buffers() to call drop_buffers() on a folio with no
buffers, leading to a null pointer dereference.

Adding a check in try_to_free_buffers() to return early if the folio has no
buffers attached, with WARN_ON_ONCE() to alert about the misconfiguration.
This provides defensive hardening.

Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
---
 fs/buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 838c0c571022..28e4d53f1717 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2948,6 +2948,10 @@ bool try_to_free_buffers(struct folio *folio)
 	if (folio_test_writeback(folio))
 		return false;
 
+	/* Misconfigured folio check */
+	if (WARN_ON_ONCE(!folio_buffers(folio)))
+		return true;
+
 	if (mapping == NULL) {		/* can this still happen? */
 		ret = drop_buffers(folio, &buffers_to_free);
 		goto out;
-- 
2.52.0


