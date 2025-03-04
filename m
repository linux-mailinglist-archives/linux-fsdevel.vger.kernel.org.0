Return-Path: <linux-fsdevel+bounces-43156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8834A4EC2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F79C7AD114
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BD627CB1C;
	Tue,  4 Mar 2025 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flO358Uq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5AC2780EC;
	Tue,  4 Mar 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113327; cv=none; b=jrqQrYfCcUEoPTtHMvhl+W9FRxKyOoLJnDyyXCs9yZsD4JSDesJokwaLZz9i1wANipS4rQkQYZUDCiJHbASCQAJPciSrpPZ6TXep5LVGCAwq1/V3FQAwrd15m830SXQ62DzhJgsa5i2DUqV+Cv9fG9QBIzTH+7RGQBPScj/UGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113327; c=relaxed/simple;
	bh=P0A0PEjdHHsIeWGrtdLnPuAjyL2aLXxzIEmswgZCJmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTZK3OxomEmiqetP3n1SJrLcugD6ZtcTRgl3NrfpkpGrtfOmFas0aU8Tevpg7aoEfH5q9bGlKyr22iNDCXfQ59FX1DiyJW2VIGobE25vEHWVPyTXTN0Ydk2hFcV9XXU+FvsxP9UZdlMw/DBp5BVYrWg/pmTPSjAVt+4jfk7AL20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flO358Uq; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so9206727a12.0;
        Tue, 04 Mar 2025 10:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741113324; x=1741718124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0Cp/31N26M2IM0Uo/PPMwOObDDtMQe4/t93mqj0N+s=;
        b=flO358UqzcucVXcRjtMH6RCUYEh1lUjUzf9F/0Rn0H5LE1ylJ438QAKhi8LedBmEz8
         UL9FipcfU96VwoPcS524Qj/lRZD84t8smykAavcqNjbZ+u7aV/Y15NzO0tHIPgBZqgSA
         IyPIKm+SGv7N4QxL0THC7wt8i0yBTNetErtKkRgm9H3KyPAaI4xfti+al2FF654alrNt
         OWSkH1Iw85xTmycS7cKefrm/Ks1QNmfhYLv6zaCbRJ/V9pH9nDMqKM/KuoDiKX+wpUkb
         yZrg4u6GEF3tvn73/LHQXoTlHTiMc8AKS7gshDR6bR+lOFcdKHlgM4PsExfKTO7h5FZT
         /iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741113324; x=1741718124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0Cp/31N26M2IM0Uo/PPMwOObDDtMQe4/t93mqj0N+s=;
        b=v4rJsSm9emspZHdhT7ac9GtragHUfl4chcix1CQgU6qG6uepAqALoLtogMWKutNRir
         ZkaKRPZUEvCUhiRXqo02jSlBl7i2en/cIALHVCZirTfWPqgE7v7GER8H4NLzo5pn8I9K
         84Jx4dFHtsalc0N8YVohEqApXQe7Woeyt9EYVjM62FYi1g3ZqLVmVTzeEV6vJ5EyCkBb
         0On/OQ1gVX+xIST9vuDB7N6yS545vuy8eJFAoiPGBFUV2OS/w6BlYBUAiQMk/MvUkwrj
         F2A8IdUMjS9NdOmh8wpz12MwfM9P8CiQjs5CNmYHiDtZ9Hb538c0pswDWPXlECEuiD22
         2b4A==
X-Forwarded-Encrypted: i=1; AJvYcCWHF1vRtBHSlTK7sOh5q9fXhk4ynQaJfB41gJfNgwb23vj6N8xdn9rwPquJasEK6iL6B04sN7TweMaqjfQJ@vger.kernel.org, AJvYcCXWg5FG/E12NIi06r9Uiqv/J/Fq5kcQ0kx07/9Fo585h/JmwLxEhBmmsNreoMbW6uqJfcvkHmsRQ6nfLr6l@vger.kernel.org
X-Gm-Message-State: AOJu0YzfAKTA3Mm6kwdOrD4ubkOX78AMTUR7gyEleFF/OZ9Z8yeb3hlg
	WuPfgL5YbFXp59B/B/1x7ten+yY/2mIGYs+0tuq1kFMaEVV5JpKv
X-Gm-Gg: ASbGncsmXIMoX4xNMIxJzC+eKu9Lh8Hvhs2Fodp0IrHKlNvqiWzJkMvKa2gUx6B0B2p
	qyj6mOHcNX69dJ5hdslpUkZMNt9q31+pfmXdB5GedrtOyFI6DuOe88Y0y3a+vGnChObD+v941/z
	pgaAGnCGoSIk9sVqA1zRlZYJE/HjLrO+do3ojbhzaha5CSGlk8YBTHCgteOodQYmErjtqldjuGk
	HVrhxOe2uWkWYt632TYQ5e4X3GYswjW10rmeyBZrGscG8x8hHlQys+aGGpZYqlcA2I7RWTYE9PY
	OirITul/UrtIMfh+fETnwXOjYGKs1H7uyAQ46Yo0b83kxk3Lx9lyt0DuSWK0
X-Google-Smtp-Source: AGHT+IEFtGkcRCG36c6CxhgM4PPufjS2PQKe2hotX1hKro6brhz9YbPJ17OkASe0bM1AkzzAUuqLDw==
X-Received: by 2002:a05:6402:5c8:b0:5d4:1ac2:277f with SMTP id 4fb4d7f45d1cf-5e59f389103mr129462a12.9.1741113324136;
        Tue, 04 Mar 2025 10:35:24 -0800 (PST)
Received: from f.. (cst-prg-71-44.cust.vodafone.cz. [46.135.71.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb747csm8691328a12.42.2025.03.04.10.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 10:35:23 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 4/4] fs: use fput_close() in path_openat()
Date: Tue,  4 Mar 2025 19:35:06 +0100
Message-ID: <20250304183506.498724-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304183506.498724-1-mjguzik@gmail.com>
References: <20250304183506.498724-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bumps failing open rate by 1.7% on Sapphire Rapids by avoiding one
atomic.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 8ce8e6038346..d38b8dc16b4b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4014,7 +4014,7 @@ static struct file *path_openat(struct nameidata *nd,
 		WARN_ON(1);
 		error = -EINVAL;
 	}
-	fput(file);
+	fput_close(file);
 	if (error == -EOPENSTALE) {
 		if (flags & LOOKUP_RCU)
 			error = -ECHILD;
-- 
2.43.0


