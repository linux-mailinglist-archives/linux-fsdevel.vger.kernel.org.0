Return-Path: <linux-fsdevel+bounces-50753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E5EACF4C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 18:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EB3189C826
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 16:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E6C275112;
	Thu,  5 Jun 2025 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFyEiJbJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9A17A317
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142292; cv=none; b=NseEG9EhHPxserLjoDxQke+dy0o9wUgS1xEc0fFF477742p1+T7sCxvdb9t20e8la8FA8Ulo3fV6aiANfuQOevsI4LQKesBjxjm3oRRBOAxxlNOpu0aooWsvTbIKJUdml0I0KDN59qemJA4Lns+KK8eOrRPQZpFdYxhXIXzfvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142292; c=relaxed/simple;
	bh=7tGewupCuQBqdKn9SQizRgoVU1H9Un7H9t2++GGjIC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+9EW44MPFofmLslbAp8cgQe8cs1cO2rOcFOeSxxcUKJnCEem0ZFHJ2F4r7mdUGWO+mvi61HkqT1ZM1g0M3BEV2ABjh8j8evKOKEqBihvgcYrM+Z6HdP83v5ioHZgFvXlW/raUht5cj51+BNy1Kdbt7Kvy9kvcFeYfktw4Dkuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFyEiJbJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a588338015so18999301cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749142289; x=1749747089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ+Il9aAD6diUGB7Neeip4HTyqHqME5qHPELbp8CA60=;
        b=XFyEiJbJOZmuYgJfYca83T0Xb7Ch9+2sFuVdzyXn+n7EdVxlab4eDl0YJkbOkaKlff
         zhyV3BJzIcqo6UuOcAnHOyVFeEjmMgP2SCNbIjET/ygCpFYuMXUrguX0gXroquU/Ypni
         94zpp72lVza7dwDp6STSK/k6FdsijV7jz0F5RZycNSJNMaO3uETh5VFrZxoou6yPHBKB
         9OXeaekwnknH1RFSSvRP3rOgOWMXHUc3waeeJmh+P9G+aZ5egMUx9EGgS7yY1fyoxE8y
         A1X8kJtDWeiDEMcQzzIRca1EwUvSdmNzqAHJ4iYGmx9geBf8013DBTvsIZ2cm9SdrmDg
         FVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142289; x=1749747089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZ+Il9aAD6diUGB7Neeip4HTyqHqME5qHPELbp8CA60=;
        b=DoxoSgE1prW+VZdfazOLGFIuV7ji/IYlXbJuH3lLmjIP44cTM5/MBE2w1BMJpVoBSq
         Lku67aaYGMFXK+BBWsTNnGcjDYi69S11DqIQKAENlTVYGF7eVHGURyzX7P6MzGxu6gXt
         Nen8SWjSCw4eEM1QOJLL+IgZGFepFv3jB8sRAWt2ZZ6uif9Y3pJu7JaRm/DeMA8gTOTf
         su+SBTfhEUIzLkHWYIvf74ezs7UpykE/QFFzsHF5LZP0h7wW6+IpTwcvGabvbEueU8Ar
         d9EIVbtkYNhwXoGK6FN+G4krHY6wxJKnGS70QT7iG8sluue/+pKmgeHvvrAe8wH2BfOj
         xjeg==
X-Gm-Message-State: AOJu0YzcNmmkTu0L83zGmv85RowVfuPh1nTBFW/0JWsriWVEdNUWvMlX
	PZjr3q0eL2SpLEapVbmtZgjk4VQc5jCmfcnIIsSGK96ugZ1T9C/hrxJ9A8l5wA==
X-Gm-Gg: ASbGnctETDyVO2hYogCmSMrSLrjSpSiITp92af+pRUKkugxMGxu7otCdODuWX8AXvlg
	j0u8j7feEEi4EqWeNOd6f/sackYro4O9Zmyp0xAgfccgdwgU+M4cREirMcDrlhVKzvSXuFc6eks
	IVQmNILQ+vbuEJgH5m0vthWigV5zYH475l5LjzBdnv+eipiVOPJy/yZ/KVKogGsQhpD8vvti0WC
	uG6WVk28JEdCOGHrWOfh6S9SIcTO3Ealgo57aoZOEc5aMzgN43PhMXbnkXGVFODd6afdTrlMy+j
	YOh3pb7uYeaX+pl0iDYzWQDOrCraZgQHbsKuTB+d37VKauyKM4MxO2pv3Uvce3Kte1TRl0fcwwD
	8FM1R8J/RP4tnPLypoMXl7BqETCmlwuY8wIFJkXBpwSe43siapOLcriyF9iKnN2w0lwBZNnBnQQ
	XAZnlzk6c7lEfMvw==
X-Google-Smtp-Source: AGHT+IGxifLaGbq4zFfOCS7J57SkD6yD0IiDSEjgQbu6ghFswKJQkWYyqxXo5vvkrrZwELy6PKmSZw==
X-Received: by 2002:a05:6214:2a88:b0:6fa:a0ac:8d46 with SMTP id 6a1803df08f44-6fb08f69f85mr2484496d6.2.1749142289497;
        Thu, 05 Jun 2025 09:51:29 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0f8b61sm1287009185a.26.2025.06.05.09.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:51:29 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Paul Eggert <eggert@cs.ucla.edu>
Subject: [PATCH] fs/xattr.c: fix simple_xattr_list()
Date: Thu,  5 Jun 2025 12:51:16 -0400
Message-ID: <20250605165116.2063-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always
include security.* xattrs") failed to reset err after the call to
security_inode_listsecurity(), which returns the length of the
returned xattr name. This results in simple_xattr_list() incorrectly
returning this length even if a POSIX acl is also set on the inode.

Reported-by: Collin Funk <collin.funk1@gmail.com>
Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com/
Reported-by: Paul Eggert <eggert@cs.ucla.edu>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2369561
Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always include security.* xattrs")

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 fs/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 8ec5b0204bfd..600ae97969cf 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1479,6 +1479,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 		buffer += err;
 	}
 	remaining_size -= err;
+	err = 0;
 
 	read_lock(&xattrs->lock);
 	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
-- 
2.49.0


