Return-Path: <linux-fsdevel+bounces-11164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9B6851A89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0696EB230CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04F14597F;
	Mon, 12 Feb 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBoOKX4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B335D4174F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757229; cv=none; b=pwVZ9tIfMGRywoXgdpPxk01ZWuWBeTpoZtO7wsJgM3xVCqeuBbhBreBFdbILlFQZpUWhomQ+JPUZnqTMtkQ9Xuz+diUp9xezgo9yaS8d9KmM8bvW687ROJQuRjyND2yJOH5+ecOnk0TcoSEXy4WCTmom6EkzZECiQSYovx2OAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757229; c=relaxed/simple;
	bh=QdzJQ1kBU4GhtNmWFv/v5q2u9OPK6bqQ8YoEEN+UHm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fxIwKVKl+A5GAb/WbQna10KjeraphYNeipjlvmxwPr9q3L8At0b0SICVJq+tqt89QDzPDNhSdOlLcOgXcLuWGJFP0PMi70lwwHzLfSmy7zneE+K1V/jrm8UqJQsnu6XSbMXHquhfmElN3mXS9WJm3vf3Kj6bG3GG7bc2VjMEsuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBoOKX4p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCVu6C3sA7ElU4nB0aYXUKm+yvCdjGTpJNzXHRX3ZOA=;
	b=WBoOKX4petF9DLZjnl7E3UwJPKUQbsWmmIUynF4DyajaBo/NIO0SMOvJvNp0Er94Kv812Q
	hFY0ubsmLTmr59ijIwbridjU66qo5A7JOUSjzl4AWnuMqyyPGNREvmA/qQRI328ORXIrkM
	F5XJyZnR6OarqgAfKhHmOMFM3DE+9wk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-ilkY4KWNOHSyGYUaWN72Wg-1; Mon, 12 Feb 2024 12:00:24 -0500
X-MC-Unique: ilkY4KWNOHSyGYUaWN72Wg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-560ebd9c1cfso1809297a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757223; x=1708362023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCVu6C3sA7ElU4nB0aYXUKm+yvCdjGTpJNzXHRX3ZOA=;
        b=mewwayd808VBnUF+VqpY4y3IoOShL9cCoUFUEWA0ZsrIICUsLBp0lo5W2lNZ02wQRN
         hIJ5XBNRMLQAfvOqxArgboiQqFIE6fAT2dRDGaKVUda95JAIIIhGFSk3LTUyJShKmuye
         iVvPX6DlMNES/i/irT2VIpI00Zmu8Zb1ds6i6vlggEhD4BDIsio9E1eIP8VD9qoqsxec
         P7qSbcLqopXmQMf95vspTvWzDXPY6gaId2H7ehu9g921475YdivMRar6mfddTGBHrwdI
         bHTBIKUazPl85WaKQkwY9ZOzUSnaozLyXuUXfG7YmGFESrnop++NnhbAv3H5Lj8CqUQs
         kEtA==
X-Gm-Message-State: AOJu0YwBRopimetNYEjliAZoHIVzT4OisSQUAx6KWlAGpSmWI+ERlucm
	h59LoEYBk023neYQtNLCc7P2Uh8B1DYI2LcE+i+wfj3O2jnIdzpMwSqzdk+vk+E+0eO9LuUh62s
	C5R9eANXlTPaZpQOY7bLcC+pHrZPN6WWeE3lKsI68Othv6LAmxlmcAKvg2tYsJA==
X-Received: by 2002:a50:fa86:0:b0:55f:fd61:b08f with SMTP id w6-20020a50fa86000000b0055ffd61b08fmr5444427edr.4.1707757223185;
        Mon, 12 Feb 2024 09:00:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX4QsV2jwPgEK3ppOb+fAmuTGxzi5pj46ICsgxsM5V1RWud/SUlTZ9QaiHLZpC1sd63X9YYw==
X-Received: by 2002:a50:fa86:0:b0:55f:fd61:b08f with SMTP id w6-20020a50fa86000000b0055ffd61b08fmr5444416edr.4.1707757223016;
        Mon, 12 Feb 2024 09:00:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbixGwNn2/iQes+rCvgVp/F3RjBSehosjFCAIvdLXWSMONtUscMUhdVZvz2ojDIXeQtTNHdhZ8OVZwgnN/hd7k6GmI5Ryp54qW3fmznAn2ASgRznKnI1XzfIgGrVB3dwYWfYVzmpZ0hy2OW2vDHkBCu2jmZU1UIQXfV1xRLXQkWg38QoXASDkPImLM3obGk9jg3wyKszAXbZUxea+dMcCgzt2VQyuH8wp/
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.09.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:00:22 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 23/25] xfs: make scrub aware of verity dinode flag
Date: Mon, 12 Feb 2024 17:58:20 +0100
Message-Id: <20240212165821.1901300-24-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212165821.1901300-1-aalbersh@redhat.com>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs-verity adds new inode flag which causes scrub to fail as it is
not yet known.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/scrub/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 9a1f59f7b5a4..ae4227cb55ec 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -494,7 +494,7 @@ xchk_xattr_rec(
 	/* Retrieve the entry and check it. */
 	hash = be32_to_cpu(ent->hashval);
 	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
-			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
+			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT | XFS_ATTR_VERITY);
 	if ((ent->flags & badflags) != 0)
 		xchk_da_set_corrupt(ds, level);
 	if (ent->flags & XFS_ATTR_LOCAL) {
-- 
2.42.0


