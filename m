Return-Path: <linux-fsdevel+bounces-36428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 803999E3A26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B982B35A7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8AE1B85CA;
	Wed,  4 Dec 2024 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nl1jZlwf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E181B414E
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314046; cv=none; b=S2M9YYN6Z370YrhauByQTSh9qWUiukVi/7etvlc+SK46huy2mEC2wAsh7yvFWIG9gaUG4+G5vhDdkyBi35ZzjDsT3HaXm6fUYjqImnAFd+3fNugPmWUivfpj+495W0tnIRmpXjzX3CyPZ7h3QYK3bo2Meus5FR5BHJi6bkBfpBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314046; c=relaxed/simple;
	bh=RvR3qOxj7F/0e9rnW7O2IklQmCFVE6f3EueDbZzyUHM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jk8NT+XFJ/Kv9vow+X0BfOMQ43vOvL/IJLOaGxov3M1MQjCcAOcbxOo26ljeToiFyVzaCd95/DqXjBbjU35soOlSVlw8O/GZ2JE+T6nvlvFDN98y1ExrRlf3zzviYJYe4jKsC42PaW9Kk6t2dHfztfW+hGRl8XX6fHnHYQMdkEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nl1jZlwf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so61769515e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 04:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733314042; x=1733918842; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h210QoOSRhdPOVfbdTSglVOfvi7IBDHS6sm3Gy55HvY=;
        b=Nl1jZlwfY1Nt1c1j+pN2QmDPxKOcAoXDPFhQJ6G3+I6gBaFxQIGeYBgx1gvlZ72kLt
         nKmJIlDnRdgB98L8bUxncMzIPGn6DRE3riy5BY24IKbVU+KZx62iteuk1rYoxd9ShIBO
         t24mdAA3fen00onL9nIzDdP9qTeg8fN9KOeQT4L2DCHXmrTqwwfxUCceYZyBGcfuaRpX
         OgEXx6TBRJmwm+5DHqG3d3HDVpeC59f0nijF4Mu0uefZaYGL8oUydjlhRRGLrH8mDTXV
         bddrm2YZnXKPiqWXxPElf5GkEkEWmqg/uwh4ltPah5KhD0O0lS4Lq7n3SmOpPqSYkolw
         TbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314042; x=1733918842;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h210QoOSRhdPOVfbdTSglVOfvi7IBDHS6sm3Gy55HvY=;
        b=gGSooKOsx2nP3m9RlmGT4RYGBtot0knFtdXaP0j83hmZmEyR8IBqURf0HqPIR2/ZOO
         7TUTPIZP6fmC4Cj7H18mm3eaBIXkeBlr+8DIBCDvCvyMTOfcESczVfoOQFqAgbo5ITvp
         zn8syJACGGoUucqPGn09DaukPT4e04cl2dmQRZVG2CI/n/lxLe7atjHKSXbAwl9kqfuF
         DECJcDuTLnwgayxluvxh0d/H+tBu25wFyzvkPGVAhJ6rPSdVnNlyX6eyFgarwC9a6Q0b
         5844Qzl+JCUqImi++HPGdt3erv/d1NJwwQOpJWZeRP1YOG0P2zXzGWga8jmLxJjx0/5L
         kjHg==
X-Forwarded-Encrypted: i=1; AJvYcCXMaLnILluHy+P14d7tXQXiHzKNBCDbC2NaKZIfFypCu1cMccAX4UwYchPUxtYyLV9EQP1PoPwFyv7o2YXq@vger.kernel.org
X-Gm-Message-State: AOJu0YwbrdGGy5dxljEhOn0XeeWQR91axux1WKnd9okFptuaQqsaXzFj
	2RrXnsO5XGgypFmdRbLolIh3m2osfeQ6XSLSi3nXBdgza/C0s18ZanVBUixLBhY=
X-Gm-Gg: ASbGncvROBrDOfUHbuhHThn9DGIEWjE2hMHZq1PHC/CYX0WsxznybC+HW3pZPlQj7Bp
	iO8c+ivkqVRBj603ykWOEWOL7KU7IFGJlH82EX2A21XyoLFPRFR6Lf+NuO9IXCxCSmi6vFaHa3/
	kbyHY63Qrz6ut0+EmEU4HXHnQ8H3i4pHHmNhey8t/KfeYXXehePnEk6iOlOFivWiZ9+rOsnvPwT
	plTGOmBk4APIuAD84yUzZwiTcnyuhYARd4V0iFzZapX33ivYWtUsPs=
X-Google-Smtp-Source: AGHT+IEMOOOmz0PjNc5gkcjsABrK46MDH+6JTcOtcJN37eRjlQ+sir8R5ollqwe8lrVAPHvlPmBp4g==
X-Received: by 2002:a05:600c:3b8c:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-434d09c0b53mr62649135e9.10.1733314041606;
        Wed, 04 Dec 2024 04:07:21 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b14csm23020975e9.2.2024.12.04.04.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:07:19 -0800 (PST)
Date: Wed, 4 Dec 2024 15:07:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nicolas Pitre <npitre@baylibre.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] binfmt_flat: Fix integer overflow bug on 32 bit systems
Message-ID: <5be17f6c-5338-43be-91ef-650153b975cb@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Most of these sizes and counts are capped at 256MB so the math doesn't
result in an integer overflow.  The "relocs" count needs to be checked
as well.  Otherwise on 32bit systems the calculation of "full_data"
could be wrong.

	full_data = data_len + relocs * sizeof(unsigned long);

Fixes: c995ee28d29d ("binfmt_flat: prevent kernel dammage from corrupted executable headers")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/binfmt_flat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 390808ce935d..b5b5ca1a44f7 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -478,7 +478,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 	 * 28 bits (256 MB) is way more than reasonable in this case.
 	 * If some top bits are set we have probable binary corruption.
 	*/
-	if ((text_len | data_len | bss_len | stack_len | full_data) >> 28) {
+	if ((text_len | data_len | bss_len | stack_len | relocs | full_data) >> 28) {
 		pr_err("bad header\n");
 		ret = -ENOEXEC;
 		goto err;
-- 
2.45.2


