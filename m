Return-Path: <linux-fsdevel+bounces-30219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC1B987EC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 08:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15C8B21D01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 06:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F337017B401;
	Fri, 27 Sep 2024 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PclUVf2P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013817A599
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420012; cv=none; b=h8HUNTEV+dsML98XLVsgZRtVUjs1MEaK/tecm4/V6LFtCMBQJaF11klcxLa2rt8IcC7Y3mGLpm2U6ObbLFfCU0k6HGqKLOgsleFiwt+IpPzbtC5QBxhn1Z6UG2VpyrMpXshtqXXap4B5Gt+ExT9wtF1Ut89dkY4bP+1b1voc96c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420012; c=relaxed/simple;
	bh=RcNpXBReu0YTEEl8Fh0cDRoNsNzMU+CnLpZNzIrK+wQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RV5ha07RiHLL2TjU0/g8sRkyD4nAF5aMzQ5kPtyU6fNiuA5aCBcLR8bPPjtIkx2pscA5izAo+VX/6mIRC90rTNMDEI2/0BR9MUVCc2Q7r/A6JyosCxJdd2ukpJ+MxPESYPZ+AdfyqG74bG06burkGmeLL/baME6F86DgwsTm+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PclUVf2P; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718e285544fso1432406b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 23:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727420010; x=1728024810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2IWPRG8mQuDfXxUuRckNQFKG7wR8uDX3QnCuWN52o4k=;
        b=PclUVf2PER58UoFzWO1hXFrL7ztx4Q4ju5NUkcERNpUssvyvoMbDB+2gUGPQjj6g75
         FasEvreWpltDH+eFBuVdxYQZRpali+IKf7CVpX6IK/BQ9BF2LulYX6KF8kluleujELa9
         w6M3i3ZsbSynbYgoQH70YUGM75WoO5J7MARJamfkZSddoDYVwLbxXL27EoIRoS7Gw1dS
         /gXcVsOAkWA4Xw3hjcq2c0773LDvoINDwQ/JEjMjsmMIs6XA0LUbiWBMrBbecqOeB4ES
         loPrxUuZwZgZ4/gTXV7dT8z/704fv7NOb15BR/LkvckilFIam+xAKw8lVuLsf9G7YHpO
         WhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727420010; x=1728024810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IWPRG8mQuDfXxUuRckNQFKG7wR8uDX3QnCuWN52o4k=;
        b=iqlvgkqRihxw273AoubuP+QK2UMRh71g4C2MAacNdtafJ9guLuuM69cM6spvR+EChX
         qLV3gFQQkHcicRhn+j9Bn9BCkFEU4D94IJRjM5dmNMFMg4F3HuZZdeJ1+X4XYAhMXXYL
         s6abWcm4wZs7bXQWfKNGbQa2UtN/9xJJaXJfWK3vKVoVjdYh52DHiHOeWtQolnrr3gI3
         ocR9qIlxpZEfISix4sOZmgrfDqTk4JMNgEZeMlroxlFZflxdTLX/pMnq/RsAAVUK/k1B
         YlKy9PcWxn1NfDqMlW7m4ZjbMvG5WQupJ+ZmNu3VTL7EZDrAVdNsWJMT5+r9ugo7Ji4Q
         r/4Q==
X-Gm-Message-State: AOJu0YzF37CvK76ALG8Gyxo9tBGI86CjcvzrmQ97GeEUv1Ek/v+taT/Y
	9paD7+hhyVsJmvEbGEapO4fhtJHbtykY5k5+X8IgF5eN6tor8vAPZJKejlCORFA=
X-Google-Smtp-Source: AGHT+IHOmYSbAu0O9bhZy7xzeTj3TXhDA7cPglFXb1smVzaiy4tUAf/57UIRLji6JVyBzi2djztawg==
X-Received: by 2002:aa7:88c7:0:b0:70d:2ac8:c838 with SMTP id d2e1a72fcca58-71b25f00be7mr3817392b3a.4.1727420009932;
        Thu, 26 Sep 2024 23:53:29 -0700 (PDT)
Received: from localhost ([206.237.119.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc3f7sm926126b3a.77.2024.09.26.23.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 23:53:29 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: chandan.babu@oracle.com,
	djwong@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	hch@lst.de,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v2] vfs: return -EOVERFLOW in generic_remap_checks() when overflow check fails
Date: Fri, 27 Sep 2024 14:53:25 +0800
Message-Id: <20240927065325.2628648-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep the errno value consistent with the equivalent check in
generic_copy_file_checks() that returns -EOVERFLOW, which feels like the
more appropriate value to return compared to the overly generic -EINVAL.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/remap_range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 6fdeb3c8cb70..1333f67530c0 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -47,7 +47,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 	/* Ensure offsets don't wrap. */
 	if (check_add_overflow(pos_in, count, &tmp) ||
 	    check_add_overflow(pos_out, count, &tmp))
-		return -EINVAL;
+		return -EOVERFLOW;
 
 	size_in = i_size_read(inode_in);
 	size_out = i_size_read(inode_out);
-- 
2.39.2


