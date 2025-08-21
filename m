Return-Path: <linux-fsdevel+bounces-58667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 344CEB306D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969E8625F86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC238FDE2;
	Thu, 21 Aug 2025 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="w48BCG8c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266E838F1DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807663; cv=none; b=sW/p+RjzmduTDJhFQNNTs06yMZyN5VpTHExuD/u1OLz914L4BmVPcCcoMeMDFXZfov/Wk8uDaJ7gOhr10j+F9Dv4GHy9A6hXOPaFzYcQiaD5sIEPW2hc5RKSF0uD+LsGra2UUoSsHoN3cC03xsMb7wB2JjpQamcBI3WSt7P/ZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807663; c=relaxed/simple;
	bh=IkafURwKBFSZguifSMeANEs1nfLj+d2hP631K3/rVjk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6dS62GO/oGX5cTeSAjUNBrAbQDKV1a1NX5yMtjjlk/2Xu2gbS6VGLWvdo3gKiN+Gn9akr4wfnBGGmpRyYFyxMbOH+UnKHSvA1FOMjwNLcoZVUpUs28jmkKqL9XfAo9qQ3z1AaYWCNcfH0bU4BmADTC5u5NttIptiA9bR9CDtWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=w48BCG8c; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d603b60cbso12944447b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807661; x=1756412461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FM4ZS/CCiHT1N83b4qCfaeSJikQ1oCz+lcijf4XNlE=;
        b=w48BCG8ccJgkma1AlOapUFCgp/21WNdaAASUnZYXvMybLQjatToJnP/1FPIRtitPM+
         5dn/K5SUYt/xVbtQ+6saR1qD0iw+EloCHTxkQh2j9cRlTOrNsjTsIcREkd+uWN7/Ql0N
         E3wqvLsQ9MTR4NuhfjdubroLi8Sm/WWKT4B6L6V0NwyTAikwXP0mVqmXB+z4HNYASN3Z
         o2fabiTx37jJOCQzZ3Ajqn9ocA/CR290z0ffEPURt2WZDl2IpkO/kiKdM4HhWdDPXx2p
         6OFNly/nhJA7MuaE27fSKUbvi/3PFY0RCQLKoClpG2Ku+OYkFGwhxLR70S6bIqpAgsQU
         gDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807661; x=1756412461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FM4ZS/CCiHT1N83b4qCfaeSJikQ1oCz+lcijf4XNlE=;
        b=nBBMJUErM5RqUF7UjlpHApdfw3s5SF8BNgGdikgL9IUZqQlQmQ9noIED/KZfpCNZtm
         Jmy5uIJTj1LKDL2NNJytOV5oxwwhxBWdLZ1F7Vz/36BiZevv8TSYNMIFsFyG/uHp+g/I
         Io+OEK3cUbCYBM2Aia5avOR5n2f6fjR+IooqgBp//kpsTmBgNez3l0sDVRc/M2FFX7aM
         fOm5G2a1mEIBBf7YyWZXP/KNShLfDE0A+rQkpl6/Z/5hDlRpnaSStABIYYpJ1zMszb0p
         LK2EGV0iAXD3JWfSkYKzIeaFkJdikgCq2Xux5VjFkkE7/6Mn/4cY5jZNY46MFvoDIjk/
         DtBA==
X-Gm-Message-State: AOJu0YyvpFNxAUr9qaMWzFYA4IyI7+Z0M+CBYc9ALG18+UuGMgU836wx
	Z9GD0KKl6B/F54cTYaMz6JNSbQwznnM1XubPEG9HeA4rBzn6JzJqBtN8U6zguAq/yFHt6fJnmxJ
	UHaJzU0WHfA==
X-Gm-Gg: ASbGncvTO/FqhxcT2ZuxFOu7IMeKklDxh2e05dzfIXYt/DXPQqWpuTZQMB8Z7ZMwwT6
	2y7y1fL7L94o/bLDM9I9zJ/h69RzZu2RsNTR642gffViqUAnji7i5C/sOGRrWechcfVZ1u/OGf2
	vqjE4k8hCke4iiNqlOSuHpt1yD3+ndzsiKe3zNeBjawhwh1VgbvczaXoaOK02VQAfAGqeqqINDl
	ogK7nEy8iiXHpvO4oR0qCh5yFmRViYjc6Y/kAVpdu+ujKBI0Rr4FJUdS2BupTCM/mwQzPscTkN2
	NvkE0kq+O7lee01KNQd9UzXkk4jxWtVUC6kAZRnrixeSTZNAk8LRAi+ASgPdIDJqhKh+HUSGlRE
	uOHAsKjX/dnJ1S6Q8+nFk27ph1qy8/5iPOxLr2d5pqkXV2bc1dlGuM77weDM=
X-Google-Smtp-Source: AGHT+IHXyW830DnvyKqzvZNJ3jCSg9ln5Zh9ENecXokTzlVqOL6TqrPnRD3Q10rxAbC3n1YAglqgtg==
X-Received: by 2002:a05:690c:30c:b0:71f:ab32:1e1 with SMTP id 00721157ae682-71fdc2b275cmr7719697b3.10.1755807660634;
        Thu, 21 Aug 2025 13:21:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f52c1dda5fsm59031d50.4.2025.08.21.13.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 30/50] bcachefs: use the refcount instead of I_WILL_FREE|I_FREEING
Date: Thu, 21 Aug 2025 16:18:41 -0400
Message-ID: <008961b8237f87429bcc1f8573d764dab2b1a22d.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can use the refcount to decide if the inode is alive instead of these
flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/bcachefs/fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 687af0eea0c2..de1c3c740a9d 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -347,7 +347,7 @@ static struct bch_inode_info *bch2_inode_hash_find(struct bch_fs *c, struct btre
 			spin_unlock(&inode->v.i_lock);
 			return NULL;
 		}
-		if ((inode->v.i_state & (I_FREEING|I_WILL_FREE))) {
+		if (!refcount_read(&inode->v.i_count)) {
 			if (!trans) {
 				__wait_on_freeing_inode(c, inode, inum);
 			} else {
@@ -2225,7 +2225,6 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
 			continue;
 
 		if (!(inode->v.i_state & I_DONTCACHE) &&
-		    !(inode->v.i_state & I_FREEING) &&
 		    igrab(&inode->v)) {
 			this_pass_clean = false;
 
-- 
2.49.0


