Return-Path: <linux-fsdevel+bounces-65750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B206DC0FDF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 19:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F3B24E2349
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279F5239591;
	Mon, 27 Oct 2025 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii4ZWR5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B017C9E
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588930; cv=none; b=NzoT4t6YwgCzxXg/9EJXsVy3m0sRhswtt1nXSjIYMW0qA5w30QaXSmyIt4yivM6Qkk7bIjgH+C2To4tMUOx8qnOmBpiIIMEk7yLv1+nnC+YqiFUEVZZ087LIjdO75bZAGpJuMqAc1BZLC6mc45jtpIigKEw1csz3huIUeD1Iqgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588930; c=relaxed/simple;
	bh=FKwpS+RRh3f05hXNddJ1qQOp1vN8UITLlB2Z+bc3aRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Al14bzRyBRMyEsuDrrzIZqF2/tDfDGQ+q5xSEYCnpnMTqRrQbx0dAOZyfsSk/ai4FekeLaz6kv/71fJw7FoYqoCw2ydl0dv2E2fqum6QT/A1iy/4xYwoThYtwVewwyjkHlTUtLpXo9Kr51aIJZ0kSaYGnu45ng9waLhygdZyp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii4ZWR5R; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781997d195aso3564929b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588928; x=1762193728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i6AiQQJTb+r16wTRj42hnuntyOmOTenHhkzoiZpzOlQ=;
        b=Ii4ZWR5RPXMljsuIp0OAW3YkcJxzHl/Vz3f74VWBoux6YAzrpEVVwxuNppbJEHt3kG
         asYmeHRdkAsImthBQy/Y6nVohmlCnJXIjOYTJpAlRlXptDHFvqY3nq43X9W6EMYtS5ZU
         21OR6G7pmr5X1bzCYRqqIydgTztcaYTCybB3CDTxl7lERU35yx9Coky1pofIlCjujgDh
         ix0VltMZI1ZRqVaIAIlo2sSPfXHMXKsgu+m4eKiZyhhEJ3HxFr5YSAezYg5ukfj6oV0q
         4SvkIBjFaWj7HIa0C51gVigcY1wC14XAzaHyZC3E2ddjtpsJzn229Ewl95IBVRplwE8a
         5IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588928; x=1762193728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6AiQQJTb+r16wTRj42hnuntyOmOTenHhkzoiZpzOlQ=;
        b=SGLpqFwvZGYWrZjveII+sl0EeK5/+sZxGo/rmzqBV7W+f0iPMLtq5Ah+NQU162/ieD
         2W32BoiyOFwFQCXMdYY08qAX2UyK3Es+coJZ9FjbvTsY91uMdRWsfMSRLeLM4s/FQTsB
         CylrMbaUHWlYq89V3LI0VluaMsn32oe8R3ElzzJoqHikvjTUKJf5EDAgcupoi4adtpgh
         JQ/7iNfLPLSOThwAzs+S0FQ9WabVAbpxzBgMlflrZpYAEnC17kqe1JfNshB9F1b26n07
         do2Hte73G8No6rTmaiTx+Y/3bJSzVTudgAY55HDODCYu1vxEJYZSvmrhlwRKUTaWLIm8
         I/mw==
X-Forwarded-Encrypted: i=1; AJvYcCWXf22uHMuW7NS5RmRux/oVf6tpYiunzmuQRCbg03veiU7TrPYgu7dZT9dXpCqAsht70cuAPOAer8+RhX9C@vger.kernel.org
X-Gm-Message-State: AOJu0YyyyIi1HfwfrMBWxS/08etJhGSKADmpOx7pOuk0FZuxVOiMWbel
	AV5SWklGQlRvaxZCDxnqVM8sliJdBM6B9cNhO1L/BMqn+MT57mPdQEOd
X-Gm-Gg: ASbGncs326YkQYEspGxrA/+XnDkAK8vorWIdSiUX5gZ/OuqlxekC5nQ28IAxKEHu4xL
	IUei8w/NG27/KyXGg6pw+Me/orEOs0NvaOu6q74HctGb2wo+gZdG8Tb7mZicb+/OtlBxQOVpCYV
	ZCZCipVyrGkklR67icElLtdp18ObI1hOG439tK1ifXXmK9dFU73QP84xutWkPstvQIrqjjjSo3r
	+x2oEKoKdktd5eJgPjPG8N4gdCi1hP2706UCJE8k+iB62O2g+0L9W9mse5lSV9nP55ZFCVsNI+b
	Tbj4RLNm7CTwkm9PMfdtJiWX3SZZ3/dkSsG0HslE0eJB0MrO4DX6YaOnSOIk9n1BGUc8vLaVn30
	Gfo2HCbyTwewrsb4Fdt7nuvYp2jnsCW2GiZICUuYGmry7VXXFc0AQKTIY4Bh8DNdqxMdCC2dTD+
	hWOrdPq4VYuxkxFOslqG7soPoiSGjqKhrVkBDNIQ==
X-Google-Smtp-Source: AGHT+IH+Tb9FqsNDYLIksZWDzxrwAXJmzzTf95FSLPv1FHb8lm8mnR8mJyh9Qb0lMkebmyUCffOzRA==
X-Received: by 2002:a05:6a21:6d98:b0:32a:c8b8:5610 with SMTP id adf61e73a8af0-344d3d4aa30mr650284637.47.1761588928236;
        Mon, 27 Oct 2025 11:15:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127bf47a1sm7965860a12.10.2025.10.27.11.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:15:27 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: bfoster@redhat.com,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] vfs-6.19.iomap commit 51311f045375 fixups
Date: Mon, 27 Oct 2025 11:12:43 -0700
Message-ID: <20251027181245.2657535-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are two fixups for commit 51311f045375 ("iomap: track pending read
bytes more optimally") in the vfs-6.19.iomap branch. It would be great
if these could get folded into that original commit, if possible.

Thanks,
Joanne

Joanne Koong (2):
  iomap: rename bytes_pending/bytes_accounted to
    bytes_submitted/bytes_not_submitted
  iomap: fix race when reading in all bytes of a folio

 fs/iomap/buffered-io.c | 75 ++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 18 deletions(-)

-- 
2.47.3


